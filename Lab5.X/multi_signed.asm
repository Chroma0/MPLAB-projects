#include"xc.inc"
GLOBAL _multi_signed
    
PSECT mytext, local, class=CODE, reloc=2
 
 _multi_signed:
    MOVWF 0x03
    BTFSC 0x03, 7 ; check if multiplicand is negative
    GOTO preprocess_1
next_2:
    BTFSC 0x01, 7 ; check if multiplier is negative
    GOTO preprocess_2
    GOTO start
preprocess_1:
    INCF LATB ; LATB represent ans is pos or neg
    MOVLW 0xFF ; WREG = 11111111(binary)
    XORWF 0x03, 1
    INCF 0x03, 1
    GOTO next_2
preprocess_2:
    INCF LATB
    MOVLW 0x02
    CPFSLT LATB
    SUBWF LATB, 1
    MOVLW 0xFF ; WREG = 11111111(binary)
    XORWF 0x01, 1
    INCF 0x01, 1
    GOTO start
start:
    MOVLW 0x04
    MOVWF LATA ; LATA = 4
loop:
    MOVFF 0x03, WREG
    BTFSC 0x01, 0
    GOTO add
    GOTO next
next:
    RLCF 0x03, 1
    BCF 0x03, 0, 0
    RLCF 0x04, 1
    RRNCF 0x01, 1
    DECF LATA
    TSTFSZ LATA
    GOTO loop
    BTFSC LATB, 0
    GOTO sign_unsign
    GOTO final
add:
    ADDWF LATD, 1 ; LATD represent lower 8 bits
    MOVFF 0x04, WREG
    ADDWFC LATC, 1 ; LATC represent higher 8 bits
    GOTO next
sign_unsign:
    MOVLW 0xFF
    XORWF LATC, 1
    XORWF LATD, 1
    INCF LATD, 1
    GOTO final
final:
    MOVFF LATD, 0x01
    MOVFF LATC, 0x02
    RETURN