
ADDRESS_REGISTER = "r13"
CALL_IDX_PLACEHOLDER = "$$CALL_IDX$$"
CALL_PLACEHOLDER_OFFSET = 4# Changed this 
RET_IDX_PLACEHOLDER = "$$RET_IDX$$"
RET_PLACEHOLDER_OFFSET = 1
NULL_REG = "r14"


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
    lines.append("addi {} {} {}".format(ADDRESS_REGISTER, NULL_REG, CALL_IDX_PLACEHOLDER))
    lines.append("push {} [2]".format(ADDRESS_REGISTER))
    lines.append(line.replace("call", "rjmp"))
    return lines

def insert_ret(assembler, line):
    lines = []
    lines.append("pop {} [2]".format(ADDRESS_REGISTER))
    lines.append("subi {} {} {}".format(ADDRESS_REGISTER, ADDRESS_REGISTER, RET_IDX_PLACEHOLDER))
    lines.append("rjmprg {}".format(ADDRESS_REGISTER)) # Stupid work around, have to fix jmpreg (now it goes to jmp)
    return lines


def insert_indexes(lines):
    new_lines = []
    for idx, line in enumerate(lines):
        call_absolute_idx = str(idx + CALL_PLACEHOLDER_OFFSET)
        ret_absolute_idx = str(idx + RET_PLACEHOLDER_OFFSET)
        line = line.replace(CALL_IDX_PLACEHOLDER, call_absolute_idx)
        line = line.replace(RET_IDX_PLACEHOLDER, ret_absolute_idx)
        new_lines.append(line)

    return new_lines