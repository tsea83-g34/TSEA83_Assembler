import base64 
file = open("uart.bin", "rb")
x = file.read()
res = base64.b64encode(x)
print("encoded:", res)
print("decoded:", base64.b64decode(res).hex())