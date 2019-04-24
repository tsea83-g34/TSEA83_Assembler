from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain, jmp



Instruction("call", 0x07, jmp)
Instruction("ret", 0x07, chain())

Instruction("jmp", 0x01, jmp)

Instruction("brge", 0x02, jmp)
Instruction("brgt", 0x03, jmp)
Instruction("breq", 0x04, jmp)
Instruction("brne", 0x03, jmp)

Instruction("brlt", 0x03, jmp)
Instruction("brle", 0x03, jmp)
Instruction("pass", 0x03, jmp)



