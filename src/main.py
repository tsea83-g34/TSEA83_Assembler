import argparse 
import sys 
import os 
from laps import laps


#TODO: Remove unnecessary idx argument, it exists in the assembler

class Assembler():
    def __init__(self, file_path, opt):
        self.file_path = file_path
        
        # Bad OOP
        self.file = open(file_path)
        self.lines = self.file.readlines()
        self.file.close() 

        self.labels = dict()
        self.res = []

        self.idx = 0
        self.line_idx = 0 
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

        for lap in laps:
            print(self.lines)
            lap(self) # Do a lap and modify the code
        

        print("RESULT:")
        out = open(out_file, "w+")
        output = ['"'+line+'"' for line in self.res]
        output = ",\n".join(output)
        print(output)
        out.write(output)
        out.close()




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