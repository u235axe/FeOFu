from z3 import *

a, b, c, d, e, f = Ints('a b c d e f')

s = Solver()
s.add(a <= 10, b <= 10, c <= 10, d <= 10, e <= 10, f <= 10)
s.add(215*a + 275*b + 335*c + 355*d + 420*e + 580*f == 1505)

while s.check():
    m = s.model()
    print(m)
    s.add(a != m[a], b != m[b], c != m[c], d != m[d], e != m[e], f != m[f])
