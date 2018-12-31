#
# $ Copyright Cypress Semiconductor $
#

NAME := WWD_FreeRTOS_Interface_$(PLATFORM)

GLOBAL_INCLUDES := . \
                   ./$(PLATFORM_DIRECTORY)

$(NAME)_SOURCES := wwd_rtos.c

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

$(NAME)_CHECK_HEADERS := \
                         wwd_FreeRTOS_systick.h \
                         wwd_rtos.h

$(NAME)_ARM_CM3_SOURCES  := ARM_CM3/low_level_init.c \
                            ARM_CM3/low_power.c
$(NAME)_ARM_CM3_INCLUDES := ./ARM_CM3

$(NAME)_ARM_CM7_SOURCES  := ARM_CM7/low_level_init.c \
                            ARM_CM7/low_power.c
$(NAME)_ARM_CM7_INCLUDES := ./ARM_CM7

$(NAME)_ARM_CM4_SOURCES  := $($(NAME)_ARM_CM3_SOURCES)
$(NAME)_ARM_CM4_INCLUDES := $($(NAME)_ARM_CM3_INCLUDES)

$(NAME)_ARM_CR4_SOURCES  := ARM_CR4/low_level_init.c \
                            ARM_CR4/low_power.c
$(NAME)_ARM_CR4_INCLUDES := ./ARM_CR4

$(NAME)_Win32_x86_SOURCES    :=
$(NAME)_Win32_x86_INCLUDES   := ./Win32_x86

$(NAME)_SOURCES += $($(NAME)_$(HOST_ARCH)_SOURCES)
GLOBAL_INCLUDES += $($(NAME)_$(HOST_ARCH)_INCLUDES)
