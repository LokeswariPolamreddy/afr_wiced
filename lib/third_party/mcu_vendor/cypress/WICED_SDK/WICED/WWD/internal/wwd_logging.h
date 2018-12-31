/*
 * $ Copyright Cypress Semiconductor $
 */
#ifndef INCLUDED_WWD_LOGGING_H_
#define INCLUDED_WWD_LOGGING_H_

#ifdef __cplusplus
extern "C"
{
#endif

/*
#define WWD_LOGGING_STDOUT_ENABLE
*/
/*
#define WWD_LOGGING_BUFFER_ENABLE
*/

#if defined( WWD_LOGGING_STDOUT_ENABLE )

#include <stdio.h>
extern int wwd_logging_enabled;
#define WWD_LOG( x ) if (wwd_logging_enabled) {printf x; }

#elif defined( WWD_LOGGING_BUFFER_ENABLE )
extern int wwd_logging_enabled;
#define LOGGING_BUFFER_SIZE 1024
extern int wwd_logging_printf( const char *format, ...);
extern void wwd_get_logbuffer( uint8_t **bufptr );
#define WWD_LOG( x ) if ( wwd_logging_enabled ) {wwd_logging_printf x; }

/* Enable WICED_LOGBUF for sigma dut debugging, as WWD_LOG in code may
 * be too much of a logging
 */
#define WICED_LOGBUF( x ) //if (wwd_logging_enabled) {wwd_logging_printf x; }

#else /* if defined( WWD_LOGGING_BUFFER_ENABLE ) */

#define WWD_LOG(x)
#define WICED_LOGBUF( x )

#endif /* if defined( WWD_LOGGING_BUFFER_ENABLE ) */


#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* ifndef INCLUDED_WWD_LOGGING_H_ */
