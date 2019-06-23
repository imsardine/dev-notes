# Make

  - 根據 makefile，控制如何從 source files 產生 non-source files。
  - 可以描述 dependency，除了會影響執行順序之外，也會自動檢查哪些檔案因為 source 或 dependency 有變動而需要重新產生 (不用全部重新產生)。
  - 任何想自動化的事情都可以 (anything else you want to do often enough to make it worth while writing down how to do it)，不限定程序語言或特定用途，只要能用 shell commands 描述要做什麼。

參考資料：

  - [Make \- GNU Project \- Free Software Foundation](https://www.gnu.org/software/make/)
  - [Make \(software\) \- Wikipedia](https://en.wikipedia.org/wiki/Make_(software)) #ril
  - [make\(1\) \- Linux man page](https://linux.die.net/man/1/make) #ril
      - make 會自動決定一個 large program 裡有哪些需要 recompile。這裡用 C 說明，但任何支援 shell 用法的 compiler 都可以用 make。
      - 事實上，make 不只可以用在程式 -- any task where some files must be updated automatically from others whenever the others change，概念上就是 "自動"

## Hello, World!

`Makefile`:

```
# Environment variable `WHO` for customization
TO = $(or $(WHO), 'World')

hello: time
	echo Hello, $(TO)'!' # Inline comments passed to shell

time:
	@echo `date`
```

執行起來像是：

```
$ make
Tue Dec 19 08:05:14 CST 2017
echo Hello, 'World''!' # Inline comments passed to shell
Hello, World!
$
$ WHO=Jeremy make
Tue Dec 19 08:05:26 CST 2017
echo Hello, Jeremy'!' # Inline comments passed to shell
Hello, Jeremy!
```

從中可以觀察出：

  - `make` 會自動找當前目錄下的 `Makefile`。
  - `make [target]...` 預設會執行第 1 個 target。
  - 註解用 `#` 表示，但接在指令後的註解會傳給 shell，由 shell 決定如何處理。
  - `$(or $(WHO), 'World')` 的用法是 function - `$(function arguments)`。
  - 變數跟環境變數都用 `$(name)` 的方式引用。
  - `hello: time` 描述了相依性 `time`，所以 `hello` 前會先執行 `time`。
  - 指令要以 tab 內縮開頭，以 `@` 開頭的指令不會被印出來 (echoing)。

## Makefile ??

  - [2.2 A Simple Makefile - GNU make](https://www.gnu.org/software/make/manual/make.html#A-Simple-Makefile) #ril
  - [Appendix C Complex Makefile Example - GNU make](https://www.gnu.org/software/make/manual/make.html#Complex-Makefile) #ril
  - [Makefile \- Wikipedia](https://en.wikipedia.org/wiki/Makefile) #ril
  - [It’s time for makefiles to make a comeback – Coding Coda](https://codingcoda.com/2017/09/05/its-time-for-makefiles-to-make-a-comeback/) (2017-09-05) #ril
  - [該把 makefile 請回來了 – CQD – Medium](https://medium.com/@CQD/%E8%A9%B2%E6%8A%8A-makefile-%E8%AB%8B%E5%9B%9E%E4%BE%86%E4%BA%86-a092f9d2a36f) (2017-09-16) #ril

## Rule, Target, Recipe ??

  - [Make Rules and Targets - Make \- GNU Project \- Free Software Foundation](https://www.gnu.org/software/make/) Rule = `target:   dependencies ...` + `commands...`，也就是如何 build 出 target，為什麼有 "target file" 的說法?? #ril
  - [Recipe Echoing - GNU make](https://www.gnu.org/software/make/manual/make.html#Recipe-Echoing) 預設會將 recipe 印出來 (echoing)，可以用開頭的 `@` 抑制這個行為，例如 `@echo bla bla`。另外 `-n, --just-print, --dry-run, --recon` 會印出所有的 recipe (包括以 `@` 開頭者)，但不會真的執行 (就是 dry-run)。
  - [4.2 Rule Syntax - GNU make](https://www.gnu.org/software/make/manual/make.html#Rule-Syntax-1) `targets : prerequisites` 其中 `targets` 跟 `prerequisites` 都是 separated by whitespace #ril
  - [makefile \- How does "make" app know default target to build if no target is specified? \- Stack Overflow](https://stackoverflow.com/questions/2057689/) anon: 執行第一個不是以 `.` 開頭的 target #ril

## Phony Target

  - 實務上不需要將所有的 target 列在 `.PHONY: ...` 後面，只要在可能發生衝突的 target 前加上 `.PHONY: <target>` 即可。

參考資料：

  - [GNU make: Phony Targets](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html)
      - A phony target is one that is not really the name of a file; rather it is just a name for a recipe to be executed when you make an explicit request. 識別某個 target 就是個要做事情的 target，跟檔名無關 (phony 是口語上的 "假的")；除了避免跟檔名衝突之外，另一點是提昇效能。
      - 以 `clean: rm *.o temp` 為例，由於 `clean` (target) 不會建立 `clean` (file)，所以這個 target 每次都會執行 ... 這沒什麼問題，但如果一個名叫 `clean` 的檔案/目錄出現時，由於它沒有 prerequisites，所以 `clean` 總被視為 up-to-date，結果就是 `clean` target 不會被執行。為了避免這種問題，可以將它列為 `.PHONY` (special target) 的 prerequisites，這樣 `clean` target 不管 `clean` file/dir 是否存在，都會執行。
      - 這裡把 `.PHONY: clean` 寫在 `clean:` 前面好像不錯?
  - [Appendix C Complex Makefile Example - GNU make](https://www.gnu.org/software/make/manual/make.html#Complex-Makefile-Example) 用到許多 `.PHONY`，包括 `install`、`clean`、`dist` 等，都是以動詞命名。
  - [Search · filename:makefile \.phony](https://github.com/search?q=filename%3Amakefile+.phony&type=Code) `.PHONY` 被使用很多次，甚至寫在 target 之後。

## make 指令基本用法 ??

  - [make\(1\) \- Linux man page](https://linux.die.net/man/1/make) #ril
      - `make [ -f makefile ] [ options ] ... [ targets ] ...`

## Recipe 要以 Tab 開頭?

  - 因為早期 backward compatibility 的考量，每一個 recipe 都要以 tab 開頭沒錯 - TAB indented command lines。
  - Make 3.82 後加入了 `.RECIPEPREFIX` 這個 special variable，不過目前 macOS 10.13.1 (High Sierra) 只內建 Make 3.81。
  - 用 Vim 編輯 `Makefile` 時，按 Enter 換行預設會用 tab 內縮，雖然有設定 `set expandtab`，大概是 syntax highlighting 在作用? 不過

參考資料：

  - [Rules - Makefile \- Wikipedia](https://en.wikipedia.org/wiki/Makefile#Rules) 提到 "Note the use of meaningful indentation in specifying commands; also note that the indentation must consist of a single <tab> character."，至少要有一個 tab 這要求還真特別! (事實上是以 tab 開頭)
  - [Appendix B Errors Generated by Make - GNU make](https://www.gnu.org/software/make/manual/make.html#Errors-Generated-by-Make) "missing separator. Stop." 這樣的錯誤，通常是因為 recipe 用 space 內縮而非 tab，但 make 預會要求 "every line in the recipe must begin with a tab character"，除非用 `.RECIPEPREFIX` 自訂。
  - [Rules - Make \(software\) \- Wikipedia](https://en.wikipedia.org/wiki/Make_(software)#Rules) TAB indented command lines 的設計惹來許多批評 (跟一連串的 space 沒有 visual difference)，作者 Stuart Feldman 說明那是基於 backward compatibility 的考量，雖然早期並沒有多少使用者，很抱歉那就是 history。在 v3.82 後加入了 `.RECIPEPREFIX` 這個 special variable 可以自訂 recipe prefix。
  - [See the tabs in your file \| Vim Tips Wiki \| FANDOM powered by Wikia](http://vim.wikia.com/wiki/See_the_tabs_in_your_file) 可以搭配 `:set list` 與 `:set listchars=tab:\|\ ` 營造出效果。
  - [.RECIPEPREFIX - GNU make](https://www.gnu.org/software/make/manual/make.html#index-_002eRECIPEPREFIX-_0028change-the-recipe-prefix-character_0029) `.RECIPEPREFIX`  #ril

## Comment

  - [What Makefiles Contain - GNU make](https://www.gnu.org/software/make/manual/make.html#What-Makefiles-Contain) 以 `#` 開始的整行 (前面可能有些空白) 會被視為註解，也可以用在行內，不過解讀方式不同，例如 recipe 裡的註解會整個傳給 shell，就看 shell 如何處理 #ril

## Variable

  - [6 How to Use Variables - GNU make](https://www.gnu.org/software/make/manual/make.html#Using-Variables) #ril
      - Variable 用一個 name 來代表一個 value -- a string of text，可以在 makefile 的其他地方用 name 引用 variable，代換成背後的 value。
      - Variable 跟 function 一樣，在讀入 makefile 時就會展開，除非在 recipe 裡、variable definition (`=`) 的右側、`define` 的 body??
      - Variable name 可以由 `:#=` 或 whitespace 以外的字元組成 (區分大小寫)，但建議只用英數字及底線就好。另外以 `.` 及大寫字母開頭的變數可能會跟 make 自己 special varialbes 衝突，應該避免使用。
      - 建議內部用的變數只用小寫字母，將大寫字母保留給 (外部的) parameters 使用；這可能跟環境變數習慣用大寫有關? 但那常數怎麼辦? 或許是指 function 裡的變數吧??
  - [6.2 The Two Flavors of Variables - GNU make](https://www.gnu.org/software/make/manual/make.html#The-Two-Flavors-of-Variables) 說明 `=` 與 `?=` 的差別，後者是 conditional variable assignment，未定義時才會 assign #ril
  - [10.5.3 Automatic Variables - GNU make](https://www.gnu.org/software/make/manual/make.html#Automatic-Variables-1) #ril
  - [6.8 Defining Multi-Line Variables - GNU make](https://www.gnu.org/software/make/manual/make.html#Defining-Multi_002dLine-Variables) #ril
      - 另一種變數給值的方式是透過 `define` directive，由於允許 value 裡出現 newline (但 `endef` 前的 newline 不會被視為 value 的一部份)，可以用來定義 canned recipes。
      - `define` 後面除了變數名稱，只能有 assignment operator (預設是 `=`)，其餘都要寫在下一行，並以單獨一行的 `endef` 結束，例如 `define variable ... endef`。

## Exporting Variables ??

  - [5.7.2 Communicating Variables to a Sub-make - GNU make](https://www.gnu.org/software/make/manual/make.html#Communicating-Variables-to-a-Sub_002dmake)

      - Variable values of the top-level `make` can be passed to the sub-`make` through the environment by EXPLICIT REQUEST. These variables are defined in the sub-`make` as defaults, but they do not override variables defined in the makefile used by the sub-`make` unless you use the ‘`-e`’ switch (see Summary of Options).

        所謂 explicit request 指的是使用 `export` directive。

      - To PASS DOWN, or EXPORT, a variable, `make` ADDS THE VARIABLE AND ITS VALUE TO THE ENVIRONMENT for running each line of the recipe. The sub-`make`, in turn, uses the environment to initialize its table of variable values. See Variables from the Environment.

        注意這裡 variable 與 environment 的差別，往 subprocess 傳的方法就是透過 environment variables。

      - Except by explicit request, `make` exports a variable only if it is either DEFINED IN THE ENVIRONMENT INITIALLY or set on the command line, and if its name consists only of letters, numbers, and underscores. Some shells cannot cope with environment variable names consisting of characters other than letters, numbers, and underscores.

        來自 invoking environemnt 的 environment variables 本來就會往下傳。

      - The value of the `make` variable `SHELL` is not exported. Instead, the value of the `SHELL` variable from the INVOKING ENVIRONMENT is passed to the sub-`make`. You can force `make` to export its value for `SHELL` by using the `export` directive, described below. See Choosing the Shell.
      - The special variable `MAKEFLAGS` is always exported (unless you unexport it). `MAKEFILES` is exported if you set it to anything.
      - `make` automatically passes down variable values that were defined on the command line, by putting them in the `MAKEFLAGS` variable. See Options/Recursion.
      - Variables are not normally passed down if they were created by default by `make` (see Variables Used by Implicit Rules). The sub-`make` will define these for itself.

      - If you want to export SPECIFIC variables to a sub-`make`, use the `export` directive, like this:

            export variable …

      - If you want to prevent a variable from being exported, use the `unexport` directive, like this:

            unexport variable …

        In both of these forms, the arguments to `export` and `unexport` are expanded, and so could be variables or functions which expand to a (list of) variable names to be (un)exported.

      - As a convenience, you can define a variable and export it at the same time by doing:

            export variable = value

        has the same result as:

            variable = value
            export variable

      - You may notice that the `export` and `unexport` directives work in `make` in the same way they work in the shell, `sh`.

      - If you want all variables to be exported by default, you can use `export` by itself:

            export

        This tells `make` that variables which are NOT EXPLICITLY MENTIONED in an `export` or `unexport` directive should be exported. Any variable given in an `unexport` directive will still not be exported. If you use `export` by itself to export variables by default, variables whose names contain characters other than alphanumerics and underscores will not be exported unless specifically mentioned in an `export` directive.

      - The behavior elicited by an `export` directive by itself was the default in older versions of GNU `make`. If your makefiles depend on this behavior and you want to be compatible with old versions of `make`, you can write a rule for the special target `.EXPORT_ALL_VARIABLES` instead of using the `export` directive. This will be ignored by old makes, while the `export` directive will cause a syntax error.

        要相容於舊版的 make 才會用 `.EXPORT_ALL_VARIABLES`? 如果只想針對特定 target 才 export 要怎麼做??

        Likewise, you can use `unexport` by itself to tell make not to export variables by default. Since this is THE DEFAULT BEHAVIOR, you would only need to do this if `export` had been used by itself earlier (in an included makefile, perhaps). You cannot use `export` and `unexport` by themselves to have variables exported for some recipes and not for others. The last `export` or `unexport` directive that appears by itself determines the behavior for the ENTIRE RUN of `make`.

        看來要 export 哪些 varible 並不是在 `export` 當下決定的，`export`/`unexport` 只是調整模式，在呼叫 subprocess 的當下，才會決定哪些 variable 要以 environment variables 的型式傳進去。

      - As a special feature, the variable `MAKELEVEL` is changed when it is passed down from level to level. This variable’s value is a string which is the depth of the level as a decimal number. The value is ‘`0`’ for the top-level `make`; ‘`1`’ for a sub-`make`, ‘`2`’ for a sub-sub-`make`, and so on. The incrementation happens when `make` sets up the environment for a recipe.

        The main use of `MAKELEVEL` is to test it in a conditional directive (see Conditional Parts of Makefiles); this way you can write a makefile that behaves one way if RUN RECURSIVELY and another way if run directly by you.

      - You can use the variable `MAKEFILES` to cause all sub-`make` commands to USE ADDITIONAL MAKEFILES ??. The value of `MAKEFILES` is a whitespace-separated list of file names. This variable, if defined in the outer-level makefile, is passed down through the environment; then it serves as a list of extra makefiles for the sub-`make` to read before the usual or specified ones. See The Variable `MAKEFILES`.

## Target-specific Variable ??

  - [6.11 Target-specific Variable Values - GNU make](https://www.gnu.org/software/make/manual/make.html#Target_002dspecific-Variable-Values)
      - Variable 通常都是 global 的 -- 一旦過了 evaluation 就不會變 (除 automatic variables)，但 target-specific variable value 可以依 target 改變 variable 的值 -- 只在 target 內有效用。
      - 用法 `target ...: variable-assignment` (可以作用在多個 target?)，其中 variable assignment 可以是 `=`/`:=`/`::=`/`+=`/`?=` 各種型式，前面也可以加 `export`/`override`/`private` 等 keyword。由於 target-specific variable 的 priority 跟其他 variable 一樣低於 command line 給的值，除非有加 `override` keyword。
      - Target-specific variable 會作用在 prerequisites (及其 prerequisites)，例如 `prog: CFLAGS = -g` 與 `prog : prog.o foo.o bar.o`，`CFLAGS = -g` 也會作用在 `prog.o`/`foo.o`/`bar.o` 等 target，除非那些 target 又用自己的 target-specific variable (assignment) 覆寫。
  - 若單純要 export 某個變數呢? `target: export MYVAR` 行不通，但 `target: export MYVAR ?=` 用 variable-assignment 的語法就可以。

## Conditionals ??

  - [5.1 Recipe Syntax - GNU make](https://www.gnu.org/software/make/manual/make.html#Recipe-Syntax-1) 最後提到 conditional expression (`ifdef`、`ifeq` 等)，在 rule context 裡若是以 tab 做為開頭的話，會被視為 recipe 交給 shell；暗示著，rule 裡是可以用 `ifdef` 的。
  - [7 Conditional Parts of Makefiles - GNU make](https://www.gnu.org/software/make/manual/make.html#Conditionals) #ril
      - Conditional directive 可以根據 variable 的值 (跟常數或另一個 variable 比較)，決定要採納/忽略 makefile 的某個部份。
      - 看到 "a conditional" 才知道 conditional 也可以當名詞用，意思是 "條件句"，相對於 conditional，外面的稱做 unconditional。
      - ... conditionals work at the TEXTUAL LEVEL: the lines of the conditional are treated as part of the makefile, or ignored, according to the condition. This is why the larger syntactic units of the makefile, such as rules, may cross the beginning or the end of the conditional. 呼應了一開始 Conditionals control what make actually “SEES” in the makefile, so they cannot be used to control recipes at the time of execution. 的說法，也難怪在 Index of Concept 裡出現 "ifdef, expansion" 之類的說法。
      - 不能動態改變 recipe，但可以控制 rule context 下有哪些 recipes。下面的例子會判斷 `CC` 的值是否為 `gcc`，以決定 C compiler 的參數。

```
libs_for_gcc = -lgnu
normal_libs =

foo: $(objects)
ifeq ($(CC),gcc)
        $(CC) -o foo $(objects) $(libs_for_gcc)
else
        $(CC) -o foo $(objects) $(normal_libs)
endif
```

      - 一個 conditional 以 `ifeq` 做為開始、中間有 `else` (選用)、最後以 `endif` 結束。其中 `ifeq` directive 會比較放在括號裡的兩個參數 `(arg1,arg2)`，若兩者相等，就會採用 `ifeq` 跟 `else` 中間的部份，否則就採用 `else` 與 `endif` 中間的部份。
      - 完整的語法如下：其中 `else` 跟 `else conditional-directive` 可以有多個，但並非必要。共有 4 種 conditional directive -- `ifeq`/`ifneq`、`ifdef`/`ifndef`

```
conditional-directive-one
text-if-one-is-true
else conditional-directive-two
text-if-two-is-true
else
text-if-one-and-two-are-false
endif
```

## Sub-make ??

  - [3.6 Overriding Part of Another Makefile - GNU make](https://www.gnu.org/software/make/manual/make.html#Overriding-Part-of-Another-Makefile) 用 `%:` 來表示 any target，內部的 recipe 再用 `$(MAKE) -f Makefile $@` 轉向另一個 makefile；其中 `$@` 是一種 automatic variable，代表 The file name of the target。

  - [5.7 Recursive Use of make - GNU make](https://www.gnu.org/software/make/manual/make.html#Recursive-Use-of-make) #ril

      - 所謂 "recursive use of `make`" 是指在 makefile 調用 `make` 指令，可以應用在 subsystem 有各自的 makefile 時。出現 sub-make 與 top-level make 的說法。

            subsystem:
                    cd subdir && $(MAKE)

        或

            subsystem:
                    $(MAKE) -C subdir

        在 Make 3.81 上發現，`-C subdir` 確實會讀取 `subdir/Makefile`，但 CWD 似乎沒有變動??

      - 5.7.1 How the MAKE Variable Works 開頭強調 recursive make 不應該明確調用 `make` 而要透過 `$(MAKE)`。`$(MAKE)` 記錄著 top-level make 的位置 (例如 `/bin/make`)，這樣做可以確保 recursive make invocation 都用同一個 `make` binary。

  - [How to manually call another target from a make target? \- Stack Overflow](https://stackoverflow.com/questions/5377297/how-to-manually-call-another-target-from-a-make-target/5378242) mklement0: 呼叫另一個 target 用 `$(MAKE) -f $(THIS_FILE) other-target`，其中 `$(MAKE)` 確保同一個 `make` binary 被呼叫 #ril
  - [Makefile: use multiple makefiles \- Stack Overflow](https://stackoverflow.com/questions/17896751/) 出現 `-f somename.mk` 的手法 #ril
  - [MK - List of filename extensions \(M–R\) \- Wikipedia](https://en.wikipedia.org/wiki/List_of_filename_extensions_(M%E2%80%93R)#MK) 跟 Makefile 相關的副檔名有 `.mk`、`.mke`、`.mkg`、`.mak`。

## Function ??

  - 踩了幾次變數打錯名稱 (例如 `$(do_something_importan)`，但 runtime 也不會提醒 (`$(call do_something_importan)` 也一樣)。建議編寫 `Makefile` 時，搭配 `--warn-undefined-variables` 檢查，就會提醒 `Makefile:NN: warning: undefined variable 'do_something_importan'`，透過 `MAKEFLAGS=--warn-undefined-variables` 直接寫在 `Makefile` 裡當然更方便，避免未來犯蠢。

參考資料：

  - [Functions for Transforming Text - GNU make](https://www.gnu.org/software/make/manual/make.html#Functions) 只講 function 怎麼用，沒有提到如何自訂 #ril
  - [GNU make: Canned Recipes](https://www.gnu.org/software/make/manual/html_node/Canned-Recipes.html) 用 canned sequence (of commands) 來定義一個 variable，搭配 `$(variable)` 將它展開；裡面可以用 `$^` 與 `$@` 分別取得 target 與 dependencies #ril
  - [8.7 The call Function - GNU make: Call Function](https://www.gnu.org/software/make/manual/html_node/Call-Function.html) TOC 裡出現 "expand a user-defined function" 的說法 #ril
      - 雖說是 parameterized function，但實際上是把內含 complex expression 的 varialbe 展開 (use call to expand it)；難怪用 `define varialbe ... endef` 宣告，也難怪 Call Function 會被歸在 Functions for Transforming Text 底下
      - `$(call variable, param, param, ...)` 會將 `param` 依序指定給 temporary variable `$(1)`、`$(2)` 等，而 `$(0)` 則對應到 `variable`；雖然不一定要傳 param，但用 `$(call)` 不傳 param 沒有意義 -- 用 canned recipe 直接展開變數就好。
      - `reverse = $(2) $(1)` 搭配 `foo = $(call reverse, a, b)` 可以調換位置，所以 `foo` 的內容會是 `b, a`
      - 最後提到 It’s generally safest to remove all extraneous whitespace when providing parameters to call 發現用 `,` 拆分 params 且會保留空白，所以就別管 `$(call)` 好不好看了，把空白拿掉
  - [Define your own function in a Makefile \(Example\)](https://coderwall.com/p/cezf6g/define-your-own-function-in-a-makefile) 用 `define ... endef` 宣告 custom function，搭配 `$call(function, )` #ril
  - 實驗發現 (v3.81) 把 variable 宣告在 targets 下面也是可以的，這樣 `Makefile` 的可讀性會較高，尤其 `make` 預設會執行第一個 target。
  - [8.1 Function Call Syntax - GNU make](https://www.gnu.org/software/make/manual/make.html#Function-Call-Syntax) 不用 `$(call ...)? #ril
  - [makefile \- Can make warn me, when I use unset variables? \- Stack Overflow](https://stackoverflow.com/questions/14391650/) sirgeorge: Make 3.81 增加了 `--warn-undefined-variables`，另外也可以宣告在 Makefile 裡的 `MAKEFLAGS=...`，避免未來犯蠢。

## Environment Variable ??

  - 將 `command` 改成 `VAR=$(VAR) command` 可以
  - [Variables from the Environment - GNU make](https://www.gnu.org/software/make/manual/make.html#Variables-from-the-Environment) 環境變數一開始都會成為 make 的變數 (同名)，但如果 makefile 裡有明確指定的話就會被覆寫 #ril
  - [shell \- How to set environment variable in Makefile \- Stack Overflow](https://stackoverflow.com/questions/23843106/) 用 export? #ril
  - [5.7.2 Communicating Variables to a Sub-make - GNU make](https://www.gnu.org/software/make/manual/make.html#Communicating-Variables-to-a-Sub_002dmake) 提到 `export variable = value` 的用法，雖然在講 sub-make，但適用所有 external command 的呼叫 #ril

## Include

  - 檔名叫 `Makefile.settings` 好像不錯，暗示被引入的檔案其語法同 `Makefile`；範例叫 `Makefile.settings.sample`，可以準備多組 settings，再用 symbolic link 指向，例如 `ln -s Makefile.settings.dev Makefile.settings`。
  - `-include Makefile.settings` 用法，同時適用開發及 CI；開發時的設定來自 `Makefile.settings`，跑 CI 時的設定來自於環境變數，就 GitLab CI 而言，環境變數可以來自 `.gitlab-ci.yaml`，也可以是 CI/CD Settings > Secret variables。

參考資料：

  - [Including Other Makefiles - GNU make](https://www.gnu.org/software/make/manual/make.html#Including-Other-Makefiles)
      - `include [FILENAME]...` 可以將其他 makefile 插入現在的位置，可以用 shell file name pattern，裡面的 variable/function reference 也會展開，後面可以加 comment。
      - 通常用於多個 makefile 要共用 variable definitions 時。
      - 若 current directory 找不到檔案，會先從 `-I`/`--include-dir` 指定的目錄找，然後再找 `prefix/include` (通常是 `/usr/local/include`)、`/usr/gnu/include`、`/usr/local/include`、`/usr/include`
      - 若要引入的檔案可有可無，可以改用 `-include`。

## Check file existance ??

  - [How do I check if file exists in Makefile so I can delete it? \- Stack Overflow](https://stackoverflow.com/questions/5553352/) #ril

      - kenorb: Then you can use a `test` command to test if the file does exist, e.g.:

            test -f myApp && echo File does exist

          - `-f file` True if file exists and is a regular file.
          - `-s file` True if file exists and has a size greater than zero.

        or does not:

          - `test -f myApp || echo File does not exist`
          - `test ! -f myApp && echo File does not exist`

        The `test` is equivalent to `[` command.

            [ -f myApp ] && rm myApp   # remove myApp if it exists

        and it would work as in your original example. See: `help [` or `help test` for further syntax.

      - holms: It's strange to see so many people using shell scripting for this. I was looking for a way to use NATIVE MAKEFILE SYNTAX, because I'm writing this outside of any target. You can use the `wildcard` function to check if file exists:

            ifeq ($(UNAME),Darwin)
                SHELL := /opt/local/bin/bash
                OS_X  := true
            else ifneq (,$(wildcard /etc/redhat-release))
                OS_RHEL := true
            else
                OS_DEB  := true
                SHELL := /bin/bash
            endif

        Update:

        I found a way which is really working for me:

            ifneq ("$(wildcard $(PATH_TO_FILE))","")
                FILE_EXISTS = 1
            else
                FILE_EXISTS = 0
            endif

        不用 shell scripting 的話，才不會踩到跨平台的問題；不過 `test`/`[` 可以做更細部的判斷。

  - [Makefile \- Check if a file exists using wildcard function \- Humbug](http://www.humbug.in/2012/makefile-check-if-a-file-exists-using-wildcard-function/) #ril

## Self-documented Makefile (`make help`) ??

  - [Self\-Documented Makefile](https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html) (2016-02-29) #ril

      - 在 target 後面用 `##` 寫說明，還能避開 internal target。增加一個 `help` target 並將它設為 default，就可以用 `make [help]` 看說明

            .PHONY: help
            .DEFAULT_GOAL := help

            help:
                @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

  - [Running the build - Getting Started — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/quickstart.html#running-the-build)

      - Execute make without an argument to SEE WHICH TARGETS ARE AVAILABLE.

      - `sphinx-quickstart` 產生的 `Makefile` 像這樣：

            # You can set these variables from the command line.
            SPHINXOPTS    =
            SPHINXBUILD   = sphinx-build
            SOURCEDIR     = .
            BUILDDIR      = _build

            # Put it first so that "make" without argument is like "make help".
            help:
                @$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

            .PHONY: help Makefile

            # Catch-all target: route all unknown targets to Sphinx using the new
            # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
            %: Makefile
                @$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

        將 `help` 安排成第一個 target 的想法很不錯，跟 `make help` 的效果一樣。

  - [Automation and Make: Self\-Documenting Makefiles](https://swcarpentry.github.io/make-novice/08-self-doc/) #ril
  - [Ned Batchelder: Makefile help target](https://nedbatchelder.com/blog/201804/makefile_help_target.html) (2018-04-04) #ril
  - [Makefile help target \- Andrey Zhukov's Tech Blog](https://blog.sneawo.com/blog/2017/06/13/makefile-help-target/) (2017-06-13) 還加了 usage #ril
  - [Add a help target to a Makefile that will allow all targets to be self documenting](https://gist.github.com/prwhite/8168133) #ril
  - [Add a help target to a Makefile that will allow all targets to be self documenting](https://gist.github.com/rcmachado/af3db315e31383502660) #ril

## 如何在 Recipe 裡設定變數?

```
$ cat Makefile
hello:
	WHO=World
	echo 'Hello, $(WHO)!'

$ make
WHO=World
echo 'Hello, !'
Hello, !
```

顯然 `WHO=World` 沒有作用。改寫成 `$(eval WHO = World)` 就可以，這時候已經是 Make 的變數，而非 shell 的變數。

```
$ cat Makefile
hello:
	$(eval WHO=World)
	echo 'Hello, $(WHO)!'

$ make
echo 'Hello, World!'
Hello, World!
```

參考資料：

  - [makefile \- Can't assign variable inside recipe \- Stack Overflow](https://stackoverflow.com/questions/6519234/) 用 $(eval ...)` function，例如 `$(eval who = World)`。
  - [Variables in GNU Make recipes, is that possible? \- Super User](https://superuser.com/questions/790560/) grawity: 每一個 recipe line 起一個 shell process 執行，所以 shell 結束就消失了；另外提到 `.ONESHELL:` 可以要求 `make` 用一個 shell 來執行所有 recipe。
  - [5.3 Recipe Execution - GNU make](https://www.gnu.org/software/make/manual/make.html#Execution) 每一行 recipe 都會用 sub-shell 來執行，除非有 `.ONESHELL` 這個特殊的 target 存在；特別舉例設定 shell variable 或 `cd` 切換目錄，下一個 recipe 都不受影響。
  - [8.9 The eval Function - GNU make](https://www.gnu.org/software/make/manual/make.html#Eval-Function) `eval` 的結果固定是空字串 #ril

## Expansion ??

  - [8.13 The shell Function - GNU make](https://www.gnu.org/software/make/manual/make.html#The-shell-Function)

    The commands run by calls to the `shell` function are run WHEN THE FUNCTION CALLS ARE EXPANDED (see How make Reads a Makefile).

    之前踩到 `$(shell)` 的執行時機跟預期不符的問題：

        define exit
            exit $(shell cat $(exit_file))
        endef

        test: _test-run
            $(call exit)

    假設 `_test-run` 會更新 `exit_file` 的內容，原以為 `$(shell cat $(exit_file))` 會發生在 `_test-run` 之後，但似乎在那之前就發生了，所以無法反應最新的內容。

    可能跟 [Function Call Syntax - GNU make](https://www.gnu.org/software/make/manual/make.html#Function-Call-Syntax) 的一段話有關：

    > A function call resembles a variable reference. It can appear anywhere a variable reference can appear, and it is expanded using the SAME RULES AS VARIABLE REFERENCES.

    以及 [Using Variables in Recipes - GNU make](https://www.gnu.org/software/make/manual/make.html#Using-Variables-in-Recipes)：

    > The other way in which `make` processes recipes is by expanding any variable references in them (see Basics of Variable References). This occurs AFTER `make` HAS FINISHED READING ALL THE MAKEFILES AND THE TARGET IS DETERMINED TO BE OUT OF DATE; so, the recipes for targets which are not rebuilt are never expanded.

    似乎是說 target 在執行前，裡面的 variable reference (包含 function call) 就已經展開。

  - [3.7 How make Reads a Makefile - GNU make](https://www.gnu.org/software/make/manual/make.html#How-make-Reads-a-Makefile)

      - GNU `make` does its work in TWO DISTINCT PHASES. During the first phase it reads all the makefiles, included makefiles, etc. and INTERNALIZES ?? all the variables and their values, implicit and explicit rules, and constructs a DEPENDENCY GRAPH of all the targets and their prerequisites. During the second phase, make uses these internal structures to determine what targets will need to be REBUILT and to invoke the rules necessary to do so.

      - It’s important to understand this two-phase approach because it has a direct impact on HOW VARIABLE AND FUNCTION EXPANSION HAPPENS; this is often a source of some CONFUSION when writing makefiles. Here we will present a summary of the phases in which expansion happens for different constructs within the makefile.

        We say that expansion is IMMEDIATE if it happens during the FIRST PHASE: in this case `make` will EXPAND any variables or functions in that section of a construct as the makefile is PARSED. We say that expansion is DEFERRED if expansion is not performed immediately. Expansion of a deferred construct is not performed until either the construct appears later in an IMMEDIATE CONTEXT ??, or until the second phase.

        You may not be familiar with some of these constructs yet. You can reference this section as you become familiar with them, in later chapters.

    Variable Assignment

      - Variable definitions are parsed as follows:

            immediate = deferred
            immediate ?= deferred
            immediate := immediate
            immediate ::= immediate
            immediate += deferred or immediate
            immediate != immediate

            define immediate
              deferred
            endef

            define immediate =
              deferred
            endef

            define immediate ?=
              deferred
            endef

            define immediate :=
              immediate
            endef

            define immediate ::=
              immediate
            endef

            define immediate +=
              deferred or immediate
            endef

            define immediate !=
              immediate
            endef

      - For the append operator, `+=`, the right-hand side is considered immediate if the variable was previously set as a simple variable (`:=` or `::=`), and deferred otherwise.

      - For the SHELL ASSIGNMENT operator, `!=`, the right-hand side is evaluated immediately and HANDED TO THE SHELL. The result is stored in the variable named on the left, and that variable becomes a SIMPLE VARIABLE (and will thus be RE-EVALUATED ON EACH REFERENCE ??).

        為什麼 simple variable 反而每次存取時都要 re-evaluate ??

    Conditional Directives

      - Conditional directives are parsed immediately. This means, for example, that automatic variables cannot be used in conditional directives, as automatic variables are not set until the recipe for that rule is invoked. If you need to use automatic variables in a conditional directive you must move the condition into the recipe and use SHELL CONDITIONAL SYNTAX instead. ??

    Rule Definition

      - A rule is always expanded the same way, regardless of the form:

            immediate : immediate ; deferred
                    deferred

        That is, the target and prerequisite sections are expanded immediately, and the recipe used to construct the target is always deferred. This general rule is true for explicit rules, pattern rules, suffix rules, static pattern rules, and simple prerequisite definitions.

## 參考資料 {: #reference }

  - [Make \- GNU Project \- Free Software Foundation](https://www.gnu.org/software/make/)
  - [CMake](https://cmake.org/)

社群：

  - ['makefile' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/makefile)

文件：

  - [GNU make](https://www.gnu.org/software/make/manual/html_node/index.html)
   ([single page](https://www.gnu.org/software/make/manual/make.html))

手冊：

  - [Index of Functions, Variables, & Directives - GNU make](https://www.gnu.org/software/make/manual/make.html#Index-of-Functions_002c-Variables_002c-_0026-Directives)
  - [GNU make: Options Summary](https://www.gnu.org/software/make/manual/html_node/Options-Summary.html)
  - [Ubuntu Manpage: make](http://manpages.ubuntu.com/manpages/xenial/man1/make.1.html)
  - [make(1) - FreeBSD](https://www.freebsd.org/cgi/man.cgi?make(1))
  - [make(1) - die.net](https://linux.die.net/man/1/make)
  - [Expansion of Immediate/Deferred Constructs](https://www.gnu.org/software/make/manual/html_node/Reading-Makefiles.html)
