
class Macro:
    def __init__ (self, name, num_args):
        self.name = name 
        self.num_args = num_args 
        self.lines = []

    def handle_macro(self, assembler, line):
        args = line.split()[1:]
        args = [arg.strip().replace(",", "") for arg in args]   # inc r1
        if len(args) != self.num_args:
            raise ValueError("Not enough arguments for macro '{}'".format(self.name))
        
        instruction_lines = []
        for line in self.lines[:]:
            for i in range(self.num_args):
                line = line.replace("${}".format(i), args[i])
            line = assembler.preprocess(line)
            if len(line) == 0 or assembler.is_comment(line):
                continue 
            instruction_lines.append(line)
        
        for line in instruction_lines: 
            assembler.handle_instruction(line.strip())

        
    @staticmethod
    def create_macro(assembler, line):
        args = line.split("%macro")[1].strip()
        args = args.split()
        macro_name = args[0].strip()
        assembler.cur_macro = Macro(macro_name, int(args[1]))
        assembler.is_macro = True 
        assembler.macros[macro_name] = assembler.cur_macro
        return ""

    @staticmethod
    def preprocess_macro(assembler, line):
        args = line.split()
        if args[0] == '%'+"end":
            assembler.is_macro = False 
            return 
        assembler.cur_macro.lines.append(line)