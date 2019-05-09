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
	.db 0
.data BG_COLOR
	.db 0
.data CURSOR
	.dh 0
.data CURSOR_X
	.dh 0
.data CURSOR_Y
	.dh 0
.data PURE_BLACK
	.db 0
.data DARK_GRAY
	.db 73
.data LIGHT_GRAY
	.db 146
.data PURE_WHITE
	.db 255
.data PURE_RED
	.db 224
.data PURE_ORANGE
	.db 240
.data PURE_YELLOW
	.db 252
.data PURE_LIME
	.db 156
.data PURE_GREEN
	.db 28
.data PURE_TEAL
	.db 30
.data PURE_AZURE
	.db 31
.data PURE_BLUE
	.db 19
.data PURE_MARINE
	.db 3
.data PURE_PURPLE
	.db 131
.data PURE_PINK
	.db 227
.data TEMPLE_BLUE
	.db 95
.data TEMPLE_YELLOW
	.db 253
.data TEMPLE_GREEN
	.db 190
.data TEMPLE_BLUE_DARK
	.db 45
.data TEMPLE_YELLOW_DARK
	.db 108
.data TEMPLE_GREEN_DARK
	.db 77
.data ATOM_PINK
	.db 207
.data ATOM_GRAY
	.db 36
.data ATOM_GREEN
	.db 118
.data ATOM_WHITE
	.db 182
.data ATOM_BLUE
	.db 87
.data ATOM_RED
	.db 233

in:
	move BP, SP
	load[2] r0, BP, 2
	subi SP, SP, 4
	load[4] r1, BP, -4
	in r1, r0
	move RR, r1
	addi SP, SP, 4
	ret

out:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r1, BP, 10
	out r1, r0
	move RR, NULL
	ret

vga_write:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r1, BP, 10
	vgaw r1, r0
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

divide:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r1, BP, 6
	subi SP, SP, 2
	subi SP, SP, 2
	addi r2, NULL, 0
	store[2] BP, r0, -2
	store[2] BP, r2, -4
L4:
	load[2] r0, BP, -2
	load[2] r1, BP, 6
	cmp r0, r1
	brgt L6
	addi r0, NULL, 0
	rjmp L7
L6:
	addi r0, NULL, 1
L7:
	cmpi r0, 1
	brne L5
	load[2] r2, BP, -2
	sub r2, r2, r1
	move r3, r2
	load[2] r4, BP, -4
	addi r4, r4, 1
	move r5, r4
	rjmp L4
L5:
	subi SP, SP, 4
	load[2] r0, BP, -4
	store[4] BP, r0, -8
	load[2] r1, BP, -2
	add r0, r0, r1
	move r2, r0
	move RR, r2
	addi SP, SP, 8
	ret

tile_index_write:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r3, BP, 10
	load[2] r4, NULL, VIDEO_TILES
	cmp r3, r4
	brge L8
	addi r3, NULL, 0
	rjmp L9
L8:
	addi r3, NULL, 1
L9:
	cmpi r3, 1
	brne L10
	addi RR, NULL, 0
	ret
	rjmp L11
L10:
L11:
	push[2] BP
	subi SP, SP, 2
	load[2] r0, BP, 10
	push[2] r0
	load[4] r1, BP, 4
	subi SP, SP, 2
	push[4] r1
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 12
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
	brge L12
	addi r1, NULL, 0
	rjmp L13
L12:
	addi r1, NULL, 1
L13:
	load[2] r4, NULL, VIDEO_PIXEL_HEIGHT
	cmp r2, r4
	brge L14
	addi r2, NULL, 0
	rjmp L15
L14:
	addi r2, NULL, 1
L15:
	or r1, r1, r2
	cmpi r1, 1
	brne L16
	addi RR, NULL, 0
	ret
	rjmp L17
L16:
L17:
	subi SP, SP, 2
	load[2] r0, BP, 8
	load[2] r1, NULL, VIDEO_PIXEL_WIDTH
	load[2] r2, BP, 10
	mul r1, r1, r2
	add r0, r0, r1
	push[2] BP
	push[2] r0
	load[4] r3, BP, 4
	subi SP, SP, 2
	push[4] r3
	store[2] BP, r0, -2
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 10
	pop[2] BP
	addi RR, NULL, 1
	addi SP, SP, 2
	ret

palette_index_write:
	move BP, SP
	load[2] r0, BP, 4
	load[1] r1, BP, 6
	load[1] r2, BP, 7
	load[2] r3, NULL, PALETTE_SIZE
	cmp r0, r3
	brge L18
	addi r0, NULL, 0
	rjmp L19
L18:
	addi r0, NULL, 1
L19:
	cmpi r0, 1
	brne L20
	addi RR, NULL, 0
	ret
	rjmp L21
L20:
L21:
	subi SP, SP, 2
	load[2] r0, NULL, PALETTE_START
	load[2] r1, BP, 4
	add r0, r0, r1
	subi SP, SP, 6
	load[1] r2, BP, 6
	store[4] BP, r2, -8
	load[1] r3, BP, 7
	add r2, r2, r3
	move r4, r2
	push[2] BP
	subi SP, SP, 2
	push[2] r0
	subi SP, SP, 2
	push[4] r4
	store[2] BP, r0, -2
	store[4] BP, r4, -8
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 12
	pop[2] BP
	addi RR, NULL, 1
	addi SP, SP, 8
	ret

set_cursor:
	move BP, SP
	load[1] r0, BP, 2
	load[1] r1, BP, 3
	load[2] r2, NULL, VIDEO_TILE_WIDTH
	cmp r0, r2
	brge L22
	addi r0, NULL, 0
	rjmp L23
L22:
	addi r0, NULL, 1
L23:
	load[2] r3, NULL, VIDEO_TILE_HEIGHT
	cmp r1, r3
	brge L24
	addi r1, NULL, 0
	rjmp L25
L24:
	addi r1, NULL, 1
L25:
	or r0, r0, r1
	cmpi r0, 1
	brne L26
	addi RR, NULL, 0
	ret
	rjmp L27
L26:
L27:
	load[1] r0, BP, 2
	move r1, r0
	load[1] r2, BP, 3
	move r3, r2
	add r0, r0, r2
	load[2] r4, NULL, VIDEO_TILE_WIDTH
	mul r0, r0, r4
	move r5, r0
	addi RR, NULL, 1
	ret

advance_cursor:
	move BP, SP
	load[2] r0, NULL, CURSOR
	addi r0, r0, 1
	move r1, r0
	store[2] NULL, r1, CURSOR
	load[2] r2, NULL, VIDEO_TILES
	cmp r1, r2
	brlt L28
	addi r1, NULL, 0
	rjmp L29
L28:
	addi r1, NULL, 1
L29:
	cmpi r1, 1
	brne L30
	load[2] r0, NULL, CURSOR_X
	addi r0, r0, 1
	move r1, r0
	store[2] NULL, r1, CURSOR_X
	load[2] r2, NULL, VIDEO_TILE_WIDTH
	cmp r1, r2
	brge L32
	addi r1, NULL, 0
	rjmp L33
L32:
	addi r1, NULL, 1
L33:
	cmpi r1, 1
	brne L34
	addi r0, NULL, 0
	load[2] r1, NULL, CURSOR_Y
	addi r1, r1, 1
	move r2, r1
	store[2] NULL, r0, CURSOR_X
	store[2] NULL, r2, CURSOR_Y
	rjmp L35
L34:
L35:
	rjmp L31
L30:
	addi r0, NULL, 0
	addi r1, NULL, 0
	addi r2, NULL, 0
	store[2] NULL, r0, CURSOR
	store[2] NULL, r1, CURSOR_X
	store[2] NULL, r2, CURSOR_Y
L31:
	move RR, NULL
	ret

back_cursor:
	move BP, SP
	load[2] r0, NULL, CURSOR
	subi r0, r0, 1
	move r1, r0
	store[2] NULL, r1, CURSOR
	load[2] r2, NULL, VIDEO_TILES
	cmp r1, r2
	brlt L36
	addi r1, NULL, 0
	rjmp L37
L36:
	addi r1, NULL, 1
L37:
	cmpi r1, 1
	brne L38
	load[2] r0, NULL, CURSOR_X
	subi r0, r0, 1
	move r1, r0
	store[2] NULL, r1, CURSOR_X
	cmpi r1, 0
	brlt L40
	addi r1, NULL, 0
	rjmp L41
L40:
	addi r1, NULL, 1
L41:
	cmpi r1, 1
	brne L42
	addi r0, NULL, 0
	load[2] r1, NULL, CURSOR_Y
	subi r1, r1, 1
	move r2, r1
	store[2] NULL, r0, CURSOR_X
	store[2] NULL, r2, CURSOR_Y
	rjmp L43
L42:
L43:
	rjmp L39
L38:
	load[2] r0, NULL, VIDEO_TILES
	subi r0, r0, 1
	move r1, r0
	load[2] r2, NULL, VIDEO_TILE_WIDTH
	move r3, r2
	load[2] r4, NULL, VIDEO_TILE_HEIGHT
	move r5, r4
	store[2] NULL, r1, CURSOR
	store[2] NULL, r3, CURSOR_X
	store[2] NULL, r5, CURSOR_Y
L39:
	move RR, NULL
	ret

advance_steps:
	move BP, SP
	load[2] r0, BP, 2
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brge L44
	addi r0, NULL, 0
	rjmp L45
L44:
	addi r0, NULL, 1
L45:
	cmpi r0, 1
	brne L46
	addi RR, NULL, 0
	ret
	rjmp L47
L46:
L47:
	load[2] r0, NULL, CURSOR
	load[2] r1, BP, 2
	add r0, r0, r1
	move r2, r0
	store[2] NULL, r2, CURSOR
	load[2] r3, NULL, VIDEO_TILES
	cmp r2, r3
	brge L48
	addi r2, NULL, 0
	rjmp L49
L48:
	addi r2, NULL, 1
L49:
	cmpi r2, 1
	brne L50
	load[2] r0, NULL, CURSOR
	load[2] r1, NULL, VIDEO_TILES
	sub r0, r0, r1
	move r2, r0
	store[2] NULL, r2, CURSOR
	rjmp L51
L50:
L51:
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
	addi RR, NULL, 1
	addi SP, SP, 8
	ret

advance_line:
	move BP, SP
	load[2] r0, NULL, CURSOR_Y
	addi r0, r0, 1
	move r1, r0
	store[2] NULL, r1, CURSOR_Y
	load[2] r2, NULL, VIDEO_TILE_HEIGHT
	cmp r1, r2
	brlt L52
	addi r1, NULL, 0
	rjmp L53
L52:
	addi r1, NULL, 1
L53:
	cmpi r1, 1
	brne L54
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	load[2] r1, NULL, CURSOR_Y
	mul r0, r0, r1
	move r2, r0
	store[2] NULL, r2, CURSOR
	rjmp L55
L54:
	addi r0, NULL, 0
	addi r1, NULL, 0
	store[2] NULL, r0, CURSOR
	store[2] NULL, r1, CURSOR_Y
L55:
	addi r0, NULL, 0
	move RR, NULL
	ret

back_line:
	move BP, SP
	load[2] r0, NULL, CURSOR_Y
	subi r0, r0, 1
	move r1, r0
	store[2] NULL, r1, CURSOR_Y
	cmpi r1, 0
	brge L56
	addi r1, NULL, 0
	rjmp L57
L56:
	addi r1, NULL, 1
L57:
	cmpi r1, 1
	brne L58
	load[2] r0, NULL, VIDEO_TILE_WIDTH
	load[2] r1, NULL, CURSOR_Y
	mul r0, r0, r1
	move r2, r0
	store[2] NULL, r2, CURSOR
	rjmp L59
L58:
	load[2] r0, NULL, VIDEO_TILES
	subi r0, r0, 1
	move r1, r0
	load[2] r2, NULL, VIDEO_TILE_HEIGHT
	move r3, r2
	store[2] NULL, r1, CURSOR
	store[2] NULL, r3, CURSOR_Y
L59:
	addi r0, NULL, 0
	move RR, NULL
	ret

print_c_at:
	move BP, SP
	load[1] r0, BP, 2
	load[1] r1, BP, 3
	load[1] r2, NULL, FG_COLOR
	load[2] r3, NULL, PALETTE_SIZE
	cmp r2, r3
	brge L60
	addi r2, NULL, 0
	rjmp L61
L60:
	addi r2, NULL, 1
L61:
	load[1] r4, NULL, BG_COLOR
	cmp r4, r3
	brge L62
	addi r4, NULL, 0
	rjmp L63
L62:
	addi r4, NULL, 1
L63:
	or r2, r2, r4
	cmpi r2, 1
	brne L64
	addi RR, NULL, 0
	ret
	rjmp L65
L64:
L65:
	subi SP, SP, 2
	load[1] r0, NULL, FG_COLOR
	store[2] BP, r0, -2
	load[1] r1, NULL, BG_COLOR
	add r0, r0, r1
	move r2, r0
	subi SP, SP, 2
	load[1] r3, BP, 2
	store[2] BP, r3, -4
	add r3, r3, r2
	move r4, r3
	push[2] BP
	subi SP, SP, 2
	load[1] r5, BP, 3
	push[2] r5
	subi SP, SP, 2
	push[4] r4
	store[2] BP, r2, -2
	store[2] BP, r4, -4
	subi SP, SP, 2
	call tile_index_write
	addi SP, SP, 12
	pop[2] BP
	addi SP, SP, 4
	ret

print_c_at_pos:
	move BP, SP
	load[1] r0, BP, 2
	load[1] r1, BP, 3
	load[1] r2, BP, 4
	push[2] BP
	subi SP, SP, 2
	load[2] r3, NULL, VIDEO_TILE_WIDTH
	add r1, r1, r3
	mul r1, r1, r2
	push[1] r1
	push[1] r0
	call print_c_at
	addi SP, SP, 4
	pop[2] BP
	ret

print_c:
	move BP, SP
	load[1] r0, BP, 2
	push[2] BP
	subi SP, SP, 2
	load[2] r1, NULL, CURSOR
	push[1] r1
	push[1] r0
	call print_c_at
	addi SP, SP, 4
	pop[2] BP
	cmpi RR, 1
	brne L66
	load[2] r0, NULL, CURSOR
	addi r0, r0, 1
	move r1, r0
	store[2] NULL, r1, CURSOR
	load[2] r2, NULL, VIDEO_TILES
	cmp r1, r2
	brge L68
	addi r1, NULL, 0
	rjmp L69
L68:
	addi r1, NULL, 1
L69:
	cmpi r1, 1
	brne L70
	addi r0, NULL, 0
	store[2] NULL, r0, CURSOR
	rjmp L71
L70:
L71:
	addi RR, NULL, 1
	ret
	rjmp L67
L66:
L67:
	addi RR, NULL, 0
	ret

print:
	move BP, SP
	load[2] r0, BP, 4
	load[2] r1, BP, 6
	subi SP, SP, 2
	addi r2, NULL, 0
	store[2] BP, r2, -2
L72:
	load[2] r0, BP, -2
	load[2] r1, BP, 4
	cmp r0, r1
	brlt L74
	addi r0, NULL, 0
	rjmp L75
L74:
	addi r0, NULL, 1
L75:
	cmpi r0, 1
	brne L73
	load[2] r2, BP, 6
	addi r2, r2, 1
	move r3, r2
	load[2] r4, BP, -2
	addi r4, r4, 1
	move r5, r4
	rjmp L72
L73:
	addi SP, SP, 2
	move RR, NULL
	ret

clear:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	store[2] BP, r0, -2
L76:
	load[2] r0, BP, -2
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brlt L78
	addi r0, NULL, 0
	rjmp L79
L78:
	addi r0, NULL, 1
L79:
	cmpi r0, 1
	brne L77
	push[2] BP
	load[2] r2, BP, -2
	push[2] r2
	addi r3, NULL, 0
	subi SP, SP, 2
	push[4] r3
	subi SP, SP, 2
	call tile_index_write
	addi SP, SP, 10
	pop[2] BP
	rjmp L76
L77:
	addi r0, NULL, 0
	addi SP, SP, 2
	move RR, NULL
	ret

load_basic_palette:
	move BP, SP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_BLACK
	push[1] r0
	push[1] r0
	addi r1, NULL, 0
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, DARK_GRAY
	push[1] r0
	push[1] r0
	addi r1, NULL, 1
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, LIGHT_GRAY
	push[1] r0
	push[1] r0
	addi r1, NULL, 2
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_WHITE
	push[1] r0
	push[1] r0
	addi r1, NULL, 3
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_RED
	push[1] r0
	push[1] r0
	addi r1, NULL, 4
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_ORANGE
	push[1] r0
	push[1] r0
	addi r1, NULL, 5
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_YELLOW
	push[1] r0
	push[1] r0
	addi r1, NULL, 6
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_LIME
	push[1] r0
	push[1] r0
	addi r1, NULL, 7
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_GREEN
	push[1] r0
	push[1] r0
	addi r1, NULL, 8
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_TEAL
	push[1] r0
	push[1] r0
	addi r1, NULL, 9
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_AZURE
	push[1] r0
	push[1] r0
	addi r1, NULL, 10
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_BLUE
	push[1] r0
	push[1] r0
	addi r1, NULL, 11
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_MARINE
	push[1] r0
	push[1] r0
	addi r1, NULL, 12
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_PURPLE
	push[1] r0
	push[1] r0
	addi r1, NULL, 13
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	load[1] r0, NULL, PURE_PINK
	push[1] r0
	push[1] r0
	addi r1, NULL, 14
	push[2] r1
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	addi r0, NULL, 0
	push[1] r0
	addi r0, NULL, 0
	push[1] r0
	addi r0, NULL, 15
	push[2] r0
	subi SP, SP, 2
	call palette_index_write
	addi SP, SP, 8
	pop[2] BP
	move RR, NULL
	ret

main:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0
	subi SP, SP, 2
	addi r1, NULL, 0
	store[2] BP, r0, -2
	store[2] BP, r1, -4
L80:
	load[2] r0, BP, -2
	load[2] r1, NULL, VIDEO_TILES
	cmp r0, r1
	brlt L82
	addi r0, NULL, 0
	rjmp L83
L82:
	addi r0, NULL, 1
L83:
	cmpi r0, 1
	brne L81
	load[2] r2, BP, -4
	cmpi r2, 11
	brge L84
	addi r2, NULL, 0
	rjmp L85
L84:
	addi r2, NULL, 1
L85:
	cmpi r2, 1
	brne L86
	addi r0, NULL, 0
	store[2] BP, r0, -4
	rjmp L87
L86:
L87:
	addi r0, NULL, 4
	load[2] r1, BP, -4
	add r0, r0, r1
	move r2, r0
	push[2] BP
	subi SP, SP, 2
	addi r3, NULL, 0
	push[1] r3
	store[1] NULL, r2, BG_COLOR
	call print_c
	addi SP, SP, 3
	pop[2] BP
	load[2] r0, BP, -2
	addi r0, r0, 1
	move r1, r0
	load[2] r2, BP, -4
	addi r2, r2, 1
	move r3, r2
	rjmp L80
L81:
	addi SP, SP, 4
	move RR, NULL
	ret

