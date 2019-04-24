from assembler.Register import register


instructions = dict()

DEBUG = False

OPCODE_LENGTH = 6
REGISTER_BITS = 4


""" SUPER REMOVED - DANK DEBUGGING OPTION """





def int_to_bin(integer):
    """ Converts and integers to a string of binary and strips away `0b`"""
    if integer < 0:
        byt = integer.to_bytes(2, "big", signed=True)
        integer = int(byt.hex(), 16)
    return bin(integer)[2:]

def int_to_bin_fill(integer, length):
    res = int_to_bin(integer)
    return "0"*(length-len(res)) + res 

def get_register(args, start_arg, num_args):
    return [ int(arg.replace("r", "")) for arg in args[start_arg:start_arg+num_args] ] # Removes the 'r' from the register, and converts it to int

def set_instruction_registers(instruction, registers, start):
    dest = start 
    for register in registers:
        instruction[dest:dest+REGISTER_BITS] = int_to_bin_fill(register, REGISTER_BITS)
        dest+=REGISTER_BITS


def get_immediate(immediate_str):
    return eval(immediate_str)


def fetch_registers(num_registers, dest_start_index=8, args_idx=1):
    def anon(self, assembler, instruction, args):
        registers = register.parse_registers(assembler, args, args_idx, num_registers)
        set_instruction_registers(instruction, registers, dest_start_index)
        return instruction
    return anon


def fetch_immediate(arg_idx, length=16, ir_idx=16):
    def anon(self, assembler, instruction, args):
        immediate_str = args[arg_idx]
        val = get_immediate(immediate_str)
        instruction[ir_idx:ir_idx+length] = int_to_bin_fill(val, length) 
        return instruction
    return anon

def fetch_size(dest=6):
    def anon(self, assembler, instruction, args):
        size = 4 
        if args[-1].find("[") != -1:
            size = eval(args[-1].replace("[", "").replace("]", ""))
        instruction[dest:dest+2] = int_to_bin_fill(size-1, 2)
        return instruction
    return anon

def chain(*functions):
    def anon(self, assembler, instruction, args):
        for function in functions:
            instruction = function(self, assembler, instruction, args)
        return instruction
    return anon

class Instruction:
    def __init__(self, name, opcode, handler):
        self.opcode = opcode 
        self.opcode_bin = int_to_bin_fill(opcode, OPCODE_LENGTH)
        #print("OPCODE CONTRL: ", self.opcode_bin, name)
        self.name = name
        self.handler = handler
        instructions[name] = self 
    
    def handle(self, assembler, line):
        global DEBUG

        line = line.replace(",", " ") 
        args = line.split()

        DEBUG = assembler.opt.debug and args[0] == assembler.opt.debug_spec
        instruction = ["0"]*32 
        instruction[:OPCODE_LENGTH] = self.opcode_bin 
        instruction[OPCODE_LENGTH:OPCODE_LENGTH + 2] = "11" # Default is 32 bits
        res = self.handler(self, assembler, instruction, args)
        return "".join(res)




""" Handlers for all the instructions. 
    `instruction` is the 32-bit instruction (array of strings, one or zero),
    that needs to be written to and returned. It begins with opcode, encoded
    into binary, and the rest of the bits are zeros.
"""

def load(self, assembler, instruction, args):
    """ load r1, r2, imm : r1 = Mem(r2+imm) """ 
    registers = register.parse_registers(assembler, args, 1, 2)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    immediate = get_immediate(args[3])
    instruction[16:] = int_to_bin_fill(immediate, 16)
    return instruction


def store(self, assembler, instruction, args):
    """ store r1, r2 : Mem(r2) = r1 """ 
    registers = register.parse_registers(assembler, args, 1, 2)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction

def movlo(self, assembler, instruction, args):
    """ `movlo r1, 1336` => r1[15:0] = 1336  """ 
    registers = register.parse_registers(assembler, args, 1, 1)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    immediate = get_immediate(args[2])
    instruction[16:] = int_to_bin_fill(immediate, 16)
    return instruction
    

def movhi(self, assembler, instruction, args):
    """ `movhi r1, 1336` => r1[31:15] = 1336  """ 
    return movlo(self, assembler, instruction, args)


def add(self, assembler, instruction, args):
    registers = register.parse_registers(assembler, args, 1, 3)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction


def addi(self, assembler, instruction, args):
    registers = register.parse_registers(assembler, args, 1, 2)
    #print(registers)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    immediate = get_immediate(args[-1])
    immediate = int_to_bin_fill(immediate, 16)
    instruction[16:] = immediate
    return instruction

def mul(self, assembler, instruction, args):
    registers = register.parse_registers(assembler, args, 1, 3)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction


def jmp(self, assembler, instruction, args):
    jmp_label = args[1]
    if jmp_label not in assembler.labels:
        raise KeyError("Such a label does not exist for jump/branch: {}".format(jmp_label))
    jmp_offset = assembler.labels[jmp_label] - assembler.idx
    if assembler.opt.debug_spec == "jmp":     
        print("JMP to ", args[1], "offset:", jmp_offset)

    jmp_offset = int_to_bin_fill(jmp_offset, 16)
    if assembler.opt.debug_spec == "jmp":   
        print("JMP binary OFFSET:", jmp_offset)
    instruction[16:] = jmp_offset
    return instruction


def push(self, assembler, instruction, args):
    """ `push r1` => Mem(SP) = r1, SP++  """
    assembler.sp_offset += 1 
    registers = register.parse_registers(assembler, args, 1, 1)
    set_instruction_registers(instruction, registers, OPCODE_LENGTH)
    return instruction
    
nop = lambda self, assembler, instruction, args: "0"*32
"""
Instruction("load", 0x11, load)
Instruction("store", 0x12, store)
Instruction("mov", 0x4, nop)
Instruction("movlo", 0x5, movlo)
Instruction("ldi", 0x5, movlo)
Instruction("movhi", 0x6, movhi)
Instruction("addi", 0x31, addi)
Instruction("subi", 0x36, addi)
Instruction("add", 0x32, add)
Instruction("mul", 0x38, mul)
Instruction("cmp", 0x33, nop)
Instruction("cmpi", 0x34, nop)
Instruction("call", 0x07, jmp)
Instruction("ret", 0x07, nop) # TODO
Instruction("jmp", 0x01, jmp)
Instruction("brge", 0x02, jmp)
Instruction("brg", 0x03, jmp)
Instruction("breq", 0x04, jmp)
Instruction("push", 0x01, push)
Instruction("pop", 0x01, push) #TODO
Instruction("and", 0x10, nop)
"""


# IMPORTS 

import assembler.instructions.alu_instructions
import assembler.instructions.mem_instructions
import assembler.instructions.branch_instructions

if __name__ == "__main__":

    import sys 
    res = get_immediate(sys.argv[1])
    print(res)