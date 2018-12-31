#
# $ Copyright Cypress Semiconductor $
#

NAME := WICED_LwIP_Interface

GLOBAL_INCLUDES := .

$(NAME)_SOURCES := wiced_network.c \
                   tcpip.c \
                   wiced_ping.c \
                   ../../wiced_network_common.c \
                   ../../wiced_tcpip_common.c

ifeq ($(TOOLCHAIN_TYPE),gcc)
# Filter out -Waddress due to GCC bug 48778. Some LwIP IP address macros
# fall over this
$(NAME)_CFLAGS  = $(filter-out -Waddress, $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS))
else
$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)
endif

$(NAME)_CHECK_HEADERS := \
                         wiced_ping.h \
                         wiced_network.h
