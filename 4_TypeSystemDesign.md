## Type system design related questions and resources

The most advanced typesystem that has widespread applications is the Hindley-Milner / prenex polymorphism system.
In that case, all type annotations can be inferred, terminates and has nice properties. It is approximately the polymorphism level that Haskell, C++ and rust supports
(forall quantifiers can only appear at the outermost level of a type). In this system we can infer polymorphic types to functions used with differnt types in different places 
(as opposed to conflicting monomorphic types that would be inferred by a simple unification algorithm), this is called generalization.

Type checking/inference can be implemented via unification and/or bidirectional methods. The latter makes use of a top-down propagated expected type,
that enables better error messages, thus the preferred implementation would make use both of the methods (ie. having an expected type propagation and unification).

Another important aspect is that prenex polymorphic code can always be monomorphised (it might not happen at typechecking, but can be done at code generation).

Better error messages and readibility would benefit from making type annotations obligatory on top-level functions and that would most likely unavoidable with dependent types.

In the most simple case, the type level combinators are the following:
* (->): arrow of the function type
* (,): product type
* (|): sum type

While these are mostly trivial to implement, some more combinators are needed:
* we need some way to express recursive types (eg. lists or trees), thus we need a Fix operator + unit type
* universal quantification (forall)
* existential quantification (exist), can be optionally implemented with foralls.

One might have multiple possible way to include recursion, one part of the question is whether data and codata is distinguished,
then most likely one needs a least and a greatest fixpoint combinator and the matching fix/unfix operations too.


## Dependent Types

In the dependent case we would have different combinators, and interplay of the others can be more complicated. Now the basic combinators are:
* Pi: represents a generalization of the arrow type and forall
* Sigma: represents a generalization of the product type and exist
* Some additional built-in is needed to create sum types (eg. bool)

If one would like to move to dependent types, some type annotation is necessary. There, a bidirectional method (ie. expected type)
can help reduce the amount of redundant annotations where it can be determined from other places (like function definition and applciation cases).

If we have Type-in-Type and Prop, and use Prop for memory related tasks, we might run into Girard's paradox.
This also does not play well with general recursion, as that should not be used in Prop or we would need some non-termination checking, like Idris:
A function can be annotated that it might be non-terminating, then it cannot be used in Prop, if this is not the case,
that it must be provable that it is terminating and can be used and later erased in Prop.

