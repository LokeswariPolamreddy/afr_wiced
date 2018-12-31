/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *
 */
#include <stdint.h>
#include "wwd_constants.h"
#include "wwd_assert.h"
#include "platform_config.h"
#include "wiced_platform.h"
#include "platform/wwd_platform_interface.h"
#include "platform_appscr4.h"
#include "cr4.h"


/******************************************************
 *                      Macros
 ******************************************************/
#ifdef __GNUC__
#define TRIGGER_BREAKPOINT() __asm__("bkpt")
#elif defined ( __IAR_SYSTEMS_ICC__ )
#define TRIGGER_BREAKPOINT() __asm("bkpt 0")
#endif

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
 *               Function Declarations
 ******************************************************/

/******************************************************
 *               Variables Definitions
 ******************************************************/

/******************************************************
 *               Function Definitions
 ******************************************************/

wwd_result_t host_platform_init( void )
{
    wwd_result_t result = WWD_SUCCESS;

#ifdef USES_RESOURCE_FILESYSTEM
    if ( platform_filesystem_init() != PLATFORM_SUCCESS )
    {
        WPRINT_WWD_ERROR(("Host Platform init FAIL\n"));
        result = WWD_RTOS_ERROR;
    }
#endif/* USES_RESOURCE_FILESYSTEM */

    return result;
}

wwd_result_t host_platform_deinit( void )
{
    return WWD_SUCCESS;
}

uint32_t host_platform_get_cycle_count( void )
{
    return cr4_get_cycle_counter( );
}

wwd_result_t host_platform_init_wlan_powersave_clock( void )
{
    return WWD_SUCCESS;
}

wwd_result_t host_platform_deinit_wlan_powersave_clock( void )
{
    return WWD_SUCCESS;
}

wiced_bool_t host_platform_is_in_interrupt_context( void )
{
    uint32_t psr = get_CPSR();
    enum op_mode {USR = 0x10, FIQ = 0x11, IRQ = 0x12, SVC = 0x13, ABT = 0x17, UND = 0x1b, SYS = 0x1f};
    enum op_mode m_bits = psr & 0x1f;

    switch (m_bits)
    {
        case FIQ:
        case IRQ:
        case SVC:
            return WICED_TRUE;

        case USR:
        case ABT:
        case UND:
        case SYS:
        default:
            return WICED_FALSE;
    }
}

void host_platform_reset_wifi( wiced_bool_t reset_asserted )
{
    UNUSED_PARAMETER( reset_asserted );
}
