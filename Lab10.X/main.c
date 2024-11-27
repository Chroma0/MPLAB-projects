#include "setting_hardaware/setting.h"
#include <stdlib.h>
#include <pic18f4520.h>
#include "stdio.h"
#include "string.h"
// using namespace std;

void DELAY(unsigned int time){
    for(int i = 0;i < time; i++)
        for(int j = 0; j < 165; j++);
}

char str[20];
void Mode1(){   // Todo : Mode1 
    return ;
}
void Mode2(){   // Todo : Mode2 
    return ;
}
void main(void) 
{
    
    SYSTEM_Initialize() ;
    
    //Set button input
    ADCON1 = 0x0F;
    TRISB = 1;
    //Set light output
    TRISAbits.RA0 = 0;
    TRISAbits.RA1 = 0;
    TRISAbits.RA2 = 0;
    TRISAbits.RA3 = 0;
    RCONbits.IPEN = 0;
    INTCONbits.INT0IF = 0;
    INTCONbits.GIE = 1;
    INTCONbits.INT0IE = 1;
    PORTA = 0x00;
    
    while(1) {
        strcpy(str, GetString()); // TODO : GetString() in uart.c
        if(str[0]=='m' && str[1]=='1'){ // Mode1
            Mode1();
            ClearBuffer();
        }
        else if(str[0]=='m' && str[1]=='2'){ // Mode2
            Mode2();
            ClearBuffer();  
        }
    }
    return;
}

void __interrupt(high_priority) Hi_ISR(void)
{  
    
    LATA++;
    if(LATA == 0x10) LATA = 0x00;
    uint8_t result = LATA;
    char res[10];
    sprintf(res,"%d",result);
    UART_Write_Text(&res);
    DELAY(10);
    INTCONbits.INT0IF = 0;
    DELAY(10);
    return;
    
}