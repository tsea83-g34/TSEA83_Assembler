from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain 

## LOGICAL
Instruction("and", 0b101111, chain(
    fetch_registers(3),
))

Instruction("xor", 0b110001, chain(
    fetch_registers(3),
))

Instruction("or", 0b110000, chain(
    fetch_registers(3),
))

Instruction("not", 0b110010, chain(
    fetch_registers(3),
))

# ARITHMETIC
Instruction("addi", 0b100010, chain(
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("subi", 0b100011, chain(
    fetch_registers(2),
    fetch_immediate(3)
))

Instruction("add", 0b100100, chain(
    fetch_registers(3)
))

Instruction("sub", 0b100101, chain(
    fetch_registers(3)
))

Instruction("mul", 0b101001, chain(
    fetch_registers(3)
))

Instruction("umul", 0b101010, chain(
    fetch_registers(3)
))

Instruction("cmp", 0b110111, chain(
    fetch_registers(2, 11)
))

Instruction("cmpi", 0b111000, chain(
    fetch_registers(1, 11),
    fetch_immediate(2)
))

Instruction("neg", 0b100110, chain(
    fetch_registers(1)
))

Instruction("inc", 0b100111, chain(
    fetch_registers(1)
))

Instruction("dec", 0b101000, chain(
    fetch_registers(1)
))


# SHIFT

Instruction("lsr", 0b101100, chain(
    fetch_registers(1),
))

Instruction("lsl", 0b101011, chain(
    fetch_registers(1),
))