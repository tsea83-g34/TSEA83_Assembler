const SP r15
const NULL r14
const BP r13
const RR r12

fibonacci:
	move BP, SP
	load[2] r0, BP, 2
	cmpi r0, 1
	breq L0
	addi r0, NULL, 0
	rjmp L1
L0:
	addi r0, NULL, 1
L1:
	cmpi r0, 1
	brne L2
	addi RR, NULL, 1
	ret
L2:
	load[2] r1, BP, 2
	cmpi r1, 2
	breq L3
	addi r1, NULL, 0
	rjmp L4
L3:
	addi r1, NULL, 1
L4:
	cmpi r1, 1
	brne L5
	addi RR, NULL, 1
	ret
L5:
	subi SP, SP, 2
	addi r2, NULL, 1
	subi SP, SP, 2
	addi r3, NULL, 1
	subi SP, SP, 2
	addi r4, NULL, 0
	subi SP, SP, 2
	addi r5, NULL, 2
	store[2] BP, r2, -2
	store[2] BP, r3, -4
	store[2] BP, r4, -6
	store[2] BP, r5, -8
L6:
	load[2] r0, BP, -8
	load[2] r1, BP, 2
	cmp r0, r1
	brne L8
	addi r0, NULL, 0
	rjmp L9
L8:
	addi r0, NULL, 1
L9:
	cmpi r0, 1
	brne L7
	load[2] r2, BP, -6
	cmpi r2, 0
	breq L10
	addi r2, NULL, 0
	rjmp L11
L10:
	addi r2, NULL, 1
L11:
	cmpi r2, 1
	brne L12
	load[2] r3, BP, -2
	load[2] r4, BP, -4
	add r3, r3, r4
	move r5, r3
	addi r6, NULL, 1
L12:
	cmpi r6, 1
	breq L13
	addi r6, NULL, 0
	rjmp L14
L13:
	addi r6, NULL, 1
L14:
	cmpi r6, 1
	brne L15
	add r4, r4, r5
	move r3, r4
	addi r6, NULL, 0
L15:
	addi r1, r1, 1
	move r4, r1
	store[2] BP, r3, -4
	store[2] BP, r4, 2
	store[2] BP, r5, -2
	store[2] BP, r6, -6
	rjmp L6
L7:
	load[2] r0, BP, -6
	cmpi r0, 0
	breq L16
	addi r0, NULL, 0
	rjmp L17
L16:
	addi r0, NULL, 1
L17:
	cmpi r0, 1
	brne L18
	load[2] r1, BP, -4
	move RR, r1
	addi SP, SP, 8
	ret
L18:
	load[2] r2, BP, -6
	cmpi r2, 1
	breq L19
	addi r2, NULL, 0
	rjmp L20
L19:
	addi r2, NULL, 1
L20:
	cmpi r2, 1
	brne L21
	load[2] r3, BP, -2
	move RR, r3
	addi SP, SP, 8
	ret
L21:
	addi SP, SP, 8
	move RR, NULL
	ret
main:
	move BP, SP
	subi SP, SP, 2
	push[2] BP
	subi SP, SP, 2
	addi r0, NULL, 10
	push[2] r0
	call fibonacci
	addi SP, SP, 4
	pop[2] BP
	move r0, RR
	addi RR, NULL, 0
	addi SP, SP, 2
	ret