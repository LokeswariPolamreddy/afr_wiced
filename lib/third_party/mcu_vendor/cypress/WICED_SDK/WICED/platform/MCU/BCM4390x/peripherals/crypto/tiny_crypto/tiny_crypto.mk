#
# $ Copyright Cypress Semiconductor $
#

NAME := Tiny_Crypto_43909_Library_$(PLATFORM)

$(NAME)_SOURCES := platform_tiny_crypto.c

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)

$(eval $(call PLATFORM_LOCAL_DEFINES_INCLUDES_43909, ../../..))
