/*
 * Amazon FreeRTOS PKCS #11 PAL V1.0.0
 * Copyright (C) 2018 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://aws.amazon.com/freertos
 * http://www.FreeRTOS.org
 */

/**
 * @file aws_pkcs11_pal.c
 * @brief Device specific helpers for PKCS11 Interface.
 */

/* Amazon FreeRTOS Includes. */
#include "aws_pkcs11.h"
#include "FreeRTOS.h"

/* C runtime includes. */
#include <stdio.h>
#include <string.h>

#include "wiced_result.h"
#include "wiced.h"

#define pkcs11palFILE_NAME_CLIENT_CERTIFICATE    "FreeRTOS_P11_Certificate.dat"
#define pkcs11palFILE_NAME_KEY                   "FreeRTOS_P11_Key.dat"
#define pkcs11palFILE_CODE_SIGN_PUBLIC_KEY       "FreeRTOS_P11_CodeSignKey.dat"

enum eObjectHandles
{
    eInvalidHandle = 0, /* According to PKCS #11 spec, 0 is never a valid object handle. */
    eAwsDevicePrivateKey = 1,
    eAwsDevicePublicKey,
    eAwsDeviceCertificate,
    eAwsCodeSigningKey
};

int wiced_crypto_random_ecc ( unsigned char *output, size_t len )
{
    size_t use_len;
    int rnd;

    while( len > 0 )
    {
        use_len = len;
        if( use_len > sizeof(int) )
            use_len = sizeof(int);

        rnd = rand();
        memcpy( output, &rnd, use_len );
        output += use_len;
        len -= use_len;
    }
    return 0;
}

/* Converts a label to its respective filename and handle. */
void prvLabelToFilenameHandle( uint8_t * pcLabel,
                               char ** pcFileName,
                               CK_OBJECT_HANDLE_PTR pHandle )
{
    if( pcLabel != NULL )
    {
        /* Translate from the PKCS#11 label to local storage file name. */
        if( 0 == memcmp( pcLabel,
                         &pkcs11configLABEL_DEVICE_CERTIFICATE_FOR_TLS,
                         sizeof( pkcs11configLABEL_DEVICE_CERTIFICATE_FOR_TLS ) ) )
        {
            *pcFileName = pkcs11palFILE_NAME_CLIENT_CERTIFICATE;
            *pHandle = eAwsDeviceCertificate;
        }
        else if( 0 == memcmp( pcLabel,
                              &pkcs11configLABEL_DEVICE_PRIVATE_KEY_FOR_TLS,
                              sizeof( pkcs11configLABEL_DEVICE_PRIVATE_KEY_FOR_TLS ) ) )
        {
            *pcFileName = pkcs11palFILE_NAME_KEY;
            *pHandle = eAwsDevicePrivateKey;
        }
        else if( 0 == memcmp( pcLabel,
                              &pkcs11configLABEL_DEVICE_PUBLIC_KEY_FOR_TLS,
                              sizeof( pkcs11configLABEL_DEVICE_PUBLIC_KEY_FOR_TLS ) ) )
        {
            *pcFileName = pkcs11palFILE_NAME_KEY;
            *pHandle = eAwsDevicePublicKey;
        }
        else if( 0 == memcmp( pcLabel,
                              &pkcs11configLABEL_CODE_VERIFICATION_KEY,
                              sizeof( pkcs11configLABEL_CODE_VERIFICATION_KEY ) ) )
        {
            *pcFileName = pkcs11palFILE_CODE_SIGN_PUBLIC_KEY;
            *pHandle = eAwsCodeSigningKey;
        }
        else
        {
            *pcFileName = NULL;
            *pHandle = eInvalidHandle;
        }
    }
}

/**
* @brief Writes a file to local storage.
*
* Port-specific file write for crytographic information.
*
* @param[in] pxLabel       Label of the object to be saved.
* @param[in] pucData       Data buffer to be written to file
* @param[in] ulDataSize    Size (in bytes) of data to be saved.
*
* @return The file handle of the object that was stored.
*/
CK_OBJECT_HANDLE PKCS11_PAL_SaveObject( CK_ATTRIBUTE_PTR pxLabel,
    uint8_t * pucData,
    uint32_t ulDataSize )
{
    wiced_result_t result = WICED_SUCCESS;
    CK_OBJECT_HANDLE xHandle = eInvalidHandle;
    char * pcFileName = NULL;

    /* Translate from the PKCS#11 label to local storage file name. */
    prvLabelToFilenameHandle( pxLabel->pValue, &pcFileName, &xHandle );
    if( xHandle != eInvalidHandle )
    {
        if( strcmp( pcFileName, pkcs11palFILE_NAME_CLIENT_CERTIFICATE ) == 0 )
        {
            result = wiced_dct_write( (const void*) &ulDataSize, DCT_APP_SECTION, 0, 4 );
            if ( result != WICED_SUCCESS)
            {
                printf("wiced_dct_write failed for client certificate length %d \n", result );
            }
            wiced_dct_write( (const void*) pucData, DCT_APP_SECTION, 12, ulDataSize );
            if ( result != WICED_SUCCESS)
            {
                printf("wiced_dct_write failed for client certificate %d \n", result );
            }

        }
        else if( strcmp( pcFileName, pkcs11palFILE_NAME_KEY ) == 0 )
        {
            result = wiced_dct_write( (const void*) &ulDataSize, DCT_APP_SECTION, 4, 4 );
            if ( result != WICED_SUCCESS)
            {
                printf("wiced_dct_write failed for client key length %d \n", result );
            }
            result = wiced_dct_write( (const void*) pucData, DCT_APP_SECTION, 12 + 2048, ulDataSize );
            if ( result != WICED_SUCCESS)
            {
                printf("wiced_dct_write failed for client key %d \n", result );
            }
        }
        else if( strcmp( pcFileName, pkcs11palFILE_CODE_SIGN_PUBLIC_KEY ) == 0 )
        {
            result = wiced_dct_write( (const void*) &ulDataSize, DCT_APP_SECTION, 8, 4 );
            if ( result != WICED_SUCCESS)
            {
                printf("wiced_dct_write failed for client key length %d \n", result );
            }
            result = wiced_dct_write( (const void*) pucData, DCT_APP_SECTION, 12 + 4096, ulDataSize );
            if ( result != WICED_SUCCESS)
            {
                printf("wiced_dct_write failed for client key %d \n", result );
            }
        }
        if( result != WICED_SUCCESS )
        {
            xHandle = eInvalidHandle;
        }
    }

    return xHandle;
}

/**
* @brief Translates a PKCS #11 label into an object handle.
*
* Port-specific object handle retrieval.
*
*
* @param[in] pLabel         Pointer to the label of the object
*                           who's handle should be found.
* @param[in] usLength       The length of the label, in bytes.
*
* @return The object handle if operation was successful.
* Returns eInvalidHandle if unsuccessful.
*/
CK_OBJECT_HANDLE PKCS11_PAL_FindObject( uint8_t * pLabel,
    uint8_t usLength )
{
    CK_OBJECT_HANDLE xHandle = eInvalidHandle;
    char * pcFileName = NULL;

    /* Translate from the PKCS#11 label to local storage file name. */
    prvLabelToFilenameHandle( pLabel, &pcFileName, &xHandle );

    return xHandle;
}

/**
 * @brief Gets the value of an object in storage, by handle.
 *
 * Port-specific file access for cryptographic information.
 *
 * This call dynamically allocates the buffer which object value
 * data is copied into.  PKCS11_PAL_GetObjectValueCleanup()
 * should be called after each use to free the dynamically allocated
 * buffer.
 *
 * @sa PKCS11_PAL_GetObjectValueCleanup
 *
 * @param[in] pcFileName    The name of the file to be read.
 * @param[out] ppucData     Pointer to buffer for file data.
 * @param[out] pulDataSize  Size (in bytes) of data located in file.
 * @param[out] pIsPrivate   Boolean indicating if value is private (CK_TRUE)
 *                          or exportable (CK_FALSE)
 *
 * @return CKR_OK if operation was successful.  CKR_KEY_HANDLE_INVALID if
 * no such object handle was found, CKR_DEVICE_MEMORY if memory for
 * buffer could not be allocated, CKR_FUNCTION_FAILED for device driver
 * error.
 */
CK_RV PKCS11_PAL_GetObjectValue( CK_OBJECT_HANDLE xHandle,
    uint8_t ** ppucData,
    uint32_t * pulDataSize,
    CK_BBOOL * pIsPrivate )
{
    uint32_t len=0;
    wiced_result_t result = WICED_SUCCESS;
    char * pcFileName = NULL;
    CK_RV ulReturn = CKR_OK;

    if( xHandle == eAwsDeviceCertificate )
    {
        pcFileName = pkcs11palFILE_NAME_CLIENT_CERTIFICATE;
        *pIsPrivate = CK_FALSE;
    }
    else if( xHandle == eAwsDevicePrivateKey )
    {
        pcFileName = pkcs11palFILE_NAME_KEY;
        *pIsPrivate = CK_TRUE;
    }
    else if( xHandle == eAwsDevicePublicKey )
    {
        /* Public and private key are stored together in same file. */
        pcFileName = pkcs11palFILE_NAME_KEY;
        *pIsPrivate = CK_FALSE;
    }
    else if( xHandle == eAwsCodeSigningKey )
    {
        pcFileName = pkcs11palFILE_CODE_SIGN_PUBLIC_KEY;
        *pIsPrivate = CK_FALSE;
    }
    else
    {
        return CKR_KEY_HANDLE_INVALID;
    }

    if( strcmp( pcFileName, pkcs11palFILE_NAME_CLIENT_CERTIFICATE ) == 0 )
    {
        result = wiced_dct_read_with_copy( (void*) &len, DCT_APP_SECTION, 0, 4 );
        if ( result != WICED_SUCCESS)
        {
            printf("wiced_dct_read_with_copy failed for client certificate length %d \n", result );
        }
        result = wiced_dct_read_lock( (void**) ppucData, WICED_TRUE, DCT_APP_SECTION, 12, len );
        if ( result != WICED_SUCCESS)
        {
            printf("wiced_dct_read_lock failed for client certificate %d \n", result );
        }
    }
    else if( strcmp( pcFileName, pkcs11palFILE_NAME_KEY ) == 0 )
    {
        result = wiced_dct_read_with_copy( (void*) &len, DCT_APP_SECTION, 4, 4 );
        if ( result != WICED_SUCCESS)
        {
            printf("wiced_dct_read_with_copy failed for client key length %d \n", result );
        }
        result = wiced_dct_read_lock( (void**) ppucData, WICED_TRUE, DCT_APP_SECTION, 12 + 2048, len );
        if ( result != WICED_SUCCESS)
        {
            printf("wiced_dct_read_lock failed for client certificate %d \n", result );
        }
    }
    else if( strcmp( pcFileName, pkcs11palFILE_CODE_SIGN_PUBLIC_KEY ) == 0 )
    {
        result = wiced_dct_read_with_copy( (void*) &len, DCT_APP_SECTION, 8, 4 );
        if ( result != WICED_SUCCESS)
        {
            printf("wiced_dct_read_with_copy failed for client key length %d \n", result );
        }
        result = wiced_dct_read_lock( (void**) ppucData, WICED_TRUE, DCT_APP_SECTION, 12 + 4096, len );
        if ( result != WICED_SUCCESS)
        {
            printf("wiced_dct_read_lock failed for client certificate %d \n", result );
        }
    }
    *pulDataSize = len;

    if( ( result != WICED_SUCCESS ) || ( len == 0 ) )
    {
        ulReturn = CKR_FUNCTION_FAILED;
    }
    return ulReturn;
}

/**
* @brief Cleanup after PKCS11_GetObjectValue().
*
* @param[in] pucData       The buffer to free.
*                          (*ppucData from PKCS11_PAL_GetObjectValue())
* @param[in] ulDataSize    The length of the buffer to free.
*                          (*pulDataSize from PKCS11_PAL_GetObjectValue())
*/
void PKCS11_PAL_GetObjectValueCleanup( uint8_t * pucData,
    uint32_t ulDataSize )
{
    if( NULL != pucData )
    {
        wiced_dct_read_unlock( pucData, WICED_TRUE );
    }
}

/*-----------------------------------------------------------*/

int mbedtls_hardware_poll( void * data,
                           unsigned char * output,
                           size_t len,
                           size_t * olen )
{
    wiced_crypto_random_ecc( output, len);
    *olen = len;
    return 0;
}
