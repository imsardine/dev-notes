# Command Line Interface (CLI)

  - [Command\-line interface \- Wikipedia](https://en.wikipedia.org/wiki/Command-line_interface) #ril

## Command, Subcommand, Argument, Parameter, Global/Subcommand-specific Option ??

  - [Anatomy of a shell CLI - Command\-line interface \- Wikipedia](https://en.wikipedia.org/wiki/Command-line_interface#Anatomy_of_a_shell_CLI) #ril
      - CLI 通常符合 `prompt command param1...paramN` 的樣式，其中 `param1...paramN` 是 OS 會傳給 command 的 (optional) parameters，區分為 argument 與 option。
  - [Parameters and arguments - Parameter \(computer programming\) \- Wikipedia](https://en.wikipedia.org/wiki/Parameter_(computer_programming)#Parameters_and_arguments) 通常 parameter 是指 function definition 中的 variable，而 argument 則是指 function call 實際傳入的 input。
  - [bash \- Difference between terms: "option", "argument", and "parameter"? \- Stack Overflow](https://stackoverflow.com/questions/36495669/) jlliagre: #ril
      - 一個 command 可以拆解成 arguments，其中 argument 0 是 command 本身，後面接著 argument 1, 2 ...
      - Option 也是一種 argument，主要用來改變 command 的行為，顧名思義 option 通常是 optional (但有些 command 則很矛盾地要求 mandatory option)。例如 `-l` (long)、`-v` (verbose) 或 `-lv` 將兩者合併，也有像 `--verbose` 的長版 (long option)。
      - Parameter 是指提供給 command 或 option 的 information，例如 `-o file`，`file` 就是 `-o` option 的 parameter，不像 option 會寫死在程式裡，parameter 通常使用者可以決定要傳什麼。
      - 如果你要傳一個 parameter 但又不想被解讀為 option，可以在 parameter 前明確加上 `--`，把前面的 options 分隔開來。例如 `ls -l -- -a`，只有一個 option `-a`，與一個 parameter `-a`。
      - Subcommand 的狀況略有不同 -- `command [global-options] subcommand [subcommand-specific-options] [params]`，在 command 與 subcommand 間可能有 global option，而 subcommand 也可以有自己的 option，例如 `git --git-dir=a.git --work-tree=b -C c status -s`，其中 `git` 與 `status` 分別是 command 與 subcommand，所以 global option 是 `--git-dir=a.git --work-tree=b -C c`，subcommand 的 option 則是 `-s`。

## Design, UX ??

  - [Exploring CLI Best Practices // Localytics Engineering Blog](https://eng.localytics.com/exploring-cli-best-practices/) (2016-10-11) #ril

## Python ??

  - [15\.6\. getopt — C\-style parser for command line options — Python 2\.7\.15rc1 documentation](https://docs.python.org/2/library/getopt.html) #ril
  - [15\.5\. optparse — Parser for command line options — Python 2\.7\.15rc1 documentation](https://docs.python.org/2/library/optparse.html) #ril
  - [15\.4\. argparse — Parser for command\-line options, arguments and sub\-commands — Python 2\.7\.15rc1 documentation](https://docs.python.org/2/library/argparse.html) #ril
  - [16\.4\. argparse — Parser for command\-line options, arguments and sub\-commands — Python 3\.6\.5 documentation](https://docs.python.org/3.6/library/argparse.html) #ril
  - [Why not Argparse? - Why Click? — Click Documentation \(5\.0\)](http://click.pocoo.org/5/why/#why-not-argparse) #ril
  - [Comparing Python Command\-Line Parsing Libraries – Argparse, Docopt, and Click – Real Python](https://realpython.com/comparing-python-command-line-parsing-libraries-argparse-docopt-click/) (2015-09-08) #ril

其他方案：

  - [Welcome to the Click Documentation — Click Documentation \(5\.0\)](http://click.pocoo.org/5/) #ril
  - [Python Fire](python-fire.md) 把 CLI subcomand 直接對應到 function

## Testing

  - Command Line Interface (CLI) tests - Apache Stratos - Apache Software Foundation https://cwiki.apache.org/confluence/display/STRATOS/Command+Line+Interface+%28CLI%29+tests 試過 Java solution 不可行，最後選用 pexpect + WireMock。

