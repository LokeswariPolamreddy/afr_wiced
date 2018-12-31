/*
 * $ Copyright Cypress Semiconductor $
 */

/*
 * @file
 * Interface functions for Newlib libC implementation
 */

#include "RTOS/wwd_rtos_interface.h"
#include <stdio.h>
#include <sys/time.h>

int _gettimeofday( struct timeval* tv, void* timezone ) {
    UNUSED_PARAMETER( timezone );

    wwd_time_t time_ms = host_rtos_get_time( );
    tv->tv_sec = ( time_ms / 1000 /* to convert ms to sec */ );
    tv->tv_usec = ( time_ms - ( tv->tv_sec * 1000 ) ) * 1000;

    return 0;
}
