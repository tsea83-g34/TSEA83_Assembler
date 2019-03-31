const SP r14


fn min (x, y) {
    cmp x, y 
    brge min_y
    return x
min_y:  
    return y
}

movlo r1, 10
movlo r2, 20 
min(r1, r2) => r3







/*

min:
    push r1
    push r2 
    load r2, SP, -(1+2)
    load r1, SP, -(2+2)
    cmp r1, r2
    brge min_y
    pop r2
    pop r1 
    addi SP, SP, -2
    push r1 
min_y:
    push r2

movlo r1, 10
movlo r2, 20
push r1 
push r2 
call min 
pop r3


*/