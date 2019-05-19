library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"820e0002", -- load r0 r14 2 [2]
X"821e0004", -- load r1 r14 4 [2]
X"a7001000", -- mul r0 r0 r1
X"d2e00006", -- store r14 r0 6 [2]
X"820e0006", -- load r0 r14 6 [2]
X"d2e00008", -- store r14 r0 8 [2]
X"820e0006", -- load r0 r14 6 [2]
X"822e000a", -- load r2 r14 10 [2]
X"93002000", -- add r0 r0 r2
X"d2e0000c", -- store r14 r0 12 [2]
X"8fff0001", -- subi r15 r15 1
X"f7dd000f", -- movlo r13 r13 15
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300057d", -- rjmp main
X"8fff0002", -- subi r15 r15 2
X"33000000", -- rjmp __halt [__halt]
X"cfdf0000", -- move r13 r15 [in]
X"820d0002", -- load r0 r13 2 [2]
X"8fff0004", -- subi r15 r15 4
X"831dfffc", -- load r1 r13 -4 [4]
X"0f100000", -- in r1 0
X"cfc10000", -- move r12 r1
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd001b", -- subi r13 r13 27
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [out]
X"830d0004", -- load r0 r13 4 [4]
X"821d000a", -- load r1 r13 10 [2]
X"e7000000", -- out 0 r0
X"d3d00004", -- store r13 r0 4 [4]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0025", -- subi r13 r13 37
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [vga_write]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"eb100000", -- vgaw r1 r0 0
X"d2d10006", -- store r13 r1 6 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd002f", -- subi r13 r13 47
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [outside_bound]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L0
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L1
X"8b0e0001", -- addi r0 r14 1 [L0]
X"823d0002", -- load r3 r13 2 [2] [L1]
X"df031000", -- cmp r3 r1
X"23000003", -- brlt L2
X"8b3e0000", -- addi r3 r14 0
X"33000002", -- rjmp L3
X"8b3e0001", -- addi r3 r14 1 [L2]
X"c3003000", -- or r0 r0 r3 [L3]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0044", -- subi r13 r13 68
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [left_shift_l]
X"830d0004", -- load r0 r13 4 [4]
X"821d000a", -- load r1 r13 10 [2]
X"820d000a", -- load r0 r13 10 [2] [L4]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L6
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L7
X"8b0e0001", -- addi r0 r14 1 [L6]
X"e3000000", -- cmpi r0 0 [L7]
X"1b000008", -- breq L5
X"831d0004", -- load r1 r13 4 [4]
X"af110000", -- lsl r1 r1 [4]
X"822d000a", -- load r2 r13 10 [2]
X"8f220001", -- subi r2 r2 1
X"d3d10004", -- store r13 r1 4 [4]
X"d2d2000a", -- store r13 r2 10 [2]
X"3300fff2", -- rjmp L4
X"830d0004", -- load r0 r13 4 [4] [L5]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd005c", -- subi r13 r13 92
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [right_shift_l]
X"830d0004", -- load r0 r13 4 [4]
X"821d000a", -- load r1 r13 10 [2]
X"820d000a", -- load r0 r13 10 [2] [L8]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L10
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L11
X"8b0e0001", -- addi r0 r14 1 [L10]
X"e3000000", -- cmpi r0 0 [L11]
X"1b000008", -- breq L9
X"831d0004", -- load r1 r13 4 [4]
X"b3110000", -- lsr r1 r1 [4]
X"822d000a", -- load r2 r13 10 [2]
X"8f220001", -- subi r2 r2 1
X"d3d10004", -- store r13 r1 4 [4]
X"d2d2000a", -- store r13 r2 10 [2]
X"3300fff2", -- rjmp L8
X"830d0004", -- load r0 r13 4 [4] [L9]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0074", -- subi r13 r13 116
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [left_shift_i]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L12]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L14
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L15
X"8b0e0001", -- addi r0 r14 1 [L14]
X"e3000000", -- cmpi r0 0 [L15]
X"1b000008", -- breq L13
X"821d0004", -- load r1 r13 4 [2]
X"ae110000", -- lsl r1 r1 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d2d10004", -- store r13 r1 4 [2]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L12
X"820d0004", -- load r0 r13 4 [2] [L13]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd008c", -- subi r13 r13 140
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [right_shift_i]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L16]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L18
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L19
X"8b0e0001", -- addi r0 r14 1 [L18]
X"e3000000", -- cmpi r0 0 [L19]
X"1b000008", -- breq L17
X"821d0004", -- load r1 r13 4 [2]
X"b2110000", -- lsr r1 r1 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d2d10004", -- store r13 r1 4 [2]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L16
X"820d0004", -- load r0 r13 4 [2] [L17]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00a4", -- subi r13 r13 164
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [left_shift_c]
X"810d0005", -- load r0 r13 5 [1]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L20]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L22
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L23
X"8b0e0001", -- addi r0 r14 1 [L22]
X"e3000000", -- cmpi r0 0 [L23]
X"1b000008", -- breq L21
X"811d0005", -- load r1 r13 5 [1]
X"ad110000", -- lsl r1 r1 [1]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d1d10005", -- store r13 r1 5 [1]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L20
X"810d0005", -- load r0 r13 5 [1] [L21]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00bc", -- subi r13 r13 188
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [right_shift_c]
X"810d0005", -- load r0 r13 5 [1]
X"821d0006", -- load r1 r13 6 [2]
X"820d0006", -- load r0 r13 6 [2] [L24]
X"e3000000", -- cmpi r0 0
X"27000003", -- brgt L26
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L27
X"8b0e0001", -- addi r0 r14 1 [L26]
X"e3000000", -- cmpi r0 0 [L27]
X"1b000008", -- breq L25
X"811d0005", -- load r1 r13 5 [1]
X"b1110000", -- lsr r1 r1 [1]
X"822d0006", -- load r2 r13 6 [2]
X"8f220001", -- subi r2 r2 1
X"d1d10005", -- store r13 r1 5 [1]
X"d2d20006", -- store r13 r2 6 [2]
X"3300fff2", -- rjmp L24
X"810d0005", -- load r0 r13 5 [1] [L25]
X"cfc00000", -- move r12 r0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd00d4", -- subi r13 r13 212
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [divide]
X"820d0004", -- load r0 r13 4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"8fff0002", -- subi r15 r15 2
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d2fffc", -- store r13 r2 -4 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L28]
X"821d0006", -- load r1 r13 6 [2]
X"df001000", -- cmp r0 r1
X"27000003", -- brgt L30
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L31
X"8b0e0001", -- addi r0 r14 1 [L30]
X"e3000000", -- cmpi r0 0 [L31]
X"1b000008", -- breq L29
X"822dfffe", -- load r2 r13 -2 [2]
X"97221000", -- sub r2 r2 r1
X"823dfffc", -- load r3 r13 -4 [2]
X"8b330001", -- addi r3 r3 1
X"d2d2fffe", -- store r13 r2 -2 [2]
X"d2d3fffc", -- store r13 r3 -4 [2]
X"3300fff1", -- rjmp L28
X"8fff0004", -- subi r15 r15 4 [L29]
X"820dfffc", -- load r0 r13 -4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0010", -- addi r1 r14 16
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"d3d0fff8", -- store r13 r0 -8 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd00fe", -- movlo r13 r13 254
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff48", -- rjmp left_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d3d0fff8", -- store r13 r0 -8 [4]
X"821dfffe", -- load r1 r13 -2 [2]
X"93001000", -- add r0 r0 r1
X"cfc00000", -- move r12 r0
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd010a", -- subi r13 r13 266
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [tile_index_write]
X"820d0004", -- load r0 r13 4 [2]
X"823d0006", -- load r3 r13 6 [2]
X"824e0006", -- load r4 r14 6 [2]
X"df034000", -- cmp r3 r4
X"2f000003", -- brge L32
X"8b3e0000", -- addi r3 r14 0
X"33000002", -- rjmp L33
X"8b3e0001", -- addi r3 r14 1 [L32]
X"e3030000", -- cmpi r3 0 [L33]
X"1b000007", -- breq L34
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd011a", -- subi r13 r13 282
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L35
X"8bfffffe", -- addi r15 r15 -2 [L34] [L35]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820d0006", -- load r0 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821d0004", -- load r1 r13 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd012a", -- movlo r13 r13 298
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fefd", -- rjmp vga_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0131", -- subi r13 r13 305
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [tile_coord_write]
X"830d0004", -- load r0 r13 4 [4]
X"821d0008", -- load r1 r13 8 [2]
X"822d000a", -- load r2 r13 10 [2]
X"823e000e", -- load r3 r14 14 [2]
X"df013000", -- cmp r1 r3
X"2f000003", -- brge L36
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L37
X"8b1e0001", -- addi r1 r14 1 [L36]
X"824e0010", -- load r4 r14 16 [2] [L37]
X"df024000", -- cmp r2 r4
X"2f000003", -- brge L38
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L39
X"8b2e0001", -- addi r2 r14 1 [L38]
X"c3112000", -- or r1 r1 r2 [L39]
X"e3010000", -- cmpi r1 0
X"1b000007", -- breq L40
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0149", -- subi r13 r13 329
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L41
X"8fff0002", -- subi r15 r15 2 [L40] [L41]
X"820d0008", -- load r0 r13 8 [2]
X"821e000e", -- load r1 r14 14 [2]
X"822d000a", -- load r2 r13 10 [2]
X"a7112000", -- mul r1 r1 r2
X"93001000", -- add r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"833d0004", -- load r3 r13 4 [4]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd015e", -- movlo r13 r13 350
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fec9", -- rjmp vga_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0166", -- subi r13 r13 358
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [palette_index_write]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"823e000a", -- load r3 r14 10 [2]
X"df003000", -- cmp r0 r3
X"2f000003", -- brge L42
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L43
X"8b0e0001", -- addi r0 r14 1 [L42]
X"e3000000", -- cmpi r0 0 [L43]
X"1b000007", -- breq L44
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0177", -- subi r13 r13 375
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L45
X"8fff0002", -- subi r15 r15 2 [L44] [L45]
X"820e0008", -- load r0 r14 8 [2]
X"821d0002", -- load r1 r13 2 [2]
X"93001000", -- add r0 r0 r1
X"8fff0002", -- subi r15 r15 2
X"822d0004", -- load r2 r13 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b3e0008", -- addi r3 r14 8
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"823d0004", -- load r3 r13 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d2fffc", -- store r13 r2 -4 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd018f", -- movlo r13 r13 399
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fee7", -- rjmp left_shift_i
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2d0fffc", -- store r13 r0 -4 [2]
X"821d0006", -- load r1 r13 6 [2]
X"93001000", -- add r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822dfffe", -- load r2 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d0fffc", -- store r13 r0 -4 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd01a4", -- movlo r13 r13 420
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe83", -- rjmp vga_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01ac", -- subi r13 r13 428
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [set_cursor]
X"810d0002", -- load r0 r13 2 [1]
X"811d0003", -- load r1 r13 3 [1]
X"822e0002", -- load r2 r14 2 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L46
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L47
X"8b0e0001", -- addi r0 r14 1 [L46]
X"823e0004", -- load r3 r14 4 [2] [L47]
X"df013000", -- cmp r1 r3
X"2f000003", -- brge L48
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L49
X"8b1e0001", -- addi r1 r14 1 [L48]
X"c3001000", -- or r0 r0 r1 [L49]
X"e3000000", -- cmpi r0 0
X"1b000007", -- breq L50
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01c3", -- subi r13 r13 451
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L51
X"810d0002", -- load r0 r13 2 [1] [L50] [L51]
X"cf100000", -- move r1 r0
X"812d0003", -- load r2 r13 3 [1]
X"cf320000", -- move r3 r2
X"93002000", -- add r0 r0 r2
X"824e0002", -- load r4 r14 2 [2]
X"a7004000", -- mul r0 r0 r4
X"d2e00016", -- store r14 r0 22 [2]
X"d2e10018", -- store r14 r1 24 [2]
X"d2e3001a", -- store r14 r3 26 [2]
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01d3", -- subi r13 r13 467
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_cursor]
X"820e0016", -- load r0 r14 22 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00016", -- store r14 r0 22 [2]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L52
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L53
X"8b0e0001", -- addi r0 r14 1 [L52]
X"e3000000", -- cmpi r0 0 [L53]
X"1b000013", -- breq L54
X"820e0018", -- load r0 r14 24 [2]
X"8b000001", -- addi r0 r0 1
X"d2e00018", -- store r14 r0 24 [2]
X"821e0002", -- load r1 r14 2 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L56
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L57
X"8b0e0001", -- addi r0 r14 1 [L56]
X"e3000000", -- cmpi r0 0 [L57]
X"1b000007", -- breq L58
X"8b0e0000", -- addi r0 r14 0
X"821e001a", -- load r1 r14 26 [2]
X"8b110001", -- addi r1 r1 1
X"d2e00018", -- store r14 r0 24 [2]
X"d2e1001a", -- store r14 r1 26 [2]
X"33000001", -- rjmp L59
X"33000007", -- rjmp L55 [L58] [L59]
X"8b0e0000", -- addi r0 r14 0 [L54]
X"8b1e0000", -- addi r1 r14 0
X"8b2e0000", -- addi r2 r14 0
X"d2e00016", -- store r14 r0 22 [2]
X"d2e10018", -- store r14 r1 24 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14 [L55]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd01fc", -- subi r13 r13 508
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [back_cursor]
X"820e0016", -- load r0 r14 22 [2]
X"e3000000", -- cmpi r0 0
X"1b000003", -- breq L60
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L61
X"8b0e0001", -- addi r0 r14 1 [L60]
X"e3000000", -- cmpi r0 0 [L61]
X"1b000007", -- breq L62
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd020a", -- subi r13 r13 522
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L63
X"820e0016", -- load r0 r14 22 [2] [L62] [L63]
X"8f000001", -- subi r0 r0 1
X"d2e00016", -- store r14 r0 22 [2]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L64
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L65
X"8b0e0001", -- addi r0 r14 1 [L64]
X"e3000000", -- cmpi r0 0 [L65]
X"1b000012", -- breq L66
X"820e0018", -- load r0 r14 24 [2]
X"8f000001", -- subi r0 r0 1
X"d2e00018", -- store r14 r0 24 [2]
X"e3000000", -- cmpi r0 0
X"23000003", -- brlt L68
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L69
X"8b0e0001", -- addi r0 r14 1 [L68]
X"e3000000", -- cmpi r0 0 [L69]
X"1b000007", -- breq L70
X"8b0e0000", -- addi r0 r14 0
X"821e001a", -- load r1 r14 26 [2]
X"8f110001", -- subi r1 r1 1
X"d2e00018", -- store r14 r0 24 [2]
X"d2e1001a", -- store r14 r1 26 [2]
X"33000001", -- rjmp L71
X"3300000a", -- rjmp L67 [L70] [L71]
X"820e0006", -- load r0 r14 6 [2] [L66]
X"8f000001", -- subi r0 r0 1
X"821e0002", -- load r1 r14 2 [2]
X"cf210000", -- move r2 r1
X"823e0004", -- load r3 r14 4 [2]
X"cf430000", -- move r4 r3
X"d2e00016", -- store r14 r0 22 [2]
X"d2e20018", -- store r14 r2 24 [2]
X"d2e4001a", -- store r14 r4 26 [2]
X"cfce0000", -- move r12 r14 [L67]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0235", -- subi r13 r13 565
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_steps]
X"820d0002", -- load r0 r13 2 [2]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L72
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L73
X"8b0e0001", -- addi r0 r14 1 [L72]
X"e3000000", -- cmpi r0 0 [L73]
X"1b000007", -- breq L74
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0244", -- subi r13 r13 580
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L75
X"820e0016", -- load r0 r14 22 [2] [L74] [L75]
X"821d0002", -- load r1 r13 2 [2]
X"93001000", -- add r0 r0 r1
X"d2e00016", -- store r14 r0 22 [2]
X"822e0006", -- load r2 r14 6 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L76
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L77
X"8b0e0001", -- addi r0 r14 1 [L76]
X"e3000000", -- cmpi r0 0 [L77]
X"1b000006", -- breq L78
X"820e0016", -- load r0 r14 22 [2]
X"821e0006", -- load r1 r14 6 [2]
X"97001000", -- sub r0 r0 r1
X"d2e00016", -- store r14 r0 22 [2]
X"33000001", -- rjmp L79
X"8fff0004", -- subi r15 r15 4 [L78] [L79]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820e0002", -- load r0 r14 2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"821e0016", -- load r1 r14 22 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd0266", -- movlo r13 r13 614
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe70", -- rjmp divide
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0004", -- subi r15 r15 4
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821e0004", -- load r1 r14 4 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"822e0016", -- load r2 r14 22 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"d3d0fffc", -- store r13 r0 -4 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd027a", -- movlo r13 r13 634
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe5c", -- rjmp divide
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0010", -- addi r1 r14 16
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"831dfffc", -- load r1 r13 -4 [4]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f10000", -- store r15 r1 0 [4]
X"d3d0fff8", -- store r13 r0 -8 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd028e", -- movlo r13 r13 654
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fdd0", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b1e0010", -- addi r1 r14 16
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"831dfff8", -- load r1 r13 -8 [4]
X"8fff0002", -- subi r15 r15 2
X"8bfffffc", -- addi r15 r15 -4
X"d3f10000", -- store r15 r1 0 [4]
X"d2e00018", -- store r14 r0 24 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd02a2", -- movlo r13 r13 674
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fdbc", -- rjmp right_shift_l
X"8bff000c", -- addi r15 r15 12
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2e0001a", -- store r14 r0 26 [2]
X"8bce0001", -- addi r12 r14 1
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02ac", -- subi r13 r13 684
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [advance_line]
X"820e001a", -- load r0 r14 26 [2]
X"8b000001", -- addi r0 r0 1
X"d2e0001a", -- store r14 r0 26 [2]
X"821e0004", -- load r1 r14 4 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L80
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L81
X"8b0e0001", -- addi r0 r14 1 [L80]
X"e3000000", -- cmpi r0 0 [L81]
X"1b000008", -- breq L82
X"820e0002", -- load r0 r14 2 [2]
X"821e001a", -- load r1 r14 26 [2]
X"a7001000", -- mul r0 r0 r1
X"822e0018", -- load r2 r14 24 [2]
X"93002000", -- add r0 r0 r2
X"d2e00016", -- store r14 r0 22 [2]
X"33000006", -- rjmp L83
X"820e0018", -- load r0 r14 24 [2] [L82]
X"cf100000", -- move r1 r0
X"8b2e0000", -- addi r2 r14 0
X"d2e10016", -- store r14 r1 22 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14 [L83]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02c9", -- subi r13 r13 713
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [back_line]
X"820e001a", -- load r0 r14 26 [2]
X"8f000001", -- subi r0 r0 1
X"d2e0001a", -- store r14 r0 26 [2]
X"e3000000", -- cmpi r0 0
X"2f000003", -- brge L84
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L85
X"8b0e0001", -- addi r0 r14 1 [L84]
X"e3000000", -- cmpi r0 0 [L85]
X"1b000008", -- breq L86
X"820e0002", -- load r0 r14 2 [2]
X"821e001a", -- load r1 r14 26 [2]
X"a7001000", -- mul r0 r0 r1
X"822e0018", -- load r2 r14 24 [2]
X"93002000", -- add r0 r0 r2
X"d2e00016", -- store r14 r0 22 [2]
X"33000007", -- rjmp L87
X"820e0018", -- load r0 r14 24 [2] [L86]
X"cf100000", -- move r1 r0
X"822e0004", -- load r2 r14 4 [2]
X"8f220001", -- subi r2 r2 1
X"d2e10016", -- store r14 r1 22 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14 [L87]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd02e6", -- subi r13 r13 742
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [new_line]
X"820e001a", -- load r0 r14 26 [2]
X"8b000001", -- addi r0 r0 1
X"d2e0001a", -- store r14 r0 26 [2]
X"821e0004", -- load r1 r14 4 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L88
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L89
X"8b0e0001", -- addi r0 r14 1 [L88]
X"e3000000", -- cmpi r0 0 [L89]
X"1b000006", -- breq L90
X"820e0002", -- load r0 r14 2 [2]
X"821e001a", -- load r1 r14 26 [2]
X"a7001000", -- mul r0 r0 r1
X"d2e00016", -- store r14 r0 22 [2]
X"33000005", -- rjmp L91
X"8b0e0000", -- addi r0 r14 0 [L90]
X"8b1e0000", -- addi r1 r14 0
X"d2e00016", -- store r14 r0 22 [2]
X"d2e1001a", -- store r14 r1 26 [2]
X"8b0e0000", -- addi r0 r14 0 [L91]
X"d2e00018", -- store r14 r0 24 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0302", -- subi r13 r13 770
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c_at]
X"810d0005", -- load r0 r13 5 [1]
X"821d0006", -- load r1 r13 6 [2]
X"822e0012", -- load r2 r14 18 [2]
X"823e000a", -- load r3 r14 10 [2]
X"df023000", -- cmp r2 r3
X"2f000003", -- brge L92
X"8b2e0000", -- addi r2 r14 0
X"33000002", -- rjmp L93
X"8b2e0001", -- addi r2 r14 1 [L92]
X"824e0014", -- load r4 r14 20 [2] [L93]
X"df043000", -- cmp r4 r3
X"2f000003", -- brge L94
X"8b4e0000", -- addi r4 r14 0
X"33000002", -- rjmp L95
X"8b4e0001", -- addi r4 r14 1 [L94]
X"c3224000", -- or r2 r2 r4 [L95]
X"e3020000", -- cmpi r2 0
X"1b000007", -- breq L96
X"8bce0000", -- addi r12 r14 0
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd031a", -- subi r13 r13 794
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L97
X"8fff0002", -- subi r15 r15 2 [L96] [L97]
X"820e0012", -- load r0 r14 18 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b1e0004", -- addi r1 r14 4
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd032b", -- movlo r13 r13 811
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd4b", -- rjmp left_shift_i
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"d2d0fffe", -- store r13 r0 -2 [2]
X"821e0014", -- load r1 r14 20 [2]
X"93001000", -- add r0 r0 r1
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8b2e0008", -- addi r2 r14 8
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd033f", -- movlo r13 r13 831
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd37", -- rjmp left_shift_i
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cf0c0000", -- move r0 r12
X"8fff0002", -- subi r15 r15 2
X"811d0005", -- load r1 r13 5 [1]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"93110000", -- add r1 r1 r0
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"822d0006", -- load r2 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd0356", -- movlo r13 r13 854
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fdb6", -- rjmp tile_index_write
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd035d", -- subi r13 r13 861
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c_at_pos]
X"810d0003", -- load r0 r13 3 [1]
X"821d0004", -- load r1 r13 4 [2]
X"822d0006", -- load r2 r13 6 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"823e0002", -- load r3 r14 2 [2]
X"a7332000", -- mul r3 r3 r2
X"93113000", -- add r1 r1 r3
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8fff0003", -- subi r15 r15 3
X"f7dd0371", -- movlo r13 r13 881
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff93", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0377", -- subi r13 r13 887
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_c]
X"810d0003", -- load r0 r13 3 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821e0016", -- load r1 r14 22 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"8fff0003", -- subi r15 r15 3
X"f7dd0387", -- movlo r13 r13 903
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff7d", -- rjmp print_c_at
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"e30c0000", -- cmpi r12 0
X"1b00000f", -- breq L98
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd0392", -- movlo r13 r13 914
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe43", -- rjmp advance_cursor
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bce0001", -- addi r12 r14 1
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0398", -- subi r13 r13 920
X"ef0d0000", -- rjmprg r13
X"33000001", -- rjmp L99
X"8bce0000", -- addi r12 r14 0 [L98] [L99]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd039e", -- subi r13 r13 926
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print]
X"820d0002", -- load r0 r13 2 [2]
X"820d0002", -- load r0 r13 2 [2] [L100]
X"81000000", -- load r0 r0 0 [1]
X"e3000000", -- cmpi r0 0
X"1b000014", -- breq L101
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"821d0002", -- load r1 r13 2 [2]
X"81110000", -- load r1 r1 0 [1]
X"8bffffff", -- addi r15 r15 -1
X"d1f10000", -- store r15 r1 0 [1]
X"8fff0001", -- subi r15 r15 1
X"f7dd03b1", -- movlo r13 r13 945
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ffc8", -- rjmp print_c
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"820d0002", -- load r0 r13 2 [2]
X"8b000001", -- addi r0 r0 1
X"d2d00002", -- store r13 r0 2 [2]
X"3300ffea", -- rjmp L100
X"cfce0000", -- move r12 r14 [L101]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd03bc", -- subi r13 r13 956
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [clear]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L102]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L104
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L105
X"8b0e0001", -- addi r0 r14 1 [L104]
X"e3000000", -- cmpi r0 0 [L105]
X"1b000012", -- breq L103
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"822dfffe", -- load r2 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f20000", -- store r15 r2 0 [2]
X"8b3e0000", -- addi r3 r14 0
X"8bfffffe", -- addi r15 r15 -2
X"d2f30000", -- store r15 r3 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd03d7", -- movlo r13 r13 983
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fd35", -- rjmp tile_index_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"3300ffe7", -- rjmp L102
X"8b0e0000", -- addi r0 r14 0 [L103]
X"8b1e0000", -- addi r1 r14 0
X"8b2e0000", -- addi r2 r14 0
X"8bff0002", -- addi r15 r15 2
X"d2e00016", -- store r14 r0 22 [2]
X"d2e10018", -- store r14 r1 24 [2]
X"d2e2001a", -- store r14 r2 26 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd03e6", -- subi r13 r13 998
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [memset]
X"820d0002", -- load r0 r13 2 [2]
X"821d0004", -- load r1 r13 4 [2]
X"812d0007", -- load r2 r13 7 [1]
X"8fff0002", -- subi r15 r15 2
X"8b3e0000", -- addi r3 r14 0
X"d2d3fffe", -- store r13 r3 -2 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L106]
X"821d0004", -- load r1 r13 4 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L108
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L109
X"8b0e0001", -- addi r0 r14 1 [L108]
X"e3000000", -- cmpi r0 0 [L109]
X"1b00000b", -- breq L107
X"822d0002", -- load r2 r13 2 [2]
X"823dfffe", -- load r3 r13 -2 [2]
X"8b4e0001", -- addi r4 r14 1
X"a7334000", -- mul r3 r3 r4
X"93223000", -- add r2 r2 r3
X"814d0007", -- load r4 r13 7 [1]
X"d1240000", -- store r2 r4 0 [1]
X"8b330001", -- addi r3 r3 1
X"d2d3fffe", -- store r13 r3 -2 [2]
X"3300ffee", -- rjmp L106
X"8bff0002", -- addi r15 r15 2 [L107]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0406", -- subi r13 r13 1030
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [add_changed]
X"820d0002", -- load r0 r13 2 [2]
X"8b1e001f", -- addi r1 r14 31
X"822e001d", -- load r2 r14 29 [2]
X"8b3e0002", -- addi r3 r14 2
X"a7223000", -- mul r2 r2 r3
X"93112000", -- add r1 r1 r2
X"d2100000", -- store r1 r0 0 [2]
X"8b220001", -- addi r2 r2 1
X"d2e2001d", -- store r14 r2 29 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0415", -- subi r13 r13 1045
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [calc_next_gen]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b1e0000", -- addi r1 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"d2d1fffc", -- store r13 r1 -4 [2]
X"d2d2fffa", -- store r13 r2 -6 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L110]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L112
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L113
X"8b0e0001", -- addi r0 r14 1 [L112]
X"e3000000", -- cmpi r0 0 [L113]
X"1b0000bd", -- breq L111
X"8fff0002", -- subi r15 r15 2
X"8b2e0000", -- addi r2 r14 0
X"8fff0002", -- subi r15 r15 2
X"8b3effff", -- addi r3 r14 -1
X"8fff0002", -- subi r15 r15 2
X"8b4effff", -- addi r4 r14 -1
X"d2d2fff8", -- store r13 r2 -8 [2]
X"d2d3fff6", -- store r13 r3 -10 [2]
X"d2d4fff4", -- store r13 r4 -12 [2]
X"820dfff4", -- load r0 r13 -12 [2] [L114]
X"e3000002", -- cmpi r0 2
X"23000003", -- brlt L116
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L117
X"8b0e0001", -- addi r0 r14 1 [L116]
X"e3000000", -- cmpi r0 0 [L117]
X"1b00005a", -- breq L115
X"820dfff6", -- load r0 r13 -10 [2] [L118]
X"e3000002", -- cmpi r0 2
X"23000003", -- brlt L120
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L121
X"8b0e0001", -- addi r0 r14 1 [L120]
X"e3000000", -- cmpi r0 0 [L121]
X"1b00004e", -- breq L119
X"8fff0002", -- subi r15 r15 2
X"821dfffc", -- load r1 r13 -4 [2]
X"822dfff6", -- load r2 r13 -10 [2]
X"93112000", -- add r1 r1 r2
X"8fff0002", -- subi r15 r15 2
X"823dfffa", -- load r3 r13 -6 [2]
X"824dfff4", -- load r4 r13 -12 [2]
X"93334000", -- add r3 r3 r4
X"d2d1fff2", -- store r13 r1 -14 [2]
X"825e0002", -- load r5 r14 2 [2]
X"df015000", -- cmp r1 r5
X"2f000003", -- brge L122
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L123
X"8b1e0001", -- addi r1 r14 1 [L122]
X"d2d3fff0", -- store r13 r3 -16 [2] [L123]
X"e3010000", -- cmpi r1 0
X"1b000004", -- breq L124
X"8b0e0000", -- addi r0 r14 0
X"d2d0fff2", -- store r13 r0 -14 [2]
X"3300000e", -- rjmp L125
X"820dfff2", -- load r0 r13 -14 [2] [L124]
X"821e0002", -- load r1 r14 2 [2]
X"df001000", -- cmp r0 r1
X"2b000003", -- brle L126
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L127
X"8b0e0001", -- addi r0 r14 1 [L126]
X"e3000000", -- cmpi r0 0 [L127]
X"1b000005", -- breq L128
X"820e0002", -- load r0 r14 2 [2]
X"8f000001", -- subi r0 r0 1
X"d2d0fff2", -- store r13 r0 -14 [2]
X"33000001", -- rjmp L129
X"820dfff0", -- load r0 r13 -16 [2] [L128] [L129] [L125]
X"821e0004", -- load r1 r14 4 [2]
X"df001000", -- cmp r0 r1
X"2f000003", -- brge L130
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L131
X"8b0e0001", -- addi r0 r14 1 [L130]
X"e3000000", -- cmpi r0 0 [L131]
X"1b000004", -- breq L132
X"8b0e0000", -- addi r0 r14 0
X"d2d0fff0", -- store r13 r0 -16 [2]
X"3300000e", -- rjmp L133
X"820dfff2", -- load r0 r13 -14 [2] [L132]
X"821e0002", -- load r1 r14 2 [2]
X"df001000", -- cmp r0 r1
X"2b000003", -- brle L134
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L135
X"8b0e0001", -- addi r0 r14 1 [L134]
X"e3000000", -- cmpi r0 0 [L135]
X"1b000005", -- breq L136
X"820e0004", -- load r0 r14 4 [2]
X"8f000001", -- subi r0 r0 1
X"d2d0fff0", -- store r13 r0 -16 [2]
X"33000001", -- rjmp L137
X"8fff0002", -- subi r15 r15 2 [L136] [L137] [L133]
X"820dfff2", -- load r0 r13 -14 [2]
X"821e0002", -- load r1 r14 2 [2]
X"822dfff0", -- load r2 r13 -16 [2]
X"a7112000", -- mul r1 r1 r2
X"93001000", -- add r0 r0 r1
X"823dfff8", -- load r3 r13 -8 [2]
X"8b4e001c", -- addi r4 r14 28
X"d2d0ffee", -- store r13 r0 -18 [2]
X"93040000", -- add r0 r4 r0
X"81000000", -- load r0 r0 0 [1]
X"93330000", -- add r3 r3 r0
X"825dfff6", -- load r5 r13 -10 [2]
X"8b550001", -- addi r5 r5 1
X"8bff0006", -- addi r15 r15 6
X"d2d3fff8", -- store r13 r3 -8 [2]
X"d2d5fff6", -- store r13 r5 -10 [2]
X"3300ffac", -- rjmp L118
X"820dfff4", -- load r0 r13 -12 [2] [L119]
X"8b000001", -- addi r0 r0 1
X"d2d0fff4", -- store r13 r0 -12 [2]
X"3300ffa0", -- rjmp L114
X"8b0e001c", -- addi r0 r14 28 [L115]
X"821dfffe", -- load r1 r13 -2 [2]
X"93101000", -- add r1 r0 r1
X"81110000", -- load r1 r1 0 [1]
X"e3010001", -- cmpi r1 1
X"1b000003", -- breq L138
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L139
X"8b1e0001", -- addi r1 r14 1 [L138]
X"e3010000", -- cmpi r1 0 [L139]
X"1b00001f", -- breq L140
X"820dfff8", -- load r0 r13 -8 [2]
X"e3000002", -- cmpi r0 2
X"23000003", -- brlt L142
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L143
X"8b0e0001", -- addi r0 r14 1 [L142]
X"821dfff8", -- load r1 r13 -8 [2] [L143]
X"e3010003", -- cmpi r1 3
X"27000003", -- brgt L144
X"8b1e0000", -- addi r1 r14 0
X"33000002", -- rjmp L145
X"8b1e0001", -- addi r1 r14 1 [L144]
X"c3001000", -- or r0 r0 r1 [L145]
X"e3000000", -- cmpi r0 0
X"1b00000f", -- breq L146
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd04b7", -- movlo r13 r13 1207
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff51", -- rjmp add_changed
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L147
X"33000017", -- rjmp L141 [L146] [L147]
X"820dfff8", -- load r0 r13 -8 [2] [L140]
X"e3000003", -- cmpi r0 3
X"1b000003", -- breq L148
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L149
X"8b0e0001", -- addi r0 r14 1 [L148]
X"e3000000", -- cmpi r0 0 [L149]
X"1b00000f", -- breq L150
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"820dfffe", -- load r0 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"f7dd04ce", -- movlo r13 r13 1230
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff3a", -- rjmp add_changed
X"8bff0004", -- addi r15 r15 4
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000001", -- rjmp L151
X"820dfffc", -- load r0 r13 -4 [2] [L150] [L151] [L141]
X"8b000001", -- addi r0 r0 1
X"821dfffe", -- load r1 r13 -2 [2]
X"8b110001", -- addi r1 r1 1
X"d2d0fffc", -- store r13 r0 -4 [2]
X"822e0002", -- load r2 r14 2 [2]
X"df002000", -- cmp r0 r2
X"2f000003", -- brge L152
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L153
X"8b0e0001", -- addi r0 r14 1 [L152]
X"d2d1fffe", -- store r13 r1 -2 [2] [L153]
X"e3000000", -- cmpi r0 0
X"1b000004", -- breq L154
X"8b0e0000", -- addi r0 r14 0
X"d2d0fffc", -- store r13 r0 -4 [2]
X"33000001", -- rjmp L155
X"8bff0006", -- addi r15 r15 6 [L154] [L155]
X"3300ff3c", -- rjmp L110
X"8bff0006", -- addi r15 r15 6 [L111]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd04ea", -- subi r13 r13 1258
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [print_board]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L156]
X"821e0006", -- load r1 r14 6 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L158
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L159
X"8b0e0001", -- addi r0 r14 1 [L158]
X"e3000000", -- cmpi r0 0 [L159]
X"1b000029", -- breq L157
X"8b2e001c", -- addi r2 r14 28
X"823dfffe", -- load r3 r13 -2 [2]
X"93323000", -- add r3 r2 r3
X"81330000", -- load r3 r3 0 [1]
X"e3030000", -- cmpi r3 0
X"1b000012", -- breq L160
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"820dfffe", -- load r0 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e002b", -- addi r1 r14 43
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd050b", -- movlo r13 r13 1291
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb1c", -- rjmp vga_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"33000011", -- rjmp L161
X"8bfffffe", -- addi r15 r15 -2 [L160]
X"d2fd0000", -- store r15 r13 0 [2]
X"820dfffe", -- load r0 r13 -2 [2]
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e0020", -- addi r1 r14 32
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"8fff0002", -- subi r15 r15 2
X"f7dd051c", -- movlo r13 r13 1308
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fb0b", -- rjmp vga_write
X"8bff0006", -- addi r15 r15 6
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"3300ffd0", -- rjmp L156 [L161]
X"8bff0002", -- addi r15 r15 2 [L157]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0525", -- subi r13 r13 1317
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [update_changed]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"d2d0fffe", -- store r13 r0 -2 [2]
X"820dfffe", -- load r0 r13 -2 [2] [L162]
X"821e001d", -- load r1 r14 29 [2]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L164
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L165
X"8b0e0001", -- addi r0 r14 1 [L164]
X"e3000000", -- cmpi r0 0 [L165]
X"1b00001f", -- breq L163
X"8fff0002", -- subi r15 r15 2
X"8b2e001f", -- addi r2 r14 31
X"823dfffe", -- load r3 r13 -2 [2]
X"8b4e0002", -- addi r4 r14 2
X"a7334000", -- mul r3 r3 r4
X"93323000", -- add r3 r2 r3
X"82330000", -- load r3 r3 0 [2]
X"8b4e001c", -- addi r4 r14 28
X"d2d3fffc", -- store r13 r3 -4 [2]
X"93343000", -- add r3 r4 r3
X"81330000", -- load r3 r3 0 [1]
X"e3030000", -- cmpi r3 0
X"1b000009", -- breq L166
X"8b0e001c", -- addi r0 r14 28
X"821dfffc", -- load r1 r13 -4 [2]
X"8b2e0001", -- addi r2 r14 1
X"a7112000", -- mul r1 r1 r2
X"93001000", -- add r0 r0 r1
X"8b2e0000", -- addi r2 r14 0
X"d1020000", -- store r0 r2 0 [1]
X"33000008", -- rjmp L167
X"8b0e001c", -- addi r0 r14 28 [L166]
X"821dfffc", -- load r1 r13 -4 [2]
X"8b2e0001", -- addi r2 r14 1
X"a7112000", -- mul r1 r1 r2
X"93001000", -- add r0 r0 r1
X"8b2e0001", -- addi r2 r14 1
X"d1020000", -- store r0 r2 0 [1]
X"8bff0002", -- addi r15 r15 2 [L167]
X"3300ffda", -- rjmp L162
X"8b0e0000", -- addi r0 r14 0 [L163]
X"8bff0002", -- addi r15 r15 2
X"d2e0001d", -- store r14 r0 29 [2]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0558", -- subi r13 r13 1368
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [sleep_ms]
X"830d0004", -- load r0 r13 4 [4]
X"8fff0004", -- subi r15 r15 4
X"831e009e", -- load r1 r14 158 [4]
X"a7001000", -- mul r0 r0 r1
X"8fff0004", -- subi r15 r15 4
X"8b2e0000", -- addi r2 r14 0
X"d3d0fffc", -- store r13 r0 -4 [4]
X"d3d2fff8", -- store r13 r2 -8 [4]
X"830dfff8", -- load r0 r13 -8 [4] [L168]
X"831dfffc", -- load r1 r13 -4 [4]
X"df001000", -- cmp r0 r1
X"23000003", -- brlt L170
X"8b0e0000", -- addi r0 r14 0
X"33000002", -- rjmp L171
X"8b0e0001", -- addi r0 r14 1 [L170]
X"e3000000", -- cmpi r0 0 [L171]
X"1b000005", -- breq L169
X"832dfff8", -- load r2 r13 -8 [4]
X"8b220001", -- addi r2 r2 1
X"d3d2fff8", -- store r13 r2 -8 [4]
X"3300fff4", -- rjmp L168
X"8bff0008", -- addi r15 r15 8 [L169]
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd0574", -- subi r13 r13 1396
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [next_gen]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd057c", -- movlo r13 r13 1404
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe9b", -- rjmp calc_next_gen
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd0584", -- movlo r13 r13 1412
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ffa3", -- rjmp update_changed
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"cfce0000", -- move r12 r14
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd058a", -- subi r13 r13 1418
X"ef0d0000", -- rjmprg r13
X"cfdf0000", -- move r13 r15 [main]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e0000", -- addi r0 r14 0
X"8bffffff", -- addi r15 r15 -1
X"d1f00000", -- store r15 r0 0 [1]
X"820e0006", -- load r0 r14 6 [2]
X"8fff0001", -- subi r15 r15 1
X"8bfffffe", -- addi r15 r15 -2
X"d2f00000", -- store r15 r0 0 [2]
X"8b1e001c", -- addi r1 r14 28
X"8bfffffe", -- addi r15 r15 -2
X"d2f10000", -- store r15 r1 0 [2]
X"f7dd059d", -- movlo r13 r13 1437
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300fe4b", -- rjmp memset
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8b0e001c", -- addi r0 r14 28
X"8b000029", -- addi r0 r0 41
X"8b1e0001", -- addi r1 r14 1
X"d1010000", -- store r0 r1 0 [1]
X"8b0e001c", -- addi r0 r14 28
X"8b000052", -- addi r0 r0 82
X"8b1e0001", -- addi r1 r14 1
X"d1010000", -- store r0 r1 0 [1]
X"8b0e001c", -- addi r0 r14 28
X"8b000079", -- addi r0 r0 121
X"8b1e0001", -- addi r1 r14 1
X"d1010000", -- store r0 r1 0 [1]
X"8b0e001c", -- addi r0 r14 28
X"8b00007a", -- addi r0 r0 122
X"8b1e0001", -- addi r1 r14 1
X"d1010000", -- store r0 r1 0 [1]
X"8b0e001c", -- addi r0 r14 28
X"8b00007b", -- addi r0 r0 123
X"8b1e0001", -- addi r1 r14 1
X"d1010000", -- store r0 r1 0 [1]
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd05ba", -- movlo r13 r13 1466
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff32", -- rjmp print_board
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2 [L172]
X"d2fd0000", -- store r15 r13 0 [2]
X"8fff0002", -- subi r15 r15 2
X"8b0e01f4", -- addi r0 r14 500
X"8bfffffc", -- addi r15 r15 -4
X"d3f00000", -- store r15 r0 0 [4]
X"8fff0002", -- subi r15 r15 2
X"f7dd05c7", -- movlo r13 r13 1479
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ff93", -- rjmp sleep_ms
X"8bff0008", -- addi r15 r15 8
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"f7dd05d0", -- movlo r13 r13 1488
X"8bfffffe", -- addi r15 r15 -2
X"d2fd0000", -- store r15 r13 0 [2]
X"3300ffa6", -- rjmp next_gen
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"3300ffea", -- rjmp L172
X"cfce0000", -- move r12 r14 [L173]
X"82df0000", -- load r13 r15 0 [2]
X"8bff0002", -- addi r15 r15 2
X"8fdd05d7", -- subi r13 r13 1495
X"ef0d0000", -- rjmprg r13
--$PROGRAM_END
others => X"00000000"
);

end program_file;
