#
# $ Copyright Cypress Semiconductor $
#

NAME := App_WICED_tiny_Bootloader_$(PLATFORM)

$(NAME)_SOURCES    := tiny_bootloader.c

$(NAME)_LINK_FILES += tiny_bootloader.o

NoOS_START_STACK   := 4000

APP_WWD_ONLY       := 1
NO_WIFI            := 1
NO_WIFI_FIRMWARE   := YES

GLOBAL_DEFINES     := WICED_NO_WIFI \
                      NO_WIFI_FIRMWARE \
                      WICED_DISABLE_STDIO \
                      WICED_DISABLE_MCU_POWERSAVE \
                      WICED_DCACHE_WTHROUGH \
                      WICED_NO_VECTORS \
                      TINY_BOOTLOADER \
                      PLATFORM_NO_SFLASH_WRITE=1
GLOBAL_INCLUDES    += .
GLOBAL_INCLUDES    += ../../waf/bootloader $(GENERATED_MAC_FILE)
GLOBAL_INCLUDES    += ../../../libraries/utilities/linked_list

VALID_OSNS_COMBOS  := NoOS-NoNS
VALID_BUILD_TYPES  := release

VALID_PLATFORMS    := BCM943909* BCM943907* BCM943903* CYW943907* Quicksilver* CYW954907*
