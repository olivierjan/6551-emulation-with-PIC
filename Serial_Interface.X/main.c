/**
  Generated Main Source File

  Company:
    Microchip Technology Inc.

  File Name:
    main.c

  Summary:
    This is the main file generated using PIC10 / PIC12 / PIC16 / PIC18 MCUs

  Description:
    This header file provides implementations for driver APIs for all modules selected in the GUI.
    Generation Information :
        Product Revision  :  PIC10 / PIC12 / PIC16 / PIC18 MCUs - 1.77
        Device            :  PIC18F46K42
        Driver Version    :  2.00
*/

/*
    (c) 2018 Microchip Technology Inc. and its subsidiaries. 
    
    Subject to your compliance with these terms, you may use Microchip software and any 
    derivatives exclusively with Microchip products. It is your responsibility to comply with third party 
    license terms applicable to your use of third party software (including open source software) that 
    may accompany Microchip software.
    
    THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER 
    EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY 
    IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS 
    FOR A PARTICULAR PURPOSE.
    
    IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND 
    WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP 
    HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO 
    THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL 
    CLAIMS IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT 
    OF FEES, IF ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS 
    SOFTWARE.
*/

#include "mcc_generated_files/mcc.h"
#include "Serial_Interface.h"

/*
                         Main application
 */
static volatile uint8_t ReadBuffer=0;
static volatile uint8_t ButtonPressed=0;
volatile uint8_t ActionFlag=ACTION_NOACTION;


//void   UART1_Receive_Toggle_ISR(void)
//{
//    ReadBuffer= U1RXB; 
//    LED_Toggle(); 
      
    // or set custom function  UART1_SetRxInterruptHandler()
//}



void main(void)
{
    
    uint8_t registerSelect;
    uint8_t i;
    // Initialize the device
    SYSTEM_Initialize();

    // If using interrupts in PIC18 High/Low Priority Mode you need to enable the Global High and Low Interrupts
    // If using interrupts in PIC Mid-Range Compatibility Mode you need to enable the Global Interrupts
    // Use the following macros to:

  
   
    INTERRUPT_GlobalInterruptHighEnable();
    INTERRUPT_GlobalInterruptLowEnable();

    PIE9bits.CLC3IE = 0;
    
    for (i=0; i<24 ;i++) {
        
        printf("\r\n");
    }
    printf("Serial Interface READY\r\n");
    
    PIE9bits.CLC3IE = 1;
    
    
   
   
    while (1)
    {
        while (CLC2CONbits.LC2OUT & PIR3bits.U1RXIF){
            LATA=U1RXB;
            TRISA=0x00;
            PIR3bits.U1RXIF=0;
            LATA=0x00;
            TRISA=0xff;
            
            //WPUA=0xff;
        }
        // Add your application code
//        switch (ActionFlag){
//            case ACTION_READ:
//                
//                // 6502 wants to READ Data
//                // And we don't want to be disturbed, so disable interrupts
//                
//               // INTERRUPT_GlobalInterruptDisable();
//                
//                // Check RS0/RS1 to see what is to be read
//                
//                // First, mask the bits we need
////                registerSelect=PORTC & REGISTERSELECTMASK;
////                
//                // Now let's process CPU request
//                switch (registerSelect){
//                    
//                    case ACIA_DATAREG:
////                        // Switch PortA to output
////                        LATA=UART1_Read();
////                        LATA=0x41;
////                        //LATA=U1RXB;
////                        //WPUA=0xff;
////                        TRISA=0x00;
////                        //LATA=0x00;
////                        TRISA=0xff;
////                        //WPUA=0x00;
//                        break;
//                    case ACIA_STATUSREG:
//                       
////                        LATAbits.LATA3=UART1_is_rx_ready();
////                        LATAbits.LATA4=UART1_is_tx_ready();
////                        WPUA=0xff;
////                        TRISA=0x00;
////                        LATA=0x00;
////                        TRISA=0xff;
////                        WPUA=0x00;
//                        break;
//                    case ACIA_COMMANDREG:
//                        // So far no need to implement this 
//                        //printf("\r\n6502 wants to READ COMMAND\r\n");
//                        break;
//                    case ACIA_CONTROLREG:
//                        // So far no need to implement this 
//                        //printf("\r\n6502 wants to READ CONTROL\r\n");
//                        break;
//                    default:
//                        // So far no need to implement this 
//                        //printf("\r\n6502 wants to READ something strange...\r\n");
//                        break;
//                }
//                
//                ActionFlag=ACTION_NOACTION;
//                
//                // We're done, re-enable interrupts.
//                //INTERRUPT_GlobalInterruptEnable();
//                
//                break;
//                
//            case ACTION_WRITE:
//                
//                // 6502 wants to WRITE Data
//                // And we don't want to be disturbed, so disable interrupts
//                
//                
//                //INTERRUPT_GlobalInterruptDisable();
//                
//                // Check RS0/RS1 to see what is to be written
//                
//                // First, mask the bits we need
//                registerSelect=PORTC & REGISTERSELECTMASK;
//                
//                // Now let's process CPU request
//                switch (registerSelect){
//                    
//                    case ACIA_DATAREG:
//                        UART1_Write(PORTA);
//                        //printf("\r\n6502 wants to WRITE DATA\r\n");
//                        break;
//                    case ACIA_STATUSREG:
//                        // So far no need to implement this 
//                        // printf("\r\n6502 wants to WRITE STATUS\r\n");
//                        break;
//                    case ACIA_COMMANDREG:
//                        // So far no need to implement this 
//                        //printf("\r\n6502 wants to WRITE COMMAND\r\n");
//                        break;
//                    case ACIA_CONTROLREG:
//                        // So far no need to implement this 
//                        // printf("\r\n6502 wants to WRITE CONTROL\r\n");
//                        break;
//                    default:
//                        // So far no need to implement this 
//                        // printf("\r\n6502 wants to WRITE something strange...\r\n");
//                        break;
//                }
//                //printf("\r\nWRITING....\r\n");
//
//                ActionFlag=ACTION_NOACTION;
//                
//                // We're done, re-enable interrupts.
//               // INTERRUPT_GlobalInterruptEnable();
//                
//                break;
//                
//            default: 
//                
//                // Feeling lonely, nothing to do...
//                
//                break;
//        }
        
        
    }
}
/**
 End of File
*/