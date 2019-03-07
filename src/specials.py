from Variable import Variable

specials = dict()

def spec(fn):
    name = fn.__name__
    specials[name] = fn 


@spec
def var (assembler, line):
    var = line.split()[1].strip()
    assembler.variables[var] = Variable(assembler)


@spec 
def const (assembler, line):
    name = line.split()[1].strip()
    val = line.split()[2].strip()
    assembler.constants[name] = val
    if assembler.opt.debug:
        print("CONST INIT: ", name, val)
