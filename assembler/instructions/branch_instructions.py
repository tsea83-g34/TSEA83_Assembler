from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain, jmp



Instruction("call", 0b000101, jmp)
Instruction("ret", 0b00100, chain())

Instruction("jmp", 0x01, jmp)
Instruction("jmpreg", 0x01, chain(
    fetch_registers(1),
))

Instruction("breq", 0b000110, jmp)
Instruction("brne", 0b000111, jmp)

Instruction("brge", 0x02, jmp)
Instruction("brgt", 0b001001, jmp)


Instruction("brlt", 0b001000, jmp)
Instruction("brle", 0x03, jmp)
Instruction("pass", 0x03, jmp)



