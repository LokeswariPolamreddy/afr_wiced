#
# $ Copyright Cypress Semiconductor $
#

NAME := SPI_Flash_43909_Library_$(PLATFORM)

$(NAME)_SOURCES := spi_flash.c spi_flash_compatible.c

# Add one or more of the following defines to your platform makefile :
#                   SFLASH_SUPPORT_MACRONIX_PARTS
#                   SFLASH_SUPPORT_SST_PARTS
#                   SFLASH_SUPPORT_EON_PARTS

# Leveling debug message as below :
# - WPRINT_ENABLE_SFLASH_INFO
#   Showing message when driver init/deinit/action normally.
# - WPRINT_ENABLE_SFLASH_ERROR
#   Showing message when driver init/deinit/action in abnormal.
# - WPRINT_ENABLE_SFLASH_DEBUG:
#   Showing detail debug message when driver access(tx/rx) sflash.
$(NAME)_DEFINES += WPRINT_ENABLE_SFLASH_INFO
#$(NAME)_DEFINES += WPRINT_ENABLE_SFLASH_ERROR
#$(NAME)_DEFINES += WPRINT_ENABLE_SFLASH_DEBUG

# [Generic SPI]
# For 4390x platform, there's 2 extra generic SPI interfaces.
# We can support them by enable below define :
ENABLE_SPI_0 := 0
ENABLE_SPI_1 := 0
ifneq ($(ENABLE_SPI_0),0)
GLOBAL_DEFINES += ENABLE_SPI_0=$(ENABLE_SPI_0)
endif
ifneq ($(ENABLE_SPI_1),0)
GLOBAL_DEFINES += ENABLE_SPI_1=$(ENABLE_SPI_1)
endif

# [FRAM]
# Because FRAM doesn't has ID (just like sflsah ID) to identify that
# what FRAM we were used currently.
# We have defined FRAM ID in driver, user must declare FRAM here specifically,
# or driver will treat device as Sflash.
# PS : for FRAM ID, please refer BCM4390x/peripherals/spi_flash.h
FRAM_SPI_0 := 0x021901
FRAM_SPI_1 := 0
ifneq ($(ENABLE_SPI_0),0)
ifneq ($(FRAM_SPI_0),0)
GLOBAL_DEFINES += FRAM_SPI_0=$(FRAM_SPI_0)
endif
endif
ifneq ($(ENABLE_SPI_1),0)
ifneq ($(FRAM_SPI_1),0)
GLOBAL_DEFINES += FRAM_SPI_1=$(FRAM_SPI_1)
endif
endif

GLOBAL_INCLUDES := .

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

$(eval $(call PLATFORM_LOCAL_DEFINES_INCLUDES_43909, ../..))
