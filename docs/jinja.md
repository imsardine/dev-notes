# Jinja

  - [Welcome \| Jinja2 \(The Python Template Engine\)](http://jinja.pocoo.org/)

      - Jinja2 is a full featured TEMPLATE ENGINE for Python. It has full UNICODE support, an optional integrated SANDBOXED execution environment, widely used and BSD licensed.

    Jinja is Beautiful

        {% extends "layout.html" %}
        {% block body %}
          <ul>
          {% for user in users %}
            <li><a href="{{ user.url }}">{{ user.username }}</a></li>
          {% endfor %}
          </ul>
        {% endblock %}

    And Powerful

      - Jinja2 is one of the most used template engines for Python.

        這句話所言不假，例如 Ansible、Cookiecutte、Flask 都以它為 template engine。

      - It is INSPIRED by Django's templating system but extends it with an EXPRESSIVE LANGUAGE that gives template authors a more powerful set of tools. On top of that it adds sandboxed execution and optional AUTOMATIC ESCAPING for applications where security is important.

        在 template 裡其實不該有太多邏輯，所以外加的 expressive language 也不是什麼優點。

      - It is internally based on Unicode and runs on a wide range of Python versions from 2.4 to current versions including Python 3.

    Wide Range of Features

      - Sandboxed execution mode. Every aspect of the template execution is monitored and explicitly WHITELISTED or BLACKLISTED, whatever is preferred. This makes it possible to execute UNTRUSTED TEMPLATES.
      - Powerful automatic HTML escaping system for CROSS SITE SCRIPTING prevention.
      - Template INHERITANCE makes it possible to use the same or a similar layout for all templates.
      - High performance with just in time compilation to PYTHON BYTECODE. Jinja2 will translate your template sources on first load into Python bytecode for best runtime performance.
      - Optional ahead-of-time compilation
      - Easy to debug with a debug system that integrates template compile and runtime errors into the standard Python traceback system.
      - CONFIGURABLE SYNTAX. For instance you can reconfigure Jinja2 to BETTER FIT output formats such as LaTeX or JavaScript.

      - TEMPLATE DESIGNER helpers. Jinja2 ships with a wide range of useful little helpers that help solving common tasks in templates such as breaking up sequences of items into multiple columns and more. ??

        呼應了下面 "both designer and developer friendly" 的說法；在分工上，template 應由 designer 來設計，這時候 presentation model 又更重要了；要求 designer 要用 expressive language 藏一些邏輯，很容易出錯。

  - [Welcome to Jinja2 — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/)

      - Jinja2 is a modern and DESIGNER-FRIENDLY templating language for Python, modelled after Django’s templates. It is fast, widely used and secure with the optional sandboxed template execution environment:

            <title>{% block title %}{% endblock %}</title>
            <ul>
            {% for user in users %}
              <li><a href="{{ user.url }}">{{ user.username }}</a></li>
            {% endfor %}
            </ul>

    Features: (http://jinja.pocoo.org/ 的說明比較完整)

      - sandboxed execution
      - powerful automatic HTML escaping system for XSS prevention
      - template inheritance
      - compiles down to the optimal python code just in time
      - optional ahead-of-time template compilation
      - easy to debug. lINE NUMBERS of exceptions directly point to the CORRECT LINE IN THE TEMPLATE.
      - configurable syntax

  - [Why is it called Jinja? - Frequently Asked Questions — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/faq/#why-is-it-called-jinja)

      - The name Jinja was chosen because it’s the name of a JAPANESE TEMPLE and temple and template SHARE A SIMILAR PRONUNCIATION. It is not named after the city in Uganda.

        Jinja 的命名源自日本的[神社](https://zh.wikipedia.org/wiki/%E7%A5%9E%E7%A4%BE) (平文式羅馬字為 "Jinjia")，且 "temple" 與 "template" 的發音近似，跟烏干達的城市 Jinja 無關；也難怪 Jinja 官網的圖示是 "鳥居"。

  - [Introduction — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/intro/)

      - This is the documentation for the Jinja2 GENERAL PURPOSE templating language. Jinja2 is a library for Python that is designed to be flexible, fast and secure.

        確實它被廣泛應用在許多領域，不限定在 HTML。

      - If you have any exposure to other text-based template languages, such as Smarty or Django, you should feel right at home with Jinja2. It’s both DESIGNER and developer friendly by sticking to PYTHON’S PRINCIPLES and adding functionality useful for templating environments.

        這也反應在 [Jinja2 Documentation](http://jinja.pocoo.org/docs/2.10/) 特別在 API 之外拉出 Template Designer Documentation。

  - [Releases · pallets/jinja](https://github.com/pallets/jinja/releases) 最早一個 release 是 2008-06-10 的 2.0rc1
  - [Jinja (template engine) \- Wikipedia](https://en.wikipedia.org/wiki/Jinja_(template_engine)) #ril

## 應用實例 {: #powered-by }

  - [Sphinx](https://github.com/sphinx-doc/sphinx/blob/v1.8.5/setup.py#L20)
  - [Flask](http://flask.pocoo.org/docs/1.0/templating/)
  - [Ansible](https://docs.ansible.com/ansible/latest/user_guide/playbooks_templating.html)

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

---

參考資料：

  - [Basic API Usage - Introduction — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/intro/#basic-api-usage)

      - This section gives you a brief introduction to the Python API for Jinja2 templates.

        The most basic way to create a template and render it is through `Template`. This however is NOT the recommended way to work with it if your templates are not loaded from strings but the file system or another data source:

            >>> from jinja2 import Template
            >>> template = Template('Hello {{ name }}!') # 傳入 byte string
            >>> template.render(name='John Doe')
            u'Hello John Doe!'                           # 傳回 unicode

        若 template 放檔案應該怎麼做 ? --> 用 `FileSystemLoader` 或 `PackageLoader`

      - By creating an instance of `Template` you get back a new template object that provides a method called `render()` which when called with a dict or keyword arguments EXPANDS the template. The dict or keywords arguments passed to the template are the so-called “CONTEXT” of the template.

      - What you can see here is that Jinja2 is USING UNICODE INTERNALLY and the return value is an unicode string. So make sure that your application is indeed using unicode internally.

## 新手上路 ?? {: #getting-started }

## Templating (API), Developer-friendly ??

  - [API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/) #ril
  - [Unicode - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#unicode) #ril

## Context ??

  - [Why is the Context immutable? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#why-is-the-context-immutable) #ril
  - [The Context - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#the-context)

## Debugging ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) 提到 "Easy to debug with a debug system that integrates template COMPILE AND RUNTIME ERRORS into the standard Python traceback system." 搭配 ahead-of-time compilation 有機會在 build time 就發現 template 的錯誤??
  - [Welcome to Jinja2 — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/) Line numbers of exceptions directly point to the correct line in the template.
  - [My tracebacks look weird. What’s happening? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#my-tracebacks-look-weird-what-s-happening) #ril

## Sandbox ??

  - [Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/) 一開始就提到 "an optional integrated SANDBOXED EXECUTION ENVIRONMENT"
  - [Sandbox — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/sandbox/) 用來評估 untrusted template/code #ril

## Customization ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) Configurable syntax. For instance you can reconfigure Jinja2 to better fit output formats such as LaTeX or JavaScript. 是指可以把 `{% ... %}` 及 `{{ ... }}` 換成其他符號??

## 安裝設置 {: #setup }

  - 支持 Python 2.6+ 與 Python 3.3+，但 Python 3 還在實驗階段。
  - 用 pip 安裝 `Jinja` 套件即可。

---

參考資料：

  - [Prerequisites - Introduction — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/intro/#prerequisites)

      - Jinja2 works with Python 2.6.x, 2.7.x and >= 3.3. If you are using Python 3.2 you can use an older release of Jinja2 (2.6) as support for Python 3.2 was dropped in Jinja2 version 2.7.

      - If you wish to use the `PackageLoader` class, you will also need `setuptools` or `distribute` installed at runtime.

    As a Python egg (via easy_install)

      - You can install the most recent Jinja2 version using `easy_install` or `pip`:

            easy_install Jinja2
            pip install Jinja2

        This will install a Jinja2 egg in your Python installation’s `site-packages` directory.

    Experimental Python 3 Support

      - Jinja 2.7 brings experimental support for Python >=3.3. It means that all unittests pass on the new version, but there might still be small bugs in there and behavior might be inconsistent. If you notice any bugs, please provide feedback in the Jinja bug tracker.

        Also please keep in mind that the documentation is written with Python 2 in mind, so you will have to adapt the shown code examples to Python 3 syntax for yourself.

        支援 Python 2.6+ 及 Python 3.3+，不過 Python 3 還在實驗階段，也之所以文件的寫法都是 Python 2。

      - 用 pip 安裝 `jinja2` 套件即可 (注意不是 `jinja`，會裝到 Jinja 1.x)，如果需要從其他 egg/package 載入 template (`PackageLoader`)，則需要加裝 `setuptools`/`distribute`。

## 參考資料 {: #reference }

  - [Jinja2](http://jinja.pocoo.org/)
  - [pallets/jinja - GitHub](https://github.com/pallets/jinja)
  - [Jinja2 - PyPI](https://pypi.org/project/Jinja2/)

社群：

  - ['jinja2' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/jinja2)

更多：

  - [API](jinja-api.md)
  - [Template](jinja-template.md)

