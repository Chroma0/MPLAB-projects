#include <xc.h>
#include<stdio.h>
#include<stdlib.h>
#include <time.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67  //OSCILLATOR SELECTION BITS (INTERNAL OSCILLATOR BLOCK, PORT FUNCTION ON RA6 AND RA7)
#pragma config WDT = OFF      //Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
#pragma config PWRT = OFF     //Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON     //Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
#pragma config PBADEN = OFF   //PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
#pragma config LVP = OFF      //Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
#pragma config CPD = OFF      //Data EEPROM Code Protection bit (Data EEPROM not code-protected)

#define _XTAL_FREQ 4000000

void __interrupt(high_priority)H_ISR(){
    
    //step4
    //uint16_t value = ((ADRESH << 8) | ADRESL);
    //do things
    
    CCPR1L = ADRESH;
    
    //clear flag bit
    PIR1bits.ADIF = 0;
    //step5 & go back step3
    //delay at least 2tad
    __delay_ms(25);
    ADCON0bits.GO = 1;
    
    return;
}

void main(void) 
{
    //configure OSC and port
    OSCCONbits.IRCF = 0b001; //1MHz
    TRISAbits.RA0 = 1;       //analog input port
    TRISBbits.RB0 = 0;
    PORTB = 0x01;
    //step1
    ADCON1bits.VCFG0 = 0;
    ADCON1bits.VCFG1 = 0;
    ADCON1bits.PCFG = 0b1110; //AN0 ?analog input,???? digital
    ADCON0bits.CHS = 0b0000;  //AN0 ?? analog input
    ADCON2bits.ADCS = 0b100;  //????100(4Mhz < 5.71Mhz)
    ADCON2bits.ACQT = 0b010;  //Tad = 2 us acquisition time?2Tad = 4 > 2.4
    ADCON0bits.ADON = 1;
    ADCON2bits.ADFM = 0;    //right justified 
    
    
    //step2
    PIE1bits.ADIE = 1;
    PIR1bits.ADIF = 0;
    INTCONbits.PEIE = 1;
    INTCONbits.GIE = 1;

    T2CONbits.TMR2ON = 0b1;
    T2CONbits.T2CKPS = 0b01;
    CCP1CONbits.CCP1M = 0b1100;
    TRISC = 0;
    LATC = 0;
    PR2 = 0x9b;
    CCPR1L = 0x08;
    CCP1CONbits.DC1B = 0b01;

    //step3
    ADCON0bits.GO = 1;
    
    while(1);
    
    return;
}
