#
# $ Copyright Cypress Semiconductor $
#

x86_GNU_ARCH_LIST := Win32_x86 Linux_x86

ifneq ($(filter $(HOST_ARCH), $(x86_GNU_ARCH_LIST)),)


HOST_INSTRUCTION_SET := X86

ifeq ($(HOST_OS),Win32)

TOOLCHAIN_PATH    := /pf8_3/MinGW/bin/
EXTRA_INCLUDE_DIRS:= $(TOOLCHAIN_PATH)../lib/gcc/mingw32/4.7.2/include/c++/ \
                     $(TOOLCHAIN_PATH)../lib/gcc/mingw32/4.7.2/include/c++/mingw32

LINK_OUTPUT_SUFFIX :=.exe

else
ifeq ($(HOST_OS),Linux32)

TOOLCHAIN_PATH    := /usr/bin/
EXTRA_INCLUDE_DIRS:=

COMPILER_SPECIFIC_EXTRA_DCT_LDFLAGS     := -static -static-libgcc -Wl,-static -Wl,-Bsymbolic -nostartfiles -fPIE -Wl,--build-id=none

else
ifeq ($(HOST_OS),Linux64)

TOOLCHAIN_PATH    := /usr/bin/
EXTRA_INCLUDE_DIRS:=

COMPILER_SPECIFIC_EXTRA_DCT_LDFLAGS     := -static -static-libgcc -Wl,-static -Wl,-Bsymbolic -nostartfiles -fPIE -Wl,--build-id=none

else
$(error Host $(HOST_OS) unknown)

endif
endif
endif

TOOLCHAIN_PREFIX  :=

PATH := $(TOOLCHAIN_PATH)

CC      := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)gcc$(EXECUTABLE_SUFFIX)"
CXX     := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)g++$(EXECUTABLE_SUFFIX)" -B $(TOOLCHAIN_PATH) $(addprefix -isystem,$(EXTRA_INCLUDE_DIRS))
AS      := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)as$(EXECUTABLE_SUFFIX)"
AR      := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)ar$(EXECUTABLE_SUFFIX)"
OBJDUMP := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)objdump$(EXECUTABLE_SUFFIX)"
OBJCOPY := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)objcopy$(EXECUTABLE_SUFFIX)"
STRIP   := "$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX)strip$(EXECUTABLE_SUFFIX)"


COMPILER_SPECIFIC_STANDARD_CFLAGS   = -Wall -fsigned-char -ffunction-sections -fdata-sections -fno-common
COMPILER_SPECIFIC_STANDARD_CXXFLAGS = -Wall -fsigned-char -ffunction-sections -fdata-sections -fno-common -fno-rtti -fno-exceptions
COMPILER_SPECIFIC_STANDARD_ADMFLAGS =
COMPILER_SPECIFIC_PEDANTIC_CFLAGS  := $(COMPILER_SPECIFIC_STANDARD_CFLAGS) -Werror -Wstrict-prototypes  -W -Wshadow  -Wwrite-strings -pedantic -std=c99 -Wconversion -Wextra -Wdeclaration-after-statement -Wconversion -Waddress -Wlogical-op -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations -Wmissing-field-initializers -Wdouble-promotion -Wswitch-enum -Wswitch-default -Wuninitialized -Wunknown-pragmas -Wfloat-equal  -Wundef  -Wshadow # -Wcast-qual -Wtraditional -Wtraditional-conversion
COMPILER_SPECIFIC_ARFLAGS_CREATE   := -rcs
COMPILER_SPECIFIC_ARFLAGS_ADD      := -rcs
COMPILER_SPECIFIC_ARFLAGS_VERBOSE  := -v
COMPILER_SPECIFIC_DEBUG_CFLAGS     := -DDEBUG -ggdb -O0
COMPILER_SPECIFIC_DEBUG_CXXFLAGS   := -DDEBUG -ggdb -O0
COMPILER_SPECIFIC_DEBUG_ASFLAGS    := --defsym DEBUG=1 -ggdb
COMPILER_SPECIFIC_DEBUG_LDFLAGS    := -Wl,--gc-sections -Wl,--cref
COMPILER_SPECIFIC_RELEASE_CFLAGS   := -DNDEBUG -ggdb -O3
COMPILER_SPECIFIC_RELEASE_CXXFLAGS := -DNDEBUG -ggdb -O3
COMPILER_SPECIFIC_RELEASE_ASFLAGS  := -ggdb
COMPILER_SPECIFIC_RELEASE_LDFLAGS  := -Wl,--gc-sections -Wl,-O3 -Wl,--cref
COMPILER_SPECIFIC_DEPS_FLAG        := -MD
COMPILER_SPECIFIC_COMP_ONLY_FLAG   := -c
COMPILER_SPECIFIC_LINK_MAP         =  -Wl,-Map,$(1)
COMPILER_SPECIFIC_LINK_FILES       =  -Wl,--start-group $(1) -Wl,--end-group
COMPILER_SPECIFIC_LINK_SCRIPT_DEFINE_OPTION = -Wl$(COMMA)-T
COMPILER_SPECIFIC_LINK_SCRIPT      =  $(addprefix -Wl$(COMMA)-T ,$(1))
LINKER                             := $(CXX)  -Wl,--warn-common
#--static -Wl,-static
TOOLCHAIN_NAME := GCC
OPTIONS_IN_FILE_OPTION    := @



FINAL_OUTPUT_SUFFIX :=.bin

endif
