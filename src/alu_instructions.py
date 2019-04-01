from instructions import Instruction, fetch_registers, fetch_immediate, chain 


Instruction("load", 0x11, load)
Instruction("store", 0x12, store)
Instruction("mov", 0x4, nop)
Instruction("movlo", 0x5, movlo)
Instruction("ldi", 0x5, movlo)
Instruction("movhi", 0x6, movhi)
Instruction("push", 0x01, push)
Instruction("pop", 0x01, push) #TODO


Instruction("and", 0x10, nop)
Instruction("addi", 0x31, addi)
Instruction("subi", 0x36, addi)

Instruction("add", 0x32, chain(
    fetch_registers(3)
))

Instruction("cmp", 0x33, chain(
    fetch_registers(2, 11)
))

Instruction("mul", 0x38, chain(
    fetch_registers(3)
))


Instruction("cmpi", 0x34, chain(
    fetch_registers(1, 11),
    fetch_immediate(2)
))

Instruction("call", 0x07, jmp)
Instruction("ret", 0x07, nop) # TODO
Instruction("jmp", 0x01, jmp)
Instruction("brge", 0x02, jmp)
Instruction("brg", 0x03, jmp)
Instruction("breq", 0x04, jmp)

