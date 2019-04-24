import time

class Variable:
    """ Currently ONLY pushes on stack at declaration,
        does not handle when the variable actually gets used
        => useless
    """
    count = 0
    def __init__(self, assembler):
        self.assembler = assembler
        self.sp_offset = assembler.sp_offset - 1
        self.reset_register()
        assembler.handle_instruction("push r0")
        Variable.count += 1 

    def init_register(self, idx: int ):
        #print("INIT REGISTER:", idx)
        self.register_idx = idx 
        self.register_start_ts = time.clock() # TODO
        self.register_uses = 0

    def get_sp_offset(self, assembler):
        return assembler.sp_offset - self.sp_offset
    
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