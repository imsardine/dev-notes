# Bash

## 新手上路 {: #getting-started }

  - Bash Guide for Beginners http://tldp.org/LDP/Bash-Beginners-Guide/html/index.html #ril

## 如何查看 Bash builtin 的用法?

  - 用 `man` 查不到 Bash builtin 的用法，要用 `help`，例如 `help cd`。

參考資料：

  - 以 `cd` 而言，它是 builtin，所以用 `man cd` 看不到什麼說明，要用 `help cd` 才行；可以用 `help help` 查看 builtin 的說明。

## Quoting ??

  - 為什麼 `$VAR` 跟 `"$VAR"` 有差別?? 後者視為一個 arg?
  - [3.1.2 Quoting - Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html#Quoting) #ril
  - [Quotes and escaping \[Bash Hackers Wiki\]](http://wiki.bash-hackers.org/syntax/quoting) #ril
      - Quote charactes 跟 parsing 有關，但跟 command line 參數傳遞無關?? `command $MYARG` 會收到 3 個參數，但 `command "MYARG"` 會收到一個參數。

## History ??

  - 感覺最後一個離開的 session，其 history 會覆寫 `~/.bash_history`?? 所以 `history -c` 或更動 `HISTSIZE` 會影響整個 `~/.bash_history`。
  - Bash 的 history 好像不能在多佪 session 間共享? 所以 [Zsh](https://en.wikipedia.org/wiki/Z_shell) 才會強調 "Sharing of command history among all running shells"。
  - [9 Using History Interactively - Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html#Using-History-Interactively) #ril
  - [8.2.5 Searching for Commands in the History - Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html#Searching) #ril
  - [8.4.2 Commands For Manipulating The History - Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html#Commands-For-History) #ril
  - [5.2 Bash Variables - Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html#Bash-Variables) 說明 `HIST*` variable #ril
  - [Linux command history: Choosing what to remember and how \| Network World](https://www.networkworld.com/article/3256279/linux/linux-command-history-choosing-what-to-remember-and-how.html) (2018-02-20) #ril
      - 最後提到 login session 的 history 在 log out 時才會寫到 history file，若是 log out 前先做 `history -c`，就不會記錄任何東西 -- 整個 history file 會被清掉。
      - `HISTCONTROL` 設定 `ignorespace` 或 `ignoredups` (同時指定時用 `:` 分開，也可以用 `ignoreboth` 替代)，其中 `ignorespace` 表示當指令前面有空白時不會被記錄，`ignoredups` 表示連續的指令重複時只會記錄一個。
  - [Quit Bash Shell Without Saving Bash History \(5 Methods\) – If Not True Then False](https://www.if-not-true-then-false.com/2010/quit-bash-shell-without-saving-bash-history/) 看起來 history 會在 logout/quit/exit 時寫回檔案，難怪都在 `exit` 前對 `HISTFILE`/`HISTSIZE` 動些手腳 (或透過 `history -c` 清空)，而 `kill -9 $$` 暴力幹掉自己則是一絕。
  - [Don't save current bash session to history \- Stack Overflow](https://stackoverflow.com/questions/9039107/) #ril

## STDIN ??

  - [command line \- How to write a script that accepts input from a file or from stdin? \- Super User](https://superuser.com/questions/747884/) 利用 `cat -` 來取得 STDIN 的內容。
  - [How to read from a file or stdin in Bash? \- Stack Overflow](https://stackoverflow.com/questions/6980090/) 也有提到 `cat -` 的用法 #ril

## set -e ??

  - [linux \- What does set \-e mean in a bash script? \- Stack Overflow](https://stackoverflow.com/questions/19622198/) #ril
      - twalberg: `man bash` 就可以找到答案；`set -e` 的說明是 "Exit  immediately if a simple command (see SHELL GRAMMAR above) exits with a non-zero status."
      - kenorb: Pipeline 的 exit status 是最後一個 command 的 exist status，除非 `pipefail` option 有啟用，就會是 "the status of last command to exit with a non-zero status"。
      - Robin Green: `help set` 就可以看到說明，預設在 command 或 pipeline 裡的錯誤會被忽略。
  - [bash \- Stop on first error \- Stack Overflow](https://stackoverflow.com/questions/3474526/) #ril
  - [Automatic exit from bash shell script on error \- Stack Overflow](https://stackoverflow.com/questions/2870992/) #ril

## List - ||, &&, &, ;

  - [3.2.3 Lists of Commands - Bash Reference Manual](https://tiswww.case.edu/php/chet/bash/bashref.html#Lists) #ril
      - List 是比 pipeline 更大的單位 -- A list is a sequence of one or more pipelines separated by one of the operators: ;, &, &&, or ||。
      - `&` 會將前面的 command 非同步地執行在 subshell，而 `;` 則是單純地依序執行 (sequentially)，return status 是最後一個 command 的 exit status。
      - `&&` 與 `||` 分別稱做 AND list 與 OR list。就 `command1 && command2` 而言，`command2` 只有在 `command1` 的 exit status 為 zero 時才會執行，而 `command1 || command2` 處理方式不同，`command2` 只有在 `command1` 的 exit status 為 non-zero 才會執行。而整個 list 的 return status 是 list 中最後一個執行的 command 的 exit status。
  - [bash \- Confusing use of && and \|\| operators \- Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/24684/) #ril
      - Shawn J. Goff: `&&` 只有在左側的 exit status 為 zero 才會執行，而 `||` 相反則是左側的 exit status 為 non-zero 時才會執行。
  - [bash which OR operator to use \- pipe v double pipe \- Stack Overflow](https://stackoverflow.com/questions/41625521/) #ril

## I/O Redirection??

  - [File descriptor \- Wikipedia](https://en.wikipedia.org/wiki/File_descriptor) Each Unix process (except perhaps a daemon) should expect to have three standard POSIX file descriptors, corresponding to the three standard streams -- `stdin` (0)、`stdout` (1) 及 `stderr` (2)；括號裡的就是 file descriptor (non-negative integer)。
  - [BASH Programming \- Introduction HOW\-TO: All about redirection](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-3.html) #ril
      - 有 3 個 file descriptor -- `stdin`、`stdout` (1)、`stderr` (2)。
  - [Bash Reference Manual: Redirections](https://www.gnu.org/software/bash/manual/html_node/Redirections.html) #ril
  - [A Detailed Introduction to I/O and I/O Redirection](https://www.tldp.org/LDP/abs/html/ioredirintro.html) #ril
      - 一個 command 內部會預期有 3 個 file descriptor -- fd 0 (`stdin`) 用在 reading/input，另外 fd 1 (`stdout`) 及 fd 2 (`stderr`) 則用在 writing/output；其中 fd 1 是 normal output，而 fd 2 則是 error output。
  - [I/O Redirection](https://www.tldp.org/LDP/abs/html/io-redirection.html) #ril
  - [bash \- Piping command output to tee but also save exit code of command \- Stack Overflow](https://stackoverflow.com/questions/6871859/) 設定 `set -o pipefail`，在 pipeline 裡有任何 command 的 exit status 不是 0 時，都能從最後的 exit status 看出來 #ril

## Shell Scripting

### If ... Else

  - linux - Why should there be a space after '[' and before ']' in Bash? - Stack Overflow https://stackoverflow.com/questions/9581064/ 為什麼 `if [ condition ]` 的兩側一定要有空白? Johnsyweb: 因為 `[` 是個 command，其實是 `test` 的 synonym (用 `help [` 及 `help test` 查看用法)，只是 `help [` 提到 `[` 的最後一個參數必須要是 `]`，所以才有 `[ expression ]` 的用法。

## Files I/O 檔案存取

### 如何判斷目錄是否存在?

```
if [ -d file ]; then
    statement1
else
    statement2
fi
```

若是目錄不存在時才要做什麼事，用 `[ expression ] || statement` 也可以 (expression 不成立時才會執行 statement)，例如 `output/` 不存在時才建立：

```
[ -d output ] || mkdir output
```

參考資料：

  - Bash Reference Manual https://www.gnu.org/software/bash/manual/bash.html#Bash-Conditional-Expressions 提到 `-d file` 可以判斷 file 存在，而且是個 directory。
  - How do I tell if a regular file does not exist in Bash? - Stack Overflow https://stackoverflow.com/questions/638975/ `test` 指令有個 not operator (`!`)，用起來像是 `if [ ! -f /tmp/foo.txt ]; then`。
  - shell - How to mkdir only if a dir does not already exist? - Stack Overflow https://stackoverflow.com/questions/793858/ 出現 `[ -d foo ] || mkdir foo` 的用法。

### 目錄不存在時才建立?

  - shell - How to mkdir only if a dir does not already exist? - Stack Overflow https://stackoverflow.com/questions/793858/ 用 `mkdir -p` 或是 `[ -d foo ] || mkdir foo`。

### Shell Scripting 跟 Shell 的關係是什麼??

  - Bash For Loop Examples – nixCraft https://www.cyberciti.biz/faq/bash-for-loop/ 提到 "A for loop can be used at a shell prompt or within a shell script itself"，感覺兩者的界限很模糊。

## Shell Expansion

  - Shell expansion http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_04.html #ril

### 如何一次展開多個 `~` ??

  - `DIRS="~/dir1 ~/dir2" 因為 `~` 在雙引號內，完全不會解析；可以暫時用 `$HOME` 來取代。
  - Shell expansion http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_04.html 似乎 tilde expansion 有一些規則 #ril

## 生產力

  - 怎麼用 alias ?? 是 Bash 的東西而非 Unix-like??

## 參數處理

  - 要如何檢查參數數量，並印出用法? => http://stackoverflow.com/questions/18568706 用 `if [ "$#" -ne 1 ]; then ... fi 或 `if test "$#" -ne 1; then ... fi`。

## 流程控制


## Process 行程管理

  - 如何對 process 送出同使用者按 Ctrl-C 的 signal? => http://stackoverflow.com/questions/514771/ 送出 `SIGINT` (`kill -SIGINT <PID>`)，預設 `kill` 會送出 `SIGTERM`。

## 資料處理

  - 怎麼模擬 SQL 裡的 `GROUP BY`?? => http://stackoverflow.com/questions/380817/ 搭配 `sort -n | uniq -c`

## HOWTO

### 如何執行多個 task (忽略中間發生的錯誤) ??

利用 `||` 右側的 command 只有在左側 command 的 exit status 為 non-zero 時才會執行。

```
set -e

sh -c 'echo one; exit 0' || EXIT_STATUS=$?
sh -c 'echo two; exit 2' || EXIT_STATUS=$?
sh -c 'echo three; exit 0' || EXIT_STATUS=$?

exit $EXIT_STATUS
```

  - [linux \- Bash ignoring error for a particular command \- Stack Overflow](https://stackoverflow.com/questions/11231937/) #ril
      - Arslan Qadeer: 不想停下來，又想把 exit code 存下來，可以用 `set -e;` 搭配 `command || EXIT_CODE=$? && true`

## 其他

  - `iabbrev` 的展開很好用，只是不知道語法?? http://learnvimscriptthehardway.stevelosh.com/chapters/08.html
  - 什麼是 Quickfix List??
   ** http://vi.stackexchange.com/questions/2280/show-only-matching-lines 提到 `:vimgrep pattern %` 的用法，再用 `:cwin` 開啟另一個視窗選取...
  - 如何快速地上下移動某些行?? => http://vim.wikia.com/wiki/Moving_lines_up_or_down
  - `NAME=VAL command` 的用法，為何 `NAME=VAL` 有 export 的效果??
  - 如何做 key-value 的 iteration?? http://stackoverflow.com/questions/3112687/how-to-iterate-over-associative-array-in-bash 專業的說法是 associative array 跟一般的 array 有什麼不同??
  - `~/.bashrc` 跟 `~/.bash_profile` 的差別?? http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html[.bash_profile vs .bashrc] 帶出 login shell 跟 non-login shell
  - 根本沒有 local/global variable 這種說法，因為 environment variable 是每個 process 都會有的，跟 Bash 沒有關係?? http://guide.bash.academy/03.variables.html 假設有個環境變數 `TOOL_DIR`，`TOOL_DIR=/tmp/tool` 是改了什麼?? 在那之前/之後，`$TOOL_DIR` 似乎分別讀取了 environment variable 跟 shell variable?? 有些時候 environment variable 跟 shell variable 似乎可以泛稱為 variable??
  - Parameter expansion 跟 variable expansion 有什麼不同? 感覺是一樣的東西? => http://guide.bash.academy/03.variables.html 說明了，shell variable 只是 paramter 的一種。
  - http://guide.bash.academy/[The Bash Guide] 很值得參考?? 每一個章節都有練習
  - Bash 的 variable 沒有資料型態，全部都是 string 吧?? `STR="Hello World!"` 中的 `"` 只是 quoating，跟資料型態無關??
  - 為什麼 `STR="Hello World!"` 在 command line 使用會有問題 `-bash: !": event not found`，但在 script file 裡使用就不會，shell prompt 跟 script file 裡 Bash 的用法有什麼差別??
  - Shell 有好幾層的概念要怎麼解釋??
  - 怎麼做四則運算?? 好像都會被視為字串?
  - 怎麼做迴圈??
  - 怎麼做條件檢查?? 檢查檔案是否存在??
  - 怎麼處理參數??
  - 什麼是 POSIX??
  - http://stackoverflow.com/questions/11588583/is-the-shells-source-posix-standard ??
  - 為什麼 Mac 有 `/bin/sh` 跟 `/bin/bash` 不一樣的 binary??
  - Bourne shell 跟 Bash 的關係??
  - 怎麼分 Bash builtin、function 跟 external command?? 用 printf 或 echo 好??
  - 什麼是 compound command?? `((` ?
  - `let` 怎麼用，跟直接做變數的 assignment 有什麼不同? 跟 `declare` 又有何不同??
  - 要怎麼解釋 expansion? => 做一些運算後，把結果置換回去；這跟 substitution 有什麼不同??
  - 怎麼定義 function?? 用 C 寫嗎??

## 參考資料

資源：

  - [BashFAQ \- Greg's Wiki](http://mywiki.wooledge.org/BashFAQ)

手冊：

  - [Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)

