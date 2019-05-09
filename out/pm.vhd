mem := (
--$PROGRAM
X"8b10000a", -- addi r1 r0 10
X"93111000", -- add r1 r1 r1
X"d3010002", -- store r0 r1 2 [4]
X"83200002", -- load r2 r0 2 [4]
X"f7300003", -- movlo r3 3
X"a7323000", -- mul r3 r2 r3,
--$PROGRAM_END
others => X"00000000"
);