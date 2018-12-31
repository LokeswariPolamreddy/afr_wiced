#
# $ Copyright Cypress Semiconductor $
#

NAME := App_SFlash_write

$(NAME)_SOURCES  := sflash_write.c

ifeq ($(TOOLCHAIN_NAME),IAR)
NoOS_START_STACK := 10000
else
NoOS_START_STACK := 5024
endif

$(NAME)_INCLUDES += ../common/spi_flash .
GLOBAL_INCLUDES  += ../../../libraries/utilities/linked_list

# This uses cflags instead of the normal includes to avoid being
# relative to the directory of this module
#$(NAME)_CFLAGS += -I$(SPI_FLASH_IMAGE_DIR)

#$(NAME)_DEFINES += FACTORY_RESET_AFTER_SFLASH

# blocking printf so breakpoint calls still print information
#GLOBAL_DEFINES += PRINTF_BLOCKING

#NoOS_START_STACK := 6000

#GLOBAL_LINK_SCRIPT := mfg_spi_flash_link.ld

NO_WIFI_FIRMWARE := YES
NO_WIFI          := YES

APP_WWD_ONLY   := 1
GLOBAL_DEFINES := WICED_NO_WIFI
GLOBAL_DEFINES += NO_WIFI_FIRMWARE
GLOBAL_DEFINES += WICED_DISABLE_MCU_POWERSAVE
NODCT          := 1
NO_WICED_API   := 1

ifeq ($(WIPE),1)
GLOBAL_DEFINES += WIPE_SFLASH
endif

VALID_OSNS_COMBOS := NoOS
INVALID_PLATFORMS := CYW9MCU7X9N364
WICED_AMAZON_FREERTOS_SDK := 1
GLOBAL_DEFINES += WICED_AMAZON_FREERTOS_SDK