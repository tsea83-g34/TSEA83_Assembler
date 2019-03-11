stations = []


def station(fn):
    stations.append(fn)


@station 
def remove_comments(assembler):
    idx = 0
    for line in assembler.lines[:]:
        line = line.strip()
        if  line.find("#"):
            line = line[line.find("#"):]
        if line.find("//") != -1:
            line = line[line.find("//"):]
        if len(line) == 0:
            continue 
        assembler.lines[idx] = line 
        idx += 1
    assembler.lines = assembler.lines[:idx]



