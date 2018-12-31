/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * Declares interrupt handlers prototype for BCM4309x
 */

#pragma once

#ifdef __cplusplus
extern "C"
{
#endif

/******************************************************
 *                      Macros
 ******************************************************/

#define IRQN2MASK(n) ((uint32_t)1 << (n))

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
 *                 Global Variables
 ******************************************************/

/******************************************************
 *               Function Declarations
 ******************************************************/

extern void ChipCommon_ISR      ( void ); // ChipCommon core
extern void Timer_ISR           ( void ); // Timer (system ticks)
extern void Sw0_ISR             ( void ); // software triggered (1)
extern void Sw1_ISR             ( void ); // software triggered (2)
extern void GMAC_ISR            ( void ); // GMAC (ethernet)
extern void Serror_ISR          ( void ); // bus error
extern void M2M_ISR             ( void ); // Memory to Memory DMA
extern void I2S0_ISR            ( void ); // I2S0
extern void I2S1_ISR            ( void ); // I2S1
extern void USB_HOST_ISR        ( void ); // USB HOST
extern void SDIO_HOST_ISR       ( void ); // SDIO HOST
extern void GSPI_SLAVE_ISR      ( void ); // GSPI slave

extern void Unhandled_ISR       ( void ); // Stub called when no handler defined

#ifdef __cplusplus
} /* extern "C" */
#endif

