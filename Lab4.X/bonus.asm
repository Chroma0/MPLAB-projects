List p = 18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ; PC = 0x00
    initial:
	MOVLW 0x08 ; n
	MOVWF 0x10 ; [0x10] = n
	MOVLW 0x04 ; k
	MOVWF 0x11 ; [0x11] = k
	MOVLW 0x00
	MOVWF 0x20
	MOVLW 0x01
	MOVWF 0x21
	MOVWF 0x22
	MOVLW 0xff
	MOVWF 0x50
	RCALL Fact
	MOVF 0x22, WREG ; WREG = [0x21]
	GOTO division_loop_high
    minus_high:
	DECF 0x20
	SUBWF 0x50, WREG
	ADDWF 0x21, f
	INCF 0x21, f
	INCF 0x00, f
	MOVF 0x22, WREG
	GOTO division_loop_low
    division_loop_high:
	CPFSLT 0x21
	GOTO division_loop_low
	TSTFSZ 0x20
	GOTO minus_high
	GOTO finish
    division_loop_low:
	SUBWF 0x21, f
	INCF 0x00, f
	CPFSLT 0x21
	GOTO division_loop_low
	GOTO division_loop_high	
    Fact:
	MOVF 0x11, WREG ; WREG = k
	MULLW 0x02 ; PRODL = k*2
	MOVF 0x10, WREG ; WREG = n
	CPFSLT PRODL ; Skip if( 2k < n )
	GOTO fun1
	GOTO fun2
    fun1:
	MOVF 0x11, WREG ; WREG = k
	SUBWF 0x10, WREG ; WREG = n - k
	MOVWF 0x31 ; [0x31] = i
	MOVFF 0x10, 0x30 ; [0x30] = n
    loop1:
	MOVF 0x30, WREG ; WREG = [0x30]
	MULWF 0x21
	MOVFF PRODL, 0x41
	MOVFF PRODH, 0x40
	MULWF 0x20
	MOVF PRODL, WREG
	ADDWF 0x40, f
	MOVFF 0x41, 0x21
	MOVFF 0x40, 0x20
	DECF 0x30, f ; [0x30]--
	MOVF 0x31, WREG ; WREG = [0x31]
	MULWF 0x22
	MOVFF PRODL, 0x22
	DECFSZ 0x31 ; i--
	GOTO loop1
	GOTO fun_fin
    fun2:
	MOVF 0x11, WREG ; WREG = k
	MOVWF 0x31 ; [0x31] = i
	MOVFF 0x10, 0x30 ; [0x30] = n
    loop2:
	MOVF 0x30, WREG ; WREG = [0x30]
	MULWF 0x21
	MOVFF PRODL, 0x41
	MOVFF PRODH, 0x40
	MULWF 0x20
	MOVF PRODL, WREG
	ADDWF 0x40, 0x20
	MOVFF 0x41, 0x21
	DECF 0x30, f ; [0x30]--
	MOVF 0x31, WREG ; WREG = [0x31]
	MULWF 0x22
	MOVFF PRODL, 0x22
	DECFSZ 0x31 ; i--
	GOTO loop2
	GOTO fun_fin
    fun_fin:
	RETURN
    finish:
	
    end