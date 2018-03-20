# Extend C++

It is undeniable that C++ has gotten a lot better lately from a usability and expressivity persepective. Not being a major user of any of the functional languages, having only read dozens of tutorials, blog posts and having fiddled with F# to some extent, I am still nto convinced, that a **functional language** would solve all of my day-to-day problems. **Functional style** programming however immediately empowers my day-to-day productivity, it's mostly the tools that limit my capabilities in this regard.

## Current limitations

Some of the limitations in tooling that I've come across:

- Single-source GPGPU compilers choke on many functional-style constructs expressed in C++
    - C++AMP was abandoned in a C++11 state where lambdas got generated different random types on host and device which wrecked overload resolution when mixed and matched in both host and device side code.
    - ComputeCpp (GPU-accelerated SYCL implementation) are struggling with similar issues with the added _bonus_ of having to [play catch](https://twitter.com/nagyegrimate/status/969272929962938368) with the moving target of MSVCs STL, due to Clang not having one of its own and libc++ not supporting Windows.
	- There should be a **standard** way to do this.
- Outside C++, functional constructs sometimes fail to fulfill their promises
    - My very first functional program was written in Mathematica. _(Jokes aside, it [aims to be functional friendly](http://reference.wolfram.com/language/guide/FunctionalProgramming.html).)_ Even though I wrote a totally stateless generator function, totally pure, it fails to CPU parallelize it. How hard can it be to divide-and-conquer a _random access sequence_ of values? Even in a JIT-capable language with a **massive** userbase and an unthinkable amount of development resources, trivial stuff like this does not work.
    - Functional languages simply did not take root in the admin world, where scripting still reigns supreme. At best, some declarative DSLs exist to ease the pain. (Executable XML, WWF) Even though isolated examples exist, such as nixOS, I cannot configure an Ubuntu Server with a package manager built with a functional mindset. I'd love to, but I don't have the assets to make it happen.
- Build systems
	- Don't even get me started on that. It depply saddens me how CMake became a de-facto standard. Being a C++ developer, I couldn't agree more with Isabella Muerte on C++ needing a build system of it's own that is built around the C++ compilation model. It need not be fully featured, but be your first idea when building anything C++.
	> But than people start asking: can it do this, can it do that? Can I build my library using it without making any modifications? If you start adding features to make everyone happy, you'll gravitate to implementing one of the existing build systems.
	- C++ needs its own Cargo. And no, I don't think Conan is the answer, neither is Meson.
- GUI
	- Out of all the GUI technologies _(SFML/SFGUI, wxWidgets, Qt Widgets, QML, XAML, [SAFE stack](https://safe-stack.github.io/))_ and plotting frameworks I've come across _(GnuPlot, oxyPlot, plPlot, Qt Charts)_ I arrive at the same conclusion: **GUI requries a declarative DSL.**
	- Dániel likes to hate current _static_ UIs present in just about any software, but I don't feel the need for a UI to be able to do any random sh_t dynamically. A user interface should:
		- be predictable
		- not surprise
		- be intuitive
		- easy to learn
	- To accomplish this, one need not anything else other than JSON or XML. Because I arrive at things primarily from the Microsoft angle, if I had to write a cross-platform GUI or plotting framework, it would be XAML _(and be XAML Standard compliant where possible)_.
	- Not making it a library/DSL of a language, one has to deal with data binding and language interop in general, but that is proven to be solvable.
	- No web technologies! For crying out loud, the foundations of Visual Studio Code are something to laugh about. Having to dynamically interpret and JIT stuff that are all known at compile time (dynamically interpret static layout) is a joke and a huge waste of resources.

## Missing pieces of technologies

I believe C++ is not beyond _redemption_ and adding/fixing/deprecating features can lead to a substantially larger audience and impact than cooking a n entirely new language. I would like to think, C++ has not reached a breaking point (yet). These are missing pieces of technologies I have collected that seems like programming nirvana in relation to functional style coding embedded in a single-source, graphics/compute capable (GP)GPU language, usable in many domains of programming, embedded preferably into C++.

### EXI en/decoder

I have mentioned JSON and XML as representations of tree-like data structures. [EXI](http://www.w3.org/TR/exi/) is just as much of a W3C recommendation as JSON or XML itself and it can be used to compress both JSON and XML. It is very much like a serialization format of both, a binary representation that can be guided by schema information. Because JSON and XML (apart from 0.0001% corener cases) are interchangeable, EXI compressed data can in theory be deserialized into both DSLs. Beneficial properties of EXI:

- Small size, even smaller than JSON (it's binary afterall)
- Extremely fast to parse (especially when schema guided)

It is ideal when one needs to store or send data over the wire, especially when the data format is agreed upon by both ends. (XAML, plotting XAML modules, LambdaXML, etc.) To be honest, I'm shocked that so few (practically none) XML libraries implement it.

_(You could even think of it as a more standard way Boost.Serialize, one fit to be part of the ISO C++ standard. As far as I thought of it, it's fit for the task. EXI supports partial schema guiding, some types to be known ahead of time (STL types?) others to be unknown at the time of deserializing.)_

#### Needed features

- Constexpr képes
	- This (along with being able to load files at compile time) would abolish the need for configuration headers with macro definitions triggering all kinds of weird macro voodoo. Separate, conforming JSON/XML files could be #include-ed (or loaded via constexpr functions), be stored as a variable and be traversed as a compile-time data structure, and be fed to TMP or constexpr_if blocks, or simply be used in a constexpr context. The proof of concept compile-time JSON parser is on [Github](https://github.com/lefticus/constexpr_all_the_things)/[Youtube](https://youtu.be/PJwd4JLYJJY).
- XML/JSON compat
- Shema guided
	- Fully
	- Partially

#### Would be awesome

- For current ROX experts, existing XML DSLs can enhance its usage
	- XML comprehension (xml["XQueryLiteral"])
	- Trivial transformations (xml.transform("XSLT_literal"))
	- Evaluated at compile-time, or just optimized at compile-time, much like you would want regular expressions to no be interpreted by a runtime mechanism, but have specialized code generated from the regex if it was a string literal.

### SVG renderer

Because when rendering either a GUI or a data plot, vector graphics comes in handy, and I'm already fixated on XML, SVG seems like a natural choice. Generating shaders specific to a given SVGs would allow for instant resizes with no pixelating in between and **extremely** low power usage when rendering UIs with SVG elements in them (Open, Save buttons, scroll bars, what not.)

#### Needed features

- SVG to shader
	- SPIR-V/DXIL?
	- Hook it into OpenVG?
		- perhaps less work, bit less intersting but if vendors have their own OpenVG implementations, it might be faster than hooking it into a generic API.

#### Would be awesome

- Constexpr capable
	- Needs static reflection to make sense.

### Build system/server

Because I'm not satisfied with any of the build systems out there, I would very much like to cook one that is better than the rest. Problems with the current cross-plat build systems:

- CMake
	- The scripting language sucks
	- No tooling around debugging the sucky scripting language
	- Is too much pain to master only to get a build running
	- Teaching new languages (LaTeX, SYCL) require deep knowledge about the internals and has to be added as code to CMake itself
- MSBuild
	- Slow to parse XML
	- Only knows MSVC, limited in Clang awareness, extremely limited GCC
- Ninja
	- Very good on the execution side
	- It definitely requires some front-end (CMake)
- QMake
	- Too much tied to Qt
- Qbs
	- Not read much about it, though I take it is still very much aimed at serving Qt

Looking at the foundations of most buildsystems (plus Meson, plus Buck, plus GNU Make), the best are Ninja and MSBuild. The very good properties of them are:

- Ninja
	- Blazingly fast
	- Favors execution instead of hand-authoring
- MSBuild
	- Declarative
	- Language aware
		- Though I would tweak it to map closer to the language at hand
	- Graphical front-end
	- Extensible
		- One can teach MSBuild a new language just by providing a schema of the languages compilation model. I need not be familiar with the internals of MSBuild as long as the schema entries which MSBuild can operate with are documented. This is how Clang/C2, ComputeCpp, and other integrations work, this is how F# was taught to MSBuild.

#### Needed features

- Language aware
	- Whatever language I compile, it must fit like a glove
	- Language dialects (GNU C++, MS C++, ISO C++, CUDA C++, etc.)
- Tool aware
	- Batch mode if tool supports it
- Extensible
	- The very first languages must be implemented using the same _extension API_ others are meant to use
- Fast
	- EXI as makefiles. I don't read Ninja, neither will I read EXI.
- Graphical front-end
	- I don't want to author makefiles, ever.
- Build server
	- Incremental builds
	- Language server hooks

#### Would be awesome

- Tooling
	- IDE infers as much from the source code as possible
		- Language version
		- Language dialect/extension
		- Dependencies
			- If I include a Boost header for eg., it should add a renference to it.

#### Open questions
- Package manager be a part, or just simply fit like a glove?
	- Mix and matching the two that were not created to be aware of each other is tough. Requires a very good extension API to pull off two-way interoperability

### GUI

A proper cross-plat GUI library

#### Needed features

- Cross-plat
	- Windows, Linux, OSX
- Modern back-ends
	- Vulkan
- Declarative
	- XAML (Standard)
- _Controls_ (GUI elements)
	- The usual desktop stuff
		- Text
			- Math (MathML)
		- Layout controls
		- Scroll bars
		- Buttons, Radio buttons, Check boxes, etc.
		- Spinners
		- etc.
	- API canvases
		- In Vulkan back-end, that is a Vulkan context
	- Plotting control

#### Would be awesome

- Metaclass generated
	- Could be driving the C++ Metaclass proposal, implementing a constexpr friendly version of this XAML compiler, not needing any external tooling.

#### Open questions

- Native/managed?
	- How can one omit recompilation of GUI elements without a stable ABI? There's no portable COM, so...
		- .Net CLR?
		- Couple it to some external tool (the aforementioned build system?) and recompile on every deployment?

### IDE

A nice use case for most of the above.

#### Needed features

- No Web!
- Native!
- Many things others already know
	- Extension manager
	- Powerful linting API

#### Would be awesome

-  Mobile-friendly
	- Continuum (existing, the coming Andromeda device), Samsung Dex, etc. capable, a mobile should be able to handle most development tasks

### C++ reflection on statements

Saving some time on my part and not paraphrasing something I already wrote down, here's an excerpt from an email to Andrew Sutton:

> The effort put into the abstraction of GPGPU and massively parallel computing has gained major traction over the past 2-3 years. Implementations however are usually compiler forks which rise and fall as research goes on. However, if there were a way to capture some subset of the C++ AST, specifically the GPU-compatible part of it, often referred to as „static C++” (no virtuals, no RTTI, no exceptions, etc.), one could implement CUDA-like single-source GPGPU compilers via reflection as a library instead of a separate compiler. Not only would such libraries be portable across compilers (Clang/GCC/MSVC), but it would also be able to evolve independently from the compilers. In my view, this would significantly reduce the barrier of incorporating GPGPU into C++, as giving any kind of language support could be based on throrough library usage. If one interface proves useful, STL implementations could ship the meta-library and hooking it into whatever API they see fit (should the standard allow so.)
>
> If there were a standardized interface to the AST (the compiler would still be free to have any internal representation (if any) as it sees fit), and one would have a constexpr friendly implementation of LLVM per say, one could write CUDA and SYCL-like compilers and distribute them as header-only libraries. The library would generate the device intermediate (SPIR-V for Vulkan, DXIL for DirectX 12, etc.) and the accompanying host-side code the same way as they do today. I know, that making LLVM work in a constexpr context is a serious effort, but if one could make it work inside a browser, making it work inside the compiler itself isn’t science fiction. (Does require a lot of constexpr work, starting with constexpr allocator support.)

#### Needed features

- Standard representation of the C++ AST
- Constexpr-compatible LLVM generator
- Constexpr-compatible LLVM back-ends
	- Initially GPU IR back-ends

#### Would be awesome

- Multiple front-ends
	- ISO C++17 (Parallel STL)
	- SYCL 2.2
- Reflection/Metaclass generated API
	- Import a metaclass library that takes the XML representation of all the Vulkan API functions (available online), and have the API bindings compile "on-the-fly" via the reflection API and have it generate metaclasses (handle vs. class/struct) and API functions.
- IntelliSense support

### Khronos standards

The following contributions to graphics/compute related APIs

#### Would be awesome

- SYCL extension to enable single-source graphics
	- Hook assembling a graphics pipeline into the command_group abstraction
	- Results in trivial compute interoperability
	- Allows for the very same math primitives and syntax to be used for both graphics and compute