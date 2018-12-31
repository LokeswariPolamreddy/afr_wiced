#
# $ Copyright Cypress Semiconductor $
#

NAME := aws_demo
GLOBAL_DEFINES := WICED_AMAZON_FREERTOS_SDK

export AMAZON_FREERTOS_PATH := ../../../../../../../../
export AMAZON_FREERTOS_LIB_PATH := ../../../../../../../

GLOBAL_INCLUDES +=  $(AMAZON_FREERTOS_PATH)demos/common/include \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/jsmn \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/pkcs11 \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/include/lwip \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/mbedtls/include \
                    $(AMAZON_FREERTOS_PATH)lib/include/ \
                    $(AMAZON_FREERTOS_PATH)lib/include/private \
                    $(AMAZON_FREERTOS_PATH)demos/cypress/CYW943907AEVAL1F/common/config_files \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/cypress/CYW943907AEVAL1F \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/arch \
                    $(AMAZON_FREERTOS_PATH)demos/common/include/ \
                    $(AMAZON_FREERTOS_PATH)demos/cypress/CYW943907AEVAL1F/common/config_files \

#$(info $(AMAZON_FREERTOS_PATH))
$(NAME)_SOURCES    := $(AMAZON_FREERTOS_PATH)demos/cypress/CYW943907AEVAL1F/common/application_code/main.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/logging/aws_logging_task_dynamic_buffers.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/demo_runner/aws_demo_runner.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/mqtt/aws_hello_world.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/shadow/aws_shadow_lightbulb_on_off.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/devmode_key_provisioning/aws_dev_mode_key_provisioning.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/greengrass_connectivity/aws_greengrass_discovery_demo.c

$(NAME)_COMPONENTS += utilities/wifi
$(NAME)_COMPONENTS += aws

APPLICATION_DCT := dct_read_write_dct.c

WICED_AMAZON_FREERTOS_SDK := 1