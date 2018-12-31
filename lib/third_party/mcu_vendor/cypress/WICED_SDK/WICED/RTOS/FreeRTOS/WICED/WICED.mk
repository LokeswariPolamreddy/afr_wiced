#
# $ Copyright Cypress Semiconductor $
#

NAME := WICED_FreeRTOS_Interface

GLOBAL_INCLUDES := .

$(NAME)_SOURCES := wiced_rtos.c \
                   ../../wiced_rtos_common.c

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

$(NAME)_CHECK_HEADERS := \
                         rtos.h