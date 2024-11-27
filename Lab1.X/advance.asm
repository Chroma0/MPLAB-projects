List p = 18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    ;Set 0x000,0x002
    initial:
	CLRF WREG
	MOVLW 0xEA
	CLRF 0x00
	MOVWF 0x00
	MOVLW 0x20
	CLRF 0x02
	MOVWF 0x02
	MOVLW 0x08
	CLRF 0x01
	MOVWF 0x01
    ;Program
    Loop:
	BTFSS 0x00, 0
	GOTO Increase
	GOTO Decrease
    Increase:
	INCF 0x02, f
	RRNCF 0x00
	DECFSZ 0x01
	GOTO Loop
	GOTO fin
    Decrease:
	DECF 0x02, f
	RRNCF 0x00
	DECFSZ 0x01
	GOTO Loop
	GOTO fin
    fin:
	CLRF 0x01
	CLRF WREG
    end