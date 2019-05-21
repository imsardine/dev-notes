---
title: C / Preprocessing
---
# [C](c.md) / Preprocessing

  - [C preprocessor \- Wikipedia](https://en.wikipedia.org/wiki/C_preprocessor) #ril
      - C preprocessor (CPP) 是 C/C++ 的 preprocessor，用來引入 header、macro expansions、conditional compilation 等。C 通常實作成獨立的程式，由 compiler 調用。
      - Preprocessing is defined by the first four (of eight) phases of TRANSLATION specified in the C Standard. 包括 trigraph replacement??、line splicing (接合 escaped newline sequences 拆開的 logical lines)、tokenization、macro expansion 及 directive handling
  - [Conditional compilation - C preprocessor \- Wikipedia](https://en.wikipedia.org/wiki/C_preprocessor#Conditional_compilation) #ril
  - [The C Preprocessor: Conditionals](https://gcc.gnu.org/onlinedocs/cpp/Conditionals.html#Conditionals) #ril
  - [Token stringification - C preprocessor \- Wikipedia](https://en.wikipedia.org/wiki/C_preprocessor#Token_stringification) #ril

## Macro ??

  - [The C Preprocessor: Macros](https://gcc.gnu.org/onlinedocs/cpp/Macros.html#Macros) #ril
  - [Macro definition and expansion - C preprocessor \- Wikipedia](https://en.wikipedia.org/wiki/C_preprocessor#Macro_definition_and_expansion) #ril
  - [Special macros and directives - C preprocessor \- Wikipedia](https://en.wikipedia.org/wiki/C_preprocessor#Special_macros_and_directives) #ril

## Header File ??

  - [Header Files \- The C Preprocessor](https://gcc.gnu.org/onlinedocs/gcc-4.1.2/cpp/Header-Files.html) #ril
  - [Including Files - C preprocessor \- Wikipedia](https://en.wikipedia.org/wiki/C_preprocessor#Including_files) #ril
  - [The C Preprocessor: Header Files](https://gcc.gnu.org/onlinedocs/cpp/Header-Files.html#Header-Files) #ril

  - [c \- Are function prototypes needed in header files? \- Stack Overflow](https://stackoverflow.com/questions/20180734/) Keith Thompson:

      - Header file 裡只應放 function declaration (prototype) -- 宣告 arguments 的 type，回傳值等，而 function definition (`{ ...}` 的實作) 應該留在 `.c` 裡。
      - 每個 header file 在一個 translation unit 裡 (編譯一個 source file 的過程) 只應被 include 一次，應透過 [include guards](https://en.wikipedia.org/wiki/Include_guard)?? 避免 multiple inclusion。
      - 如果某個 function 只被用在一個 `.c` 裡，可以把 function declaration 及 definition 都放在 `.c` 裡；如果 definition 出現在 function call 之前，則 declaration 可以省略，因為 definition 就可以做為 declaration。

  - `#include <stdio.h>` 中的 `stdio.h` 在哪??
  - `#include <stdio.h>` 什麼時候要用雙引號? => https://learnxinyminutes.com/docs/c/ 角括號指來自 C standard library，自己的 header 則要用雙引號

