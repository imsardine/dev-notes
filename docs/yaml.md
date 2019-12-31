# YAML

  - YAML 唸作 `/ˈjæməl/`

---

參考資料：

  - [The Official YAML Web Site](http://yaml.org/)

      - YAML: YAML Ain't Markup Language
      - What It Is: YAML is a human friendly data serialization standard for all programming languages. 這個網頁就用 YAML 來表現，可讀性還真的滿高的。

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/)

      - YAML is a data serialisation language designed to be directly writable and readable by humans.

      - It’s a STRICT SUPERSET of JSON, with the addition of SYNTACTICALLY SIGNIFICANT NEWLINES and INDENTATION, like Python. Unlike Python, however, YAML doesn’t allow literal tab characters for indentation.

        這點確實跟 Python 有點像，但不能用 tab 來做縮排；明智的決定。

  - [YAML \- Wikipedia](https://en.wikipedia.org/wiki/YAML) #ril

## 跟 JSON 的關係 ?? {: #json }

  - 就 JSON 不支援 comment 但 YAML 支援這點來看，可以把 YAML 視為 JSON for Humans 的版本，而 JSON 就留給 for Machine 的應用。

參考資料：

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) 算是 "strict superset of JSON"，跟 Python 一樣看重 newline 與 indentation，但不像 Python 允許 tab。
  - [1.3. Relation to JSON - YAML Ain’t Markup Language (YAML™) Version 1\.2](http://yaml.org/spec/1.2/spec.html#id2759572) #ril

## Hello, World! ??

```
# Hello, World!
greeting: Hello, YAML!
```

## 新手上路 ?? {: #getting-started }

  - [YAML Ain't Markup Language](https://yaml.org/start.html) 結構用 indentation 創造出來 (一或多個空格)、list (sequence items) 用 dash (`-`) 表示，而 key-value pair 則用 colon (`:`) 拆開 key 跟 value；其中 `&` 跟 `*` 似乎可以用來參照?? `>` 跟 `|` 可以用多行表示??

參考資料：

  - [Getting Started - YAML Ain't Markup Language](https://yaml.org/start.html)

      - Below is an example of an invoice expressed via YAML(tm). STRUCTURE IS SHOWN THROUGH INDENTATION (one or more spaces). SEQUENCE items are denoted by a dash, and KEY VALUE PAIRS within a map are separated by a colon.

            --- !clarkevans.com/^invoice
            invoice: 34843
            date   : 2001-01-23 # (1)
            bill-to: &id001
                given  : Chris
                family : Dumars
                address:
                    lines: |
                        458 Walkman Dr.
                        Suite #292
                    city    : Royal Oak
                    state   : MI
                    postal  : 48046
            ship-to: *id001
            product:
                - sku         : BL394D
                  quantity    : 4
                  description : Basketball
                  price       : 450.00
                - sku         : BL4438H
                  quantity    : 1
                  description : Super Hoop
                  price       : 2392.00
            tax  : 251.42
            total: 4443.52
            comments: >
                Late afternoon is best.
                Backup contact is Nancy
                Billsmer @ 338-4338.

         1. 空白可以拿來做排版，讓 `:` 對齊。

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) #ril

    Start, Comment

        ---  # document start (1) (2)

        # Comments in YAML look like this.

     1. 看來註解 `#` 不一定要出現在行首。
     2. `---` 是用來隔開 front matter，應該不是必要的 ??

    SCALAR TYPES

        # Our root object (which continues for the entire document) will be a map, (1)
        # which is equivalent to a dictionary, hash or object in other languages.
        key: value
        another_key: Another value goes here.
        a_number_value: 100
        scientific_notation: 1e+12
        # The number 1 will be interpreted as a number, not a boolean. if you want
        # it to be interpreted as a boolean, use true
        boolean: true          # (2)
        null_value: null       # (3)
        key with spaces: value # (4)
        # Notice that strings don't need to be quoted. However, they can be.
        however: 'A string, enclosed in quotes.'
        'Keys can be quoted too.': "Useful if you want to put a ':' in your key."
        single quotes: 'have ''one'' escape pattern'
        double quotes: "have many: \", \0, \t, \u263A, \x0d\x0a == \r\n, and more."

        # Multiple-line strings can be written either as a 'literal block' (using |),
        # or a 'folded block' (using '>').
        literal_block: | # (5)
            This entire block of text will be the value of the 'literal_block' key,
            with line breaks being preserved.

            The literal continues until de-dented, and the leading indentation is
            stripped.

                Any lines that are 'more-indented' keep the rest of their indentation -
                these lines will be indented by 4 spaces.
        folded_style: >
            This entire block of text will be the value of 'folded_style', but this
            time, all newlines will be replaced with a single space.

            Blank lines, like above, are converted to a newline character.

                'More-indented' lines keep their newlines, too -
                this text will appear over two lines.

     1. 事實上，root object 不一定要是 key-value pair，也可以是 sequence，甚至是 scalars，例如 `null`、`true`/`false` 等。
     2. Boolean 用 `true`/`false` 表示。
     3. Null 用 `null` 表示。
     4. Key 跟 value 都可以不加引號，即使含有空白字元；單引號不支援 escape，裡面的單引號用 `''` 表示，雙引號則支援 escape，例如 `\"`、`\t` 等。
     5. `|` 表示要對齊左側，跟 Python 的 [`textwrap.dedent()`](https://docs.python.org/3/library/textwrap.html#textwrap.dedent) 很像，會保留換行字元 -- 除開頭跟結尾的換行字元以外 ??
     6. `>` 表示相連的行要串接起來，空白行才會被視為換行，加上 "'More-indented' lines keep their newlines" 類 indented code block 的說法，很像是 Markdown 的解讀方式 ??

  - [Understanding YAML](https://docs.saltstack.com/en/latest/topics/yaml/) #ril
  - [YAML Syntax — Ansible Documentation](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html) #ril
  - [YAML Idiosyncrasies](https://docs.saltstack.com/en/latest/topics/troubleshooting/yaml_idiosyncrasies.html) #ril
  - [The YAML Format (The Yaml Component \- Symfony Docs)](https://symfony.com/doc/current/components/yaml/yaml_format.html) #ril

## Boolean ??

  - [Boolean Language\-Independent Type for YAML™ Version 1\.1](https://yaml.org/type/bool.html) 多種寫法可以兼顧可讀性

      - Canonical: `y|n`
      - Regexp: `y|Y|yes|Yes|YES|n|N|no|No|NO|true|True|TRUE|false|False|FALSE|on|On|ON|off|Off|OFF`

      - Definition: Mathematical Booleans.

        A Boolean represents a true/false value. Booleans are formatted as English words (“true”/“false”, “yes”/“no” or “on”/“off”) for readability and may be ABBREVIATED as a single character “y”/“n” or “Y”/“N”.

  - [y\|Y\|n\|N not Recognised as Booleans · Issue \#247 · yaml/pyyaml](https://github.com/yaml/pyyaml/issues/247) 實驗確認 3.13 也有這個問題，為什麼這個錯誤在 2019-02-01 才被回報? #ril

## Convention ??

  - 雖然[官方 FAQ](http://www.yaml.org/faq.html) 建議使用 `.yaml`，但因為 `.yml` 已經夠清楚、某些早期檔名 8.3 限制的習慣，結果 `.yml` 變成業界標準 (de facto standard)。

參考資料：

  - [YAML Ain't Markup Language](http://www.yaml.org/faq.html) 副檔名建議用 `.yaml`。
  - [configuration files \- Is it \.yaml or \.yml? \- Stack Overflow](https://stackoverflow.com/questions/21059124/) 雖然官方建議 `.yaml`，但大家普遍還是用 `.yml`? Bandrami: 8.3 的習慣很難拿掉 MarkDBlackwell: `.yml` 已經夠明確，只有少數的副檔名以 Y 開頭，`.yml` 已經成為 de facto standard。
  - [YML \- Wikipedia](https://en.wikipedia.org/wiki/YML) `.yml` 是 YAML 的副檔名
  - [symfony \- What is the difference between YAML vs YML extension? \- Stack Overflow](https://stackoverflow.com/questions/22268952/) 因為歷史因素，Windows 開發人員還是害怕使用 3 個字元以上的副檔名。
  - [What is the canonical YAML naming style \- Stack Overflow](https://stackoverflow.com/questions/22771226/) camelCase、`-` 或 `_` 都有人用 #ril

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
  - [The YAML Format (The Yaml Component \- Symfony 3\.3 Docs)](https://symfony.com/doc/3.3/components/yaml/yaml_format.html) #ril

## String ??

  - [Strings - The YAML Format (The Yaml Component \- Symfony Docs)](https://symfony.com/doc/current/components/yaml/yaml_format.html#strings) #ril

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

      - There are two types of formats that YAML supports for strings: BLOCK SCALAR and FLOW SCALAR formats.

        (Scalars are what YAML calls basic values like numbers or strings, as opposed to complex types like arrays or objects.)

        Block scalars have more control over how they are interpreted, whereas flow scalars have more limited escaping support.

      - 最下面 Plain 的用法其實滿直覺的，結果幾乎跟 `'` 一樣。

  - [syntax \- How do I break a string over multiple lines? \- Stack Overflow](https://stackoverflow.com/questions/3790454) #ril

## Data Serialization ??

  - [The Official YAML Web Site](https://yaml.org/) 到處都看得到 data serialization 的說法，感覺可以定義 YAML 與 object 的對應規則?
  - [PyYAML · PyPI](https://pypi.org/project/PyYAML/) 提到 pickle support 與 represent an arbitrary Python object。

## Merge Multiple Files ??

  - [Overriding Theme Config - Configuration \| Hexo](https://hexo.io/docs/configuration#Overriding-Theme-Config) 第一次在 Hexo 看到多個 YAML 合併的概念：

    Using multiple files combines all the config files and saves the merged settings to `_multiconfig.yml`. The later values take precedence. It works with any number of JSON and YAML files with arbitrarily deep objects.

        # _config.yml
        theme_config:
          bio: "My awesome bio"

        # themes/my-theme/_config.yml
        bio: "Some generic bio"
        logo: "a-cool-image.png"
        Resulting theme configuration:

        {
          bio: "My awesome bio",
          logo: "a-cool-image.png"
        }

    但實驗發現 `theme_config: footer: since: 2017` 會覆寫整個 `theme/_config.yml` 裡的 `footer:`，無法單純複寫 `since: 2017` 這項設定。

  - [Scout24/yamlreader: Read all YAML files in a directory and merge them](https://github.com/Scout24/yamlreader) #ril

  - [Using an Alternate Config - Configuration \| Hexo](https://hexo.io/docs/configuration#Using-an-Alternate-Config)


## Python ??

  - 從 [YAML.org](http://yaml.org/) 與 [Python Wiki](https://wiki.python.org/moin/YAML) 的建議看來，[PyYAML](pyyaml.md) 是最推薦的套件。

參考資料：

  - [The Official YAML Web Site](https://yaml.org/) Python 列出 PyYAML、ruamel.yaml 與 PySyck，但 PySyck 的連結已經斷了。
  - [How do I install the yaml package for Python? \- Stack Overflow](https://stackoverflow.com/questions/14261614/) 幾乎都在講 PyYAML 套件。
  - [How can I parse a YAML file in Python \- Stack Overflow](https://stackoverflow.com/questions/1773805/) Anthon 提到 ruamel.yaml，本身是作者
  - [YAML \- Python Wiki](https://wiki.python.org/moin/YAML) 由於 YAML spec 的複雜度，PyYAML 有完整的支援 (C-based)，但其他 library 只有局部的支援。

## 參考資料 {: #reference }

  - [YAML.org](http://yaml.org/)
  - [yaml/yaml - GitHub](https://github.com/yaml/yaml)

工具：

  - [Online YAML Parser](http://yaml-online-parser.appspot.com/) 可以輸出成 JSON 或 Python
  - [YAML Lint - The YAML Validator](http://www.yamllint.com/) 除了檢查，也會將 `[...]` (list) 或 `{...}` (dictionary) 轉換成階層的表示法
  - [Best YAML Validator Online](https://jsonformatter.org/yaml-validator) 同時提供 Validate 與 Format YAML 的功能

書籍：

  - [YAML Cookbook (Ruby)](https://yaml.org/YAML_for_ruby.html)

手冊：

  - [YAML 1.2](http://www.yaml.org/spec/1.2/spec.html)

