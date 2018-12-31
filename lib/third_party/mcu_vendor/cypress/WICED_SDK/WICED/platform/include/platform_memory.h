/*
 * $ Copyright Cypress Semiconductor $
 */
/** @file
 * Defines functions to get platform allocated TX and RX Pools
 */
#pragma once

#include "wiced_result.h"

#ifdef __cplusplus
extern "C" {
#endif

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
 *                 Global Variables
 ******************************************************/

/******************************************************
 *               Function Declarations
 ******************************************************/
/**
 * Get TX Buffer Pool from Platform
 *
 * @param[in]  size_requested : tx buffer pool size requested
 *
 * @return 4-byte aligned pointer to allocated memory pool or NULL, in case of memory unavailable
 */
uint8_t* platform_get_tx_buffer_pool(uint32_t size_requested);

/**
 * Get RX Buffer Pool from Platform
 *
 * @param[in]  size_requested : rx buffer pool size requested
 *
 * @return 4-byte aligned pointer to allocated memory pool or NULL, in case of memory unavailable
 */
uint8_t* platform_get_rx_buffer_pool(uint32_t size_requested);

#ifdef __cplusplus
} /* extern "C" */
#endif
