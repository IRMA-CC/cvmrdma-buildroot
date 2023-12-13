#!/usr/bin/env bash
set -xu

IFACE_FILE="${TARGET_DIR}/etc/network/interfaces"
PROFILE_FILE="${TARGET_DIR}/etc/profile.d/rdma_rpc.sh"

STATIC_HOSTNAME="$(hostnamectl --static)"

if [[ "$STATIC_HOSTNAME" == "meli-X12DAi-N6" ]]; then
    echo "Setting IP prefix to 192.4.0.0/24..."
    perl -pi -e "s/192\.3/192\.4/" "$IFACE_FILE"
    echo "Setting remote address to 203.0.113.1:3456"
    perl -pi -e "s/192\.33\.93\.245/192\.33\.93\.235/" "$PROFILE_FILE"
fi


# Create startup.nsh for disk image
cat <<EOF > "${BINARIES_DIR}/startup.nsh"
bzImage.efi earlycon root=/dev/vda2 console=ttyS0 nokaslr
EOF


exit 0