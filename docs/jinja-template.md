---
title: Jinja / Template
---
# [Jinja](jinja.md) / Template

  - [Template Designer Documentation — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/templates/) #ril

      - This document describes the syntax and semantics of the template engine and will be most useful as reference to those creating Jinja templates. As the template engine is very flexible, the configuration from the application can be slightly different from the code presented here in terms of delimiters and behavior of undefined values.

        因為 Jinja 強調 configurable，所以行為上會因 environment 的設定而異。

    Synopsis

      - A Jinja template is simply a text file. Jinja can generate ANY TEXT-BASED FORMAT (HTML, XML, CSV, LaTeX, etc.). A Jinja template doesn’t need to have a specific extension: `.html`, `.xml`, or any other extension is just fine.

        [python \- Is there an idiomatic file extension for Jinja templates? \- Stack Overflow](https://stackoverflow.com/questions/29590931/) 多數人同意 Ansible 採 `.j2` 的做法。

      - A template contains VARIABLES and/or EXPRESSIONS, which get replaced with values when a template is RENDERED; and TAGS, which control the LOGIC of the template. The template syntax is heavily inspired by Django and Python.

        注意 delimiter 與 tag 的不同，delimiter 指的是 `{% ... %}`、`{{ ... }}` 這些從 template 挖洞安插動態資料的部份，而 tag 則是指 `{% ... %}` 裡特有的 template language，例如 `for`、`include` 等。

      - Below is a minimal template that illustrates a few basics using the default Jinja configuration. We will cover the details later in this document:

            <!DOCTYPE html>
            <html lang="en">
            <head>
                <title>My Webpage</title>
            </head>
            <body>
                <ul id="navigation">
                {% for item in navigation %}
                    <li><a href="{{ item.href }}">{{ item.caption }}</a></li>
                {% endfor %}
                </ul>

                <h1>My Webpage</h1>
                {{ a_variable }}

                {# a comment #}
            </body>
            </html>

      - The following example shows the default configuration settings. An application developer can change the syntax configuration from `{% foo %}` to `<% foo %>`, or something similar.

        There are a few kinds of DELIMITERS. The default Jinja delimiters are configured as follows:

          - `{% ... %}` for Statements
          - `{{ ... }}` for Expressions to print to the template output
          - `{# ... #}` for Comments not included in the template output
          - `#  ... ##` for Line Statements

        原來有這麼多用法!! 最後一個 line statement 的應用情境 ??

    Comments

      - To comment-out part of a line in a template, use the comment syntax which is by default set to `{# ... #}`. This is useful to comment out parts of the template FOR DEBUGGING or to add information for other template designers or yourself:

            {# note: commented-out template because we no longer use this
                {% for user in users %}
                    ...
                {% endfor %}
            #}

        可以包含其他 delimiter。

    Whitespace Control

      - In the default configuration:

          - a single trailing newline is stripped if present

            實驗確認，這裡的 single trailing newline 指的是整個 template 的結尾，而非某個 block 的結尾處；符合 [`jinja2.Environment`](http://jinja.pocoo.org/docs/2.10/api/#high-level-api) 中 `keep_trailing_newline` option 的說法：

            > Preserve the trailing newline when rendering templates. The default is `False`, which causes a single newline, if present, to be stripped from THE END OF THE TEMPLATE.

          - other whitespace (spaces, tabs, newlines etc.) is returned unchanged

      - If an application configures Jinja to `trim_blocks`, the FIRST newline after a template tag is removed automatically (like in PHP). The `lstrip_blocks` option can also be set to strip tabs and spaces from the beginning of a line to the start of a block. (Nothing will be stripped if there are other characters before the start of the block.)

        這裡 block 好像不是專指 {% block %}` 而是泛指 `{% ... %}`? 實驗發現 "first newline after a template tag" 只會刪 `{% %}` 後面遇到的第一個 newline，但其他 whitespace 不會動，例如 `{% if True %}\n\t` 會留下 `\t`，但 `{% if True %}\t\n` 則會留下 `\t\n`，因為後者的 `\n` 沒有緊貼著 `%}`。

        With both `trim_blocks` and `lstrip_blocks` enabled, you can put BLOCK TAGS on their own lines, and the entire BLOCK LINE will be removed when rendered, preserving the whitespace of the contents. For example, without the `trim_blocks` and `lstrip_blocks` options, this template:

            <div>
                {% if True %}
                    yay
                {% endif %}
            </div>

        gets rendered with blank lines inside the div:

            <div>

                    yay

            </div>

        But with both `trim_blocks` and `lstrip_blocks` enabled, the template block lines are removed and other whitespace is preserved:

            <div>
                    yay
            </div>

        就如同那些 block tags 不曾存在過一樣。

      - You can manually disable the `lstrip_blocks` behavior by putting a plus sign (`+`) at the start of a block:

            <div>
                    {%+ if something %}yay{% endif %}
            </div>

      - You can also strip whitespace in templates BY HAND. If you add a minus sign (`-`) to the start or end of a block (e.g. a For tag), a comment, or a variable expression, the whitespaces before or after that block will be removed:

            {% for item in seq -%}
                {{ item }}
            {%- endfor %}

        This will yield all elements without whitespace between them. If `seq` was a list of numbers from 1 to 9, the output would be `123456789`.

        沒想到 variable expression (`{{ ... }}`) 的用法跟 whitespace 的去留也有關 ?? 實驗發現，這裡 by hand 的做法效果不等同於上面的 `trim_blocks` + `lstrip_blocks`，因為 `{%-` 或 `-%}` 會將鄰近其他行的 whitespace 也刪掉，有時候很難達到 "you can put block tags on their own lines" 的效果。

      - If Line Statements are enabled, they strip leading whitespace automatically up to the beginning of the line. ??

      - By default, Jinja2 also removes trailing newlines. To keep single trailing newlines, configure Jinja to `keep_trailing_newline`.

      - Note: You must NOT add whitespace between the tag and the minus sign.

        valid:

            {%- if foo -%}...{% endif %}

        invalid:

            {% - if foo - %}...{% endif %}

## Variable ??

  - [Variables - Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/#variables)

      - Template variables are defined by the CONTEXT DICTIONARY passed to the template.

      - You can MESS AROUND with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.

        You can use a dot (`.`) to access attributes of a variable in addition to the standard Python `__getitem__` “subscript” syntax (`[]`). The following lines do the same thing:

            {{ foo.bar }}
            {{ foo['bar'] }}

      - It’s important to know that the outer double-curly braces are not part of the variable, but the PRINT STATEMENT. If you access variables inside tags don’t put the braces around them.

        原來 `{{ ... }}` expression 等同於 print statement。

      - If a variable or attribute DOES NOT EXIST, you will get back an UNDEFINED VALUE. What you can do with that kind of value depends on the application configuration: the default behavior is to evaluate to an EMPTY STRING if printed OR ITERATED OVER, and to fail for every other operation.

        看似滿貼心的設計，但默默地吃掉錯誤，更難發現 template 本身的問題? 還好只有 print 與 iteration 時。

    Implementation

      - For the sake of convenience, `foo.bar` in Jinja2 does the following things on the Python layer:

          - check for an attribute called `bar` on `foo` (`getattr(foo, 'bar')`)
          - if there is not, check for an item `'bar'` in `foo` (`foo.__getitem__('bar')`)
          - if there is not, return an undefined object.

      - foo['bar'] works mostly the same with a small difference in sequence:

          - check for an item `'bar'` in `foo`. (`foo.__getitem__('bar')`)
          - if there is not, check for an attribute called `bar` on `foo`. (`getattr(foo, 'bar')`)
          - if there is not, return an undefined object.

        This is important if an object has an item and attribute with the same name. Additionally, the `attr()` filter only looks up attributes.

        也因此 `foo.bar` 與 `foo['bar']` 的用法是相通，差別只在先檢查 attribute 或 item。

  - [Notes on Identifiers - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#notes-on-identifiers) #ril
  - [The Global Namespace - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#the-global-namespace) #ril

## Filter ??

  - `int()` 屬於 builtin filter 而非 builtin global function，結果 `{% for page in range(int(cookiecutter.number_of_slides)) %}` 會出現 `int not defined` 的錯誤，非得用 `{% set number_of_slides = cookiecutter.number_of_slides | int %}` 先轉換過?

---

參考資料：

  - [Filters - Template Designer Documentation — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/templates/#filters)

      - Variables can be modified by filters. Filters are separated from the variable by a pipe symbol (`|`) and may have OPTIONAL ARGUMENTS in parentheses. Multiple filters can be CHAINED. The output of one filter is applied to the next.

        For example, `{{ name|striptags|title }}` will remove all HTML Tags from variable name and title-case the output (`title(striptags(name))`).

      - Filters that accept arguments have parentheses around the arguments, just like a function call. For example: `{{ listx|join(', ') }}` will join a list with commas (`str.join(', ', listx)`).

  - [Custom Filters - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#custom-filters) #ril

## Test ??

  - [Tests - Template Designer Documentation — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/templates/#tests)

      - Beside filters, there are also so-called “tests” available. Tests can be used to test a variable AGAINST A COMMON EXPRESSION.

        To test a variable or expression, you add `is` plus the NAME OF THE TEST after the variable. For example, to find out if a variable is DEFINED, you can do `name is defined`, which will then return true or false depending on whether name is defined in the current template context.

        除了固定用 `is` 接判斷，通常會搭配 `if` tag。

      - Tests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:

            {% if loop.index is divisibleby 3 %}
            {% if loop.index is divisibleby(3) %}

## Inheritance ??

  - [Inheritance - Template Designer Documentation — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/templates/#template-inheritance) #ril

## Macro ??

  - [Macros - Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/#macros)

      - Macro 就像是一般程式語言的 function，可以把慣用寫法 (idiom) 包裝成 reusable function (DRY)。例如：

            {% macro input(name, value='', type='text', size=20) -%}
                <input type="{{ type }}" name="{{ name }}" value="{{
                    value|e }}" size="{{ size }}">
            {%- endmacro %}

      - 用起來就像 function call 一樣 (in the namespace??)；看起來像 Python code，但其實不是。

            <p>{{ input('username') }}</p>
            <p>{{ input('password', type='password') }}</p>

      - 在 macro 裡，除了 macro 宣告的參數之外，還有些 special variables 可以調用： #ril

          - `varargs` (`list`) - 內有多出來的 (unconsumed) positional arguments。
          - `kwargs` (`dict`) - 內有多出來的 (unconsumed) keyword arguments。

      - 如果 macro name 以底線開頭，就不能被 export & import；只能在單一個 template 裡使用。

  - [My Macros are overridden by something - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#my-macros-are-overridden-by-something) #ril

## Template 裡不該有邏輯 ?? {: #less-logic-in-template }

  - [Isn’t it a terrible idea to put Logic into Templates? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#isn-t-it-a-terrible-idea-to-put-logic-into-templates)

      - Without a doubt you should try to remove as much logic from templates as possible. 大方向是，但並非絕對。
      - But templates without any logic mean that you have to do all the processing in the code which is boring and stupid. So some amount of logic is required in templates to KEEP EVERYONE HAPPY. Python 內建的 [`string.Template`](https://docs.python.org/3/library/string.html#string.Template) 就不支援 loop、if condition，在 developer 與 designer 間要取得一個平衡。
      - Jinja leaves it pretty much to you how much logic you want to put into templates. There are some restrictions in what you can do and what not. 自己決定要放多少 logic 進 template，但 Jinja 本身還是有限制，例如只允許少數的 Python expression (只是 template language 長得像而已?)，目的還是要讓 template 好維護、容易閱讀。

## 參考資料 {: #reference }

手冊：

  - [List of Builtin Filters](http://jinja.pocoo.org/docs/2.10/templates/#builtin-filters)
  - [List of Builtin Tests](http://jinja.pocoo.org/docs/2.10/templates/#builtin-tests)
