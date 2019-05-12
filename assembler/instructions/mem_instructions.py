from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain, fetch_size

Instruction("nop", 0, chain())

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

Instruction("move", 0b110011, chain(
    fetch_registers(2),
))

Instruction("movlo", 0b111101, chain(
    fetch_registers(1),
    fetch_immediate(2),
))

Instruction("movhi", 0b111100, chain(
    fetch_registers(1),
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
    fetch_registers(2, dest_start_index=8, args_idx=1),
))

Instruction("out", 0b111001, chain( # Didn't find any "OUT" encodingf so same as "IN"
    fetch_registers(2, dest_start_index=8, args_idx=1)
))

Instruction("vgaw", 0b111010, chain( # Didn't find any "OUT" encodingf so same as "IN"
    fetch_registers(2, dest_start_index=8, args_idx=1),
    fetch_immediate(3),
))