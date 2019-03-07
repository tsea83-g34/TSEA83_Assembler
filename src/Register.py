from Variable import Variable 
from main import Assembler


TEST_FILL_SPOT = 10

class Register:
    def __init__(self, size: int ):
        self.registers = [None]*size    # List of `Variable`
        self.size = size 
        self.occupied = 0

    def kill(self, idx: int):
        self.registers[idx] = None 
        self.occupied -= 1 
    
    def parse_registers(self, assembler: Assembler, args, start, num_args):
        registers = args[start: start+num_args]
        for register in registers:
            if register in assembler.variables:
                var = assembler.variables[register]
                if var.register_idx == -1:
                    self.find_spot(var)
                    var.insert_load(assembler)

    def find_spot(self, new_variable: Variable):
        def fill_spot(idx: int):
            new_variable
            self.registers[idx] = new_variable 

        min_prio = float('inf')
        for idx, variable in enumerate(self.registers):
            if variable == None:
                fill_spot(idx)
                break 
        else:
            self.registers[TEST_FILL_SPOT].insert_save()  
            fill_spot(TEST_FILL_SPOT) # TODO: Fix this to remove the one with lowest priority

register = Register(16)