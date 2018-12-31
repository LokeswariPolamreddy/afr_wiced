#
# $ Copyright Cypress Semiconductor $
#

NAME := SDIO_Host_43909_Library_$(PLATFORM)

GLOBAL_DEFINES += BCMSDIO

$(NAME)_SOURCES := bcmsdstd.c \
                   bcmsdstd_wiced.c

$(eval $(call PLATFORM_LOCAL_DEFINES_INCLUDES_43909, ../..))