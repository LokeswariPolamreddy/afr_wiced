#
# $ Copyright Cypress Semiconductor $
#

NAME := WWD_NoOS_Interface

GLOBAL_INCLUDES := .
$(NAME)_SOURCES  := wwd_rtos.c

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

ifneq ($(filter $(HOST_ARCH), ARM_CM3 ARM_CM4),)
NOOS_ARCH:=Cortex_M3_M4
else
ifneq ($(filter $(HOST_ARCH), ARM_CM7),)
NOOS_ARCH:=Cortex_M7
else
ifneq ($(filter $(HOST_ARCH), ARM_CR4),)
NOOS_ARCH:=Cortex_R4
endif
endif
endif

GLOBAL_INCLUDES += $(NOOS_ARCH)

GLOBAL_INCLUDES += $(NOOS_ARCH)

$(NAME)_SOURCES  += $(NOOS_ARCH)/noos.c

$(NAME)_CHECK_HEADERS := \
                         wwd_rtos.h
