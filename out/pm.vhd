mem := (
--$PROGRAM
X"83100009", -- load r1 r0 9
X"8b0e0009", -- addi r0 r14 9,
--$PROGRAM_END
others => X"00000000"
);