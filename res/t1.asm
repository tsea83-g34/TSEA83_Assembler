movhi r1, 1337
add r3, r2, r1
addi r3, r2, 10
load r3, r1

DIFF_LINE:
addi r3,r2,10
jmp DIFF_LINE

STUFF: addi r1, r1, 6969
jmp LOAD
addi r3, r1, 1337

LOAD: load r2, r1