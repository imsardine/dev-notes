---
title: Python > PDB (Python Debugger)
---
# [Python](python.md) > PDB (Python Debugger)

  - [pdb — The Python Debugger — Python 3\.7\.2rc1 documentation](https://docs.python.org/3/library/pdb.html)
      - The module `pdb` defines an INTERACTIVE source code debugger for Python programs. It supports setting (conditional) breakpoints and single stepping at the source line level, inspection of STACK FRAMES, source code listing, and evaluation of arbitrary Python code in the context of any stack frame. 操作起來像是 Python 的 interactive shell，主要是執行 debug command，但也可以寫些簡單的 Python expression (執行在所處的 stack frame 下)。
      - It also supports POST-MORTEM DEBUGGING and can be called UNDER PROGRAM CONTROL. 相對於 under debugger control 的說法；後者是由 debugger 執行 program，前者則是 program 執行過程中進入 debugger，因此有 "break into the debugger" 的說法，pdb 支持這兩種用法。

  - [Python Debugging With Pdb – Real Python](https://realpython.com/python-debugging-pdb/) (2018-04-09)
      - pdb, and other debuggers, are indispensable tools. When you need a debugger, there’s no substitute. You really need it. 這句話有點奇妙
      - Sometimes, stepping through code in pdb and seeing how values change can be a real eye-opener and lead to “aha” moments, along with the occasional “face palm”.
      - pdb is part of Python’s standard library, so it’s ALWAYS THERE and available for use. This can be a life saver if you need to debug code in an environment where you don’t have access to the GUI debugger you’re familiar with. 雖然 GUI debugger 很誘人，但 pdb 還是得學。

## 新手上路 {: #getting-started }

  - [pdb — The Python Debugger — Python 3\.7\.2rc1 documentation](https://docs.python.org/3/library/pdb.html)
      - The debugger’s prompt is `(Pdb)`. Typical usage to run a program UNDER CONTROL OF THE DEBUGGER is:

            >>> import pdb
            >>> import mymodule
            >>> pdb.run('mymodule.test()') # 進 interactive shell 再用 debugger 執行 program，實務上比較少見?
            > <string>(0)?() # 不過這是什麼東西? 應該是因為沒有 source，執行 ll 會提示 "could not get source code"
            (Pdb) continue
            > <string>(1)?()
            (Pdb) continue
            NameError: 'spam'
            > <string>(1)?()
            (Pdb)

      - Changed in version 3.3: Tab-completion via the `readline` module is available for commands and command arguments, e.g. the current global and local names are offered as arguments of the `p` command. 在 `p`/`pp` 後按 tab，可以列出當時存取得到的 global 跟 local names，很方便。
      - `pdb.py` can also be invoked AS A SCRIPT to debug OTHER SCRIPTS. For example: `python3 -m pdb myscript.py` 會停在 `myscript.py` 的第 1 行前面。
      - New in version 3.7: `pdb.py` now accepts a `-m` option that execute modules similar to the way `python3 -m` does. As with a script, the debugger will pause execution just before the first line of the module. 例如：

            $ python -m pdb -m unittest
            > /usr/local/Cellar/python/3.7.0/Frameworks/Python.framework/Versions/3.7/lib/python3.7/unittest/__main__.py(1)<module>()
            -> """Main entry point"""
            (Pdb)

      - The typical usage to BREAK INTO THE DEBUGGER FROM A RUNNING PROGRAM is to insert `import pdb; pdb.set_trace()` at the location you want to break into the debugger. You can then step through the code following this statement, and continue running without the debugger using the `continue` command. 以上都是 under debugger control 的做法，要走 under program control 至少要在程式裡安插一個 breakpoint，呼應了下面 "each ENTERS THE DEBUGGER in a slightly different way" 的說法，一旦進入 debugger 後，面對的都是 PDB prompt。

  - [Getting Started: Printing a Variable’s Value - Python Debugging With Pdb – Real Python](https://realpython.com/python-debugging-pdb/#getting-started-printing-a-variables-value) (2018-04-09) #ril
      - Insert the following code at the location where you want to BREAK INTO THE DEBUGGER: `import pdb; pdb.set_trace()` When the line above is executed, Python stops and waits for you to tell it what to do next. You’ll see a (Pdb) prompt. 如果在 GUI debugger 裡安插 breakopoint 一樣。
      - You can also break into the debugger, without modifying the source and using `pdb.set_trace()` or `breakpoint()`, by running Python directly from the command-line and passing the option `-m pdb`. 例如 `python3 -m pdb app.py arg1 arg2`，一開始停在那裡? => 第 1 行之前

  - [Dropping to PDB (Python Debugger) on failures - Usage and Invocations — pytest documentation](https://docs.pytest.org/en/latest/usage.html#dropping-to-pdb-python-debugger-on-failures) #ril
  - [Debug: drop into pdb on errors or failures — nose 1\.3\.7 documentation](https://nose.readthedocs.io/en/latest/plugins/debug.html) #ril

## Debugger Command ??

  - [Debugger Commands - 26\.2\. pdb — The Python Debugger — Python 2\.7\.15 documentation](https://docs.python.org/2/library/pdb.html#debugger-commands) #ril
      - Most commands can be abbreviated to one or two letters; e.g. `h(elp)` means that either `h` or `help` can be used to enter the help command (but not `he` or `hel`, nor `H` or `Help` or `HELP`). Arguments to commands must be separated by whitespace (spaces or tabs). 只能採用指定的縮寫，否則就只能用全名。
      - Entering a blank line repeats the last command entered. Exception: if the `last` command was a list command, the NEXT 11 lines are listed. 但對 `ll` 無效。
      - Commands that the debugger doesn’t recognize are assumed to be Python statements and are executed in the CONTEXT of the program being debugged. Python statements can also be prefixed with an exclamation point (`!`). This is a powerful way to inspect the program being debugged; it is even possible to CHANGE A VARIABLE or call a function. When an exception occurs in such a statement, the exception name is printed but the debugger’s STATE IS NOT CHANGED. 完全不輸 GUI debugger!! 不過 Python statement 還是明確用 `!` 帶出來比較好，避免誤執行到 debugger command。
      - Multiple commands may be entered on a single line, separated by `;;`. ... No intelligence is applied to separating the commands; the input is split at the first `;;` pair, even if it is in the middle of a quoted string. 實際的應用??
      - The debugger supports aliases. Aliases can have parameters which allows one a certain level of ADAPTABILITY to the context under examination. 搭配 `.pdbrc` 比較實用。
      - `c(ont(inue))` - Continue execution, only stop when a breakpoint is encountered. 直到下一個 breakpoint。
      - `p expression` - Evaluate the expression in the current context and print its value.
      - `pp expression` - Like the `p` command, except the value of the expression is pretty-printed using the `pprint` module.
      - `q(uit)` - Quit from the debugger. The program being executed is ABORTED. 不單純只是離開 debugger
  - [Stack Frame - Debugger Commands - 26\.2\. pdb — The Python Debugger — Python 2\.7\.15 documentation](https://docs.python.org/2/library/pdb.html#debugger-commands) 整理出跟 stack frame、function call 相關的 commands #ril
      - `w(here)` - Print a stack trace, with the most recent frame at the bottom. An arrow indicates the current frame, which determines the CONTEXT of most commands. 印出一路執行到這裡的路徑
      - `s(tep)` - Execute the current line, stop at the first possible occasion (either in a function that is called or on the next line in the current function). 近似於 `next` (stop over)??
      - `n(ext)` - Continue execution until the next line in the current function is reached or it returns. (The difference between `next` and `step` is that step stops INSIDE a called function, while `next` executes called functions at (nearly) full speed, only stopping at the next line in the current function.) 傳統 debugger 的 step over
      - `d(own)` - Move the current frame one level down in the stack trace (to a newer frame). 搭配 `w(here)` 使用比較清楚；可以在 stack frame 間游走，有點神奇!!
      - `u(p)` - Move the current frame one level up in the stack trace (to an older frame).
      - `r(eturn)` - Continue execution until the current function returns. 直到離開所在的 function。

## `.pdbrc` ??

  - [Debugger Commands - 26\.2\. pdb — The Python Debugger — Python 2\.7\.15 documentation](https://docs.python.org/2/library/pdb.html#debugger-commands)
      - If a file `.pdbrc` exists in the user’s home directory or in the current directory, it is read in and executed as if it had been typed at the debugger prompt. This is particularly useful for ALIASES. If both files exist, the one in the home directory is read first and aliases defined there can be overridden by the local file. 自己慣用的 alias 放 home dir，專案特有的 alias 就放專案底下。

## `breakpoint()` Built-In ??

  - [Getting Started: Printing a Variable’s Value - Python Debugging With Pdb – Real Python](https://realpython.com/python-debugging-pdb/#getting-started-printing-a-variables-value) (2018-04-09) Python 3.7 新加入了 `breakpoint()` built-in，只要在 code 裡面安插 `breakpoint()` 即可，效果跟上面 `import pdb; pdb.set_trace()` 一樣，但可以進一步透過 `PYTHONBREAKPOINT` 環境變數來控制要不要作用，例如 `PYTHONBREAKPOINT=0` 可以停用 debugging (所以 `breakpoint()` 可以留在 source code 裡)；作者建議 Python 3.7 用 `breakpoint()` 來取代 `pdb.set_trace()`。
  - [The breakpoint() Built-In - Cool New Features in Python 3\.7 – Real Python](https://realpython.com/python37-new-features/#the-breakpoint-built-in) (2018-06-27) #ril
  - [Python 3\.7’s new builtin breakpoint — a quick tour – Hacker Noon](https://hackernoon.com/python-3-7s-new-builtin-breakpoint-a-quick-tour-4f1aebc444c) (2018-05-17) #ril
  - [breakpoint() - Built\-in Functions — Python 3\.7\.2rc1 documentation](https://docs.python.org/3/library/functions.html#breakpoint) #ril

## Post-Mortem Debugging ??

  - [pdb — The Python Debugger — Python 3\.7\.2rc1 documentation](https://docs.python.org/3/library/pdb.html) 一開始就提到支援 post-mortem debugging #ril
      - When invoked as a script, pdb will automatically enter post-mortem debugging if the program being debugged EXITS ABNORMALLY. After post-mortem debugging (or after normal exit of the program), pdb will restart the program. Automatic restarting preserves pdb’s state (such as breakpoints) and in most cases is more useful than quitting the debugger upon program’s exit. ??

## 工具 {: #tools }

  - [Welcome to pudb’s documentation\! — pudb 2\.0\.1\.8\.\.\.1 documentation](https://documen.tician.de/pudb/index.html) #ril
  - [romanvm/python\-web\-pdb: Web\-based remote UI for Python's PDB debugger](https://github.com/romanvm/python-web-pdb) #ril
  - [PythonDebuggingTools \- Python Wiki](https://wiki.python.org/moin/PythonDebuggingTools) #ril

## 參考資料 {: #reference }

  - [pdb — The Python Debugger](https://docs.python.org/3/library/pdb.html)

手冊：

  - [Debugger Commands](https://docs.python.org/3/library/pdb.html#debugger-commands)
  - [`cpython/pdb.py` - python/cpython](https://github.com/python/cpython/blob/3.7/Lib/pdb.py)