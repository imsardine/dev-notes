# YAML

  - YAML 唸作 `/ˈjæməl/`

參考資料：

  - [The Official YAML Web Site](http://yaml.org/) YAML = YAML Ain't Markup Language，把自己定位成 YAML is a human friendly data serialization standard for all programming languages. 這個網頁就用 YAML 來表現，可讀性還真的滿高的。
  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) 有 "directly writable and readable by humans" 的說法。
  - [YAML \- Wikipedia](https://en.wikipedia.org/wiki/YAML) #ril

## 跟 JSON 的關係 ?? {: #json }

  - 就 JSON 不支援 comment 但 YAML 支援這點來看，可以把 YAML 視為 JSON for Humans 的版本，而 JSON 就留給 for Machine 的應用。

參考資料：

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) 算是 "strict superset of JSON"，跟 Python 一樣看重 newline 與 indentation，但不像 Python 允許 tab。
  - [1.3. Relation to JSON - YAML Ain’t Markup Language \(YAML™\) Version 1\.2](http://yaml.org/spec/1.2/spec.html#id2759572) #ril

## Hello, World! ??

```
# Hello, World!
greeting: Hello, YAML!
```

## 新手上路 ?? {: #getting-started }

  - [YAML Ain't Markup Language](https://yaml.org/start.html) 結構用 indentation 創造出來 (一或多個空格)、list (sequence items) 用 dash (`-`) 表示，而 key-value pair 則用 colon (`:`) 拆開 key 跟 value；其中 `&` 跟 `*` 似乎可以用來參照?? `>` 跟 `|` 可以用多行表示??

參考資料：

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) #ril
  - [Understanding YAML](https://docs.saltstack.com/en/latest/topics/yaml/) #ril
  - [YAML Syntax — Ansible Documentation](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html) #ril
  - [YAML Idiosyncrasies](https://docs.saltstack.com/en/latest/topics/troubleshooting/yaml_idiosyncrasies.html) #ril
  - [The YAML Format \(The Yaml Component \- Symfony Docs\)](https://symfony.com/doc/current/components/yaml/yaml_format.html) #ril

## 慣用的副檔名 {: #file-extension }

  - 雖然[官方 FAQ](http://www.yaml.org/faq.html) 建議使用 `.yaml`，但因為 `.yml` 已經夠清楚、某些早期檔名 8.3 限制的習慣，結果 `.yml` 變成業界標準 (de facto standard)。

參考資料：

  - [YAML Ain't Markup Language](http://www.yaml.org/faq.html) 副檔名建議用 `.yaml`。
  - [configuration files \- Is it \.yaml or \.yml? \- Stack Overflow](https://stackoverflow.com/questions/21059124/) 雖然官方建議 `.yaml`，但大家普遍還是用 `.yml`? Bandrami: 8.3 的習慣很難拿掉 MarkDBlackwell: `.yml` 已經夠明確，只有少數的副檔名以 Y 開頭，`.yml` 已經成為 de facto standard。
  - [YML \- Wikipedia](https://en.wikipedia.org/wiki/YML) `.yml` 是 YAML 的副檔名
  - [symfony \- What is the difference between YAML vs YML extension? \- Stack Overflow](https://stackoverflow.com/questions/22268952/) 因為歷史因素，Windows 開發人員還是害怕使用 3 個字元以上的副檔名。

## Comment

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) `# Comments in YAML look like this.`
  - [YAML \- Wikipedia](https://en.wikipedia.org/wiki/YAML) Comment 以 `#` 開頭表示，可以出現在一行的任何地方，直到行尾，但必須與其他 token 用 whitespace 隔開。在 Comparison with JSON 也提到，YAML 比 JSON 多了 comment 的支援。
  - [How do you do block comment in yaml? \- Stack Overflow](https://stackoverflow.com/questions/2276572/) 提到 inline comment 的說法，但不援 block comment 是真的。

## 不能用 Tab? 慣用的縮排 {: #tab-indentation }

  - [YAML Ain't Markup Language](http://www.yaml.org/faq.html) 由於 indentation 對 YAML 很重要，所以 YAML 裡不能用 tab，各種工具對 tab 有不同的解讀。
  - [YAML Idiosyncrasies](https://docs.saltstack.com/en/latest/topics/troubleshooting/yaml_idiosyncrasies.html) 建議用 2 spaces (Vim 搭配 `:set tabstop=2 expandtab`)；Nested Dictioanries 提到 nested dicts 的 identation 要特別注意。

## Collection (Sequence, Mapping), Nested, Indentation ??

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) #ril
      - Sequences (equivalent to lists or arrays) look like this (note that THE '-' COUNTS AS INDENTATION) 其中 `- ` 也被視為 identation，那麼 key 的 value 是 list 時，為什麼不用再縮一排，就可以解釋了。
  - [Complete idiot's introduction to yaml · Animosity/CraftIRC Wiki](https://github.com/Animosity/CraftIRC/wiki/Complete-idiot%27s-introduction-to-yaml) #ril
  - [YAML Syntax — Ansible Documentation](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html) Dictionary 跟 list 都有 abbreviated form #ril
  - [The YAML Format \(The Yaml Component \- Symfony 3\.3 Docs\)](https://symfony.com/doc/3.3/components/yaml/yaml_format.html) #ril

## String ??

  - [Strings - The YAML Format \(The Yaml Component \- Symfony Docs\)](https://symfony.com/doc/current/components/yaml/yaml_format.html#strings) #ril
      - Strings in YAML can be wrapped both in single and double quotes. In some cases, they can also be UNQUOTED:

            A string in YAML
            'A singled-quoted string in YAML'
            "A double-quoted string in YAML"

      - Quoted styles are useful when a string starts or end with one or more relevant spaces, because UNQUOTED STRINGS ARE TRIMMED on both end when parsing their contents. Quotes are required when the string contains SPECIAL OR RESERVED CHARACTERS. 下面提到特殊字元指的是

            :, {, }, [, ], ,, &, *, #, ?, |, -, <, >, =, !, %, @, `

      - When using single-quoted strings, any single quote `'` inside its contents must be doubled to escape it: `'A single quote '' inside a single-quoted string'`，那雙引號怎麼 escape??
  - [Scalars - A YAML Primer — OctoPrint 1\.3\.9\.post5\.dev0\+g09af281 documentation](http://docs.octoprint.org/en/master/configuration/yaml.html#scalars) In double quoted strings if you need to include a literal double quote in your string you can escape it by PREFIXING IT WITH A BACKSLASH `\` (which you can in turn escape by itself). In single quoted strings the single quote character can be escaped by prefixing it with another single quote, basically DOUBLING IT. Backslashes in single quoted strings do not need to be escaped. 在 single quote 與 double quote 裡要 escape quote 的方式很不一樣，double quote 裡因為 `\` 有作用的關係，用 `\"`，但 single quote 裡因為 `\` 沒有作用，所以改用 `''`。
  - [syntax \- Do I need quotes for strings in Yaml? \- Stack Overflow](https://stackoverflow.com/questions/19109912/) `Yes` 跟 `No` 要加引號，否則會被解讀為 `True`/`False` #ril

## 多行字串要如何表示 ?? {: #multiline-string }

  - [YAML Multiline Strings](http://yaml-multiline.info/) #ril

## Data Serialization ??

  - [The Official YAML Web Site](https://yaml.org/) 到處都看得到 data serialization 的說法，感覺可以定義 YAML 與 object 的對應規則?
  - [PyYAML · PyPI](https://pypi.org/project/PyYAML/) 提到 pickle support 與 represent an arbitrary Python object。

## Python ??

  - 從 [YAML.org](http://yaml.org/) 與 [Python Wiki](https://wiki.python.org/moin/YAML) 的建議看來，[PyYAML](pyyaml.md) 是最推薦的套件。

參考資料：

  - [The Official YAML Web Site](https://yaml.org/) Python 列出 PyYAML、ruamel.yaml 與 PySyck，但 PySyck 的連結已經斷了。
  - [How do I install the yaml package for Python? \- Stack Overflow](https://stackoverflow.com/questions/14261614/) 幾乎都在講 PyYAML 套件。
  - [How can I parse a YAML file in Python \- Stack Overflow](https://stackoverflow.com/questions/1773805/) Anthon 提到 ruamel.yaml，本身是作者
  - [YAML \- Python Wiki](https://wiki.python.org/moin/YAML) 由於 YAML spec 的複雜度，PyYAML 有完整的支援 (C-based)，但其他 library 只有局部的支援。

## 參考資料 {: #reference }

  - [YAML.org](http://yaml.org/)

工具：

  - [Online YAML Parser](http://yaml-online-parser.appspot.com/) 可以輸出成 JSON 或 Python
  - [YAML Lint - The YAML Validator](http://www.yamllint.com/) 除了檢查，也會將 `[...]` (list) 或 `{...}` (dictionary) 轉換成階層的表示法
  - [Best YAML Validator Online](https://jsonformatter.org/yaml-validator) 同時提供 Validate 與 Format YAML 的功能

手冊：

  - [YAML 1.2](http://www.yaml.org/spec/1.2/spec.html)

