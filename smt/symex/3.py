from z3 import *

a = BitVec('a', 32)
c = FP('c', Float32())

s = Solver()
s.add(c <= 42.0)
s.add(c > 0.0)
s.add(-3.14*c*c > 0)

c = s.check()
print(c)
if c == sat:
    print(s.model())
