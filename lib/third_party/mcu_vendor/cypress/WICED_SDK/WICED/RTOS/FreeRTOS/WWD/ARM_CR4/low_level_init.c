/*
 * $ Copyright Cypress Semiconductor $
 */
#include "FreeRTOS.h"
#include "platform_isr.h"
#include "portmacro.h"
#include "wwd_rtos_isr.h"

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
void irq_vector_external_interrupt( void ) __attribute__((naked));
void irq_vector_software_interrupt( void ) __attribute__((naked));

/******************************************************
 *               Variable Definitions
 ******************************************************/

/******************************************************
 *               Function Definitions
 ******************************************************/

/* Initial entry point for external interrupts */
void irq_vector_external_interrupt( void )
{
    __asm volatile (
        "B    FreeRTOS_IRQ_Handler    \t\n"
    );
}

/* Initial entry point for software interrupts */
void irq_vector_software_interrupt( void )
{
    __asm volatile (
        "B    FreeRTOS_SVC_Handler    \t\n"
    );
}

WWD_RTOS_DEFINE_ISR( platform_tick_isr )
{
    if ( platform_tick_irq_handler( ) )
    {
        FreeRTOS_Tick_Handler( );
    }
}

WWD_RTOS_MAP_ISR( platform_tick_isr, Timer_ISR )
