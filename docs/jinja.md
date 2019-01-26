# Jinja

  - [Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/) Jinja 的命名源自日本的[神社](https://zh.wikipedia.org/wiki/%E7%A5%9E%E7%A4%BE) (平文式羅馬字為 "Jinjia")，且 "temple" 與 "template" 的發音近似，跟烏干達的城市 Jinja 無關；也難怪 Jinja 官網的圖示是 "鳥居"。
  - [Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/)
      - 是個 template engine for Python
      - Jinja2 is one of the most used template engines for Python. 這句話所言不假，例如 Ansible、Cookiecutte、Flask 都以它為 template engine。
      - 靈感來自 Django 的 templating system，在那之上額外提供了 expressive language、sandboxed execution、automatic escaping 等。
  - [Introduction — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/intro/)
      - 一開始就提到 "GENERAL purpose templating language"，確實它被廣泛應用在許多領域，不限定在 HTML。
      - 再次強調  both designer and developer friendly -- sticking to Python’s principles and adding functionality useful for templating environments 同時顧到了 developer & designer
  - [Welcome to Jinja2 — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/) Jinja2 is a modern and DESIGNER-FRIENDLY templating language for Python, modelled after Django’s templates，但 designer-friendly 實質上指的是什麼??
  - [Releases · pallets/jinja](https://github.com/pallets/jinja/releases) 最早一個 release 是 2008-06-10 的 2.0rc1
  - [Jinja (template engine) \- Wikipedia](https://en.wikipedia.org/wiki/Jinja_(template_engine)) #ril

## Template 裡不該有邏輯 ?? {: #less-logic-in-template }

  - [Isn’t it a terrible idea to put Logic into Templates? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#isn-t-it-a-terrible-idea-to-put-logic-into-templates)
      - Without a doubt you should try to remove as much logic from templates as possible. 大方向是，但並非絕對。
      - But templates without any logic mean that you have to do all the processing in the code which is boring and stupid. So some amount of logic is required in templates to KEEP EVERYONE HAPPY. Python 內建的 [`string.Template`](https://docs.python.org/3/library/string.html#string.Template) 就不支援 loop、if condition，在 developer 與 designer 間要取得一個平衡。
      - Jinja leaves it pretty much to you how much logic you want to put into templates. There are some restrictions in what you can do and what not. 自己決定要放多少 logic 進 template，但 Jinja 本身還是有限制，例如只允許少數的 Python expression (只是 template language 長得像而已?)，目的還是要讓 template 好維護、容易閱讀。

## Hello, World!

```
from jinja2 import Template

def test_hello_world(py2):
    template = Template('Hello, {{ name }}!')
    context = {'name': 'World'}

    out = template.render(context)

    unicode_type = unicode if py2 else str
    assert out == 'Hello, World!'
    assert type(out) == unicode_type
```

## 新手上路 ?? {: #getting-started }

## Templating (API), Developer-friendly ??

  - [Basic API Usage - Introduction — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/intro/#basic-api-usage)
      - 最基本的方法就是建立 `jinja2.Template`，並透過 `render()` 來畫出 unicode：

```
>>> from jinja2 import Template
>>> template = Template('Hello {{ name }}!')
>>> template.render(name='John Doe')
u'Hello John Doe!' <-- 一再強調 Jinja2 內部用 unicode
```

      - `render()` 可以傳入 dict 或 keyword arguments -- 所謂的 "context" (of the template) -- 據以展開 (expand) template。

  - [API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/) #ril
  - [Unicode - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#unicode) #ril

## Context ??

  - [Why is the Context immutable? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#why-is-the-context-immutable) #ril
  - [The Context - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#the-context)

## Template (Syntax), Designer-friendly ??

  - [Jinja is Beautiful - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#jinja-is-beautiful) 從 Jinja is Beautiful 的範例看來，template 都在 `{% ... %}` 與 `{{ ... }}` 裡，另外也支援 template inheritance。

    ```
{% extends "layout.html" %}
{% block body %}
  <ul>
  {% for user in users %}
    <li><a href="{{ user.url }}">{{ user.username }}</a></li>
  {% endfor %}
  </ul>
{% endblock %}
    ```

  - [Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/) #ril

## Autoescaping ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) 提到 powerful automatic HTML escaping system for cross site scripting prevention. 這跟 cross site scripting (XSS) 有什麼關係??
  - [Why is Autoescaping not the Default? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#why-is-autoescaping-not-the-default) #ril
  - [Autoescaping - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#autoescaping) #ril

## Macro ??

  - [Macros - Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/#macros)
      - Macro 就像是一般程式語言的 function，可以把慣用寫法 (idiom) 包裝成 reusable function (DRY)。例如：

    ```
{% macro input(name, value='', type='text', size=20) -%}
    <input type="{{ type }}" name="{{ name }}" value="{{
        value|e }}" size="{{ size }}">
{%- endmacro %}
    ```

      - 用起來就像 function call 一樣 (in the namespace??)；看起來像 Python code，但其實不是。

    ```
<p>{{ input('username') }}</p>
<p>{{ input('password', type='password') }}</p>
    ```

      - 在 macro 裡，除了 macro 宣告的參數之外，還有些 special variables 可以調用： #ril
     * `varargs` (`list`) - 內有多出來的 (unconsumed) positional arguments。
     * `kwargs` (`dict`) - 內有多出來的 (unconsumed) keyword arguments。
      - 如果 macro name 以底線開頭，就不能被 export & import；只能在單一個 template 裡使用。

  - [My Macros are overridden by something - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#my-macros-are-overridden-by-something) #ril

## Filter ??

  - `int()` 屬於 builtin filter 而非 builtin global function，結果 `{% for page in range(int(cookiecutter.number_of_slides)) %}` 會出現 `int not defined` 的錯誤，非得用 `{% set number_of_slides = cookiecutter.number_of_slides | int %}` 先轉換過?
  - [Custom Filters - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#custom-filters) #ril
  - [Filters - Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/#filters) #ril

## Variable ??

  - [Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/#variables) #ril
      - Template variable 定義在傳進 template 的 context dictionary 裡。
      - You can use a dot (`.`) to access ATTRIBUTES OF A VARIABLE in addition to the standard Python `__getitem__` “subscript” syntax (`[]`). 但所有的 variable 都支援 `[]` 嗎? 還是在 template 裡，這兩種用法是互通的??
      - 如果 variable 或 attribute 不存在，會得到 undefined value，至於會導致什麼樣的反應，則跟 application configuration 有關；被印出來或 iterate 時會視為 empty string，但其他的操作則會直接噴錯。
  - [Notes on Identifiers - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#notes-on-identifiers) #ril
  - [The Global Namespace - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#the-global-namespace) #ril

## Loader ??

  - [Loaders - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#loaders) #ril

## Template Compilation ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) 提到 "just in time compilation to Python bytecode"，會把 template 轉譯成 Pyhton bytecode 以提昇效能 (也支援 ahead-of-time compilation)，或許因為這樣才需要有 sandbox 吧?
  - [Bytecode Cache - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#bytecode-cache) #ril

## Debugging ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) 提到 "Easy to debug with a debug system that integrates template COMPILE AND RUNTIME ERRORS into the standard Python traceback system." 搭配 ahead-of-time compilation 有機會在 build time 就發現 template 的錯誤??
  - [Welcome to Jinja2 — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/) Line numbers of exceptions directly point to the correct line in the template.
  - [My tracebacks look weird. What’s happening? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#my-tracebacks-look-weird-what-s-happening) #ril

## Sandbox ??

  - [Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/) 一開始就提到 "an optional integrated SANDBOXED EXECUTION ENVIRONMENT"
  - [Sandbox — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/sandbox/) 用來評估 untrusted template/code #ril

## Customization ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) Configurable syntax. For instance you can reconfigure Jinja2 to better fit output formats such as LaTeX or JavaScript. 是指可以把 `{% ... %}` 及 `{{ ... }}` 換成其他符號??

## 安裝設定 {: #installation }

  - [And Powerful - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#and-powerful) 提到支援 Python 2.4+ 及 Python 3。
  - [Prerequisites - Introduction — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/intro/#prerequisites) #ril
      - 支援 Python 2.6+ 及 Python 3.3+，不過 Python 3 還在實驗階段，也之所以文件的寫法都是 Python 2。
      - 用 pip 安裝 `jinja2` 套件即可 (注意不是 `jinja`，會裝到 Jinja 1.x)，如果需要從其他 egg/package 載入 template (`PackageLoader`)，則需要加裝 `setuptools`/`distribute`。

## 參考資料 {: #reference }

  - [Jinja2](http://jinja.pocoo.org/)
  - [pallets/jinja - GitHub](https://github.com/pallets/jinja)
  - [Jinja2 - PyPI](https://pypi.org/project/Jinja2/)

手冊：

  - [Jinja2 API Documentation](http://jinja.pocoo.org/docs/2.10/api/)
  - [class `jinja2.Template`](http://jinja.pocoo.org/docs/2.10/api/#jinja2.Template)
  - [List of Builtin Filters](http://jinja.pocoo.org/docs/2.10/templates/#list-of-builtin-filters)
