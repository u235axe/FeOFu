from z3 import *

x = BitVec('x', 32)

s = Solver()
s.add((LShR(x << 8, 16) << 8) != x & 4294967295)

print(s.check())
print(s.model())
