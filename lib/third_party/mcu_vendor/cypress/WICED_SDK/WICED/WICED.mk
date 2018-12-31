#
# $ Copyright Cypress Semiconductor $
#

NAME = WICED

$(NAME)_SOURCES := internal/wiced_core.c

ifndef USES_BOOTLOADER_OTA
USES_BOOTLOADER_OTA :=1
endif

ifeq ($(BUILD_TYPE),debug)
#Note: WICED_ENABLE_MALLOC_DEBUG must be enabled when including test/malloc_debug
#GLOBAL_DEFINES += WICED_ENABLE_MALLOC_DEBUG
#$(NAME)_COMPONENTS += test/malloc_debug
endif

# Check if WICED level API is required
ifndef NO_WICED_API
$(NAME)_SOURCES += internal/time.c \
                   internal/system_monitor.c \
                   internal/wiced_lib.c \
                   internal/wiced_crypto.c \
                   internal/waf.c

# Check if Wi-Fi is not required
ifndef NO_WIFI
$(NAME)_SOURCES += internal/wifi.c \
                   internal/wiced_wifi_deep_sleep.c \
                   internal/wiced_easy_setup.c \
                   internal/wiced_filesystem.c

ifndef WICED_AMAZON_FREERTOS_SDK
$(NAME)_SOURCES += internal/wiced_cooee.c
endif

$(NAME)_INCLUDES += security/BESL/crypto_internal \
                    security/BESL/include \
                    security/BESL/host/WICED \
                    security/BESL/WPS \
                    security/PostgreSQL \
                    security/PostgreSQL/include \
                    security/BESL/mbedtls_open/include

$(NAME)_COMPONENTS += WICED/WWD \
                      utilities/wifi

ifndef WICED_AMAZON_FREERTOS_SDK
$(NAME)_COMPONENTS += WICED/security/BESL \
                      WICED/security/PostgreSQL
endif

ifndef NETWORK
NETWORK := NetX_Duo
$(NAME)_COMPONENTS += NetX_Duo
endif

else #ifndef NO_WIFI
GLOBAL_INCLUDES += WWD/include \
                   security/BESL/include \
                   security/BESL/host/WICED \
                   security/BESL/crypto_internal \
                   security/PostgreSQL \
                   security/PostgreSQL/include \
                   security/BESL/mbedtls_open/include

endif #ifndef NO_WIFI

else # ifndef NO_WICED_API
ifneq ($(NETWORK),)
$(NAME)_COMPONENTS += WICED/WWD
else # NETWORK
GLOBAL_INCLUDES += WWD/include
endif # NETWORK
GLOBAL_INCLUDES += security/BESL/include \
                   security/BESL/host/WICED \
                   security/BESL/crypto_internal \
                   security/PostgreSQL/include \
                   security/BESL/mbedtls_open/include
GLOBAL_DEFINES += NO_WICED_API
endif # ifndef NO_WICED_API

ifdef WICED_POWER_LOGGER
$(NAME)_COMPONENTS += WICED/WPL
GLOBAL_INCLUDES += WICED/WPL/include
GLOBAL_DEFINES += WICED_POWER_LOGGER_ENABLE
$(NAME)_COMPONENTS += utilities/command_console/wpl
endif

$(NAME)_CHECK_HEADERS := internal/wiced_internal_api.h \
                         ../include/default_wifi_config_dct.h \
                         ../include/resource.h \
                         ../include/wiced.h \
                         ../include/wiced_defaults.h \
                         ../include/wiced_easy_setup.h \
                         ../include/wiced_framework.h \
                         ../include/wiced_management.h \
                         ../include/wiced_platform.h \
                         ../include/wiced_rtos.h \
                         ../include/wiced_tcpip.h \
                         ../include/wiced_time.h \
                         ../include/wiced_utilities.h \
                         ../include/wiced_crypto.h \
                         ../include/wiced_wifi.h \
                         ../include/wiced_wifi_deep_sleep.h

# Add WICEDFS as default if filesystem is not specified
ifdef PLATFORM_FILESYSTEM_FILEX
GLOBAL_DEFINES += USING_FILEX
$(NAME)_COMPONENTS += filesystems/FileX
else
GLOBAL_DEFINES += USING_WICEDFS
$(NAME)_COMPONENTS += filesystems/wicedfs
endif

# Add MCU component
$(NAME)_COMPONENTS += WICED/platform/MCU/$(HOST_MCU_FAMILY)

# Define the default ThreadX and FreeRTOS starting stack sizes
FreeRTOS_START_STACK := 800
ThreadX_START_STACK  := 800
NuttX_START_STACK    := 4000

GLOBAL_DEFINES += WWD_STARTUP_DELAY=10 \
                  BOOTLOADER_MAGIC_NUMBER=0x4d435242

GLOBAL_INCLUDES += . \
                   platform/include \
                   ../libraries/test/wl_tool/$(WLAN_CHIP)$(WLAN_CHIP_REVISION)/include \
                   ../libraries/utilities/wifi

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

$(NAME)_SOURCES += internal/wiced_low_power.c

$(NAME)_UNIT_TEST_SOURCES := internal/unit/wiced_unit.cpp

ifdef WICED_ENABLE_FUNCTION_MOCKING
MOCKED_FUNCTIONS += malloc malloc_named
endif
