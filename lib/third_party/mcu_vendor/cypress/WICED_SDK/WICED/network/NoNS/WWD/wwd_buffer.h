/*
 * $ Copyright Cypress Semiconductor $
 */
#ifndef INCLUDED_WWD_BUFFER_H_
#define INCLUDED_WWD_BUFFER_H_


#include <stdint.h>

#ifdef __cplusplus
extern "C"
{
#endif

/******************************************************
 *             Constants
 ******************************************************/

/******************************************************
 *             Structures
 ******************************************************/

typedef /*@abstract@*/ /*@owned@*/ char* wiced_buffer_t;

typedef struct
{
    /*@dependent@*/ void*    internal_buffer;
    uint16_t buff_size;
} nons_buffer_init_t;

typedef void wiced_buffer_fifo_t;

/******************************************************
 *             Function declarations
 ******************************************************/

/*@external@*/ extern void nons_set_packet_size( uint16_t size );

/******************************************************
 *             Global variables
 ******************************************************/

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* ifndef INCLUDED_WWD_BUFFER_H_ */
