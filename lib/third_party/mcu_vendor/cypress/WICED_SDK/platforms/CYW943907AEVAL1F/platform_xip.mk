#
# $ Copyright Cypress Semiconductor $
#

#If OTA2 is enabled, use OTA2_IMAGE_APP0_XIP_AREA_BASE from ota2_image_defines.mk
ifeq (1,$(OTA2_SUPPORT))
include platforms/$(PLATFORM)/ota2_image_defines.mk

ifeq (,$(OTA2_IMAGE_APP0_XIP_AREA_BASE))
$(error OTA2_IMAGE_APP0_XIP_AREA_BASE is not defined!)
endif # ifeq (,$(OTA2_IMAGE_APP0_XIP_AREA_BASE))

XIP_LOAD_ADDRESS             := $(OTA2_IMAGE_APP0_XIP_AREA_BASE)
else
XIP_LOAD_ADDRESS             := 0x400000
endif #ifeq (1,$(OTA2_SUPPORT))

SFLASH_BASE_ADDRESS			 := 0x14000000
#Link start address = 0x14000000 + $(XIP_LOAD_ADDRESS)
XIP_LINK_START_ADDRESS       = $(shell $(PERL) -le 'print sprintf("0x%X", $(SFLASH_BASE_ADDRESS) + $(XIP_LOAD_ADDRESS))')
#The region length used in generated app_without_rom_xip.ld:  2M
XIP_REGION_LENGTH			 := 0x200000
