; PIC Assembler Example (DMA Demo)
; Tested with PIC18F57Q43 Curiosity Nano Board

; custom linker options required
; -preset_vec=0h;-pint_vec_hi=8h
 
    
#include <xc.inc>

extrn init
    
psect reset_vec, class=CODE, reloc=2
reset_vec:
    PAGESEL start
    goto    start
 
psect code 
start:
    
    call    init
    
 
main:  
    bra	    main        ; idle loop
    
END reset_vec

  
    