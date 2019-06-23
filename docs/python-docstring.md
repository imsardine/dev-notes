---
title: Python / Docstring (Documentation String)
---
# [Python](python.md) / Docstring

  - [docstring - Glossary — Python 3\.7\.3 documentation](https://docs.python.org/3/glossary.html#term-docstring) #ril
  - [triple-quoted string - Glossary — Python 3\.7\.3 documentation](https://docs.python.org/3/glossary.html#term-triple-quoted-string) #ril

  - [Defining Functions - 4\. More Control Flow Tools — Python 3\.7\.3 documentation](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)

    Defining Functions

      - The first statement of the function body can optionally be a string literal; this string literal is the function’s documentation string, or docstring. (More about docstrings can be found in the section Documentation Strings.)
      - There are tools which use docstrings to automatically produce online or printed documentation, or to let the user interactively browse through code; it’s good practice to include docstrings in code that you write, so MAKE A HABIT OF IT.

    Documentation Strings #ril

  - [8\. Compound statements — Python 3\.7\.3 documentation](https://docs.python.org/3/reference/compound_stmts.html)

      - A string literal appearing as the first statement in the function body is transformed into the function’s `__doc__` attribute and therefore the function’s docstring.
      - A string literal appearing as the first statement in the class body is transformed into the namespace’s `__doc__` item and therefore the class’s docstring.

  - [Future statements - 7\. Simple statements — Python 3\.7\.3 documentation](https://docs.python.org/3/reference/simple_stmts.html#future-statements)

    A future statement must appear near the top of the module. The only lines that can appear before a future statement are: the MODULE DOCSTRING (if any), ...

## 新手上路 {: #getting-started }

  - [Writing Docstrings - Documentation — The Hitchhiker's Guide to Python](https://docs.python-guide.org/writing/documentation/#writing-docstrings) #ril

## Convention ??

  - 大致上就是 Google-style + Sphinx + Napoleon plugin

---

參考資料：

  - [coding style \- What is the standard Python docstring format? \- Stack Overflow](https://stackoverflow.com/questions/3898572/)

      - Noah McIlraith: I have seen a few different styles of writing docstrings in Python, is there an official or "agreed-upon" style?
      - sorin: I think that this question was not clear enough because PEP-257 and PEP-8 are the establishing only the BASE for docstrings, but how about epydoc, doxygen, sphinx? Does anyone have any statistics, is one of them going to replace the others, in cases like this TOO MANY OPTIONS CAN HURT.

    daouzli: Formats

      - Python docstrings can be written following SEVERAL FORMATS as the other posts showed. However the default Sphinx docstring format was not mentioned and is based on reStructuredText (reST). You can get some information about the main formats in [that tuto](http://daouzli.com/blog/docstring.html).

        Note that the reST is RECOMMENDED by the [PEP 287](https://www.python.org/dev/peps/pep-0287) There follows the MAIN USED formats for docstrings.

        有點矛盾? 官方推薦 reST，但被廣為採用的又不是? 若是大部份網站都用 Sphinx 寫，docstring 用 reST 寫好像也合理 ??

      - Epytext

        HISTORICALLY a JAVADOC LIKE style was prevalent, so it was taken as a base for Epydoc (with the called Epytext format) to generate documentation. Example:

            """
            This is a javadoc style.

            @param param1: this is a first param
            @param param2: this is a second param
            @return: this is a description of what is returned
            @raise keyError: raises an exception
            """

      - reST

        NOWADAYS, the probably more prevalent format is the reStructuredText (reST) format that is used by Sphinx to generate documentation. Note: it is used BY DEFAULT IN JetBrains PyCharm (type triple quotes after defining a method and hit enter). It is also used by default as output format in [Pyment](https://github.com/dadadel/pyment). Example:

            """
            This is a reST style.

            :param param1: this is a first param
            :param param2: this is a second param
            :returns: this is a description of what is returned
            :raises keyError: raises an exception
            """

      - Google

        Google has their own format that is often used. It also can be interpreted by Sphinx (ie. using [Napoleon plugin](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/)). Example:

            """
            This is an example of Google style.

            Args:
                param1: This is the first param.
                param2: This is a second param.

            Returns:
                This is a description of what is returned.

            Raises:
                KeyError: Raises an exception.
            """

      - Numpydoc

        Note that Numpy recommend to follow their own [numpydoc](https://numpydoc.readthedocs.io/en/latest/) BASED ON GOOGLE FORMAT and usable by Sphinx.

            """
            My numpydoc description of a kind
            of very exhautive numpydoc format docstring.

            Parameters
            ----------
            first : array_like
                the 1st param name `first`
            second :
                the 2nd param
            third : {'value', 'other'}, optional
                the 3rd param, by default 'value'

            Returns
            -------
            string
                a value in a string

            Raises
            ------
            KeyError
                when a key error
            OtherError
                when an other error
            """

      - Converting/Generating

        It is possible to use a tool like Pyment to automatically generate docstrings to a Python project not yet documented, or to convert existing docstrings (can be mixing several formats) from a format to an other one.

        Note: The examples are taken from the Pyment documentation

    Nathan:

      - The Google style guide contains an excellent Python style guide. It includes conventions for readable docstring syntax that offers BETTER GUIDANCE than PEP-257. For example:

            def square_root(n):
                """Calculate the square root of a number.

                Args:
                    n: the number to get the square root of.
                Returns:
                    the square root of n.
                Raises:
                    TypeError: if n is not a number.
                    ValueError: if n is negative.

                """
                pass

        I like to extend this to also include type information in the arguments, as described in this Sphinx documentation tutorial. For example:

            def add_value(self, value):
                """Add a new value.

                   Args:
                       value (str): the value to add.
                """
                pass

  - [3.8 Comments and Docstrings - styleguide \| Style guides for Google\-originated open\-source projects](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)

    Be sure to use the right style for module, function, method docstrings and inline comments.

    Docstrings

      - Python uses docstrings to document code. A docstring is a string that is the first statement in a package, module, class or function. These strings can be extracted automatically through the `__doc__` member of the object and are used by `pydoc`. (Try running `pydoc` on your module to see how it looks.)

      - Always use the three double-quote `"""` format for docstrings (per PEP 257). A docstring should be organized as a SUMMARY LINE (one physical line) TERMINATED BY A PERIOD, QUESTION MARK, or EXCLAMATION POINT, followed by a BLANK LINE, followed by the rest of the docstring starting AT THE SAME CURSOR POSITION as the first quote of the first line. There are more formatting guidelines for docstrings below.

        "starting at the same cursor position ..." 指的是跟 `"""` 的左側對齊，而不是跟 summary line 的內容對齊。

        若 summary line 一定是以 `.?!` 結尾，是否表示 docstring 不能用中文寫 ??

    Modules

      - Every file should contain LICENSE BOILERPLATE. Choose the appropriate boilerplate for the license used by the project (for example, Apache 2.0, BSD, LGPL, GPL)

        這部份有辦法自動加嗎 ??

    Functions and Methods

      - In this section, “function” means a method, function, or generator.

        A function must have a docstring, unless it meets all of the following criteria:

          - NOT EXTERNALLY VISIBLE
          - very short
          - obvious

        如果不是 externally visible，就回歸到 naming 本身的可讀性。

      - A docstring should give enough information to write a call to the function WITHOUT READING THE FUNCTION’S CODE.

        The docstring should be DESCRIPTIVE ("""Fetches rows from a Bigtable.""") rather than IMPERATIVE ("""Fetch rows from a Bigtable.""").

        這一點跟 [Javadoc 的慣例](https://www.oracle.com/technetwork/articles/javase/index-137868.html)相同：

        > Use 3rd person (descriptive) not 2nd person (prescriptive). The description is in 3rd person declarative rather than 2nd person imperative.
        >
        > Gets the label. (preferred)
        >
        > Get the label. (avoid)

        所謂第 3 人稱，其實是[這裡](https://mail.python.org/pipermail/tutor/2012-May/089584.html)省略主詞的結果，例如 "[This function] returns the number of widgets in a set."。 #ril

      - A docstring should describe the function’s calling syntax and its SEMANTICS, NOT ITS IMPLEMENTATION. For TRICKY CODE, comments ALONGSIDE THE CODE are more appropriate than using docstrings.

      - A method that OVERRIDES a method from a base class may have a simple docstring SENDING THE READER TO ITS OVERRIDDEN METHOD’S DOCSTRING, such as """See base class.""".

        The rationale is that there is no need to repeat in many places documentation that is already present in the base method’s docstring. However, if the overriding method’s behavior is SUBSTANTIALLY DIFFERENT from the overridden method, or details need to be provided (e.g., documenting additional SIDE EFFECTS), a docstring with AT LEAST those differences is required on the overriding method.

      - CERTAIN ASPECTS of a function should be documented in special SECTIONS, listed below. Each section begins with a heading line, which ends with a colon. Sections should be INDENTED TWO SPACES, except for the heading. 但為什麼下面的例子是內縮 4 格 ??

        `Args:`

          - List each parameter by name. A description should follow the name, and be separated by a colon and a space.

            If the description is too long to fit on a single 80-character line, use a HANGING INDENT of 2 or 4 spaces (be consistent with the rest of the file).

          - The description SHOULD include REQUIRED TYPE(S) if the code does not contain a corresponding TYPE ANNOTATION. 什麼是 required type ??
          - If a function accepts `*foo` (variable length argument lists) and/or `**bar` (arbitrary keyword arguments), they should be listed as `*foo` and `**bar`.

        `Returns:` (or `Yields:` for generators)

          - Describe the TYPE and semantics of the return value.

          - If the function only returns `None`, this section is not required. It may also be omitted if the docstring starts with `Returns` or `Yields` (e.g. `"""Returns row from Bigtable as a tuple of strings."""`) and the opening sentence is sufficient to describe return value.

        Raises:

          - List all exceptions that are relevant to the interface.

    Classes

      - Classes should have a docstring below the class definition describing the class.

        If your class has PUBLIC ATTRIBUTES, they should be documented here in an `Attributes` section and follow the same formatting as a function’s `Args` section.

            class SampleClass(object):
                """Summary of class here.

                Longer class information....
                Longer class information....

                Attributes:
                    likes_spam: A boolean indicating if we like SPAM or not.
                    eggs: An integer count of the eggs we have laid.
                """

                def __init__(self, likes_spam=False):
                    """Inits SampleClass with blah."""
                    self.likes_spam = likes_spam
                    self.eggs = 0

                def public_method(self):
                    """Performs operation blah."""

        因為個別 attribute 不會有自己的 docstring。注意這份文件完全沒提到 reST，這裡的範例也用到任何 markup，是不是哪裡不太對 ??

    Block and Inline Comments

      - The final place to have comments is in TRICKY PARTS OF THE CODE. If you’re going to have to EXPLAIN IT at the next code review, you should COMMENT IT now. Complicated operations get a few lines of comments BEFORE the operations commence. NON-OBVIOUS ones get comments at the end of the line.

            # We use a weighted dictionary search to find out where i is in
            # the array.  We extrapolate position based on the largest num
            # in the array and the array size and then do binary search to
            # get the exact number.

            if i & (i-1) == 0:  # True if i is 0 or a power of 2.

      - To improve legibility, these comments should be AT LEAST 2 SPACES away from the code. 空兩格還滿特別的

      - On the other hand, NEVER DESCRIBE THE CODE. Assume the person reading the code knows Python (though not WHAT YOU’RE TRYING TO DO) better than you do.

            # BAD COMMENT: Now go through the b array and make sure whenever i occurs
            # the next element is i+1

    Punctuation, Spelling and Grammar

      - Pay attention to punctuation, spelling, and GRAMMAR; it is easier to read well-written comments than badly written ones.

      - Comments should be as readable as NARRATIVE TEXT, with proper capitalization and punctuation.

        In many cases, COMPLETE SENTENCES are more readable than SENTENCE FRAGMENTS. Shorter comments, such as comments at the end of a line of code, can sometimes be LESS FORMAL, but you should be consistent with your style.

      - Although it can be frustrating to have a code reviewer point out that you are using a comma when you should be using a semicolon, it is very important that source code maintain a high level of clarity and readability. Proper punctuation, spelling, and grammar help with that goal.

  - [PEP 8 \-\- Style Guide for Python Code \| Python\.org](https://www.python.org/dev/peps/pep-0008/)

    Maximum Line Length

      - For flowing long blocks of text with FEWER STRUCTURAL RESTRICTIONS (docstrings or comments), the line length should be limited to 72 characters.

        Some teams strongly prefer a longer line length. For code maintained exclusively or primarily by a team that can reach AGREEMENT on this issue, it is okay to increase the line length limit up to 99 characters, provided that comments and docstrings are still wrapped at 72 characters.

        原來 line length 對 code 跟 docstring/comment 的要求不同，但為什麼是 72，而且很堅持 (就算程式可以到 99 個字元) ??

      - The Python standard library is conservative and requires limiting lines to 79 characters (and docstrings/comments to 72).

    Source File Encoding

      - In the standard library, non-default encodings should be used only for test purposes or when a comment or docstring needs to mention an AUTHOR NAME that contains non-ASCII characters; otherwise, using `\x`, `\u`, `\U`, or `\N` escapes is the preferred way to include non-ASCII data in string literals.

        很尊重作者，作者用 escape 就無法一眼看出來了。

    Imports

      - Imports are always put at the top of the file, just AFTER any module comments and docstrings, and before module globals and constants.

    Module Level Dunder Names

      - Module level "dunders" (i.e. names with two leading and two trailing underscores) such as `__all__`, `__author__`, `__version__`, etc. should be placed after the module docstring but BEFORE ANY IMPORT STATEMENTS EXCEPT FROM `__future__` imports. Python mandates that future-imports must appear in the module before any other code except docstrings:

    Documentation Strings

      - Conventions for writing good documentation strings (a.k.a. "docstrings") are immortalized in PEP 257.

          - Write docstrings for all PUBLIC modules, functions, classes, and methods. Docstrings are not necessary for non-public methods, but you should HAVE A COMMENT THAT DESCRIBES WHAT THE METHOD DOES. This comment should appear after the `def` line.

            non-public method 在做什麼應該從 naming 就看得出來，或許應該說明的是 return value、side effect 等 ??

          - PEP 257 describes good docstring conventions. Note that most importantly, the `"""` that ends a multiline docstring should be ON A LINE BY ITSELF:

                """Return a foobang

                Optional plotz says to frobnicate the bizbaz first.
                """

          - For one liner docstrings, please keep the closing `"""` on the same line.

  - [The docstrings main formats](http://daouzli.com/blog/docstring.html) (2014-04-07) #ril

  - [PEP 257 \-\- Docstring Conventions \| Python\.org](https://www.python.org/dev/peps/pep-0257/) #ril
  - [Example Google Style Python Docstrings — napoleon 0\.7 documentation](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) #ril

## 工具 {: #tools }

  - [dadadel/pyment: Format and convert Python docstrings and generates patches](https://github.com/dadadel/pyment) #ril
  - [pydoc — Documentation generator and online help system — Python 3\.7\.3 documentation](https://docs.python.org/3/library/pydoc.html) #ril
  - [Epydoc](http://epydoc.sourceforge.net/) #ril
  - [Overview — Sphinx 3\.0\.0\+/f7bf66012 documentation](http://www.sphinx-doc.org/en/master/) #ril
  - [Doxygen: Main Page](http://www.doxygen.nl/) #ril

## doctest ??

  - [doctest — Test interactive Python examples — Python 3\.7\.3 documentation](https://docs.python.org/3/library/doctest.html) #ril

## 參考資料 {: #reference }

  - [Google Style Docstring](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)
  - [PEP 257 -- Docstring Conventions](https://www.python.org/dev/peps/pep-0257/)
  - [PEP 287 -- reStructuredText Docstring Format](https://www.python.org/dev/peps/pep-0287/)
