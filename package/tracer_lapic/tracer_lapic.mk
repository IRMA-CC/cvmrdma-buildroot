################################################################################
#
# TRACER_LAPIC Buildroot package
#
################################################################################

TRACER_LAPIC_SITE = $(TOPDIR)/package/tracer_lapic
TRACER_LAPIC_SITE_METHOD = local
TRACER_LAPIC_DEPENDENCIES = linux

# Build against the kernel tree Buildroot built (LINUX_DIR), with this dir as module (M=$(@D))
define TRACER_LAPIC_BUILD_CMDS
    $(MAKE) -C $(LINUX_DIR) M=$(@D) modules
endef

define TRACER_LAPIC_INSTALL_TARGET_CMDS
    $(MAKE) -C $(LINUX_DIR) M=$(@D) INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
endef

$(eval $(kernel-module))
$(eval $(generic-package))
