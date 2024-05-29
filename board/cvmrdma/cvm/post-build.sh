#!/usr/bin/env bash
set -xu

# Create startup.nsh for disk image
# swiotlb=1048576 -> 4GiB
# cma=8G ?
cat <<EOF > "${BINARIES_DIR}/startup.nsh"
bzImage.efi earlycon cma=2G root=/dev/vda2 console=ttyS0 swiotlb=4194304
EOF


exit 0