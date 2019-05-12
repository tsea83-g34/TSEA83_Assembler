addi r1, r0, 10 # r1 = 10
add r1, r1, r1  # r1 = 20
store[4] r0, r1, 2  # mem(22) = 0
load[4] r2, r0, 2   # r2 = 0
movlo r3, 3 # r3 = 3
mul r3, r2, r3  # r3 = 3*0 = 0
