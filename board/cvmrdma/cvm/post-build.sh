#!/usr/bin/env bash
set -xu

# Create startup.nsh for disk image
cat <<EOF > "${BINARIES_DIR}/startup.nsh"
bzImage.efi earlycon root=/dev/vda2 console=ttyS0 swiotlb=262144
EOF


exit 0