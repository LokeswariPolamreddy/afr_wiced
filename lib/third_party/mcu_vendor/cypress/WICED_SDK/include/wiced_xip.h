/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * Header file for XIP
 */

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************
 *            Macros
 ******************************************************/

#ifdef APPLICATION_XIP_ENABLE
/*
 * Read-only data/instructions are placed in sflash by default with XIP enabled
 * except for data referred by sflash driver and sflash driver itself.
 * Assigning ro-data/instructions into RAM can be done by using these macros.
 *  */

/* Read-only data section
 * For example, declare a variable with the macro :
 *  const int WICED_XIP_RAM_RO_DATA(xip_data) = 100;
 * */
#define WICED_XIP_RAM_SECTION_RO_DATA( _rodata )     ".ram_rodata."#_rodata

#define WICED_XIP_RAM_RO_DATA( _rodata ) \
        SECTION( WICED_XIP_RAM_SECTION_RO_DATA( _rodata ) ) _rodata

/* Instruction section
 *
 * For example, define a function with the macro :
 * void WICED_XIP_RAM_FUNC( foo ) ( int arg1 , int arg2) {
 *                 .................
 * }
 *  */
#define WICED_XIP_RAM_SECTION_FUNC( _func )     ".ram_function."#_func

#define WICED_XIP_RAM_FUNC( _func ) \
        NEVER_INLINE SECTION( WICED_XIP_RAM_SECTION_FUNC( _func ) ) _func
#else
#define WICED_XIP_RAM_RO_DATA( _rodata )            _rodata
#define WICED_XIP_RAM_FUNC( _func )                 _func
#endif /* APPLICATION_XIP_ENABLE */

/******************************************************
 *            Enumerations
 ******************************************************/

/******************************************************
 *            Structures
 ******************************************************/

/******************************************************
 *            Function Declarations
 ******************************************************/

#ifdef __cplusplus
} /*extern "C" */
#endif
