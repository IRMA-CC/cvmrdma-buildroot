################################################################################
#
# cvmrdma-bench
#
################################################################################

CVMRDMA_BENCH_SITE = /home/fheinen/leo-cvmrdma-src/cvmrdma-bench
CVMRDMA_BENCH_SITE_METHOD = local

CVMRDMA_BENCH_DEPENDENCIES = libsodium aegis

define CVMRDMA_BENCH_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
        CC="$(TARGET_CC)" \
        CFLAGS="$(TARGET_CFLAGS)" \
        CPPFLAGS="$(TARGET_CPPFLAGS)" \
        LDFLAGS="$(TARGET_LDFLAGS)" \
        STAGING_DIR="$(STAGING_DIR)" \
        USE_PKG_CONFIG=0 \
        all
endef

define CVMRDMA_BENCH_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/enc $(TARGET_DIR)/usr/bin/enc
    $(INSTALL) -D -m 0755 $(@D)/clock_test $(TARGET_DIR)/usr/bin/clock_test
    $(INSTALL) -D -m 0755 $(@D)/write_prot $(TARGET_DIR)/usr/bin/write_prot
endef

$(eval $(generic-package))