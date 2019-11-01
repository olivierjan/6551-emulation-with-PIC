;*******************************************************************************
;                                                                              *
;    Microchip licenses this software to you solely for use with Microchip     *
;    products. The software is owned by Microchip and/or its licensors, and is *
;    protected under applicable copyright laws.  All rights reserved.          *
;                                                                              *
;    This software and any accompanying information is for suggestion only.    *
;    It shall not be deemed to modify Microchip?s standard warranty for its    *
;    products.  It is your responsibility to ensure that this software meets   *
;    your requirements.                                                        *
;                                                                              *
;    SOFTWARE IS PROVIDED "AS IS".  MICROCHIP AND ITS LICENSORS EXPRESSLY      *
;    DISCLAIM ANY WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING  *
;    BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS    *
;    FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL          *
;    MICROCHIP OR ITS LICENSORS BE LIABLE FOR ANY INCIDENTAL, SPECIAL,         *
;    INDIRECT OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, HARM TO     *
;    YOUR EQUIPMENT, COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR    *
;    SERVICES, ANY CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY   *
;    DEFENSE THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER      *
;    SIMILAR COSTS.                                                            *
;                                                                              *
;    To the fullest extend allowed by law, Microchip and its licensors         *
;    liability shall not exceed the amount of fee, if any, that you have paid  *
;    directly to Microchip to use this software.                               *
;                                                                              *
;    MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF    *
;    THESE TERMS.                                                              *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Filename: Serial.asm                                                      *
;    Date: 17/08/2019                                                          *
;    File Version:   1                                                         *
;    Author:  OJ                                                               *
;    Company:                                                                  *
;    Description: 6551 Serial Interface                                        *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Notes: In the MPLAB X Help, refer to the MPASM Assembler documentation    *
;    for information on assembly instructions.                                 *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Known Issues: This template is designed for relocatable code.  As such,   *
;    build errors such as "Directive only allowed when generating an object    *
;    file" will result when the 'Build in Absolute Mode' checkbox is selected  *
;    in the project properties.  Designing code in absolute mode is            *
;    antiquated - use relocatable mode.                                        *
;                                                                              *
;*******************************************************************************
;                                                                              *
;    Revision History:                                                         *
;                                                                              *
;*******************************************************************************



;*******************************************************************************
; Processor Inclusion
;
; TODO Step #1 Open the task list under Window > Tasks.  Include your
; device .inc file - e.g. #include <device_name>.inc.  Available
; include files are in C:\Program Files\Microchip\MPLABX\mpasmx
; assuming the default installation path for MPLAB X.  You may manually find
; the appropriate include file for your device here and include it, or
; simply copy the include generated by the configuration bits
; generator (see Step #2).
;
;*******************************************************************************

#include "p18f46k42.inc"

;*******************************************************************************
;
; TODO Step #2 - Configuration Word Setup
;
; The 'CONFIG' directive is used to embed the configuration word within the
; .asm file. MPLAB X requires users to embed their configuration words
; into source code.  See the device datasheet for additional information
; on configuration word settings.  Device configuration bits descriptions
; are in C:\Program Files\Microchip\MPLABX\mpasmx\P<device_name>.inc
; (may change depending on your MPLAB X installation directory).
;
; MPLAB X has a feature which generates configuration bits source code.  Go to
; Window > PIC Memory Views > Configuration Bits.  Configure each field as
; needed and select 'Generate Source Code to Output'.  The resulting code which
; appears in the 'Output Window' > 'Config Bits Source' tab may be copied
; below.
;
;*******************************************************************************

; CONFIG1L
  CONFIG  FEXTOSC = OFF         ; External Oscillator Selection (Oscillator not enabled)
  CONFIG  RSTOSC = HFINTOSC_64MHZ; Reset Oscillator Selection (HFINTOSC with HFFRQ = 64 MHz and CDIV = 1:1)

; CONFIG1H
  CONFIG  CLKOUTEN = OFF        ; Clock out Enable bit (CLKOUT function is disabled)
  CONFIG  PR1WAY = ON           ; PRLOCKED One-Way Set Enable bit (PRLOCK bit can be cleared and set only once)
  CONFIG  CSWEN = ON            ; Clock Switch Enable bit (Writing to NOSC and NDIV is allowed)
  CONFIG  FCMEN = ON            ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor enabled)

; CONFIG2L
  CONFIG  MCLRE = EXTMCLR       ; MCLR Enable bit (If LVP = 0, MCLR pin is MCLR; If LVP = 1, RE3 pin function is MCLR )
  CONFIG  PWRTS = PWRT_OFF      ; Power-up timer selection bits (PWRT is disabled)
  CONFIG  MVECEN = OFF		; Multi-vector enable bit (Interrupt contoller does not use vector table to prioritze interrupts)
  CONFIG  IVT1WAY = OFF         ; IVTLOCK bit One-way set enable bit (IVTLOCK bit can be cleared and set only once)
  CONFIG  LPBOREN = OFF         ; Low Power BOR Enable bit (ULPBOR disabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable bits (Brown-out Reset enabled , SBOREN bit is ignored)

; CONFIG2H
  CONFIG  BORV = VBOR_2P45      ; Brown-out Reset Voltage Selection bits (Brown-out Reset Voltage (VBOR) set to 2.45V)
  CONFIG  ZCD = OFF             ; ZCD Disable bit (ZCD disabled. ZCD can be enabled by setting the ZCDSEN bit of ZCDCON)
  CONFIG  PPS1WAY = ON          ; PPSLOCK bit One-Way Set Enable bit (PPSLOCK bit can be cleared and set only once; PPS registers remain locked after one clear/set cycle)
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  DEBUG = OFF           ; Debugger Enable bit (Background debugger disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Extended Instruction Set and Indexed Addressing Mode disabled)

; CONFIG3L
  CONFIG  WDTCPS = WDTCPS_31    ; WDT Period selection bits (Divider ratio 1:65536; software control of WDTPS)
  CONFIG  WDTE = OFF            ; WDT operating mode (WDT Disabled; SWDTEN is ignored)

; CONFIG3H
  CONFIG  WDTCWS = WDTCWS_7     ; WDT Window Select bits (window always open (100%); software control; keyed access not required)
  CONFIG  WDTCCS = SC           ; WDT input clock selector (Software Control)

; CONFIG4L
  CONFIG  BBSIZE = BBSIZE_512   ; Boot Block Size selection bits (Boot Block size is 512 words)
  CONFIG  BBEN = OFF            ; Boot Block enable bit (Boot block disabled)
  CONFIG  SAFEN = OFF           ; Storage Area Flash enable bit (SAF disabled)
  CONFIG  WRTAPP = OFF          ; Application Block write protection bit (Application Block not write protected)

; CONFIG4H
  CONFIG  WRTB = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-30000Bh) not write-protected)
  CONFIG  WRTC = OFF            ; Boot Block Write Protection bit (Boot Block (000000-0007FFh) not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM not write-protected)
  CONFIG  WRTSAF = OFF          ; SAF Write protection bit (SAF not Write Protected)
  CONFIG  LVP = ON              ; Low Voltage Programming Enable bit (Low voltage programming enabled. MCLR/VPP pin function is MCLR. MCLRE configuration bit is ignored)

; CONFIG5L
  CONFIG  CP = OFF              ; PFM and Data EEPROM Code Protection bit (PFM and Data EEPROM code protection disabled)

; CONFIG5H

;*******************************************************************************
;
; TODO Step #3 - Variable Definitions
;
; Refer to datasheet for available data memory (RAM) organization assuming
; relocatible code organization (which is an option in project
; properties > mpasm (Global Options)).  Absolute mode generally should
; be used sparingly.
;
; Example of using GPR Uninitialized Data
;
;   GPR_VAR        UDATA
;   MYVAR1         RES        1      ; User variable linker places
;   MYVAR2         RES        1      ; User variable linker places
;   MYVAR3         RES        1      ; User variable linker places
;
;   ; Example of using Access Uninitialized Data Section (when available)
;   ; The variables for the context saving in the device datasheet may need
;   ; memory reserved here.
;   INT_VAR        UDATA_ACS
;   W_TEMP         RES        1      ; w register for context saving (ACCESS)
;   STATUS_TEMP    RES        1      ; status used for context saving
;   BSR_TEMP       RES        1      ; bank select used for ISR context saving
;
;*******************************************************************************

; TODO PLACE VARIABLE DEFINITIONS GO HERE
  
;*******************************************************************************
; Reset Vector
;*******************************************************************************

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

;*******************************************************************************
; TODO Step #4 - Interrupt Service Routines
;
; There are a few different ways to structure interrupt routines in the 8
; bit device families.  On PIC18's the high priority and low priority
; interrupts are located at 0x0008 and 0x0018, respectively.  On PIC16's and
; lower the interrupt is at 0x0004.  Between device families there is subtle
; variation in the both the hardware supporting the ISR (for restoring
; interrupt context) as well as the software used to restore the context
; (without corrupting the STATUS bits).
;
; General formats are shown below in relocatible format.
;
;------------------------------PIC16's and below--------------------------------
;
; ISR       CODE    0x0004           ; interrupt vector location
;
;     <Search the device datasheet for 'context' and copy interrupt
;     context saving code here.  Older devices need context saving code,
;     but newer devices like the 16F#### don't need context saving code.>
;
;     RETFIE
;
;----------------------------------PIC18's--------------------------------------
;
; ISRHV     CODE    0x0008
;     GOTO    HIGH_ISR
; ISRLV     CODE    0x0018
;     GOTO    LOW_ISR
;
; ISRH      CODE                     ; let linker place high ISR routine
; HIGH_ISR
;     <Insert High Priority ISR Here - no SW context saving>
;     RETFIE  FAST
;
; ISRL      CODE                     ; let linker place low ISR routine
; LOW_ISR
;       <Search the device datasheet for 'context' and copy interrupt
;       context saving code here>
;     RETFIE
;
;*******************************************************************************

ISRVH	CODE	0x000008
	bcf	PIR1,INT0IF	   ; Clear Interrupt flag
	movf	PORTC, W, ACCESS   ;  
	bra   ACTIONTABLE
    
ACTIONTABLE
    addwf   PCL,F
    bra   ACIAWrite
    bra   ACIADoNothing           ;ACIAReset
    bra   ACIADoNothing           ;ACIAWriteCommand
    bra   ACIADoNothing           ;ACIAWriteControl
    bra   ACIARead
    bra   ACIAStatus
    bra   ACIADoNothing           ;ACIAReadCommand
    bra   ACIADoNothing           ;ACIAReadControl
    
ACIARead
	movffl  U1RXB,LATA   ; Move Content of UART Receive buffer to PORTA
                        ;nop
                        ;nop
    clrf    TRISA,ACCESS ; Make PORT A Output
	nop
	nop
	setf    TRISA,ACCESS ; Revert PORT A to Input
	retfie  FAST  
	
ACIAWrite
    movffl  PORTA,U1TXB ; Move PORT A Content to UART Send Buffer
                        ;nop
                        ;nop
	nop
	nop
	nop
	nop
    retfie   FAST
    
ACIAStatus
    movffl  PIR3,LATA       ;nop
                            ;nop
                            ;nop
	clrf    TRISA, ACCESS   ;nop
	nop
    nop
    setf    TRISA, ACCESS   ;nop
    retfie  FAST
    
ACIADoNothing
    retfie  FAST
    
    
;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************

    
    
    
;*******************************************************************************
; PORT A:       Parallel DATA IN / OUT
; PORT C<1-2>:       RS0,RS1
; PORT C-3: RW'
;
; PORT B-0: CTS
; PORT B-1: RTS
; PORT B-2: TX
; PORT B-3: RX
;    
; PORT B-5: CS
;*******************************************************************************
    
    
MAIN_PROG CODE  0x000060                   ; let linker place main program

START

    ; TODO Step #5 - Insert Your Program Here
    
    ; Setup PORTS
    
    ; Turn analog off
    
    banksel ANSELA
    clrf    ANSELA                  
    clrf    ANSELB
    clrf    ANSELC
    clrf    ANSELD
    clrf    ANSELE
    
    ; Clear Output latchs
    clrf    LATA, ACCESS
    clrf    LATB, ACCESS
    clrf    LATC, ACCESS
    clrf    LATD, ACCESS
    clrf    LATE, ACCESS
    
    ; Tristate ports
    setf    TRISA, ACCESS	; Configured for Input
    setf    TRISB, ACCESS	; Configured for Input
    setf    TRISC, ACCESS	; Configured for Input
    setf    TRISD, ACCESS	; Configured for Input
    movlw   0x07
    movwf   TRISE, ACCESS	; Configured for Input
    
    ; Assign Ports
    
	; UART
    banksel U1RXPPS
    movlw   0x0b            ; Assign pin RB3. PORTB:001 PIN 3: 011	
    movwf   U1RXPPS         ; to UART1 RX
    movlw   0x13            ; Assign UART1 TX. b010011
    movwf   RB2PPS          ; to pin RB2.  
    movlw   0x08            ; Assign pin RB0. PORTB:001 PIN 0: 000
    movwf   U1CTSPPS        ; to UART1 CTS
    movlw   0x15            ; Assign UART1 RTS'. b010101
    movwf   RB1PPS          ; to pin RB1
	
	; External Interrupt
    
    movlw   0x0d			; Assign pin RB5 (CS) PORTB: 001 PIN 5: 101
    movwf   INT0PPS         ; to INT0
    
    
    ; Configure Interrupts

    bcf	    INTCON0, GIE, ACCESS            ; Disable all Interrupts
    bsf	    INTCON0, INT0EDG, ACCESS	    ; Get Interrupt on rising edge
      
    banksel PIE1
    bcf	    PIR1, INT0IF
    bsf	    PIE1, INT0IE                    ; Enable External Interrupt on INT0
    
     
    bsf	    INTCON0, GIE, ACCESS            ; Re-enable Interrupts
    
    
    ; Configure UART
    
    movlw   0x00    ;
    movwf   U1P1L   ; Unused for "Basic" Serial communication
    movwf   U1P1H   ; Unused for "Basic" Serial communication
    movwf   U1P2L   ; Unused for "Basic" Serial communication
    movwf   U1P2H   ; Unused for "Basic" Serial communication
    movwf   U1P3L   ; Unused for "Basic" Serial communication
    movwf   U1P3H   ; Unused for "Basic" Serial communication
    
    ; BRGS high speed
    ; MODE Asynchronous 8-bit mode
    ; RXEN enabled
    ; TXEN enabled
    ; ABDEN disabled; 
    
    movlw   0xB0    ;
    movwf   U1CON0  ;

    ; RXBIMD Set RXBKIF on rising RX input
    ; BRKOVR disabled
    ; WUE disabled
    ; SENDB send break
    ; ON enabled; 
    
    movlw   0x81    ;
    movwf   U1CON1  ;

    ; TXPOL not inverted
    ; FLO Hardware flow control
    ; C0EN Add all TX and RX characters
    ; RXPOL not inverted
    ; RUNOVF RX input shifter continues
    ; STP Transmit 1Stop bit, receiver verifies first Stop bit; 
    
    movlw   0x82    ;
    movwf   U1CON2  ;

    ; BRGL 130; 
    movlw   0x82    ;
    movwf   U1BRGL  ;

    ; BRGH 6; 
    movlw   0x06    ;
    movwf   U1BRGH  ;

    ; STPMD in middle of first Stop bit
    ; TXWRE No error; 
    movlw   0x00    ;
    movwf   U1FIFO  ;

    ; ABDIF Auto-baud detection complete
    ; WUIF WUE not enabled by software
    ; ABDIE enabled; 
    
    movlw   0x44    ;
    movwf   U1UIR   ;

    ; ABDOVF Not overflowed
    ; TXCIF 0
    ; RXBKIF No Break detected
    ; RXFOIF not overflowed
    ; CERIF No Checksum error; 
    movlw   0x00    ;
    movwf   U1ERRIR ;

    ; TXCIE disabled
    ; FERIE disabled
    ; TXMTIE disabled
    ; ABDOVE disabled
    ; CERIE disabled
    ; RXFOIE disabled
    ; PERIE disabled
    ; RXBKIE disabled; 
    
    movlw   0x00    ;
    movwf   U1ERRIE ;
    
    ; Send a first byte to initialize
    movlw 0x55      ;
    movwf   U1TXB   ;

       
LOOP    
    nop
    GOTO LOOP                               ; loop forever

    END