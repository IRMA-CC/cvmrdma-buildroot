################################################################################
#
# ibverbs-test-app
#
################################################################################


define OPENSM_AUTOGEN_HOOK
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef


OPENSM_VERSION = 3.3.24
OPENSM_SITE = https://github.com/linux-rdma/opensm/releases/download/$(OPENSM_VERSION)
OPENSM_LICENSE = BSD
OPENSM_LICENSE_FILES = COPYING
OPENSM_DEPENDENCIES = rdma-core-virtual

OPENSM_CONF_OPTS = --oldincludedir=$(STAGING_DIR)/usr/include --with-osmv=openib
OPENSM_AUTORECONF = YES

# OPENSM_PRE_CONFIGURE_HOOKS += OPENSM_AUTOGEN_HOOK

$(eval $(autotools-package))
