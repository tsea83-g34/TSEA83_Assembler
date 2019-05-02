mem := (
--$PROGRAM
X"add r0 r0 r1: cb001000",
X"addi r1 r1 1: c7110001",
X"pop r9: 0b900000",
X"jmpreg r9: 07900000",
X"movlo r9 8: 17980008",
X"push r9: db900000",
X"jmp INC: 0700fffb"
--$PROGRAM_END
);