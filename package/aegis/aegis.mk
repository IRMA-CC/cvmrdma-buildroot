################################################################################
#
# aegis
#
################################################################################

AEGIS_VERSION = 0.1.22
AEGIS_SITE = $(call github,jedisct1,libaegis,$(AEGIS_VERSION))
AEGIS_LICENSE = MIT
AEGIS_LICENSE_FILES = LICENSE
AEGIS_INSTALL_STAGING = YES

$(eval $(cmake-package))
