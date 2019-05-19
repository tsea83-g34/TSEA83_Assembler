const SP r15
const NULL r14
const BP r13
const RR r12

.data MEMORY_SIZE
	.dh 4096
.data VIDEO_TILE_WIDTH
	.dh 40
.data VIDEO_TILE_HEIGHT
	.dh 30
.data VIDEO_TILES
	.dh 0
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	load[2] r1, NULL, VIDEO_TILE_HEIGHT
	mul r0, r0, r1
	store[2] NULL, r0, VIDEO_TILES
.data PALETTE_START
	.dh 0
	load[2] r0, NULL, VIDEO_TILES
	store[2] NULL, r0, PALETTE_START
.data PALETTE_SIZE
	.dh 16
.data VIDEO_MEMORY_SIZE
	.dh 0
	load[2] r0, NULL, VIDEO_TILES
	load[2] r2, NULL, PALETTE_SIZE
	add r0, r0, r2
	store[2] NULL, r0, VIDEO_MEMORY_SIZE
.data VIDEO_PIXEL_WIDTH
	.dh 640
.data VIDEO_PIXEL_HEIGHT
	.dh 480
.data FG_COLOR
	.dh 0
.data BG_COLOR
	.dh 0
.data CURSOR
	.dh 0
.data CURSOR_X
	.dh 0
.data CURSOR_Y
	.dh 0
.data buffer
	.db 0
.data changed_index
	.dh 0
.data changed
	.dh 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
.data SLEEP_MS_MULT
	.dw 7692

	subi SP, SP, 1
	call main
	subi SP, SP, 2
__halt:
	rjmp __halt

in:
	move BP, SP
	load[2] r0, BP, 2
	subi SP, SP, 4
	load[4] r1, BP, -4
	in r1, 0
	move RR, r1
	addi SP, SP, 4
	ret

out:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r1, BP, 10
	out 0, r0
	store[4] BP, r0, 4
	move RR, NULL
	ret

vga_write:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r1, BP, 6
	vgaw r1, r0, 0
	store[2] BP, r1, 6
	move RR, NULL
	ret

outside_bound:
	move BP, SP
	load[2] r0, BP, 2
	load[2] r1, BP, 4
	load[2] r2, BP, 6
	cmp r0, r2
	brge L0
	addi r0, NULL, 0
	rjmp L1
L0:
	addi r0, NULL, 1
L1:
	load[2] r3, BP, 2
	cmp r3, r1
	brlt L2
	addi r3, NULL, 0
	rjmp L3
L2:
	addi r3, NULL, 1
L3:
	or r0, r0, r3
	move RR, r0
	ret

left_shift_l:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r1, BP, 10
L4:
	load[2] r0, BP, 10
	cmpi r0, 0
	brgt L6
	addi r0, NULL, 0
	rjmp L7
L6:
	addi r0, NULL, 1
L7:
	cmpi r0, 0
	breq L5
	load[4] r1, BP, 4
	lsl[4] r1, r1
	load[2] r2, BP, 10
	subi r2, r2, 1
	store[4] BP, r1, 4
	store[2] BP, r2, 10
	rjmp L4
L5:
	load[4] r0, BP, 4
	move RR, r0
	ret

right_shift_l:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r1, BP, 10
L8:
	load[2] r0, BP, 10
	cmpi r0, 0
	brgt L10
	addi r0, NULL, 0
	rjmp L11
L10:
	addi r0, NULL, 1
L11:
	cmpi r0, 0
	breq L9
	load[4] r1, BP, 4
	lsr[4] r1, r1
	load[2] r2, BP, 10
	subi r2, r2, 1
	store[4] BP, r1, 4
	store[2] BP, r2, 10
	rjmp L8
L9:
	load[4] r0, BP, 4
	move RR, r0
	ret

left_shift_i:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r1, BP, 6
L12:
	load[2] r0, BP, 6
	cmpi r0, 0
	brgt L14
	addi r0, NULL, 0
	rjmp L15
L14:
	addi r0, NULL, 1
L15:
	cmpi r0, 0
	breq L13
	load[2] r1, BP, 4
	lsl[2] r1, r1
	load[2] r2, BP, 6
	subi r2, r2, 1
	store[2] BP, r1, 4
	store[2] BP, r2, 6
	rjmp L12
L13:
	load[2] r0, BP, 4
	move RR, r0
	ret

right_shift_i:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r1, BP, 6
L16:
	load[2] r0, BP, 6
	cmpi r0, 0
	brgt L18
	addi r0, NULL, 0
	rjmp L19
L18:
	addi r0, NULL, 1
L19:
	cmpi r0, 0
	breq L17
	load[2] r1, BP, 4
	lsr[2] r1, r1
	load[2] r2, BP, 6
	subi r2, r2, 1
	store[2] BP, r1, 4
	store[2] BP, r2, 6
	rjmp L16
L17:
	load[2] r0, BP, 4
	move RR, r0
	ret

left_shift_c:
	move BP, SP
	load[1] r0, BP, 5
	load[2] r1, BP, 6
L20:
	load[2] r0, BP, 6
	cmpi r0, 0
	brgt L22
	addi r0, NULL, 0
	rjmp L23
L22:
	addi r0, NULL, 1
L23:
	cmpi r0, 0
	breq L21
	load[1] r1, BP, 5
	lsl[1] r1, r1
	load[2] r2, BP, 6
	subi r2, r2, 1
	store[1] BP, r1, 5
	store[2] BP, r2, 6
	rjmp L20
L21:
	load[1] r0, BP, 5
	move RR, r0
	ret

right_shift_c:
	move BP, SP
	load[1] r0, BP, 5
	load[2] r1, BP, 6
L24:
	load[2] r0, BP, 6
	cmpi r0, 0
	brgt L26
	addi r0, NULL, 0
	rjmp L27
L26:
	addi r0, NULL, 1
L27:
	cmpi r0, 0
	breq L25
	load[1] r1, BP, 5
	lsr[1] r1, r1
	load[2] r2, BP, 6
	subi r2, r2, 1
	store[1] BP, r1, 5
	store[2] BP, r2, 6
	rjmp L24
L25:
	load[1] r0, BP, 5
	move RR, r0
	ret

divide:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r1, BP, 6
	subi SP, SP, 2
	subi SP, SP, 2
	addi r2, NULL, 0
	store[2] BP, r0, -2
	store[2] BP, r2, -4
L28:
	load[2] r0, BP, -2
	load[2] r1, BP, 6
	cmp r0, r1
	brgt L30
	addi r0, NULL, 0
	rjmp L31
L30:
	addi r0, NULL, 1
L31:
	cmpi r0, 0
	breq L29
	load[2] r2, BP, -2
	sub r2, r2, r1
	load[2] r3, BP, -4
	addi r3, r3, 1
	store[2] BP, r2, -2
	store[2] BP, r3, -4
	rjmp L28
L29:
	subi SP, SP, 4
	load[2] r0, BP, -4
	push[2] BP
	subi SP, SP, 2
	addi r1, NULL, 16
	push[2] r1
	subi SP, SP, 2
	push[4] r0
	store[4] BP, r0, -8
	subi SP, SP, 2
	call left_shift_l
	addi SP, SP, 12
	pop[2] BP
	move r0, RR
	store[4] BP, r0, -8
	load[2] r1, BP, -2
	add r0, r0, r1
	move RR, r0
	addi SP, SP, 8
	ret

tile_index_write:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r3, BP, 6
	load[2] r4, NULL, VIDEO_TILES
	cmp r3, r4
	brge L32
	addi r3, NULL, 0
	rjmp L33
L32:
	addi r3, NULL, 1
L33:
	cmpi r3, 0
	breq L34
	addi RR, NULL, 0
	ret
	rjmp L35
L34:
L35:
	push[2] BP
	subi SP, SP, 2
	load[2] r0, BP, 6
	push[2] r0
	load[2] r1, BP, 4
	push[2] r1
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 8
	pop[2] BP
	addi RR, NULL, 1
	ret

tile_coord_write:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r1, BP, 8
	load[2] r2, BP, 10
	load[2] r3, NULL, VIDEO_PIXEL_WIDTH
	cmp r1, r3
	brge L36
	addi r1, NULL, 0
	rjmp L37
L36:
	addi r1, NULL, 1
L37:
	load[2] r4, NULL, VIDEO_PIXEL_HEIGHT
	cmp r2, r4
	brge L38
	addi r2, NULL, 0
	rjmp L39
L38:
	addi r2, NULL, 1
L39:
	or r1, r1, r2
	cmpi r1, 0
	breq L40
	addi RR, NULL, 0
	ret
	rjmp L41
L40:
L41:
	subi SP, SP, 2
	load[2] r0, BP, 8
	load[2] r1, NULL, VIDEO_PIXEL_WIDTH
	load[2] r2, BP, 10
	mul r1, r1, r2
	add r0, r0, r1
	push[2] BP
	push[2] r0
	load[4] r3, BP, 4
	push[2] r3
	store[2] BP, r0, -2
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 6
	pop[2] BP
	addi RR, NULL, 1
	addi SP, SP, 2
	ret

palette_index_write:
	move BP, SP
	load[2] r0, BP, 2
	load[2] r1, BP, 4
	load[2] r2, BP, 6
	load[2] r3, NULL, PALETTE_SIZE
	cmp r0, r3
	brge L42
	addi r0, NULL, 0
	rjmp L43
L42:
	addi r0, NULL, 1
L43:
	cmpi r0, 0
	breq L44
	addi RR, NULL, 0
	ret
	rjmp L45
L44:
L45:
	subi SP, SP, 2
	load[2] r0, NULL, PALETTE_START
	load[2] r1, BP, 2
	add r0, r0, r1
	subi SP, SP, 2
	load[2] r2, BP, 4
	push[2] BP
	subi SP, SP, 2
	addi r3, NULL, 8
	push[2] r3
	load[2] r3, BP, 4
	push[2] r3
	store[2] BP, r0, -2
	store[2] BP, r2, -4
	subi SP, SP, 2
	call left_shift_i
	addi SP, SP, 8
	pop[2] BP
	move r0, RR
	store[2] BP, r0, -4
	load[2] r1, BP, 6
	add r0, r0, r1
	push[2] BP
	subi SP, SP, 2
	load[2] r2, BP, -2
	push[2] r2
	push[2] r0
	store[2] BP, r0, -4
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 8
	pop[2] BP
	addi RR, NULL, 1
	addi SP, SP, 4
	ret

set_cursor:
	move BP, SP
	load[1] r0, BP, 2
	load[1] r1, BP, 3
	load[2] r2, NULL, VIDEO_TILE_WIDTH
	cmp r0, r2
	brge L46
	addi r0, NULL, 0
	rjmp L47
L46:
	addi r0, NULL, 1
L47:
	load[2] r3, NULL, VIDEO_TILE_HEIGHT
	cmp r1, r3
	brge L48
	addi r1, NULL, 0
	rjmp L49
L48:
	addi r1, NULL, 1
L49:
	or r0, r0, r1
	cmpi r0, 0
	breq L50
	addi RR, NULL, 0
	ret
	rjmp L51
L50:
L51:
	load[1] r0, BP, 2
	move r1, r0
	load[1] r2, BP, 3
	move r3, r2
	add r0, r0, r2
	load[2] r4, NULL, VIDEO_TILE_WIDTH
	mul r0, r0, r4
	store[2] NULL, r0, CURSOR
	store[2] NULL, r1, CURSOR_X
	store[2] NULL, r3, CURSOR_Y
	addi RR, NULL, 1
	ret

advance_cursor:
	move BP, SP
	load[2] r0, NULL, CURSOR
	addi r0, r0, 1
	store[2] NULL, r0, CURSOR
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brlt L52
	addi r0, NULL, 0
	rjmp L53
L52:
	addi r0, NULL, 1
L53:
	cmpi r0, 0
	breq L54
	load[2] r0, NULL, CURSOR_X
	addi r0, r0, 1
	store[2] NULL, r0, CURSOR_X
	load[2] r1, NULL, VIDEO_TILE_WIDTH
	cmp r0, r1
	brge L56
	addi r0, NULL, 0
	rjmp L57
L56:
	addi r0, NULL, 1
L57:
	cmpi r0, 0
	breq L58
	addi r0, NULL, 0
	load[2] r1, NULL, CURSOR_Y
	addi r1, r1, 1
	store[2] NULL, r0, CURSOR_X
	store[2] NULL, r1, CURSOR_Y
	rjmp L59
L58:
L59:
	rjmp L55
L54:
	addi r0, NULL, 0
	addi r1, NULL, 0
	addi r2, NULL, 0
	store[2] NULL, r0, CURSOR
	store[2] NULL, r1, CURSOR_X
	store[2] NULL, r2, CURSOR_Y
L55:
	move RR, NULL
	ret

back_cursor:
	move BP, SP
	load[2] r0, NULL, CURSOR
	cmpi r0, 0
	breq L60
	addi r0, NULL, 0
	rjmp L61
L60:
	addi r0, NULL, 1
L61:
	cmpi r0, 0
	breq L62
	addi RR, NULL, 0
	ret
	rjmp L63
L62:
L63:
	load[2] r0, NULL, CURSOR
	subi r0, r0, 1
	store[2] NULL, r0, CURSOR
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brlt L64
	addi r0, NULL, 0
	rjmp L65
L64:
	addi r0, NULL, 1
L65:
	cmpi r0, 0
	breq L66
	load[2] r0, NULL, CURSOR_X
	subi r0, r0, 1
	store[2] NULL, r0, CURSOR_X
	cmpi r0, 0
	brlt L68
	addi r0, NULL, 0
	rjmp L69
L68:
	addi r0, NULL, 1
L69:
	cmpi r0, 0
	breq L70
	addi r0, NULL, 0
	load[2] r1, NULL, CURSOR_Y
	subi r1, r1, 1
	store[2] NULL, r0, CURSOR_X
	store[2] NULL, r1, CURSOR_Y
	rjmp L71
L70:
L71:
	rjmp L67
L66:
	load[2] r0, NULL, VIDEO_TILES
	subi r0, r0, 1
	load[2] r1, NULL, VIDEO_TILE_WIDTH
	move r2, r1
	load[2] r3, NULL, VIDEO_TILE_HEIGHT
	move r4, r3
	store[2] NULL, r0, CURSOR
	store[2] NULL, r2, CURSOR_X
	store[2] NULL, r4, CURSOR_Y
L67:
	move RR, NULL
	ret

advance_steps:
	move BP, SP
	load[2] r0, BP, 2
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brge L72
	addi r0, NULL, 0
	rjmp L73
L72:
	addi r0, NULL, 1
L73:
	cmpi r0, 0
	breq L74
	addi RR, NULL, 0
	ret
	rjmp L75
L74:
L75:
	load[2] r0, NULL, CURSOR
	load[2] r1, BP, 2
	add r0, r0, r1
	store[2] NULL, r0, CURSOR
	load[2] r2, NULL, VIDEO_TILES
	cmp r0, r2
	brge L76
	addi r0, NULL, 0
	rjmp L77
L76:
	addi r0, NULL, 1
L77:
	cmpi r0, 0
	breq L78
	load[2] r0, NULL, CURSOR
	load[2] r1, NULL, VIDEO_TILES
	sub r0, r0, r1
	store[2] NULL, r0, CURSOR
	rjmp L79
L78:
L79:
	subi SP, SP, 4
	push[2] BP
	subi SP, SP, 2
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	push[2] r0
	load[2] r1, NULL, CURSOR
	push[2] r1
	subi SP, SP, 2
	call divide
	addi SP, SP, 8
	pop[2] BP
	move r0, RR
	subi SP, SP, 4
	push[2] BP
	subi SP, SP, 2
	load[2] r1, NULL, VIDEO_TILE_HEIGHT
	push[2] r1
	load[2] r2, NULL, CURSOR
	push[2] r2
	store[4] BP, r0, -4
	subi SP, SP, 2
	call divide
	addi SP, SP, 8
	pop[2] BP
	move r0, RR
	push[2] BP
	subi SP, SP, 2
	addi r1, NULL, 16
	push[2] r1
	load[4] r1, BP, -4
	subi SP, SP, 2
	push[4] r1
	store[4] BP, r0, -8
	subi SP, SP, 2
	call right_shift_l
	addi SP, SP, 12
	pop[2] BP
	move r0, RR
	push[2] BP
	subi SP, SP, 2
	addi r1, NULL, 16
	push[2] r1
	load[4] r1, BP, -8
	subi SP, SP, 2
	push[4] r1
	store[2] NULL, r0, CURSOR_X
	subi SP, SP, 2
	call right_shift_l
	addi SP, SP, 12
	pop[2] BP
	move r0, RR
	store[2] NULL, r0, CURSOR_Y
	addi RR, NULL, 1
	addi SP, SP, 8
	ret

advance_line:
	move BP, SP
	load[2] r0, NULL, CURSOR_Y
	addi r0, r0, 1
	store[2] NULL, r0, CURSOR_Y
	load[2] r1, NULL, VIDEO_TILE_HEIGHT
	cmp r0, r1
	brlt L80
	addi r0, NULL, 0
	rjmp L81
L80:
	addi r0, NULL, 1
L81:
	cmpi r0, 0
	breq L82
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	load[2] r1, NULL, CURSOR_Y
	mul r0, r0, r1
	load[2] r2, NULL, CURSOR_X
	add r0, r0, r2
	store[2] NULL, r0, CURSOR
	rjmp L83
L82:
	load[2] r0, NULL, CURSOR_X
	move r1, r0
	addi r2, NULL, 0
	store[2] NULL, r1, CURSOR
	store[2] NULL, r2, CURSOR_Y
L83:
	move RR, NULL
	ret

back_line:
	move BP, SP
	load[2] r0, NULL, CURSOR_Y
	subi r0, r0, 1
	store[2] NULL, r0, CURSOR_Y
	cmpi r0, 0
	brge L84
	addi r0, NULL, 0
	rjmp L85
L84:
	addi r0, NULL, 1
L85:
	cmpi r0, 0
	breq L86
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	load[2] r1, NULL, CURSOR_Y
	mul r0, r0, r1
	load[2] r2, NULL, CURSOR_X
	add r0, r0, r2
	store[2] NULL, r0, CURSOR
	rjmp L87
L86:
	load[2] r0, NULL, CURSOR_X
	move r1, r0
	load[2] r2, NULL, VIDEO_TILE_HEIGHT
	subi r2, r2, 1
	store[2] NULL, r1, CURSOR
	store[2] NULL, r2, CURSOR_Y
L87:
	move RR, NULL
	ret

new_line:
	move BP, SP
	load[2] r0, NULL, CURSOR_Y
	addi r0, r0, 1
	store[2] NULL, r0, CURSOR_Y
	load[2] r1, NULL, VIDEO_TILE_HEIGHT
	cmp r0, r1
	brlt L88
	addi r0, NULL, 0
	rjmp L89
L88:
	addi r0, NULL, 1
L89:
	cmpi r0, 0
	breq L90
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	load[2] r1, NULL, CURSOR_Y
	mul r0, r0, r1
	store[2] NULL, r0, CURSOR
	rjmp L91
L90:
	addi r0, NULL, 0
	addi r1, NULL, 0
	store[2] NULL, r0, CURSOR
	store[2] NULL, r1, CURSOR_Y
L91:
	addi r0, NULL, 0
	store[2] NULL, r0, CURSOR_X
	move RR, NULL
	ret

print_c_at:
	move BP, SP
	load[1] r0, BP, 5
	load[2] r1, BP, 6
	load[2] r2, NULL, FG_COLOR
	load[2] r3, NULL, PALETTE_SIZE
	cmp r2, r3
	brge L92
	addi r2, NULL, 0
	rjmp L93
L92:
	addi r2, NULL, 1
L93:
	load[2] r4, NULL, BG_COLOR
	cmp r4, r3
	brge L94
	addi r4, NULL, 0
	rjmp L95
L94:
	addi r4, NULL, 1
L95:
	or r2, r2, r4
	cmpi r2, 0
	breq L96
	addi RR, NULL, 0
	ret
	rjmp L97
L96:
L97:
	subi SP, SP, 2
	load[2] r0, NULL, FG_COLOR
	push[2] BP
	addi r1, NULL, 4
	push[2] r1
	push[2] r0
	store[2] BP, r0, -2
	subi SP, SP, 2
	call left_shift_i
	addi SP, SP, 6
	pop[2] BP
	move r0, RR
	store[2] BP, r0, -2
	load[2] r1, NULL, BG_COLOR
	add r0, r0, r1
	push[2] BP
	addi r2, NULL, 8
	push[2] r2
	push[2] r0
	store[2] BP, r0, -2
	subi SP, SP, 2
	call left_shift_i
	addi SP, SP, 6
	pop[2] BP
	move r0, RR
	subi SP, SP, 2
	load[1] r1, BP, 5
	store[2] BP, r1, -4
	add r1, r1, r0
	push[2] BP
	subi SP, SP, 2
	load[2] r2, BP, 6
	push[2] r2
	push[2] r1
	store[2] BP, r0, -2
	store[2] BP, r1, -4
	subi SP, SP, 2
	call tile_index_write
	addi SP, SP, 8
	pop[2] BP
	addi SP, SP, 4
	ret

print_c_at_pos:
	move BP, SP
	load[1] r0, BP, 3
	load[2] r1, BP, 4
	load[2] r2, BP, 6
	push[2] BP
	subi SP, SP, 2
	load[2] r3, NULL, VIDEO_TILE_WIDTH
	mul r3, r3, r2
	add r1, r1, r3
	push[2] r1
	push[1] r0
	subi SP, SP, 3
	call print_c_at
	addi SP, SP, 8
	pop[2] BP
	ret

print_c:
	move BP, SP
	load[1] r0, BP, 3
	push[2] BP
	subi SP, SP, 2
	load[2] r1, NULL, CURSOR
	push[2] r1
	push[1] r0
	subi SP, SP, 3
	call print_c_at
	addi SP, SP, 8
	pop[2] BP
	cmpi RR, 0
	breq L98
	push[2] BP
	call advance_cursor
	pop[2] BP
	addi RR, NULL, 1
	ret
	rjmp L99
L98:
L99:
	addi RR, NULL, 0
	ret

print:
	move BP, SP
	load[2] r0, BP, 2
L100:
	load[2] r0, BP, 2
	load[1] r0, r0, 0
	cmpi r0, 0
	breq L101
	push[2] BP
	subi SP, SP, 2
	load[2] r1, BP, 2
	load[1] r1, r1, 0
	push[1] r1
	subi SP, SP, 1
	call print_c
	addi SP, SP, 4
	pop[2] BP
	load[2] r0, BP, 2
	addi r0, r0, 1
	store[2] BP, r0, 2
	rjmp L100
L101:
	move RR, NULL
	ret

clear:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	store[2] BP, r0, -2
L102:
	load[2] r0, BP, -2
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brlt L104
	addi r0, NULL, 0
	rjmp L105
L104:
	addi r0, NULL, 1
L105:
	cmpi r0, 0
	breq L103
	push[2] BP
	load[2] r2, BP, -2
	push[2] r2
	addi r3, NULL, 0
	push[2] r3
	subi SP, SP, 2
	call tile_index_write
	addi SP, SP, 6
	pop[2] BP
	rjmp L102
L103:
	addi r0, NULL, 0
	addi r1, NULL, 0
	addi r2, NULL, 0
	addi SP, SP, 2
	store[2] NULL, r0, CURSOR
	store[2] NULL, r1, CURSOR_X
	store[2] NULL, r2, CURSOR_Y
	move RR, NULL
	ret

memset:
	move BP, SP
	load[2] r0, BP, 2
	load[2] r1, BP, 4
	load[1] r2, BP, 7
	subi SP, SP, 2
	addi r3, NULL, 0
	store[2] BP, r3, -2
L106:
	load[2] r0, BP, -2
	load[2] r1, BP, 4
	cmp r0, r1
	brlt L108
	addi r0, NULL, 0
	rjmp L109
L108:
	addi r0, NULL, 1
L109:
	cmpi r0, 0
	breq L107
	load[2] r2, BP, 2
	load[2] r3, BP, -2
	addi r4, NULL, 1
	mul r3, r3, r4
	add r2, r2, r3
	load[1] r4, BP, 7
	store[1] r2, r4, 0
	addi r3, r3, 1
	store[2] BP, r3, -2
	rjmp L106
L107:
	addi SP, SP, 2
	move RR, NULL
	ret

add_changed:
	move BP, SP
	load[2] r0, BP, 2
	addi r1, NULL, changed
	load[2] r2, NULL, changed_index
	addi r3, NULL, 2
	mul r2, r2, r3
	add r1, r1, r2
	store[2] r1, r0, 0
	addi r2, r2, 1
	store[2] NULL, r2, changed_index
	move RR, NULL
	ret

calc_next_gen:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	subi SP, SP, 2
	addi r1, NULL, 0
	subi SP, SP, 2
	addi r2, NULL, 0
	store[2] BP, r0, -2
	store[2] BP, r1, -4
	store[2] BP, r2, -6
L110:
	load[2] r0, BP, -2
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brlt L112
	addi r0, NULL, 0
	rjmp L113
L112:
	addi r0, NULL, 1
L113:
	cmpi r0, 0
	breq L111
	subi SP, SP, 2
	addi r2, NULL, 0
	subi SP, SP, 2
	addi r3, NULL, -1
	subi SP, SP, 2
	addi r4, NULL, -1
	store[2] BP, r2, -8
	store[2] BP, r3, -10
	store[2] BP, r4, -12
L114:
	load[2] r0, BP, -12
	cmpi r0, 2
	brlt L116
	addi r0, NULL, 0
	rjmp L117
L116:
	addi r0, NULL, 1
L117:
	cmpi r0, 0
	breq L115
L118:
	load[2] r0, BP, -10
	cmpi r0, 2
	brlt L120
	addi r0, NULL, 0
	rjmp L121
L120:
	addi r0, NULL, 1
L121:
	cmpi r0, 0
	breq L119
	subi SP, SP, 2
	load[2] r1, BP, -4
	load[2] r2, BP, -10
	add r1, r1, r2
	subi SP, SP, 2
	load[2] r3, BP, -6
	load[2] r4, BP, -12
	add r3, r3, r4
	store[2] BP, r1, -14
	load[2] r5, NULL, VIDEO_TILE_WIDTH
	cmp r1, r5
	brge L122
	addi r1, NULL, 0
	rjmp L123
L122:
	addi r1, NULL, 1
L123:
	store[2] BP, r3, -16
	cmpi r1, 0
	breq L124
	addi r0, NULL, 0
	store[2] BP, r0, -14
	rjmp L125
L124:
	load[2] r0, BP, -14
	load[2] r1, NULL, VIDEO_TILE_WIDTH
	cmp r0, r1
	brle L126
	addi r0, NULL, 0
	rjmp L127
L126:
	addi r0, NULL, 1
L127:
	cmpi r0, 0
	breq L128
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	subi r0, r0, 1
	store[2] BP, r0, -14
	rjmp L129
L128:
L129:
L125:
	load[2] r0, BP, -16
	load[2] r1, NULL, VIDEO_TILE_HEIGHT
	cmp r0, r1
	brge L130
	addi r0, NULL, 0
	rjmp L131
L130:
	addi r0, NULL, 1
L131:
	cmpi r0, 0
	breq L132
	addi r0, NULL, 0
	store[2] BP, r0, -16
	rjmp L133
L132:
	load[2] r0, BP, -14
	load[2] r1, NULL, VIDEO_TILE_WIDTH
	cmp r0, r1
	brle L134
	addi r0, NULL, 0
	rjmp L135
L134:
	addi r0, NULL, 1
L135:
	cmpi r0, 0
	breq L136
	load[2] r0, NULL, VIDEO_TILE_HEIGHT
	subi r0, r0, 1
	store[2] BP, r0, -16
	rjmp L137
L136:
L137:
L133:
	subi SP, SP, 2
	load[2] r0, BP, -14
	load[2] r1, NULL, VIDEO_TILE_WIDTH
	load[2] r2, BP, -16
	mul r1, r1, r2
	add r0, r0, r1
	load[2] r3, BP, -8
	addi r4, NULL, buffer
	store[2] BP, r0, -18
	add r0, r4, r0
	load[1] r0, r0, 0
	add r3, r3, r0
	load[2] r5, BP, -10
	addi r5, r5, 1
	addi SP, SP, 6
	store[2] BP, r3, -8
	store[2] BP, r5, -10
	rjmp L118
L119:
	load[2] r0, BP, -12
	addi r0, r0, 1
	store[2] BP, r0, -12
	rjmp L114
L115:
	addi r0, NULL, buffer
	load[2] r1, BP, -2
	add r1, r0, r1
	load[1] r1, r1, 0
	cmpi r1, 1
	breq L138
	addi r1, NULL, 0
	rjmp L139
L138:
	addi r1, NULL, 1
L139:
	cmpi r1, 0
	breq L140
	load[2] r0, BP, -8
	cmpi r0, 2
	brlt L142
	addi r0, NULL, 0
	rjmp L143
L142:
	addi r0, NULL, 1
L143:
	load[2] r1, BP, -8
	cmpi r1, 3
	brgt L144
	addi r1, NULL, 0
	rjmp L145
L144:
	addi r1, NULL, 1
L145:
	or r0, r0, r1
	cmpi r0, 0
	breq L146
	push[2] BP
	subi SP, SP, 2
	load[2] r0, BP, -2
	push[2] r0
	call add_changed
	addi SP, SP, 4
	pop[2] BP
	rjmp L147
L146:
L147:
	rjmp L141
L140:
	load[2] r0, BP, -8
	cmpi r0, 3
	breq L148
	addi r0, NULL, 0
	rjmp L149
L148:
	addi r0, NULL, 1
L149:
	cmpi r0, 0
	breq L150
	push[2] BP
	subi SP, SP, 2
	load[2] r0, BP, -2
	push[2] r0
	call add_changed
	addi SP, SP, 4
	pop[2] BP
	rjmp L151
L150:
L151:
L141:
	load[2] r0, BP, -4
	addi r0, r0, 1
	load[2] r1, BP, -2
	addi r1, r1, 1
	store[2] BP, r0, -4
	load[2] r2, NULL, VIDEO_TILE_WIDTH
	cmp r0, r2
	brge L152
	addi r0, NULL, 0
	rjmp L153
L152:
	addi r0, NULL, 1
L153:
	store[2] BP, r1, -2
	cmpi r0, 0
	breq L154
	addi r0, NULL, 0
	store[2] BP, r0, -4
	rjmp L155
L154:
L155:
	addi SP, SP, 6
	rjmp L110
L111:
	addi SP, SP, 6
	move RR, NULL
	ret

print_board:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	store[2] BP, r0, -2
L156:
	load[2] r0, BP, -2
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brlt L158
	addi r0, NULL, 0
	rjmp L159
L158:
	addi r0, NULL, 1
L159:
	cmpi r0, 0
	breq L157
	addi r2, NULL, buffer
	load[2] r3, BP, -2
	add r3, r2, r3
	load[1] r3, r3, 0
	cmpi r3, 0
	breq L160
	push[2] BP
	load[2] r0, BP, -2
	push[2] r0
	addi r1, NULL, 43
	push[2] r1
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 6
	pop[2] BP
	rjmp L161
L160:
	push[2] BP
	load[2] r0, BP, -2
	push[2] r0
	addi r1, NULL, 32
	push[2] r1
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 6
	pop[2] BP
L161:
	rjmp L156
L157:
	addi SP, SP, 2
	move RR, NULL
	ret

update_changed:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	store[2] BP, r0, -2
L162:
	load[2] r0, BP, -2
	load[2] r1, NULL, changed_index
	cmp r0, r1
	brlt L164
	addi r0, NULL, 0
	rjmp L165
L164:
	addi r0, NULL, 1
L165:
	cmpi r0, 0
	breq L163
	subi SP, SP, 2
	addi r2, NULL, changed
	load[2] r3, BP, -2
	addi r4, NULL, 2
	mul r3, r3, r4
	add r3, r2, r3
	load[2] r3, r3, 0
	addi r4, NULL, buffer
	store[2] BP, r3, -4
	add r3, r4, r3
	load[1] r3, r3, 0
	cmpi r3, 0
	breq L166
	addi r0, NULL, buffer
	load[2] r1, BP, -4
	addi r2, NULL, 1
	mul r1, r1, r2
	add r0, r0, r1
	addi r2, NULL, 0
	store[1] r0, r2, 0
	rjmp L167
L166:
	addi r0, NULL, buffer
	load[2] r1, BP, -4
	addi r2, NULL, 1
	mul r1, r1, r2
	add r0, r0, r1
	addi r2, NULL, 1
	store[1] r0, r2, 0
L167:
	addi SP, SP, 2
	rjmp L162
L163:
	addi r0, NULL, 0
	addi SP, SP, 2
	store[2] NULL, r0, changed_index
	move RR, NULL
	ret

sleep_ms:
	move BP, SP
	load[4] r0, BP, 4
	subi SP, SP, 4
	load[4] r1, NULL, SLEEP_MS_MULT
	mul r0, r0, r1
	subi SP, SP, 4
	addi r2, NULL, 0
	store[4] BP, r0, -4
	store[4] BP, r2, -8
L168:
	load[4] r0, BP, -8
	load[4] r1, BP, -4
	cmp r0, r1
	brlt L170
	addi r0, NULL, 0
	rjmp L171
L170:
	addi r0, NULL, 1
L171:
	cmpi r0, 0
	breq L169
	load[4] r2, BP, -8
	addi r2, r2, 1
	store[4] BP, r2, -8
	rjmp L168
L169:
	addi SP, SP, 8
	move RR, NULL
	ret

next_gen:
	move BP, SP
	push[2] BP
	call calc_next_gen
	pop[2] BP
	push[2] BP
	call update_changed
	pop[2] BP
	move RR, NULL
	ret

main:
	move BP, SP
	push[2] BP
	subi SP, SP, 2
	addi r0, NULL, 0
	push[1] r0
	load[2] r0, NULL, VIDEO_TILES
	subi SP, SP, 1
	push[2] r0
	addi r1, NULL, buffer
	push[2] r1
	call memset
	addi SP, SP, 8
	pop[2] BP
	addi r0, NULL, buffer
	addi r0, r0, 41
	addi r1, NULL, 1
	store[1] r0, r1, 0
	addi r0, NULL, buffer
	addi r0, r0, 82
	addi r1, NULL, 1
	store[1] r0, r1, 0
	addi r0, NULL, buffer
	addi r0, r0, 121
	addi r1, NULL, 1
	store[1] r0, r1, 0
	addi r0, NULL, buffer
	addi r0, r0, 122
	addi r1, NULL, 1
	store[1] r0, r1, 0
	addi r0, NULL, buffer
	addi r0, r0, 123
	addi r1, NULL, 1
	store[1] r0, r1, 0
	push[2] BP
	call print_board
	pop[2] BP
L172:
	push[2] BP
	subi SP, SP, 2
	addi r0, NULL, 500
	push[4] r0
	subi SP, SP, 2
	call sleep_ms
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	call next_gen
	pop[2] BP
	rjmp L172
L173:
	move RR, NULL
	ret

