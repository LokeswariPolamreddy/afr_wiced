/*
 * $ Copyright Cypress Semiconductor $
 */

#ifndef INCLUDED_WWD_NETWORK_H_
#define INCLUDED_WWD_NETWORK_H_

#include "lwip/err.h"

#ifdef __cplusplus
extern "C"
{
#endif

struct pbuf;
struct netif;

/******************************************************
 *             Constants
 ******************************************************/

/******************************************************
 *             Structures
 ******************************************************/

/******************************************************
 *             Function declarations
 ******************************************************/

extern err_t ethernetif_init( /*@partial@*/ struct netif *netif );

/******************************************************
 *             Global variables
 ******************************************************/

#ifdef __cplusplus
}
#endif

#endif /* define INCLUDED_WWD_NETWORK_H_ */
