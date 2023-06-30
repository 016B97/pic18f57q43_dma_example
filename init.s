; PIC Assembler Example (DMA Demo)
; Tested with PIC18F57Q43 Curiosity Nano Board

   
#include <xc.inc>
#include "defines.inc"
  
global init    
extrn init_timer, init_uart1, dma1_init, dma1_start, dma2_init
    
psect code

init:
;-----------------------------------------------------------------------------    
    movlw   PORTA_IO
    movwf   BANKMASK(TRISA),a
    movlw   PORTB_IO
    movwf   BANKMASK(TRISB),a
    movlw   PORTC_IO
    movwf   BANKMASK(TRISC),a
    movlw   PORTD_IO
    movwf   BANKMASK(TRISD),a
    movlw   PORTE_IO
    movwf   BANKMASK(TRISE),a
    movlw   PORTF_IO    
    movwf   BANKMASK(TRISF),a
;-----------------------------------------------------------------------------    
    banksel ANSELA
    clrf    BANKMASK(ANSELA),b
    banksel ANSELB
    clrf    BANKMASK(ANSELB),b
    banksel ANSELC
    clrf    BANKMASK(ANSELC),b
    banksel ANSELD
    clrf    BANKMASK(ANSELD),b
    banksel ANSELE
    clrf    BANKMASK(ANSELE),b
    banksel ANSELF
    clrf    BANKMASK(ANSELF),b
;-----------------------------------------------------------------------------        
    banksel RF0PPS
    movlw   0x20 ;TX1 to RF0
    movwf   BANKMASK(RF0PPS),b
 
    banksel U1RXPPS
    movlw   0b00101001 ;RX1 to RF1
    movwf   BANKMASK(U1RXPPS),b
    
    banksel PPSLOCK
    movlw   0x55
    movwf   BANKMASK(PPSLOCK),b
    movlw   0xAA
    movwf   BANKMASK(PPSLOCK),b
    bsf	    PPSLOCKED
;-----------------------------------------------------------------------------    
    PAGESEL	init_timer
    call	init_timer
    PAGESEL	init_uart1
    call	init_uart1

;-----------------------------------------------------------------------------
    
    banksel PRLOCK  ;priority lock is required for DMA 
    movlw   0x55
    movwf   BANKMASK(PRLOCK),b
    movlw   0xAA
    movwf   BANKMASK(PRLOCK),b
    bsf	    PRLOCKED
    
    PAGESEL	dma2_init
    call	dma2_init
    
    PAGESEL	dma1_init
    call	dma1_init
    PAGESEL	dma1_start
    call	dma1_start
;-----------------------------------------------------------------------------
   
    bcf		BOARD_LED
    
    bsf		GIEH
    
    return
    