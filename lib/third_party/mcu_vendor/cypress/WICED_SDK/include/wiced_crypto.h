/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *  Define cryptographic functions
 */

#pragma once

#include <stdint.h>
#include "wiced_result.h"

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************
 *                 Type Definitions
 ******************************************************/

typedef uint32_t (*wiced_crypto_prng_get_random_t)( void );
typedef void     (*wiced_crypto_prng_add_entropy_t)( const void* buffer, uint16_t buffer_length );

/******************************************************
 *                    Structures
 ******************************************************/

typedef struct
{
    wiced_crypto_prng_get_random_t  get_random;
    wiced_crypto_prng_add_entropy_t add_entropy;
} wiced_crypto_prng_t;

/******************************************************
 *               Function Declarations
 ******************************************************/

/**
 * Gets a 16 bit random numbers.
 *
 * Allows user applications to retrieve 16 bit random numbers.
 * If cryptographic security for rand numbers is required, call wiced_crypto_use_secure_prng first
 * @param buffer : pointer to the buffer which will receive the
 *                 generated random data
 * @param buffer_length : size of the buffer
 *
 * @return WICED_SUCCESS or Error code
 */
extern wiced_result_t wiced_crypto_get_random( void* buffer, uint16_t buffer_length );

/**
 * Feed entropy into random number generator.
 *
 * @param buffer : pointer to the buffer which contains random data
 * @param buffer_length : size of the buffer
 *
 * @return WICED_SUCCESS or Error code
 */
extern wiced_result_t wiced_crypto_add_entropy( const void* buffer, uint16_t buffer_length );

/**
 * Set new PRNG implementation.
 *
 * @param prng : pointer to PRNG implementation, if NULL then default (Well512) would be used
 *
 * @return WICED_SUCCESS or Error code
 */
extern wiced_result_t wiced_crypto_set_prng( wiced_crypto_prng_t* prng );

/**
 * Use default PRNG (currently Well512).  This is not a cryptographically secure PRNG.
 * Advantage is, relatively small memory requirements.
 * @return WICED_SUCCESS
 */
extern wiced_result_t wiced_crypto_use_default_prng( void );

#ifdef WICED_SECURE_PRNG_FORTUNA_ENABLE
/**
 * Use cryptographically secure PRNG  (currently Fortuna).  This uses ~5k heap while enabled.
 * The default PRNG (Well512) will be used as the initial source of starting entropy (seed).
 * See apps/test/entropy for more details on usage.
 * @return WICED_SUCCESS if successfully enabled
 */
extern wiced_result_t wiced_crypto_use_secure_prng( void );
#endif /* WICED_SECURE_PRNG_FORTUNA_ENABLE */

/**
 * Use the parameter to seed the default pseudo-random number generator (PRNG) from a low variability source.
 * Examples of this type of entropy are cycles taken to complete a function.
 * Note this type of seeding is usually most effective if the secure PRNG is compiled in.
 * (See wiced_crypto_use_secure_prng for more info.)
 * @param entropy : variable holding a value with some small amount of variability that can be used as an initial seed
 *                          Example: number of cycles to complete functions accessing hardware
 * @return WICED_SUCCESS or Error code
 */
extern void wiced_crypto_prng_add_low_variability_entropy( uint32_t entropy );

#ifdef __cplusplus
} /*extern "C" */
#endif
