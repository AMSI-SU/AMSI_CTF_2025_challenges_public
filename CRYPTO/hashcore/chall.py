#!/usr/bin/python3
import base64
import struct
PREFIX = b"AMSI_en_collision"

def right_rotate(x, c):
    return ((x << c) | (x >> (32 - c))) & 0xFFFFFFFF

def totally_custom_hash(message):
    lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    g = [75, 99, 99, 115, 106, 44, 120, 102, 116, 121, 124, 54, 99, 99, 125, 121, 119, 41, 125, 125, 113, 41, 111, 121, 96, 125, 34, 52, 102, 102, 96, 103, 97, 104, 100, 114, 112, 126, 98, 55, 101, 111, 121, 103, 109, 120, 115, 126, 104, 109, 47, 112, 106, 99, 123, 57, 38, 121, 106, 113, 38, 110, 96, 53]
    s = [ord(lorem[i]) ^ g[i] for i in range(64)]

    V = ['MzYxNDA5MDM2MA==', 'MzkwNTQwMjcxMA==', 'NjA2MTA1ODE5', 'MzI1MDQ0MTk2Ng==', 'NDExODU0ODM5OQ==', 'MTIwMDA4MDQyNg==', 'MjgyMTczNTk1NQ==', 'NDI0OTI2MTMxMw==', 'MTc3MDAzNTQxNg==', 'MjMzNjU1Mjg3OQ==', 'NDI5NDkyNTIzMw==', 'MjMwNDU2MzEzNA==', 'MTgwNDYwMzY4Mg==', 'NDI1NDYyNjE5NQ==', 'Mjc5Mjk2NTAwNg==', 'MTIzNjUzNTMyOQ==', 'NDEyOTE3MDc4Ng==', 'MzIyNTQ2NTY2NA==', 'NjQzNzE3NzEz', 'MzkyMTA2OTk5NA==', 'MzU5MzQwODYwNQ==', 'MzgwMTYwODM=', 'MzYzNDQ4ODk2MQ==', 'Mzg4OTQyOTQ0OA==', 'NTY4NDQ2NDM4', 'MzI3NTE2MzYwNg==', 'NDEwNzYwMzMzNQ==', 'MTE2MzUzMTUwMQ==', 'Mjg1MDI4NTgyOQ==', 'NDI0MzU2MzUxMg==', 'MTczNTMyODQ3Mw==', 'MjM2ODM1OTU2Mg==', 'NDI5NDU4ODczOA==', 'MjI3MjM5MjgzMw==', 'MTgzOTAzMDU2Mg==', 'NDI1OTY1Nzc0MA==', 'Mjc2Mzk3NTIzNg==', 'MTI3Mjg5MzM1Mw==', 'NDEzOTQ2OTY2NA==', 'MzIwMDIzNjY1Ng==', 'NjgxMjc5MTc0', 'MzkzNjQzMDA3NA==', 'MzU3MjQ0NTMxNw==', 'NzYwMjkxODk=', 'MzY1NDYwMjgwOQ==', 'Mzg3MzE1MTQ2MQ==', 'NTMwNzQyNTIw', 'MzI5OTYyODY0NQ==', 'NDA5NjMzNjQ1Mg==', 'MTEyNjg5MTQxNQ==', 'Mjg3ODYxMjM5MQ==', 'NDIzNzUzMzI0MQ==', 'MTcwMDQ4NTU3MQ==', 'MjM5OTk4MDY5MA==', 'NDI5MzkxNTc3Mw==', 'MjI0MDA0NDQ5Nw==', 'MTg3MzMxMzM1OQ==', 'NDI2NDM1NTU1Mg==', 'MjczNDc2ODkxNg==', 'MTMwOTE1MTY0OQ==', 'NDE0OTQ0NDIyNg==', 'MzE3NDc1NjkxNw==', 'NzE4Nzg3MjU5', 'Mzk1MTQ4MTc0NQ==']
    K = [int(base64.b64decode(i).decode()) for i in V]

    A = 0x9e1f9b4a
    B = 0x8f2d7a6b
    C = 0x1a7b3c9e
    D = 0xe37c45d0

    original_len_in_bits = (8 * len(message)) & 0xffffffffffffffff
    message += b'\x80'
    while (len(message) % 64) != 56:
        message += b'\x00'
    message += struct.pack('<Q', original_len_in_bits)

    for offset in range(0, len(message), 64):
        a, b, c, d = A, B, C, D
        chunk = message[offset:offset + 64]
        M = list(struct.unpack('<16I', chunk))

        for i in range(64):
            if 0 <= i <= 15:
                f = (b & c) | (~b & d)
                g = i
            elif 16 <= i <= 31:
                f = (d & b) | (~d & c)
                g = (5 * i + 1) % 16
            elif 32 <= i <= 47:
                f = b ^ c ^ d
                g = (3 * i + 5) % 16
            elif 48 <= i <= 63:
                f = c ^ (b | ~d)
                g = (7 * i) % 16

            f = (f + a + K[i] + M[g]) & 0xFFFFFFFF
            a, d, c, b = d, c, b, (b + right_rotate(f, s[i])) & 0xFFFFFFFF

        A = (A + a) & 0xFFFFFFFF
        B = (B + b) & 0xFFFFFFFF
        C = (C + c) & 0xFFFFFFFF
        D = (D + d) & 0xFFFFFFFF

    return ''.join(f'{i:02x}' for i in struct.pack('<4I', A, B, C, D))

def main():
    inputs = []
    for i in range(2):
        s = input(f"Enter input {i+1} : ")
        try:
            decoded = base64.b64decode(s)
        except Exception:
            print("Wrong input")
            return

        if not decoded.startswith(PREFIX):
            print("Wrong input")
            return
        inputs.append(decoded)

    if len(set(inputs)) != 2:
        print("Wrong input")
        return

    hashes = [totally_custom_hash(s) for s in inputs]

    if all(h == hashes[0] for h in hashes):
        with open("flag.txt", "r") as f:
            print(f.read().strip())
    else:
        print("Wrong input")

if __name__ == "__main__":
    main()
