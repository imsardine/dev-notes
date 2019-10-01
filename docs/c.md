# C

  - [C \(programming language\) \- Wikipedia](https://en.wikipedia.org/wiki/C_(programming_language)) #ril

  - [Learn to code using the C programming language on your Mac \- Macworld UK](https://www.macworld.co.uk/how-to/mac/learn-c-in-mac-os-x-3639920/) (2016-05-26)

      - The C programming language has been around since the 1970s, but it has NEVER GONE OUT OF STYLE, and learning C is one of the best computer skills you can acquire. Mac OS X comes with C built into it, and Apple has used C while making every aspect of OS X and iOS.

      - Because C is such a popular language, it even forms the basis of many other programming languages, including two big names: C++ and Objective-C. And even though Apple is migrating from Objective-C to Swift, guess what languages Apple used to build Swift? Throughout the Swift code, you'll find C and C++ files.

        雖然 Apple 正把 Objective-C 往 Swift 遷移，但 Swift 本身就是 C 跟 C++ 寫的。

      - You're almost SURE NEVER TO USE C PROFESSIONALLY, but learning it is a rite of passage for programmers. The C programming language has influenced many other languages. Learning C enables you to UNDERSTAND WHAT'S GOING INSIDE A COMPUTER IN GENERAL.

      - C is also a curious creature, in that it's a HIGH-LEVEL language (these are the easy ones to understand), but with LOW-LEVEL elements (so-called because they are "close to the metal").

        The C syntax is similar to many modern programming languages. However, you have to learn how to allocate memory, free up memory to prevent leaks and use memory addresses and pointers (memory blocks that point to other memory blocks). All of this memory management will most likely drive you to tears at some point, but it's superb for understanding what a programming language is doing.

        This complexity is why C is used in courses such as Harvard's CS50: Introduction to Computer Science. More modern languages, like Python, take care of memory for you; which is better for day-to-day use, but not as good educationally.

        C 屬於高階語言 (high-level language)，但有許多低階的操作，尤其是要自己做記憶體管理，許多語言像 Python 已經幫你把記憶體的管理處理掉，使得 C 更適合拿來做為教材，讓你瞭解電腦內部的運作；Harvard's CS50 就是用 C 做為教材。

  - [C Programming/Why learn C? \- Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/C_Programming/Why_learn_C%3F) #ril
      - C 最常被拿來寫 OS，最早是 Unix，然後是 Windows, Mac OS X, GNU/Linux。另外，許多 high-level languages 本身也都是用 C 寫的 (Perl, PHP, Python...)
      - Assembly language 強調的是 speed 跟 maximum control (但每個 device/architecture 之間的 assembly language 並不相容)，而 C 則在上面疊加了 portability 但又能維持住 performance。
      - 有 "what you see is all you get" 一說，因為 C statement 直接跟少量的 assembly statements 對應。
      - OS 用 C 寫，很自然地 high-level libraries (OpenGL, GTK 等) 大部份也會用 C 寫，之後特別要求效能的應用 (game, media players 等) 也會用 C 來寫 ... (pattern)
  - [C Programming/History \- Wikibooks, open books for an open world](https://en.wikibooks.org/wiki/C_Programming/History) #ril
      - UNIX 的 portability 讓 UNIX 跟 C 變得流行 (因為 UNIX 是用 C 寫的)
      - 只要為系統特有的部份寫一段程式，再搭配該系統的 C compiler，就可以讓程式執行在不同的系統上。
  - Chapter 1: Getting Started - Let Us C, 5th Edition (2004.) #ril
      - 每個語言都有 4 個面向 -- 如何儲存資料、如何操作資料、如何處理 input/output、如何控制程式的執行順序。
      - C 在 1972 由 Dennis Ritchie 在 AT&T Bell 實驗室發展出來，在 70 年代後期 C 開始取代其他常見的語言 (例如 PL/I、ALGOL 等)，沒有任何推廣，所以 Ritchie 自己也很意外；可能是它 reliable、simple 及 easy to use 的特性。
  - [1. 千里之行始於足下 - 歐萊禮 - 深入淺出 C]([博客來\-深入淺出 C](http://www.books.com.tw/products/0010564017)) (2012-11) p2. 被應用在重視速度、空間和可攜性 (portability) 的地方，多數的作業系統跟程式語言都用 C 寫，大多數的遊戲更是。
  - [旗標 - C 語言教學手冊 (第四版)](http://www.books.com.tw/products/0010360466) (2007-04) p1-4 C 語言具有低階語言的優點 (對硬體的控制能力佳)，同時兼顧了高階語言的特色 (易於撰寫、除錯)，有人稱之為 "中階語言"，此外 C 可以很容易與組合語言連結。

### 為什麼要學 ??

  - 由於 OS 底層是 C 的關係，其他語言也是在外層包裝，學習 C 有助於瞭解底層的高階包裝。
  - Chapter 1: Getting Started - Let Us C, 5th Edition (2004.)
      - 常聽到 "C 已經被 C++、C# 和 Java 接替，為什麼還要學 C"，除了先用 C 打好基礎、OS/kernel/driver 用 C 寫的事實、適合資源受限的 microprocessor，作者大部份的理由都是 "C 的效能無人能及"，但相對 C++ 也是嗎?

### 跟 C++ 的關係 ??

  - [Advantages of C over C\+\+ – The Bit Theories](https://thebittheories.com/advantages-of-c-over-c-f31f61873997) (2016-07-21) #ril
      - 許多人宣稱 C++ 比 C 好，但有些人不這麼認為；但都認同有些 C 的經驗後，可以切到 C++，因為在寫 C 的同時，可以用到 C++ 的東西。
      - 作者列出一些 C 比 C++ 好的幾個點，包括 less runtime support、更適用於 kernel/driver development 等...
  - [Should You Learn C Or C\+\+ First? \| Software Specialists](http://www.ssipeople.com/2015/04/28/which-should-you-learn-first-c-or-c/) #ril
  - [Why would anybody use C over C\+\+? \- Stack Overflow](https://stackoverflow.com/questions/497786/) #ril
  - [When to use C over C\+\+, and C\+\+ over C? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/113295/) #ril
  - [What are the fundamental differences between C and C\+\+? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/16390/) #ril
  - [What are the advantages of using C over C\+\+? \- Quora](https://www.quora.com/What-are-the-advantages-of-using-C-over-C-1) #ril
  - [Compatibility of C and C\+\+ \- Wikipedia](https://en.wikipedia.org/wiki/Compatibility_of_C_and_C%2B%2B) #rl

## Hello, World!

```
$ vi hello.c
$ make hello
cc     hello.c   -o hello

$ ./hello
Hi, my name is Judy, and I'm 15 years old.
```

`hello.c`:

```
#include <stdio.h>

int main() {
    int age = 15;
    char name[] = "Judy";
    printf("Hi, my name is %s, and I'm %d years old.\n", name, age);

    return 0;
}
```

參考資料：

  - [How to set up C in OS X - Learn to code using the C programming language on your Mac \- Macworld UK](https://www.macworld.co.uk/how-to/mac/learn-c-in-mac-os-x-3639920/#toc-3639920-2) (2016-05-26)

      - Like Python, it's easy to set up C in OS X. Mostly because it's already packaged in the system and you don't need to install anything.

      - There are multiple standards for C, and the two you'll come across most are C99 and C11. As a newcomer, you don't need to worry too much about these, and you'll almost certainly learn C99 then discover the new features in C11.

        只要知道 C11 (2011) 比 C99 (1999) 新就好。

      - C differs from other programming languages, like Python, in that you need to compile programs before you can run them. You'll typically do this in C using the command "`make`". C programs end with the "`.c`" extension, and you'll run `make` to build a second file, that is the compiled program. The compiled file is what you run.

            #include <stdio.h>
            #import

            int main() {
                printf("Hello, World!\n");
                return 0;
            }

        執行 `make hello` 即可完成編譯。

            $ make hello
            cc     hello.c   -o hello
            $ ./hello
            Hello, World!
            $ ls -l hello
            -rwxr-xr-x  1 jeremykao  wheel  8432 Apr 27 08:41 hello

        小小的 `hello.c` 編出來有 8432 bytes，是因為 `stdio.h` 整個包進去了嗎??

## 新手上路 {: #getting-started }

  - 大朋友可以從 C Programming Language, 2nd Edition 下手。
  - Head First C 好像很適合小朋友? 寫作風格很活潑；在那之前還可以先看過 Head First Programming。

參考資料：

  - `long long` 是什麼?
    * c - What kind of data type is "long long"? - Stack Overflow http://stackoverflow.com/questions/2127473/ C99 是 integer，但至少要 64-bits。
    * types - long long in C/C++ - Stack Overflow http://stackoverflow.com/questions/1458923/ `long long` 的 literal 要加後綴 `LL`，例如 `long long num = 123LL`。

  - 預設是 signed?? 跟 `short`/`long` 一起使用時的順序??
      - c - Is the integer constant's default type signed or unsigned? - Stack Overflow http://stackoverflow.com/questions/11310456/ Integer constant 沒有 suffix 時要視為 signed int 或 unsigned int? ouah 提到 decimal/octal/hexadecimal 的規則不同，但概念上都是 "first type the value can fit in"；就 decimal constant 而言，依序是 `int`, `long`, `long long`，而 hexadecimal 依序是 `int`, `unsigned int`, `long`, `unsigned long`, `long long`, `unsigned long long` (主要都是 `unsigned`) ... 不過這還是沒有回答問題。
      - language agnostic - Default int type: Signed or Unsigned? - Stack Overflow http://stackoverflow.com/questions/1555154/ #ril

  - C Programming Boot Camp http://gribblelab.org/cbootcamp/ #ril
  - Learn c in Y Minutes https://learnxinyminutes.com/docs/c/ 跳太快? 看了一些就開始卡了... #ril
  - C for Python Programmers http://www.toves.org/books/cpy/ #ril
  - C and C++ for Java Programmers - Cprogramming.com http://www.cprogramming.com/java/c-and-c++-for-java-programmers.html #ril

  - [Which book is best for learning C programming by a beginner? \- Quora](https://www.quora.com/Which-book-is-best-for-learning-C-programming-by-a-beginner) 最常出現的是 The C Programming Language、Let Us C、Head First C 及 Programming in ANSI C。
      - Jack Sparrow: The C Programming Language、C Programming: A Modern Approach、C Programming in 12 Easy Lessons、C for Dummies、C for Dummies Vol. II
      - Geet Gobind Singh: Let Us C、Pointers in C、Test Your C Skills、The C Programming Language (前 3 本都是 Yashwant Kanetkar 的書)
      - Mohammed Raiyyan: Let Us C、
      - Subhomoy Haldar: ANSI C、Let Us C、Programming in C、The C reference Guide、Head First C、C: How to Program
      - Vinod Chuahan: Let Us C、Head First C
      - Kamal Rana: Let Us C、The C Programming Language
      - Ankit Bhasker: The C Programming Language、C: The Complete Reference、Programming in ANSI C、Let Us C、Head First C
      - Bhairab Changkakoty: Head First C
      - Shubham Yadav: Let Us C、The C Programming Language
      - Kumar Subham: Programming in ANSI C
      - Shrinath Bhosale: Head First C
      - SANUJ BHADRA: Let Us C、Programming in ANSI C

## ANSI, C99, C11 ??

  - C 有許多標準，差別是什麼??
      - Learn to code using the C programming language on your Mac - How to - Macworld UK (2016-05-26) http://www.macworld.co.uk/how-to/mac/learn-c-in-mac-os-x-3639920/ 最常見的是 C99 跟 C11，初學者主要是從 C99 開始，然後慢慢接觸 C11 的新功能。
  - 跨平台 (portable) 是透過在不同平台上重新 compile。
  - [1. 千里之行始於足下 - 歐萊禮 - 深入淺出 C]([博客來\-深入淺出 C](http://www.books.com.tw/products/0010564017)) (2012-11) p2. 有 3 種語言標準 (C standard)，ANSI C 來自 80 年代後期，1999 的 C99 有許多修正，2011 年的 C11 添加了許多酷炫的功能；版本間的差異其實不太。

參考資料：

  - [C99 \- Wikipedia](https://en.wikipedia.org/wiki/C99) #ril

## Debugging ??

  - [An introduction to Debugging \(in C and lldb\), Part\- I](https://towardsdatascience.com/an-introduction-to-debugging-in-c-and-lldb-part-i-e3c51991f83a) (2018-08-15) #ril

## C Standard Library

  - C standard library - Wikipedia https://en.wikipedia.org/wiki/C_standard_library #ril
  - Standard Library 的文件要去哪裡查? 拿 `stdio.h` 裡的 `printf` 就好 => http://en.cppreference.com/w/c/io/fprintf

## 慣例

  - 習慣內縮幾格??
      - http://www.macworld.co.uk/how-to/mac/learn-c-in-mac-os-x-3639920/ 建議用 4 格 (除非別人的專案已經用了 tab)，但不要混用 space 跟 tab 就好。

## 安裝設定 {: #installation }

### macOS

  - [How to set up C in OS X - Learn to code using the C programming language on your Mac \- Macworld UK](https://www.macworld.co.uk/how-to/mac/learn-c-in-mac-os-x-3639920/#toc-3639920-2) (2016-05-26)

      - Open terminal and enter `clang --version`. Clang is the compiler built by Apple to compile C and A BUNCH OF OTHER LANGUAGES. We get Apple LLVM version 7.3.0 (clang-703.0.29) but whatever version you're using is good enough to compile beginner's code.

        為什麼這裡講 Clang，但下面又用 `make` -- 背後走 `cc`? 因為 `cc` 在 macOS 上指向 Clang

            $ ls -l `which cc`
            lrwxr-xr-x  1 root  wheel  5 Mar 30 15:28 /usr/bin/cc -> clang

        Clang 不是裝了 Command Line Tool 才有的 ??

  - [Exercise 0: The Setup - Learn C The Hard Way](http://c.learncodethehardway.org/book/ex0.html) - Mac OS X 上要安裝 Xcode #ril

## 參考資料

  - [Learn C and C++ Programming - Cprogramming.com](https://www.cprogramming.com/)
  - [Learn C - Free Interactive C Tutorial](http://www.learn-c.org/)
  - [Online C Compiler](http://www.tutorialspoint.com/compile_c_online.php)

社群：

  - ['c' Questions - Stack Overflow](http://stackoverflow.com/questions/tagged/c)

更多：

  - [Programming](c-programming.md)
  - [Data Type](c-type.md)
  - [Pointer](c-pointer.md)
  - [Build Process](c-build.md)
  - [Preprocessing](c-preprocess.md)
  - [Library](c-library.md)
  - [Random](c-random.md)

書籍：

  - [C Programming - Wikibooks](http://en.wikibooks.org/wiki/C_Programming)
  - [Learn C The Hard Way](http://c.learncodethehardway.org/book/) (Online)
  - [India Professional - Programming in ANSI C](https://www.amazon.com/Programming-Ansi-C-Balagurusamy/dp/933921966X) (2016-12)
  - [Apress - Pointers in C](http://www.apress.com/9781430259114) (2013-12)
  - [Apress - Advanced Topics in C](http://www.apress.com/9781430264002) (2013-11)
  - [Addison-Wesley - C Primer Plus, 6th Edition](http://www.informit.com/store/c-primer-plus-9780321928429) (2013-11)
  - [Apress - Cryptography in C and C++](http://www.apress.com/9781430250982) (2013-07)
  - [O'Reilly - Understanding and Using C Pointers](http://shop.oreilly.com/product/0636920028000.do) (2013-05)
  - [Packt - C Programming for Arduino](http://www.packtpub.com/c-programming-arduino/book) (2013-05)
  - [Apress - Beginning C, 5th Edition](http://www.apress.com/9781430248811) (2013.03)
  - [Apress - Learn C on the Mac, 2nd Edition](http://www.apress.com/9781430245339) (2013-01)
  - [Apress - Beginning C for Arduino](http://www.apress.com/9781430247760) (2012-12)
  - [歐萊禮 - 深入淺出 C]([博客來\-深入淺出 C](http://www.books.com.tw/products/0010564017)) (2012-11)
  - [O'Reilly - Head First C](http://shop.oreilly.com/product/0636920015482.do) (2012.04)
  - [Apress - Embedded Software Development with C](http://www.apress.com/9781441906052) (2009-07)
  - [Apress - Learn C on the Mac](http://www.apress.com/9781430218098) (2008-12)
  - [旗標 - C 語言教學手冊 (第四版)](http://www.books.com.tw/products/0010360466) (2007-04)
  - [O'Reilly - C in a Nutshell](http://shop.oreilly.com/product/9780596006976.do) (2005-12)
  - [Sams - C Primer Plus, 5th Edition](http://www.informit.com/store/c-primer-plus-9780672326967) (2004.11)
  - BPB - Let Us C, 5th Edition (2004.)
  - [Sams - Programming in C, 3rd Edition](http://www.informit.com/store/programming-in-c-9780672326660) (2004-07)
  - [O'Reilly - Secure Programming Cookbook for C and C++](http://shop.oreilly.com/product/9780596003944.do) (2003-07)
  - [O'Reilly - C Pocket Reference](http://shop.oreilly.com/product/9780596004361.do) (2002-11)
  - [MHE - Programming in ANSI C, 6th Edition](https://www.amazon.com/Programming-ANSI-C-BALAGURUSAMY/dp/1259004619) (2000)
  - [O'Reilly - Practical C Programming, 3rd Edition](http://shop.oreilly.com/product/9781565923065.do) (1997-08)
  - [Prentice Hall - Expert C Programming](http://www.informit.com/store/expert-c-programming-9780131774292) (1994-06)
  - [Addison Wesley - The C Book](http://publications.gbdirect.co.uk/c_book/) (1991, Online)
  - [O'Reilly - Using C on the UNIX System](http://shop.oreilly.com/product/9780937175231.do) (1989-01)
  - [Prentice Hall - C Programming Language, 2nd Edition](https://www.amazon.com/Programming-Language-2nd-Brian-Kernighan/dp/0131103628) (1988.04)

  - The C Programming Language - Wikipedia https://en.wikipedia.org/wiki/The_C_Programming_Language #ril
  - C Programming - Wikibooks, open books for an open world https://en.wikibooks.org/wiki/C_Programming #ril
  - C Tutorial https://www.tutorialspoint.com/cprogramming/ #ril
  - free-programming-books/free-programming-books.md at master · vhf/free-programming-books https://github.com/vhf/free-programming-books/blob/master/free-programming-books.md#c #ril

相關：

  - macOS 內建 [Clang](clang.md) 支援 C 相關的開發

手冊：

  - [C Reference - cppreference.com](http://en.cppreference.com/w/c)
  - [`sizeof`](sizeof operator - cppreference.com http://en.cppreference.com/w/c/language/sizeof)

