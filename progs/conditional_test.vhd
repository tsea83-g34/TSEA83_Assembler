library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"8fff0001", -- subi r15 r15 1
X"f7dd0005", -- movlo r13 r13 5
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"33000003", -- rjmp main
X"8fff0002", -- subi r15 r15 2
X"33000000", -- rjmp __halt [__halt]
X"cfdf0000", -- move r13 r15 [main]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b4e0000", -- addi r4 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b5e0000", -- addi r5 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b6e0000", -- addi r6 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b7e00ff", -- addi r7 r14 255
X"8fff0002", -- subi r15 r15 2
X"f3880000", -- movhi r8 r8 0
X"f788ffff", -- movlo r8 r8 65535
X"e7000000", -- out 00 r0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"e3000000", -- cmpi r0 0
X"23000003", -- brlt L0
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L1
X"8b0e0001", -- addi r0 r14 1 [L0]
X"d2d1fffc", -- store r13 r1 -4 [2] [L1]
X"d2d2fffa", -- store r13 r2 -6 [2]
X"d2d3fff8", -- store r13 r3 -8 [2]
X"d2d4fff6", -- store r13 r4 -10 [2]
X"d2d5fff4", -- store r13 r5 -12 [2]
X"d2d6fff2", -- store r13 r6 -14 [2]
X"d2d7fff0", -- store r13 r7 -16 [2]
X"d2d8ffee", -- store r13 r8 -18 [2]
X"e3000001", -- cmpi r0 1
X"1f000005", -- brne L2
X"820dfff0", -- load r0 r13 -16 [2]
X"cf100000", -- move r1 r0
X"d2d1fffc", -- store r13 r1 -4 [2]
X"33000037", -- rjmp L3
X"82df0000", -- load r13 r15 0 [2] [L2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0033", -- subi r13 r13 51
X"ef0d0000", -- rjmprg r13
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L4
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L5
X"8b0e0001", -- addi r0 r14 1 [L4]
X"e3000001", -- cmpi r0 1 [L5]
X"1f000005", -- brne L6
X"820dfff0", -- load r0 r13 -16 [2]
X"cf100000", -- move r1 r0
X"d2d1fffa", -- store r13 r1 -6 [2]
X"33000028", -- rjmp L7
X"820dfffe", -- load r0 r13 -2 [2] [L6]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L8
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L9
X"8b0e0001", -- addi r0 r14 1 [L8]
X"e3000001", -- cmpi r0 1 [L9]
X"1f000005", -- brne L10
X"820dfff0", -- load r0 r13 -16 [2]
X"cf100000", -- move r1 r0
X"d2d1fff8", -- store r13 r1 -8 [2]
X"3300001c", -- rjmp L11
X"820dfffe", -- load r0 r13 -2 [2] [L10]
X"e3000000", -- cmpi r0 0
X"2b000003", -- brle L12
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L13
X"8b0e0001", -- addi r0 r14 1 [L12]
X"e3000001", -- cmpi r0 1 [L13]
X"1f000005", -- brne L14
X"820dfff0", -- load r0 r13 -16 [2]
X"cf100000", -- move r1 r0
X"d2d1fff6", -- store r13 r1 -10 [2]
X"33000010", -- rjmp L15
X"820dfffe", -- load r0 r13 -2 [2] [L14]
X"e3000000", -- cmpi r0 0
X"2f000003", -- brge L16
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L17
X"8b0e0001", -- addi r0 r14 1 [L16]
X"e3000001", -- cmpi r0 1 [L17]
X"1f000005", -- brne L18
X"820dfff0", -- load r0 r13 -16 [2]
X"cf100000", -- move r1 r0
X"d2d1fff4", -- store r13 r1 -12 [2]
X"33000004", -- rjmp L19
X"820dfff0", -- load r0 r13 -16 [2] [L18]
X"cf100000", -- move r1 r0
X"d2d1fff2", -- store r13 r1 -14 [2]
X"820dffee", -- load r0 r13 -18 [2] [L19] [L15] [L11] [L7] [L3]
X"e7000000", -- out 00 r0
X"8bce0000", -- addi r12 r14 0
X"8bff0012", -- addi r15 r15 18
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd006d", -- subi r13 r13 109
X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);

end program_file;
