from z3 import *

a = BitVec('a', 32)
b = BitVec('b', 32)

s = Solver()
s.add(a > 3)
s.add(b < 3)
s.add(b > a)

c = s.check()
print(c)
if c == sat:
    print(s.model())
