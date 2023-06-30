; PIC Assembler Example (DMA Demo)
; Tested with PIC18F57Q43 Curiosity Nano Board

   
#define	PORTA_IO 11111111B
#define	PORTB_IO 11111111B
#define	PORTC_IO 11111111B
#define PORTD_IO 11111111B
#define PORTE_IO 11111111B
#define PORTF_IO 11110111B

#define BOARD_LED	 BANKMASK(LATF),3,a

