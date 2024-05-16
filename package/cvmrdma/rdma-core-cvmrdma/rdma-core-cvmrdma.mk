################################################################################
#
# rdma-core-cvmrdma
#
################################################################################

RDMA_CORE_CVMRDMA_VERSION = a7f4aea75c92f1dee2c1ceffa371700728b1744c
RDMA_CORE_CVMRDMA_SITE = https://github.com/IRMA-CC/cvmrdma-rdma-core.git
RDMA_CORE_CVMRDMA_LICENSE = GPL-2.0 or BSD-2-Clause
RDMA_CORE_CVMRDMA_LICENSE_FILES = COPYING.GPL2 COPYING.BSD_MIT COPYING.md
RDMA_CORE_CVMRDMA_DEPENDENCIES = libnl libsodium aegis
RDMA_CORE_CVMRDMA_INSTALL_STAGING = YES
RDMA_CORE_CVMRDMA_PROVIDES = rdma-core-virtual

RDMA_CORE_CVMRDMA_CONF_OPTS = \
	-DNO_MAN_PAGES=1 \
	-DNO_PYVERBS=1 \
	-DIOCTL_MODE=ioctl

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
RDMA_CORE_CVMRDMA_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS=-latomic \
	-DCMAKE_SHARED_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))
