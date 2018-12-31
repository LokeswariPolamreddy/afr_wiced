#
# $ Copyright Cypress Semiconductor $
#

NAME := NoNS

$(NAME)_COMPONENTS += WICED/network/NoNS/WWD

# Define some macros to allow for some network-specific checks
GLOBAL_DEFINES += NETWORK_$(NAME)=1

$(NAME)_INCLUDES :=
$(NAME)_SOURCES  :=
$(NAME)_DEFINES  :=

VALID_RTOS_LIST:= NoOS

NS_WWD_ONLY := TRUE