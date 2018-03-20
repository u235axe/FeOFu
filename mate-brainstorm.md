# Extend C++

It is undeniable that C++ has gotten a lot better lately from a usability and expressivity persepective. Not being a major user of any of the functional languages, having only read dozens of tutorials, blog posts and having fiddled with F# to some extent, I am still nto convinced, that a **functional language** would solve all of my day-to-day problems. **Functional style** programming however immediately empowers my day-to-day productivity, it's mostly the tools that limit my capabilities in this regard.

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

	• EXI en-/dekóder
		○ Constexpr képes
		○ XML/JSON compat
		○ Szigorú séma mód
	• SVG renderer
		○ SVG-ből árnyaló
		○ OpenVG?
	• GUI
		○ XAML
		○ X-plat
		○ Metaclass generált
		○ Natív/managed?
	• IDE
		○ Natív/managed?
	• Build system
		○ Build server
		○ Deklaratív
			§ Környezet
			§ Ki-/bemenet
			§ Melléktermék
		○ Batch feladat támogatás
		○ Nyelv ismeret
			§ Nyelvi sztenderd / nyelvi feature
			§ Kiterjesztése
		○ Csomagkezelés?
	• STL2
		○ Iostream
			§ Nyers I/O eszköz
			§ Formázás, lokalizáció viszonya?
			§ Dátum, idő, időtartam?
		○ COM
			§ Könyvtár típusok + modul?
		○ Fordító
			§ Build system?
			§ Kapcsolók vs. Fordítási modell?
	• C++
		○ Reflection
			§ AST
	• (GP)GPU
		○ Single-source graphics
			§ Compute interop
			§ Közös matek primitívek
		
