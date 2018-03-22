# Problems, limitations of existing languages + the good parts

## C++ (including modern standards)

### Bad parts

- Does not enforce safety like Rust does.
- Huge existing codebases mean it's always hard to use the latest and greatest standard.
- No reflection.
- Macros are outdated and unsafe (not typed).
- Warnings and error messages can get really confusing.
- No standard binary interface (only C has one!)
- Compile time programming is drastically different than runtime level.
- No non-local returns. Only possible with exceptions, but they are not intended for regular flow control.

### Good parts

- Copiled code performs great.
- Interopability with C code.
- Almost every API has C++ (C) bindings.
- Not adding runtime overhead with new features.

## Haskell

### Bad parts

- Compiled code performs bad.
- Optimized code requires lots of workarounds and "messing" up the code.
- Mandatory GC.
- Slow compiler.
- IDEs are in a bad state.
- Interop with C code is not as easy as C++ or Rust.
- Requires initializing a runtime when called in external code.
- Unusual syntax for the average programmer.
- High barrier of entry for the average programmer experienced in imperative languages.
- Most of the packages are hard to understand for newcomers and they tend to be very "academic".
- Scoping depends on spacing.
- Namespace pollution by record accessor names forced to be unique globally
- Impure functions unreasonably pollute function types (random number generation)

### Good parts

- Type inference.
- Great abstractions.
- REPL workflow.

## Rust

### Bad parts

- Generics is still lacking compared to C++ templates. (no cimpiler time integer arithmetic for at least 2019-2020)
- Writing SIMD code is so-so.
- Slow compiler.
- IDE support is not as good as C++, and besides the IDEA plugin nothing works out of the box.
- Certain syntax elements mean totally different things compared to mainstream languages.
- Ownership and borrowing is hard to understand for an average programmer.

### Good parts

- Compiled code perfroms great.
- Type inference.
- Great macros.
- Interopability with C and C++ code.
- Safety through memory ownership.
- Useful compiler warning / error messages.
- Syntax is similar to C++ / C family of languages.
- Great build system and package manager.
- Compiler can generate strict memory access patterns by using the ownership information.

## Python

### Bad parts

- Super slow!
- Dynamic typing.
- Mandatory GC.
- Scoping depends on spacing.

### Good parts

- REPL workflow.
- Widely used and great selection of libraries.
- Easy to use.

## Others
