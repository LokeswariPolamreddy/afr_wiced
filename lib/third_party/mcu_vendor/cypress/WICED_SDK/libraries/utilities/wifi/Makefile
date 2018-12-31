#
# $ Copyright Cypress Semiconductor $
#
SOURCE_ROOT :=../../../

ifneq ($(MAKECMDGOALS),wipe_source_for_test)
ifeq ($(RTOS),)
$(error Must define RTOS)
endif
ifeq ($(NETWORK),)
$(error Must define NETWORK)
endif
endif

NAME :=wifi_utils

# General WICED includes
CFLAGS += -I$(SOURCE_ROOT)include
CFLAGS += -I$(SOURCE_ROOT)tools/ARM_GNU/include
CFLAGS += -I$(SOURCE_ROOT)WICED
CFLAGS += -I$(SOURCE_ROOT)WICED/WWD/include
CFLAGS += -I$(SOURCE_ROOT)WICED/WWD
CFLAGS += -I$(SOURCE_ROOT)WICED/platform/include
CFLAGS += -I$(SOURCE_ROOT)WICED/platform/MCU
CFLAGS += -I$(SOURCE_ROOT)WICED/platform/MCU/BCM4390x/peripherals/include
CFLAGS += -I$(SOURCE_ROOT)WICED/network/$(NETWORK)/WWD
CFLAGS += -I$(SOURCE_ROOT)WICED/WWD/internal/chips/4390x
CFLAGS += -I$(SOURCE_ROOT)WICED/RTOS/$(RTOS)/WICED
CFLAGS += -I$(SOURCE_ROOT)WICED/RTOS/$(RTOS)/WWD
CFLAGS += -I$(SOURCE_ROOT)WICED/WWD/internal/bus_protocols/SDIO
CFLAGS += -I$(SOURCE_ROOT)WICED/WWD/include/network
CFLAGS += -I$(SOURCE_ROOT)WICED/network/$(NETWORK)/WICED
CFLAGS += -I$(SOURCE_ROOT)WICED/security/BESL/crypto
CFLAGS += -I$(SOURCE_ROOT)WICED/security/BESL/crypto_open
CFLAGS += -I$(SOURCE_ROOT)libraries/utilities/base64
CFLAGS += -I$(SOURCE_ROOT)libraries/utilities/TLV
CFLAGS += -I$(SOURCE_ROOT)WICED/security/BESL/include
CFLAGS += -I$(SOURCE_ROOT)libraries/utilities/ring_buffer
CFLAGS += -I$(SOURCE_ROOT)libraries/utilities/linked_list
CFLAGS += -I$(SOURCE_ROOT)libraries/filesystems/wicedfs
CFLAGS += $(addprefix -I$(SOURCE_ROOT)WICED/RTOS/$(RTOS)/WWD/, $(GLOBAL_INCLUDES))
CFLAGS += -I$(SOURCE_ROOT)WICED/platform/$(HOST_ARCH)

include wifi_utils.mk

SOURCES := $($(NAME)_SOURCES)
CFLAGS += $(addprefix -I,$(GLOBAL_INCLUDES)) $(addprefix -D,$(GLOBAL_DEFINES)) $(addprefix -I,$($(NAME)_INCLUDES)) $(addprefix -D,$($(NAME)_DEFINES)) $($(NAME)_CFLAGS)

KEEP_LIST_DIR := $(SOURCE_ROOT)libraries/utilities/wifi_utils

include $(SOURCE_ROOT)tools/release/wiced_library.mk
