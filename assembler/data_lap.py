from assembler.instructions.instructions import  int_to_bin_fill

MAX_DM_SIZE = 64000

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
            self.val = eval(self.val)
            self.init_simple_val(byte_sizes[cmd])
        elif cmd == ".dc":
            self.vals.append(char_to_bin(self.val))
        elif cmd == ".ds":
            self.init_str()

        self.size = len(self.vals)
        if addr == None: # Auto inc
            self.addr = Data.idx
            Data.idx += self.size 
        Data.total_size += self.size 

    def init_simple_val(self, size):
        bin_str = int_to_bin_fill(self.val, 8*size)
        for i in range(0, size*8, 8):
            byte = bin_str[i:i+8]
            self.vals.append(byte)
        self.vals.reverse()
    
    def init_str(self):
        self.val = self.val.replace("\"", "") # "asda" -> asda
        for char in self.val:
            self.vals.append(char_to_bin(char))
        self.vals.append("0"*8) # append NULL

    def __lt__ (self, other):
        return self.addr < other.addr

    def __str__(self):
        return "Cmd: {}, val: {}, addr: {}, vals: {}".format(
            self.cmd, self.val, self.addr, [hex(int(val, 2)) for val in self.vals],
        )


def get_max_addr (data_list):
    max_addr = -1 
    for data in data_list:
        max_addr = max(max_addr, data.addr+data.size)
    return max_addr


def get_multiline_str(assembler, first_line, idx):
    res = first_line
    quotes_count = first_line.count('"')
    while idx < len(assembler.lines) and quotes_count < 2:
        res += "\n" + assembler.lines[idx]
        quotes_count += assembler.lines[idx].count('"')
        idx += 1 
    return res, idx

        


def store_data_memory(assembler):
    
    abs_addresses = []
    inc_addresses = []
    # Even if should overwrite, better to seperate 
    lines = [] # Remove all .db stuff
    idx = 0
    while idx < len(assembler.lines):
        line = assembler.lines[idx]
        if line.find(".d") != -1: # Unsafe and shitty
            line.replace(":", ": ") # Easier 
            args = line.split() # Also strips it
            if line.find('"') != -1: # To handle .ds
                quote_idx = line.find('"')
                args = [line[:quote_idx], line[quote_idx:]]
                args[0] = args[0].strip()
                args[1], new_idx = get_multiline_str(assembler, args[1], idx + 1)
                idx = new_idx - 1 # We always add one to idx at end of loop
            cmd = args[0]
            addr = None # Just auto inc
            if line.find(":") != -1: # Absolute address `.db 100: 0xff`
                val = args[2]
                addr = eval(args[1].replace(":", ""))
                abs_addresses.append(Data(cmd, val, addr))
            else:
                # adds .data labels as well
                val = args[1]
                
                data = Data(cmd, val, addr)
                if cmd == ".ds": # Split it up into chars
                    Data.idx -= len(data.vals) # Shitty solution for chunks
                    Data.total_size -= len(data.vals) # Shitty solution for chunks
                    data.val += "\0"
                    for char in data.val:
                        inc_addresses.append(Data(".dc", char, None)) # Adds idx earlier removed
                elif len(args) > 2: # ARRAY
                    #print("Pre array:\n" + "\n".join([str(data) for data in inc_addresses]))
                    for val in args[2:]:
                        inc_addresses.append(Data(data.cmd, val, None))
                    #print("Post array:\n" + "\n".join([str(data) for data in inc_addresses]))
                else:
                    inc_addresses.append(data)
        else:
            lines.append(line)
        idx += 1
    assembler.lines = lines
    #print([str(data) for data in inc_addresses], len(inc_addresses))

    data_memory_size = Data.total_size
    if len(abs_addresses) > 0:
        data_memory_size = max(Data.total_size, get_max_addr(abs_addresses))
    data_memory = ["0"*8] * MAX_DM_SIZE
    
    # Switch these around if absolute addresses should overwrite the incremented
    for data in abs_addresses:
        data_memory[data.addr: data.addr+data.size] = data.vals 
    
    idx = 0
    chunk_idx = 0
    for data in inc_addresses:
        if data.cmd == ".data":
            assembler.constants[data.val] = str(idx)
            continue
        if 4 - chunk_idx < data.size:
            idx += (4-chunk_idx)
            chunk_idx = 0
        data_memory[idx: idx+data.size] = data.vals 
        chunk_idx = (chunk_idx + data.size) % 4
        idx += data.size 
    last_idx = max(get_max_addr(abs_addresses), idx)
    assembler.data_memory = data_memory[:last_idx]