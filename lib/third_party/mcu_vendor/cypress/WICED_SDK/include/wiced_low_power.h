/*
 * $ Copyright Cypress Semiconductor $
 */
#pragma once

#include <stdint.h>
#include "platform_toolchain.h"
#include "wwd_constants.h"
#include "wiced_constants.h"
#include "wiced_result.h"
#include "platform_config.h"

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************
 *                    Callback types
 ******************************************************/

typedef enum
{
    WICED_SLEEP_EVENT_ENTER,
    WICED_SLEEP_EVENT_CANCEL,
    WICED_SLEEP_EVENT_LEAVE,
    WICED_SLEEP_EVENT_WLAN_RESUME
} wiced_sleep_event_type_t;

typedef void( *wiced_sleep_event_handler_t )( wiced_sleep_event_type_t event );

/******************************************************
 *                 Platform definitions
 ******************************************************/

#define PLATFORM_LOW_POWER_HEADER_INCLUDED
#include "platform_low_power.h"

/******************************************************
 *                      Macros
 ******************************************************/

typedef struct
{
    wiced_sleep_event_handler_t handler;
} wiced_sleep_event_registration_t;

#ifndef WICED_ENABLE_LOW_POWER_EVENT_HANDLERS
#if !defined(WICED_DISABLE_MCU_POWERSAVE) && defined(PLATFORM_SUPPORTS_LOW_POWER_MODES) && !defined(__IAR_SYSTEMS_ICC__)
#define WICED_ENABLE_LOW_POWER_EVENT_HANDLERS 1
#else
#define WICED_ENABLE_LOW_POWER_EVENT_HANDLERS 0
#endif /* !defined(WICED_DISABLE_MCU_POWERSAVE) && defined(PLATFORM_SUPPORTS_LOW_POWER_MODES) */
#endif /* WICED_ENABLE_LOW_POWER_EVENT_HANDLERS */

#if WICED_ENABLE_LOW_POWER_EVENT_HANDLERS

#ifndef WICED_SLEEP_STR_EXPAND
#define WICED_SLEEP_STR_EXPAND( name )                      #name
#endif

#ifndef WICED_SLEEP_SECTION_NAME_EVENT_HANDLER
#define WICED_SLEEP_SECTION_NAME_EVENT_HANDLER( name )      ".sleep_event_handlers."WICED_SLEEP_STR_EXPAND( name )
#endif

#ifndef WICED_SLEEP_SECTION_NAME_EVENT_REGISTRATION
#define WICED_SLEEP_SECTION_NAME_EVENT_REGISTRATION( name ) ".sleep_event_registrations."WICED_SLEEP_STR_EXPAND( name )
#endif

#ifndef WICED_SLEEP_EVENT_HANDLER
#define WICED_SLEEP_EVENT_HANDLER( func_name ) \
    static void SECTION( WICED_SLEEP_SECTION_NAME_EVENT_HANDLER( func_name ) ) func_name( wiced_sleep_event_type_t event ); \
    const wiced_sleep_event_registration_t SECTION( WICED_SLEEP_SECTION_NAME_EVENT_REGISTRATION( func_name ) ) func_name##_registration = { .handler = &func_name }; \
    static void MAY_BE_UNUSED func_name( wiced_sleep_event_type_t event )
#endif

void SECTION( WICED_SLEEP_SECTION_NAME_EVENT_HANDLER( wiced_sleep_call_event_handlers ) ) wiced_sleep_call_event_handlers( wiced_sleep_event_type_t event );

#ifndef WICED_SLEEP_CALL_EVENT_HANDLERS
#define WICED_SLEEP_CALL_EVENT_HANDLERS( cond, event ) \
    do { if ( cond ) wiced_sleep_call_event_handlers( event ); } while( 0 )
#endif


extern wiced_sleep_event_registration_t link_sleep_event_registrations_location;
extern wiced_sleep_event_registration_t link_sleep_event_registrations_end;



#endif /* WICED_ENABLE_LOW_POWER_EVENT_HANDLERS */

#ifndef WICED_DEEP_SLEEP_SAVED_VAR
#define WICED_DEEP_SLEEP_SAVED_VAR( var )                                               var
#endif

#ifndef WICED_SLEEP_EVENT_HANDLER
#ifdef  __IAR_SYSTEMS_ICC__
#define IAR_ROOT_FUNC __root
#else
#define IAR_ROOT_FUNC
#endif /* __IAR_SYSTEMS_ICC__ */
#define WICED_SLEEP_EVENT_HANDLER( func_name ) \
    static IAR_ROOT_FUNC void MAY_BE_UNUSED func_name( wiced_sleep_event_type_t event )
#endif /* ifndef WICED_SLEEP_EVENT_HANDLER */

#ifndef WICED_SLEEP_CALL_EVENT_HANDLERS
#define WICED_SLEEP_CALL_EVENT_HANDLERS( cond, event )
#endif

#ifndef WICED_DEEP_SLEEP_IS_WARMBOOT
#define WICED_DEEP_SLEEP_IS_WARMBOOT( )                                            0
#endif

#ifndef WICED_DEEP_SLEEP_IS_ENABLED
#define WICED_DEEP_SLEEP_IS_ENABLED( )                                             0
#endif

#ifndef WICED_DEEP_SLEEP_IS_WARMBOOT_HANDLE
#define WICED_DEEP_SLEEP_IS_WARMBOOT_HANDLE( )                                     ( WICED_DEEP_SLEEP_IS_ENABLED( ) && WICED_DEEP_SLEEP_IS_WARMBOOT( ) )
#endif

#ifndef WICED_DEEP_SLEEP_SAVE_PACKETS_NUM
#define WICED_DEEP_SLEEP_SAVE_PACKETS_NUM                                           0
#endif

/* The following #defines are deprecated from WICED 5.3 onwards, they
 * exist for backward compatibility with past WICED releases *
 */
#define wiced_deep_sleep_event_type_t       wiced_sleep_event_type_t
#define WICED_DEEP_SLEEP_EVENT_ENTER        WICED_SLEEP_EVENT_ENTER
#define WICED_DEEP_SLEEP_EVENT_CANCEL       WICED_SLEEP_EVENT_CANCEL
#define WICED_DEEP_SLEEP_EVENT_LEAVE        WICED_SLEEP_EVENT_LEAVE
#define WICED_DEEP_SLEEP_EVENT_HANDLER      WICED_SLEEP_EVENT_HANDLER

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

/*****************************************************************************/
/** @addtogroup initconf       Deep-sleep related functions
 *  @ingroup deep-sleep
 *
 * Functions to resume WICED after the deep-sleep.
 * Platform is not necessary to support deep-sleep mode.
 *
 *  @{
 */
/*****************************************************************************/

/** Resumes the WICED system after deep-sleep
 *
 * This function sets up the system same way as wiced_init
 * and has to be used when system resumes from deep-sleep
 *
 * @return @ref wiced_result_t
 */
extern wiced_result_t wiced_resume_after_deep_sleep( void );


/** Return the time spent during deep sleep.
 *
 * @note Currently this is implemented for 4390x platforms only.
 *
 * @return time in system ticks
 */
uint32_t     wiced_deep_sleep_ticks_since_enter( void );

/** @} */

#ifdef __cplusplus
} /* extern "C" */
#endif
