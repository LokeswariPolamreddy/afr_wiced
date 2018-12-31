/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *
 */

#include "wiced_low_power.h"
#include "wiced_utilities.h"
#include "wiced_rtos.h"

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
 *               Function Declarations
 ******************************************************/

/******************************************************
 *               Variable Definitions
 ******************************************************/

/******************************************************
 *               Function Definitions
 ******************************************************/
#if WICED_ENABLE_LOW_POWER_EVENT_HANDLERS
void wiced_sleep_call_event_handlers( wiced_sleep_event_type_t event )
{
    wiced_sleep_event_registration_t* p;

    for ( p = &link_sleep_event_registrations_location; p < &link_sleep_event_registrations_end; ++p )
    {
        if ( p->handler )
        {
            ( *p->handler )( event );
        }
    }
}
#endif
