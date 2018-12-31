/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *
 */
#include "wiced_result.h"
#include "wwd_constants.h"
#include "platform_config.h"
#include "wwd_debug.h"

extern wiced_result_t wiced_core_init( void );
extern wiced_result_t wiced_core_deinit( void );
extern wiced_result_t wiced_platform_init( void );
extern wiced_result_t wiced_rtos_init  ( void );
extern wiced_result_t wiced_dct_init  ( void );
wiced_result_t wiced_rtos_deinit( void );
extern void wiced_hwcrypto_init( void );

#ifdef USES_RESOURCE_FILESYSTEM
extern platform_result_t platform_filesystem_init( void );
#endif

static wiced_bool_t wiced_core_initialised = WICED_FALSE;

wiced_result_t wiced_core_init( void )
{
    if ( wiced_core_initialised == WICED_TRUE )
    {
        return WICED_SUCCESS;
    }

    wiced_platform_init( );

    wiced_rtos_init( );

    wiced_dct_init( );

#ifdef USES_RESOURCE_FILESYSTEM
    platform_filesystem_init();
#endif

#if defined(PLATFORM_HAS_HW_CRYPTO_SUPPORT)
    wiced_hwcrypto_init( );
#endif

    wiced_core_initialised = WICED_TRUE;

    WPRINT_APP_INFO( ("WICED_core Initialized\r\n") );
    return WICED_SUCCESS;
}

wiced_result_t wiced_core_deinit( void )
{
    if ( wiced_core_initialised != WICED_TRUE )
    {
        return WICED_SUCCESS;
    }

    wiced_rtos_deinit();

    wiced_core_initialised = WICED_FALSE;

    return WICED_SUCCESS;
}
