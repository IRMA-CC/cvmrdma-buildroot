################################################################################
#
# mstflint
#
################################################################################

MSTFLINT_VERSION = cc30ec4f40d6499db9697ba755754fb77ec5b946
MSTFLINT_SITE = https://github.com/Mellanox/mstflint.git
MSTFLINT_SITE_METHOD = git

define MSTFLINT_BUILD_CMDS
	export BR_COMPILER_PARANOID_UNSAFE_PATH="" && \
	export BR2_COMPILER_PARANOID_UNSAFE_PATH="" && \
	cd $(@D) &&  \
	PATH=$(BR_PATH) ./autogen.sh && \
	mkdir -p build && \
	cd build && \
	PATH=$(BR_PATH) ../configure --disable-inband --disable-dc --disable-openssl && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -j CC="$(TARGET_CC)" LD="$(TARGET_LD)" && \
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) install DESTDIR=$(TARGET_DIR)
endef

define MSTFLINT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) install DESTDIR=$(TARGET_DIR)
	$(INSTALL) -D -m 0755 $(@D)/src/qperf $(TARGET_DIR)/usr/bin/qperf
endef


$(eval $(generic-package))
