#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00 ; PC = 0x00
initial:
    MOVLB 0x1 ; BSR = 1
    MOVLW 0x10 ; WREG = 0xB5
    MOVWF 0x00, 1 ; [0x100] = 0xB5
    MOVLW 0x02 ; WREG = 0xF8
    MOVWF 0x01, 1 ; [0x101] = 0xF8
    MOVLW 0x04 ; WREG = 0x64
    MOVWF 0x02, 1 ; [0x102] = 0x64
    MOVLW 0x58 ; WREG = 0x7F
    MOVWF 0x03, 1 ; [0x103] = 0x7F
    MOVLW 0x2C ; WREG = 0xA8
    MOVWF 0x04, 1 ; [0x104] = 0xA8
    MOVLW 0x5D ; WREG = 0x15
    MOVWF 0x05, 1 ; [0x105] = 0x15
    LFSR 0, 0x100 ; FSR0 point to 0x100
    LFSR 1, 0x105 ; FSR1 point to 0x105
main:
    MOVF FSR0L, W
    MOVWF 0x01, 0 ; [0x001] = FSR0L (Left)
    MOVF FSR1L, W
    MOVWF 0x02, 0 ; [0x002] = FSR1L (Right)
    MOVF 0x01, W ; WREG = FSR0L
    SUBWF 0x02, W ; WREG = FSR1L - FSR0L
    MOVWF 0x00, 0 ; [0x000] = FSR1L - FSR0L (i)
    TSTFSZ 0x00, 0 ; Check if i == 0
    GOTO Loop1
    GOTO fin
    Loop1:
	MOVF POSTINC0, W
	CPFSGT INDF0 ; Skip if [FSR0] < [FSR0 + 1]
	GOTO SWAP1
    Next1:
	DECFSZ 0x00 ; i--
	GOTO Loop1
    DECF 0x02, 1, 0 ; Right--
    MOVFF 0x001, FSR0L
    MOVFF 0x002, FSR1L
    MOVF FSR0L, W
    MOVWF 0x01, 0 ; [0x001] = FSR0L (Left)
    MOVF FSR1L, W
    MOVWF 0x02, 0 ; [0x002] = FSR1L (Right)
    MOVF 0x01, W ; WREG = FSR0L
    SUBWF 0x02, W ; WREG = FSR1L - FSR0L
    MOVWF 0x00, 0 ; [0x000] = FSR1L - FSR0L (i)
    TSTFSZ 0x00, 0 ; Check if i == 0
    GOTO Loop2
    GOTO fin
    Loop2:
	MOVF POSTDEC1, W
	CPFSLT INDF1 ; Skip if [FSR1 - 1] < [FSR1]
	GOTO SWAP2
    Next2:
	DECFSZ 0x00 ; i--
	GOTO Loop2
    INCF 0x01, 1, 0 ; Left++
    MOVFF 0x001, FSR0L
    MOVFF 0x002, FSR1L
    GOTO Loop
    SWAP1:
	MOVFF INDF0, 0x003
	MOVWF POSTDEC0
	MOVFF 0x003, POSTINC0
	GOTO Next1
    SWAP2:
	MOVFF INDF1, 0x003
	MOVWF POSTINC1
	MOVFF 0x003, POSTDEC1
	GOTO Next2
    Loop:
	MOVF FSR0L, W
	CPFSLT FSR1L ; Skip if FSR0L < FSR1L
	GOTO main
    fin:
	MOVLW 0x06
	MOVWF 0x00, 0
	LFSR 0, 0x100 ; FSR0 point to 0x100
	LFSR 1, 0x110 ; FSR1 point to 0x110
    Set_num:
	MOVFF POSTINC0, POSTINC1
	DECFSZ 0x00 ; i--
	GOTO Set_num
	
end