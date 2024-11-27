#include"xc.inc"
GLOBAL _lcm
    
PSECT mytext, local, class=CODE, reloc=2
 
_lcm:
    MOVFF 0x01, LATA ; LATA = a
    MOVFF 0x03, LATB ; LATB = b
    MOVFF 0x01, WREG
    CPFSLT 0x03
    GOTO gcd_1
    GOTO gcd_2
gcd_1:
    MOVFF 0x01, WREG
    SUBWF 0x03, 1
    CPFSLT 0x03
    GOTO gcd_1
    TSTFSZ 0x03
    GOTO gcd_2
    MOVFF 0x01, LATC ; LATC = gcd(a,b)
    GOTO relay
gcd_2:
    MOVFF 0x03, WREG
    SUBWF 0x01, 1
    CPFSLT 0x01
    GOTO gcd_2
    TSTFSZ 0x01
    GOTO gcd_1
    MOVFF 0x03, LATC ; LATC = gcd(a,b)
    GOTO relay
relay:
    MOVLW 0x00
    MOVWF 0x01
    MOVWF 0x02
    MOVLW 0xFF
    MOVWF TRISC
    MOVFF LATA, WREG
    MULWF LATB ; a*b
    MOVFF PRODH, TRISA
    MOVFF PRODL, TRISB
    GOTO division_loop_high
minus_high:
    DECF TRISA
    MOVFF LATC, WREG
    SUBWF TRISC, 0
    ADDWF TRISB, 1
    INCF TRISB, 1
    MOVLW 0xFF
    CPFSLT 0x01
    GOTO add_num_2
    GOTO add_num_1
division_loop_high:
    MOVFF LATC, WREG
    CPFSLT TRISB
    GOTO division_loop_low
    TSTFSZ TRISA
    GOTO minus_high
    GOTO finish
division_loop_low:
    SUBWF TRISB, 1
    MOVLW 0xFF
    CPFSLT 0x01
    GOTO add_num_2
    GOTO add_num_1
add_num_1:
    MOVFF LATC, WREG
    INCF 0x01, 1
    CPFSLT TRISB
    GOTO division_loop_low
    GOTO division_loop_high
add_num_2:
    INCF 0x02
    MOVLW 0x00
    MOVWF 0x01
    MOVFF LATC, WREG
    CPFSLT TRISB
    GOTO division_loop_low
    GOTO division_loop_high
finish:
    RETURN