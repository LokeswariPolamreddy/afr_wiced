/*
 * $ Copyright Cypress Semiconductor $
 */

/** @file
 *  Additional code to be inserted to FreeRTOS tasks.c file
 *
 */

#ifndef INCLUDED_FREERTOS_TASKS_C_ADDITIONS_H_
#define INCLUDED_FREERTOS_TASKS_C_ADDITIONS_H_


signed portBASE_TYPE xTaskIsTaskFinished( TaskHandle_t xTask )
{
    int i;
    const tskTCB * const pxTCB = ( tskTCB * ) xTask;

    /* It does not make sense to check if the calling task is suspended. */
    configASSERT( xTask );

    /* Is the task we are attempting to resume actually in the
    suspended list? */
    if ( pxCurrentTCB == pxTCB )
    {
        return pdFALSE;
    }
    taskENTER_CRITICAL();

    if ( ( listIS_CONTAINED_WITHIN( &xSuspendedTaskList, &( pxTCB->xStateListItem ) ) != pdFALSE ) ||
         ( listIS_CONTAINED_WITHIN( &xDelayedTaskList1, &( pxTCB->xStateListItem ) ) != pdFALSE ) ||
         ( listIS_CONTAINED_WITHIN( &xDelayedTaskList2, &( pxTCB->xStateListItem ) ) != pdFALSE ) ||
         ( listIS_CONTAINED_WITHIN( &xPendingReadyList, &( pxTCB->xStateListItem ) ) != pdFALSE ) )
    {
        taskEXIT_CRITICAL();
        return pdFALSE;
    }
    for ( i = 0; i < configMAX_PRIORITIES; i++ )
    {
        if ( listIS_CONTAINED_WITHIN( &pxReadyTasksLists[ i ], &( pxTCB->xStateListItem ) ) != pdFALSE )
        {
            taskEXIT_CRITICAL();
            return pdFALSE;
        }
    }
    taskEXIT_CRITICAL();
    return pdTRUE;
}


TaskHandle_t xTaskGetCurrentThread( void )
{
    return (TaskHandle_t) pxCurrentTCB;
}

#endif /* ifndef INCLUDED_FREERTOS_TASKS_C_ADDITIONS_H_ */
