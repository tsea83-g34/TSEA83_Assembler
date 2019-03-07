
TEST_FILL_SPOT = 10

class Register:
    def __init__(self, size: int ):
        self.registers = [None]*size    # List of `Variable`
        self.size = size 
        self.occupied = 0
        self.assembler = None 

    def kill(self, idx: int):
        self.registers[idx] = None 
        self.occupied -= 1 
    
    def parse_registers(self, assembler, args, start, num_args):
        self.assembler = assembler
        registers = args[start: start+num_args]
        if assembler.opt.debug:
            print("PARSE REGISTERS: ", registers)
        for i in range(len(registers)):
            register = registers[i]
            if register in assembler.variables:
                var = assembler.variables[register]
                if var.register_idx == -1:
                    self.find_spot(var)
                    var.insert_load(assembler)
                register = "r{}".format(var.register_idx + 1)
            elif register in assembler.constants:
                register = assembler.constants[register] # SP = r20 ish
            registers[i] = int(register.replace('r', ''))
        if assembler.opt.debug:
            print("POST PARSE REGISTERS: ", registers)
        return registers

    def find_spot(self, new_variable):
        def fill_spot(idx: int):
            new_variable.init_register(idx)
            new_variable.insert_load(self.assembler)
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