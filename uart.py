new_vals = [0b01110101]
file = open("uart.bin", "wb")
file.write(bytes(new_vals))
file.close()

file = open("uart.bin", "rb")
res = file.read()
hexa = res.hex()
val = int(hexa, 16)
bin_val = bin(val)
print(len(bin_val))

