from z3 import *

x = BitVec('x', 32)
C = BitVec('C', 32)

s = Solver()
s.add((LShR(x << 8, 16) << 8) == x & C, C != 4294967295, C != 0)

print(s.check())
print(s.model())
