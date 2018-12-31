/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * Defines globally accessible resource functions
 */
#pragma once
#include "platform_config.h"
#include "wiced_resource.h"

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

#ifdef USES_RESOURCE_GENERIC_FILESYSTEM
#include "wiced_filesystem.h"
extern wiced_filesystem_t resource_fs_handle;
#else
#ifdef USES_RESOURCE_FILESYSTEM
#include "wicedfs.h"

extern wicedfs_filesystem_t resource_fs_handle;
#endif /* ifdef USES_RESOURCE_FILESYSTEM */
#endif /* ifdef USES_RESOURCE_GENERIC_FILESYSTEM */

/******************************************************
 *               Function Declarations
 ******************************************************/

/* Resource reading */
extern resource_result_t resource_get_readonly_buffer ( const resource_hnd_t* resource, uint32_t offset, uint32_t maxsize, uint32_t* size_out, const void** buffer );
extern resource_result_t resource_free_readonly_buffer( const resource_hnd_t* handle, const void* buffer );

extern resource_result_t platform_read_external_resource( const resource_hnd_t* resource, uint32_t offset, uint32_t maxsize, uint32_t* size, void* buffer );

#ifdef __cplusplus
} /*extern "C" */
#endif
