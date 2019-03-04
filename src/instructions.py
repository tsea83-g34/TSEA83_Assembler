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


""" Handlers for all the instructions. 
    `instruction` is the 32-bit instruction (array of strings, one or zero),
    that needs to be written to and returned. It begins with opcode, encoded
    into binary, and the rest of the bits are zeros.
"""

def load (self, assembler, instruction, args, idx):

    return instruction


def addi (self, assembler, instruction, args, idx):
    print(args)
    registers = [ int(arg.replace("r", "")) for arg in args[1:3] ] # Removes the 'r' from the register, and converts it to int
    dest = OPCODE_LENGTH
    for i in range(2):
        instruction[dest:dest+REGISTER_BITS] = self.int_to_bin_fill(registers[i], REGISTER_BITS)
        dest+=REGISTER_BITS
    intermediate = self.int_to_bin_fill(int(args[-1]), 16)
    instruction[16:] = intermediate
    return instruction


Instruction("load", 0x11, load)
Instruction("addi", 0x31, addi)
