# Python Fire

  - [google/python\-fire: Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object\.](https://github.com/google/python-fire)
      - Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object. 從 Python object 產生 CLI，這觀念好特別!!
      - Python Fire is a helpful tool for developing and debugging Python code. 指 REPL 在開發期間方便試東西。
      - Python Fire makes transitioning between Bash and Python easier. 指與 Unix tools 混用，而非取代 Bash。
      - Python Fire makes using a Python REPL easier by setting up the REPL with the modules and variables you'll need already imported and created. 進到 REPL e，直接面對 CLI 背後的 API，使用上更有彈性。

  - [Benefits \- Python Fire](https://google.github.io/python-fire/benefits/)
      - Simply write the functionality you want exposed at the command line as a function / module / class, and then call Fire. With this addition of a single-line call to Fire, your CLI is ready to go. 哇!!
      - Develop and debug Python code - ... You could also open an IPython REPL and import your library there and test it, but then you have to deal with reloading your imports every time you change something. 有了 Fire，只要加 `--interactive` 就會把 REPL 的環境準備好。
      - Explore existing code; turn other people's code into a CLI, Explore code in a Python REPL - 把 `difflib` module 丟進 `Fire` 就能得到 diffing tool，把 Python Imaging Library (PIL) module 丟進 `Fire` 就能得到 image manipulation tool ... 真有這麼神奇!?
      - Transition between Bash and Python - 指可以混用 Python function 與手邊的 Unix tools，而且過往用 Bash 寫 one-off script 可以改用 Python 了；不過 Python 調用其他 commands 不是那麼直覺，還是個問題?? 如果跟 STDIN/STDOUT 接??
  - [Why is it called Fire? - google/python\-fire: Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object\.](https://github.com/google/python-fire#why-is-it-called-fire) When you call `Fire`, it FIRES OFF (executes) your command.
  - [Introducing Python Fire, a library for automatically generating command line interfaces \| Google Open Source Blog](https://opensource.googleblog.com/2017/03/python-fire-command-line.html) (2017-03-02) #ril

## 新手上路 ?? {: #getting-started }

  - [Basic Usage - google/python\-fire: Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object\.](https://github.com/google/python-fire#basic-usage) #ril
  - [The Python Fire Guide \- Python Fire](https://google.github.io/python-fire/guide/) #ril
  - [Using a CLI \- Python Fire](https://google.github.io/python-fire/using-cli/) #ril

## Help, Usage

  - [`--help`: Getting help - Using a CLI \- Python Fire](https://google.github.io/python-fire/using-cli/#help-flag) #ril
      - Let say you have a command line tool named `widget` that was made with Fire. How do you use this Fire CLI? The simplest way to get started is to run `widget -- --help`. This will give you usage information for your CLI. You can always append `-- --help` to any Fire command in order to get usage information for that command and any SUBCOMMANDS. 無法自訂參數 (即 function argument) 的說明? ==> 可以針對 command，但不能針對個別參數。
      - Additionally, help will be displayed if you hit an error using Fire. For example, if you try to pass too many or too few arguments to a function, then help will be displayed. Similarly, if you try to access a member that does not exist, or if you index into a list with too high an index, then help will be displayed.
      - The displayed help shows information about which PYTHON COMPONENT (這是 Fire 定義的東西) your command corresponds to, as well as usage information for how to extend that command.

  - [Using Fire Flags - The Python Fire Guide \- Python Fire](https://google.github.io/python-fire/guide/#using-fire-flags) #ril
      - You can add the `help` flag to any command to see help and usage information. Fire incorporates your DOCSTRINGS into the help and usage information that it generates. Fire will try to provide help even if you omit the isolated `--` separating the flags from the Fire command, but may not always be able to, since `help` is a valid argument name (`--help` 會被當做參數傳入 function??). Use this feature like this: `python example.py -- --help`.

        以 `examples/widget/widget.py` 為例：

            $ python examples/widget/widget.py -- --help
            Type:        Widget
            String form: <__main__.Widget object at 0x106688f10>
            File:        ~/work/_clone/python-fire/examples/widget/widget.py
            <-- 因為 Widget class 本身沒有 docstring，所以沒有顯示

            Usage:       widget
                         widget bang
                         widget whack <-- 可惜的是，就算 subcommand 有寫 docstring，這時候並不會印出來

            $ python examples/widget/widget.py whack -- --help
            Type:        instancemethod
            String form: <bound method Widget.whack of <__main__.Widget object at 0x104ffff10>>
            File:        ~/work/_clone/python-fire/examples/widget/widget.py
            Line:        22
            Docstring:   Prints "whack!" n times.

            Usage:       widget whack [N]
                         widget whack [--n N]

## Sub-command ??

  - [Grouping Commands - The Python Fire Guide \- Python Fire](https://google.github.io/python-fire/guide/#grouping-commands)

    Here's an example of how you might make a command line interface with GROUPED COMMANDS. 雖然這裡稱做 grouped commands，但 [`--help`: Getting help - Using a CLI \- Python Fire](https://google.github.io/python-fire/using-cli/#help-flag) 也提到 "subcommand" 的說法。

        class IngestionStage(object):

          def run(self):
            return 'Ingesting! Nom nom nom...'

        class DigestionStage(object):

          def run(self, volume=1):
            return ' '.join(['Burp!'] * volume)

          def status(self):
            return 'Satiated.'

        class Pipeline(object):

          def __init__(self):
            self.ingestion = IngestionStage() <-- 用 attribute 表現 sub command!!
            self.digestion = DigestionStage()

          def run(self):
            self.ingestion.run()
            self.digestion.run()

        if __name__ == '__main__':
          fire.Fire(Pipeline)

    Here's how this looks at the command line:

        $ python example.py run
        Ingesting! Nom nom nom...
        Burp!
        $ python example.py ingestion run
        Ingesting! Nom nom nom...
        $ python example.py digestion run
        Burp!
        $ python example.py digestion status
        Satiated.

## REPL, Interactive Mode

  - [Explore code in a Python REPL - Benefits \- Python Fire](https://google.github.io/python-fire/benefits/#explore-code-in-a-python-repl)
      - When you use the `--interactive` flag to enter an IPython REPL, it starts with variables and modules already defined for you. You don't need to waste time importing the modules you care about or defining the variables you're going to use, since Fire has already done so for you.

        實驗發現，會自動採用 IPyton，但環境內沒有 IPython 時還是可以進入 interactive mode，只是用起來沒那麼方便而已 (尤其是 auto-completion)。例如 `python caculator.py -- --interactive`

  - [`--interactive`: Interactive mode - Using a CLI \- Python Fire](https://google.github.io/python-fire/using-cli/#-interactive-interactive-mode)
      - Call `widget -- --interactive` or `widget -- -i` to enter interactive mode. This will put you in an IPython REPL, with the variable `widget` already defined. You can then explore the Python object that `widget` corresponds to interactively using Python.

        其中 `widget` 應該就是 [python\-fire/widget\.py at master · google/python\-fire](https://github.com/google/python-fire/blob/master/examples/widget/widget.py)，只是若要像 `$ widget` 這樣直接呼叫 (而非 `$ python widget.py`)，應該要加上 shebang (`#!/usr/bin/env python`) 並設定 executable bit 才行，不過這些在官方文件裡完全沒提到就是了。

        另外 interactive mode 下有 variable `widget` 可以調用? 試過 `examples/widget/widget.py` 真的可以：

            $ python examples/widget/widget.py -- --interactive
            In [1]: widget
            Out[1]: <__main__.Widget at 0x10b565f10>

        為什麼 `widget` 是個 `Widget` instance? 因為它用 `fire.Fire(Widget(), name='widget')` 的寫法，而非 `fire.Fire(Widget, name='widget')` (component 給 instance 而非 type)。

## Testing ??

  - [python\-fire/widget\_test\.py at master · google/python\-fire](https://github.com/google/python-fire/blob/master/examples/widget/widget_test.py) 搭配 `fire.testurils` 測? #ril

## 安裝設定 {: #installation }

  - [Installation - google/python\-fire: Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object\.](https://github.com/google/python-fire#installation) 用 Pip 安裝 `fire` 套件即可。

## 參考資料 {: #reference }

  - [Python Fire](https://google.github.io/python-fire/)
  - [google/python-fire - GitHub](https://github.com/google/python-fire)
