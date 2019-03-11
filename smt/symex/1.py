from z3 import *

a = BitVec('a', 32)
b = BitVec('b', 32)

s = Solver()
s.add((a - b) == 0)
s.add((b - a) < 0)
s.add((b - a) > 0)

c = s.check()
print(c)
if c == sat:
    print(s.model())
