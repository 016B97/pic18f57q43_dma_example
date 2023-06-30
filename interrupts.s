; PIC Assembler Example (DMA Demo)
; Tested with PIC18F57Q43 Curiosity Nano Board

    
#include <xc.inc>

extrn timer_handler, dma1_start, dma2_start
    
psect   int_vec_hi,class=CODE, reloc=2
    PAGESEL high_isr
    goto    high_isr
    
;------------------------------------------------------------------------------
    
psect code   
 
high_isr:
    btfsc   TMR0IF
    call    isr_timer0

    btfsc   DMA1DCNTIF
    call    dma1_dst_interrupt
    
    btfsc   DMA2DCNTIF
    call    dma2_dst_interrupt
    
    retfie  1 ;restore registers from shadow         
;------------------------------------------------------------------------------

isr_timer0:
    bcf	    TMR0IF
    PAGESEL timer_handler
    call    timer_handler
    return
;------------------------------------------------------------------------------
   
; this example starts receiving, when dma send is done
; if you need a continous receive you have to work with two buffers
      
;------------------------------------------------------------------------------      
dma1_dst_interrupt:
    bcf	    DMA1DCNTIF
   
    PAGESEL dma2_start
    call    dma2_start

    return
  ;------------------------------------------------------------------------------
dma2_dst_interrupt:
    bcf	    DMA2DCNTIF
   
    PAGESEL dma1_start
    call    dma1_start

    return
  ;------------------------------------------------------------------------------
  