# COMMENT
const VGA 0x200
const FLAGS r21
const KEY r22
# COMMENT
const KEY_IDX 1<<3
const ENTER 31
const BACKSPACE 32 
const tile_idx r6 


# COMMENT

rjmp MAIN

PRINT_BACKSPACE:
    subi tile_idx, tile_idx, 1
    store tile_idx, r0, VGA
    rjmp MAIN

PRINT_CHAR: 
    
    cmpi KEY, BACKSPACE 
    breq PRINT_BACKSPACE

    store tile_idx, KEY, VGA
    subi FLAGS, FLAGS, KEY_IDX  
    addi tile_idx, tile_idx, 1
    rjmp MAIN


CHECK_KEY_DOWN:
    movlo r1, KEY_IDX
    and r1, FLAGS, r1
    cmpi r1, 1 
    brgt PRINT_CHAR  
    rjmp MAIN




MAIN:
    rjmp CHECK_KEY_DOWN






