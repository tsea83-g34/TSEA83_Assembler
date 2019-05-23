const NULL r14 
const IS_CTRL_DOWN 1<<10

%macro dec 1
    subi $0, $0, 1
%end

.data greeting
    .ds "Hello!"
.dh 1337
.dw 1<<30


MAIN:
    call is_ctrl_down
    pop[2] r2 
    cmpi r2, 0
    breq MAIN ; CTRL is not down, continue loop
    in r2, 0
    addi r3, NULL, 1<<8
    dec r3
    and r4, r2, r3 ; Mask out the key value
    cmpi r4, 'c' ; CTRL-C is down => halt
    brne MAIN
    halt 

is_ctrl_down:
    in r1, 0 
    addi r2, NULL, IS_CTRL_DOWN
    and r2, r1, r2 ; R2 := is_ctrl_down 
    push[2] r2 
    ret 

