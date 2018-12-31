/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * Common UART STDIO implementation
 */

#include "platform_stdio.h"

/******************************************************
 *                      Macros
 ******************************************************/

/******************************************************
 *                    Constants
 ******************************************************/

/******************************************************
 *                   Enumerations
 ******************************************************/

/******************************************************
 *                 Type Definitions
 ******************************************************/

/******************************************************
 *                    Structures
 ******************************************************/

/******************************************************
 *               Static Function Declarations
 ******************************************************/

/******************************************************
 *               Variable Definitions
 ******************************************************/

#ifndef WICED_DISABLE_STDIO
static platform_uart_driver_t*      stdio_driver = NULL;
static host_semaphore_type_t        stdio_rx_mutex;
static host_semaphore_type_t        stdio_tx_mutex;
static volatile wiced_ring_buffer_t stdio_rx_buffer;
DEFINE_RING_BUFFER_DATA( static volatile uint8_t, stdio_rx_data, STDIO_BUFFER_SIZE )
#endif /* #ifndef WICED_DISABLE_STDIO */

/******************************************************
 *               Function Definitions
 ******************************************************/

platform_result_t platform_stdio_init( platform_uart_driver_t* driver, const platform_uart_t* interface, const platform_uart_config_t* config )
{
#ifndef WICED_DISABLE_STDIO
    platform_result_t result;

    host_rtos_init_semaphore( &stdio_tx_mutex );
    host_rtos_set_semaphore ( &stdio_tx_mutex, WICED_FALSE );
    host_rtos_init_semaphore( &stdio_rx_mutex );
    host_rtos_set_semaphore ( &stdio_rx_mutex, WICED_FALSE );

    ring_buffer_init( (wiced_ring_buffer_t*) &stdio_rx_buffer, (uint8_t*) stdio_rx_data, sizeof( stdio_rx_data ) );

    result = platform_uart_init( driver, interface, config, (wiced_ring_buffer_t*) &stdio_rx_buffer );

    wiced_assert( "stdio init failed", result == PLATFORM_SUCCESS );

    /* platform_stdio is now initiated successfully.
     * Set the driver pointer to enable the xxx_read/xxx_write functions
     */
    stdio_driver = driver;

    return result;
#else
    UNUSED_PARAMETER( driver );
    UNUSED_PARAMETER( interface );
    UNUSED_PARAMETER( config );
    return PLATFORM_UNSUPPORTED;
#endif
}

void platform_stdio_write( const char* str, uint32_t len )
{
    /* This function is called by newlib _write function */
#ifndef WICED_DISABLE_STDIO
    if ( stdio_driver != NULL )
    {
        host_rtos_get_semaphore( &stdio_tx_mutex, NEVER_TIMEOUT, WICED_FALSE );
        platform_uart_transmit_bytes( stdio_driver, (const uint8_t*) str, len );
        host_rtos_set_semaphore( &stdio_tx_mutex, WICED_FALSE );
    }
#else
    UNUSED_PARAMETER( str );
    UNUSED_PARAMETER( len );
#endif
}

void platform_stdio_read( char* str, uint32_t len )
{
    /* This function is called by newlib _read function */
#ifndef WICED_DISABLE_STDIO
    if ( stdio_driver != NULL )
    {
        host_rtos_get_semaphore( &stdio_rx_mutex, NEVER_TIMEOUT, WICED_FALSE );
        platform_uart_receive_bytes( stdio_driver, (uint8_t*) str, &len, NEVER_TIMEOUT );
        host_rtos_set_semaphore( &stdio_rx_mutex, WICED_FALSE );
    }
#else
    UNUSED_PARAMETER( str );
    UNUSED_PARAMETER( len );
#endif
}

void platform_stdio_exception_write( const char* str, uint32_t len )
{
#ifndef WICED_DISABLE_STDIO
    if ( stdio_driver != NULL )
    {
        platform_uart_exception_transmit_bytes( stdio_driver, (const uint8_t*) str, len );
    }
#else
    UNUSED_PARAMETER( str );
    UNUSED_PARAMETER( len );
#endif
}
