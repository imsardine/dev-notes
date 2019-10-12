# Sphinx

  - [Overview — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/)

      - Sphinx is a tool that makes it easy to create intelligent and beautiful documentation, written by Georg Brandl and licensed under the BSD license.

      - It was originally created for the [Python documentation](https://docs.python.org/), and it has excellent facilities for the documentation of software projects in A RANGE OF LANGUAGES. Of course, this site is also created from reStructuredText sources using Sphinx! The following features should be highlighted:

          - Output formats: HTML (including Windows HTML Help), LaTeX (for printable PDF versions), ePub, Texinfo, manual pages, plain text

          - Extensive CROSS-REFERENCES: semantic markup and AUTOMATIC links for functions, classes, citations, glossary terms and similar pieces of information

            若改用 Google Style Docstring，這些還會有嗎 ??

          - Hierarchical structure: easy definition of a DOCUMENT TREE, with automatic links to siblings, parents and children
          - Automatic indices: general index as well as a LANGUAGE-SPECIFIC module indices
          - Code handling: automatic highlighting using the Pygments highlighter

          - Extensions: automatic testing of code snippets, inclusion of docstrings from Python modules (API DOCS), and more

            API doc 只是 project documentation 的一部份而已。

          - Contributed extensions: more than 50 extensions contributed by users in a second repository; most of them installable from PyPI

      - Sphinx uses reStructuredText as its markup language, and many of its strengths come from the power and straightforwardness of reStructuredText and its parsing and translating suite, the [Docutils](http://docutils.sourceforge.net/).

        就算 Docstring 改用 Google style 寫，API doc 以外的文件還是得用 reStructuredText 寫? 事實上 Google style 裡的 formatting 也是 reStructuredText。

    Examples

      - Links to documentation generated with Sphinx can be found on the Projects using Sphinx page.
      - For examples of how Sphinx SOURCE FILES look, use the “Show source” links on all pages of the documentation apart from this welcome page.

    Hosting

      - Need a place to host your Sphinx docs? readthedocs.org hosts a lot of Sphinx docs already, and INTEGRATES well with projects' source control. It also features a powerful BUILT-IN SEARCH that exceeds the possibilities of Sphinx' JAVASCRIPT-BASED OFFLINE SEARCH.

  - [Sphinx \(documentation generator\) \- Wikipedia](https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)) #ril

## 應用實例 {: #powered-by }

  - [Python 2\.7\.16 documentation](https://docs.python.org/2/) / [3\.7\.3 Documentation](https://docs.python.org/3/)
  - [Projects using Sphinx — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/examples.html)

## 新手上路 {: #getting-started }

這裡以 Python docstring (用 Google style) 為例，說明如何產生 API doc。專案結構如下：

```
$ tree -F
.
├── docs/
│   ├── api/
│   └── site/
├── pypkg/
│   └── __init__.py
├── setup.py
└── tests/
    └── __init__.py

5 directories, 3 files

$ cat pypkg/__init__.py
def hello(who=None):
    """Says hello to someone.

    Args:
      who (str): Someone you want to say hello to. Defaults to ``World``

    Returns:
      str: A greeting.
    """
    who = 'World' if who is None else who
    return 'Hello, %s!' % who
```

 1. 用 `sphinx-apidoc` 產生 Sphinx source 在 `docs/api`，裡面會安排好 `autodoc`：

        $ sphinx-apidoc -o docs/api --full . setup.py tests/
        Creating file docs/api/pypkg.rst.
        Creating file docs/api/conf.py.
        Creating file docs/api/index.rst.
        Creating file docs/api/Makefile.
        Creating file docs/api/make.bat.

    其中 `. setup.py tests` 會從當前的目錄找 Python package，但不含 `setup.py` 與 `tests/`。

 2. 在 `docs/api/conf.py` 裡啟用 Napoleon plugin：

        extensions = [
            'sphinx.ext.autodoc',
            ...
            'sphinx.ext.napoleon',
        ]

 3. 用 `sphinx-build` 產生 HTML API doc 到 `build/apidocs/`：

        $ PYTHONPATH=$(PWD) sphinx-build -b html docs/api build/apidocs
        Running Sphinx v1.8.5
        loading translations [en]... done
        making output directory...
        building [mo]: targets for 0 po files that are out of date
        building [html]: targets for 2 source files that are out of date
        updating environment: 2 added, 0 changed, 0 removed
        reading sources... [100%] pypkg
        looking for now-outdated files... none found
        pickling environment... done
        checking consistency... done
        preparing documents... done
        writing output... [100%] pypkg
        generating indices... genindex py-modindex
        highlighting module code... [100%] pypkg
        writing additional pages... search
        copying static files... done
        copying extra files... done
        dumping search index in English (code: en) ... done
        dumping object inventory... done
        build succeeded.

        The HTML pages are in build/apidocs.

    開啟 `build/apidocs/index.html` 就可以看到 API doc，結果就像：

        pypkg.hello(who=None)                                            [source]
          Says hello to someone.

          Parameters:  who (str) – Someone you want to say hello to. Defaults to World
          Returns:     A greeting.
          Return type: str

 4. 首頁的內容來自 `docs/api/index.rst`，用 reStructuredText 補上一些敘述性的文字，就更完整了。

        $ cat docs/api/index.rst
        .. pylib documentation master file, created by
           sphinx-quickstart on Sat Jun  1 16:43:25 2019.
           You can adapt this file completely to your liking, but it should at least
           contain the root `toctree` directive.

        Welcome to pylib's documentation!
        =================================

        .. toctree::
           :maxdepth: 4
           :caption: Contents:

           pypkg


        Indices and tables
        ==================

        * :ref:`genindex`
        * :ref:`modindex`
        * :ref:`search`

---

參考資料：

  - [Getting Started — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/quickstart.html) #ril

      - Once Sphinx is installed, you can proceed with setting up your first Sphinx project. To ease the process of getting started, Sphinx provides a tool, `sphinx-quickstart`, which will generate a documentation source directory and populate it with some defaults. We’re going to use the `sphinx-quickstart` tool here, though its use is by no means necessary.

    Setting up the documentation sources

      - The root directory of a Sphinx collection of reStructuredText document sources is called the SOURCE DIRECTORY. This directory also contains the Sphinx configuration file `conf.py`, where you can configure ALL ASPECTS of how Sphinx reads your sources and builds your documentation.

        This is the usual layout. However, `conf.py` can also live in another directory, the configuration directory. Refer to the `sphinx-build` man page for more information.

      - Sphinx comes with a script called `sphinx-quickstart` that sets up a source directory and creates a default `conf.py` with the most useful configuration values from a few questions it asks you. To use this, run:

            $ sphinx-quickstart

        Answer each question asked. Be sure to say “yes” to the `autodoc` extension, as we will use this later.

      - There is also an automatic “API documentation” generator called `sphinx-apidoc`; see `sphinx-apidoc` for details.

        `sphinx-apidoc` 是自動產生內含 `autodoc` 的 Sphinx source (並沒有抄寫 docstring)，跟把 Sphinx source 視為 input 的 `sphinx-build` 不同。

    Defining document structure

      - Let’s assume you’ve run `sphinx-quickstart`. It created a source directory with `conf.py` and a MASTER DOCUMENT, `index.rst` (if you accepted the defaults).

        The main function of the master document is to serve as a WELCOME PAGE, and to contain the root of the “table of contents tree” (or toctree). This is one of the main things that Sphinx ADDS to reStructuredText, a way to CONNECT multiple files to a SINGLE HIERARCHY OF DOCUMENTS.

      - The `toctree` directive initially is empty, and looks like so:

            .. toctree::
               :maxdepth: 2

        You add documents listing them in the CONTENT of the directive:

            .. toctree::
               :maxdepth: 2

               usage/installation
               usage/quickstart
               ...

        (Directive 的 content 與 options 間會隔一行空白)

      - This is exactly how the toctree for this documentation looks. The documents to include are given as DOCUMENT NAMES, which in short means that you leave off the file name extension and use forward slashes (`/`) as directory separators.

      - You can now create the files you listed in the toctree and add content, and their SECTION TITLES will be inserted (up to the `maxdepth` level) at the place where the `toctree` directive is placed. Also, Sphinx now knows about the ORDER and HIERARCHY of your documents.

        (They may contain `toctree` directives themselves, which means you can create DEEPLY NESTED HIERARCHIES if necessary.)

    Adding content

      - In Sphinx source files, you can use most features of standard reStructuredText. There are also several features ADDED BY SPHINX.

        For example, you can add cross-file references in a PORTABLE WAY (which works for all output types) using the `ref` ROLE. ??

      - For an example, if you are viewing the HTML version, you can look at the source for this document – use the “Show Source” link in the sidebar. 這就是 cross-file reference ??

    Running the build

      - Now that you have added some files and content, let’s make a first build of the docs. A build is started with the `sphinx-build` program:

            $ sphinx-build -b html sourcedir builddir

        where `sourcedir` is the source directory, and `builddir` is the directory in which you want to place the built documentation. The `-b` option selects a BUILDER; in this example Sphinx will build HTML files.

      - However, `sphinx-quickstart` script creates a `Makefile` and a `make.bat` which make life even easier for you. These can be executed by running `make` with the name of the builder. For example.

            $ make html

        This will build HTML docs in the build directory you chose. Execute `make` without an argument to SEE WHICH TARGETS ARE AVAILABLE.

      - How do I generate PDF documents? `make latexpdf` runs the LaTeX builder and readily invokes the pdfTeX toolchain for you.

    Documenting objects

      - One of Sphinx’s main objectives is easy documentation of OBJECTS (in a very general sense) in ANY DOMAIN.

        A domain is a collection of object types that belong together, complete with markup to create and reference descriptions of these objects.

      - The most prominent domain is the PYTHON DOMAIN. For example, to document Python’s built-in function `enumerate()`, you would add this to one of your source files.

            .. py:function:: enumerate(sequence[, start=0])

               Return an iterator that yields tuples of an index and an item of the
               *sequence*. (And so on.)

        This is rendered like this:

            enumerate(sequence[, start=0])
            Return an iterator that yields tuples of an index and an item of the sequence. (And so on.)

        The argument of the directive is the SIGNATURE of the object you describe, the content is the documentation for it. MULTIPLE SIGNATURES can be given, each in its own line.

        [Domains — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html) 除了 Python domain，還有 C domain、C++ domain 等。

        這是自己用 reStructuredText directive 寫文件，但如果是寫在 Python source code 裡的 docstring 呢 --> `autodoc` extension + Napoleon pre-processor。

      - The Python domain also happens to be the DEFAULT DOMAIN, so you don’t need to prefix the markup with the domain name.

            .. function:: enumerate(sequence[, start=0])

               ...

        does the same job if you keep the default setting for the default domain.

        所以 `py:function::` 中的 `py:function` 一樣是 directive type，而 `py:` 是 domain；當 domain 是 Python (`py:`) 時，domain 可以省略。

      - There are several more directives for documenting other types of Python objects, for example `py:class` or `py:method`.

        There is also a cross-referencing role for each of these object types. This markup will create a link to the documentation of `enumerate()`.

            The :py:func:`enumerate` function can be used for ...

        And here is the proof: A link to [enumerate()](http://www.sphinx-doc.org/en/master/usage/quickstart.html#enumerate). 直接連回上述 "This is rendered like this:" 的地方。

      - Again, the `py:` can be left out if the Python domain is the default one. It doesn’t matter which file contains the actual documentation for `enumerate()`; Sphinx will find it and create a link to it.

      - Each domain will have special rules for how the signatures can look like, and make the formatted output look pretty, or add specific features like links to parameter types, e.g. in the C/C++ domains.

        more info See Domains for all the available domains and their directives/roles.

  - [An idiot’s guide to Python documentation with Sphinx and ReadTheDocs – Samposium](https://samnicholls.net/2016/06/15/how-to-sphinx-readthedocs/) (2016-06-15) #ril

## Configuration ??

  - [Basic configuration - Getting Started — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/quickstart.html#basic-configuration) #ril
  - [Configuration — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/configuration.html) #ril

## Domain ??

  - [Domains — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html) #ril

## Docstring, Google Style ??

  - [Autodoc - Getting Started — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/quickstart.html#autodoc)

      - When documenting Python code, it is common to put a lot of documentation in the source files, in documentation strings. Sphinx supports the INCLUSION OF DOCSTRINGS FROM YOUR MODULES with an extension (an extension is a Python module that provides additional features for Sphinx projects) called `autodoc`.

        概念上是把 Python source 的 signature 及 docstring 引到 Sphinx 文件裡來，在 build time 將 API doc 併入一般文件內容。

        如果單純是引入 docstring，也就預期 docstring 用 reStructuredText 語法寫；所以就算啟用 Napoleon plugin 可以用 Google style 寫 docstring，Sphinx 實際上拿到的還是即時轉換過的 reStructuredText。

      - In order to use `autodoc`, you need to ACTIVATE it in `conf.py` by putting the string `sphinx.ext.autodoc` into the list assigned to the `extensions` config value. Then, you have a few additional directives at your disposal.

      - For example, to document the function `io.open()`, READING its signature and docstring from the source file, you’d write this:

            .. autofunction:: io.open

        You can also document whole classes or even modules automatically, using member options for the auto directives, like

            .. automodule:: io
               :members:

      - `autodoc` needs to IMPORT your modules in order to extract the docstrings. Therefore, you must add the appropriate path to `sys.path` in your `conf.py`.

        在 `sphinx-quickstart` 產生的 `conf.py` 有這麼一段：

            # -- Path setup --------------------------------------------------------------

            # If extensions (or modules to document with autodoc) are in another directory,
            # add these directories to sys.path here. If the directory is relative to the
            # documentation root, use os.path.abspath to make it absolute, like shown here.
            #
            # import os
            # import sys
            # sys.path.insert(0, os.path.abspath('.'))

        所謂 another directory 是指 "modules to document with autodoc" 不在 Sphinx 自己的 source directory 底下，也之所以範例才會用 `os.path.abspath('.')`。用 [`PYTHONPATH` 環境變數](https://github.com/sphinx-doc/sphinx/issues/2390)就不用操作 `sys.path` 了 (有點髒)。

        若 Sphinx + `autodoc` 在 build time 會走過程式 -- 要能 import 成功，就需要執行在 tox 管理的 virtualenv 裡才行；這表示 Sphinx 無法由事先安裝好的 Docker image 提供。

    Warning

      - `autodoc` imports the modules to be documented. If any modules have SIDE EFFECTS on import, these will be executed by `autodoc` when `sphinx-build` is run.

        本來設定上 import time 就不該做事，否則單元測試也會有問題。

      - If you document SCRIPTS (as opposed to library modules), make sure their `main` routine is protected by a if `__name__ == '__main__'` condition.

      - more info See `sphinx.ext.autodoc` for the complete description of the features of `autodoc`.

  - [Release 1.3b1 (released Oct 10, 2014) - Changes in Sphinx — Sphinx 3\.0\.0\+/f7bf66012 documentation](https://www.sphinx-doc.org/en/master/changes.html#release-1-3b1-released-oct-10-2014)

    Added `sphinx.ext.napoleon` extension for NumPy and Google style docstring support.

  - [sphinx\.ext\.napoleon – Support for NumPy and Google style docstrings — Sphinx 3\.0\.0\+/f7bf66012 documentation](https://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html) #ril

    Overview

      - Are you TIRED of writing docstrings that look like this:

            :param path: The path of the file to wrap
            :type path: str
            :param field_storage: The :class:`FileStorage` instance to wrap
            :type field_storage: FileStorage
            :param temporary: Whether or not to delete the file when the File
               instance is destructed
            :type temporary: bool
            :returns: A buffered writable file descriptor
            :rtype: BufferedFileStorage

        reStructuredText is great, but it creates VISUALLY DENSE, HARD TO READ docstrings. Compare the jumble above to the same thing rewritten according to the Google Python Style Guide:

            Args:
                path (str): The path of the file to wrap
                field_storage (FileStorage): The :class:`FileStorage` instance to wrap
                temporary (bool): Whether or not to delete the file when the File
                   instance is destructed

            Returns:
                BufferedFileStorage: A buffered writable file descriptor

        Much more legible, no? 原本用一堆 directive option 來描述，確實很亂!!

      - Napoleon is a extension that enables Sphinx to parse both NumPy and Google style docstrings - the style recommended by [Khan Academy](https://github.com/Khan/style-guides/blob/master/style/python.md#docstrings). #ril

      - Napoleon is a PRE-PROCESSOR that parses NumPy and Google style docstrings and CONVERTS THEM TO reStructuredText before Sphinx attempts to parse them.

        This happens in an intermediate step while Sphinx is processing the documentation, so it doesn’t modify any of the docstrings in your actual source code files.

        原來如此，用 `autodoc` 引入 Sphinx 文件的，還是 reStructuredText，只不過是動態將 Google style 轉換的結果。

    Getting Started

      - After setting up Sphinx to build your docs, enable napoleon in the Sphinx `conf.py` file:

            # conf.py

            # Add napoleon to the extensions list
            extensions = ['sphinx.ext.napoleon']

      - Use `sphinx-apidoc` to build your API documentation:

            $ sphinx-apidoc -f -o docs/source projectdir

        若用 `sphinx-build` 則要有一份 Sphinx 文件用 `autodoc` directive 引用 docstring。安排在 `docs/source`，看起來就是要進 version control。

        [python \- Which files should I tell my VCS to ignore when using Sphinx for documentation? \- Stack Overflow](https://stackoverflow.com/questions/9570382)

        > jcollado: If you take a look at the contents of `Makefile` you'll see something as follows: ... This means that `make clean` just removes the build directory so, with regard to version control, ignoring the contents of the build directory should be enough as you already suspected.

    Docstrings

      - Napoleon interprets every docstring that `autodoc` can find, including docstrings on: modules, classes, attributes, methods, functions, and variables.

      - Inside each docstring, specially formatted Sections are parsed and converted to reStructuredText.

        All standard reStructuredText formatting still works as expected.

        也就是說，Google style 用比較好讀的編排取代 directive options 的用法，其餘還是 reStructuredText 的用法 (可以是 markdown 嗎 ??)；在裡面要如何引用其他 Python object ??

    Docstring Sections

      - All of the following section headers are supported:

          - Args (alias of Parameters)
          - Arguments (alias of Parameters)
          - Attention
          - Attributes
          - Caution
          - Danger
          - Error
          - Example
          - Examples
          - Hint
          - Important
          - Keyword Args (alias of Keyword Arguments)
          - Keyword Arguments
          - Methods
          - Note
          - Notes
          - Other Parameters
          - Parameters
          - Return (alias of Returns)
          - Returns
          - Raises
          - References
          - See Also
          - Tip
          - Todo
          - Warning
          - Warnings (alias of Warning)
          - Warns
          - Yield (alias of Yields)
          - Yields

    Google vs NumPy

      - Napoleon supports two styles of docstrings: Google and NumPy. The main difference between the two styles is that Google uses INDENTATION to separate sections, whereas NumPy uses UNDERLINES.

        Google style:

            def func(arg1, arg2):
                """Summary line.

                Extended description of function.

                Args:
                    arg1 (int): Description of arg1
                    arg2 (str): Description of arg2

                Returns:
                    bool: Description of return value

                """
                return True

        NumPy style:

            def func(arg1, arg2):
                """Summary line.

                Extended description of function.

                Parameters
                ----------
                arg1 : int
                    Description of arg1
                arg2 : str
                    Description of arg2

                Returns
                -------
                bool
                    Description of return value

                """
                return True

      - NumPy style tends to require MORE VERTICAL SPACE, whereas Google style tends to use more horizontal space. Google style tends to be easier to read for SHORT AND SIMPLE DOCSTRINGS, whereas NumPy style tends be easier to read for LONG AND IN-DEPTH DOCSTRINGS.

        The [Khan Academy](https://github.com/Khan/style-guides/blob/master/style/python.md#docstrings) recommends using Google style.

      - The choice between styles is largely aesthetic, but the two styles should not be mixed. Choose one style for your project and be consistent with it.

        For complete examples:

          - [Example Google Style Python Docstrings](https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html)
          - [Example NumPy Style Python Docstrings](https://www.sphinx-doc.org/en/master/usage/extensions/example_numpy.html)

        因為 Google style 用內縮來區分 section，所以水平空間被壓縮了；就 module docstring 而言，NumPy style 比較好讀，但 function/method docstring 則是 Google style 比較好讀，可惜這兩者不能混用。

    Type Annotations

      - PEP 484 introduced a standard way to express types in Python code. This is an alternative to expressing types directly in docstrings. One benefit of expressing types according to PEP 484 is that type checkers and IDEs can take advantage of them for STATIC CODE ANALYSIS.

      - Google style with Python 3 type annotations:

            def func(arg1: int, arg2: str) -> bool:
                """Summary line.

                Extended description of function.

                Args:
                    arg1: Description of arg1
                    arg2: Description of arg2

                Returns:
                    Description of return value

                """
                return True

        Google style with types in docstrings:

            def func(arg1, arg2):
                """Summary line.

                Extended description of function.

                Args:
                    arg1 (int): Description of arg1
                    arg2 (str): Description of arg2

                Returns:
                    bool: Description of return value

                """
                return True

        做為 library，若要同時滿足 Python 2 & 3，也只好將 type 寫在 docstring 裡。

      - Note: [Python 2/3 compatible annotations](https://www.python.org/dev/peps/pep-0484/#suggested-syntax-for-python-2-7-and-straddling-code) aren’t currently supported by Sphinx and won’t show up in the docs.

  - [sphinx\-apidoc — Sphinx 3\.0\.0\+/ce3c5735c documentation](http://www.sphinx-doc.org/en/master/man/sphinx-apidoc.html)

    Synopsis

        sphinx-apidoc [OPTIONS] -o <OUTPUT_PATH> <MODULE_PATH> [EXCLUDE_PATTERN, …]

    Description

      - `sphinx-apidoc` is a tool for automatic generation of SPHINX SOURCES that, using the `autodoc` extension, document a whole package in the style of other automatic API documentation tools.

        只是產生 Sphinx source，之後還是得交由 `sphinx-build` 去 build；搭配 `--full` 就不用自己寫 `conf.py`。

      - `MODULE_PATH` is the path to a Python package to document, and `OUTPUT_PATH` is the directory where the generated sources are placed.

        這裡 "path to a Python package to document" 的說法有點怪，尤其搭配 `-a` 使用時，會將該路徑加入 Python 的 module search path。所以是 package 的上層，例如 `path/to/myproj/pypkg/__init__.py`，`MODULE_PATH` 應指向 `path/to/myproj/` 而非 `path/to/myproj/pypkg/`。

        Any `EXCLUDE_PATTERN`s given are fnmatch-style file and/or directory patterns that will be excluded from generation.

      - Warning: `sphinx-apidoc` generates source files that use `sphinx.ext.autodoc` to document all found modules. If any modules have side effects on import, these will be executed by autodoc when `sphinx-build` is run.

        If you document scripts (as opposed to library modules), make sure their `main` routine is protected by a `if __name__ == '__main__'` condition.

    Options

      - `-o <OUTPUT_PATH>`

        Directory to place the output files. If it does not exist, it is created.

      - `-f, --force`

        Force overwriting of any existing generated files.

      - `-l, --follow-links`

        Follow symbolic links.

      - `-n, --dry-run`

        Do not create any files.

      - `-s <suffix>`

        Suffix for the source files generated. Defaults to `rst`.

      - `-d <MAXDEPTH>`

        Maximum depth for the generated TABLE OF CONTENTS file.

      - `--tocfile`

        Filename for a table of contents file. Defaults to `modules`.

      - `-T, --no-toc`

        Do not create a table of contents file. Ignored when `--full` is provided.

      - `-F, --full`

        Generate a full Sphinx project (`conf.py`, `Makefile` etc.) using the same mechanism as `sphinx-quickstart`.

        對於只想拿 Sphinx 來產生 API doc 而非 project site 時，這很方便 (只有第一次會用到)；不過因為跟 `sphinx-quickstart` 的機制一樣，所以產生出來的 `conf.py` 也很雜。

      - `-e, --separate`

        Put documentation for each module on its own page.

        New in version 1.2.

      - `-E, --no-headings`

        Do not create headings for the modules/packages. This is useful, for example, when docstrings already contain headings.

      - `-P, --private`

        Include `_private` modules.

        New in version 1.2.

      - `--implicit-namespaces`

        By default `sphinx-apidoc` processes `sys.path` searching for modules only. Python 3.3 introduced PEP 420 implicit namespaces that allow module path structures such as `foo/bar/module.py` or `foo/bar/baz/__init__.py` (notice that bar and foo are namespaces, not modules). ??

        Interpret paths recursively according to PEP-0420.

      - `-M, --module-first`

        Put module documentation BEFORE SUBMODULE documentation.

        These options are used when `--full` is specified:

      - `-a`

        Append `module_path` to `sys.path`.

        搭配 `-F, --full` 時才會有作用，產生的 `conf.py` 裡，會直接將 `MODULE_PATH` 的 "絕對路徑"，一開始就加到 `sys.path` 裡，所以實用性不高。例如：

            sys.path.insert(0, u'/path/to/mylib')

      - `-H <project>`

        Sets the project name to put in generated files (see project).

      - `-A <author>`

        Sets the author name(s) to put in generated files (see copyright).

      - `-V <version>`

        Sets the project version to put in generated files (see version).

      - `-R <release>`

        Sets the project release to put in generated files (see release).

    Environment

      - `SPHINX_APIDOC_OPTIONS`

        A comma-separated list of option to append to generated `automodule` directives. Defaults to `members,undoc-members,show-inheritance`.

  - [sphinx\.ext\.autodoc – Include documentation from docstrings — Sphinx 3\.0\.0\+/f7bf66012 documentation](https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html) #ril

## tox Integration {: #tox }

  - [Generate documentation — tox 3\.12\.2\.dev5 documentation](https://tox.readthedocs.io/en/latest/example/documentation.html) #ril

    It’s possible to generate the projects documentation with tox itself. The advantage of this path is that now generating the documentation can be part of the CI, and whenever any validations/checks/operations fail while generating the documentation you’ll catch it within tox.


  - [Running unittest2 and sphinx tests in one go - unittest2, discover and tox — tox 3\.12\.2\.dev6 documentation](https://tox.readthedocs.io/en/latest/example/unittest.html#running-unittest2-and-sphinx-tests-in-one-go) Sphinx test ?? #ril
  - [Integrating “sphinx” documentation checks in a Jenkins job - Using tox with the Jenkins Integration Server — tox 3\.12\.2\.dev6 documentation](https://tox.readthedocs.io/en/latest/example/jenkins.html#integrating-sphinx-documentation-checks-in-a-jenkins-job) #ril

## Markdown ??

  - [Markdown — Sphinx 3\.0\.0\+/ce3c5735c documentation](https://www.sphinx-doc.org/en/master/usage/markdown.html)

      - Markdown is a lightweight markup language with a simplistic plain text formatting syntax. It exists in many syntactically different flavors. To support Markdown-based documentation, Sphinx can use [recommonmark](https://recommonmark.readthedocs.io/en/latest/index.html).

        recommonmark is a Docutils BRIDGE to CommonMark-py, a Python package for parsing the CommonMark Markdown flavor.

    Configuration

      - To configure your Sphinx project for Markdown support, proceed as follows:

      - Install the Markdown parser `recommonmark`:

            pip install --upgrade recommonmark

        Note: The configuration as explained here requires recommonmark version 0.5.0 or later.

      - Add `recommonmark` to the list of configured extensions:

            extensions = ['recommonmark']

        Changed in version 1.8: Version 1.8 deprecates and version 3.0 removes the `source_parsers` configuration variable that was used by older recommonmark versions.

      - If you want to use Markdown files with extensions other than `.md`, adjust the `source_suffix` variable. The following example configures Sphinx to parse all files with the extensions `.md` and `.txt` as Markdown:

            source_suffix = {
                '.rst': 'restructuredtext',
                '.txt': 'markdown',
                '.md': 'markdown',
            }

      - You can further configure recommonmark to allow custom syntax that standard CommonMark doesn’t support. Read more in the recommonmark documentation.

## 安裝設置 {: #setup }

  - [Installation from PyPI - Installing Sphinx — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/usage/installation.html#installation-from-pypi)

      - Sphinx packages are published on the Python Package Index. The preferred tool for installing packages from PyPI is `pip`. This tool is provided with all modern versions of Python.

      - On Linux or MacOS, you should open your terminal and run the following command.

            $ pip install -U sphinx

        On Windows, you should open Command Prompt (⊞Win-r and type `cmd`) and run the same command.

            C:\> pip install -U sphinx

      - After installation, type `sphinx-build --version` on the command prompt. If everything worked fine, you will see the version number for the Sphinx package you just installed.

## 參考資料 {: #reference }

  - [Sphinx](http://www.sphinx-doc.org/en/master/)
  - [sphinx-doc/sphinx - GitHub](https://github.com/sphinx-doc/sphinx)
  - [Sphinx - PyPI](https://pypi.python.org/pypi/Sphinx)

社群：

  - ['python-sphinx' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/python-sphinx)

相關：

  - Sphinx 的語法是基於 [reStructuredText](rst.md) 再進行擴充。

手冊：

  - [`sphinx-build`](http://www.sphinx-doc.org/en/master/man/sphinx-build.html)
  - [`sphinx-apidoc`](http://www.sphinx-doc.org/en/master/man/sphinx-apidoc.html)
  - [`sphinx-autogen`](https://www.sphinx-doc.org/en/master/man/sphinx-autogen.html)
