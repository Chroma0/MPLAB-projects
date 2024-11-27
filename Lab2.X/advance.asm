#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00 ; PC = 0x00
initial:
    MOVLW 0x0A ; WREG = 0x05
    MOVWF 0x00 ; [0x000] = 0x05
    MOVLW 0x03 ; WREG = 0x02
    MOVWF 0x18 ; [0x018] = 0x02
    LFSR 0, 0x000 ; FSR0 point to 0x000
    LFSR 1, 0x018 ; FSR1 point to 0x018
main:
    MOVF POSTINC0, W ; WREG = [FSR0] ; FSR0++
    ADDWF INDF1, W ; WREG = [FSR0] + [FSR1]
    MOVWF POSTDEC0 ; [FSR0] = WREG ; FSR0-- 
    MOVF POSTDEC1, W ; WREG = [FSR1] ; FSR1--
    SUBWF POSTINC0, W ; WREG = [FSR0] - [FSR1] ; FSR0++
    MOVWF INDF1 ; [FSR1 - 1] = WREG
    GOTO Loop
Loop:
    MOVF FSR0L, W
    CPFSEQ FSR1L ; If FSR0L == FSR1L
        GOTO main

end