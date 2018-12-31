#
# $ Copyright Cypress Semiconductor $
#

PLATFORM_NO_DDR := 1

ifneq ($(wildcard $(SOURCE_ROOT)WICED/platform/MCU/BCM4390x/$(HOST_MCU_VARIANT)/$(APPS_CHIP_REVISION)/$(HOST_MCU_VARIANT)$(APPS_CHIP_REVISION).mk),)
include $(SOURCE_ROOT)WICED/platform/MCU/BCM4390x/$(HOST_MCU_VARIANT)/$(APPS_CHIP_REVISION)/$(HOST_MCU_VARIANT)$(APPS_CHIP_REVISION).mk
endif # wildcard $(WICED ...)