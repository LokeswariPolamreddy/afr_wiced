/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * Declare functions to manipulate caches
 */
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include "platform_cache_def.h"

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

#ifndef __ASSEMBLER__

#ifndef UNUSED_PARAMETER
#define UNUSED_PARAMETER(x) (void) x
#endif /* UNUSED_PARAMETER */

void platform_icache_inv_all( void );

#ifdef PLATFORM_L1_CACHE_SHIFT

void platform_dcache_enable( void );
void platform_dcache_disable( void );
void platform_dcache_inv_all( void );
void platform_dcache_clean_all( void );
void platform_dcache_clean_and_inv_all( void );
void platform_dcache_inv_range( volatile void *p, uint32_t length );
void platform_dcache_clean_range( const volatile void *p, uint32_t length );
void platform_dcache_clean_and_inv_range( const volatile void *p, uint32_t length );
void platform_icache_inv_range( volatile void *p, uint32_t length );

#else

#define platform_dcache_enable()                  do {                                         } while(0)
#define platform_dcache_disable()                 do {                                         } while(0)
#define platform_dcache_inv_all()                 do {                                         } while(0)
#define platform_dcache_clean_all()               do {                                         } while(0)
#define platform_dcache_clean_and_inv_all()       do {                                         } while(0)
#define platform_dcache_inv_range(p, l)           do {UNUSED_PARAMETER(p); UNUSED_PARAMETER(l);} while(0)
#define platform_dcache_clean_range(p, l)         do {UNUSED_PARAMETER(p); UNUSED_PARAMETER(l);} while(0)
#define platform_dcache_clean_and_inv_range(p, l) do {UNUSED_PARAMETER(p); UNUSED_PARAMETER(l);} while(0)
#define platform_icache_inv_range(p, l)           do {UNUSED_PARAMETER(p); UNUSED_PARAMETER(l);} while(0)
#endif /* PLATFORM_L1_CACHE_SHIFT */

#endif /* __ASSEMBLER__ */

#ifdef __cplusplus
} /*extern "C" */
#endif
