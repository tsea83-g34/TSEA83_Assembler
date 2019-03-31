from collections import namedtuple
functions = dict()

class Function(namedtuple("Function", "name, args")):
    pass

def register_functions(assembler):
    lines = []
    is_func = False 
    cur_func = None 
    for line in assembler.lines:
        line = line.strip()
        line.replace("(", " (")
        if is_func: 
            if line.find("}") != -1:
                is_func = False 
                cur_func = None
                continue 
            line = line.replace(",", " ")
            args = line.split()
            for i, arg in enumerate(cur_func.args):
                if arg in args:
                    line = line.replace(arg, "r{}".format(i+1))
            if line.find("return") != -1:
                num_args = len(cur_func.args)
                ret_val = line.split()[1] # x or y or whatever
                lines.append("mov {} r15".format(ret_val))
                for i in range(num_args, 0, -1):
                    lines.append("pop r{}".format(i))

                lines.append("push r15")
                line = "ret"

        if line[:2] == "fn":
            fn_name = line.split()[1]
            args_start, args_end = line.find("("),  line.find(")")
            args_str = line[args_start+1 : args_end]
            args_str = args_str.replace(" ", "")
            args = args_str.split(",")
            functions[fn_name] = None 
            line = fn_name + ':'
            is_func = True 
            cur_func = Function(fn_name, args)
            lines.append(line)
            lines += func_init_lines(args)

            continue

        lines.append(line)
    print("\n".join(lines))
    assembler.lines = lines

def func_init_lines(args):
    lines = []
    num_args = len(args)
    for i in range(1, num_args + 1):
        lines.append("push r{}".format(i))
    for i in range(1, num_args+1):
        lines.append("load r{}, r0, SP+{}".format(i, -(num_args*2 - i + 1)))
    return lines
    

def handle_functions(assembler):
    lines = []
    for line in assembler.lines:
        line = line.replace("(", " (")
        cmd = line.split()[0]
        if cmd in functions:
            line = "call {}".format(cmd)

        lines.append(line) 
    assembler.lines = lines