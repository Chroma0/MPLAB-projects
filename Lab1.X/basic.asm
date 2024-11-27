List p = 18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    ;Set x1
    CLRF WREG
    MOVLW 0x22
    CLRF 0x00
    MOVWF 0x00
    ;Set x2
    MOVLW 0x88
    CLRF 0x01
    MOVWF 0x01
    ;Set y1
    MOVLW 0xAF
    CLRF 0x02
    MOVWF 0x02
    ;Set y2
    MOVLW 0x04
    CLRF 0x03
    MOVWF 0x03
    ;x1+x2
    MOVF 0x00, W
    ADDWF 0x01, W
    CLRF 0x10
    MOVWF 0x10
    ;y1-y2 
    MOVF 0x03, W
    SUBWF 0x02, W
    CLRF 0x11
    MOVWF 0x11
    ;Compare 0x10,0x11
    MOVF 0x11, W
    CPFSEQ 0x10
    GOTO not_equal
    CLRF 0x20
    MOVLW 0xFF
    MOVWF 0x20
    GOTO fin
    not_equal:
        CLRF 0x20
        MOVLW 0x01
        MOVWF 0x20
    fin:
	CLRF WREG
    end