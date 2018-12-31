#
# $ Copyright Cypress Semiconductor $
#

# Separate the DCT value file from the actual build target
DCT_VALUE_FILE :=$(word 2, $(MAKECMDGOALS))
EXTENSION      :=$(notdir $(DCT_VALUE_FILE:.txt=))
MAKECMDGOALS   :=$(word 1, $(MAKECMDGOALS))


include $(MAKEFILES_PATH)/wiced_toolchain_common.mk

CONFIG_FILE := build/$(CLEANED_BUILD_STRING)/config.mk
include $(CONFIG_FILE)

# Include all toolchain makefiles - one of them will handle the architecture
ifeq ($(IAR),1)
include $(MAKEFILES_PATH)/wiced_toolchain_IAR.mk
else
include $(MAKEFILES_PATH)/wiced_toolchain_ARM_GNU.mk
endif

include $(SOURCE_ROOT)/platforms/$(PLATFORM)/$(PLATFORM).mk
include $(SOURCE_ROOT)/WICED/WICED.mk


DCT_TEMPLATE_FILE         := $(SOURCE_ROOT)Apps/$(APP_FULL)/factory_reset_dct.c
DCT_FILE_NAME             := $(OUTPUT_DIR)/factory_reset/factory_reset_dct_$(EXTENSION)
DCT_C_FILE                := $(DCT_FILE_NAME).c
DCT_O_FILE                := $(DCT_FILE_NAME).o
DCT_BIN_FILE              := $(DCT_FILE_NAME).bin
DCT_LINKED_FILE           := $(DCT_FILE_NAME)$(LINK_OUTPUT_SUFFIX)
LINK_DCT_STRIPPED_FILE    := $(DCT_FILE_NAME).stripped$(LINK_OUTPUT_SUFFIX)
MAP_DCT_FILE              :=$(DCT_LINKED_FILE:$(LINK_OUTPUT_SUFFIX)=.map)
WICED_SDK_DCT_LINK_SCRIPT :=$(if $(DCT_LINK_SCRIPT),$(addprefix $($(NAME)_LOCATION),$(DCT_LINK_SCRIPT)),)

.PHONY: $(DCT_C_FILE) $(MAKECMDGOALS)

#
#$(info APP_FULL        ::: $(APP_FULL))
#$(info DCT_VALUE_FILE  ::: $(DCT_VALUE_FILE))
#$(info DCT_FILE_NAME   ::: $(DCT_FILE_NAME))
#$(info DCT_C_FILE      ::: $(DCT_C_FILE))
#$(info DCT_O_FILE      ::: $(DCT_O_FILE))
#$(info DCT_LINKED_FILE ::: $(DCT_LINKED_FILE))
#$(info STRIP           ::: $(STRIP))
#$(info DCT_LINK_SCRIPT ::: $(DCT_LINK_SCRIPT))
#
#$(info WICED_SDK_LDFLAGS                   ::: $(WICED_SDK_LDFLAGS))
#$(info COMPILER_SPECIFIC_EXTRA_DCT_LDFLAGS ::: $(COMPILER_SPECIFIC_EXTRA_DCT_LDFLAGS))
#$(info WICED_SDK_DCT_LINK_CMD              ::: $(WICED_SDK_DCT_LINK_CMD))

#$(info PERL script     ::: $(WICED_SDK_DCT_LINK_SCRIPT))
#$(info MAKECMDGOALS    ::: $(MAKECMDGOALS))

##################################
# Build rules
##################################

COMMA :=,

CFLAGS :=
CFLAGS += -I$(SOURCE_ROOT)include
CFLAGS += -I$(SOURCE_ROOT)platforms/$(PLATFORM)
CFLAGS += -I$(SOURCE_ROOT)WICED/security/BESL/include
CFLAGS += -I$(SOURCE_ROOT)libraries/filesystems/tester
CFLAGS += -I$(SOURCE_ROOT)libraries/utilities/crc
CFLAGS += -I$(SOURCE_ROOT)WICED/platform/include
CFLAGS += -I$(SOURCE_ROOT)WICED/platform/MCU
CFLAGS += -I$(SOURCE_ROOT)WICED/WWD/include
CFLAGS += -I$(SOURCE_ROOT)WICED/RTOS/NoOS/wwd
CFLAGS += -I$(SOURCE_ROOT)WICED/Network/NoNS/wwd
CFLAGS += $(WICED_SDK_DEFINES)
CFLAGS += -nostartfiles
CFLAGS += $(addprefix -Wl$(COMMA)-T ,$(WICED_DCT_LINK_SCRIPT))

$(MAKECMDGOALS): $(DCT_LINKED_FILE)

$(DCT_C_FILE): $(DCT_VALUE_FILE) $(DCT_TEMPLATE_FILE)
	$(QUIET)$(call MKDIR, $(OUTPUT_DIR)/factory_reset)
	$(QUIET)$(ECHO) Perling Factory Reset DCT image
	$(PERL) $(TOOLS_ROOT)/create_dct/generate_factory_reset_dct.pl $(DCT_VALUE_FILE) $(DCT_TEMPLATE_FILE) > $(DCT_C_FILE)

$(DCT_LINKED_FILE): $(DCT_C_FILE)
	$(QUIET)$(ECHO) Compiling Factory Reset DCT image
	$(QUIET)$(CC) $(CPU_CFLAGS) $(COMPILER_SPECIFIC_COMP_ONLY_FLAG) $(DCT_C_FILE) $(WICED_SDK_DEFINES) $(WICED_SDK_INCLUDES) $(COMPILER_SPECIFIC_DEBUG_CFLAGS) $(COMPILER_SPECIFIC_STANDARD_CFLAGS) -I$(OUTPUT_DIR) -I$(SOURCE_ROOT). -I$(SOURCE_ROOT)apps/$(APP_FULL) -o $(DCT_O_FILE)
	$(QUIET)$(ECHO) Link
	$(QUIET)$(LINKER) $(WICED_SDK_LDFLAGS) $(COMPILER_SPECIFIC_EXTRA_DCT_LDFLAGS) $(WICED_SDK_DCT_LINK_CMD) $(call COMPILER_SPECIFIC_LINK_MAP,$(MAP_DCT_FILE)) -o $@  $(DCT_O_FILE)
	$(QUIET)$(ECHO) Strip
	$(STRIP) -o $(LINK_DCT_STRIPPED_FILE) $(STRIPFLAGS) $(DCT_LINKED_FILE)
	$(QUIET)$(ECHO) Obj Copy
	$(QUIET)$(OBJCOPY) -O binary -R .eh_frame -R .init -R .fini -R .comment -R .ARM.attributes $(DCT_O_FILE) $(DCT_BIN_FILE)
