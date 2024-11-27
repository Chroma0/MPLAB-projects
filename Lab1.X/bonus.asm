List p = 18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    initial:
	CLRF WREG
	CLRF 0x00
	CLRF 0x01
	CLRF 0x02
    main:
	MOVLW d'0'
	MOVWF 0x00;a
	MOVWF 0x01;ans
	MOVWF 0x02
	RRCF 0x02, f, 0;b
	;a = bar(a) & b
	COMF 0x00, f
	MOVF 0x02, W
	ANDWF 0x00, f
	;b = a & bar(b)
	COMF 0x02, f
	MOVF 0x01, W
	ANDWF 0x02, f
	;ans = a | b
	MOVF 0x00, W
	IORWF 0x02, W
	MOVWF 0x01
	CLRF 0x00
	CLRF 0x02
	CLRF WREG
    end