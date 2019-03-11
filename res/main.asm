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

jmp MAIN

PRINT_BACKSPACE:
    subi tile_idx, tile_idx, 1
    store r0, tile_idx, VGA
    jmp MAIN

PRINT_CHAR: 
    
    cmpi KEY, BACKSPACE 
    breq PRINT_BACKSPACE

    store KEY, tile_idx, VGA
    subi FLAGS, FLAGS, KEY_IDX  
    addi tile_idx, tile_idx, 1
    jmp MAIN


CHECK_KEY_DOWN:
    movlo r1, KEY_IDX
    and r1, FLAG, r1
    cmpi r1, 1 
    brg PRINT_CHAR  
    jmp MAIN




MAIN:
    jmp CHECK_KEY_DOWN






