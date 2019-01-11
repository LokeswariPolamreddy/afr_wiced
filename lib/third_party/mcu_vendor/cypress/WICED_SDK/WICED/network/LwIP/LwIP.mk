#
# $ Copyright Cypress Semiconductor $
#

NAME := LwIP

VERSION := 2.0.3

$(NAME)_COMPONENTS += WICED/network/LwIP/WWD
ifeq (,$(APP_WWD_ONLY)$(NS_WWD_ONLY)$(RTOS_WWD_ONLY))
$(NAME)_COMPONENTS += WICED/network/LwIP/WICED
endif

ifeq ($(BUILD_TYPE),debug)
GLOBAL_DEFINES := WICED_LWIP_DEBUG
endif

VALID_RTOS_LIST:= FreeRTOS

# Ethernet driver is not yet implemented for LwIP
PLATFORM_NO_GMAC := 1

# Define some macros to allow for some network-specific checks
GLOBAL_DEFINES += NETWORK_$(NAME)=1
GLOBAL_DEFINES += $(NAME)_VERSION=$$(SLASH_QUOTE_START)v$(VERSION)$$(SLASH_QUOTE_END)

# See GCC bug 48778. Some LwIP IP address macros fall over this
ifeq ($(TOOLCHAIN_TYPE),gcc)
GLOBAL_CFLAGS += -Wno-address
endif

GLOBAL_INCLUDES := $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/include \
                   $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable \
                   $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/cypress/CYW954907AEVAL1F/include \
                   WICED

$(NAME)_SOURCES :=  $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/api_lib.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/api_msg.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/err.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/netbuf.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/netdb.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/netifapi.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/sockets.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/api/tcpip.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/dhcp.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/dns.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/init.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ip.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/autoip.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/icmp.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/igmp.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/inet_chksum.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/ip4.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/ip4_addr.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/ip4_frag.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/def.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/timeouts.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/mem.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/memp.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/netif.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/pbuf.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/raw.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/apps/snmp/snmp_asn1.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/apps/snmp/snmp_mib2.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/apps/snmp/snmp_msg.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/stats.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/sys.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/tcp.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/tcp_in.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/tcp_out.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/udp.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv4/etharp.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/netif/ethernet.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/ethip6.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/dhcp6.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/icmp6.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/inet6.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/ip6.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/ip6_addr.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/ip6_frag.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/mld6.c \
                    $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/core/ipv6/nd6.c