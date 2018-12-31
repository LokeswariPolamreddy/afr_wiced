/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * Defines globally accessible serial flash DCT functions
 */
#pragma once
#include "platform_constants.h"
#include "spi_flash.h"

#ifdef __cplusplus
extern "C" {
#endif

extern platform_result_t platform_get_sflash_dct_loc( sflash_handle_t* sflash_handle, uint32_t* loc );

#ifdef __cplusplus
} /* extern "C" */
#endif
