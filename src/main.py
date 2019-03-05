import argparse 
import sys 
import os 
from instructions import instructions 
from macro import Macro


class Assembler():
    def __init__(self, file_path, opt):
        self.file_path = file_path
        self.file = open(file_path)
        self.labels = dict()
        self.res = []
        
        self.macros = dict()
        self.is_macro = False 
        self.cur_macro = None

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
        
        idx = 0
        self.idx = 0
        
        for line in self.file.readlines():
            idx = self.idx
            line = line.strip()
            if len(line) == 0: # Just a blank line
                continue
            if self.is_comment(line):
                continue
            elif self.is_macro:
                self.continue_macro(line, idx)
                continue
            
            line = self.preprocess(line, idx)
            if len(line) > 0: # not only a label => not an empty string
                if not only_preprocess:
                    self.handle_instruction(line, idx)
                idx += 1

        self.file.close()

        if only_preprocess:
            self.file = open(self.file_path)
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


    def handle_instruction(self, line, idx):
        instruction = line.split()[0] 
        if instruction in instructions:
            asm = instructions[instruction].handle(self, line, idx)
            self.add_instruction(asm, line)
        elif instruction in self.macros: # It is a macro
            args = line.split()[1:]
            args = [arg.strip().replace(",", "") for arg in args]
            macro = self.macros[instruction]
            if len(args) != macro.num_args:
                raise ValueError("Not enough arguments for macro '{}'".format(macro.name))
            
            for line in macro.lines[:]:
                print("Macro_line {}".format(line))
                for i in range(macro.num_args):
                    line = line.replace("${}".format(i), args[i])
                print("Macro_line post {}".format(line))
                instruction = line.strip()
                self.handle_instruction(line, idx)
                idx += 1

            #raise ValueError("We have not yet implemeneted macros")
            # Loop through every item in macro.lines
            # Pass it as an instruction AFTER replacing the arguments with real values


        else:
            raise KeyError("No such instruction: {}".format(instruction))

    def preprocess(self, line, idx):
        if len(line.split(":")) > 1:
            return self.handle_labels(line, idx)
        elif len(line.split("%macro")) > 1:
            return self.handle_macro(line, idx)
        else:
            return line 

    def continue_macro(self, line, index):
        args = line.split()
        if args[0] == '%'+"end":
            self.is_macro = False 
            return 
        self.cur_macro.lines.append(line)

    def handle_macro(self, line, idx):
        args = line.split("%macro")[1].strip()
        args = args.split()
        print("ARGS: {}".format(args))
        macro_name = args[0].strip()
        self.cur_macro = Macro(macro_name, int(args[1]))
        self.is_macro = True 
        self.macros[macro_name] = self.cur_macro
        return ""

    def handle_labels(self, line, idx):
        args = line.split(":")
        if len(args) == 1:
            return line # A regular assembly instruction; no line
        elif len(args) == 2:
            label = args[0]
            self.labels[label] = idx
            return args[1]
        else:
            raise ValueError("Syntax error: Too many colons on one line")



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file", type=str)
    parser.add_argument("--out", type=str, default="a.out")
    parser.add_argument("--bin", action="store_const", const=True, default=False)
    parser.add_argument("--debug", action="store_const", const=True, default=False)
    opt = parser.parse_args()
    path = os.getcwd()
    file_name = opt.input_file
    file_path = os.getcwd() + os.sep + file_name 
    assembler = Assembler(file_path, opt)
    assembler.assemble(path + os.sep + opt.out)