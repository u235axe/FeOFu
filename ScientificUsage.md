##Musings on the design of scientific computing platforms

The goal: We want a scientific computing platform which allow scientists to work close to "ideal" efficiency. This document is biased towards (symbolic) mathematics, but that's fine.

* It must be programmable. Well I think this is a pretty clear requirement, we want to build up complex abstractions from simpler elements, this needs some form of programming.

* It needs a (static) type system. Types are inevitably helpful for avoiding mistakes, and a working scientist (hopefully) always have the types implicitly in their mind already (after all, we never add together apples with dollars!). We just want to make this explicit.

* It needs *dependent types*. Basically all mathematical objects are parametrized by other mathematical objects. Some simple examples: 
    - cyclic groups are parametrized by positive integers
    - rings of polynomials are parametrized by the base ring and the set of variables
    - vector bundles are over a space
    - group algebras are parametrized by groups (and a field)
    - etc etc

To express these we need dependent types. They are also useful for mechanized proofs, if we get to that at some point of the future.

* It needs a very liberal syntax, which allows notation as close to estabilished scientific notation as it is realistically possible. Think something like Agda mixfix syntax, but on steroids. We must allow both leaving things implicit, when it helps, and also make everything explicit for the cases when it is necessary. Again Agda-style implicit arguments is a good starting point, but not enough.

* It probably needs (extensible) physical units for applications. These can be simulated with dependent types, but explicit support from the language would be helpful.

* It needs an integrated development environment. Experience shows that working in a single integrated computing environment is very efficient. I personally dislike "notebook-style" interfaces, instead I would probably prefer separating code and execution into a scratch buffer and a shell. We need support to organize code in different stages of development and subjects (experimenting, immature library, mature library, different projects, etc)

* It needs support for large-scale programming. Mathematicians and other scientists built up extremely large hierarchies of abstractions during the last several hundredyears, which needs to be mapped to software. This results in significant engineering challenges. Code must be modularized in very flexible ways.

* Some form of built-in version control

* It needs support for having multiple representations of the same object. It is very typical in mathematics that we have different representations of the same object with very different properties and tradeoffs. Some computation may be fast in one representation and very slow or even impossible in some other. 

Some examples:

    - an univariate polynomial can have: 1) a dense array of coefficients; 
      2) a sparse array of coefficients; 3) Horner form; 4) expansion in some
      series of orthogonal polynomials; 5) an evaluator function; and so on

    - an analytic function can have: 1) an algebraic formula involving known  
      special functions; 2) an infinite power series expansion; 3) an infinite
      Fourier series expansion; 4) some kind of symbolic integral representation; and so on

    - the ring symmetric polynomials have several different bases with very
      different properties (elementary symmetric polynomials, power sum polyomials,
      Schur polynomials, etc)

  We need language support to make dealing with this less painful (seamlessly convert between them for convenience, but also offer control over this, because conversion may have highly nontrivial cost). 

* It needs control over caching and memory usage. This is a practical issue: Caching partial results can dramatically speed up computations; however we can easily run out of memory, in which case we may want to discard some cached result, because computing something slowly is better than not computing. Persisting partial results to disk could be also helpful.

* Since interactivity is very important, we probably want a JIT compiler. This could help in other ways too (link-time optimizations, staged compilation, etc).

* Check out the Fortress project for more ideas? (unfortunately it's dead)

* Freeman Dyson's point about "tool-driven revolutions" rather than concept-driven ones

http://science.sciencemag.org/content/338/6113/1426.summary

We want a tool which is an "enabler". Our current tools are often "stoppers" (ie. we know how to do something in principle, but it would be very complex and painful to implement with the existing tools).
