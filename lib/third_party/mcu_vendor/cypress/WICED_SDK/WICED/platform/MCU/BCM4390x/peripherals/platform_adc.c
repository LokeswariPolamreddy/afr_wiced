/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *
 */
#include "platform_peripheral.h"
#include "wwd_assert.h"
#ifdef USING_EXTERNAL_ADC
#include "MAX11615.h"
#endif /* USING_EXTERNAL_ADC */

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

typedef platform_result_t (*adc_init_func_t)                     ( const platform_adc_t* i2c, uint32_t config );
typedef platform_result_t (*adc_deinit_func_t)                   ( const platform_adc_t* i2c );
typedef platform_result_t (*adc_take_sample_func_t)              ( const platform_adc_t *i2c, uint16_t *output );
typedef platform_result_t (*adc_take_sample_stream_func_t)       ( const platform_adc_t *i2c, void *buffer, uint16_t buffer_length );

/******************************************************
 *                    Structures
 ******************************************************/

struct adc_driver
{
    adc_init_func_t init;
    adc_deinit_func_t deinit;
    adc_take_sample_func_t take_sample;
    adc_take_sample_stream_func_t take_sample_stream;
};

/******************************************************
 *               Static Function Declarations
 ******************************************************/

static platform_result_t adc_init( const platform_adc_t* adc, uint32_t sample_cycle );
static platform_result_t adc_deinit( const platform_adc_t* adc );
static platform_result_t adc_take_sample( const platform_adc_t* adc, uint16_t* output );
static platform_result_t adc_take_sample_stream( const platform_adc_t* adc, void* buffer, uint16_t buffer_length );

/******************************************************
 *               Variable Definitions
 ******************************************************/

const adc_driver_t internal_adc_driver =
{
    .init = adc_init,
    .deinit = adc_deinit,
    .take_sample = adc_take_sample,
    .take_sample_stream = adc_take_sample_stream,
};

#ifdef USING_EXTERNAL_ADC
const adc_driver_t max11615_adc_driver =
{
    .init = max11615_init,
    .deinit = max11615_deinit,
    .take_sample = max11615_take_sample,
    .take_sample_stream = max11615_take_sample_stream,
};
#endif /* USING_EXTERNAL_ADC */

/******************************************************
 *               Function Definitions
 ******************************************************/

platform_result_t platform_adc_init( const platform_adc_t* adc, uint32_t sample_cycle )
{
    return adc->driver->init( adc, sample_cycle );
}

platform_result_t platform_adc_deinit( const platform_adc_t* adc )
{
    return adc->driver->deinit( adc );
}

platform_result_t platform_adc_take_sample( const platform_adc_t* adc, uint16_t* output )
{
    return adc->driver->take_sample( adc, output );
}

platform_result_t platform_adc_take_sample_stream( const platform_adc_t* adc, void* buffer, uint16_t buffer_length )
{
    return adc->driver->take_sample_stream( adc, buffer, buffer_length );
}

platform_result_t adc_init( const platform_adc_t* adc, uint32_t sample_cycle )
{
    UNUSED_PARAMETER( adc );
    UNUSED_PARAMETER( sample_cycle );
    return PLATFORM_UNSUPPORTED;
}

platform_result_t adc_deinit( const platform_adc_t* adc )
{
    UNUSED_PARAMETER( adc );
    return PLATFORM_UNSUPPORTED;
}

platform_result_t adc_take_sample( const platform_adc_t* adc, uint16_t* output )
{
    UNUSED_PARAMETER( adc );
    wiced_assert( "output is NULL", output != NULL );
    *output = 0;
    return PLATFORM_UNSUPPORTED;
}

platform_result_t adc_take_sample_stream( const platform_adc_t* adc, void* buffer, uint16_t buffer_length )
{
    UNUSED_PARAMETER( adc );
    UNUSED_PARAMETER( buffer );
    UNUSED_PARAMETER( buffer_length );
    return PLATFORM_UNSUPPORTED;
}
