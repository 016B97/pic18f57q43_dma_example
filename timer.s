; PIC Assembler Example (DMA Demo)
; Tested with PIC18F57Q43 Curiosity Nano Board

    
#include <xc.inc>
#include "defines.inc"
  
global timer_handler,init_timer
      
psect udata_acs  ; access bank
PSC1:
    DS 1 ; reserve 1 byte for PSC1
 
psect code

;------------------------------------------------------------------------------- 
timer_handler:
    
    decfsz  BANKMASK(PSC1),a
    return

    btg	    BOARD_LED

    return
    
;-------------------------------------------------------------------------------

init_timer:
    clrf	BANKMASK(PSC1),a
    
    banksel	T0CON1
    movlw	0b01010111
    movwf	BANKMASK(T0CON1),b
    
    banksel	T0CON0
    movlw	0b00000000
    movwf	BANKMASK(T0CON0),b
    bsf		BANKMASK(T0CON0),T0CON0_EN_POSN,b
    
    bcf		TMR0IF
    bsf		TMR0IE
    
    return
;-------------------------------------------------------------------------------
    