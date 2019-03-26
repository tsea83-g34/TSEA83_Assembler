import argparse 
import sys 
import os 
from laps import laps


class Assembler():
    def __init__(self, file_path, opt):
        self.file_path = file_path
        
        # Bad OOP
        self.file = open(file_path)
        self.lines = self.file.readlines()
        self.file.close() 

        self.labels = dict()
        self.res = []
        self.final_lines = []

        self.idx = 0
        self.line_idx = 0 
        self.sp_offset = 0
        
        self.macros = dict()
        self.is_macro = False 
        self.cur_macro = None
        self.bracket_stack = []

        self.data_memory = []

        ## VARIABLES - @var are reserved variables
        self.variables = {
            "@id":4163 #random start number
        }
        self.constants = dict()

        self.opt = opt  

    def add_instruction(self, instruction, line=""):
        self.final_lines.append(line)
        self.res.append(instruction) # Binary string 
    
    def bin_to_hex(self, seq, bit_size=32):
        res = []
        size = bit_size//4
        for bin_str in seq:
            hexa = hex(int(bin_str, 2))
            hexa = str(hexa)[2:]
            hexa = "0"*(size-len(hexa)) + hexa
            res.append(hexa)
        return res 
        
    def add_debug(self, seq):
        return [self.final_lines[i] + ": " + seq[i] for i in range(len(seq))]

    
    def assemble(self, out_file, only_preprocess=True):

        for lap in laps:
            lap(self) # Do a lap and modify the code
            if self.opt.debug:
                print("(Code after '{}')\n {}".format(lap.__name__ , "\n".join(self.lines)))
        
       

        if not self.opt.bin:
            self.res = self.bin_to_hex(self.res)
            self.data_memory = self.bin_to_hex(self.data_memory, 8)

        if self.opt.debug:
            self.res = self.add_debug(self.res)

        print("RESULT:\n" + self.write_file(out_file, self.res))
        pm_res = self.write_file(self.opt.pm_name, self.data_memory)
        print("DM Res:\n"+pm_res)
    
    def write_file(self, name, values):
        out = open(name, "w+")
        beginning = '"' if self.opt.bin else 'X"'
        output = [beginning + line + '"' for line in values]
        output = ",\n".join(output)
        out.write(output)
        out.close()
        return output 




if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file", type=str)
    parser.add_argument("--out", type=str, default="a.out")
    parser.add_argument("--pm_name", type=str, default="dm.out")
    parser.add_argument("--bin", action="store_const", const=True, default=False)
    parser.add_argument("--debug", action="store_const", const=True, default=False)
    parser.add_argument("--debug_spec", type=str, default="")
    opt = parser.parse_args()
    #print(opt)
    path = os.getcwd()
    file_name = opt.input_file
    file_path = os.getcwd() + os.sep + file_name 
    assembler = Assembler(file_path, opt)
    assembler.assemble(path + os.sep + opt.out)