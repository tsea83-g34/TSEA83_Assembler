import time
from main import Assembler

class Variable:
    def __init__(self, var_idx: int):
        self.var_idx = var_idx
        self.reset_register()

    def init_register(self, idx: int ):
        self.register_idx = idx 
        self.register_start_ts = time.clock() # TODO
        self.register_uses = 0

    def get_sp_offset(self, assembler):
        return assembler.sp_offset - self.var_idx # maybe +1
    
    def get_register_prio(self):
        return 1 

    def reset_register(self):
        self.register_idx = -1 
        self.register_start_ts = -1 
        self.register_uses = -1

    def insert_load(self, assembler: Assembler):
        assembler.handle_instruction("load r{}, SP, {}".format(self.register_idx+1, self.get_sp_offset(assembler)))

    def insert_save(self, assembler: Assembler): 
        # idx here is the `r{idx-1}`, i.e. index-0 based
        assembler.handle_instruction("store r{}, SP, {}".format(self.register_idx + 1, self.get_sp_offset(assembler)))