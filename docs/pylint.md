# Pylint

  - [Pylint \- code analysis for Python \| www\.pylint\.org](https://www.pylint.org/) #ril
      - Slogan 是 Star your Python code!
      - 可以檢查單行程式是不是過長、變數命名是否合格、引入了沒用到的 module、重複的程式碼等。
  - [Introduction — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/intro.html)
      - 用來要求 coding standard、找出 code smell，並提出建議；預設採用近似於 PEP 8 的 coding style。
      - 其他類似的專案有 pychecker (已死)、pyflakes、flake8 跟 mypy。
      - 分析過程會丟出一些不同 category 的 messages -- error、warning，然後提供一個總體評分 (overall mark)
      - What Pylint says is not to be taken as gospel (教義) and Pylint isn’t smarter than you are: it may warn you about things that you have conscientiously (負責盡職地) done. 這句話說得真好。Pylint 會儘力減少 false positive，面對 verboseness 的方式，就是調整哪些 message category 要啟用/停用，可以從 command line 做，也可以由 configuration file 提供 (可以用 `--generate-rcfile` 產生)
  - [Tutorial — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/tutorial.html)
      - "become a more aware programmer" 這說法有趣，若要讓別人參與其中 (shared code)，Pylint 可以確保你的 code 對其他人是友善的。
  - [What is Pylint? - Frequently Asked Questions — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/faq.html#what-is-pylint) 是一個 static code checker。

## Hello, World! ??

`hello.py`:

```
def hello(who):
    print 'Hello, %s!' % who

if __name__ == '__main__':
    print hello(sys.args[1] if len(sys.args) >= 2 else 'World')
```

```
$ pylint hello # 注意不是 hello.py
No config file found, using default configuration
************* Module hello
C:  1, 0: Missing module docstring (missing-docstring)
C:  1, 0: Missing function docstring (missing-docstring)
E:  5,35: Undefined variable 'sys' (undefined-variable)
E:  5,16: Undefined variable 'sys' (undefined-variable)

----------------------------------------------------------------------
Your code has been rated at -20.00/10 (previous run: -20.00/10, +0.00)
```

參考資料：

  - [Tutorial — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/tutorial.html) #ril
      - 觀察 `pylint --long-help` 的輸出，這裡只會用到 `--generate-rcfile=<file>`、`--help-msg=<msg-id>`、`--disable=<msg-ids>` 與 `--reports=<y_or_n>`，最後面的 `Output:` 提到有 5 種 message type - Convention、refactor、warning、error、fatal (造成 Pylint 無法解析)。
      - 第一次使用，最常見的抱怨是 Pylint 很吵 (noisy)，因為預設的 configuration 會啟用所有的檢查，可以調整為只做想要的檢查。
      - 這裡舉的範例其實有點複雜了，光是 Hello, World! 就可以檢查出很多問題。

## 新手上路 ?? {: #getting-started }

  - [Running Pylint — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/user_guide/run.html) #ril
      - 基本用法是 `pylint [OPTIONS] MODULES_OR_PACKAGES` (用空白隔開)，注意是 module/package，而非 filename；實驗發現，package 下就算是沒用到的 module 也會去掃描。
      - Pylint 雖然不會 import module/package，但會用 Python 內部的機制 (internals) 來找到它們，所以一樣會受到 `PYTHONPATH` 的影響；也就是環境內要有 package，否則會丟出 `[E0401(import-error), ] Unable to import 'xxx'` 的錯誤。
      - It is also possible to analyze python files, with a few restrictions. 若傳入 file name，會試著將它轉為 module name，而這個轉換可能失敗，還是少用...
  - [Running Pylint - Frequently Asked Questions — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/faq.html#running-pylint) #ril
  - [Pylint output — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/user_guide/output.html) 看懂 CLI 的輸出
      - 預設的 output format 是 raw text，可以用 `--output-format=<FORMAT>` 調整，可接受的 format 有 `text` (預設)、`json`、`parseable`、`colorized` 與 `msvs` (Visual Studio?) 訊息可以用 `--msg-template` 自訂 message，想起 [Jenkins Wranings Plugin](https://plugins.jenkins.io/warnings) 就是解析 build log。
      - 輸出分為 3 塊 -- Source code analysis section、Reports section (`--reports=y` 啟用) 與 Score section (`--score=n` 停用)。
      - Source code analysis section 每個 module 都會以 `************* Module XXX` 劃分開來，接著條列長得像 `MESSAGE_TYPE: LINE_NUM:[OBJECT:] MESSAGE` 的訊息。其中 message type 可能是 [R]efactor for a "good practice" metric violation、[C]onvention for coding standard violation、[W]arning for stylistic problems, or minor programming issues、[E]rror for important programming issues (i.e. most probably bug) 或 [F]atal for errors which prevented further processing。
      - Reports section 會從不同的面向統計 message，可以用 `--reports=y` 啟用；若一直都能維持 10 分，就沒必要看 report 了。
      - 最後的 Score section 會以滿分 10 來計分，公式可以用 `--evaluation` 來自訂，預設是 `10.0 - ((float(5 * error + warning + refactor + convention) / statement) * 10)`；看起來是有任何 message，就不可能達到 10 分。

## Checker, Message, Message Category ??

  - [Getting Started - Tutorial — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/tutorial.html#getting-started) 從 "There are 5 kind of message types" 與 "Messages by category" 看來，message type/category 像是在為 message 分級 -- convention、refactor、warning、error、fatal；跟 debug level 有點像，但 warning 往上是 refactor 跟 convention。
  - [Command line options - Running Pylint — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/user_guide/run.html#command-line-options) "Pylint is architectured around several checkers. you can disable a specific checker or some of its messages or messages categories..." 說明了 checker 定義了不同的 message，而每個 message 分屬不同的 category。
  - [Checkers — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/technical_reference/checkers.html) checker 都在 `pylint.checkers` 下，大部份的 checker 都是 AST-based，背後用 astroid。
  - [pylint/pylint/checkers at master · PyCQA/pylint](https://github.com/PyCQA/pylint/tree/master/pylint/checkers) 底下有 imports、logging、python3、variables 等。
  - [Optional Pylint checkers in the extensions module — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/technical_reference/extensions.html) optional checkers 由 plugins 提供 #ril
  - [Tutorial — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/tutorial.html) `pylint --help-msg=missing-docstring` 說是來自 basic checker，但 `pylint/checkers` 下找不到 `basic.py`?
  - [Pylint features — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/technical_reference/features.html) 不同 checker 的參考手冊；許多 checker 都有 Messages 的段落，每個 message ID/symbol 後會跟著一個號碼，例如 `E1701`、`W0106` 等，第一個英文字母就是 message type/category。 #ril

## Message Control ??

  - [Messages control — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/user_guide/message-control.html)

    用程式碼裡的註解 `# pylint: disable=...` 或 `# pylint: enable=...` 來微調。

        """pylint option block-disable""" <-- 這裡也可以寫 pylint: disable=... 嗎??

        __revision__ = None

        class Foo(object):
            """block-disable test"""

            def __init__(self):
                pass

            def meth1(self, arg):
                """this issues a message"""
                print self

            def meth2(self, arg):
                """and this one not"""
                # pylint: disable=unused-argument
                print self\
                      + "foo"

            def meth3(self):
                """test one line disabling"""
                # no error
                print self.bla # pylint: disable=no-member <-- 從這一行開始作用
                # error
                print self.blop

            def meth4(self):
                """test re-enabling"""
                # pylint: disable=no-member
                # no error
                print self.bla
                print self.blop
                # pylint: enable=no-member <-- 同一層 block，可以重新 enable/disable
                # error
                print self.blip

            def meth5(self):
                """test IF sub-block re-enabling"""
                # pylint: disable=no-member <-- 作用在所在的 block 及 sub-block
                # no error
                print self.bla
                if self.blop:
                    # pylint: enable=no-member <-- sub-block 也可以重新 enable/disable
                    # error
                    print self.blip
                else:
                    # no error
                    print self.blip
                # no error
                print self.blip

            def meth6(self):
                """test TRY/EXCEPT sub-block re-enabling"""
                # pylint: disable=no-member
                # no error
                print self.bla
                try:
                    # pylint: enable=no-member
                    # error
                    print self.blip
                except UndefinedName: # pylint: disable=undefined-variable <-- except 可以分開控制
                    # no error
                    print self.blip
                # no error
                print self.blip

            def meth7(self):
                """test one line block opening disabling"""
                if self.blop: # pylint: disable=no-member <-- 可以寫在 block opening 那行
                    # error
                    print self.blip
                else:
                    # error
                    print self.blip
                # error
                print self.blip


            def meth8(self):
                """test late disabling"""
                # error
                print self.blip
                # pylint: disable=no-member
                # no error
                print self.bla
                print self.blop

  - [Configuration — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/user_guide/options.html) #ril
  - [Pylint \- code analysis for Python \| www\.pylint\.org](https://www.pylint.org/) Fully customizable 提到可以用 `pylintrc` 自訂 convention。

  - Pylint features — Pylint documentation https://pylint.readthedocs.io/en/latest/technical_reference/features.html #ril

## Lint 也要透過 tox 來做 ??

  - Static analysis 應該發生在 build 之前；若 Pylint 會檢查 import 的套件在不在，就必須要把 dependencies 都裝起來。
  - `tox --disable=import-error` 似乎是個方法? 更何況這種錯誤本來就不像 lint，應該用 unit tests 去確保才對。

參考資料：

  - [flask/tox\.ini at master · pallets/flask](https://github.com/pallets/flask/blob/master/tox.ini) `docs-html` 跟 `coverage-report` 都是跟測試無關的 test env，從 `[testenv:coverage-report]` 下的 `skip_install = true` 看來，所有的 test evn 預設都會裝 package；這樣好像也很合理，Pylint 也說會跟 `PYTHONPATH` 有關 ...
  - [endpoints\-python/tox\.ini at 9da60817aefbb0f2a4b9145c17ee39b9115067b0 · cloudendpoints/endpoints\-python](https://github.com/cloudendpoints/endpoints-python/blob/9da60817aefbb0f2a4b9145c17ee39b9115067b0/tox.ini) `[testenv:pylint-full]` 裡出現 `pylint` 及 `-r{toxinidir}/test-requirements.txt`

## 在多個專案間共用 pylintrc ??

  - 用 "pylintrc share" 找不到任何資料，或許自己維護幾個 template project 吧?

## 如何在 Jenkins 裡顯示 Pylint 檢查的結果??

  - Pylint - code analysis for Python | www.pylint.org https://www.pylint.org/ 在 Continuous integration 提到 Jenkins。

## 如何在 Vim 裡就提示不符合 Pylint 要求的部份??

  - Pylint - code analysis for Python | www.pylint.org https://www.pylint.org/ 提到 vim (pylint.vim, [syntastic](https://github.com/vim-syntastic/syntastic))

## 如何產生 UML diagrams??

  - [Pylint \- code analysis for Python \| www\.pylint\.org](https://www.pylint.org/) 提到整合 Pyreverse 可以產生 UML diagrams。

## no-else-return (R1705) ??

  - 如果做為 guard statements，當然不用 else，但如果是在做分支 -- 模擬 swtich 互斥的結構，覺得還是用 else 比較好。
  - 當然，如果遵守 function 不該有多個 `return` 的原則，就不會有這個問題。

參考資料：

  - [What's New In Pylint 1\.7 — Pylint 2\.2\.0 documentation](http://pylint.pycqa.org/en/latest/whatsnew/1.7.html) Pylint 1.7 新加入 `no-else-return` 的檢查。
  - [Refactoring checker Messages - Pylint features — Pylint 2\.2\.0 documentation](https://pylint.readthedocs.io/en/latest/technical_reference/features.html#refactoring-checker-messages)
      - Unnecessary "%s" after "return"
      - Used in order to highlight an unnecessary block of code following an if containing a return statement. As such, it will warn when it encounters an else following a chain of ifs, all of them containing a return statement.
  - [Does pylint warning no\-else\-return make sense to you · Issue \#500 · SoCo/SoCo](https://github.com/SoCo/SoCo/issues/500)
      - KennethNielsen: Pylint 1.7.1 加入了 "an else clause on a if statement after a return statement" 的檢查，似乎是從 Chromium C++ style guide 來的，雖然同意大部份 Pylint 建議的，但就這一點他不行。第 2 種寫法比較可讀，不認為它應該被勸阻，雖然已經停用了 warning，但還是想聽聽大家的意見。
      - robwebset: 兩種寫法各有優點，沒理由防止任一種寫法；DPH 也是持相同的看法。
  - [python \- It is more efficient to use if\-return\-return or if\-else\-return? \- Stack Overflow](https://stackoverflow.com/questions/9191388/)
      - Jorge Leitão: 從 efficiency 的考量，`if` 裡有 `return`，後面加 `else` 比較好，還是不加?
      - ams: compiled language 會自動優化它，並不需要我們擔心，重點是 code 的可讀性。
      - Frédéric Hamidi: 由於 `return` 結束了 function，所以兩種寫法是等價的 (equivalent)，雖然第 2 種寫法比較好讀，但第 1 種的執行效率確實比較好。
      - skeller88: 引用 [Chromium C++ Style Guide](https://chromium.googlesource.com/chromium/src/+/master/styleguide/c++/c++.md) -- Don't use else after return. Tim: 很訝異第一種寫法是比較清楚的，後來 skeller88: 重點是 code base 的風格要一致。
  - [“No\-else\-after\-return” considered harmful \| Nicholas Nethercote](https://blog.mozilla.org/nnethercote/2009/08/31/no-else-after-return-considered-harmful/) (2009-08-31) 提到 "it’s just harder to read because the two return statements have different indentation levels despite the fact that they are CLOSELY RELATED."。
  - [no\-else\-return \- Rules \- ESLint \- Pluggable JavaScript linter](https://eslint.org/docs/rules/no-else-return) ESLint 也有同樣的檢查，覺得重點是 "Its contents can be placed outside of the block"，若這不是訴求，或許這個檢查就沒有意義?

## unsubscriptable-object (E1136) ??

  - 之前的例子，又沒有宣告 `-> type`，Pylint 是如何知道有沒有 `__getitem__` 的??
  - [Pylint features — Pylint 2\.2\.0 documentation](https://pylint.readthedocs.io/en/latest/technical_reference/features.html#typecheck-checker-messages)
      - Value '%s' is unsubscriptable
      - Emitted when a subscripted value doesn't support subscription (i.e. doesn't define __getitem__ method).
  - [E1136 \- PyLint Messages](http://pylint-messages.wikidot.com/messages:e1136) 因為 `files['txt']` 一開始被初始化為 `None`，即便後來有給值，但還是會回報為 unsubscriptable；不知道這在 Python 3 有 type hint 會不會好一點?
  - [Pylint NEWS — Pylint 1\.6\.5 documentation](https://docs.pylint.org/en/1.6.0/whatsnew/changelog.html) Pylint 1.5.0 時加入 `unsubscriptable-objec`，但後來 Pylint 1.5.1 與 1.5.5 分別做了調整 -- Don’t emit unsubscriptable-object if the node is found inside an abstract class. 與 Don’t emit unsubscriptable-value for classes with unknown base classes. 感覺會誤報?
  - [erroneous error: Value 'typing\.Sequence' is unsubscriptable (unsubscriptable\-object) · Issue \#776 · PyCQA/pylint](https://github.com/PyCQA/pylint/issues/776) #ril
  - [False positive with E1136 unsubscriptable\-object · Issue \#1498 · PyCQA/pylint](https://github.com/PyCQA/pylint/issues/1498) #ril

## useless-object-inheritance (R0205) ??

  - [Classes chcker Message - Pylint features — Pylint 2\.2\.0 documentation](https://pylint.readthedocs.io/en/latest/technical_reference/features.html#classes-checker-messages)
      - Class %r inherits from object, can be safely removed from bases in python3
      - Used when a class inherit from object, which under python3 is implicit, hence can be safely removed from bases. 因此若專案必須相容於 Python 2，就應該停用這項檢查。

## 安裝設定 {: #installation }

### Pylint 1.x, 2.x ??

  - [What versions of Python is Pylint supporting? - Frequently Asked Questions — Pylint 2\.2\.0 documentation](http://pylint.pycqa.org/en/latest/faq.html#what-versions-of-python-is-pylint-supporting)
      - Pylint 2.0 只支援 Python 3.4+，雖然它也可以用來分析 Python 2 的檔案，但有些檢查假設了執行環境是 Python 2 所以無法作用。
      - 採用 Python 2 的話，必然要選擇 Pylint 1.8 或 1.9，到 2020 年之前，會持續有 bug fix 的 backports，也會有 Python 3 compatibility checks，不過在 2020 後就會停止對 Python 2 的支援。

### 安裝 Pylint

參考資料：

  - [Installation — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/user_guide/installation.html) 安裝 `pylint` 套件即可。
  - [Running Pylint — Pylint 2\.0\.0 documentation](https://pylint.readthedocs.io/en/latest/user_guide/run.html) Pylint 雖然不會 import module/package，但會用 Python 內部的機制 (internals) 來找到它們，所以一樣會受到 `PYTHONPATH` 的影響。

### 整合 Jenkins??

  - [Pylint \- code analysis for Python \| www\.pylint\.org](https://www.pylint.org/) Continuous integration 提到 Jenkins 的 Vilations Plugin。
  - [Violations - Jenkins Plugins](https://plugins.jenkins.io/violations) #ril

## 參考資料 {: #reference }

  - [Pylint](https://www.pylint.org/)
  - [PyCQA/pylint - GitHub](https://github.com/PyCQA/pylint)

社群：

  - ['pylint' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/pylint)

文件：

  - [Pylint User Manual](https://pylint.readthedocs.io/en/latest/)

手冊：

  - [Pylint Global Options and Switches](http://pylint.pycqa.org/en/latest/technical_reference/features.html#pylint-global-options-and-switches)
  - [Pylint Checkers' Options and Switches](http://pylint.pycqa.org/en/latest/technical_reference/features.html#pylint-checkers-options-and-switches)
  - [Command Line Options](https://pylint.readthedocs.io/en/latest/user_guide/run.html#command-line-options)
  - [Exit Codes](http://pylint.pycqa.org/en/latest/user_guide/run.html#exit-codes)
  - [Checker Messages](https://pylint.readthedocs.io/en/latest/technical_reference/features.html)

