List p = 18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ; PC = 0x00
    
    Add_Mul macro xh,xl,yh,yl
	MOVF xl, WREG
	ADDWF yl, WREG ; xl + yl
	MOVWF 0x01 ; [0x01] = xl + yl
	
	MOVF xh, WREG
	ADDWFC yh, WREG ; xh + yh + C
	MOVWF 0x00 ; [0x00] = xh + yh + C
	
	MOVF 0x01, WREG
	MULWF 0x00 ; [0x00] * [0x01]
	
	MOVF 0x01, WREG
	BTFSC 0x00, 7 ; if( [0x00] < 0 )
	    SUBWF PRODH ; PRODH = PRODH - [0x01]
	
	MOVF 0x00, WREG
	BTFSC 0x01, 7 ; if( [0x01] < 0 )
	    SUBWF PRODH ; PRODH = PRODH - [0x00]
	    
	MOVFF PRODH, 0x10
	MOVFF PRODL, 0x11
	endm
    
    initial:
	MOVLW 0xff
	MOVWF 0x20 ; xh = 0x04
	MOVLW 0xeb
	MOVWF 0x21 ; xl = 0x02
	MOVLW 0x00
	MOVWF 0x22 ; yh = 0x0A
	MOVLW 0x0F
	MOVWF 0x23 ; yl = 0x04
	Add_Mul 0x20,0x21,0x22,0x23
	
    end
    
	