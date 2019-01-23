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
                   $(AMAZON_FREERTOS_PATH)lib/third_party/lwip/src/portable/cypress/$(PLATFORM)/include \
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