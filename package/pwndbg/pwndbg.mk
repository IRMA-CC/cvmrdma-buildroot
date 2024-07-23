################################################################################
#
# pwndbg
#
################################################################################

PWNDBG_VERSION = 2024.02.14
PWNDBG_SITE = $(call github,pwndbg,pwndbg,$(PWNDBG_VERSION))
PWNDBG_LICENSE = MIT
PWNDBG_LICENSE_FILES = LICENSE
PWNDBG_INSTALL_STAGING = YES


define PWNDBG_BUILD_CMDS
	wget https://github.com/pwndbg/pwndbg/releases/download/2024.02.14/pwndbg_2024.02.14_amd64-portable.tar.gz --directory-prefix=$(@D)
	mkdir -p $(@D)/unpacked
	tar -xvf $(@D)/pwndbg_2024.02.14_amd64-portable.tar.gz  -C $(@D)/unpacked
	rm $(@D)/pwndbg_2024.02.14_amd64-portable.tar.gz*
endef

define PWNDBG_INSTALL_TARGET_CMDS
	cp -r $(@D)/unpacked/pwndbg $(TARGET_DIR)/usr/bin
	rm -rf $(@D)/unpacked/pwndbg
endef

$(eval $(generic-package))
