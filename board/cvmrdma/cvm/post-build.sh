#!/usr/bin/env bash
set -xu

# Create startup.nsh for disk image
# swiotlb=1048576 -> 4GiB
# cma=8G ?
cat <<EOF > "${BINARIES_DIR}/startup.nsh"
bzImage.efi earlycon cma=8G root=/dev/vda2 console=ttyS0 swiotlb=2097152
EOF


exit 0