from Crypto.Cipher import AES
import os
import pickle
import base64

with open("flag.txt") as f:
    message = f.read().encode()

key = os.urandom(32)
cipher = AES.new(key, AES.MODE_EAX)
ciphertext, tag = cipher.encrypt_and_digest(message)

data = {
    "key": key,
    "ciphertext": ciphertext,
    "tag": tag
}

encoded = base64.b64encode(pickle.dumps(data)).decode()
print(encoded)
