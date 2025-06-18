from sage.all import *
import random
from key import d

def is_cube(a, p): 
    return power_mod(a, (p-1)/gcd(3, p-1), p) == 1


def is_square(x, p): 
    return Mod(x, p).is_square()


def rand_prime_congru_1mod3_and_3mod4(size):
    p = random_prime(2 << size - 1)
    while (p%3 != 1) or (p%4 != 3):
        p = random_prime(2 << size - 1)
    return p


def rand_pq(size):
    p = rand_prime_congru_1mod3_and_3mod4(size)
    q = p
    while q >= p or p>=2*q:
        q = rand_prime_congru_1mod3_and_3mod4(size)
        p = rand_prime_congru_1mod3_and_3mod4(size)

    return (p, q)

def extend_solution_quadratic_equation_mod_pr(coeffs, sol, p, r):

    a, b, c = coeffs; x0 = int(sol)
    f = lambda x : a *x^2 + b*x + c
    fprime = lambda x : 2*a*x + b
    # We apply Hensel Lemma
    x0 = int(sol)
    for _ in range(2, r+1):
        x0 = (x0 - f(x0)*inverse_mod(fprime(x0), p^r)) % p^r
    return x0


def solver_quadratic_equation_mod_pr(coeffs, p, r):
    a, b, c = coeffs; assert a%p != 0 and is_square(b^2-4*a*c, p)
    if  p%4 == 3:
        x1 = Mod((-b- power_mod(Mod(b^2-4*a*c, p), (p+1)//4, p)) * inverse_mod(2*a, p), p)
        x2 = Mod((-b + power_mod(Mod(b^2-4*a*c, p), (p+1)//4, p)) * inverse_mod(2*a, p), p)
    else:
        x1 = Mod((-b - Mod(b^2-4*a*c, p).sqrt()) * inverse_mod(2*a, p), p)
        x2 = Mod((-b + Mod(b^2-4*a*c, p).sqrt()) * inverse_mod(2*a, p), p)
        
    x1r = extend_solution_quadratic_equation_mod_pr(coeffs, x1, p, r)
    x2r = extend_solution_quadratic_equation_mod_pr(coeffs, x2, p, r)
    return (x1r, x2r)


def get_sol_with_cubic_pell_point_mod_pr_qs(C, p, q, r, s):
    xc, yc, zc = C; (a, b, c) = zc^3, yc^3-3*xc*yc*zc, xc^3 - 1
    sol_mod_pr = solver_quadratic_equation_mod_pr((a, b, c), p, r)
    sol_mod_qs = solver_quadratic_equation_mod_pr((a, b, c), q, s)
    return (sol_mod_pr, sol_mod_qs)


def is_solution_mod_pr(C, sol, p, r):
    xc, yc, zc = C; (a, b, c) = zc^3, yc^3-3*xc*yc*zc, xc^3 - 1
    f = lambda x : a *x^2 + b*x + c
    return (f(sol) % p^r) == 0


def get_sols_with_ctheo(xp, yq, p, q, r, s):
    N = p^r * q^s
    X = (xp*q^s*inverse_mod(q^s, p^r) + yq*p^r*inverse_mod(p^r, q^s))
    return X % N


def get_possible_a_values(C, p, q, r, s):

    N = p^r * q^s; (xc, yc, zc) = C
    sol_mod_pr, sol_mod_qs = get_sol_with_cubic_pell_point_mod_pr_qs(C, p, q, r, s)
    a1 =  get_sols_with_ctheo(sol_mod_pr[0], sol_mod_qs[0], p, q, r, s)
    a2 =  get_sols_with_ctheo(sol_mod_pr[1], sol_mod_qs[1], p, q, r, s)
    a3 =  get_sols_with_ctheo(sol_mod_pr[0], sol_mod_qs[1], p, q, r, s)
    a4 =  get_sols_with_ctheo(sol_mod_pr[1], sol_mod_qs[0], p, q, r, s)
    possible_a = (a1, a2, a3, a4)
    
    return possible_a


def add(pt1, pt2, a, N):
    (x1, y1, z1) =  pt1; (x2, y2, z2) = pt2
    x3 = (x1*x2 + a*(y2*z1 + y1*z2)) % N
    y3 = (x2*y1 + x1*y2 + a*z1*z2) % N
    z3 = (y1*y2 + x2*z1 + x1*z2) % N
    return (x3, y3, z3)


def exponent(pt, e, a, N):
    (x1, y1, z1) = pt; (x2, y2, z2) = (1, 0, 0)
    for bit in bin(e)[2:]:
        (x2, y2, z2) = add((x2, y2, z2), (x2, y2, z2), a, N)
        if bit == '1': 
            (x2, y2, z2) = add((x2, y2, z2), (x1, y1, z1), a, N)
    
    return (x2, y2, z2)


def keygen(size, r, s,d):
    p, q = rand_pq(size)
    N = p^r * q^s
    ordn = p*q*(p^2+p+1)*(q^2+q+1)*(p - 1)^2*(q - 1)^2
    #e = randint(1, N)
    #while gcd(e, ordn) != 1:
        #e = randint(1, N)
    phi=((p-1)^2)*((q-1)^2)
    e=Mod(1/d,phi).lift()
        
    d1 = inverse_mod(e, p^(2*(r-1))*q^(2*(s-1))*(p^2+p+1)*(q^2+q+1))
    d2 = inverse_mod(e, p^(2*(r-1))*q^(2*(s-1))*(p - 1)^2*(q - 1)^2)
    d3 = inverse_mod(e, p^(2*(r-1))*q^(2*(s-1))*(p^2+p+1)*(q - 1)^2)
    d4 = inverse_mod(e, p^(2*(r-1))*q^(2*(s-1))*(p - 1)^2*(q^2+q+1))
    return (N, e), (p, q, (r, s), (d1, d2, d3, d4))

    
def encipher(m, pk):
    (N, e) = pk; (xm, ym) = m
    a = ((1 - xm^3) * inverse_mod(ym^3, N)) % N
    C = exponent((xm, ym, 0), e, a, N)
    return C
    
    
def decipher(ctx, sk):
    
    (p, q, (r, s), (d1, d2, d3, d4)) = sk
    N =  p^r*q^s
    
    possible_a = get_possible_a_values(ctx, p, q, r, s)
    for a in possible_a:
        if (not is_cube(a, p)) and (not is_cube(a, q)): 
            d = d1
        elif is_cube(a, p) and is_cube(a, q): 
            d = d2
        elif (not is_cube(a, p)) and is_cube(a, q): 
            d = d3
        else:
            d = d4
        (xm, ym, zm) = exponent(ctx, d, a, N)
        if zm == 0:
            return (xm, ym)

r, s = 1, 1
size_pq = 200
pk, sk = keygen(size_pq, r, s,d)
N = pk[0]
print("pk = ", pk)

print("r,s = (",r,",",s,")")