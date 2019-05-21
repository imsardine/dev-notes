# Clang

  - [Clang C Language Family Frontend for LLVM](https://clang.llvm.org/)
      - C Language Family Frontend for LLVM 就 LLVM 而言，Clang 是面對整個 C language family 的 frontend；注意 frontend 不是介接現有的 compilers (例如 GCC) 與 LLVM，因為 Clang 本身就是 compiler。
      - The Clang project provides a language front-end and tooling infrastructure for languages in the C language family (C, C++, Objective C/C++, OpenCL, CUDA, and RenderScript) for the LLVM project. Both a GCC-compatible compiler driver (`clang`) and an MSVC-compatible compiler driver (`clang-cl.exe`) are provided.
      - Features and Goals 提到 expressive diagnostics (精確地指出 source code 的問題點)、GCC compatibility、Support diverse clients (refactoring, static analysis, code generation, etc.)、Allow tight integration with IDEs ... 下面的 Why? 更提到 a license that is compatible with commercial products。容易跟 IDE 整合、發展出其他應用，這點真的很重要! 想起 [JaCoCo 的發展背景](https://www.jacoco.org/jacoco/trunk/doc/mission.html) -- none of them are really designed for integration。
      - Clang is considered to be a production quality C, Objective-C, C++ and Objective-C++ compiler when targeting X86-32, X86-64, and ARM (other targets may have caveats, but are usually easy to fix).
  - [The LLVM Compiler Infrastructure Project](http://www.llvm.org/) The primary sub-projects of LLVM 提到 Clang 是個 "LLVM native C/C++/Objective-C compiler"，主要的訴求是快! (以 Objective-C + debug configuration，編譯速度比 GCC 快 3 倍)、產出更有用的 error/warning message，並可做為其他 soruce-level tools 的基礎。
  - [Clang vs GCC (GNU Compiler Collection) - Comparing Clang to other open source compilers](https://clang.llvm.org/comparison.html#gcc) 雖然 GCC 比 Clang 支援更多的語言 (Java、FORTRAN、Go 等)、更多的平台 (target)，但 Clang 提供更多的好處 #ril
  - [Clang \- Wikipedia](https://en.wikipedia.org/wiki/Clang) #ril
    - Clang 唸做 /ˈklæŋ/，做為 C、C++、Objective-C、Objective-C++ 等的 compiler front end，也以 LLVM compiler infrastructure 做為它的 backend。在 LLVM 2.6 後，也成為 LLVM release cycle 的一部份。Clang 專案除了 Clang front end 之外，也包含了 static analyzer。
    - 它被設計為 GCC 的 drop-in replacement，支援大部份的 compilation flags 與 unofficial language extensions?

## 新手上路 ?? {: #getting-started }

  - [Description - clang \- the Clang C, C\+\+, and Objective\-C compiler — Clang 8 documentation](https://clang.llvm.org/docs/CommandGuide/clang.html#description) While Clang is highly integrated, it is important to understand the STAGES of compilation, to understand how to invoke it. These stages are:
      - Preprocessing - This stage handles tokenization of the input source file, macro expansion, `#include` expansion and handling of other preprocessor directives. The output of this stage is typically called a “`.i`” (for C), “`.ii`” (for C++), “`.mi`” (for Objective-C), or “`.mii`” (for Objective-C++) file.
      - Parsing and Semantic Analysis - This stage parses the input file, translating preprocessor tokens into a PARSE TREE. Once in the form of a parse tree, it applies semantic analysis to compute types for expressions as well and determine whether the code is WELL FORMED. This stage is responsible for generating most of the COMPILER WARNINGS as well as PARSE ERRORS. The output of this stage is an “Abstract Syntax Tree” (AST).
      - Code Generation and Optimization - This stage translates an AST into low-level INTERMEDIATE CODE (known as “LLVM IR”) and ultimately to MACHINE CODE. This phase is responsible for optimizing the generated code and handling TARGET-SPECIFIC code generation. The output of this stage is typically called a “`.s`” file or “assembly” file. 不是產生 source code，而是 assembly code；至於轉 machine code 則是下一階段 assembler 的事。
      - Assembler - This stage runs the TARGET ASSEMBLER to translate the output of the compiler into a TARGET OBJECT FILE. The output of this stage is typically called a “`.o`” file or “object” file. 將上階段的 assembly code 轉換成 machine code。
      - Linker - This stage runs the TARGET LINKER to MERGE multiple object files into an EXECUTABLE or DYNAMIC LIBRARY. The output of this stage is typically called an “`a.out`”, “`.dylib`” or “`.so`” file. 將多個 object file merge/link 成 executable 或 dynamic libary，那 static library 呢?? 但 linker 應該不算 compilation 的一部份。

## Driver ??

  - [Description - clang \- the Clang C, C\+\+, and Objective\-C compiler — Clang 8 documentation](https://clang.llvm.org/docs/CommandGuide/clang.html#description) Driver - The `clang` executable is actually a SMALL DRIVER which controls the OVERALL EXECUTION OF OTHER TOOLS such as the compiler, assembler and linker. Typically you do not need to interact with the driver, but you transparently use it to run the other tools. 所以才會有 "GCC-compatible compiler driver (`clang`)" 的說法。

## `clang` CLI ??

  - [clang \- the Clang C, C\+\+, and Objective\-C compiler — Clang 8 documentation](https://clang.llvm.org/docs/CommandGuide/clang.html) #ril
      - `clang [options] filename ...` 從 [Object Files and Symbols \- Nick Desaulniers](http://nickdesaulniers.github.io/blog/2016/08/13/object-files-and-symbols/) `clang main.o helper.o` 的用法看來，其中 `filename` 似乎不一定要是 source code ??
      - `clang` is a C, C++, and Objective-C compiler which encompasses preprocessing, parsing, optimization, code generation, assembly, and linking. Depending on which high-level mode setting (指 stage selection option) is passed, Clang will stop before doing a FULL LINK.
      - 底下的 options 區分為 Stage Selection Options、Language Selection and Mode Options、Target Selection Options、Code Generation Options、Driver Options、Diagnostics Options、Preprocessor Options。
  - [Stage Selection Options - clang \- the Clang C, C\+\+, and Objective\-C compiler — Clang 8 documentation](https://clang.llvm.org/docs/CommandGuide/clang.html#stage-selection-options) If no stage selection option is specified, all stages above are run, and THE LINKER IS RUN to combine the results into an executable or shared library. 呼應 Description 裡 stages of compilication，`-E`、`-fsyntax-only`、`-S`、`-c` 可以控制不要走完所有的 stage，否則最後會呼叫 linker 產生 executable 或 shared library：

        Preprocessing -> Parsing and Semantic Analysis -> Code Generation and Optimization -> Assembler -> Linker
                     ^                                ^                                   ^            ^
                     |                                |                                   |            |
                     -E                               -fsyntax-only                       -S           -c (.o)

  - [c\+\+ \- What is the difference? clang\+\+ \| clang \-std=c\+\+11 \- Stack Overflow](https://stackoverflow.com/questions/20047218/) #ril

## 參考資料 {: #reference }

  - [Clang](https://clang.llvm.org/)

文件：

  - [Clang Compiler User’s Manual](https://clang.llvm.org/docs/UsersManual.html)

手冊：

  - [`clang`(1) Manpage](https://clang.llvm.org/docs/CommandGuide/clang.html)
  - [Language Compatibility](https://clang.llvm.org/compatibility.html)
  - [C++17, C++14, C++11 and C++98 Status](https://clang.llvm.org/cxx_status.html)
