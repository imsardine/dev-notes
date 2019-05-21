---
title: Python / Import System
---
# [Python](python.md) / Import System

  - [importing - Glossary — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/glossary.html#term-importing)
      - The process by which Python code in ONE MODULE is made available to Python code in ANOTHER MODULE.

        單位都是 module，跨 module 存取時，就會涉及 importing；注意 package 也是一種特殊的 module。

  - [5\. The import system — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/reference/import.html) #ril
      - Python code in one module gains access to the code in another module by the process of IMPORTING it. The `import` statement is the most common way of invoking the IMPORT MACHINERY, but it is not the only way. Functions such as `importlib.import_module()` and built-in `__import__()` can also be used to invoke the import machinery.
      - The `import` statement combines two operations; it SEARCHES for the NAMED MODULE (有 unnamed module 嗎??), then it BINDS the results of that search to a NAME IN THE LOCAL SCOPE. The search operation of the `import` statement is defined as a call to the `__import__()` function, with the appropriate arguments. The return value of `__import__()` is used to perform the NAME BINDING operation of the `import` statement. See the `import` statement for the exact details of that name binding operation.
      - A direct call to `__import__()` performs only the MODULE SEARCH and, if found, the MODULE CREATION operation. While certain SIDE-EFFECTS may occur, such as the IMPORTING OF PARENT PACKAGES, and the updating of various CACHES (including `sys.modules`), only the `import` statement performs a name binding operation.

        也就是 `import` = `__import__()` (search + creation) + name binding (local scope)，但 `importlib.import_module()` 背後不是用 `__import__()`。

      - When an `import` statement is executed, the standard builtin `__import__()` function is called. Other mechanisms for invoking the import system (such as `importlib.import_module()`) may choose to bypass `__import__()` and use their own solutions to implement import semantics.
      - When a module is first imported, Python searches for the module and if found, it creates a module object (`types.ModuleType`), initializing it. If the named module cannot be found, a `ModuleNotFoundError` is raised. Python implements various strategies to search for the named module when the import machinery is invoked. These strategies can be modified and extended by using various HOOKS?? described in the sections below.
      - Changed in version 3.3: The import system has been updated to fully implement the SECOND PHASE of PEP 302. There is no longer any IMPLICIT?? import machinery - the full import system is exposed through `sys.meta_path`.

  - [Searching - 5\. The import system — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/reference/import.html#searching) #ril
      - To begin the search, Python needs the FULLY QUALIFIED NAME of the module (or package, but for the purposes of this discussion, the difference is IMMATERIAL) being imported. This name may come from various arguments to the `import` statement, or from the parameters to the `importlib.import_module()` or `__import__()` functions.

        原來 `import` 的不同語法，都跟拼湊出 module/package 的全名有關。

      - This name will be used in various phases of the IMPORT SEARCH, and it may be the DOTTED PATH to a submodule, e.g. `foo.bar.baz`. In this case, Python first tries to import `foo`, then `foo.bar`, and finally `foo.bar.baz`. If any of the INTERMEDIATE IMPORTS fail, a `ModuleNotFoundError` is raised.

        就 package 而言，就是執行 `__init__.py` 的內容。而 `foo/__init__.py` --> `foo/bar/__init__.py` --> `foo/bar/baz.py` (或 foo/bar/baz/__init__.py`) 的順序很關鍵，即便 import 的對象是 `foo.bar.baz`。

    The module cache

      - The first place checked during import search is `sys.modules`. This mapping serves as a cache of all modules that have been previously imported, including the INTERMEDIATE PATHS??. So if `foo.bar.baz` was previously imported, `sys.modules` will contain entries for `foo`, `foo.bar`, and `foo.bar.baz`. Each key will have as its value the corresponding module object.
      - During import, the module name is looked up in `sys.modules` and if present, the associated value is the module satisfying the import, and the process completes. However, if the value is `None`, then a `ModuleNotFoundError` is raised. (之前找不到的，不用再找了；下面有解釋) If the module name is missing, Python will continue searching for the module.
      - sys.modules is WRITABLE. Deleting a key may not destroy the associated module (as other modules may HOLD REFERENCES TO IT), but it will INVALIDATE THE CACHE entry for the named module, causing Python to search anew for the named module upon its next import. The key can also be assigned to `None`, forcing the next import of the module to result in a `ModuleNotFoundError`.
      - Beware though, as if you keep a reference to the module object, invalidate its cache entry in `sys.modules`, and then re-import the named module, the two module objects will not be the same. (重新建立的 module object) By contrast, `importlib.reload()` will reuse the same module object, and simply REINITIALISE the module contents by rerunning the module’s code.

        像 Flask developement server 這類 reloader 的機制，應該都是用 `importlib.repload()` 達成?

  - [The import statement - 7\. Simple statements — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/reference/simple_stmts.html#import) #ril

  - [6\. Modules — Python 2\.7\.14 documentation](https://docs.python.org/2/tutorial/modules.html) #ril

## importlib ??

  - [importlib - 5\. The import system — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/reference/import.html#importlib)
      - The `importlib` module provides a rich API for interacting with the import system. For example `importlib.import_module()` provides a recommended, simpler API than built-in `__import__()` for invoking the import machinery. Refer to the `importlib` library documentation for additional detail.

## Import 只應放 module 上方? 什麼時候該放 function 裡?

  - 雖然 PEP8 說 "Imports are always put at the top of the file..."，但這也不是那麼絕對。
  - 除了可以用來避開 circular dependencies，也可以用在 wrapper (Don't mock types you don't own)，避免引用 wrapper 時就去找 3rd-party libraries；有些 libraries 並不是純 Python，又或者 import time 會做一些事情。
  - 以 Flask 而言，為了減少 [lazy-initialization](http://flask.pocoo.org/docs/0.12/patterns/appfactories/#factories-extensions)，讓 object 不會一開始處於 uninitialized 的狀態，可以考慮在 `wsgi.py` 做 wiring，在 `app` module 建立 singleton (`app.db = SQLAlchemy(flask_app)`)，其他要引用這個 singleton 的人，可以在 function 裡動態引用 `from app import db`，這樣測試期間，只要換掉 `app.db` 即可。

參考資料：

  - [optimization \- Should Python import statements always be at the top of a module? \- Stack Overflow](https://stackoverflow.com/questions/128478/) #ril

      - 雖然 PEP8 說 "Imports are always put at the top of the file..."，但較少用的是不是需要時再 import 比較有效率?
      - John Millikin: 放 function 裡比較慢? aaronasterling: 這倒未必
      - Moe: 可以用來避開 circular dependencies
      - thousandlegs: 把 import 放進 function 方便 refactor...

  - [Python import coding style \- Stack Overflow](https://stackoverflow.com/questions/477096/) 發現 import 放進 function 好像比較容易維護? aaronasterling: performance 不是背後的考量，因為在 function 裡 import 其實更快，但最好還是放 module 上方，可以容易看出 module 跟誰相依，也與 Python universe 的做法一致。
  - [All messages \- PyLint Messages](http://pylint-messages.wikidot.com/all-messages) Error message 提到 cyclic import，但沒講到從 function 裡 import 不行。

## Absolute & Package-relative Import ?? {: #relative-import }

  - [4 PEP 328: Absolute and Relative Imports](https://docs.python.org/2.5/whatsnew/pep-328.html)

      - The SIMPLER PART of PEP 328 was implemented in Python 2.4: PARENTHESES could now be used to enclose the names imported from a module using the `from ... import ...` statement, making it easier to import many different names. ??

        The more complicated part has been implemented in Python 2.5: importing a module can be specified to use ABSOLUTE or PACKAGE-RELATIVE imports. The plan is to move toward MAKING ABSOLUTE IMPORTS THE DEFAULT in future versions of Python.

      - Let's say you have a package directory like this:

            pkg/
            pkg/__init__.py
            pkg/main.py
            pkg/string.py

        This defines a package named `pkg` containing the `pkg.main` and `pkg.string` submodules.

      - Consider the code in the `main.py` module. What happens if it executes the statement `import string`? In Python 2.4 and earlier, it will FIRST LOOK IN THE PACKAGE'S DIRECTORY to perform a relative import, finds `pkg/string.py`, imports the contents of that file as the `pkg.string` module, and that module is bound to the name `string` in the `pkg.main` module's namespace.

        That's fine if `pkg.string` was what you wanted. But what if you wanted Python's standard `string` module? There's NO CLEAN WAY TO IGNORE `pkg.string` and look for the standard module; generally you had to look at the contents of `sys.modules`, which is slightly unclean.

        Holger Krekel's `py.std` package provides a tidier way to perform imports from the standard library, `import py ; py.std.string.join()`, but that package isn't available on all Python installations.

      - Reading code which relies on relative imports is also LESS CLEAR, because a reader may be confused about which module, `string` or `pkg.string`, is intended to be used. Python users soon learned NOT TO DUPLICATE the names of standard library modules in the names of their packages' submodules, but you can't protect against having your submodule's name being used for a new module added in a future version of Python.

        預設採 package-relative import 最大的問題是 readability。

      - In Python 2.5, you can switch import's behaviour to absolute imports using a `from __future__ import absolute_import` directive. This absolute-import behaviour will become the default in a future version (probably Python 2.7).

        Once absolute imports are the default, `import string` will always find the standard library's version. It's suggested that users should begin using absolute imports as much as possible, so it's preferable to begin writing `from pkg import string` in your code.

        以前預設採 relative import 的年代，`import ...` 跟 `from ... import` 都會先從 package 裡面找，但改採 absolute import 後，兩種寫法就都不會從 package 裡面找；跟下面 leading periods 的用法無關。

        這裡 "using absolute imports as much as possible" 的說法是在為切換到 "預設採 absolute import" 的未來做準備，並沒有建議不要用下面 leading periods 做 relative import 的意思，尤其 leading periods 並沒有難以識別 absolute/relative import 的問題。

      - Relative imports are still possible by adding a LEADING PERIOD to the module name when using the `from ... import` form:

            # Import names from pkg.string
            from .string import name1, name2
            # Import pkg.string
            from . import string

        This imports the `string` module relative to the current package, so in `pkg.main` this will import `name1` and `name2` from `pkg.string`. Additional leading periods perform the relative import starting from the parent of the current package. For example, code in the `A.B.C` module can do:

            from . import D                 # Imports A.B.D
            from .. import E                # Imports A.E
            from ..F import G               # Imports A.F.G 多個 . 的用法似乎過頭了 ??

        Leading periods cannot be used with the `import modname` form of the `import` statement, only the `from ... import` form.

  - [PyLint Messages](http://pylint-messages.wikidot.com/messages:w0403) `Relative import %r, should be %r`，不過實驗發現只有在 `from string import ...` 的寫法才會出現警告，寫成 `from .string import ...` 不會。

  - [The Definitive Guide to Python import Statements \| Chris Yeh](https://chrisyeh96.github.io/2017/08/08/definitive-guide-python-imports.html#absolute-vs-relative-import) #ril

      - Relative import 分為 explicit import (`from .xxx import ...`) 與 implicit import (`from xxx import ...`)，不過 implicit import 在 Python 3 已經完全不支援。
      - 作者認為 In general, absolute imports are preferred over relative imports. They avoid the confusion between explicit vs. implicit relative imports. 即便是 explicit relative import 也要少用?
      - [What’s New In Python 3\.0 — Python v3\.0\.1 documentation](https://docs.python.org/3.0/whatsnew/3.0.html) The only acceptable syntax for relative imports is from .[module] import name. All import forms not starting with . are interpreted as absolute imports. 所以用到 relative import 的 script 無法直接執行。
      - [6\. Modules — Python 3\.7\.0 documentation](https://docs.python.org/3/tutorial/modules.html#intra-package-references) Note that relative imports are based on the name of the current module. Since the name of the main module is always "__main__", modules intended for use as the main module of a Python application must always use absolute imports.

  - [Absolute and Relative Imports](http://pulkitgoyal.com/absolute-relative-imports) (2016-06-24) #ril
  - [coding style \- What's wrong with relative imports in Python? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/159503/) #ril
  - [PEP 328 \-\- Imports: Multi\-Line and Absolute/Relative \| Python\.org](https://www.python.org/dev/peps/pep-0328/) #ril

## Circular/Cyclic Imports (環狀) ??

[Coping with cyclic imports \- Google Groups](https://groups.google.com/d/msg/comp.lang.python/HYChxtsrhnw/AeCAK6zM9Q4J) 中 Duncan Booth 提到：

> Imports are pretty straightforward really. Just remember the following:
>
> 'import' and 'from xxx import yyy' are executable statements. They execute when the running program reaches that line.
>
> If a module is not in sys.modules, then an import creates the new module entry in sys.modules and then executes the code in the module. It does not return control to the calling module until the execution has completed.
>
> If a module does exist in sys.modules then an import simply returns that module whether or not it has completed executing. That is the reason why cyclic imports may return modules which appear to be partly empty.
>
> Finally, the executing script runs in a module named __main__, importing the script under its own name will create a new module unrelated to  __main__.
>
> Take that lot together and you shouldn't get any surprises when importing modules.

[Importing Python Modules](http://effbot.org/zone/import-confusion.htm):

> Modules are executed during import, and new functions and classes won’t appear in the module’s namespace until the def (or class) statement has been executed.

```
$ pylint --help-msg cyclic-import
:cyclic-import (R0401): *Cyclic import (%s)*
  Used when a cyclic import between two or more modules is detected. This
  message belongs to the imports checker.
```

---

參考資料：

  - [Python Circular Imports](http://stackabuse.com/python-circular-imports/) (2017-10-27) #ril
  - [PythonStyleGuide \- Launchpad Development](https://dev.launchpad.net/PythonStyleGuide#Circular_imports) 把其中一方的 import 移到 function/method 裡 (nested import)，並且在一開頭就加註是為了避開 circular imports 才這麼做的。
  - [Circular dependency in Python \- Stack Overflow](https://stackoverflow.com/questions/894864) (2009-05-21) "Python is not Java. You don't need one class per file." 點出了根本的問題，但不拆出來的話 `.py` 會變得太長而難以維護；或許 divide by module 會減少這種問題?
  - [Circular \(or cyclic\) imports in Python \- Stack Overflow](https://stackoverflow.com/questions/744373/) (2009-04-13) - 引用 Duncan Booth 的看法，另外也討論到 circular 的說法會比 cyclic 來得好。
  - [Coping with cyclic imports \- Google Groups](https://groups.google.com/forum/?fromgroups=#!topic/comp.lang.python/HYChxtsrhnw) (2008-04-09) - 最後導出 Duncan Booth 的看法，也就是這份文件最上頭引用的那一段話。
  - [Importing Python Modules](http://effbot.org/zone/import-confusion.htm) (1999-01-07) - circular import 應該避免，但小心安排的話是沒有問題的。對於 "Modules are executed during import" 這件事講得很清楚。
  - [java \- Reason for circular references with classes? \- Stack Overflow](https://stackoverflow.com/questions/10957694/) 說明在 Java 裡 circular class reference 其實很常見。這種狀況拆也拆不開(硬是拆出去變得難維護也不值得)，只能合併成一個 module？

  - 我們清楚知道應該避免 circular imports，例如把共用的部份另外抽出去。
  - 好像目前遇到的例子都是因為 class 的造成，parent class 某個方法內部的實作會引用到 subclass；但 subclass 又必須繼承 parent class。
  - 看似 one module per class 是 Java 帶過來的壞習慣？但不拆的話 .py 又太大而難以維護。
  - 常見的解法是把一方的 import 移到 function/method 內部，並在開頭加註這麼做是為了要避開 circular imports。

## 參考資料 {: #reference }

手冊：

  - [PEP 302 -- New Import Hooks](https://www.python.org/dev/peps/pep-0302/)
  - [PEP 328 -- Imports: Multi-Line and Absolute/Relative](https://www.python.org/dev/peps/pep-0328/)
