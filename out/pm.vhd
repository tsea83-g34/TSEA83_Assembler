mem := (
--$PROGRAM
X"cfdf0000", -- move r13 r15
X"810d0002", -- load r0 r13 2 [2]
X"8fff0004", -- subi r15 r15 4
X"831dfffc", -- load r1 r13 -4 [4]
X"0f100000", -- in r1 r0
X"cfc10000", -- move r12 r1
X"8bff0004", -- addi r15 r15 4
X"83df0000", -- load r13 r15 0
X"8bff0001", -- addi r15 r15 1
X"8fdd000a", -- subi r13 r13 10
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15
X"830d0004", -- load r0 r13 4 [4]
X"811d000a", -- load r1 r13 10 [2]
X"e7100000", -- out r1 r0
X"d1d1000a", -- store r13 r1 10 [2]
X"cfce0000", -- move r12 r14
X"83df0000", -- load r13 r15 0
X"8bff0001", -- addi r15 r15 1
X"8fdd0014", -- subi r13 r13 20
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15
X"830d0004", -- load r0 r13 4 [4]
X"811d000a", -- load r1 r13 10 [2]
X"eb100000", -- vgaw r1 r0
X"d1d1000a", -- store r13 r1 10 [2]
X"cfce0000", -- move r12 r14
X"83df0000", -- load r13 r15 0
X"8bff0001", -- addi r15 r15 1
X"8fdd001e", -- subi r13 r13 30
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15
X"810d0002", -- load r0 r13 2 [2]
X"811d0004", -- load r1 r13 4 [2]
X"812d0006", -- load r2 r13 6 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L0
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L1
X"8b0e0001", -- addi r0 r14 1
X"813d0002", -- load r3 r13 2 [2]
X"df031000", -- cmp r3 r1
X"23000003", -- brlt L2
X"8b3e0000", -- addi r3 r14 0
X"33000002", -- rjmp L3
X"8b3e0001", -- addi r3 r14 1
X"c3003000", -- or r0 r0 r3
X"cfc00000", -- move r12 r0
X"83df0000", -- load r13 r15 0
X"8bff0001", -- addi r15 r15 1
X"8fdd0033", -- subi r13 r13 51
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15
X"8bfffffe", -- addi r15 r15 -2
X"d1fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d1f00000", -- store r15 r0 0 [2]
X"8b0e2910", -- addi r0 r14 10512
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7d00044", -- movlo r13 68
X"8bffffff", -- addi r15 r15 -1
X"d3fd0000", -- store r15 r13 0
X"3300ffd2", -- rjmp vga_write
X"8bff000c", -- addi r15 r15 12
X"81df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d1fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0001", -- addi r0 r14 1
X"8bfffffe", -- addi r15 r15 -2
X"d1f00000", -- store r15 r0 0 [2]
X"8b0e2a10", -- addi r0 r14 10768
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7d00056", -- movlo r13 86
X"8bffffff", -- addi r15 r15 -1
X"d3fd0000", -- store r15 r13 0
X"3300ffc0", -- rjmp vga_write
X"8bff000c", -- addi r15 r15 12
X"81df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d1fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e2a0f", -- addi r0 r14 10767
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7d00065", -- movlo r13 101
X"8bffffff", -- addi r15 r15 -1
X"d3fd0000", -- store r15 r13 0
X"3300ffb1", -- rjmp vga_write
X"8bff000c", -- addi r15 r15 12
X"81df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d1fd0000", -- store r15 r13 0 [2]
X"8b0e0000", -- addi r0 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d1f00000", -- store r15 r0 0 [2]
X"8b0e2a10", -- addi r0 r14 10768
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7d00076", -- movlo r13 118
X"8bffffff", -- addi r15 r15 -1
X"d3fd0000", -- store r15 r13 0
X"3300ffa0", -- rjmp vga_write
X"8bff000a", -- addi r15 r15 10
X"81df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"cfce0000", -- move r12 r14
X"83df0000", -- load r13 r15 0
X"8bff0001", -- addi r15 r15 1
X"8fdd007e", -- subi r13 r13 126
X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);