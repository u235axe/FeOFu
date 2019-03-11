from z3 import *

x = FP('x', Float32())
z = FPVal(0.0, Float32())

s = Solver()
s.add(x + z != x)

print(s.check())
if s.check() == sat:
    print(s.model())
