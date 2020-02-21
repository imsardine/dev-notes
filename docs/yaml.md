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

## Hello, World!

```
# Hello, World!
greeting: Hello, YAML!
```

## 新手上路 {: #getting-started }

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

## Boolean

  - [Boolean Language\-Independent Type for YAML™ Version 1\.1](https://yaml.org/type/bool.html) 多種寫法可以兼顧可讀性

      - Canonical: `y|n`
      - Regexp: `y|Y|yes|Yes|YES|n|N|no|No|NO|true|True|TRUE|false|False|FALSE|on|On|ON|off|Off|OFF`

      - Definition: Mathematical Booleans.

        A Boolean represents a true/false value. Booleans are formatted as English words (“true”/“false”, “yes”/“no” or “on”/“off”) for readability and may be ABBREVIATED as a single character “y”/“n” or “Y”/“N”.

  - [y\|Y\|n\|N not Recognised as Booleans · Issue \#247 · yaml/pyyaml](https://github.com/yaml/pyyaml/issues/247) 實驗確認 3.13 也有這個問題，為什麼這個錯誤在 2019-02-01 才被回報? #ril

## Convention

  - 雖然[官方 FAQ](http://www.yaml.org/faq.html) 建議使用 `.yaml`，但因為 `.yml` 已經夠清楚、某些早期檔名 8.3 限制的習慣，結果 `.yml` 變成業界標準 (de facto standard)。

參考資料：

  - [YAML Ain't Markup Language](http://www.yaml.org/faq.html) 副檔名建議用 `.yaml`。
  - [configuration files \- Is it \.yaml or \.yml? \- Stack Overflow](https://stackoverflow.com/questions/21059124/) 雖然官方建議 `.yaml`，但大家普遍還是用 `.yml`? Bandrami: 8.3 的習慣很難拿掉 MarkDBlackwell: `.yml` 已經夠明確，只有少數的副檔名以 Y 開頭，`.yml` 已經成為 de facto standard。
  - [YML \- Wikipedia](https://en.wikipedia.org/wiki/YML) `.yml` 是 YAML 的副檔名
  - [symfony \- What is the difference between YAML vs YML extension? \- Stack Overflow](https://stackoverflow.com/questions/22268952/) 因為歷史因素，Windows 開發人員還是害怕使用 3 個字元以上的副檔名。
  - [What is the canonical YAML naming style \- Stack Overflow](https://stackoverflow.com/questions/22771226/) camelCase、`-` 或 `_` 都有人用 #ril

## Comment

  - [Comments - The YAML Format \(The Yaml Component \- Symfony 3\.3 Docs\)](https://symfony.com/doc/3.3/components/yaml/yaml_format.html#comments)

    Comments can be added in YAML by prefixing them with a hash mark (`#`):

        # Comment on a line
        "symfony 1.0": { PHP: 5.0, Propel: 1.2 } # Comment at the end of a line
        "symfony 1.2": { PHP: 5.2, Propel: 1.3 }

    NOTE: Comments are simply ignored by the YAML parser and DO NOT NEED TO BE INDENTED according to the current level of nesting in a collection.

    但跟著資料內縮會比較好讀。

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) `# Comments in YAML look like this.`
  - [YAML \- Wikipedia](https://en.wikipedia.org/wiki/YAML) Comment 以 `#` 開頭表示，可以出現在一行的任何地方，直到行尾，但必須與其他 token 用 whitespace 隔開。在 Comparison with JSON 也提到，YAML 比 JSON 多了 comment 的支援。
  - [How do you do block comment in yaml? \- Stack Overflow](https://stackoverflow.com/questions/2276572/) 提到 inline comment 的說法，但不援 block comment 是真的。

## 不能用 Tab? 慣用的縮排 {: #tab-indentation }

  - [YAML Ain't Markup Language](http://www.yaml.org/faq.html) 由於 indentation 對 YAML 很重要，所以 YAML 裡不能用 tab，各種工具對 tab 有不同的解讀。
  - [YAML Idiosyncrasies](https://docs.saltstack.com/en/latest/topics/troubleshooting/yaml_idiosyncrasies.html) 建議用 2 spaces (Vim 搭配 `:set tabstop=2 expandtab`)；Nested Dictioanries 提到 nested dicts 的 identation 要特別注意。

## `---`, `...` {: #--- }

  - 對於文件一開始的 `---`，YAML 1.1 與 1.2 有不同的解釋：

    [YAML 1.1](https://yaml.org/spec/1.1/#id857577):

    > YAML uses three dashes (“`---`”) to separate documents within a stream.

    [YAML 1.2](https://yaml.org/spec/1.2/spec.html#id2760395):

    > YAML uses three dashes (“`---`”) to separate directives from document content. This also serves to signal the start of a document if no directives are present.

    顯然明確用 `---` 起頭的想法是源自 YAML 1.2，目的是為了強調沒有 directives；雖然相對而言 YAML 1.1，現有支擾 YAML 1.2 的 parser 是相對少的。

  - "multiple documents in a single stream" 的用法其實並不常見，尤其是用在 configuration 時。

    > Allowing multiple documents in a single stream makes YAML suitable for LOG FILES and similar applications. Note that each document is independent of the rest, allowing for heterogeneous log file entries.
    >
    > -- [YAML 1.2](https://yaml.org/spec/1.2/spec.html#id2801681)

  - 要求文件一開始要有 `---` 的習慣可能來自 Puppet？

    [Google 搜尋結果](https://www.google.com/search?q=puppet+three+dashes) 都在講 YAML 要以 `---` 開頭，可能因此造成該領域的人誤以為 YAML 就是要以 `---` 開頭。

    同為 configurmation management 應用的 Ansible 也說一開始的 `---` 並非必要：

    > There’s another small quirk to YAML. All YAML files (regardless of their association with Ansible or not) can OPTIONALLY begin with `---` and end with `...`. This is part of the YAML format and indicates the start and end of a document.
    >
    > -- [YAML Syntax — Ansible Documentation](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html#yaml-basics)

    在其他領域，包括 [Dart](https://dart.dev/tools/pub/pubspec#example)、[Symfony](https://symfony.com/doc/master/components/yaml/yaml_format.html)、[Jekyll 的 `_config.yml`](https://github.com/jekyll/jekyll/blob/master/lib/site_template/_config.yml)、[Travis](https://docs.travis-ci.com/user/customizing-the-build/)、[Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration/) 都未曾出現過這類要求。

---

參考資料：

  - [why \-\-\- \(3 dashes/hyphen\) in yaml file? \- Stack Overflow](https://stackoverflow.com/questions/50788277/)

      - YAML uses three dashes (“---”) to separate directives from document content. This also serves to signal the start of a document if NO DIRECTIVES ARE PRESENT.

      - Yassin Hajaj: It's not mandatory to have them if you do not begin your YAML with a directive. If it's the case, you should use them.

  - [General syntax - Brief YAML reference — Camel 0\.1\.2 documentation](https://camel.readthedocs.io/en/latest/yamlref.html#general-syntax)

      - A document begins with `---` and ends with `...`. Both are OPTIONAL, though a `...` can only be followed by directives or `---`.

        You DON’T see multiple documents very often, but it’s a very useful feature for sending INTERMITTENT CHUNKS of data over a single network connection. With JSON you’d usually put each chunk on its own line and delimit with newlines; YAML has support built in.

      - Documents may be preceded by directives, in which case the `---` is REQUIRED to indicate the end of the directives.

        Directives are a `%` followed by an identifier and some parameters. (This is how directives are distinguished from a bare document without `---`, so the first non-blank non-comment line of a document can’t start with a `%`.)

  - [The YAML Format \(The Yaml Component \- Symfony 5\.1 Docs\)](https://symfony.com/doc/master/components/yaml/yaml_format.html#unsupported-yaml-features)

    The following YAML features are not supported by the Symfony Yaml component: Multi-documents (`---` and `...` markers);

    如果只有一個 document 但以 `---` 開頭會怎樣?

  - [document-start - Rules — yamllint 1\.20\.0 documentation](https://yamllint.readthedocs.io/en/stable/rules.html#module-yamllint.rules.document_start)

    Use this rule to require or forbid the use of DOCUMENT START MARKER (`---`).

    Set `present` to `true` when the document start marker is required, or to `false` when it is forbidden.

    這工具的設計有點奇怪，`document-start: {present: true}` 時一定要有，`document-start: {present: false}` 一定不能有，若要讓使用者依需求自己決定呢?

        $ yamllint settings.yml
        settings.yml
          1:1       warning  missing document start "---"  (document-start)
        $ echo $?
        0

    不過它只是 warning 就是了，除非啟用 [strict mode](https://yamllint.readthedocs.io/en/stable/configuration.html#errors-and-warnings)：

        $ yamllint --strict settings.yml
        settings.yml
          1:1       warning  missing document start "---"  (document-start)
        $ echo $?
        2

## Collection (Sequence, Mapping), Nested, Indentation ??

  - [Learn yaml in Y Minutes](https://learnxinyminutes.com/docs/yaml/) #ril
      - Sequences (equivalent to lists or arrays) look like this (note that THE '-' COUNTS AS INDENTATION) 其中 `- ` 也被視為 identation，那麼 key 的 value 是 list 時，為什麼不用再縮一排，就可以解釋了。
  - [Complete idiot's introduction to yaml · Animosity/CraftIRC Wiki](https://github.com/Animosity/CraftIRC/wiki/Complete-idiot%27s-introduction-to-yaml) #ril
  - [YAML Syntax — Ansible Documentation](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html) Dictionary 跟 list 都有 abbreviated form #ril

  - [Collections - The YAML Format \(The Yaml Component \- Symfony 3\.3 Docs\)](https://symfony.com/doc/3.3/components/yaml/yaml_format.html#collections)

      - A YAML file is rarely used to describe a simple scalar. Most of the time, it describes a collection. YAML collections can be a sequence (indexed arrays in PHP) or a mapping of elements (associative arrays in PHP).

      - Sequences use a DASH followed by a SPACE:

            - PHP
            - Perl
            - Python

        The previous YAML file is equivalent to the following PHP code:

            array('PHP', 'Perl', 'Python');

     - Mappings use a COLON followed by a SPACE (`: `) to mark each key/value pair:

            PHP: 5.2
            MySQL: 5.1
            Apache: 2.2.20

        注意 `:` 後面還要有個空格，否則會被視為 scalar value -- string。

        which is equivalent to this PHP code:

            array('PHP' => 5.2, 'MySQL' => 5.1, 'Apache' => '2.2.20');

        NOTE: In a mapping, a key can be ANY VALID SCALAR.

        The number of spaces between the colon and the value does not matter:

            PHP:    5.2
            MySQL:  5.1
            Apache: 2.2.20

        為了提高可讀性時，也可以這麼做。

      - YAML uses indentation with ONE OR MORE spaces to describe nested collections:

            'symfony 1.0':
              PHP:    5.0
              Propel: 1.2
            'symfony 1.2':
              PHP:    5.2
              Propel: 1.3

        The above YAML is equivalent to the following PHP code:

            array(
                'symfony 1.0' => array(
                    'PHP'    => 5.0,
                    'Propel' => 1.2,
                ),
                'symfony 1.2' => array(
                    'PHP'    => 5.2,
                    'Propel' => 1.3,
                ),
            );

      - There is one important thing you need to remember when using indentation in a YAML file: Indentation must be done with one or more spaces, but never with tabulators.

        You can nest sequences and mappings as you like:

            'Chapter 1':
              - Introduction
              - Event Types
            'Chapter 2':
              - Introduction
              - Helpers

      - YAML can also use FLOW STYLES for collections, using explicit indicators rather than indentation to denote scope.

        A sequence can be written as a comma separated list within square brackets (`[]`):

            [PHP, Perl, Python]

        A mapping can be written as a comma separated list of key/values within curly braces (`{}`):

            { PHP: 5.2, MySQL: 5.1, Apache: 2.2.20 }

        You can mix and match styles to achieve a BETTER READABILITY:

            'Chapter 1': [Introduction, Event Types]
            'Chapter 2': [Introduction, Helpers]

            'symfony 1.0': { PHP: 5.0, Propel: 1.2 }
            'symfony 1.2': { PHP: 5.2, Propel: 1.3 }

## String

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

## Python

  - 從 [YAML.org](http://yaml.org/) 與 [Python Wiki](https://wiki.python.org/moin/YAML) 的建議看來，[PyYAML](pyyaml.md) 是最推薦的套件。

---

參考資料：

  - [The Official YAML Web Site](https://yaml.org/) Python 列出 PyYAML、ruamel.yaml 與 PySyck，但 PySyck 的連結已經斷了。
  - [How do I install the yaml package for Python? \- Stack Overflow](https://stackoverflow.com/questions/14261614/) 幾乎都在講 PyYAML 套件。
  - [How can I parse a YAML file in Python \- Stack Overflow](https://stackoverflow.com/questions/1773805/) Anthon 提到 ruamel.yaml，本身是作者
  - [YAML \- Python Wiki](https://wiki.python.org/moin/YAML) 由於 YAML spec 的複雜度，PyYAML 有完整的支援 (C-based)，但其他 library 只有局部的支援。

## Java

  - [Jackson](https://github.com/FasterXML/jackson)
  - [SnakeYAML](https://bitbucket.org/asomov/snakeyaml/wiki/Home)

Jackson 的 YAML extension 及 Spring Boot 背後都是用 SnakeYAML。

---

參考資料：

  - [Reading and Writing YAML Files in Java with Jackson](https://stackabuse.com/reading-and-writing-yaml-files-in-java-with-jackson/) (2020-01-02)

    With a refresher on YAML, we're ready to write some code that reads/writes YAML files. To achieve this, we can use either of the two popular libraries: Jackson or SnakeYAML. In this article, we'll be focusing on Jackson.

  - [Read YAML in Java with Jackson \- DZone Java](https://dzone.com/articles/read-yaml-in-java-with-jackson) (2016-05-30)

    Jackson is one of the best JSON libraries for Java. Now with the YAML EXTENSION of Jackson, we can use Jackson to process YAML in Java. Under the hood, Jackson’s YAML extension uses the SnakeYAML library to parse YAML.

    所謂 extension (`com.fasterxml.jackson.dataformat:jackson-dataformat-yaml`) 背後也是用 SnakeYAML。

  - [Java - The Official YAML Web Site](https://yaml.org/)

    這裡提到 JvYaml、SnakeYAML、YamlBeans、JYaml 及 Camel，但沒有 Jackson。

  - [Project Dependency - Spring Boot YAML example – Mkyong\.com](https://mkyong.com/spring-boot/spring-boot-yaml-example/)

    Spring Boot uses SnakeYAML library to parse the YAML file, and the SnakeYAML library is provided by `spring-boot-starter`

## 參考資料 {: #reference }

  - [YAML.org](http://yaml.org/)
  - [yaml/yaml - GitHub](https://github.com/yaml/yaml)

工具：

  - [Online YAML Parser](http://yaml-online-parser.appspot.com/) 可以輸出成 JSON 或 Python
  - [YAML Lint - The YAML Validator](http://www.yamllint.com/) 除了檢查，也會將 `[...]` (list) 或 `{...}` (dictionary) 轉換成階層的表示法
  - [Best YAML Validator Online](https://jsonformatter.org/yaml-validator) 同時提供 Validate 與 Format YAML 的功能
  - [adrienverge/yamllint - GitHub](https://github.com/adrienverge/yamllint) (Python)

書籍：

  - [YAML Cookbook (Ruby)](https://yaml.org/YAML_for_ruby.html)

手冊：

  - [YAML 1.1](https://yaml.org/spec/1.1/)
  - [YAML 1.2](http://yaml.org/spec/1.2/spec.html)
