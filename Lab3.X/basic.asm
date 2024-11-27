List p = 18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00 ; PC = 0x00
    initial:
	MOVLW b'11110000' ; WREG = 11010111
        MOVWF TRISA ; TRISA = WREG
    Arithmetic:
        MOVF TRISA, WREG ; WREG = TRISA
	RLCF WREG, WREG ; Carry = TRISA[7]
        RRCF TRISA, 1 ; Rotate Right TRISA with carry
    Logical:
        RRNCF TRISA, 1 ; Rotate Right TRISA without carry
        MOVLW b'01111111' ; WREG = 01111111
        ANDWF TRISA, 1 ; Make TRISA[7] = 0
	
    end