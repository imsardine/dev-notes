# GCC (GNU Compiler Collection)

  - [GCC Front Ends \- GNU Project \- Free Software Foundation \(FSF\)](https://gcc.gnu.org/frontends.html) GCC 由許多 frond end 組成，包括 C (`gcc`)、C++ (`g++`) 等 #ril
  - [GCC, the GNU Compiler Collection \- GNU Project \- Free Software Foundation \(FSF\)](https://gcc.gnu.org/) News 2018-01-25 ~ 2018-10-26 陸續出版了 GCC 7.3、8.1、8.2 及 6.5，感覺每個 major version 各自在發展中。

## 基礎

### Search Path ??

  - [The C Preprocessor: Search Path](https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html)
      - 就 `#include "file"` (quote form) 而言，preprocessor 會先從相對於目前檔案的位置找起，然後才是 standard system directories。例如 `/usr/include/sys/stat.h` 裡的 `#include "types.h"`，會優先找 `/usr/include/sys/types.h`。
      - 就 `#include <file>` (angle-bracket form) 而言，preprocessor 則只會在 standard system directories -- 這個 list 會因 target system、GCC 的組態而有不同；用 `cpp -v /dev/null -o /dev/null` 可以查看 default search directory list。
      - 有些 command-line option 可以增加 search path，最常用的是 `-I<DIR>`，會在安插在 current directory (就 quote form 而言) 之後，其他 standard system directories 之前，如果使用 `-I` 多次的話，則會由左而右依續找。如果要分開控制 quote form 與 angle-bracket form 的話，可以分開用 `-iquote` 或 `-isystem`。
      - 搭配 `-nostdinc` 則可以完全略過 default system (header) directories，用於編譯 OS kernel 或程式用不到 standard C library 時。
  - [Using the GNU Compiler Collection \(GCC\): Directory Options](https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html)

### Link ??

  - [Using the GNU Compiler Collection \(GCC\): Link Options](https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html) #ril
  - [gcc \-l \-L option flags for library link](https://www.rapidtables.com/code/linux/gcc/gcc-l.html) #ril
  - [How to Link Static Library in C/C\+\+ using GCC compiler? \| Technology of Computing](https://helloacm.com/how-to-link-static-library-in-cc-using-gcc-compiler/) (2016-11-27) #ril
  - [c\+\+ \- What is an undefined reference/unresolved external symbol error and how do I fix it? \- Stack Overflow](https://stackoverflow.com/questions/12573816/) #ril

### Environment Variable Substituion ??

  - [c\+\+ \- How do I use the C preprocessor to make a substitution with an environment variable \- Stack Overflow](https://stackoverflow.com/questions/2299824/) 透過 `gcc ... -D"THE_VERSION_STRING=${THE_VERSION_STRING}"` (`-D` 是 preprocessor option) #ril

## 參考資料 {: #reference }

  - [GCC, the GNU Compiler Collection](https://gcc.gnu.org/)

文件：

  - [Using the GNU Compiler Collection (GCC)](https://gcc.gnu.org/onlinedocs/gcc/) #ril

手冊：

  - [GCC Command Options](https://gcc.gnu.org/onlinedocs/gcc/Invoking-GCC.html) ([Summary](https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html))
      - [Preprocessor Options](https://gcc.gnu.org/onlinedocs/gcc/Preprocessor-Options.html)
      - [Code Gen Options](https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html)
      - [Link Options](https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html)
