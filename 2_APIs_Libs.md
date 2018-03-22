## Problems, limitations of APIs

Most APIs are centered on C/C++ bindings, with outdated, limited design.
Thus:
- Most APIs do not enforce valid usage at the type level, even in cases when they could, instead they report invalid usage with error codes / exceptions at runtime.
- API calls are not composable, they do not provide helpers in this regard, user might create own solutions, but they do not care, this results in code bloat, and copy-paste errors.

## Good points

- Vulkan made an important step in automating the generation of bindings from the XML specification. If this could be made to another level, where constraints on API call arguments could be automatically generated could greatly improve type level enforcements.

## Problems, limitations of libraries
- Most libraries provide little or limited capabilities for end user customization. Again Vulkan has some good counter examples, e.g. the full memopry allocation system is customizable to use user supplied allocators for memory improvements.

- Mathematical libraries suffer from a wide range of limitations in encapsulating user defined arithmetic types, that would be possible to accomodate, but the library is not prepared to do so.
