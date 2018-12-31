@
@ $ Copyright Cypress Semiconductor $
@

    /*
       Because of Linker issue in ld 7.2.1
       memory related functions in ROM
       always linked with BLX (THUMB to ARM) than BL (THUMB to THUMB)
     */

#define ROM_FUNCTION( fun_name, address ) \
       .global fun_name;                  \
       .type fun_name, %function;         \
       fun_name = address;

    .thumb

    ROM_FUNCTION(memcmp, 0x004646e0 + 1)
    ROM_FUNCTION(memcpy, 0x00464740 + 1)
    ROM_FUNCTION(memset, 0x00464ca0 + 1)
