from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain, jmp



Instruction("call", 0b000101, jmp)
Instruction("ret", 0b00100, chain())

Instruction("rjmp", 0b001100, jmp)
Instruction("rjmprg", 0b111011, chain(
    fetch_registers(1),
))

Instruction("breq", 0b000110, jmp)
Instruction("brne", 0b000111, jmp)

Instruction("brge", 0b001011, jmp)
Instruction("brgt", 0b001001, jmp)


Instruction("brlt", 0b001000, jmp)
Instruction("brle", 0b001010, jmp)
Instruction("pass", 0b001101, jmp)



