/*
 * $ Copyright Cypress Semiconductor $
 */

/*
 * Defines WICED-related configuration.
 */
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/*  WICED Resources uses a filesystem */
#define USES_RESOURCE_FILESYSTEM

/* Location on SPI Flash where filesystem starts */
#define FILESYSTEM_BASE_ADDR (0x00010000)

/* The main app is stored in external serial flash */
/* Value for this should be in the platforms/<platform_name>/toplevel.mk */
#ifndef BOOTLOADER_LOAD_MAIN_APP_FROM_EXTERNAL_LOCATION
#define BOOTLOADER_LOAD_MAIN_APP_FROM_EXTERNAL_LOCATION
#endif


/*  DCT is stored in external flash */
#define EXTERNAL_DCT

#ifdef __cplusplus
} /* extern "C" */
#endif

