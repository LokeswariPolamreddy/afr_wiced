/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 * BCM4390x pin mux related definitions and APIs
 */

#ifdef __cplusplus
extern "C"
{
#endif

platform_result_t platform_pinmux_init( platform_pin_t pin, platform_pin_function_t function );
platform_result_t platform_pinmux_deinit( platform_pin_t pin, platform_pin_function_t function );
platform_result_t platform_pinmux_get_function_config( platform_pin_t pin, const platform_pin_internal_config_t **pin_conf_pp, uint32_t *pin_function_index_p );
platform_result_t platform_pinmux_function_get( const platform_pin_internal_config_t *pin_conf, uint32_t *pin_function_index_ptr );
const platform_pin_internal_config_t *platform_pinmux_get_internal_config( platform_pin_t pin );
platform_result_t platform_pinmux_function_deinit( const platform_pin_internal_config_t *pin_conf, uint32_t pin_function_index );
platform_result_t platform_pinmux_function_init( const platform_pin_internal_config_t *pin_conf, uint32_t pin_function_index, platform_pin_config_t config );
platform_result_t platform_chipcommon_gpio_init( const platform_pin_internal_config_t *pin_conf, uint32_t pin_function_index, platform_pin_config_t config );
platform_result_t platform_chipcommon_gpio_deinit( const platform_pin_internal_config_t *pin_conf, uint32_t pin_function_index );

#ifdef __cplusplus
} /* extern "C" */
#endif
