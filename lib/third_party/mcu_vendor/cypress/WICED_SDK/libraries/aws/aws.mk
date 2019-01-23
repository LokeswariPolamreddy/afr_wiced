#
# Copyright 2019, Cypress Semiconductor Corporation or a subsidiary of
 # Cypress Semiconductor Corporation. All Rights Reserved.
 # 
 # This software, associated documentation and materials ("Software")
 # is owned by Cypress Semiconductor Corporation,
 # or one of its subsidiaries ("Cypress") and is protected by and subject to
 # worldwide patent protection (United States and foreign),
 # United States copyright laws and international treaty provisions.
 # Therefore, you may use this Software only as provided in the license
 # agreement accompanying the software package from which you
 # obtained this Software ("EULA").
 # If no EULA applies, Cypress hereby grants you a personal, non-exclusive,
 # non-transferable license to copy, modify, and compile the Software
 # source code solely for use in connection with Cypress's
 # integrated circuit products. Any reproduction, modification, translation,
 # compilation, or representation of this Software except as specified
 # above is prohibited without the express written permission of Cypress.
 #
 # Disclaimer: THIS SOFTWARE IS PROVIDED AS-IS, WITH NO WARRANTY OF ANY KIND,
 # EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, NONINFRINGEMENT, IMPLIED
 # WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. Cypress
 # reserves the right to make changes to the Software without notice. Cypress
 # does not assume any liability arising out of the application or use of the
 # Software or any product or circuit described in the Software. Cypress does
 # not authorize its products for use in any products where a malfunction or
 # failure of the Cypress product may reasonably be expected to result in
 # significant property damage, injury or death ("High Risk Product"). By
 # including Cypress's product in a High Risk Product, the manufacturer
 # of such system or application assumes all risk of such use and in doing
 # so agrees to indemnify Cypress against all liability.
#

NAME := aws

$(NAME)_SOURCES :=  $(AMAZON_FREERTOS_LIB_PATH)lib/bufferpool/aws_bufferpool_static_thread_safe.c        \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/greengrass/aws_greengrass_discovery.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/greengrass/aws_helper_secure_connect.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/jsmn/jsmn.c                               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/aes.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/aesni.c                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/arc4.c                    \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/asn1parse.c               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/asn1write.c               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/base64.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/bignum.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/blowfish.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/camellia.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ccm.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/certs.c                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/cipher.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/cipher_wrap.c             \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/cmac.c                    \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ctr_drbg.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/debug.c                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/des.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/dhm.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ecdh.c                    \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ecdsa.c                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ecjpake.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ecp.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ecp_curves.c              \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/entropy.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/entropy_poll.c            \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/error.c                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/gcm.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/havege.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/hmac_drbg.c               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/md.c                      \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/md2.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/md4.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/md5.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/md_wrap.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/memory_buffer_alloc.c     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/net_sockets.c             \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/oid.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/padlock.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/pem.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/pk.c                      \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/pk_wrap.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/pkcs12.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/pkcs5.c                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/pkparse.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/pkwrite.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/platform.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/platform_util.c           \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ripemd160.c               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/rsa.c                     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/rsa_internal.c            \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/sha1.c                    \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/sha256.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/sha512.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ssl_cache.c               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ssl_ciphersuites.c        \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ssl_cli.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ssl_cookie.c              \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ssl_srv.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ssl_ticket.c              \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/ssl_tls.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/threading.c               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/timing.c                  \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/version.c                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/version_features.c        \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/xtea.c                    \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/x509.c                    \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/x509_create.c             \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/x509_crl.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/x509_crt.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/x509_csr.c                \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/x509write_crt.c           \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/library/x509write_csr.c           \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/mqtt/aws_mqtt_agent.c                                 \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/mqtt/aws_mqtt_lib.c                                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/secure_sockets/portable/lwip/aws_secure_sockets.c \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/shadow/aws_shadow.c                                   \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/shadow/aws_shadow_json.c                              \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/tls/aws_tls.c                                         \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/utils/aws_system_init.c                               \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/wifi/portable/cypress/$(PLATFORM)/aws_wifi.c     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/pkcs11/mbedtls/aws_pkcs11_mbedtls.c \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/crypto/aws_crypto.c \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/pkcs11/portable/cypress/$(PLATFORM)/aws_pkcs11_pal.c

$(NAME)_INCLUDES := $(AMAZON_FREERTOS_LIB_PATH)lib/include/ \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/jsmn \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/include \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/unity/src