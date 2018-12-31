/*
 * $ Copyright Cypress Semiconductor $
 */

/*
 * Defines internal configuration of the BCM94907AEVAL1F board
 */
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/*
 *  OTA Support
 *  NOTE:
 *  1. Only apply when OTA2 is not enabled.
 *  2. Following line must be located ahead of platform_config_bsp_default.h to override PLATFORM_NO_SFLASH_WRITE.
 */
#ifndef OTA2_SUPPORT
#define PLATFORM_HAS_OTA
#endif

/*
 * Below configuration file defines default BSP settings.
 * Put here platform specific configuration parameters to override these default ones.
 */
#include "platform_config_bsp_default.h"

/*
 * Below configuration file defines default WICED settings.
 * To change settings replace below included file with its contents.
 */
#include "platform_config_wiced_default.h"

#ifdef __cplusplus
} /* extern "C" */
#endif

