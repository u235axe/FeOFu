## Parsing and Syntax related topics and resources

Main point: the parser / compiler must be designed with IDE support in mind, that is, for recompiling a project with only small, localized changes since the last build. Also, the parser / type checker / partial evaluator must be able to run on local parts of the code to support tooltips, completion, etc. 

 * [dev.stephendiehl.com](http://dev.stephendiehl.com/fun/index.html)
   
   An incomplete but detailed blog on writing parsers.

 * [A Typed, Algebraic Approach to Parsing](http://semantic-domain.blogspot.com/2018/07/a-typed-algebraic-approach-to-parsing.html)
   
   * "First, we found a better notation for context-free languages than BNF. Basically, if you take regular expressions and add a least fixed operator to them, then you can recognize exactly the context free languages."
   
   * "the next thing we do is we define a type system for our context-free expressions, which can statically identify unambiguous grammars which can be parsed efficiently"
   
   * "Next, we define a family of parser combinators which operate on typed grammars. Our parser combinators have a very simple implementation story -- there's no backtracking and no fancy lookahead, so the type of parsers is as simple as can be."
   
   * "Our parser combinators have very predictable performance, but are still fairly slow, due to all the overhead of indirecting through function pointers (due to all the higher-order functions involved). So we use staged programming to eliminate this overhead."
   
 * GLL parsing
   
   I have recently heard from multiple sources that GLL is allegedly the best modern solution to parsing. Its main advantages seem to be that it's recursive-descent and so suitable for parser combinators, can handle left-recursive and ambiguous grammars, and is O(n) for deterministic ones (O(n^3) in the general case). I haven't had time to study it further, but here is a selection of links I found:
   
     * https://github.com/djspiewak/gll-combinators#theory (Scala library)
     
     * http://dotat.at/tmp/gll.pdf original paper, 2010
     
     * http://hackage.haskell.org/package/gll (Haskell library)
     
     * https://github.com/lykenware/gll (Rust library - WIP at time of this writing)
     
     * http://www.cs.rhul.ac.uk/research/languages/csle/GLLparsers.html
     
     * http://www.codecommit.com/blog/scala/unveiling-the-mysteries-of-gll-part-2
     
     * http://dinhe.net/~aredridel/.notmine/PDFs/Parsing/IZMAYLOVA,%20Anastasia%20&%20AFROOZEH%20-%20Faster,%20Practical%20GLL%20Parsing.pdf 2015
     
     * https://dl.acm.org/citation.cfm?id=2950603 "Structuring the GLL parsing algorithm for performance", 2016
     
     * https://dl.acm.org/citation.cfm?id=3276618 "GLL parsing with flexible combinators", 2018
     
     * [Twitter thread](https://twitter.com/glaebhoerl/status/1061592404514476032)
 
 * Monoidal parsing
 
   Offers benefits in terms of parallelism and incrementality. Probably suitable for an IDE?
   
     * http://comonad.com/reader/2009/iteratees-parsec-and-monoid/
     
     * https://www.reddit.com/r/haskell/comments/75as61/monoidal_parsing_edward_kmett_scala_world/
     
     * https://www.youtube.com/watch?v=090hIEiUoE0
     
     * http://hackage.haskell.org/package/incremental-parser (not clear if this is the same idea?)

 * [rust-analyzer/rowan](https://github.com/rust-analyzer/rowan)
   
   "Rowan is a library for lossless syntax trees, inspired in part by Swift's libsyntax."
   
 * [Parsing: A Timeline](https://jeffreykegler.github.io/personal/timeline_v3)
 
   Read this if you want to understand the challenges and hard problems in parsing, the history of it all, the various approaches and their relationships to each other. (I have only skimmed it so far.)
   
   Doesn't mention GLL though?
   
 * [Taxonomy](https://internals.rust-lang.org/t/proposal-grammar-working-group/8442/46) of crazy in-between-CFG-and-context-sensitive stuff
