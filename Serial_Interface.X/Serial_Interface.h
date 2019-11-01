/* 
 * File:   Serial_Interface.h
 * Author: ojan
 *
 * Created on August 15, 2019, 12:34 PM
 */

#ifndef SERIAL_INTERFACE_H
#define	SERIAL_INTERFACE_H

#ifdef	__cplusplus
extern "C" {
#endif




#ifdef	__cplusplus
}
#endif

#define ACTION_NOACTION 0
#define ACTION_READ 1 
#define ACTION_WRITE 2

#define ACIA_DATAREG    0x00
#define ACIA_STATUSREG  0x10
#define ACIA_COMMANDREG 0x20
#define ACIA_CONTROLREG 0x30

#define REGISTERSELECTMASK 0x30;

#endif	/* SERIAL_INTERFACE_H */

