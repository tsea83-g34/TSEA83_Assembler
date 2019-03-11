import argparse 
import sys 
import os 
from instructions import instructions 
from macro import Macro
from specials import specials


#TODO: Remove unnecessary idx argument, it exists in the assembler

class Assembler():
    def __init__(self, file_path, opt):
        self.file_path = file_path
        self.file = open(file_path)
        self.labels = dict()
        self.res = []

        self.idx = 0
        self.line_idx = 0 
        self.lines = []
        self.sp_offset = 0
        
        self.macros = dict()
        self.is_macro = False 
        self.cur_macro = None
        self.bracket_stack = []

        ## VARIABLES - @var are reserved variables
        self.variables = {
            "@id":4163 #random start number
        }
        self.constants = dict()

        self.opt = opt  


    def add_instruction(self, instruction, line=""):
        if self.opt.bin:
            if self.opt.debug:
                self.res.append(line+": " + instruction)
            else:
                self.res.append(instruction)
        else:
            hexa = hex(int(instruction, 2))
            hexa = str(hexa)[2:]
            hexa = "0"*(8-len(hexa)) + hexa
            if self.opt.debug:
                self.res.append(line+": " + hexa)
            else:
                self.res.append(hexa)

    
    def assemble(self, out_file, only_preprocess=True):

        self.idx = 0
        if only_preprocess:
            self.lines = self.file.readlines()
        for self.line_idx, line in enumerate(self.lines[:]):
            line = line.strip()
            if len(line) == 0: # Just a blank line
                continue
            if self.is_comment(line):
                continue
            elif self.is_macro:
                Macro.preprocess_macro(self, line)
                continue
            
            line = self.preprocess(line)
            if len(line) > 0: # not only a label => not an empty string
                if not only_preprocess:
                    self.handle_instruction(line)
                    self.idx -= 1
                self.idx += 1

        self.file.close()

        if only_preprocess:
            return self.assemble(out_file, only_preprocess=False)

        print("RESULT:")
        out = open(out_file, "w+")
        output = ['"'+line+'"' for line in self.res]
        output = ",\n".join(output)
        print(output)
        out.write(output)
        out.close()


    def is_comment(self, line):
        if line[0] == "#" or line[0:2] == "//": # Does not handle multiline comments yet
            return True 
        return False 


    def handle_instruction(self, line):

        instruction = line.split()[0] 
        if instruction in instructions:
            asm = instructions[instruction].handle(self, line)
            self.add_instruction(asm, line)
            self.idx += 1
        elif instruction in specials:
            specials[instruction](self, line)
        elif instruction in self.macros: # It is a macro
            self.macros[instruction].handle_macro(self, line)

        else:
            raise KeyError("No such instruction: {}".format(instruction))

    def preprocess(self, line):
        if line.find("@id") != -1:
            while line.find("@id") != -1:
                i = line.find("@id")
                if line[i:i+4] == "@id+" or line[i:i+4] == "@id-": 
                    op = line[i+3]
                    self.variables["@id"] += 1 if op == '+' else -1
                    line = line.replace("@id"+op, str(self.variables["@id"]))
                else:
                    line = line.replace("@id", str(self.variables["@id"]))
            self.lines[self.line_idx] = line
            
        if len(line.split(":")) > 1:
            return self.handle_labels(line)
        elif len(line.split("%macro")) > 1:
            return Macro.create_macro(self, line)
        else:
            return line 


    def handle_labels(self, line):
        args = line.split(":")
        if len(args) == 1:
            return line # A regular assembly instruction; no line
        elif len(args) == 2:
            label = args[0]
            self.labels[label] = self.idx
            return args[1]
        else:
            raise ValueError("Syntax error: Too many colons on one line")



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file", type=str)
    parser.add_argument("--out", type=str, default="a.out")
    parser.add_argument("--bin", action="store_const", const=True, default=False)
    parser.add_argument("--debug", action="store_const", const=True, default=False)
    parser.add_argument("--debug_spec", type=str, default="")
    opt = parser.parse_args()
    print(opt)
    path = os.getcwd()
    file_name = opt.input_file
    file_path = os.getcwd() + os.sep + file_name 
    assembler = Assembler(file_path, opt)
    assembler.assemble(path + os.sep + opt.out)