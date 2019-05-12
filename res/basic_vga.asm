const SP r15
const NULL r14
const BP r13
const RR r12

.data MEMORY_SIZE
	.dh 4096

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
	store[2] BP, r1, 10
	move RR, NULL
	ret

vga_write:
	move BP, SP
	load[4] r0, BP, 4
	load[2] r1, BP, 10
	vgaw r1, r0
	store[2] BP, r1, 10
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

main:
	move BP, SP
	push[2] BP
	subi SP, SP, 2
	addi r0, NULL, 0
	push[2] r0
	addi r0, NULL, 10512
	subi SP, SP, 2
	push[4] r0
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 12
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	addi r0, NULL, 1
	push[2] r0
	addi r0, NULL, 10768
	subi SP, SP, 2
	push[4] r0
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 12
	pop[2] BP
	push[2] BP
	subi SP, SP, 2
	addi r0, NULL, 10767
	subi SP, SP, 2
	push[4] r0
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 12
	pop[2] BP
	push[2] BP
	addi r0, NULL, 0
	push[2] r0
	addi r0, NULL, 10768
	subi SP, SP, 2
	push[4] r0
	subi SP, SP, 2
	call vga_write
	addi SP, SP, 10
	pop[2] BP
	addi SP, SP, -2
	move RR, NULL
	ret

