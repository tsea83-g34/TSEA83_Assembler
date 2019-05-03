
ADDRESS_REGISTER = "r13"
IDX_PLACEHOLDER = "$$IDX$$"
PLACEHOLDER_OFFSET = 3 # Relative offset it should jump to on `ret`


def subroutine_lap(assembler):
    lines = []
    for line in assembler.lines:
        if line.find("call") != -1:
            lines += insert_call(assembler, line)
        elif line.find("ret") != -1:
            lines += insert_ret(assembler, line)
        else:
            lines.append(line)
    assembler.lines = lines

def insert_subroutine_indexes(assembler):
    """ Has to be done after handle_labels, because some lines are
    removed there. """
    assembler.lines = insert_indexes(assembler.lines)


def insert_call(assembler, line):
    lines = []
    lines.append("movlo {} {}".format(ADDRESS_REGISTER, IDX_PLACEHOLDER))
    lines.append("push {}".format(ADDRESS_REGISTER))
    lines.append(line.replace("call", "jmp"))
    return lines

def insert_ret(assembler, line):
    lines = []
    lines.append("pop {}".format(ADDRESS_REGISTER))
    lines.append("jmpreg {}".format(ADDRESS_REGISTER)) # Stupid work around, have to fix jmpreg (now it goes to jmp)
    return lines


def insert_indexes(lines):
    new_lines = []
    for idx, line in enumerate(lines):
        absolute_idx = str(idx + PLACEHOLDER_OFFSET)
        new_lines.append(line.replace(IDX_PLACEHOLDER, absolute_idx))
    return new_lines