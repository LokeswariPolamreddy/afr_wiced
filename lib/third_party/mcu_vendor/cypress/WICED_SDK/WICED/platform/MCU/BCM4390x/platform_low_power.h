/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *  Sleep support functions.
 *
 */

#pragma once

#include <stdint.h>
#include "platform_config.h"
#include "platform_map.h"
#include "platform_mcu_peripheral.h"

#ifdef __cplusplus
extern "C"
{
#endif

/******************************************************
 *             Macros
 ******************************************************/

#ifndef PLATFORM_LOW_POWER_HEADER_INCLUDED
#error "Platform header file must not be included directly, Please use wiced_low_power.h instead."
#endif

#define WICED_SLEEP_STR_EXPAND( name )                      #name

#define WICED_DEEP_SLEEP_SECTION_NAME_SAVED_VAR( name )     ".deep_sleep_saved_vars."WICED_SLEEP_STR_EXPAND( name )

#define WICED_DEEP_SLEEP_IS_WARMBOOT( ) \
    platform_mcu_powersave_is_warmboot( )

#if PLATFORM_APPS_POWERSAVE

#define WICED_DEEP_SLEEP_SAVED_VAR( var ) \
    SECTION( WICED_DEEP_SLEEP_SECTION_NAME_SAVED_VAR( var ) ) var

#define WICED_DEEP_SLEEP_IS_ENABLED( )                           1

#endif /* PLATFORM_APPS_POWERSAVE */

#define WICED_DEEP_SLEEP_IS_AON_SEGMENT( segment_addr, segment_size ) \
    ( ( (segment_addr) >= PLATFORM_SOCSRAM_CH0_AON_RAM_BASE(0x0)) && ( (segment_addr) + (segment_size) <= PLATFORM_SOCSRAM_CH0_AON_RAM_BASE(PLATFORM_SOCSRAM_AON_RAM_SIZE) ) )

/******************************************************
 *             Constants
 ******************************************************/

/******************************************************
 *             Enumerations
 ******************************************************/

/******************************************************
 *             Structures
 ******************************************************/

typedef struct
{
    uint32_t entry_point;
    uint32_t app_address;
} wiced_deep_sleep_tiny_bootloader_config_t;

/******************************************************
 *             Variables
 ******************************************************/

/******************************************************
 *             Function declarations
 ******************************************************/

#ifdef __cplusplus
} /* extern "C" */
#endif
