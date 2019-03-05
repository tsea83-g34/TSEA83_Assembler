instructions = dict()

OPCODE_LENGTH = 6
REGISTER_BITS = 5
SIGN_BIT_16 = 1<<(15)

def sign_extend_16(value):
    return (value & (SIGN_BIT_16 - 1)) - (value & SIGN_BIT_16)

def int_to_bin(integer):
    """ Converts and integers to a string of binary and strips away `0b`"""
    return str(bin(integer))[2:]

def int_to_bin_fill(integer, length):
    if integer < 0:
        res = int_to_bin(abs(integer))
        res = "0"*(length-len(res)) + res
        res = [int(x) for x in res.split()]
        lsb = res[::-1].index(1)
        if lsb == -1:
            return res ## TODO: 
        res = [x^1 for xi]
    res = int_to_bin(integer)
    return "0"*(length-len(res)) + res 

def get_registers(args, start_arg, num_args):
    return [ int(arg.replace("r", "")) for arg in args[start_arg:start_arg+num_args] ] # Removes the 'r' from the register, and converts it to int

def set_instruction_registers(instruction, registers, start):
    dest = start 
    for register in registers:
        instruction[dest:dest+REGISTER_BITS] = int_to_bin_fill(register, REGISTER_BITS)
        dest+=REGISTER_BITS


class Instruction:
    def __init__(self, name, opcode, handler):
        self.opcode = opcode 
        self.opcode_bin = int_to_bin_fill(opcode, OPCODE_LENGTH)
        #print("OPCODE CONTRL: ", self.opcode_bin, name)
        self.name = name
        self.handler = handler
        instructions[name] = self 
    
    def handle(self, assembler, line, idx):
        line = line.replace(",", "")
        args = line.split() 
        args = [arg.strip() for arg in args]
        instruction = ["0"]*32 
        instruction[:OPCODE_LENGTH] = self.opcode_bin 
        res = self.handler(self, assembler, instruction, args, idx)
        return "".join(res)




""" Handlers for all the instructions. 
    `instruction` is the 32-bit instruction (array of strings, one or zero),
    that needs to be written to and returned. It begins with opcode, encoded
    into binary, and the rest of the bits are zeros.
"""

def load(self, assembler, instruction, args, idx):
    """ load r1, r2, 
        # Loads the content from the ram adress in `r2` into `r1` 
    """ 
    registers = get_registers(args, 1, 2)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction

def movhi(self, assembler, instruction, args, idx):
    """ `movhi r1, 1336` => r1[31:15] = 1336  """ 
    #print("MOVHI ARGS:", args)
    registers = get_registers(args, 1, 1)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    instruction[16:] = int_to_bin_fill(int(args[2]), 16)
    return instruction


def add(self, assembler, instruction, args, idx):
    registers = get_registers(args, 1, 3)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction


def addi(self, assembler, instruction, args, idx):
    registers = get_registers(args, 1, 2)
    #print(registers)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    intermediate = int_to_bin_fill(int(args[-1]), 16)
    instruction[16:] = intermediate
    return instruction

def mul(self, assembler, instruction, args, idx):
    registers = get_registers(args, 1, 3)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction


def jmp(self, assembler, instruction, args, idx):
    jmp_label = args[1]
    if jmp_label not in assembler.labels:
        raise KeyError("Such a label does not exist for jump: {}".format(jmp_label))
    jmp_offset = idx-assembler.labels[jmp_label]
    print("EXTEND", bin(sign_extend_16(jmp_offset)))
    print("JMP", jmp_offset)
    jmp_offset = int_to_bin_fill(jmp_offset, 16)
    print("JMP OFFSET:", jmp_offset)
    instruction[16:] = jmp_offset
    return instruction


Instruction("load", 0x11, load)
Instruction("movhi", 0x6, movhi)
Instruction("addi", 0x31, addi)
Instruction("add", 0x32, add)
Instruction("mul", 0x38, mul)
Instruction("jmp", 0x01, jmp)