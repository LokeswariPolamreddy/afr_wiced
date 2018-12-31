#
# $ Copyright Cypress Semiconductor $
#
#
# Constant sector size FLASH
#

SECTOR_SIZE 						 := 4096

#
#  Sample Layout for 8MB FLASH
#
#   Sizes are on sector boundaries for this platform
#
#   +---------------------------------------+
#   | Boot Loader Area						| 32k  ---< build/waf.bootloader-<platform>/binary/waf.bootloader-<platform>.trx.bin
#   +---------------------------------------+
#   | DCT 1                 				| 16k  ---< build/<your_application>-<platform>/DCT.bin
#   +---------------------------------------+
#   | DCT 2                 				| 16k  ---< For the backup of one single DCT area
#   +---------------------------------------+
#   | Application Lookup Table (LUT)		|  4k  ---< build/<your_application>-<platform>/APPS.bin
#   +---------------------------------------+
#   | APPS - Filesystem	                    |  ??  ---< build/<your_application>-<platform>/filesystem.bin
#   +--                                   --+
#   | APPS - ??? (if existed)	            |
#   +--                                   --+
#   | APPS - ??? (if existed)	            |
#   +--                                   --+
#   | APPS - APP0	                        |  ??  ---< build/<your_application>-<platform>/binary/<your_application>-<platform>.stripped.elf
#   +--                                   --+
#   | APPS - APP1 (if existed)	            |
#   +--                                   --+
#   | APPS - APP2 (if existed)	            |
#   +--                                   --+
#   | 	                      				|
#   +---------------------------------------+
#
#--------------------------------------------------------------------------------------
# Normal Image FLASH Area                  Location     Size
#--------------------------------------------------------------------------------------
NORMAL_IMAGE_FLASH_BASE                 := 0x00000000

# Boot Loader
NORMAL_IMAGE_BOOTLOADER_START           := 0x00000000	#  32k  (0x00008000)

# DCT1
NORMAL_IMAGE_DCT_1_AREA_BASE            := 0x00008000	#  16k  (0x00004000)

# DCT2
NORMAL_IMAGE_DCT_2_AREA_BASE            := 0x0000C000	#  16k  (0x00004000)

# LUT
NORMAL_IMAGE_LUT_AREA_BASE              := 0x00010000	#   4k  (0x00001000)

# APPS
# For normal image, APPS including: FR_APP DCT_IMAGE OTA_APP FILESYSTEM_IMAGE WIFI_FIRMWARE APP0 APP1 APP2
# Given the start sector number, all APPS image will be arranged automatically in "wiced_apps.mk"
# See "BUILD_APPS_RULES" for more detail
NORMAL_IMAGE_APPS_AREA_BASE             := 0x00011000

# Filesystem
# Should be an obsolete define
NORMAL_IMAGE_FS_AREA_BASE               := $(NORMAL_IMAGE_APPS_AREA_BASE)



