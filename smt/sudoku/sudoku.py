import sys
import itertools
from z3 import *

# Create solver
s = Solver()

# Create Z3 integer variables for matrix cells
cells = [ [ Int("z_%s_%s" % (i+1, j+1)) for j in range(9) ] for i in range(9) ]

# Add sudoku problem instance constraints
for y, line in enumerate(open(sys.argv[1], "rU").read().split("\n")):
    for x, value in enumerate(line):
        if value != ".":
            s.add(cells[x][y] == value)

# Add cell constraints
for y in range(9):
    for x in range(9):
        s.add(And(1 <= cells[x][y], cells[x][y] <= 9))

# Add column constraints
for x in range(9):
    s.add(Distinct(cells[x]))

# Add row constraints
for y in range(9):
    s.add(Distinct([cells[x][y] for x in range(9)]))

# Add group constraints
for y in range(0,9,3):
    for x in range(0,9,3):
        s.add(Distinct([cells[x+i][y+j] for i, j in itertools.product(range(3), range(3))]))

# Check if constraints have been satisfied
if s.check() == sat:
    m = s.model()
    for y in range(9):
        print("".join([str(m.evaluate(cells[x][y])) for x in range(9) ]))
else:
    print("Failed to solve")
