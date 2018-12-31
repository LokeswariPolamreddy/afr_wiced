#
# $ Copyright Cypress Semiconductor $
#

NAME := WWD_NoNS_Interface

GLOBAL_INCLUDES := .
$(NAME)_SOURCES  := wwd_buffer.c

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

$(NAME)_CHECK_HEADERS := \
                         wwd_buffer.h
