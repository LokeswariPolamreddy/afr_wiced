#
# $ Copyright Cypress Semiconductor $
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
                    $(AMAZON_FREERTOS_LIB_PATH)lib/wifi/portable/cypress/CYW954907AEVAL1F/aws_wifi.c     \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/pkcs11/mbedtls/aws_pkcs11_mbedtls.c \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/crypto/aws_crypto.c \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/pkcs11/portable/cypress/CYW954907AEVAL1F/aws_pkcs11_pal.c

$(NAME)_INCLUDES := $(AMAZON_FREERTOS_LIB_PATH)lib/include/ \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/jsmn \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/mbedtls/include \
                    $(AMAZON_FREERTOS_LIB_PATH)lib/third_party/unity/src