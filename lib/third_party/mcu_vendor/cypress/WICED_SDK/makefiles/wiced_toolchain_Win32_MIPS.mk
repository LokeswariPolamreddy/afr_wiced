#
# $ Copyright Cypress Semiconductor $
#

MIPS_GNU_ARCH_LIST := MIPS


ifneq ($(filter $(HOST_ARCH), $(MIPS_GNU_ARCH_LIST)),)

TOOLCHAIN_PATH    :=
#$(TOOLS_ROOT)/mips-2013.11-37-mips-sde-elf-i686-mingw32/bin
TOOLS_PATH    := $(TOOLS_ROOT)/common/Win32/
HOST_INSTRUCTION_SET := MIPS

TOOLCHAIN_PREFIX  := mips-sde-elf-
#PATH :=
export PATH := $(TOOLS_ROOT)/mips-2013.11-37-mips-sde-elf-i686-mingw32/bin:$(PATH)


# MinGW settings
TOOLCHAIN_SUFFIX  := .exe
OPENOCD_FULL_NAME := $(OPENOCD_PATH)openocd-all-brcm-libftdi
SLASH_QUOTE:=\\\"
ECHO_BLANK_LINE   := echo
PERL    := "$(TOOLS_PATH)perl"
CLEAN_COMMAND := $(TOOLS_PATH)rm -rf build
MKDIR   = "$(TOOLS_PATH)mkdir$(TOOLCHAIN_SUFFIX)" -p $1
CONV_SLASHES = $1

# $(1) is the content, $(2) is the file to print to.
define PRINT
@$(ECHO) '$(1)'>>$(2)

endef


# Set shortcuts to the compiler and other tools
CC      := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)gcc$(TOOLCHAIN_SUFFIX)"
CXX     := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)g++$(TOOLCHAIN_SUFFIX)"
AS      := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)as$(TOOLCHAIN_SUFFIX)"
AR      := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)ar$(TOOLCHAIN_SUFFIX)"
OBJDUMP := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)objdump$(TOOLCHAIN_SUFFIX)"
OBJCOPY := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)objcopy$(TOOLCHAIN_SUFFIX)"
RM      := "$(TOOLS_PATH)rm$(TOOLCHAIN_SUFFIX)" -f
CP      := "$(TOOLS_PATH)cp$(TOOLCHAIN_SUFFIX)" -f
STRIP   := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)strip$(TOOLCHAIN_SUFFIX)"
ECHO    := "$(TOOLS_PATH)echo"
MAKE    := "$(TOOLS_PATH)make$(TOOLCHAIN_SUFFIX)"

COMPILER_SPECIFIC_ARFLAGS_CREATE   := -rcs
COMPILER_SPECIFIC_ARFLAGS_ADD      := -rcs

COMPILER_SPECIFIC_RELEASE_CFLAGS   := -Wall -ffunction-sections -fdata-sections -Os -G0 -gdwarf-2 -fmessage-length=0 -fno-common -EL -march=m14kec -mmicromips -minterlink-mips16 -msoft-float -mlong-calls -mno-gpopt -G 0 -Dmemcpy=or_memcpy -Dmemset=or_memset -Dprintf=or_printf
COMPILER_SPECIFIC_RELEASE_CXXFLAGS := -Wall -ffunction-sections -fdata-sections -Os -G0 -gdwarf-2 -fmessage-length=0 -fno-common -EL -march=m14kec -mmicromips -minterlink-mips16 -msoft-float -mlong-calls -mno-gpopt -G 0 -Dmemcpy=or_memcpy -Dmemset=or_memset -Dprintf=or_printf
COMPILER_SPECIFIC_RELEASE_ASFLAGS  := -ggdb
COMPILER_SPECIFIC_RELEASE_LDFLAGS  := -Wl,--gc-sections -Wl,-Os -Wl,--cref

OPTIONS_IN_FILE_OPTION    := @

LINK_OUTPUT_SUFFIX :=.elf
FINAL_OUTPUT_SUFFIX :=.bin

BUILD_STRING := $(strip $(filter-out clean debug download download_only run terminal, $(MAKECMDGOALS)))
BUILD_DIR    :=  build
OUTPUT_DIR   := $(BUILD_DIR)/$(BUILD_STRING)


endif # ifneq ($(filter $(HOST_ARCH), $(MIPS_GNU_ARCH_LIST)),)
