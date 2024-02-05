# Buildroot for CVMRDMA

## CVMRDMA-specific additions

A new config:

- `configs/cvmrdma_sev_defconfig`
  + with modified SEV-SNP Linux kernel, with Kconfig:
    * RDMA enabled (userspace access)
    * Mellanox IB kernel modules
    * DMA-BUF system heap enabled (to allocate in unprotected memory)
  + with CVMRDMA

Config-specific files in `board/cvmrdma/cvm`:

- some configurations and scripts as a rootfs overlay
- post-build/image scripts:
  + to generate startup.nsh and generate a qcow2 disk image


Additional packages in `package/cvmrdma`:

- 3 existing packages: opensm, rdma-core, ucx
- 2 of our packages: rdma-core-cvmrdma


## Building

Advice: just use the deploy.py script in cvmrdma-deploy!

Manually:

```
# This assumes that a toolchain is already available at
# ${HOME}/cvmrdma-install/toolchain-x86-64-v3
# deploy.py can do this for you!

# Prepare the Buildroot environment
# Debug options are disabled by default
make O=$HOME/cvmrdma-install/br-sev-Release cvmrdma_sev_defconfig

# (optional) Change configuration options, e.g. enable
# debug symbols/assertions
cd $HOME/cvmrdma-install/br-sev-Release
make menuconfig

# Build the outputs
make
```

Else, after using deploy.py, you can directly go to `$HOME/cvmrdma-install/br-sev-Release` (or `br-sev-Debug`)
configure with `make menuconfig` and rebuild specific packages:

```
# rebuild packages
make linux-rebuild rdma-core-cvmrdma-rebuild

# update the disk image
make
```

## Outputs

This builds:

1. `bzImage`: the kernel (our fork)
2. `MEMFD.fd`, `OVMF_CODE.fd`,  `OVMF.fd`, `OVMF_VARS.fd`: OVMF firmware (from AMD's SEV-SNP fork)
3. rootfs.ext2: a rootfs, including CVMRDMA
4. qemu-host (from AMD's SEV-SNP fork)

1-3 get packaged together in a single disk image (`disk.qcow2`).
