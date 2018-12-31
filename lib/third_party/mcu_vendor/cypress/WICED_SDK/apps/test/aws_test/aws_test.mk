#
# $ Copyright Cypress Semiconductor $
#

NAME := aws_test
GLOBAL_DEFINES := AMAZON_FREERTOS_ENABLE_UNIT_TESTS \
                  WICED_AMAZON_FREERTOS_SDK \
                  UNITY_EXCLUDE_MATH_H \
                  UNITY_INCLUDE_CONFIG_H

export AMAZON_FREERTOS_PATH := ../../../../../../../../
export AMAZON_FREERTOS_LIB_PATH := ../../../../../../../

GLOBAL_INCLUDES +=  $(AMAZON_FREERTOS_PATH)tests/common/include/ \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/jsmn \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/pkcs11 \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/include/lwip \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/mbedtls/include \
                    $(AMAZON_FREERTOS_PATH)lib/include/ \
                    $(AMAZON_FREERTOS_PATH)lib/include/private \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/unity/src \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/unity/extras/fixture/src \
                    $(AMAZON_FREERTOS_PATH)tests/cypress/CYW943907AEVAL1F/common/config_files \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/cypress/CYW943907AEVAL1F \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/arch \
                    $(AMAZON_FREERTOS_PATH)tests/common/include/ \
                    $(AMAZON_FREERTOS_PATH)tests/cypress/CYW943907AEVAL1F/common/config_files

#$(info $(AMAZON_FREERTOS_PATH))
$(NAME)_SOURCES    := $(AMAZON_FREERTOS_PATH)tests/cypress/CYW943907AEVAL1F/common/application_code/main.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/logging/aws_logging_task_dynamic_buffers.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/test_runner/aws_test_runner.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/framework/aws_test_framework.c \
                      $(AMAZON_FREERTOS_PATH)lib/third_party/unity/src/unity.c \
                      $(AMAZON_FREERTOS_PATH)lib/third_party/unity/extras/fixture/src/unity_fixture.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/wifi/aws_test_wifi.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/tls/aws_test_tls.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/secure_sockets/aws_test_tcp.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/pkcs11/aws_test_pkcs11.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/mqtt/aws_test_mqtt_agent.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/mqtt/aws_test_mqtt_lib.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/shadow/aws_test_shadow.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/greengrass/aws_test_greengrass_discovery.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/greengrass/aws_test_helper_secure_connect.c \
                      $(AMAZON_FREERTOS_PATH)tests/common/tls/aws_test_tls.c \
                      $(AMAZON_FREERTOS_PATH)demos/common/devmode_key_provisioning/aws_dev_mode_key_provisioning.c
                    
$(NAME)_COMPONENTS += utilities/wifi
$(NAME)_COMPONENTS += aws

APPLICATION_DCT := dct_read_write_dct.c

WICED_AMAZON_FREERTOS_SDK := 1