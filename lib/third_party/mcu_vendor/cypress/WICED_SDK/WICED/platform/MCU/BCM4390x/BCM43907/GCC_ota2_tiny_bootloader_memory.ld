/*
 * $ Copyright Cypress Semiconductor $
 */

MEMORY
{
    AONRAM           (rwx)  : ORIGIN = 0x006A0000, LENGTH = 5K /* Use half of 8K AON memory as hard limit for tiny bootloader */
    RAM              (rwx)  : ORIGIN = 0x00688000, LENGTH = 77K /* Uses the top 77K of SRAM */
}

