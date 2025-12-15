################################################################################
#
# cvmrdma-manager
#
################################################################################

CVMRDMA_MANAGER_SITE = /home/fheinen/leo-cvmrdma-src/cvmrdma-manager
CVMRDMA_MANAGER_SITE_METHOD = local

define CVMRDMA_MANAGER_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
        CC="$(TARGET_CC)" \
        CFLAGS="$(TARGET_CFLAGS)" \
        CPPFLAGS="$(TARGET_CPPFLAGS)" \
        LDFLAGS="$(TARGET_LDFLAGS)" \
        STAGING_DIR="$(STAGING_DIR)" \
        USE_PKG_CONFIG=0 \
        all
endef

define CVMRDMA_MANAGER_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/cvmrdma_manager $(TARGET_DIR)/usr/bin/cvmrdma_manager
endef

$(eval $(generic-package))