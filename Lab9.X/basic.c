#include <xc.h>
#include<stdio.h>
#include<stdlib.h>
#include <time.h>

#pragma config OSC = INTIO67  //OSCILLATOR SELECTION BITS (INTERNAL OSCILLATOR BLOCK, PORT FUNCTION ON RA6 AND RA7)
#pragma config WDT = OFF      //Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
#pragma config PWRT = OFF     //Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON     //Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
#pragma config PBADEN = OFF   //PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
#pragma config LVP = OFF      //Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
#pragma config CPD = OFF      //Data EEPROM Code Protection bit (Data EEPROM not code-protected)

#define _XTAL_FREQ 4000000

void __interrupt(high_priority)H_ISR(){
        
    //do things
    uint16_t value = ((ADRESH << 8) | ADRESL) / 128;
    //state = (state + 1) % 3;
    if(value > 7) CCPR1L = 0x12;
    else if(value > 6) CCPR1L = 0x11;
    else if(value > 5) CCPR1L = 0x10;
    else if(value > 4) CCPR1L = 0x09;
    else if(value > 3) CCPR1L = 0x08;
    else if(value > 2) CCPR1L = 0x07;
    else if(value > 1) CCPR1L = 0x06;
    else if(value > 0) CCPR1L = 0x05;
    else CCPR1L = 0x04;
    //clear flag bit
    PIR1bits.ADIF = 0;
    //step5 & go back step3
    //delay at least 2tad
    __delay_us(10);
    ADCON0bits.GO = 1;
    INTCONbits.INT0IF = 0;
    return;
}

void main(void) 
{
    T2CONbits.TMR2ON = 0b1;
    T2CONbits.T2CKPS = 0b01;
    //configure OSC and port
    OSCCONbits.IRCF = 0b110; //4MHz
    CCP1CONbits.CCP1M = 0b1100;
    TRISC = 0;
    LATC = 0;
    PR2 = 0x9b;
    CCPR1L = 0x08;
    CCP1CONbits.DC1B = 0b01;
    RCONbits.IPEN = 0;
    INTCONbits.INT0IF = 0;
    INTCONbits.INT0IE = 1;
    ADCON1 = 0x0F;
    TRISAbits.RA0 = 1;       //analog input port
    //step1
    ADCON1bits.VCFG0 = 0;
    ADCON1bits.VCFG1 = 0;
    ADCON1bits.PCFG = 0b1110; //AN0 ?analog input,???? digital
    ADCON0bits.CHS = 0b0000;  //AN0 ?? analog input
    ADCON2bits.ADCS = 0b100;  //????100(4Mhz < 5.71Mhz)
    ADCON2bits.ACQT = 0b010;  //Tad = 2 us acquisition time?2Tad = 4 > 2.4
    ADCON0bits.ADON = 1;
    ADCON2bits.ADFM = 1;    //right justified 
    
    
    //step2
    PIE1bits.ADIE = 1;
    PIR1bits.ADIF = 0;
    INTCONbits.PEIE = 1;
    INTCONbits.GIE = 1;


    //step3
    ADCON0bits.GO = 1;
    
    while(1);
    
    return;
}
