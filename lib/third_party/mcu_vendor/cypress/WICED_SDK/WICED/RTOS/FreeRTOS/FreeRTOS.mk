#
# $ Copyright Cypress Semiconductor $
#

NAME := FreeRTOS

VERSION := 10.0.0

$(NAME)_COMPONENTS := WICED/RTOS/FreeRTOS/WWD
ifeq (,$(APP_WWD_ONLY)$(NS_WWD_ONLY)$(RTOS_WWD_ONLY))
$(NAME)_COMPONENTS += WICED/RTOS/FreeRTOS/WICED
endif

# Define some macros to allow for some network-specific checks
GLOBAL_DEFINES += RTOS_$(NAME)=1
GLOBAL_DEFINES += configUSE_MUTEXES
GLOBAL_DEFINES += configUSE_RECURSIVE_MUTEXES
GLOBAL_DEFINES += $(NAME)_VERSION=$$(SLASH_QUOTE_START)v$(VERSION)$$(SLASH_QUOTE_END)

#GLOBAL_INCLUDES := ver$(VERSION)/Source/include
GLOBAL_INCLUDES := $(AMAZON_FREERTOS_PATH)lib/include \
				   $(AMAZON_FREERTOS_PATH)lib/include/private


$(NAME)_SOURCES :=  $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/event_groups.c \
                    $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/list.c \
                    $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/queue.c \
                    $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/tasks.c \
                    $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/timers.c \
                    $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/stream_buffer.c \
                    $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/MemMang/heap_3.c

# Win32_x86 specific sources and includes
$(NAME)_Win32_x86_SOURCES  := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/MSVC-MingW/port.c
$(NAME)_Win32_x86_INCLUDES := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/MSVC-MingW
$(NAME)_Win32_x86_LDFLAGS  := -l winmm

$(NAME)_DEFINES := FREERTOS_WICED

# ARM Cortex M3/4 specific sources and includes
ifeq ($(TOOLCHAIN_NAME),IAR)
$(NAME)_ARM_CM3_SOURCES  := ver$(VERSION)/Source/portable/IAR/ARM_CM3/port.c \
                          ver$(VERSION)/Source/portable/IAR/ARM_CM3/portasm.S
$(NAME)_ARM_CM3_INCLUDES := ver$(VERSION)/Source/portable/IAR/ARM_CM3 \
                    WWD/ARM_CM3
else
$(NAME)_ARM_CM3_SOURCES  := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/GCC/ARM_CM3/port.c
$(NAME)_ARM_CM3_INCLUDES := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/GCC/ARM_CM3

$(NAME)_ARM_CM7_SOURCES  := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/GCC/ARM_CM7/r0p1/port.c \
                            WWD/ARM_CM7
$(NAME)_ARM_CM7_INCLUDES := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/GCC/ARM_CM7/r0p1 \
                            WWD/ARM_CM7

endif
$(NAME)_ARM_CM4_SOURCES  := $($(NAME)_ARM_CM3_SOURCES)
$(NAME)_ARM_CM4_INCLUDES := $($(NAME)_ARM_CM3_INCLUDES)

# ARM Cortex R4 specific sources and includes
#$(NAME)_ARM_CR4_SOURCES := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/GCC/ARM_CRx_No_GIC/port.c \
#                          $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/GCC/ARM_CRx_No_GIC/portASM.S
#$(NAME)_ARM_CR4_INCLUDES := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/GCC/ARM_CRx_No_GIC

$(NAME)_ARM_CR4_SOURCES := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/ThirdParty/GCC/Wiced_CY/port.c \
                          $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/ThirdParty/GCC/Wiced_CY/portASM.S
$(NAME)_ARM_CR4_INCLUDES := $(AMAZON_FREERTOS_PATH)lib/FreeRTOS/portable/ThirdParty/GCC/Wiced_CY/

$(NAME)_SOURCES += $($(NAME)_$(HOST_ARCH)_SOURCES)
GLOBAL_INCLUDES += $($(NAME)_$(HOST_ARCH)_INCLUDES)
GLOBAL_LDFLAGS  += $($(NAME)_$(HOST_ARCH)_LDFLAGS)


