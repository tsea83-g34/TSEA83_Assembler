const VGA 0x200 ; Maybe have const32 for 32 bits
const FLAGS r21
const KEY r22
const KEY_IDX 1<<3
const ENTER 31
const BACKSPACE 32 
const tile_idx r6 



PRINT_BACKSPACE:
    subi tile_idx, tile_idx, 1
    store r0, tile_idx, VGA
    jmp MAIN

PRINT_CHAR: 
    
    // check if ENTER, BACKSPACE?
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







/*

%macro store2 3

%end

fn put_char 3
    // Done automatic: pop r1, r2, r3
    var offset
    add offset, offset, r1
    muli offset, offset, 20
    add offset, offset, r2
    addi offset, offset, VGA  
    store r1, offset
end fn 


put_char 10, 0, 'H' 
put_char 10, 1, 'e'

fn put_str (y, x, msg)
    var len, character, i
    strlen msg => len
    for i, 0, len {
        store character, msg, i
        put_char y, x, character
        inc x 
    } 
end fn 

put_str 10, 0, "Hello World!"

*/