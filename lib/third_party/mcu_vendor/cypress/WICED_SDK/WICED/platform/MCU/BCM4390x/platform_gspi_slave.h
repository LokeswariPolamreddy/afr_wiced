/*
 * $ Copyright Cypress Semiconductor $
 */
#pragma once

#ifndef PLATFORM_GSPI_SLAVE_H_
#define PLATFORM_GSPI_SLAVE_H_

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************
 *                      Macros
 ******************************************************/

#ifndef PAD
#define    _PADLINE(line)    pad ## line
#define    _XSTR(line)    _PADLINE(line)
#define    PAD        _XSTR(__LINE__)
#endif

/******************************************************
 *             Structures
 ******************************************************/
/* core registers */
typedef volatile struct {
    uint32_t corecontrol;        /* CoreControl, 0x000, rev8 */
    uint32_t corestatus;        /* CoreStatus, 0x004, rev8  */
    uint32_t PAD[1];
    uint32_t biststatus;        /* BistStatus, 0x00c, rev8  */

    /* PCMCIA access */
    uint16_t pcmciamesportaladdr;    /* PcmciaMesPortalAddr, 0x010, rev8   */
    uint16_t PAD[1];
    uint16_t pcmciamesportalmask;    /* PcmciaMesPortalMask, 0x014, rev8   */
    uint16_t PAD[1];
    uint16_t pcmciawrframebc;        /* PcmciaWrFrameBC, 0x018, rev8   */
    uint16_t PAD[1];
    uint16_t pcmciaunderflowtimer;    /* PcmciaUnderflowTimer, 0x01c, rev8   */
    uint16_t PAD[1];

    /* interrupt */
    uint32_t intstatus;        /* IntStatus, 0x020, rev8   */
    uint32_t hostintmask;        /* IntHostMask, 0x024, rev8   */
    uint32_t intmask;            /* IntSbMask, 0x028, rev8   */
    uint32_t sbintstatus;        /* SBIntStatus, 0x02c, rev8   */
    uint32_t sbintmask;        /* SBIntMask, 0x030, rev8   */
    uint32_t funcintmask;        /* SDIO Function Interrupt Mask, SDIO rev4 */
    uint32_t PAD[2];
    uint32_t tosbmailbox;        /* ToSBMailbox, 0x040, rev8   */
    uint32_t tohostmailbox;        /* ToHostMailbox, 0x044, rev8   */
    uint32_t tosbmailboxdata;        /* ToSbMailboxData, 0x048, rev8   */
    uint32_t tohostmailboxdata;    /* ToHostMailboxData, 0x04c, rev8   */

    /* synchronized access to registers in SDIO clock domain */
    uint32_t sdioaccess;        /* SdioAccess, 0x050, rev8   */
    uint32_t PAD[3];

    /* PCMCIA frame control */
    uint8_t pcmciaframectrl;        /* pcmciaFrameCtrl, 0x060, rev8   */
    uint8_t PAD[3];
    uint8_t pcmciawatermark;        /* pcmciaWaterMark, 0x064, rev8   */
    uint8_t PAD[155];

    /* interrupt batching control */
    uint32_t intrcvlazy;        /* IntRcvLazy, 0x100, rev8 */
    uint32_t PAD[3];

    /* counters */
    uint32_t cmd52rd;            /* Cmd52RdCount, 0x110, rev8, SDIO: cmd52 reads */
    uint32_t cmd52wr;            /* Cmd52WrCount, 0x114, rev8, SDIO: cmd52 writes */
    uint32_t cmd53rd;            /* Cmd53RdCount, 0x118, rev8, SDIO: cmd53 reads */
    uint32_t cmd53wr;            /* Cmd53WrCount, 0x11c, rev8, SDIO: cmd53 writes */
    uint32_t abort;            /* AbortCount, 0x120, rev8, SDIO: aborts */
    uint32_t datacrcerror;        /* DataCrcErrorCount, 0x124, rev8, SDIO: frames w/bad CRC */
    uint32_t rdoutofsync;        /* RdOutOfSyncCount, 0x128, rev8, SDIO/PCMCIA: Rd Frm OOS */
    uint32_t wroutofsync;        /* RdOutOfSyncCount, 0x12c, rev8, SDIO/PCMCIA: Wr Frm OOS */
    uint32_t writebusy;        /* WriteBusyCount, 0x130, rev8, SDIO: dev asserted "busy" */
    uint32_t readwait;        /* ReadWaitCount, 0x134, rev8, SDIO: read: no data avail */
    uint32_t readterm;        /* ReadTermCount, 0x138, rev8, SDIO: rd frm terminates */
    uint32_t writeterm;        /* WriteTermCount, 0x13c, rev8, SDIO: wr frm terminates */
    uint32_t PAD[40];
    uint32_t clockctlstatus;        /* ClockCtlStatus, 0x1e0, rev8 */
    uint32_t PAD[7];
} gspi_slave_reg_t;

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* PLATFORM_GSPI_SLAVE_H_ */
