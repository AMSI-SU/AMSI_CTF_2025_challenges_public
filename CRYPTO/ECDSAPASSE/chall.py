#!/usr/bin/env python3

import hashlib
import secrets
from ecdsa import SigningKey, SECP256k1
from ecdsa.util import sigencode_string, sigdecode_string
from ecdsa.numbertheory import inverse_mod

def sha256_hash(message):
    return hashlib.sha256(message.encode()).digest()

def message_to_int(message):
    hash_bytes = sha256_hash(message)
    return int.from_bytes(hash_bytes, 'big')

class ECDSA:
    def __init__(self):
        self.private_key = SigningKey.generate(curve=SECP256k1)
        self.public_key = self.private_key.get_verifying_key()
        
        self.curve = SECP256k1
        self.n = self.curve.order 
        
        self.a = 2
        self.b = secrets.randbelow(2**20) + 2**20
        
        self.k1 = None
        
    def sign(self, message1, message2):

        self.k1 = secrets.randbelow(self.n - 1) + 1
        
        k2 = (self.a * self.k1 + self.b) % self.n
        
        h1 = message_to_int(message1) % self.n
        h2 = message_to_int(message2) % self.n
        
        sig1 = self._sign_with_nonce(h1, self.k1)
        
        sig2 = self._sign_with_nonce(h2, k2)
        
        return sig1, sig2, h1, h2
    
    def _sign_with_nonce(self, hash_int, k):

        point = k * self.curve.generator
        r = point.x() % self.n
        
        priv_int = self.private_key.privkey.secret_multiplier
        s = (inverse_mod(k, self.n) * (hash_int + r * priv_int)) % self.n
        
        return (r, s)
    
    def get_data(self):
        return {
            'public_key': self.public_key.to_string().hex(),
            'curve_order': hex(self.n),
            'params': {'a': self.a}
        }

def challenge():
    ecdsa = ECDSA()
    
    message1 = "Il n’y a que deux façons de dire la vérité complète – de manière anonyme et posthume."
    message2 = "Peu importe que vous soyez intelligent si vous ne vous prenez pas le temps de réfléchir."
    
    print(f"Message 1: {message1}")
    print(f"Message 2: {message2}")
    print()
    
    sig1, sig2, h1, h2 = ecdsa.sign(message1, message2)
    
    print(f"Signature 1: (r1={hex(sig1[0])}, s1={hex(sig1[1])})")
    print(f"Signature 2: (r2={hex(sig2[0])}, s2={hex(sig2[1])})")
    print(f"Hash 1: {hex(h1)}")
    print(f"Hash 2: {hex(h2)}")
    print()
    
    data = ecdsa.get_data()
    print(f"Clé publique: {data['public_key']}")
    print(f"Ordre de la courbe: {data['curve_order']}")
    print(f"Paramètres : a={data['params']['a']}")
    
    print()
    
    return {
        'signatures': [sig1, sig2],
        'hashes': [h1, h2],
        'data': data
    }

if __name__ == "__main__":
    challenge_data = challenge()