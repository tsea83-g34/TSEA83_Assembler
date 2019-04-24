import assembler
print(assembler)
from assembler.instructions.instructions import Instruction, fetch_registers, fetch_immediate, chain 

## LOGICAL
Instruction("and", 0x10, chain(
    fetch_registers(3),
))

Instruction("xor", 0x10, chain(
    fetch_registers(3),
))

Instruction("or", 0x10, chain(
    fetch_registers(3),
))

Instruction("not", 0x10, chain(
    fetch_registers(3),
))

# ARITHMETIC
Instruction("addi", 0x31, chain(
    fetch_registers(2),
    fetch_immediate(3),
))

Instruction("subi", 0x36, chain(
    fetch_registers(2),
    fetch_immediate(3)
))

Instruction("add", 0x32, chain(
    fetch_registers(3)
))

Instruction("sub", 0x32, chain(
    fetch_registers(3)
))

Instruction("mul", 0x38, chain(
    fetch_registers(3)
))

Instruction("cmp", 0x33, chain(
    fetch_registers(2, 11)
))

Instruction("cmpi", 0x34, chain(
    fetch_registers(1, 11),
    fetch_immediate(2)
))

Instruction("neg", 0x33, chain(
    fetch_registers(1)
))

Instruction("inc", 0x33, chain(
    fetch_registers(1)
))

Instruction("dec", 0x33, chain(
    fetch_registers(1)
))


# SHIFT

Instruction("lsr", 0x39, chain(
    fetch_registers(1),
))

Instruction("lsl", 0x39, chain(
    fetch_registers(1),
))