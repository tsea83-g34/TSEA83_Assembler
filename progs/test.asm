const SP r15
const NULL r14
const BP r13
const RR r12


        subi SP, SP, 1
        call main
        subi SP, SP, 2
__halt:
        rjmp __halt

main:
        move BP, SP
        subi SP, SP, 2
        addi r0, NULL, 2
        addi SP, SP, 2
        move RR, NULL
        ret

