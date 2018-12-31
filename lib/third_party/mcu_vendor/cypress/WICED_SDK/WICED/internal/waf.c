/*
 * $ Copyright Cypress Semiconductor $
 */

#include <string.h>
#include "platform_config.h" /* Needed for EXTERNAL_DCT */
#include "wiced_framework.h"
#include "wiced_dct_common.h"
#include "wiced_utilities.h"

#include "wiced_rtos.h"
#include "wwd_assert.h"

/** @file
 *
 */

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

/******************************************************
 *               Function Definitions
 ******************************************************/

#if !defined(BOOTLOADER)
wiced_mutex_t   wiced_dct_mutex;
wiced_bool_t    wiced_dct_mutex_inited;
wiced_result_t wiced_dct_init( void )
{
    wiced_result_t result = WICED_SUCCESS;

    if (wiced_dct_mutex_inited == WICED_FALSE)
    {
        result = wiced_rtos_init_mutex( &wiced_dct_mutex );
        wiced_assert( "Init DCT Mutex failed", (result == WICED_SUCCESS) );
        if (result == WICED_SUCCESS)
        {
            wiced_dct_mutex_inited = WICED_TRUE;
        }
    }
    return result;
}
#endif

/*
 * NOTE: The read of the DCT is locked so that the data does not change during the read itself.
 *       The DCT is *not* left in a locked state.
 */
wiced_result_t wiced_dct_read_lock( void** info_ptr, wiced_bool_t ptr_is_writable, dct_section_t section, uint32_t offset, uint32_t size )
{
#ifdef EXTERNAL_DCT

    UNUSED_PARAMETER( ptr_is_writable );

    *info_ptr = malloc_named( "DCT", size );
    return wiced_dct_read_with_copy( *info_ptr, section, offset, size);
#else /* ifdef EXTERNAL_DCT */
    if ( ptr_is_writable == WICED_TRUE )
    {
        *info_ptr = (void*)malloc_named( "DCT", size );
        if ( *info_ptr == NULL )
        {
            return WICED_ERROR;
        }
        wiced_dct_read_with_copy( *info_ptr, section, offset, size );
    }
    else
    {
        *info_ptr = (char*)wiced_dct_get_current_address( section ) + offset;
    }
    return WICED_SUCCESS;
#endif /* ifdef EXTERNAL_DCT */
}

wiced_result_t wiced_dct_read_unlock( void* info_ptr, wiced_bool_t ptr_is_writable )
{
#ifdef EXTERNAL_DCT

    UNUSED_PARAMETER( ptr_is_writable );

    free( info_ptr );
#else
    if ( ptr_is_writable == WICED_TRUE )
    {
        free( info_ptr );
    }
#endif /* ifdef EXTERNAL_DCT */
    return WICED_SUCCESS;
}
