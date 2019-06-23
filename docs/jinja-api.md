---
title: Jinja / API
---
# [Jinja](jinja.md) / API

  - [API — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/api/) #ril

      - This document describes the API to Jinja2 and NOT THE TEMPLATE LANGUAGE. It will be most useful as reference to those implementing the TEMPLATE INTERFACE to the application and not those who are creating Jinja2 templates.

        這裡 template interface 的說法很棒!

    Basics

      - Jinja2 uses a central object called the template `Environment`. Instances of this class are used to store the CONFIGURATION and GLOBAL OBJECTS, and are used to LOAD TEMPLATES from the file system or other locations. Even if you are creating templates from strings by using the constructor of `Template` class, an environment is created automatically for you, albeit a shared one.

        把 environment 視為 context 似乎比較好理解，不過 context 在 Jinja 是提供資料的 dict，跟比較底層的 configuration 無關。

      - Most applications will create one `Environment` object on application initialization and use that to load templates. In some cases however, it’s useful to have multiple environments side by side, if different configurations are in use.

      - The simplest way to configure Jinja2 to load templates for your application looks roughly like this:

            from jinja2 import Environment, PackageLoader, select_autoescape
            env = Environment(
                loader=PackageLoader('yourapplication', 'templates'),
                autoescape=select_autoescape(['html', 'xml'])
            )

        This will create a template environment with the default settings and a loader that looks up the templates in the `templates` folder inside the `yourapplication` PYTHON PACKAGE. Different loaders are available and you can also write your own if you want to load templates from a database or other resources.

        This also enables autoescaping for HTML and XML files. 對 HTML/XML 特殊字完做 escaping，跟 template 的內容或副檔名無關。

      - To load a template FROM THIS ENVIRONMENT you just have to call the `get_template()` method which then returns the loaded `Template`:

            template = env.get_template('mytemplate.html')

        To render it with some variables, just call the `render()` method:

            print template.render(the='variables', go='here')

      - Using a TEMPLATE LOADER rather than passing strings to `Template` or `Environment.from_string()` has multiple advantages. Besides being a lot easier to use it also enables TEMPLATE INHERITANCE.

        這裡 `Environment.from_string()` 是相對於 `Environment.get_template()` 的用法。

    Notes on Autoescaping

      - In future versions of Jinja2 we might ENABLE AUTOESCAPING BY DEFAULT for security reasons. As such you are encouraged to explicitly configure autoescaping now instead of relying on the default.

## Autoescaping ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) 提到 powerful automatic HTML escaping system for cross site scripting prevention. 這跟 cross site scripting (XSS) 有什麼關係??
  - [Why is Autoescaping not the Default? - Frequently Asked Questions — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/faq/#why-is-autoescaping-not-the-default) #ril
  - [Autoescaping - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#autoescaping) #ril

## Loader ??

  - [Loaders - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#loaders) #ril

## Template Compilation ??

  - [Wide Range of Features - Welcome \| Jinja2 (The Python Template Engine)](http://jinja.pocoo.org/#wide-range-of-features) 提到 "just in time compilation to Python bytecode"，會把 template 轉譯成 Pyhton bytecode 以提昇效能 (也支援 ahead-of-time compilation)，或許因為這樣才需要有 sandbox 吧?
  - [Bytecode Cache - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#bytecode-cache) #ril

## 參考資料 {: #reference }

手冊：

  - [Jinja2 API Documentation](http://jinja.pocoo.org/docs/2.10/api/)

    - [Class `jinja2.Template`](http://jinja.pocoo.org/docs/2.10/api/#jinja2.Template)
    - [Class `jinja2.Environment` (Options)](http://jinja.pocoo.org/docs/2.10/api/#jinja2.Environment)
