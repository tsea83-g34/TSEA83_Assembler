from instructions import get_immediate, int_to_bin_fill


byte_sizes = {
    ".db": 1,
    ".dh": 2,
    ".dw": 4,
}

def char_to_bin(char):
    """ char: "'a'" """
    char.replace("'", "")
    val = ord(char)
    return int_to_bin_fill(val, 8)

class Data:
    idx = 0
    total_size = 0 # Not counting overwrites
    def __init__ (self, cmd, val, addr):
        self.cmd = cmd
        self.val = val  # pure val: ['c', "asda", 0x222]
        self.addr = addr
        self.vals = []
        if cmd in byte_sizes:
            self.val = get_immediate(self.val)
            self.init_simple_val(byte_sizes[cmd])
        elif cmd == ".dc":
            self.vals.append(char_to_bin(self.val))
        elif cmd == ".ds":
            self.init_str()

        self.size = len(self.vals)
        if addr == None: # Auto inc
            self.addr = Data.idx
            Data.idx += self.size 
        self.total_size += self.size 

    def init_simple_val(self, size):
        bin_str = int_to_bin_fill(self.val, 8*size)
        for i in range(0, size*8, 8):
            byte = bin_str[i:i+8]
            self.vals.append(byte)
        self.vals.reverse()
    
    def init_str(self):
        self.val = self.val.replace("\"", "") # "asda" -> asda
        print(self.val)
        for char in self.val:
            self.vals.append(char_to_bin(char))
        self.vals.append("0"*8) # append NULL

    def __lt__ (self, other):
        return self.addr < other.addr

def get_max_addr (data_list):
    max_addr = -1 
    for data in data_list:
        max_addr = max(max_addr, data.addr+data.size)
    return max_addr

def store_data_memory(assembler):
    
    abs_addresses = []
    inc_addresses = []
    # Even if should overwrite, better to seperate 
    lines = [] # Remove all .db stuff
    for line in assembler.lines:
        if line.find(".d") != -1:
            line.replace(":", ": ") # Easier 
            args = line.split() # Also strips it 
            cmd = args[0]
            addr = None # Just auto inc
            if line.find(":") != -1: # Absolute address `.db 100: 0xff`
                val = args[2]
                addr = get_immediate(args[1].replace(":", ""))
                abs_addresses.append(Data(cmd, val, addr))
            else:
                val = args[1]
                inc_addresses.append(Data(cmd, val, addr))
        else:
            lines.append(line)
    assembler.lines = lines


    data_memory_size = Data.total_size
    if len(abs_addresses) > 0:
        data_memory_size = max(Data.total_size, get_max_addr(abs_addresses))
    data_memory = ["0"*8] * data_memory_size
    
    # Switch these around if absolute addresses should overwrite the incremented
    for data in abs_addresses:
        data_memory[data.addr: data.addr+data.size] = data.vals 
    
    idx = 0
    for data in inc_addresses:
        data_memory[idx: idx+data.size] = data.vals 
        idx += data.size 
    assembler.data_memory = data_memory
    
    
