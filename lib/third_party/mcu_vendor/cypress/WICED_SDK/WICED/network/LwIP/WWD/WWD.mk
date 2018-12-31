#
# $ Copyright Cypress Semiconductor $
#

NAME := WWD_LwIP_Interface_$(RTOS)

GLOBAL_INCLUDES := .

$(NAME)_SOURCES := $(AMAZON_FREERTOS_PATH)../lib/third_party/lwip/src/portable/cypress/CYW943907AEVAL1F/wwd_buffer.c \
                   $(AMAZON_FREERTOS_PATH)../lib/third_party/lwip/src/portable/cypress/CYW943907AEVAL1F/wwd_network.c \
                   $(AMAZON_FREERTOS_PATH)../lib/third_party/lwip/src/portable/cypress/CYW943907AEVAL1F//netif/ethernetif.c

$(NAME)_COMPONENTS := WICED/network/LwIP/WWD/$(RTOS)

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

$(NAME)_CHECK_HEADERS := \
                         $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/cypress/CYW943907AEVAL1F/include/wwd_buffer.h \
                         $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/cypress/CYW943907AEVAL1F/include/ethernetif.h
