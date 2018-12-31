#
# $ Copyright Cypress Semiconductor $
#

NAME := Wiced_Network_LwIP_FreeRTOS

GLOBAL_INCLUDES += .
$(NAME)_SOURCES := $(AMAZON_FREERTOS_PATH)../../lib/third_party/lwip/src/portable/arch/sys_arch.c
