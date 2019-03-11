from z3 import *

x = BitVec('x', 32)
C = BitVec('C', 32)

a = BitVecVal(0, 32)
b = BitVecVal(-1, 32)

s = Solver()
s.add((LShR(a << 8, 16) << 8) == a & C)
s.add((LShR(b << 8, 16) << 8) == b & C)
s.add((LShR(x << 8, 16) << 8) == x & C)

print(s.check())
print(s.model())
