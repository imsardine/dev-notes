---
title: Python / Module & Package
---
# [Python](python.md) / Module & Package

## `python -m` ??

  - [1\. Command line and environment — Python 3\.7\.2 documentation](https://docs.python.org/3/using/cmdline.html)
      - `python [-bBdEhiIOqsSuvVWx?] [-c command | -m module-name | script | - ] [args]`
      - When called with `-m module-name`, the given module is located on the Python module path and executed AS A SCRIPT.

    `-m <module-name>`

      - Search `sys.path` for the named module and execute its contents as the `__main__` module.
      - Since the argument is a MODULE NAME, you MUST NOT give a file extension (`.py`). The module name should be a valid ABSOLUTE Python module name, but the implementation may not always enforce this (e.g. it may allow you to use a name that includes a HYPHEN).

        可以包含 `-` 的話，用起來會比 `_` 來得直覺，但中間是怎麼轉換成 module name 的??

      - Package names (including namespace packages??) are also permitted. When a package name is supplied instead of a normal module, the interpreter will execute `<pkg>.__main__` as the MAIN MODULE. This behaviour is deliberately similar to the handling of directories and zipfiles that are passed to the interpreter as the script argument. 在 package 裡取 `__name__` 也會得到 `__main__`??

        Note This option cannot be used with built-in modules and extension modules written in C, since they do not have Python module files. However, it can still be used for precompiled modules, even if the original source file is not available.

      - If this option is given, the first element of `sys.argv` will be the full path to the module file (while the module file is being located, the first element will be set to "`-m`"??). As with the `-c` option, the current directory will be added to the start of `sys.path`. 擅自調整 `sys.path` 好嗎??

      - Many standard library modules contain code that is invoked on their execution as a script. An example is the `timeit` module: (原來 `-m` 跟 module name 間不需要有空白)

            python -mtimeit -s 'setup here' 'benchmarked code here'
            python -mtimeit -h # for details

  - [python \- What is the purpose of the \-m switch? \- Stack Overflow](https://stackoverflow.com/questions/7610001/) #ril

  - [PEP 338 \-\- Executing modules as scripts \| Python\.org](https://www.python.org/dev/peps/pep-0338/) #ril

## Internal Module ??

  - [Public and Internal Interfaces - PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/?#public-and-internal-interfaces)
      - Any backwards compatibility guarantees apply only to public interfaces. Accordingly, it is important that users be able to clearly distinguish between public and internal interfaces. ... All undocumented interfaces should be assumed to be internal. 這話說得真好 -- 揭露越多，未來的包袱越重。
      - To better support introspection, modules should explicitly declare the names in their public API using the `__all__` attribute. Setting `__all__` to an empty list indicates that the module has no public API. 原來 `__all__` 的意義這麼重大!
      - Even with `__all__` set appropriately, internal interfaces (packages, modules, classes, functions, attributes or other names) should still be prefixed with a single leading underscore. 原來底線的慣例適用於所有的 names，包括 package、module、class ... 若 internal module 本身已經加底線，是否內部的 names 也要加底線??
  - [Python: 'Private' module in a package \- Stack Overflow](https://stackoverflow.com/questions/3602110/)
      - Frederick The Fool: Package `mypack` 下有 2 個 module - `mod_a` 及 `mod_b`，不希望 `mod_b` 被外面的人用，要如何表達 (convey)? 在 module name 前面加底線 (`_mod_b`)，或是放進 subpackage `private/mod_b` 好?
      - Ivo van der Wijk: 雖有在 method 前加底線的慣例，但不會在檔案或 class 上面做這件事，覺得醜；或許可以從文件下手? 在文件說明哪些 module 不該直接存取。
      - Frederick The Fool: 最後決定採用 subpackage `private`，將不想公開的 module 放在底下，也不覺得這是 unpythonic；過了 6 年之後，sparc_spread 問作者還在用 private subpackage 嗎? 作者回答是的，因為還沒找到更好的方法。
      - Jeremy: 傾向在 module 前加底線，精神上同 PEP8 建議 C-extension module 加底線一樣。
  - [Modules and Packages \- Learn Python \- Free Interactive Python Tutorial](https://www.learnpython.org/en/Modules_and_Packages) The `__init__.py` file can also decide which modules the package exports as the API, while keeping other modules internal, by overriding the `__all__` variable 在 `__init__.py` 的 `__all__` 一併把可以公開的 module 列進去。

可以參考的做法：

  - [requests/\_internal\_utils\.py at master · requests/requests](https://github.com/requests/requests/blob/master/requests/_internal_utils.py)
  - [flask/\_compat\.py at master · pallets/flask](https://github.com/pallets/flask/blob/master/flask/_compat.py)

## __init__.py 適不適合寫邏輯 ??

  - 覺得不適合，否則就要額外用 `__all__` 宣告哪些 name 要做為公開的 API。

