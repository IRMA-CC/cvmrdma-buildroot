################################################################################
#
# rdma-core-cvmrdma
#
################################################################################

RDMA_CORE_CVMRDMA_SRC_VERSION = a7f4aea75c92f1dee2c1ceffa371700728b1744c
RDMA_CORE_CVMRDMA_SRC_SITE = https://github.com/IRMA-CC/cvmrdma-rdma-core.git
RDMA_CORE_CVMRDMA_SRC_LICENSE = GPL-2.0 or BSD-2-Clause
RDMA_CORE_CVMRDMA_SRC_INSTALL_STAGING = YES

define RDMA_CORE_CVMRDMA_SRC_BUILD_CMDS
endef

define RDMA_CORE_CVMRDMA_SRC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/root/src/cvmrdma
	cp -r $(@D)/* $(TARGET_DIR)/root/src/cvmrdma
endef

$(eval $(generic-package))