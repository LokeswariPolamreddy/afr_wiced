/*
 * $ Copyright Cypress Semiconductor $
 */
#pragma once

#include "stdint.h"
#include "string.h"
#include "platform_config.h"
#include "platform_peripheral.h"
#include "wwd_rtos.h"
#include "wwd_assert.h"
#include "RTOS/wwd_rtos_interface.h"
#include "platform_cache_def.h"

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************
 *                   Constants
 ******************************************************/

/******************************************************
 *                    Macros
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

/* STDIO UART function */
void platform_stdio_write( const char* str, uint32_t len );
void platform_stdio_read ( char* str, uint32_t len );
void platform_stdio_exception_write( const char* str, uint32_t len );

#ifdef __cplusplus
} /* extern "C" */
#endif

