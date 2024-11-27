#include"xc.inc"
GLOBAL _is_square
    
PSECT mytext, local, class=CODE, reloc=2
 
_is_square:
    MOVLW 0x01
    MOVWF LATB ; LATB = 1
    MOVLW 0x00
    MOVWF LATA ; LATA = i
    GOTO Check
Check:
    INCF LATA ; i++
    MOVFF LATA, WREG
    MULWF LATA ; i*i
    MOVFF LATB, WREG
    CPFSLT PRODH ; check if 16*16
    GOTO false
    GOTO loop
loop:
    MOVFF PRODL, WREG
    CPFSEQ 0x01 ; check if i*i == [0x01]
    GOTO Check
    GOTO true
true:
    MOVLW 0x01
    MOVWF 0x01
    GOTO final
false:
    MOVLW 0xFF
    MOVWF 0x01
    GOTO final
final:
    RETURN