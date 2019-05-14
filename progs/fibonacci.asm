const SP r15 
const NULL r14
const temp r13
const fib_n r1 
const x r2 
const y r3

addi SP, SP, 0x200

addi fib_n, fib_n, 10-2 ; 10th fibonacci number
addi x, x, 1 
FIB:
    subi fib_n, fib_n, 1
    move temp, x 
    add x, x, y 
    move y, temp 
    cmpi fib_n, 0
    brgt FIB 
out 0, x 
halt
