#
# $ Copyright Cypress Semiconductor $
#

NAME := NoOS

# Define some macros to allow for some network-specific checks
GLOBAL_DEFINES += RTOS_$(NAME)=1

$(NAME)_COMPONENTS := WICED/RTOS/NoOS/WWD

#This makefile is a placeholder for cases when No Operating System is used
$(NAME)_INCLUDES :=

ifeq (,$(APP_WWD_ONLY)$(NS_WWD_ONLY)$(RTOS_WWD_ONLY))
$(NAME)_SOURCES  := WICED/rtos.c
endif

GLOBAL_INCLUDES := .

RTOS_WWD_ONLY := TRUE