# pyenv

## pyenv ??

  - [pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv)
      - Simple Python version management，可以在不同版本的 Python 間切換；源自 rbenv、ruby-build，像是 nvm (Node)、rvm (Ruby) 這類的工具。
      - 從 `pyenv global pypy-2.6.0` 與 `miniconda3-3.16.0 (set by /Volumes/treasuredata/.python-version)` 看來，pyenv 支援 CPython、PyPy、Conda 等，有 global Python version 的概念 (per-user basis)，也支援 per-project Python version。
      - pyenv 本身是用 shell script 寫的，不需要先裝 Python；也因此它不直接管理 virtualenv，但 [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) 是做什麼的??
  - [Which Python Package Manager Should You Use? \- YouTube](https://www.youtube.com/watch?v=3J02sec99RM) #ril
      - 03:22 唸做 "py-ann-f"；pyenv 在 virtualenv 及 Anaconda 之上?
  - [egg \- Is there a python equivalent of Ruby's 'rvm'? \- Stack Overflow](https://stackoverflow.com/questions/2812471/)
      - Olivier Verdier: 原先講 virtualenv，後來修正為 pyenv；但就 scientific computing 而言，建議用 Anaconda。
      - hytdsh: 原先講 Pythonbrew，後來也轉向 pyenv。
      - Yuu Yamashita: 仿 rbenv 寫了 pyenv，也支援 Stackless、PyPy 及 Jython。

## Hello, World! ??

## 新手上路 ??

  - [Using version managers – Sagar Rakshe – Medium](https://medium.com/@sagarrakshe2/using-version-managers-e2c626b3bb50) (2017-09-10) #ril
  - [Managing Multiple Python Versions with pyenv](http://akbaribrahim.com/managing-multiple-python-versions-with-pyenv/) (2016-01-11) #ril

## Shim ??

  - [Basic GitHub Checkout - pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv#basic-github-checkout) #ril
  - [How It Works - pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv#how-it-works) #ril

## 安裝設定

```
$ curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
...
WARNING: seems you still have not added 'pyenv' to the load path.

# Load pyenv automatically by adding
# the following to ~/.bashrc: <-- 要手動加些東西，才能自動載入 pyenv

export PATH="/Users/jeremykao/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

參考資料：

  - [Installation - pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv#installation) #ril
      - macOS 上建議用 `brew install pyenv` 安裝，之後昇級用 `brew upgrade pyenv`；但還是要用動做 Add `pyenv init` to your shell to enable shims and autocompletion
      - 作者自己寫了個 [automatic installer](https://github.com/pyenv/pyenv-installer)，執行 `curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash`，會安裝到 `~/.pyenv`。

## 參考資料

  - [pyenv/pyenv - GitHub](https://github.com/pyenv/pyenv)

手冊：

  - [Command Reference](https://github.com/pyenv/pyenv/blob/master/COMMANDS.md)

