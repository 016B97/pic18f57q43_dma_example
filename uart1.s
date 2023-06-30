; PIC Assembler Example (DMA Demo)
; Tested with PIC18F57Q43 Curiosity Nano Board


#include <xc.inc>
#include "defines.inc"

global init_uart1

psect code


init_uart1:
    movlw	0x01 ; 9600Baud @64MHz
    banksel	U1BRGH 
    movwf	BANKMASK(U1BRGH),b

    movlw	0x9F
    banksel	U1BRGL
    movwf	BANKMASK(U1BRGL),b

    movlw	0b00110000
    banksel	U1CON0
    movwf	BANKMASK(U1CON0),b

    movlw	0b00000000
    banksel	U1CON2
    movwf	BANKMASK(U1CON2),b

    movlw	0b10000000
    banksel	U1CON1
    movwf	BANKMASK(U1CON1),b

    banksel	PIE4
    bsf		U1RXIE

    return

