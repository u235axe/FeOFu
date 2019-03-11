from z3 import *

x = BitVec('x', 32)
C = BitVec('C', 32)

s = Solver()
s.add(ForAll(x, (LShR(x << 8, 16) << 8) == x & C))

print(s.check())
print(s.model())
