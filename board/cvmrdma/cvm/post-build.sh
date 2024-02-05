#!/usr/bin/env bash
set -xu

IFACE_FILE="${TARGET_DIR}/etc/network/interfaces"
PROFILE_FILE="${TARGET_DIR}/etc/profile.d/rdma_rpc.sh"

STATIC_HOSTNAME="$(hostnamectl --static)"

# Create startup.nsh for disk image
cat <<EOF > "${BINARIES_DIR}/startup.nsh"
bzImage.efi earlycon root=/dev/vda2 console=ttyS0 swiotlb=262144
EOF


exit 0