# PyYAML

  - [yaml/pyyaml: Canonical source repository for PyYAML](https://github.com/yaml/pyyaml) PyYAML - The next generation YAML parser and emitter for Python. 同時做為 YAML 的 parser 與 emitter (寫出 YAML)
  - [PyYAML - Wiki](https://pyyaml.org/wiki/PyYAML)
      - A complete YAML 1.1 parser. In particular, PyYAML can parse all examples from the specification. 對 YAML 1.2 的支援?
      - Unicode support including UTF-8/UTF-16 input/output and * <-- 最後的星號指的是?
      - Low-level EVENT-BASED parser and emitter API (like SAX).
      - High-level API for serializing and deserializing native Python objects (like DOM or pickle).
      - Support for all types from the [YAML types repository](https://yaml.org/type/index.html). A simple extension API is provided. 若 YAML 支援這麼多 type，那麼 PyYAML 支援 object serialization 也不奇怪了。
      - Both pure-Python and fast LibYAML-based parsers and emitters.
  - [Welcome to PyYAML](https://pyyaml.org/) PyYAML is a full-featured YAML FRAMEWORK for the Python programming language. 支援 high-/low-level API、pure-Python/LibYAML-based impl、object serialization、可擴充 YAML type 等，就能理解 framework 的說法。

## 應用實例 {: #powered-by }

  - [ansible/requirements\.txt at v2\.7\.5 · ansible/ansible](https://github.com/ansible/ansible/blob/v2.7.5/requirements.txt#L7)
  - [mkdocs/setup\.py at 1\.0\.4 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/1.0.4/setup.py#L63)
  - [Search · filename:setup\.py pyyaml - GitHub](https://github.com/search?q=filename%3Asetup.py+pyyaml&type=Code)

## YAML 1.2, ruamel.yaml ?? {: #inactive }

  - [PyYAML - Wiki](https://pyyaml.org/wiki/PyYAML) A complete YAML 1.1 parser.
  - [YAML 1\.2 support · Issue \#116 · yaml/pyyaml](https://github.com/yaml/pyyaml/issues/116) (2017-12-27) 不少人按讚，但幾乎沒有討論；ruamel.yaml 是選項?
  - [Is this time to pass the baton? · Issue \#31 · yaml/pyyaml](https://github.com/yaml/pyyaml/issues/31) (2016-08-08) #ril
  - [xi / pyyaml / issues / \#59 \- Has this project been abandoned? — Bitbucket](https://bitbucket.org/xi/pyyaml/issues/59/) (2016-04-05)
      - Nicholas Chammas: It just seems weird that such an important and widely used Python library -- ~3.8M downloads last month according to PyPI! 這麼多人在用的 library，卻這麼久沒更新了；https://bitbucket.org/ruamel/yaml 這個 fork 看似有趣?
      - AMIGrAve: 沒進 Python standard library 也很奇怪。
  - [pyyaml does not support literals in unicode over codepoint 0xffff · Issue \#25 · yaml/pyyaml](https://github.com/yaml/pyyaml/issues/25) jlevy: ruamel.yaml 沒這個問題、adamchainz: 問題解了但還沒 release。
  - [Rebase off ruamel? \- many new valuable features · Issue \#46 · yaml/pyyaml](https://github.com/yaml/pyyaml/issues/46) (2016-12-10) #ril

## 新手上路 ?? {: #getting-started }

  - [PyYAML Wiki](https://pyyaml.org/wiki/PyYAML) #ril
  - [PyYAML Documentation](https://pyyaml.org/wiki/PyYAMLDocumentation) #ril

## 讀取 YAML ?? {: #parsing }

參考資料：

  - How can I parse a YAML file in Python - Stack Overflow https://stackoverflow.com/questions/1773805/ 也用 PyYAML #ril
  - YAML parsing and Python? - Stack Overflow https://stackoverflow.com/questions/6866600/ 用 PyYAML 套件 #ril

## Object Serialization ??

  - [PyYAML - Wiki](https://pyyaml.org/wiki/PyYAML) 提到 high-level API for serializing and deserializing native Python objects (like DOM or pickle).

## LibYAML ??

  - [Welcome to PyYAML](https://pyyaml.org/) LibYAML is a YAML parser and emitter written in C 為什麼會特別提及 [LibYAML](https://github.com/yaml/libyaml)，跟 PyYAML 在同個組織下?
  - [PyYAML - Wiki](https://pyyaml.org/wiki/PyYAML) Both pure-Python and fast LibYAML-based parsers and emitters.
  - [yaml/pyyaml: Canonical source repository for PyYAML](https://github.com/yaml/pyyaml) #ril
      - By default, the `setup.py` script checks whether LibYAML is installed and if so, builds and installs LibYAML bindings. To skip the check and force installation of LibYAML bindings, use the option `--with-libyaml`: `python setup.py --with-libyaml install`.
      - To disable the check and skip building and installing LibYAML bindings, use `--without-libyaml`: `python setup.py --without-libyaml install`. `setup.py` 會檢查系統是不是有 LibYAML，如果有的話就安裝 LibYAML binding，若不想安裝 LibYAML binding 則可以加上 `--without-libyaml`。

## 安裝設定 {: #installation }

## 參考資料 {: #reference }

  - [PyYAML](https://pyyaml.org/)
  - [yaml/pyyaml - GitHub](https://github.com/yaml/pyyaml)
  - [PyYAML - PyPI](https://pypi.python.org/pypi/PyYAML)

社群：

  - ['pyyaml' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/pyyaml)

文件：

  - [PyYAML Documentation](https://pyyaml.org/wiki/PyYAMLDocumentation)

相關：

  - [YAML](yaml.md)
