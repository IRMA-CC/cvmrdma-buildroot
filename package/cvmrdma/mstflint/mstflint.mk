################################################################################
#
# mstflint
#
################################################################################

MSTFLINT_VERSION = cc30ec4f40d6499db9697ba755754fb77ec5b946
MSTFLINT_SITE = https://github.com/Mellanox/mstflint.git
MSTFLINT_SITE_METHOD = git

define MSTFLINT_AUTOGEN_HOOK
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef


MSTFLINT_CONF_OPTS = --disable-dc --disable-openssl
MSTFLINT_AUTORECONF = YES


$(eval $(autotools-package))
