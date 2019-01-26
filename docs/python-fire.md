# Python Fire

  - [google/python\-fire: Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object\.](https://github.com/google/python-fire)
      - Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object. 從 Python object 產生 CLI，這觀念好特別。
      - Python Fire is a helpful tool for developing and debugging Python code. 指 REPL 在開發期間方便試東西。
      - Python Fire makes transitioning between Bash and Python easier. 指與 Unix tools 混用，而非取代 Bash。
      - Python Fire makes using a Python REPL easier by setting up the REPL with the modules and variables you'll need already imported and created. 進到 REPL 後，直接面對 CLI 背後的 API，使用上更有彈性。
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

## 安裝設定 {: #installation }

  - [Installation - google/python\-fire: Python Fire is a library for automatically generating command line interfaces (CLIs) from absolutely any Python object\.](https://github.com/google/python-fire#installation) 用 Pip 安裝 `fire` 套件即可。

## 參考資料 {: #reference }

  - [Python Fire](https://google.github.io/python-fire/)
  - [google/python-fire - GitHub](https://github.com/google/python-fire)
