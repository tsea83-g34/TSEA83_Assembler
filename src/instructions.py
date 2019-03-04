instructions = dict()

OPCODE_LENGTH = 6
REGISTER_BITS = 5

class Instruction:
    def __init__(self, name, opcode, handler):
        self.opcode = opcode
        binary = self.int_to_bin(opcode)
        self.opcode_bin = "0"*(OPCODE_LENGTH-len(binary)) + binary 
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

    def int_to_bin(self, integer):
        """ Converts and integers to a string of binary and strips away `0b`"""
        return str(bin(integer))[2:]

    def int_to_bin_fill(self, integer, length):
        res = self.int_to_bin(integer)
        return "0"*(length-len(res)) + res 

    def get_registers(self, args, start, num):
        return [ int(arg.replace("r", "")) for arg in args[start:start+num] ] # Removes the 'r' from the register, and converts it to int

    def set_instruction_registers(self, instruction, registers, start):
        dest = start 
        for register in registers:
            instruction[dest:dest+REGISTER_BITS] = self.int_to_bin_fill(register, REGISTER_BITS)
            dest+=REGISTER_BITS



""" Handlers for all the instructions. 
    `instruction` is the 32-bit instruction (array of strings, one or zero),
    that needs to be written to and returned. It begins with opcode, encoded
    into binary, and the rest of the bits are zeros.
"""

def load(self, assembler, instruction, args, idx):
    return instruction


def add(self, assembler, instruction, args, idx):
    registers = self.get_registers(args, 1, 3)
    self.set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction


def addi(self, assembler, instruction, args, idx):
    registers = self.get_registers(args, 1, 2)
    #print(registers)
    self.set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    intermediate = self.int_to_bin_fill(int(args[-1]), 16)
    instruction[16:] = intermediate
    return instruction


def jmp(self, assembler, instruction, args, idx):
    jmp_label = args[1]
    if jmp_label not in assembler.labels:
        raise KeyError("Such a label does not exist for jump: {}".format(jmp_label))
    jmp_dest = self.int_to_bin_fill(assembler.labels[jmp_label], 32-OPCODE_LENGTH)
    #print("Jump to : {} at line {}".format(jmp_label, int(jmp_dest, 2)+1))
    instruction[OPCODE_LENGTH:] = jmp_dest
    return instruction


Instruction("load", 0x11, load)
Instruction("addi", 0x31, addi)
Instruction("add", 0x32, add)
Instruction("jmp", 0x01, jmp)