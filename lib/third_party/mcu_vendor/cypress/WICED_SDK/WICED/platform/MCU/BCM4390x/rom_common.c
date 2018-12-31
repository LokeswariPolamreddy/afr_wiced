/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * BCM43909 ROM common
 */

#include "platform_assert.h"

/******************************************************
 *               Function Declarations
 ******************************************************/

void ramfnstub_unimplemented_handler(void);

/******************************************************
 *               Function Definitions
 ******************************************************/

void ramfnstub_unimplemented_handler(void)
{
    /* This means that a ROM function was called, which in turn
     * called a RAM stub function for which no implementation
     * was provided.  This should never happen.
     */
    WICED_TRIGGER_BREAKPOINT();

    while (1)
    {
        /* Loop forever */
    }
}
