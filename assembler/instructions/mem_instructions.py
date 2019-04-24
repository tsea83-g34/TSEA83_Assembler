from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain, fetch_size


# load word
Instruction("load", 0x11, chain(
    fetch_size(),
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("ldb", 0x11, chain(
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("ldh", 0x11, chain(
    fetch_registers(2),
    fetch_immediate(3),
))


Instruction("store", 0x12, chain(
    fetch_size(),
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("sth", 0x12, chain(
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("stb", 0x12, chain(
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("mov", 0x4, chain(
    fetch_registers(2),
))

Instruction("movlo", 0x5, chain(
    fetch_registers(2),
    fetch_immediate(2),
))

Instruction("movhi", 0x6, chain(
    fetch_registers(2),
    fetch_immediate(2),
))

Instruction("ldi", 0x5, chain(
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("push", 0x01, fetch_registers(1))
Instruction("pushh", 0x01, fetch_registers(1))
Instruction("pushb", 0x01, fetch_registers(1))

Instruction("pop", 0x01, fetch_registers(1)) #
Instruction("poph", 0x01, fetch_registers(1)) #
Instruction("popb", 0x01, fetch_registers(1)) #


Instruction("in", 0x01, chain(
    fetch_immediate(1, length=5, ir_idx=6),
    fetch_registers(1, dest_start_index=11, args_idx=2)
))
Instruction("out", 0x01, chain(
    fetch_immediate(1, length=5, ir_idx=6),
    fetch_registers(1, dest_start_index=11, args_idx=2)
))