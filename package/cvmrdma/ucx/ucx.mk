################################################################################
#
# ibverbs-test-app
#
################################################################################

UCX_VERSION = 1.15.0
UCX_SITE = https://github.com/openucx/ucx/releases/download/v$(UCX_VERSION)
UCX_LICENSE = BSD
UCX_LICENSE_FILES = LICENSE
UCX_INSTALL_STAGING = YES
UCX_DEPENDENCIES = rdma-core-virtual

UCX_CONF_OPTS += \
	CFLAGS="$(TARGET_CFLAGS) -Wno-error" \
	--enable-optimizations \
	--disable-logging \
	--disable-debug \
	--disable-assertions \
	--disable-params-check \
	--disable-numa
# OPENSM_AUTORECONF = YES

# UCX_PRE_CONFIGURE_HOOKS += UCX_SET_CONFIGURE_HOOK

$(eval $(autotools-package))
