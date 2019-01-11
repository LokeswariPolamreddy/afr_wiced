
PROJECT_NAME := aws_tests

ifndef AMAZON_FREERTOS_PATH
export AMAZON_FREERTOS_PATH := $(CURDIR)/../../../..
endif

ifndef WICED_SDK_PATH
export WICED_SDK_PATH := $(AMAZON_FREERTOS_PATH)/lib/third_party/mcu_vendor/cypress/WICED_SDK
endif

export AMAZON_FREERTOS_ENABLE_UNIT_TESTS := 1

include $(WICED_SDK_PATH)/Makefile

