; PIC Assembler Example (DMA Demo)
; Tested with PIC18F57Q43 Curiosity Nano Board


#include <xc.inc>
#include "defines.inc"

global dma1_init,dma1_start,dma2_init,dma2_start

psect udata_bank6
DMA_BUF:
    DS 8 ; reserve 8 bytes for dma buf
     
;------------------------------------------------------------------------------
    
psect code

dma1_init:  ; receive from UART1 via DMA1
    movlw   0x00 ; select DMA channel 1
    banksel DMASELECT
    movwf   BANKMASK(DMASELECT),b
    
    banksel DMAnCON0   
    clrf    BANKMASK(DMAnCON0),b
        
    movlw   01100000B
    banksel DMAnCON1
    movwf   BANKMASK(DMAnCON1),b
         
    movlw   0x00
    banksel DMAnSSZH  ; source size    
    movwf   BANKMASK(DMAnSSZH),b
    movlw   0x01
    banksel DMAnSSZL    
    movwf   BANKMASK(DMAnSSZL),b
    
    banksel DMAnSSAU 
    clrf    BANKMASK(DMAnSSAU),b    
    movlw   HIGH(U1RXB)  ; load address of U1RXB
    banksel DMAnSSAH  
    movwf   BANKMASK(DMAnSSAH),b    
    movlw   LOW(U1RXB) 
    banksel DMAnSSAL
    movwf   BANKMASK(DMAnSSAL),b
         
    movlw   0x00   ; dest size
    banksel DMAnDSZH
    movwf   BANKMASK(DMAnDSZH),b     
    movlw   0x08
    banksel DMAnDSZL
    movwf   BANKMASK(DMAnDSZL),b
     
    movlw   HIGH(DMA_BUF)  ; dest start address of DMA_BUF
    banksel DMAnDSAH
    movwf   BANKMASK(DMAnDSAH),b    
    movlw   LOW(DMA_BUF)
    movwf   BANKMASK(DMAnDSAL),b
     
    movlw   0x20 ;UART 1 RX IRQ
    banksel DMAnSIRQ
    movwf   BANKMASK(DMAnSIRQ),b
    
    banksel DMAnCON0
    movlw   10000000B
    movwf   BANKMASK(DMAnCON0),b
    
    bcf	    DMA1DCNTIF
    bsf	    DMA1DCNTIE 
        
    return
;------------------------------------------------------------------------------
dma1_start:
    movlw   0x00 ; select DMA channel 1
    banksel DMASELECT
    movwf   BANKMASK(DMASELECT),b
    
    banksel DMAnCON0
    bsf	    SIRQEN
    
    return
;------------------------------------------------------------------------------  
dma2_init:  ; send over UART1 via 2
    movlw   0x01  ; select dma channel 2
    banksel DMASELECT
    movwf   BANKMASK(DMASELECT),b
    
    banksel DMAnCON0   
    clrf    BANKMASK(DMAnCON0),b
        
    movlw   00000011B
    banksel DMAnCON1
    movwf   BANKMASK(DMAnCON1),b
             
    movlw   0x00   ; source size
    banksel DMAnSSZH 
    movwf   BANKMASK(DMAnSSZH),b        
    movlw   0x08
    banksel DMAnSSZL
    movwf   BANKMASK(DMAnSSZL),b
    
    banksel DMAnSSAU 
    clrf    BANKMASK(DMAnSSAU),b   
    movlw   HIGH(DMA_BUF)  ; source start address of DMA_BUF  
    banksel DMAnSSAH
    movwf   BANKMASK(DMAnSSAH),b    
    movlw   LOW(DMA_BUF)
    banksel DMAnSSAL
    movwf   BANKMASK(DMAnSSAL),b
           
    movlw   0x00  ; dest size
    banksel DMAnDSZH  
    movwf   BANKMASK(DMAnDSZH),b       
    movlw   0x01
    banksel DMAnDSZL
    movwf   BANKMASK(DMAnDSZL),b
    
    movlw   HIGH(U1TXB)   ; load address of U1TXB
    banksel DMAnDSAH
    movwf   BANKMASK(DMAnDSAH),b    
    movlw   LOW(U1TXB)
    banksel DMAnDSAL
    movwf   BANKMASK(DMAnDSAL),b
 
    movlw   0x21
    banksel DMAnSIRQ
    movwf   BANKMASK(DMAnSIRQ),b
    
    banksel DMAnCON0
    movlw   10000000B
    movwf   BANKMASK(DMAnCON0),b
    
    bcf	    DMA2DCNTIF
    bsf	    DMA2DCNTIE 
    
    return
 ;------------------------------------------------------------------------------
 dma2_start:
    movlw   0x01 ; select DMA channel 2
    banksel DMASELECT
    movwf   BANKMASK(DMASELECT),b

    banksel DMAnCON0
    bsf	    SIRQEN
    
    return
;------------------------------------------------------------------------------ 