#!/usr/bin/env bash
set -xu

# Create startup.nsh for disk image
# swiotlb=1048576 -> 2GiB
cat <<EOF > "${BINARIES_DIR}/startup.nsh"
bzImage.efi earlycon cma=24G root=/dev/vda2 console=ttyS0 swiotlb=1048576 amd_iommu=on iommu=pt
EOF


exit 0