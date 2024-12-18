#include <xc.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67    // Oscillator Selection bits
#pragma config WDT = OFF        // Watchdog Timer Enable bit 
#pragma config PWRT = OFF       // Power-up Enable bit
#pragma config BOREN = ON       // Brown-out Reset Enable bit
#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
#pragma config LVP = OFF        // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF        // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)

int STATE = 1;

void __interrupt() ISR(void){
    if(STATE == 1){
        CCPR1L = 0x0b;//angle = 0
        STATE = 2;
    }
    else if(STATE == 2){
        CCPR1L = 0x0F;//angle = 45
        STATE = 3;
    }
    else if(STATE == 3){
        CCPR1L = 0x0b;//angle = 0
        STATE = 4;
    }
    else if(STATE == 4){
        CCPR1L = 0x08;//angle = -45
        STATE = 1;
    }
    INTCONbits.INT0IF = 0;
    return;
}


void main(void)
{
    
    // Timer2 -> On, prescaler -> 4
    T2CONbits.TMR2ON = 0b1;
    T2CONbits.T2CKPS = 0b01;
    // Internal Oscillator Frequency, Fosc = 125 kHz, Tosc = 8 �s
    OSCCONbits.IRCF = 0b001;
    // PWM mode, P1A, P1C active-high; P1B, P1D active-high
    CCP1CONbits.CCP1M = 0b1100;
    // CCP1/RC2 -> Output
    TRISC = 0;
    LATC = 0;
    // Set up PR2, CCP to decide PWM period and Duty Cycle
    /** 
     * PWM period
     * = (PR2 + 1) * 4 * Tosc * (TMR2 prescaler)
     * = (0x9b + 1) * 4 * 8�s * 4
     * = 0.019968s ~= 20ms
     */
    PR2 = 0x9b;
    /**
     * Duty cycle
     * = (CCPR1L:CCP1CON<5:4>) * Tosc * (TMR2 prescaler)
     * = (0x0b*4 + 0b01) * 8�s * 4
     * = 0.00144s ~= 1450�s
     */
    CCPR1L = 0x08;
    CCP1CONbits.DC1B = 0b01;
    TRISB = 1;
    RCONbits.IPEN = 0;
    INTCONbits.INT0IF = 0;
    INTCONbits.GIE = 1;
    INTCONbits.INT0IE = 1;
    ADCON1 = 0x0F;
    
    while(1);
    return;
}
