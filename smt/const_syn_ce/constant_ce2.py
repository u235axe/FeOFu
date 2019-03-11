from z3 import *

x = BitVec('x', 32)
C = BitVecVal(16776960, 32)

s = Solver()
s.add((LShR(x << 8, 16) << 8) != x & C)

print(s.check())
if s.check() == sat:
    print(s.model())
