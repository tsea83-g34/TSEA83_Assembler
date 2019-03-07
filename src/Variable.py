import time

class Variable:
    count = 0
    def __init__(self, assembler):
        self.assembler = assembler
        self.var_idx = Variable.count
        self.reset_register()
        assembler.handle_instruction("push r0")
        Variable.count += 1 

    def init_register(self, idx: int ):
        #print("INIT REGISTER:", idx)
        self.register_idx = idx 
        self.register_start_ts = time.clock() # TODO
        self.register_uses = 0

    def get_sp_offset(self, assembler):
        print("FIRST", self.var_idx)
        return -(self.var_idx) - assembler.sp_offset# maybe +1
    
    def get_register_prio(self):
        return 1 

    def reset_register(self):
        self.register_idx = -1 
        self.register_start_ts = -1 
        self.register_uses = -1

    def insert_load(self, assembler):
        assembler.handle_instruction("load r{}, SP, {}".format(self.register_idx+1, self.get_sp_offset(assembler)))

    def insert_save(self, assembler): 
        # idx here is the `r{idx-1}`, i.e. index-0 based
        assembler.handle_instruction("store r{}, SP, {}".format(self.register_idx + 1, self.get_sp_offset(assembler)))

    def register_kill(self):
        self.insert_save(self.assembler)
        self.reset_register()