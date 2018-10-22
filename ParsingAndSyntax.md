## Parsing and Syntax related topics and resources

Main point: the parser / compiler must be designed with IDE support in mind, that is, for recompiling a project with only small, localized changes since the last build. Also, the parser / type checker / partial evaluator must be able to run on local parts of the code to support tooltips, completion, etc. 

 * [dev.stephendiehl.com](http://dev.stephendiehl.com/fun/index.html)
   
   An incomplete but detailed blog on writing parsers.

 * [A Typed, Algebraic Approach to Parsing](http://semantic-domain.blogspot.com/2018/07/a-typed-algebraic-approach-to-parsing.html)
   
   * "First, we found a better notation for context-free languages than BNF. Basically, if you take regular expressions and add a least fixed operator to them, then you can recognize exactly the context free languages."
   
   * "the next thing we do is we define a type system for our context-free expressions, which can statically identify unambiguous grammars which can be parsed efficiently"
   
   * "Next, we define a family of parser combinators which operate on typed grammars. Our parser combinators have a very simple implementation story -- there's no backtracking and no fancy lookahead, so the type of parsers is as simple as can be."
   
   * "Our parser combinators have very predictable performance, but are still fairly slow, due to all the overhead of indirecting through function pointers (due to all the higher-order functions involved). So we use staged programming to eliminate this overhead."

 * [rust-analyzer/rowan](https://github.com/rust-analyzer/rowan)
   
   "Rowan is a library for lossless syntax trees, inspired in part by Swift's libsyntax."
