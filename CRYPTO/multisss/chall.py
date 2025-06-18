#!/usr/bin/env python3

import os
import json
import hashlib
from Crypto.Util.number import getPrime
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad

class MultiSecretSSS:
    def __init__(self, threshold=5, prime_bits=64):
        self.threshold = threshold
        self.p = getPrime(prime_bits)
        self.shared_coefficients = [getPrime(18) % self.p for _ in range(threshold - 1)]
        print(f"[DEBUG] Shared coefficients: {self.shared_coefficients}")

    def share_secret(self, secret, num_shares=8):
        coeffs = [secret] + self.shared_coefficients
        shares = []
        for x in range(1, num_shares + 1):
            y = sum(coeffs[j] * pow(x, j, self.p) for j in range(len(coeffs))) % self.p
            shares.append({'x': x, 'y': y})
        return shares

    def create_challenge(self):
        with open("flag.txt", "r") as f:
            flag = f.read().strip()
        
        part_len = len(flag) // 4
        parts = [flag[i*part_len:(i+1)*part_len] for i in range(3)]
        parts.append(flag[3*part_len:])  # final part gets the remainder

        secrets = [
            int(hashlib.sha256(parts[i].encode()).hexdigest()[:16], 16) % self.p
            for i in range(4)
        ]

        shares = [self.share_secret(secret, num_shares=6) for secret in secrets]
        partial_shares = [s[:4] for s in shares]

        key_material = (str(secrets[0]) + str(secrets[1]) + str(secrets[2]) + str(secrets[3])).encode()
        if len(key_material) < 16:
            aes_key = key_material.ljust(16, b'\0')
        else:
            aes_key = key_material[:16]

        iv = os.getrandom(16)
        cipher = AES.new(aes_key, AES.MODE_CBC, iv=iv)
        encrypted_flag = cipher.encrypt(pad(flag.encode(), 16)).hex()
        iv_hex = iv.hex()

        return {
            'secret1_shares': partial_shares[0],
            'secret2_shares': partial_shares[1],
            'secret3_shares': partial_shares[2],
            'secret4_shares': partial_shares[3],
            'secrets': secrets,
            'encrypted_flag': encrypted_flag,
            'iv': iv_hex,
            'flag_parts': parts
        }

def main():
    print("Generating Multi-Secret SSS Challenge...")

    sss = MultiSecretSSS(threshold=5, prime_bits=64)
    challenge_data = sss.create_challenge()

    participant_data = {
        'description': 'Multi-Secret Sharing System',
        'parameters': {
            'threshold': sss.threshold,
            'prime': sss.p
        },
        'secret1_shares': challenge_data['secret1_shares'],
        'secret2_shares': challenge_data['secret2_shares'],
        'secret3_shares': challenge_data['secret3_shares'],
        'secret4_shares': challenge_data['secret4_shares'],
        'iv': challenge_data['iv'],
        'encrypted_flag': challenge_data['encrypted_flag']
    }

    with open('challenge_data.json', 'w') as f:
        json.dump(participant_data, f, indent=2)

    solution_data = {
        'prime': sss.p,
        'threshold': sss.threshold,
        'shared_coefficients': sss.shared_coefficients,
        'secret1': challenge_data['secrets'][0],
        'secret2': challenge_data['secrets'][1],
        'secret3': challenge_data['secrets'][2],
        'secret4': challenge_data['secrets'][3],
        'flag_plaintext': "".join(challenge_data['flag_parts']),
        'flag_parts': challenge_data['flag_parts']
    }

    with open('solution_data.json', 'w') as f:
        json.dump(solution_data, f, indent=2)

    print("Challenge generated!")
    print(f"Prime: {sss.p}")
    print(f"Threshold: {sss.threshold}")
    print(f"Encrypted Flag (hex): {challenge_data['encrypted_flag']}")
    print("Flag parts used for secrets:")
    for i, part in enumerate(challenge_data['flag_parts']):
        print(f"  Part {i+1}: {part}")

if __name__ == "__main__":
    main()
