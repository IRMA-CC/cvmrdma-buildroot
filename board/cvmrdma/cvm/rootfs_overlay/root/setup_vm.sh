#!/bin/bash

PRIVFILE="privkeys.txt"
PUBFILE="pubkeys.txt"

get_key() {
    # vm's start with 3, so we subtract 2 to get the correct line number
    local line_num=$(($1 - 2))
    local key_type=$2
    
    # Validate line number
    if ! [[ "$line_num" =~ ^[0-9]+$ ]] || [ "$line_num" -lt 1 ]; then
        echo "Error: Line number must be a positive integer." >&2
        return 1
    fi
    
    # Determine which file to use based on second parameter
    local keyfile
    if [ "$key_type" = "priv" ] || [ "$key_type" = "private" ]; then
        keyfile="$PRIVFILE"
    elif [ "$key_type" = "pub" ] || [ "$key_type" = "public" ]; then
        keyfile="$PUBFILE"
    else
        echo "Error: Key type must be 'priv' or 'pub'" >&2
        return 1
    fi

    # Extract key from file by line number
    local key=$(sed -n "${line_num}p" "$keyfile")

    if [ -z "$key" ]; then
        echo "Error: No key found at line $line_num in $keyfile" >&2
        return 1
    fi
    
    # Return the key via echo
    echo "$key"
    return 0
}

if [ $# -ne 1 ]; then
  echo "Usage: $0 <vm_id>"
  exit 1
fi

vm_id=$1

# Create list of all VM IDs (3 to 6) and remove current vm_id
all_vms=(3 4 5 6 7 8 9 10 11)
peer_vms=()
for vm in "${all_vms[@]}"; do
    if [ "$vm" != "$vm_id" ]; then
        peer_vms+=("$vm")
    fi
done


mkdir -p /mnt/host
mount -t 9p -o trans=virtio,version=9p2000.L p9share /mnt/host/ 


ip link set up dev eth0
ip addr add 10.0.2.15/24 dev eth0
ip route add default via 10.0.2.2 
echo "nameserver 10.0.2.3" > /etc/resolv.conf

modprobe ixgbe
# we need to use a specific driver for VFs
modprobe ixgbevf
ip addr add 192.10.0.${vm_id}/24 dev eth1
ip link set up eth1
# 9710
ip link set dev eth1 mtu 9710

modprobe ib_ipoib
ip addr add 10.1.1.${vm_id}/24 dev ib0
ip link set up ib0
echo connected > /sys/class/net/ib0/mode
echo 65520 > /sys/class/net/ib0/mtu

# Get the private key from file based on VM ID
MY_PRIVKEY=$(get_key "$vm_id" "priv")
echo $MY_PRIVKEY > $HOME/privkey.key

echo "PUBKEY:"
wg pubkey < $HOME/privkey.key

# Setup WireGuard interface wg0
ip link add dev wg0 type wireguard
ip link set dev wg0 mtu 8920
ip addr add 10.0.0.${vm_id}/24 dev wg0
ip link set up dev wg0
wg set wg0 private-key $HOME/privkey.key listen-port 51820

# Add peers to wg0
for peer_vm in "${peer_vms[@]}"; do
    peer_pubkey=$(get_key "$peer_vm" "pub")
    if [ $? -eq 0 ]; then
        wg set wg0 peer "$peer_pubkey" \
            allowed-ips 10.0.0.${peer_vm}/32 \
            endpoint 192.10.0.${peer_vm}:51820
    fi
done

# Setup WireGuard interface wg1
ip link add dev wg1 type wireguard
ip addr add 10.0.3.${vm_id}/24 dev wg1
ip link set dev wg1 up
wg set wg1 private-key $HOME/privkey.key listen-port 51821

# Add peers to wg1
for peer_vm in "${peer_vms[@]}"; do
    peer_pubkey=$(get_key "$peer_vm" "pub")
    if [ $? -eq 0 ]; then
        wg set wg1 peer "$peer_pubkey" \
            allowed-ips 10.0.3.${peer_vm}/32 \
            endpoint 10.1.1.${peer_vm}:51821
    fi
done

export CVMRDMA_BIND_ADDR="*:3456"
export CVMRDMA_AEAD="aegis128x4"
export CVMRDMA_SHARED_KEY="2dcfa4058886bc0d5f9bfaded6c4b9767da3841ca83ee46f16a616aa5cd9494d"

#opensm &