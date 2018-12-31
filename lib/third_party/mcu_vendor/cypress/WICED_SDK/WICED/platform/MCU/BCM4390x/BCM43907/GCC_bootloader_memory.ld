/*
 * $ Copyright Cypress Semiconductor $
 */

MEMORY
{
    ROM              (rx)   : ORIGIN = 0x00400000, LENGTH = 640K
    FLOPS            (rwx)  : ORIGIN = 0x00000000, LENGTH = 32
    BOOTLOADER_SRAM  (rwx)  : ORIGIN = 0x00696000, LENGTH = 36K  /* Uses the top 36K of SRAM (apart from the 4K used by the ROM bootloader */
    DDR              (rwx)  : ORIGIN = 0x40000000, LENGTH = 0
}
