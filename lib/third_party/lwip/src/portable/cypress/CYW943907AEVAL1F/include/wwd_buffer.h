/*
 * $ Copyright Cypress Semiconductor $
 */
#ifndef INCLUDED_WWD_BUFFER_H_
#define INCLUDED_WWD_BUFFER_H_

#ifdef __cplusplus
extern "C"
{
#endif
#include "wwd_constants.h"
#include "wiced_constants.h"

/******************************************************
 *             Constants
 ******************************************************/

/******************************************************
 *             Structures
 ******************************************************/

typedef /*@owned@*/ struct pbuf * wiced_buffer_t;

typedef struct
{
    wiced_buffer_t first;
    wiced_buffer_t last;
} wiced_buffer_interface_fifo_t;

typedef struct
{
  wiced_buffer_interface_fifo_t per_interface_fifos[WICED_INTERFACE_MAX];
} wiced_buffer_fifo_t;

/******************************************************
 *             Function declarations
 ******************************************************/

/******************************************************
 *             Global variables
 ******************************************************/


#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* ifndef INCLUDED_WWD_BUFFER_H_ */
