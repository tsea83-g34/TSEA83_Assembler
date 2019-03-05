import argparse 
import sys 
import os 
from instructions import instructions 

class Assembler():
    def __init__(self, file_path, opt):
        self.file_path = file_path
        self.file = open(file_path)
        self.labels = dict()
        self.res = []
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

    
    def assemble(self, out_file, only_setting_labels=True):
        
        idx = 0
        for line in self.file.readlines():
            line = line.strip()
            if len(line) == 0: # Just a blank line
                continue
            if self.is_comment(line):
                continue
            
            line = self.handle_labels(line, idx)
            if len(line) > 0: # not only a label
                if not only_setting_labels:
                    self.handle_instruction(line, idx)
                idx += 1

        self.file.close()

        if only_setting_labels:
            self.file = open(self.file_path)
            return self.assemble(out_file, False)

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
        else:
            pass 
            #print("not an instruction")

    def handle_labels(self, line, idx):
        args = line.split(":")
        if len(args) == 1:
            return line 
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