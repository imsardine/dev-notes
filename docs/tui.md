# TUI (Text-based User Interface)

  - [Text\-based user interface \- Wikipedia](https://en.wikipedia.org/wiki/Text-based_user_interface) #ril
  - [jroimartin/gocui: Minimalist Go package aimed at creating Console User Interfaces\.](https://github.com/jroimartin/gocui) CUI (Console User Interface) 是另一種說法。
  - [Topic: cui](https://github.com/topics/cui)、[Topic: tui](https://github.com/topics/tui) 有些專案同時標示 tui 與 cui，甚至是 cli。
  - [gui \- Is it crazy to develop a TUI today? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/213826/) #ril
  - [command line \- Are there differences between cli and tui? \- Ask Ubuntu](https://askubuntu.com/questions/867416/) #ril

## 應用實例 {: #showcase }

  - [Ask HN: Good examples of interactive command\-line user experience? \| Hacker News](https://news.ycombinator.com/item?id=14401057) #ril
  - [asciinema \- Record and share your terminal sessions, the right way](https://asciinema.org/) -- asciicasts 下應該找到不錯的應用，例如 mapscii #ril

## Python ??

  - [Curses Programming with Python — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/curses.html) #ril
  - [15\.11\. curses — Terminal handling for character\-cell displays — Python 2\.7\.14 documentation](https://docs.python.org/2/library/curses.html#module-curses) #ril
  - [user interface \- Input in a Python text\-based GUI \(TUI\) \- Stack Overflow](https://stackoverflow.com/questions/18177142/) 許多人都提到 `curses`；rook: 推薦基於 curses 的 [urwid](http://urwid.org/)；Peter Brittain: Linux 及 OS X 上的標準是 `ncurses`，而 Python built-in `curses` 就是包裝它，但在 Windows 上的支援有限。跨平台方案可選 [asciimatics](https://github.com/peterbrittain/asciimatics)，此外它也提供許多高階的 UI widgets。
  - [Good python library for a text based interface? : Python](https://www.reddit.com/r/Python/comments/5gd3jd/) 有人提到 asciimatics、curses、urwid、[blessed](https://github.com/jquast/blessed)、[Python Prompt Toolkit](https://github.com/jonathanslenders/python-prompt-toolkit) -- IPython 就是用它!! 作者還寫了 pymux 與 pyvim，重刻了 tmux 與 vim !?
  - [pfalcon/picotui: Lightweight, pure\-Python Text User Interface \(TUI\) widget toolkit with minimal dependencies\. Dedicated to MicroPython\.](https://github.com/pfalcon/picotui) 支援 CPython 3 與 MicroPython!
  - [I'm trying to make a fancy CLI interface in python\. Curses is very confusing \(and I can't find a good tutorial\!\) Any suggestions? : Python](https://www.reddit.com/r/Python/comments/1132ct/) #ril
  - [Create TUI on Python – Valery Krasnoselsky – Medium](https://medium.com/@bad_day/create-tui-on-python-71377849879d) (2018-04-21) 用 `npyscreen` #ril
  - [tehmaze/diagram: Text mode diagrams using UTF\-8 characters and fancy colors](https://github.com/tehmaze/diagram) #ril

## 參考資料

相關：

  - [Text Mode](text-mode.md)
