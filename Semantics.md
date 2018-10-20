# Some random semantic questions

## The single element - single element collection isomorphism:
in some contexts it is ambiguous, how nested single element structures should be separated into the container and the element.
Consider the following. Let `(a)` denote a single element tuple containing a single type `a`.
Let `((a))` denote a single element tuple containing a single element tuple containing a type `a`.
Now, if we'd like to define the append operation and the concatenation as a single function (or operator) we have an ambiguity if we'd like to evaluate `((a)) + (a)` because:
 - we may consider it an append, we get `((a), a)`
 - we may consider it a concatenation, we get `((a), (a))`
 - we may consider it a creation of a container from two elements, we get `( ((a)), (a) )`
 
 
## The last step of currying problem:
What we shuld get, when we partially apply a function to its last argument?
Consider: `(((+ :: Int->Int->Int) 2 :: Int) 3 :: Int)`
 - We can get back the evaluated result of the function: `5 :: Int`
 - We can get back an unevaluated zero argument function: `() -> Int`, that we can somehow evaluate and get `5 :: Int`. This is breaking a pattern, so might be undesirable from some points of view. 
 
 or
 
We can separate the concepts of specifying the arguments of a function and evaluating a function. This means, we have an operator for evaluation and until it is not called nothing happens, but it may be called on a function with not all arguments specified: in that case it performs partial evaluation. In the same manner, specifying all the arguments of a function may not automatically evaluate.
 
 
## Limits of type constraints (refinement types):
It seems to be impossible to handle the decidability of the equivalence of two arbitrary type refinements. The question is, is there a meaningful subset for the most common problems in graphics and computing (e.g. indexing of arrays, where refimenents are posed by integer operations and relations) where such refinements are decidable?

