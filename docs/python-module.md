---
title: Python / Module & Package
---
# [Python](python.md) / Module & Package

## Module ??

  - [module - Glossary — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/glossary.html#term-module) #ril
  - [Packages - 5\. The import system — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/reference/import.html#packages)
      - Python has ONLY ONE TYPE of module object, and all modules are of this type, regardless of whether the module is implemented in Python, C, or something else.
      - ALL modules have a name. 這就不懂為何 [5\. The import system — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/reference/import.html) 會有 named module 的說法，好像有 unnamed module 一樣?

## Package ??

  - [package - Glossary — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/glossary.html#term-package)
      - A Python module which CAN contain SUBMODULES or recursively, SUBPACKAGES. Technically, a package is a Python module with an `__path__` attribute.

        這裡 "can contain" 的說法，似乎意謂著一開始用 module，之後發展成 module，也不會對 client code 造成影響? 這呼應了下面 "所有 package 都是 module (一種特殊的 module)，但 module 不一定是 package" 的說法。

  - [regular package - Glossary — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/glossary.html#term-regular-package)
      - A traditional package, such as a directory containing an `__init__.py` file.

  - [namespace package - Glossary — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/glossary.html#term-namespace-package)
      - A PEP 420 package which serves only as a CONTAINER for subpackages. Namespace packages may have no physical representation, and specifically are not like a regular package because they have no `__init__.py` file.

  - [Packages - 5\. The import system — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/reference/import.html#packages)
      - To help organize modules and provide a NAMING HIERARCHY, Python has a concept of PACKAGES.
      - You can think of packages as the directories on a file system and modules as files within directories, but DON’T TAKE THIS ANALOGY TOO LITERALLY since packages and modules need not originate from the file system. For the purposes of this documentation, we’ll use this convenient analogy of directories and files. Like file system directories, packages are organized hierarchically, and packages may themselves contain subpackages, as well as regular modules.
      - It’s important to keep in mind that ALL PACKAGES ARE MODULES, BUT NOT ALL MODULES ARE PACKAGES. Or put another way, packages are just a SPECIAL KIND OF MODULE. Specifically, any module that contains a `__path__` attribute is considered a package.
      - All modules have a name. Subpackage names are separated from their PARENT PACKAGE name by DOTS, akin to Python’s standard attribute access syntax. Thus you might have a module called `sys` and a package called `email`, which in turn has a subpackage called `email.mime` and a module within that subpackage called `email.mime.text`.

    Regular packages

      - Python defines two types of packages, REGULAR PACKAGES and NAMESPACE PACKAGES. Regular packages are traditional packages as they existed in Python 3.2 and earlier. A regular package is typically implemented as a directory containing an `__init__.py` file. When a regular package is imported, this `__init__.py` file is IMPLICITLY EXECUTED, and the objects it defines are BOUND TO NAMES IN THE PACKAGE’S NAMESPACE. The `__init__.py` file can contain the same Python code that any other module can contain, and Python will add some additional attributes?? to the module when it is imported.
      - For example, the following file system layout defines a top level parent package with three subpackages:

            parent/
                __init__.py
                one/
                    __init__.py
                two/
                    __init__.py
                three/
                    __init__.py

        Importing `parent.one` will implicitly execute `parent/__init__.py` AND `parent/one/__init__.py`. Subsequent imports of `parent.two` or `parent.three` will execute `parent/two/__init__.py` and `parent/three/__init__.py` respectively.

        注意 parent package 的 `__init__.py` 也會被執行，即便 import 的對象底下的 subpackage。

    Namespace packages

      - A namespace package is a composite of various PORTIONS, where each portion contributes a subpackage to the parent package. Portions may RESIDE IN DIFFERENT LOCATIONS ON THE FILE SYSTEM. Portions may also be found in zip files, on the network, or anywhere else that Python searches during import. Namespace packages may or may not correspond directly to objects on the file system; they may be VIRTUAL MODULES that have no concrete representation.

        以下 subpackage 都要在同一個 parent package 對應的資料夾底下，有時候會形成限制。

      - Namespace packages do not use an ORDINARY LIST?? for their `__path__` attribute. They instead use a custom iterable type which will automatically perform a new search for package portions on the next import attempt within that package if the path of their parent package (or `sys.path` for a top level package) changes. ??
      - With namespace packages, there is no `parent/__init__.py` file. In fact, there may be MULTIPLE PARENT DIRECTORIES found during import search, where each one is provided by a different portion. Thus `parent/one` may not be physically located next to `parent/two`. In this case, Python will create a namespace package for the top-level parent package whenever it or one of its subpackages is imported. See also PEP 420 for the namespace package specification.

        所以實務上要怎麼寫出 namespace package? 感覺是自動產生的??

## Module Search Path ??

  - [6\. Modules — Python 2\.7\.16 documentation](https://docs.python.org/2/tutorial/modules.html)

    The Module Search Path

      - When a module named `spam` is imported, the interpreter first searches for a BUILT-IN MODULE with that name. If not found, it then searches for a file named `spam.py` in a LIST OF DIRECTORIES given by the variable `sys.path`. `sys.path` is initialized from these locations:

          - the directory containing the INPUT SCRIPT (or the CURRENT DIRECTORY).
          - `PYTHONPATH` (a list of directory names, with the same syntax as the shell variable `PATH`).
          - the installation-dependent default.

      - After initialization, Python programs CAN MODIFY `sys.path`. The DIRECTORY CONTAINING THE SCRIPT BEING RUN is placed at the beginning of the search path, ahead of the STANDARD LIBRARY PATH. This means that scripts in that directory will be loaded instead of modules of the same name in the library directory. This is an error unless the replacement is intended. See section Standard Modules for more information.

        注意是 main/input script 所在的目錄，不一定是 CWD。

    Standard Modules

      - The variable `sys.path` is a list of strings that determines the interpreter’s search path for modules. It is initialized to a default path taken from the environment variable `PYTHONPATH`, or from a built-in default if `PYTHONPATH` is not set. You can modify it using standard list operations:

            >>> import sys
            >>> sys.path.append('/ufs/guido/lib/python')

        這裡 "OR from a built-in default" 聽起來有點怪? 實驗發現，`PYTHONPATH` 與 built-in default 並非互斥：

            $ pwd
            /workspace
            $ mkdir bin && echo 'import sys; print(sys.path)' > bin/run.py
            $ python bin/run.py
            ['/workspace/bin', '/usr/local/lib/python37.zip', '/usr/local/lib/python3.7', '/usr/local/lib/python3.7/lib-dynload', '/usr/local/lib/python3.7/site-packages']
            $ PYTHONPATH=/workspace python bin/run.py
            ['/workspace/bin', '/workspace', '/usr/local/lib/python37.zip', '/usr/local/lib/python3.7', '/usr/local/lib/python3.7/lib-dynload', '/usr/local/lib/python3.7/site-packages']

        無論如何，main/input script 所在的目錄一定在最前面。

  - [6\. Modules — Python 3\.7\.3 documentation](https://docs.python.org/3/tutorial/modules.html) 文件跟 Python 2 大致相同，只是多了：

      - Note: On file systems which support symlinks, the directory containing the input script is calculated after the symlink is followed. In other words the directory containing the symlink is not added to the module search path.

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

## 參考資料 {: #reference }

手冊：

  - [PEP 420 -- Implicit Namespace Packages](https://www.python.org/dev/peps/pep-0420/)
  - [class `types.ModuleType`](https://docs.python.org/3/library/types.html#types.ModuleType)
