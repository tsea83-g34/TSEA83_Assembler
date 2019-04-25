from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain, fetch_size


# load word
Instruction("load", 0b100000 , chain(
    fetch_size(),
    fetch_registers(2),
    fetch_immediate(3),
))


Instruction("store", 0b110100, chain(
    fetch_size(),
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("store_pm", 0b110101, chain(
    fetch_size(),
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("mov", 0b110011, chain(
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

Instruction("push", 0b110110, chain(
    fetch_size(),
    fetch_registers(1)
))


Instruction("pop", 0b000010, chain(
    fetch_size(),
    fetch_registers(1)
))


Instruction("in", 0b000011, chain(
    fetch_immediate(1, length=5, ir_idx=6),
    fetch_registers(1, dest_start_index=11, args_idx=2)
))
Instruction("out", 0b000011, chain( # Didn't find any "OUT" encodingf so same as "IN"
    fetch_immediate(1, length=5, ir_idx=6),
    fetch_registers(1, dest_start_index=11, args_idx=2)
))