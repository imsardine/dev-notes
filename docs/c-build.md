---
title: C / Build Process
---
# [C](c.md) / Build Process

  - [The Four Stages of Compiling a C Program](https://www.calleerlandsson.com/the-four-stages-of-compiling-a-c-program/) (2015-08-07) 用 Hello, World! 說明，可以看到每個階段的產出

      - Compiling a C program is a multi-stage process. At an overview level, the process can be split into four separate stages: PREPROCESSING, COMPILATION, ASSEMBLY, and LINKING.

        嚴格來說，是 build 分為 4 個階段。

            /*
             * "Hello, World!": A classic.
             */

            #include <stdio.h>

            int
            main(void)
            {
                puts("Hello, World!");
                return 0;
            }

    Preprocessing

      - The first stage of compilation is called preprocessing. In this stage, lines starting with a `#` character are interpreted by the preprocessor as PREPROCESSOR COMMANDS. These commands form a simple MACRO LANGUAGE with its own syntax and semantics.

        This language is used to REDUCE REPETITION in source code by providing functionality to inline files, define macros, and to CONDITIONALLY OMIT CODE.

      - Before interpreting commands, the preprocessor does some INITIAL PROCESSING. This includes JOINING continued lines (lines ending with a \) and stripping comments.

        在 preprocessing 前，還有個 initial processing。

      - To print the result of the preprocessing stage, pass the `-E` option to `cc`: `cc -E hello_world.c`

        Given the “Hello, World!” example above, the preprocessor will produce the contents of the `stdio.h` header file joined with the contents of the `hello_world.c` file, stripped free from its leading comment:

            [lines omitted for brevity]

            extern int __vsnprintf_chk (char * restrict, size_t,
                   int, size_t, const char * restrict, va_list);
            # 493 "/usr/include/stdio.h" 2 3 4
            # 2 "hello_world.c" 2

            int
            main(void) {
             puts("Hello, World!");
             return 0;
            }

        在 macOS 上 Clang `-E` 的作用是 Run the preprocessor stage. 實際執行的結果：

            # 1 "hello_world.c"
            # 1 "<built-in>" 1
            # 1 "<built-in>" 3
            # 361 "<built-in>" 3
            # 1 "<command line>" 1
            # 1 "<built-in>" 2
            # 1 "hello_world.c" 2




            # 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdio.h" 1 3 4
            # 64 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdio.h" 3 4
            # 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 1 3 4
            # 68 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 3 4
            # 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 1 3 4
            # 608 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 3 4

            ...

            # 412 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdio.h" 2 3 4
            # 6 "hello_world.c" 2

            int
            main(void)
            {
             puts("Hello, World!");
             return 0;
            }

        原本 `#include <stdio.h>` 被展開成一推檔案的內容，包括 stdio.h 自己間接引入的；可以看出不同 header files 來自什麼地方。

    Compilation

      - The second stage of compilation is confusingly enough called compilation. In this stage, the preprocessed code is translated to ASSEMBLY INSTRUCTIONS specific to the TARGET PROCESSOR ARCHITECTURE. These form an INTERMEDIATE HUMAN READABLE LANGUAGE.

      - The existence of this step allows for C code to contain INLINE ASSEMBLY INSTRUCTIONS and for different assemblers to be used.

        Some compilers also supports the use of an INTEGRATED ASSEMBLER, in which the compilation stage generates MACHINE CODE directly, avoiding the overhead of generating the intermediate assembly instructions and invoking the assembler.

      - To save the result of the compilation stage, pass the `-S` option to cc: `cc -S hello_world.c`

        This will create a file named `hello_world.s`, containing the generated assembly instructions. On macOS 10.10.4, where `cc` is an alias for `clang`, the following output is generated:

                .section    __TEXT,__text,regular,pure_instructions
                .macosx_version_min 10, 10
                .globl  _main
                .align  4, 0x90
            _main:                                  ## @main
                .cfi_startproc
            ## BB#0:
                pushq   %rbp
            Ltmp0:
                .cfi_def_cfa_offset 16
            Ltmp1:
                .cfi_offset %rbp, -16
                movq    %rsp, %rbp
            Ltmp2:
                .cfi_def_cfa_register %rbp
                subq    $16, %rsp
                leaq    L_.str(%rip), %rdi
                movl    $0, -4(%rbp)
                callq   _puts
                xorl    %ecx, %ecx
                movl    %eax, -8(%rbp)          ## 4-byte Spill
                movl    %ecx, %eax
                addq    $16, %rsp
                popq    %rbp
                retq
                .cfi_endproc

                .section    __TEXT,__cstring,cstring_literals
            L_.str:                                 ## @.str
                .asciz  "Hello, World!"


            .subsections_via_symbols

        在 macOS 上 Clang `-S` 的作用是 Run  the  previous  stages  as  well  as LLVM generation and optimization stages and target-specific code generation, producing an ASSEMBLY FILE.

    Assembly

      - During this stage, an assembler is used to translate the assembly instructions to OBJECT CODE. The output consists of ACTUAL INSTRUCTIONS to be run by the target processor.

        也就是 machine code。

      - To save the result of the assembly stage, pass the `-c` option to `cc`: `cc -c hello_world.c`

        Running the above command will create a file named `hello_world.o`, containing the object code of the program. The contents of this file is in a binary format and can be inspected using `hexdump` or `od` by running either one of the following commands:

            hexdump hello_world.o
            od -c hello_world.o

        用 `hexdump` 或 `od` 看就一堆數字，為什麼不是用 `nm` 或 `strings` 看?

    Linking

      - The object code generated in the assembly stage is composed of machine instructions that the processor understands but some pieces of the program are out of order or missing. To produce an executable program, the existing pieces have to BE REARRANGED AND THE MISSING ONES FILLED IN. This process is called LINKING.

      - The linker will arrange the pieces of object code so that FUNCTIONS IN SOME PIECES CAN SUCCESSFULLY CALL FUNCTIONS IN OTHER ONES. It will also add pieces containing the instructions for library functions used by the program. In the case of the “Hello, World!” program, the linker will add the object code for the `puts` function.

        這說法很容易懂，所謂的 piece 指的是存在不同 object file 或 library 裡的東西，在 linking 時也只會取有用到的部份出來重組；但不能走 dynamic linking 嗎??

      - The result of this stage is the final executable program. When run without options, `cc` will name this file `a.out`. To name the file something else, pass the `-o` option to `cc`: `cc -o hello_world hello_world.c`

  - [旗標 - C 語言教學手冊 (第四版)](http://www.books.com.tw/products/0010360466) (2007-04)

      - 流程圖提到，編譯程式搭配 "標頭檔" (header file) 會產生 "目的檔" (object file)，透過 "連結程式" (linker) 可以根據多個目的檔及函數庫產生執行檔。 (p1-13)
      - 編譯過程除了要檢查語法，也要根據標頭檔所宣告的函數原型 (prototype) 檢查函數的用法是否合乎規則，若這些檢查都沒有問題，就會產生一個目的檔 -- 已經編譯過且沒有錯誤的程式。接著連結程式將多個目的檔及函數庫 (library) 連結在一起，成為可執行檔。 (p1-16)
      - 函數是 C 語言的基本單位，C 語言已經將許多常用的函數寫好並分門別類放在不同的 library 裡，將個別的 header 引入，就可以使用。 (p1-17)

  - [The C build process \- Sticky Bits \- Powered by FeabhasSticky Bits – Powered by Feabhas](https://blog.feabhas.com/2012/06/the-c-build-process/) (2012-06-29) 這裡講得更細，由其是不同 section 的作用與組成 #ril

## Build Tool

  - CMake 是最佳選擇，但如果沒有跨平台的問題，GNU Make 也可以。

---

參考資料：

  - [What is currently the best build tool for C\+\+? \- Quora](https://www.quora.com/What-is-currently-the-best-build-tool-for-C++)

      - Anonymous: The best options these days are CMake and QMake.

        CMake is useful because it GENERATES BUILD SCRIPT for several different build systems. So if you do it right, your program will compile on other platforms too. It is supported on windows.

        QMake is a part of Qt 5, which is a great cross-platform framework for C++. It acts in manner similar to CMake (meaning it generates build script for a target platform), and is also supported on windows.

        If you're planning to make GUI apps, I'd advise to use Qt with QMake. Otherwise I'd use CMake.

        GNU make is NOT A VERY GOOD CHOICE, because out of the box it offers very little, and proper utilization of the system requires [autoconf](https://www.gnu.org/software/autoconf/)... which doesn't work that well on windows system.

      - Peter Bočan, Student @ FIT CTU in Prague: For PORTABLE projects it's CMake, but I do not feel it's the best one (it's cumbersome for me).

        For NON PORTABLE projects it's Makefile on UNIX. On Windows there's none such thing, but I would use Visual Studio Solution for Windows-only projects.

        看來涉及跨平台時 CMake 是最好的選擇，否則用 Make 即可。

  - [18 Best open\-source build systems for C/C\+\+ as of 2019 \- Slant](https://www.slant.co/topics/4263/~open-source-build-systems-for-c-c) CMake 跟 GNU Make 不相上下。

  - [CMake  \|  Android NDK  \|  Android Developers](https://developer.android.com/ndk/guides/cmake)

      - Android Studio can use CMake to compile C and C++ code into a native library that the IDE then packages into your APK.

  - [googletest/CMakeLists\.txt at master · google/googletest](https://github.com/google/googletest/blob/master/CMakeLists.txt) Google Test 也用 CMake

  - [Make and CMake : Automating C\+\+ Build Process – Coding Blocks – Medium](https://medium.com/coding-blocks/make-and-cmake-automating-c-build-process-900f569a75db) 用 Hello, World! 比較 CMake 與 GNU Make (2017-12-13) #ril

  - [An overview of build systems (mostly for C\+\+ projects)](https://medium.com/@julienjorge/an-overview-of-build-systems-mostly-for-c-projects-ac9931494444) (2018-07-17) 作者很推 Premake? #ril

## Project Structure ??

  - C 有沒有標準的專案結構 (project structure) ??
  - The Project Directory Structure | Abhishek Arora | Pulse | LinkedIn (2016-08-15) https://www.linkedin.com/pulse/project-directory-structure-abhishek-arora #ril
  - What is a good project structure in C - Stack Overflow http://stackoverflow.com/questions/2605253/ #ril
  - styles - Is there a C project Default Directory Layout? - Stack Overflow http://stackoverflow.com/questions/8523078/ #ril
  - Folder structure for a C project - Stack Overflow http://stackoverflow.com/questions/1451086/ #ril
  - How should I structure complex projects in C? - Stack Overflow http://stackoverflow.com/questions/661307/ #ril

## Package Manager ??

  - conan-io/conan: Conan.io - The open-source C/C++ package manager https://github.com/conan-io/conan 用 Python 開發! 但從 https://conan.io/ 得知有跟 JFrog 合作 #ril
  - clibs/clib: C package manager-ish https://github.com/clibs/clib 主要用 C 開發 #ril

## Object File, Symbol ??

  - [Object Files and Symbols \- Nick Desaulniers](http://nickdesaulniers.github.io/blog/2016/08/13/object-files-and-symbols/) (2016-08-13)
      - A quick review of the compilation+execution pipeline (for terminology): ... #1 ~ #4 還在分析程式碼，接著產生 object code，透過 linking 才有 executable，最後才是執行期有 OS 的 loader 載入 executable 執行；這裡將專注在 #6 Linkage produces a complete executable，用 Clang 說明。
      - 把 `main.c` 拆成多個 source，建造的過程開始變得不一樣...

            // main.c
            #include <stdio.h>
            void helper () {
              puts("helper");
            }
            int main () {
              helper();
            }

         把 source 拆成兩份，同時也衍生出一個 header file：

            // main.c
            #include "helper.h"
            int main () {
              helper();
            }

            // helper.h
            void helper();

            //helper.c
            #include <stdio.h>
            #include "helper.h"
            void helper () {
              puts("helper");
            }

      - 就 single source version 而言，`clang main.c` 同時做了 compile 與 link 然後產生 executable，但 multiple source version 則必須將 compilation 與 linking 分開來做 -- 將 source files 編譯成 object files (加 `-c` 就不會走到 linking)，再把它們 link 在一起：

            $ clang -c helper.c     # produces helper.o
            $ clang -c main.c       # produces main.o
            $ clang main.o helper.o # produces a.out 沒有加 stage selection option，直接走到 linker；a.out 是 executable

        或合併成一個步驟：

            $ clang helper.c main.c # produces a.out

      - Object file (`.o`) "幾乎是" full exectuable，內含 machine code (還需要經過 relocation)、symbol table (記錄有 variables & functions 這些 symbole 的 address) 及其他資訊。注意 symbol table 裡的 address 不一定是在最終 executable 裡的 address，因為還會經過 relocation，而那正是 linker 的工作。
      - 分別觀察 `clang main.c` 與 `clang helper.c` 的輸出 (刻意不加 `-c`，直接走到 linking)，有助於瞭解 object file、symbols：

            $ clang main.c
            Undefined symbols for architecture x86_64:
              "_helper", referenced from:
                  _main in main-586572.o  <-- 想要 link，但發現有個 undefined symbol，在所有 object file 裡都找不到
            ld: symbol(s) not found for architecture x86_64  <-- 錯誤由 linker (ld) 丟出
            clang: error: linker command failed with exit code 1 (use -v to see invocation)

            $ clang helper.c
            Undefined symbols for architecture x86_64:
              "_main", referenced from:  <--  沒有解析不出來的 symbol? 因為要做為 exectuable 的關係，要有 main() 才行
                 implicit entry/start for main executable
            ld: symbol(s) not found for architecture x86_64
            clang: error: linker command failed with exit code 1 (use -v to see invocation)

        事實上 `helper.c` 有用到 `puts` 這個來自 `stdio.h` 的 symbol，為什麼不會跳 undefined symbol 的錯誤? 那是因為 C compiler 預設會動態連結 C runtime (`libc`) 的關係。實驗發現，加 `-nostdlib` 就可以引發 undefined symbol 的錯誤：

            $ clang -nostdlib helper.c
            Undefined symbols for architecture x86_64:
              "_main", referenced from:
                 implicit entry/start for main executable
              "_puts", referenced from:
                  _helper in helper-2d46e7.o
            ld: symbol(s) not found for architecture x86_64
            clang: error: linker command failed with exit code 1 (use -v to see invocation)

      - 上面的問題源自，`main.o` 裡用到的 `helper` 在 `helper.o` 裡，可以用 `nm` -- display name list (symbol table) 來觀察不同 object file 分別定義了哪些 symbol，又用到了哪些外部的 symbol。

            $ nm -p helper.o main.o a.out

            helper.o:
            0000000000000000 T _helper <--+
                             U _puts      |
                                          |
            main.o:                       |
            0000000000000000 T _main      |
                             U _helper ---+

            a.out:
            0000000100000000 T __mh_execute_header
            0000000100000f70 T _helper <---+
            0000000100000f60 T _main   ----+
                             U _puts
                             U dyld_stub_binder

        每一行都是空白隔開的 address、type 跟 symbol name (macOS 會在前面加底線)。Type `U` 表示 undefined (有用到，但不是宣告在這個 object file 裡)，`T` 則表示 text section symbol (即 code section)`。

        很明顯地，原先 `main.o`、`help.o` 裡 text section symbol 前面的 address/value 都是 0 -- 只是個 placeholder，在 link 的過程中就會被代換掉 (the addresses are PLACEHOLDERS in object files, and final in executables)，這就是前面所說的 relocation -- when the linker performs RELOCATION on the object files, combining them into a final executable, it goes through PLACEHOLDERS of addresses and fills them in.

      - 可以用 `strip` 將 executable 裡的 symbol 拿掉，雖然檔案會小一點點，但會造成 stack trace 無法閱讀 (不完全是壞事)

            $ strip a.out
            $ nm -p a.out
            0000000100000000 T __mh_execute_header
                             U _puts           <-- 原先的 _helper 跟 _main 都不見了
                             U dyld_stub_binder

      - 在做 link 時若搭配 `-g` (generate debug information) 會額外產生 debug symbols -- 保留所有 symbol 的 filename 及 line number；但 `a.out.dSYM/` 是做什麼的??

            $ clang main.c helper.c && nm -a a.out
            0000000100000000 T __mh_execute_header
            0000000100000f70 T _helper
            0000000100000f60 T _main
                             U _puts
                             U dyld_stub_binder

            $ clang -g main.c helper.c && nm -a a.out
            0000000000000000 - 01 0000    SO <-- 字母 - 表示 debug symbol
            0000000000000000 - 01 0000    SO
            000000000000000f - 00 0000   FUN
            000000000000000f - 01 0000 ENSYM
            000000000000001d - 00 0000   FUN
            000000000000001d - 01 0000 ENSYM
            0000000100000f60 - 01 0000 BNSYM
            0000000100000f70 - 01 0000 BNSYM
            0000000000000000 - 00 0000    SO /tmp/c/
            0000000000000000 - 00 0000    SO /tmp/c/
            000000005be59a6f - 03 0001   OSO /var/folders/1c/_3jhpxmn0cz8mbsf068f116h0000gp/T/helper-0d8d64.o
            000000005be59a6f - 03 0001   OSO /var/folders/1c/_3jhpxmn0cz8mbsf068f116h0000gp/T/main-88cd49.o
            0000000100000000 T __mh_execute_header
            0000000100000f70 - 01 0000   FUN _helper
            0000000100000f70 T _helper
            0000000100000f60 - 01 0000   FUN _main
            0000000100000f60 T _main
                             U _puts
                             U dyld_stub_binder
            0000000000000000 - 00 0000    SO helper.c
            0000000000000000 - 00 0000    SO main.c

      - 最後再次強調 Finding symbols to be placed into a final executable and relocating addresses are the main job of the linker.

  - [Object code \- Wikipedia](https://en.wikipedia.org/wiki/Object_code)
      - Object code/module 是 compiler 的產出 (通常就是 machine code，但還不是 executable)，這說法源自 the code is the GOAL or result of the compiling process, with some early sources referring to source code as a "SUBJECT program." 其中的 object 解釋成 "目的"，與解釋成 "題材" 的 subject 互為對照?
      - Object files can in turn be linked to form an executable file or library file. In order to be used, object code must either be placed in an executable file, a library file, or an object file. 這句話有點難懂? 先確認 object code 就是 RELOCATABLE format machine code，可以放在 object file 做為 compiler 的產出，之後經過 linker 做 relocation 併進 executable file 或 library file。
      - Object code is a portion of machine code that has not yet been linked into a complete program. ... It may also contain placeholders or OFFSETs, not found in the machine code of a completed program, that the linker will use to connect everything together. Whereas machine code is binary code that can be executed directly by the CPU, object code has the JUMPS PARTIALLY PARAMETERIZED so that a linker can fill them in. 還是 placeholder & fill in 的說法最容易懂
  - [Object file \- Wikipedia](https://en.wikipedia.org/wiki/Object_file) #ril
      - An object file is a file containing object code, meaning RELOCATABLE FORMAT MACHINE CODE that is usually NOT DIRECTLY EXECUTABLE. 這篇聚焦在 object file 本身的檔案格式，而 object code 只是其中的一部份而已。
      - In addition to the object code itself, object files may contain metadata used for linking or debugging, including: information to resolve SYMBOLIC CROSS-REFERENCES between different modules, RELOCATION information, stack unwinding information, comments, program symbols, debugging or profiling information.
      - 早期各系統有自己的 object file format，但後來一些像 COFF、ELF 的通用格式被用在不同的系統上；It is possible for the same file format to be used both as linker INPUT AND OUTPUT, and thus as the library and executable file format. 也難怪 `nm` (list symbols from object files) 這個工具也可以看 executable。
      - The design and/or choice of an object file format is a key part of overall system design. It affects the performance of the linker and thus programmer TURNAROUND while developing. If the format is used for executables, the design also affects the time programs take to begin running, and thus the RESPONSIVENESS for users. 做為 object file 的格式，會影響 linking 的速度，跟開發人員有關；若也用在 executable，則會影響程式啟動的速度，跟使用者的感受有關。
      - Most object file formats are structured as separate sections of data, each section containing a certain type of data. These sections are known as "segments" due to the term "memory segment" (所以 section/segment 都說得通), which was previously a common form of memory management. When a program is loaded into memory by a loader, the loader allocates various regions of memory. Some of these regions CORRESPOND to segments of the object file, and thus are usually known by the same names. 難怪概念上很像。
  - [Symbol table \- Wikipedia](https://en.wikipedia.org/wiki/Symbol_table) #ril
  - [compilation \- What's an object file in C? \- Stack Overflow](https://stackoverflow.com/questions/7718299/) #ril
      - cHao: object file 是 compilation phase 的產出，除了 machine code 
  - [linker \- How does C\+\+ linking work in practice? \- Stack Overflow](https://stackoverflow.com/questions/12122446/) #ril

## make, cc, gcc

`cc` 是 Unix 下 C compiler 的名稱，而 `gcc` 則是 GCC (GNU Compiler Collection) 下 C compiler 的名稱。通常 Linux distro 的 `cc` 都會指向 `gcc`。例如：

```
$ cc -o hello hello.c
```

至於為什麼 `make hello` 也可以編譯 `hello.c`，是因為 make 的 implicit rule 在作用，預設會採用 `cc`：

```
$ make hello
cc     hello.c   -o hello
```

參考資料：

  - [How to compile and run C/C\+\+ in a Unix console/Mac terminal? \- Stack Overflow](https://stackoverflow.com/questions/221185/) camh: 執行 `make foo` 即可，source code 可以是 `foo.c` 或 `foo.cpp` 等。甚至不需要 makefile，因為 make 內建把 source file 編譯成 executable (同名，但沒有副檔名) 的 rule?
  - [macos \- How to compile a C program with make on Mac OS X Terminal \- Stack Overflow](https://stackoverflow.com/questions/26409648/) kly 引用了 You don't need a Makefile 的說法。
  - [cc/gcc and why is there a difference?](https://ubuntuforums.org/showthread.php?t=1161860) 筆記寫 `gcc`，但參考書卻用 `cc`?
      - Nemooo: 大部份 Linux distro 的 `cc` 都是 `gcc`，比較一下 `cc --version` 跟 `gcc --version` 就知道 (版號相同)
      - k2t0f12d: `cc` 是 Unix 的 C compiler，而 `gcc` 是 GNU OS 的 C compiler，通常 GNU+Linux 將 `cc` 指向 `gcc`；傳統上，採用 `cc` 時表示會遵守某種標準及 CLI。
      - chuuk: 發現 `main() { printf("Hello World"); }` 可以用 `cc` 編，但 `gcc` 會失敗? 不過自己在 Ubuntu 及 macOS 上試過，都可以成功 compile 但會有 warning。之後 k2t0f12d 說明了這種現象 -- 就像 Bashi (Bourne Again SHell) 一樣，雖然 `sh` 指向 `bash`，但以 `sh` 執行時，會儘可能模擬 Bourne Shell 的行為，因此以 `cc` 執行 `gcc` 時也會模擬 `cc` 的行為，不過 chuuk 遇到的錯誤 k2t0f12d 也試不出來。
  - 在 Ubuntu 16.04.2 LTS 執行 `readlink -f `which cc`` 會得到 `/usr/bin/gcc-5`，證實了 `cc` 指向 `gcc` 的說法。
  - [c\+\+ \- Difference between CC, gcc and g\+\+? \- Stack Overflow](https://stackoverflow.com/questions/1516609/) #ril
  - [10 Using Implicit Rules - GNU make](https://www.gnu.org/software/make/manual/make.html#Using-Implicit-Rules)
      - 每個 implicit rule 都有 target pattern 與 prerequisite pattern 的概念，由於多個 implicit rule 可能有相同的 target pattern (例如 C compiler 的 `.o` 可以由 `.c` 產生、Pascal 的 `.o` 可以由 `.p` 產生)，所以會看誰的 prerequisite pattern 有符合的檔案存在，以決定要用哪個 implicit rule。
      - Make 內建 C compilation 的 implicit rule，當它發現有 `.c` 時，就會拿它來編譯並產生 executable。這些 implicit rule 的 recipe 會用到一些 variable，透過修改 variable 就能影響 implicit rule 的行為。
      - 10.2 Catalogue of Built-In Rules > Compiling C programs 提到 n.o is made automatically from n.c with a recipe of the form ‘$(CC) $(CPPFLAGS) $(CFLAGS) -c’. 雖然實際的輸出 `cc     hello.c   -o hello` 沒有最後的 `-c`，但在 makefile 裡 `$(CC)` 的值確實是 `cc` 沒錯。

            $ make --debug=v hello
            GNU Make 3.81
            Copyright (C) 2006  Free Software Foundation, Inc.
            This is free software; see the source for copying conditions.
            There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
            PARTICULAR PURPOSE.

            This program built for i386-apple-darwin11.3.0
            Reading makefiles...
            Updating goal targets....
            Considering target file `hello'.
             File `hello' does not exist.
              Considering target file `hello.c'.
               Finished prerequisites of target file `hello.c'.
              No need to remake target `hello.c'.
             Finished prerequisites of target file `hello'.
            Must remake target `hello'.
            cc     hello.c   -o hello <== 為什麼知道要用 cc ??
            Successfully remade target file `hello'.

## Make ??

  - [4.3 Types of Prerequisites - GNU make](https://www.gnu.org/software/make/manual/make.html#Types-of-Prerequisites) #ril

      - 出現 `$(OBJDIR)` 的用法，可以把 output 集中到一個資料夾下

            OBJDIR := objdir
            OBJS := $(addprefix $(OBJDIR)/,foo.o bar.o baz.o)

            $(OBJDIR)/%.o : %.c
                    $(COMPILE.c) $(OUTPUT_OPTION) $<

            all: $(OBJS)

            $(OBJS): | $(OBJDIR)

            $(OBJDIR):
                    mkdir $(OBJDIR)

## 參考資料 {: #reference }

相關：

  - Build tool 多數人推 [CMake](cmake.md)，但 [Make](make.md) 較單純
  - macOS 的 `cc` 指向 [Clang](clang.md)
  - [GCC (GNU Compiler Collection)](gcc.md)
