from macro import Macro

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
            line = line[:]
        if len(line) == 0:
            continue 
        assembler.lines[idx] = line 
        idx += 1
    assembler.lines = assembler.lines[:idx]


def register_macros(assembler):
    cur_macro = None 
    is_macro = True 
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
            line = assembler.preprocess(line)
            if len(line) == 0 or assembler.is_comment(line):
                continue 
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


def handle_constants(assembler):
    lines = []
    for line in assembler.lines[:]:
        args = [arg.replace(',', '') for arg in line.split()] # remove commas
        res = [] 
        for arg in args:
            if arg in assembler.constants:
                res.append(assembler.constans[arg]) # replace it with the constant value 
            else:
                res.append(arg)
            # Confusion, modifies 'commas' 
        lines.append(" ".join(res))
    assembler.lines = lines
            



## END EXPANDING


laps = [
    remove_comments_and_whitespace,
    register_macros,
    handle_macros,
]