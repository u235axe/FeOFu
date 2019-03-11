from z3 import *

Yellow, Blue, Red, Ivory, Green = Ints('Yellow Blue Red Ivory Green')
Norwegian, Ukrainian, Englishman, Spaniard, Japanese = Ints('Norwegian Ukrainian Englishman Spaniard Japanese')
Water, Tea, Milk, OrangeJuice, Coffee = Ints('Water Tea Milk OrangeJuice Coffee')
Kools, Chesterfield, OldGold, LuckyStrike, Parliament = Ints('Kools Chesterfield OldGold LuckyStrike Parliament')
Fox, Horse, Snails, Dog, Zebra = Ints('Fox Horse Snails Dog Zebra')

s = Solver()

# colors are distinct for all 5 houses:
s.add(Distinct(Yellow , Blue , Red, Ivory , Green))

# all nationalities are living in different houses:
s.add(Distinct(Norwegian , Ukrainian , Englishman , Spaniard , Japanese))

# so are beverages:
s.add(Distinct(Water , Tea, Milk , OrangeJuice , Coffee))

# so are cigarettes:
s.add(Distinct(Kools , Chesterfield , OldGold , LuckyStrike , Parliament))

# so are pets:
s.add(Distinct(Fox, Horse , Snails , Dog, Zebra))

# limits.
# adding two constraints at once (separated by comma) is the same
# as adding one And() constraint with two subconstraints
s.add(Yellow >=1, Yellow <=5)
s.add(Blue >=1, Blue <=5)
s.add(Red >=1, Red <=5)
s.add(Ivory >=1, Ivory <=5)
s.add(Green >=1, Green <=5)
s.add(Norwegian >=1, Norwegian <=5)
s.add(Ukrainian >=1, Ukrainian <=5)
s.add(Englishman >=1, Englishman <=5)
s.add(Spaniard >=1, Spaniard <=5)
s.add(Japanese >=1, Japanese <=5)
s.add(Water >=1, Water <=5)
s.add(Tea >=1, Tea <=5)
s.add(Milk >=1, Milk <=5)
s.add(OrangeJuice >=1, OrangeJuice <=5)
s.add(Coffee >=1, Coffee <=5)
s.add(Kools >=1, Kools <=5)
s.add(Chesterfield >=1, Chesterfield <=5)
s.add(OldGold >=1, OldGold <=5)
s.add(LuckyStrike >=1, LuckyStrike <=5)
s.add(Parliament >=1, Parliament <=5)

s.add(Fox >=1, Fox <=5)
s.add(Horse >=1, Horse <=5)
s.add(Snails >=1, Snails <=5)
s.add(Dog >=1, Dog <=5)
s.add(Zebra >=1, Zebra <=5)

# main constraints of the puzzle:
# 2.The Englishman lives in the red house.
s.add(Englishman==Red)

# 3.The Spaniard owns the dog.
s.add(Spaniard==Dog)

# 4.Coffee is drunk in the green house.
s.add(Coffee==Green)

# 5.The Ukrainian drinks tea.
s.add(Ukrainian==Tea)

# 6.The green house is immediately to the right of the ivory house.
s.add(Green==Ivory+1)

# 7.The Old Gold smoker owns snails.
s.add(OldGold==Snails)

# 8.Kools are smoked in the yellow house.
s.add(Kools==Yellow)

# 9.Milk is drunk in the middle house.
s.add(Milk==3) # i.e., 3rd house

# 10.The Norwegian lives in the first house.
s.add(Norwegian==1)

# 11.The man who smokes Chesterfields lives in the house next to the man with the fox.
s.add(Or(Chesterfield==Fox+1, Chesterfield==Fox -1)) # left or right

# 12.Kools are smoked in the house next to the house where the horse is kept.
s.add(Or(Kools==Horse+1, Kools==Horse -1)) # left or right

# 13.The Lucky Strike smoker drinks orange juice.
s.add(LuckyStrike==OrangeJuice)

# 14.The Japanese smokes Parliaments.
s.add(Japanese==Parliament)

# 15.The Norwegian lives next to the blue house.
s.add(Or(Norwegian==Blue+1, Norwegian==Blue -1)) # left or right

r = s.check()
print(r)
if r == unsat:
    exit(0)
m = s.model()
print(m)
