/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *  Platform Sleep Functions
 */

#include "wiced_low_power.h"

#if WICED_DEEP_SLEEP_IS_ENABLED()

#include "wiced_utilities.h"
#include "wiced_rtos.h"
#include "wiced_tcpip.h"

#include "wwd_network_interface.h"
#include "wwd_buffer_interface.h"
#include "wwd_assert.h"
#include "wiced_management.h"

#include "platform_isr.h"

/******************************************************
 *                      Macros
 ******************************************************/

#define DEEP_SLEEP_REPLAY_PACKETS_STATE_INIT    0
#define DEEP_SLEEP_REPLAY_PACKETS_STATE_START   1
#define DEEP_SLEEP_REPLAY_PACKETS_STATE_DONE    2
#define DEEP_SLEEP_REPLAY_PACKETS_STATE_DISABLE 3


#define DEEP_SLEEP_REPLAY_PACKETS_WAIT        100

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
 *               Function Declarations
 ******************************************************/

/******************************************************
 *               Variables Definitions
 ******************************************************/

#if WICED_DEEP_SLEEP_SAVE_PACKETS_NUM
static wiced_buffer_fifo_t                   deep_sleep_saved_packets;
static uint8_t                               deep_sleep_saved_packets_num    = 0;
static uint8_t                               deep_sleep_replay_packets_state = DEEP_SLEEP_REPLAY_PACKETS_STATE_INIT;
#endif

/******************************************************
 *               Function Definitions
 ******************************************************/

void wiced_deep_sleep_disable_packet_buffering( void )
{
#if WICED_DEEP_SLEEP_SAVE_PACKETS_NUM
    deep_sleep_replay_packets_state = DEEP_SLEEP_REPLAY_PACKETS_STATE_DISABLE;
#endif /* #if WICED_DEEP_SLEEP_SAVE_PACKETS_NUM */
}

wiced_bool_t wiced_deep_sleep_save_packet( wiced_buffer_t buffer, wwd_interface_t interface )
{
#if WICED_DEEP_SLEEP_SAVE_PACKETS_NUM

    wiced_bool_t result           = WICED_FALSE;
    wiced_bool_t wait_replay_done = WICED_TRUE;
    uint32_t     flags;

    if ( deep_sleep_replay_packets_state == DEEP_SLEEP_REPLAY_PACKETS_STATE_DONE ||
         deep_sleep_replay_packets_state == DEEP_SLEEP_REPLAY_PACKETS_STATE_DISABLE )
    {
        /* Fast path. */
        return WICED_FALSE;
    }

    WICED_SAVE_INTERRUPTS( flags );

    if ( deep_sleep_replay_packets_state == DEEP_SLEEP_REPLAY_PACKETS_STATE_INIT )
    {
        if ( deep_sleep_saved_packets_num < WICED_DEEP_SLEEP_SAVE_PACKETS_NUM )
        {
            host_buffer_push_to_fifo( &deep_sleep_saved_packets, buffer, interface );

            deep_sleep_saved_packets_num++;

            result = WICED_TRUE;
        }
        wait_replay_done = WICED_FALSE;
    }

    WICED_RESTORE_INTERRUPTS( flags );

    if ( wait_replay_done )
    {
        /*
         * Hit the middle of replaying.
         * To avoid packets reordering wait till its done.
         */

        int i;

        for ( i = 0; i < DEEP_SLEEP_REPLAY_PACKETS_WAIT; ++i )
        {
            MEMORY_BARRIER_AGAINST_COMPILER_REORDERING();
            if ( deep_sleep_replay_packets_state == DEEP_SLEEP_REPLAY_PACKETS_STATE_DONE )
            {
                break;
            }
            wiced_rtos_delay_milliseconds( 1 );
        }
    }

    return result;

#else

    UNUSED_PARAMETER( buffer );
    UNUSED_PARAMETER( interface );

    return WICED_FALSE;

#endif /* WICED_DEEP_SLEEP_SAVE_PACKETS_NUM */
}

static void wiced_deep_sleep_replay_packets( void )
{
#if WICED_DEEP_SLEEP_SAVE_PACKETS_NUM

    deep_sleep_replay_packets_state = DEEP_SLEEP_REPLAY_PACKETS_STATE_START;
    MEMORY_BARRIER_AGAINST_COMPILER_REORDERING();

    while ( 1 )
    {
        wwd_interface_t interface;
        wiced_buffer_t  buffer = host_buffer_pop_from_fifo( &deep_sleep_saved_packets, &interface );

        if ( buffer == NULL )
        {
            wiced_assert( "unbalanced counter", deep_sleep_saved_packets_num == 0 );
            break;
        }

        wiced_assert( "unbalanced counter", deep_sleep_saved_packets_num > 0 );
        deep_sleep_saved_packets_num--;

        host_network_process_ethernet_data( buffer, interface );
    }

    deep_sleep_replay_packets_state = DEEP_SLEEP_REPLAY_PACKETS_STATE_DONE;
    MEMORY_BARRIER_AGAINST_COMPILER_REORDERING();

#endif /* WICED_DEEP_SLEEP_SAVE_PACKETS_NUM */
}

void wiced_deep_sleep_set_networking_ready( void )
{
    wiced_deep_sleep_replay_packets( );
}

wiced_bool_t wiced_deep_sleep_is_networking_idle( wiced_interface_t interface )
{
    /*
     * Packet can be received during time when application is going into deep-sleep.
     * To reduce packet loss application before going into deep-sleep should poll current
     * function till it return WICED_TRUE.
     * This reduce chances significantly but does not guarantee avoiding of all packet losses
     * as packet can be received after the check.
     */

    if ( !host_buffer_pool_is_full( WWD_NETWORK_TX ) )
    {
        return WICED_FALSE;
    }

    if ( wiced_ip_is_any_pending_packets( interface ) )
    {
        return WICED_FALSE;
    }

   return WICED_TRUE;
}

#endif /* WICED_DEEP_SLEEP_IS_ENABLED() */

void platform_deep_sleep_init( void )
{
#if WICED_DEEP_SLEEP_IS_ENABLED()
#if WICED_DEEP_SLEEP_SAVE_PACKETS_NUM
    host_buffer_init_fifo( &deep_sleep_saved_packets );
#endif
#endif
}

uint32_t wiced_deep_sleep_ticks_since_enter( void )
{
    return platform_tick_get_time( PLATFORM_TICK_GET_TICKS_SINCE_LAST_DEEP_SLEEP );
}
