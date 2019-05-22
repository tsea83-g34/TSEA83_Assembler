def append_with_start_stop(seq, num):
    bin_str = bin(num)[2:]
    bin_str = "0" * (8-len(bin_str)) + bin_str
    seq.append("0" + bin_str + "1")

def get_memory_length_list(memory, line_size):
    res = []
    num_pm_bytes = len(memory)*4
    num_pm_str = str(num_pm_bytes);
    for num in num_pm_str:
        append_with_start_stop(res, int(num))
    append_with_start_stop(res, 20);
    return res


def get_chunk_val(hexa_chunk):
    val = int(hexa_chunk, 16)
    chunk_bin = bin(val)[2:]
    chunk_bin = chunk_bin[::-1] # LSB first, reverse
    chunk_val = int(chunk_bin, 2)
    return chunk_val

def get_line_bytes(memory, line_size):
    res = []
    for line in memory:
        hexa = hex(int(line,2))
        hexa_str = str(hexa)[2:]
        hexa_str = "0"*(8-len(hexa_str)) + hexa_str
        for i in range(line_size):
            chunk = hexa_str[i*2: i*2 + 2]
            chunk_val = get_chunk_val(chunk)
            append_with_start_stop(res, chunk_val)
    return res

def create_hex_dump(pm, dm):
    bytes_res = []
    bytes_res += get_memory_length_list(pm, 4)
    bytes_res += get_line_bytes(pm, 4)
    bytes_res += get_memory_length_list(dm, 1)
    bytes_res += get_line_bytes(dm, 4)
    bytes_bin = "".join(bytes_res)
    bytes_bin += "1"*((8-len(bytes_bin))%8)
    bytes_res = []
    for i in range(0, len(bytes_bin), 8):
        chunk = bytes_bin[i:i+8]
        bytes_res.append(int(chunk, 2))
    return bytes_res
