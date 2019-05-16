const SP r15
const NULL r14
const BP r13
const RR r12


	subi SP, SP, 1
	call main
	subi SP, SP, 2
__halt:
	rjmp __halt

main:
	move BP, SP
	subi SP, SP, 2
	addi r0, NULL, 0 			; a = 0
	subi SP, SP, 2
	addi r1, NULL, 0 			; x = 0
	subi SP, SP, 2
	addi r2, NULL, 0 			; y = 0
	subi SP, SP, 2
	addi r3, NULL, 0 			; z = 0
	subi SP, SP, 2
	addi r4, NULL, 0 			; w = 0
	subi SP, SP, 2
	addi r5, NULL, 0 			; k = 0
	subi SP, SP, 2
	addi r6, NULL, 0 			; p = 0
	subi SP, SP, 2
	addi r7, NULL, 255 		; test = 0x00FF
	subi SP, SP, 2
	movhi r8, r8, 0
	movlo r8, r8, 65535 	; out_v = 0xFFFF
	out 00, r0 						; test out 1
	store[2] BP, r0, -2   ; 
	cmpi r0, 0						; conditional
	brlt L0								; go to if a < 0
	addi r0, NULL, 0			; set r0 to false
	rjmp L1								; if not a < 0 then skip
L0:
	addi r0, NULL, 1			; set r0 to true
L1:
	store[2] BP, r1, -4		; store context
	store[2] BP, r2, -6
	store[2] BP, r3, -8
	store[2] BP, r4, -10
	store[2] BP, r5, -12
	store[2] BP, r6, -14
	store[2] BP, r7, -16  ; test var in store context
	store[2] BP, r8, -18
	cmpi r0, 1						; check if conditional is true
	brne L2								; if conditional is not true
	load[2] r0, BP, -16		; 
	move r1, r0						; preemptive x = test
	store[2] BP, r1, -4   ; store x = test
	rjmp L3								; jump to reload out_v, exit if 
L2:
	load[2] r0, BP, -2    ; load return address
	cmpi r0, 0
	breq L4
	addi r0, NULL, 0
	rjmp L5
L4:
	addi r0, NULL, 1
L5:
	cmpi r0, 1
	brne L6
	load[2] r0, BP, -16
	move r1, r0
	store[2] BP, r1, -6
	rjmp L7
L6:
	load[2] r0, BP, -2
	cmpi r0, 0
	brgt L8
	addi r0, NULL, 0
	rjmp L9
L8:
	addi r0, NULL, 1
L9:
	cmpi r0, 1
	brne L10
	load[2] r0, BP, -16
	move r1, r0
	store[2] BP, r1, -8
	rjmp L11
L10:
	load[2] r0, BP, -2
	cmpi r0, 0
	brle L12
	addi r0, NULL, 0
	rjmp L13
L12:
	addi r0, NULL, 1
L13:
	cmpi r0, 1
	brne L14
	load[2] r0, BP, -16
	move r1, r0
	store[2] BP, r1, -10
	rjmp L15
L14:
	load[2] r0, BP, -2
	cmpi r0, 0
	brge L16
	addi r0, NULL, 0
	rjmp L17
L16:
	addi r0, NULL, 1
L17:
	cmpi r0, 1
	brne L18
	load[2] r0, BP, -16
	move r1, r0
	store[2] BP, r1, -12
	rjmp L19
L18:
	load[2] r0, BP, -16
	move r1, r0
	store[2] BP, r1, -14
L19:
L15:
L11:
L7:
L3:
	load[2] r0, BP, -18
	out 00, r0
	addi RR, NULL, 0
	addi SP, SP, 18
	ret

