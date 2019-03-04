    movhi r1, 0000
    movhi r2, 0000
    addi r1, r1, 0008
    addi r2, r2, 0020
    lw r3, 0000(r2)
    lw r4, 0020(r2)
    muls r5, r4, r3
    add r6, r6, r5
    addi r2, r2, 0004
    addi r1, r1, FFFF
    sfne r0, r1
    bf 0000010
    sw 0000(r0), r6