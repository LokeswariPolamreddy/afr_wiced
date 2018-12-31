#
# $ Copyright Cypress Semiconductor $
#

NAME := Lib_Wiced_RO_FS

$(NAME)_SOURCES := \
                   src/wicedfs.c \
                   wicedfs_drivers.c

GLOBAL_INCLUDES := src

GLOBAL_DEFINES := USING_WICEDFS

$(NAME)_CFLAGS  = $(COMPILER_SPECIFIC_PEDANTIC_CFLAGS)


$(NAME)_UNIT_TEST_SOURCES := src/unit/wicedfs_unit_images.c src/unit/wicedfs_unit.cpp