#!/usr/bin/env python3

import json
import os
import z3
from z3 import Solver, Int, sat
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

def load_challenge_data(filename="challenge_data.json"):
    if not os.path.exists(filename):
        raise FileNotFoundError(f"Challenge data file not found: {filename}")
    with open(filename, "r") as f:
        data = json.load(f)
    return data

def solve_multi_secret_sss():
    data = load_challenge_data()
    p = data["parameters"]["prime"]
    
    s = Solver()
    
    c1 = Int('c1')
    c2 = Int('c2')
    c3 = Int('c3')
    c4 = Int('c4')
    
    secret1 = Int('secret1')
    secret2 = Int('secret2')
    secret3 = Int('secret3')
    secret4 = Int('secret4')
    
    for coeff in [c1, c2, c3, c4]:
        s.add(coeff >= 0)
        s.add(coeff < 2**18)
    
    for secret in [secret1, secret2, secret3, secret4]:
        s.add(secret >= 0)
        s.add(secret < p)
    
    def add_constraints(secret_var, shares):
        for share in shares:
            x, y = share["x"], share["y"]
            poly_val = (secret_var + c1*x + c2*(x**2) + c3*(x**3) + c4*(x**4)) % p
            s.add(poly_val == y)
    
    add_constraints(secret1, data["secret1_shares"])
    add_constraints(secret2, data["secret2_shares"])
    add_constraints(secret3, data["secret3_shares"])
    add_constraints(secret4, data["secret4_shares"])
    
    print("Solving for coefficients and secrets...")
    
    solutions = []
    max_solutions = 10000
    count = 0
    
    while s.check() == sat and count < max_solutions:
        m = s.model()
        coeffs = [m[c1].as_long(), m[c2].as_long(), m[c3].as_long(), m[c4].as_long()]
        secrets = [m[secret1].as_long(), m[secret2].as_long(), m[secret3].as_long(), m[secret4].as_long()]
        
        solutions.append((coeffs, secrets))
        count += 1
        
        print(f"\nSolution {count}:")
        print(f"  Coefficients: {coeffs}")
        print(f"  Secrets: {secrets}")
        
        flag = try_decrypt_flag(data, secrets[0], secrets[1], count)
        if flag:
            print(f"  SUCCESS! Flag found: {flag}")
            return coeffs, secrets
        
        s.add(z3.Or(
            c1 != coeffs[0],
            c2 != coeffs[1],
            c3 != coeffs[2],
            c4 != coeffs[3],
            secret1 != secrets[0],
            secret2 != secrets[1],
            secret3 != secrets[2],
            secret4 != secrets[3],
        ))
    
    if count == 0:
        print("No solutions found!")
        return None, None
    else:
        print(f"\nFound {count} solutions but none decrypted the flag successfully.")
        return None, None

def try_decrypt_flag(data, secret1, secret2, attempt_num):
    from binascii import unhexlify
    try:
        key_material = (str(secret1) + str(secret2)).encode()
        if len(key_material) < 16:
            aes_key = key_material.ljust(16, b'\0')
        else:
            aes_key = key_material[:16]
        
        iv = unhexlify(data["iv"])
        encrypted_flag = unhexlify(data["encrypted_flag"])
        
        cipher = AES.new(aes_key, AES.MODE_CBC, iv=iv)
        decrypted = cipher.decrypt(encrypted_flag)
        flag = unpad(decrypted, 16)
        return flag.decode()
    except Exception as e:
        print(f"  Decryption attempt {attempt_num} failed: {e}")
        return None

if __name__ == "__main__":
    print("Multi-Secret SSS Z3 Solver")
    print("="*40)
    
    coeffs, secrets = solve_multi_secret_sss()
    
    if coeffs and secrets:
        print("\nRecovered Coefficients and Secrets:")
        print("Coefficients:", coeffs)
        print("Secrets:", secrets)
    else:
        print("Failed to recover valid solution.")
