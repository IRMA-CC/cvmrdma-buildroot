#!/usr/bin/env bash
set -xu

# Create startup.nsh for disk image
# swiotlb=1048576 -> 4GiB
# cma=8G ?
cat <<EOF > "${BINARIES_DIR}/startup.nsh"
bzImage.efi earlycon cma=4G root=/dev/vda2 console=ttyS0 swiotlb=1048576
EOF


exit 0