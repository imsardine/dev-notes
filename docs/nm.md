# nm

  - [nm \(Unix\) \- Wikipedia](https://en.wikipedia.org/wiki/Nm_(Unix))

      - The `nm` command ships with a number of later versions of Unix and similar operating systems.
      - `nm` is used to EXAMINE BINARY FILES (including libraries, compiled object modules, shared-object files, and standalone executables) and to DISPLAY THE CONTENTS of those files, or META INFORMATION stored in them, specifically the SYMBOL TABLE.
      - The output from `nm` distinguishes between various SYMBOL TYPES. For example, it differentiates between a function that is supplied by an object module and a function that is required by it. `nm` is used as an AID FOR DEBUGGING, to help resolve problems arising from name conflicts and C++ NAME MANGLING, and to validate other parts of the toolchain.
      - The GNU Project ships an implementation of `nm` as part of the [GNU Binutils](https://www.gnu.org/software/binutils/) package.

## 新手上路 {: #getting-started }

  - [nm output sample - nm \(Unix\) \- Wikipedia](https://en.wikipedia.org/wiki/Nm_(Unix)#nm_output_sample)

      - 分別用 `gcc -c test.c` 與 `g++ -c test.cpp` 產生 `test.o`，只是 C 跟 C++ compiler 的結果會不太一樣，C++ 版本的 symbol table 名字很亂，因為 C+ compiler 會做 name mangling (為了達到 unique names) 的關係。

      - If the previous code is compiled with the gcc C compiler, the output of the nm command is the following:

            # nm test.o
            0000000a T global_function
            00000025 T global_function2
            00000004 C global_var
            00000000 D global_var_init
            00000004 b local_static_var.1255
            00000008 d local_static_var_init.1256
            0000003b T main
            00000036 T non_mangled_function
            00000000 t static_function
            00000000 b static_var
            00000004 d static_var_init

        無法顯示變數的初始值 ??

      - When the C++ compiler is used, the output differs:

            # nm test.o
            0000000a T _Z15global_functioni
            00000025 T _Z16global_function2v
            00000004 b _ZL10static_var
            00000000 t _ZL15static_functionv
            00000004 d _ZL15static_var_init
            00000008 b _ZZ15global_functioniE16local_static_var
            00000008 d _ZZ15global_functioniE21local_static_var_init
                     U __gxx_personality_v0
            00000000 B global_var
            00000000 D global_var_init
            0000003b T main
            00000036 T non_mangled_function

  - [man page nm section 1 - Mac OS X 10.12.6](http://www.manpagez.com/man/1/nm/osx-10.12.6.php) #ril

      - 在 macOS High Sierra (10.13.6) 執行 `man nm`，發現 man page 跟 FreeBSD 也不一樣，執行 `nm --reverse` 吐 `nm: Unknown command line argument '--reverse'.  Try: '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm -help'` 的錯誤，才發現它跟 Xcode 綁得很緊。
      - As of Xcode 8.0 the default `nm`(1) tool is `llvm-nm`(1). They for the most part have the same options except for `-f` and `-s` which the differences are noted below. More help on options for `llvm-nm`(1) is provided when running it with the `--help` option. 原來是 `llvm-nm`，但跟 [LLVM 官方文件](https://llvm.org/docs/CommandGuide/llvm-nm.html) 也差好多。
      - 列出 object file (`x.o`) 或 archive (`libx.a`) 裡每個 object file 的 name list (symbol table)；甚至寫成 `libx.a(x.o)` 則只會看 archive 裡的特定 object file。如果沒有給定 file，則會看 `a.out`。
      - 每一行都是一個 symbol，依序印出 value、type 跟 name，其中 type 若是 undefined 則 value 會是留白，而 type 若沒有使用 `-m` 則會用一個字母來表示 -- U (undefined)、A (absolute)、T (text section symbol)、D (data section symbol)、B (bss section symbol)、C (common symbol)、- (debugger symbol)、S (在上述 section 之外) 及 I (indirect symbol)；Symbol type 的字母有大小寫之分，大寫表示 external，小寫表示 local (non-external)。

  - [nm \(GNU Binary Utilities\)](https://sourceware.org/binutils/docs-2.31/binutils/nm.html) #ril
      - GNU `nm` lists the symbols from object files `objfile…`. If no object files are listed as arguments, `nm` assumes the file `a.out`.

## 參考資料 {: #reference }

手冊：

  - [`nm`(1) - Debian Manpages](https://manpages.debian.org/stretch/binutils/nm.1.en.html)
  - [`nm` - FreeBSD Manual Pages](https://www.freebsd.org/cgi/man.cgi?query=nm)
  - [`nm`(1) - Mac OS X 10.12.6](http://www.manpagez.com/man/1/nm/osx-10.12.6.php)
  - [`nm` - GNU Binary Utilities](https://sourceware.org/binutils/docs-2.31/binutils/nm.html#nm)
  - [`llvm-nm` - LLVM 8 Documentation](https://llvm.org/docs/CommandGuide/llvm-nm.html)
