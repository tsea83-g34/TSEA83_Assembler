import argparse 
import sys 
import os 
from assembler.laps import laps


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
        pm = [seq[i] + ", -- " + self.final_lines[i] for i in range(len(seq))]
        for label, idx in self.labels.items():
            pm[idx] += " [{}]".format(label)
        return pm

    def add_data_debug(self):
        self.data_memory = [line + "," for line in self.data_memory]

    
    def assemble(self):

        for lap in laps:
            if self.opt.debug:
                print("(Pre {})".format(lap.__name__))
            lap(self) # Do a lap and modify the code
            if self.opt.debug:
                print("(Code after '{}')\n {}".format(lap.__name__ , "\n".join(self.lines)))
        
       

        if not self.opt.bin:
            self.res = self.bin_to_hex(self.res)
            self.data_memory = self.bin_to_hex(self.data_memory, 8)

        self.res = self.add_debug(self.res)
        self.add_data_debug()
        self.write_file(self.opt.out, self.res, "--$PROGRAM")
        for i in range(4):
            chunk = [self.data_memory[i] for i in range(i, len(self.data_memory), 4)]
            dm_res = self.write_file(self.opt.dm_name, chunk, "--$DATA{}".format(i+1))
    
    def write_file(self, name, values, token="--$PROGRAM"):
        with open(name) as file:
            prev_out = file.read()
        out = open(name, "w+")
        beginning = '"' if self.opt.bin else 'X"'
        output = [beginning + line.replace(",", '",') for line in values]
        output = "\n".join(output) # Trailing comma for others

        begin_idx = prev_out.find(token)
        end_idx = prev_out.find(token+"_END")
        if begin_idx != -1 and end_idx != -1:
            new_out = (
                    prev_out[:begin_idx+len(token)]
                    + "\n" 
                    + output 
                    + "\n"
                    + prev_out[end_idx:] 
            )
                
        else: 
            new_out = prev_out.replace(token, token + "\n" + output)
        out.write(new_out)
        out.close()
        return output 



def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file", type=str)
    parser.add_argument("--out", type=str, default="out/program.vhd")
    parser.add_argument("--dm_name", type=str, default="out/data.vhd")
    parser.add_argument("--bin", action="store_const", const=True, default=False)
    parser.add_argument("--debug", action="store_const", const=True, default=False)
    parser.add_argument("--debug_spec", type=str, default="")
    opt = parser.parse_args()
    #print(opt)
    path = os.getcwd()
    opt.out = path + os.sep + opt.out 
    opt.dm_name = path + os.sep + opt.dm_name
    file_name = opt.input_file
    file_path = os.getcwd() + os.sep + file_name 
    assembler = Assembler(file_path, opt)
    assembler.assemble()

if __name__ == "__main__":
    main()