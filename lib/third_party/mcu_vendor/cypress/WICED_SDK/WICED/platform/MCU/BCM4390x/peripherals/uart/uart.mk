#
# $ Copyright Cypress Semiconductor $
#

NAME := Uart_43909_Library_$(PLATFORM)

$(NAME)_SOURCES := platform_uart.c

$(eval $(call PLATFORM_LOCAL_DEFINES_INCLUDES_43909, ../..))
