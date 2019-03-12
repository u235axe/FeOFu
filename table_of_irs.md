


|                    |     CPS/1    |     CPS/2    |      ANF     |    Monadic   |   SSA/LLVM   |    SSA/SIL   |  MLton "CPS" |      MIR     |   GHC Core   |      STG     |      C--     |      SoN     |    Thorin    |
| ------------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
| Structure          |      AST     |      AST     |      AST     |      AST     |      AST     |      AST     |      AST     |      AST     |      AST     |      AST     |      AST     |     Graph    |     Graph    |
| Scoping            |    Lexical   |    Lexical   |    Lexical   |    Lexical   |   Inferred   |   Inferred   |    Lexical   |   Inferred?  |    Lexical   |    Lexical   |       ?      |       ?      |   Inferred   |
| "Order"            |    Higher    |    Higher?   |    Higher    |       ?      |     First    |    Higher?   |    Higher?   |    First?    |    Higher    |    Higher    |     First    |     First    |    Higher    |
| Control flow style |      CPS     |      CPS     |    Direct    |    Direct    |    Direct    |    Direct    |    Direct    |    Direct    |    Direct    |    Direct    |    Direct    |     Direct   |     CPS*     |
| Unit of control    | Continuation | Continuation |   Function   |   Function   |  Basic block |  Basic block |  Basic block |  Basic block |   Function   |   Function   |       ?      |     Node     | Continuation |
| Jumps vs. calls    |  Calls only  |  Jumps also  |  Calls only  |  Calls only? |  Jumps also  |  Jumps also  |  Jumps also  |  Jumps also  |  Jumps also  |  Jumps also  |       ?      |  Jumps also  |  Jumps also  |
| Temporaries        |   Explicit?  |   Explicit?  |   Explicit   |   Explicit   |   Explicit   |   Explicit   |   Explicit   |   Explicit   |   Automatic  |   Explicit   |   Explicit?  |   Explicit   |   Explicit   |
| Local variables    |   Immutable  |   Immutable  |   Immutable  |   Immutable  |   Immutable  |   Immutable  |   Immutable  |    Mutable   |   Immutable  |   Immutable  |    Mutable   |   Immutable  |   Immutable  |
| Data flow via      |   Arguments  |   Arguments  |   Arguments  |   Arguments  |   PHI nodes  |   Arguments  |   Arguments  |   Mutation   |   Arguments  |   Arguments  |       ?      |   Arguments  |   Arguments  |
| Evaluation order   |     Fixed    |     Fixed    |     Fixed    |     Fixed    |     Fixed    |     Fixed    |     Fixed    |     Fixed    |   Flexible   |     Fixed    |     Fixed    |   Flexible   |   Flexible   |


CPS/1 = First-class continuations

CPS/2 = Second-class continuations ("Compiling with Continuations, Continued" Kennedy)

SIL   = Swift Intermediate Language

MIR   = Middle Intermediate Representation (Rust)

SoN   = Sea of Nodes ("A Simple Graph-Based Intermediate Representation" Click)

TODO maybe add: [wasm, microwasm](http://troubles.md/posts/microwasm/), [Cranelift](https://cranelift.readthedocs.io/en/latest/compare-llvm.html)
