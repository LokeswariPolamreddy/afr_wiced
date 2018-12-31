/*
 * $ Copyright Cypress Semiconductor $
 */
#pragma once

#include "wiced_tcpip.h"


#ifdef __cplusplus
extern "C" {
#endif


wiced_result_t wiced_ping_send( wiced_interface_t interface, const wiced_ip_address_t* address, uint32_t timeout_ms, uint32_t* elapsed_ms );

#ifdef __cplusplus
} /*extern "C" */
#endif
