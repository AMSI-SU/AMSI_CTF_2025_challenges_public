import random
import hashlib
from Crypto.Util.number import getPrime, inverse
from math import gcd
from flag import pwd

# Public
n = getPrime(512)
g = 2

def H(pwd):
    return int(hashlib.sha256(pwd.encode()).hexdigest(), 16) % (n - 1)

def invertible_Q(pwd):
    Q = H(pwd)
    while gcd(Q, n - 1) != 1:
        Q = (Q + 1) % (n - 1)
    return Q

def alice_send_X1(Q, a):
    print("[Client ➜ Server] X1")
    X1 = pow(g, a * Q, n)
    return X1

def bob_send_Y1_and_compute_X(Q, b, X1):
    print("[Server ➜ Client] Y1")
    Y1 = pow(g, b * Q, n)
    Qinv = inverse(Q, n - 1)
    X = pow(X1, Qinv, n) 
    return Y1, X

def alice_compute_Y(Y1, Q):
    Qinv = inverse(Q, n - 1)
    Y = pow(Y1, Qinv, n)
    return Y

def derive_key(base, exponent):
    return pow(base, exponent, n)


if __name__ == "__main__":
    print(f"n = {n}\ng = {g}\n")

    Q = invertible_Q(pwd)

    a = random.randint(2, n-2)
    b = random.randint(2, n-2)

    X1 = alice_send_X1(Q, a)

    Y1, X = bob_send_Y1_and_compute_X(Q, b, X1)

    Y = alice_compute_Y(Y1, Q)

    Key_client = derive_key(Y, a)

    Key_server = derive_key(X, b)

    print(f"X1 = {X1}")
    print(f"Y1 = {Y1}")
    print(f"Y  = {Y}")
    print(f"{'Let\'s start the session bro' if Key_client == Key_server else 'nah'}")
