# Problems, limitations of existing languages + the good parts

## C++ (including modern standards)

### Bad parts

- Does not enforce safety like Rust does.
- Huge existing codebases mean it's always hard to use the latest and greatest standard.
- No reflection.
- Macros are outdated.
- Warnings and error messages can get really confusing.

### Good parts

- Great performance.
- Interopability with C code.
- Almost every API has C++ (C) bindings.
- Not adding runtime overhead with new features.

## Haskell

### Bad parts

- Performance issues. Optimized code requires lots of workarounds and "messing" up the code.
- Mandatory GC.
- Bad compiler performance.
- IDEs are in a bad state.
- Interop with C code is not as easy as C++ or Rust.
- Requires initializing a runtime when called in external code.

### Good parts

- Type inference.
- Great abstractions.
- REPL workflow.

## Rust

### Bad parts

- Generics is still lacking compared to C++ templates.
- Writing SIMD code is so-so.
- Bad compiler performance.
- IDE support is not as good as C++, and besides the IDEA plugin nothing works out of the box.
- Great macros.

### Good parts

- Great performance.
- Type inference.
- Interopability with C and C++ code.
- Safety through memory ownership.
- Useful compiler warning / error messages.

## Python

### Bad parts

- Super slow!
- Dynamic typing.
- Mandatory GC.

### Good parts

- REPL workflow.
- Widely used and great selection of libraries.
- Easy to use.

## Others
