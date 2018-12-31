/*
* $ Copyright Cypress Semiconductor $
*/

#include <FreeRTOS.h>
#include <task.h>
#include "platform_sleep.h"

extern void vPortSuppressTicksAndSleep( TickType_t xExpectedIdleTime );

void vPortSuppressTicksAndSleep( TickType_t xExpectedIdleTime )
{
    UBaseType_t adjust_ticks = 0;

    if( platform_power_down_permission() )
    {
        portENTER_CRITICAL();
        {
            adjust_ticks = platform_power_down_hook( xExpectedIdleTime );

            vTaskStepTick( adjust_ticks );
        }
        portEXIT_CRITICAL();
    }
}
