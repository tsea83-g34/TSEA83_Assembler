from assembler.macro import Macro
from assembler.instructions.instructions import instructions 

ZERO_REG = "r14"
SP = "r15"

## EXPANDING
def remove_comments_and_whitespace(assembler):
    idx = 0
    is_multiline = False # If currently a multiline comment: `/* \n*$i *\` 
    for line in assembler.lines[:]:
        line = line.strip()
        if is_multiline:
            if line.find("*/") != -1:
                is_multiline = False
            continue 
        if line[:2] == "/*":
            if line[2:].find("*/") != -1:
                continue 
            is_multiline = True
            continue 

        if  line.find("#") != -1:
            line = line[:line.find("#")]
        elif line.find("//") != -1:
            line = line[:line.find("//")]
        elif line.find(";") != -1:
            line = line[:line.find(";")]
        if len(line) == 0:
            continue
        assembler.lines[idx] = line 
        idx += 1
    assembler.lines = assembler.lines[:idx]
    


def register_macros(assembler):
    cur_macro = None 
    is_macro = False 
    lines = []
    for line in assembler.lines[:]:
        if (not is_macro) and (line.find("%macro") == -1): 
            # This is not a macro def => a real assembly line => save it for later
            lines.append(line)
            continue 
        elif is_macro:
            args = line.split()
            if args[0] == '%' + "end":
                is_macro = False 
            else:
                cur_macro.lines.append(line)
        else:
            is_macro = True
            args = line.split()
            name = args[1]
            num_args = int(args[2])
            cur_macro = Macro(name, num_args)
            assembler.macros[name] = cur_macro 
    assembler.lines = lines

def handle_macros(assembler):
    lines = []
    for line in assembler.lines[:]:
        instruction = line.split()[0]
        if instruction not in assembler.macros:
            lines.append(line)
            continue 
        macro = assembler.macros[instruction]
        args = line.split()[1:]
        args = [arg.strip().replace(",", "") for arg in args]   # inc r1
        if len(args) != macro.num_args:
            raise ValueError("Not enough arguments for macro '{}'".format(macro.name))
        for line in macro.lines[:]:
            for i in range(macro.num_args):
                line = line.replace("${}".format(i), args[i])
            lines.append(line)
    assembler.lines = lines 
    


def register_constants(assembler):
    lines = []
    for line in assembler.lines[:]:
        args = line.split()
        if args[0] == "const":
            name = args[1]
            val = args[2] # already stripped ;)
            assembler.constants[name] = val 
            continue 
        lines.append(line)
    assembler.lines = lines 


## END EXPANDING



def handle_constants(assembler):
    lines = []
    for line in assembler.lines[:]:
        args = [arg.replace(',', '') for arg in line.split()] # remove commas
        res = [args[0]] 
        for arg in args[1:]:
            if arg in assembler.constants:
                res.append(assembler.constants[arg]) # replace it with the constant value 
            else:
                res.append(arg)
            # Confusion, modifies 'commas' 
        lines.append(" ".join([str(arg) for arg in res])) # Make it string in case const was number
    assembler.lines = lines
### Maybe @variables, like @anon ....
###


def handle_labels(assembler):
    idx = 0
    lines = [] 
    for line in assembler.lines: # don't need copying
        args = [arg.strip() for arg in line.split(":")] 
        if line.find(':') != -1:
            label, rest = line.split(':')
            if len(rest) == 0:
                line = rest
                assembler.labels[label] = idx
                assembler.constants[label] = idx
                continue # Don't need to increment, like putting label on same line
            assembler.labels[label] = idx 
        lines.append(line)
        idx += 1 
    assembler.lines = lines 


def handle_sizes(assembler):
    lines = []
    has_size = lambda arg: arg.find("[") != -1
    for line in assembler.lines:
        line = line.replace("[", " [").replace("]", "] ").replace(",", " ")
        args = line.split()
        new_args = []
        size_args = []
        for arg in args:
            if has_size(arg):
                size_args.append(arg)
            else:
                new_args.append(arg)
        line = " ".join(new_args + size_args)

        lines.append(line) 
        # This works if size is last argument, I think, but not first 
    assembler.lines = lines 


def handle_instructions(assembler):
    assembler.idx = 0
    for line in assembler.lines[:]:
        instruction = line.split()[0]
        asm = instructions[instruction].handle(assembler, line)
        assembler.add_instruction(asm, line)
        assembler.idx += 1 # Needed by `assembler.add_instruction` in next pass


def replace_pop_push(assembler):
    """ pop r15 [4]"""
    lines = [] 
    for line in assembler.lines:
        args = line.split() 
        if args[0] == "pop" :
            size = 1 if len(args) < 3 else eval(args[2].replace("[", "").replace("]", ""))
            lines.append("load {}, {}, 0 {}".format(
                args[1],
                SP,
                "" if len(args) < 3 else args[2], # Size (optional)
            ))
            lines.append("addi {}, {}, {}".format(SP, SP, size))
        elif args[0] == "push" :
            size = 1 if len(args) < 3 else eval(args[2].replace("[", "").replace("]", ""))
            lines.append("addi {}, {}, {}".format(SP, SP, -size))
            lines.append("store {}, {}, 0 {}".format(
                SP,
                args[1],
                "" if len(args) < 3 else args[2], # Size (optional)
            ))
        else:
            lines.append(line)
    assembler.lines = lines

def replace_halts(assembler):
    lines = []
    for line in assembler.lines:
        args = line.split()
        if args[0] == "halt":
            lines.append("nop")
            lines.append("rjmp -1")
        else:
            lines.append(line)
    assembler.lines = lines


from assembler.data_lap import store_data_memory
from assembler.fn_lap import register_functions, handle_functions 
from assembler.subroutine_lap import subroutine_lap, insert_subroutine_indexes

laps = [
    remove_comments_and_whitespace,
    register_macros,
    handle_macros,
    handle_macros, # To handle macro calls in macro
    register_constants,
    store_data_memory,
    replace_halts,
    handle_constants,
    handle_sizes, # Pre pop push
    replace_pop_push,
    subroutine_lap, # Has to be before handle_labels
    replace_pop_push, # Again to handle subroutine push/pop
    handle_labels,
    handle_constants, # To insert labels used as constants
    insert_subroutine_indexes,
    handle_sizes, # To clean up inserted instructions TODO: Maybe unnecessary
    handle_instructions,
]


def at():
    pass 
    # This is shitty
    """
    if line.find("@id") != -1:
    while line.find("@id") != -1:
        i = line.find("@id")
        if line[i:i+4] == "@id+" or line[i:i+4] == "@id-": 
            op = line[i+3]
            self.variables["@id"] += 1 if op == '+' else -1
            line = line.replace("@id"+op, str(self.variables["@id"]))
        else:
            line = line.replace("@id", str(self.variables["@id"]))
    self.lines[self.line_idx] = line
            
    """