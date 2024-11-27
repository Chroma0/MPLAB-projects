#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00 ; PC = 0x00
initial:
    MOVLB 0x1 ; BSR = 1
    MOVLW 0x15 ; WREG = 0x03
    MOVWF 0x00, 1 ; [0x100] = 0x03
    MOVLW 0x12 ; WREG = 0x08
    MOVWF 0x01, 1 ; [0x101] = 0x08
    LFSR 0, 0x100 ; FSR0 point to 0x100
    LFSR 1, 0x101 ; FSR1 point to 0x101
    LFSR 2, 0x102 ; FSR2 point to 0x102
main:
    ; Check if the address is even or odd
    BTFSC FSR2L, 0
	GOTO odd
    GOTO even
even:
    MOVF POSTINC0, W ; WREG = [FSR0] ; FSR0++
    ADDWF POSTINC1, W ; WREG = [FSR1] + [FSR0] ; FSR1++
    MOVWF POSTINC2 ; [FSR2] = WREG ; FSR2++
    GOTO Loop
odd:
    MOVF POSTINC0, W ; WREG = [FSR0] ; FSR0++
    SUBWF POSTINC1, W ; WREG = [FSR1] - [FSR0] ; FSR1++
    MOVWF POSTINC2 ; [FSR2] = WREG ; FSR2++
    GOTO Loop
Loop:; Check if we've reached [0x108]
    MOVLW 0x08
    CPFSGT FSR2L ; If FSR2L > 0x08
        GOTO main

end
    