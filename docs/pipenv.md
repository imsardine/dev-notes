# Pipenv

  - [Installing Pipenv - Pipenv & Virtual Environments — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/install/#installing-pipenv) Pipenv is a DEPENDENCY MANAGER for Python projects. If you’re familiar with Node.js’ npm or Ruby’s bundler, it is similar in spirit to those tools. While pip can install Python packages, Pipenv is recommended as it’s a HIGHER-LEVEL TOOL that simplifies dependency management for common use cases. 說明了 pip 與 Pipenv 的關係 -- Pipenv 是 pip 的高階應用。
  - [Pipenv: Python Dev Workflow for Humans — pipenv 2018\.7\.1\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/) #ril
      - Slogan 是 Python Dev Workflow for Humans，重點在 DEV Workflow。
      - It automatically creates and manages a VIRTUALENV for your projects, as well as adds/removes packages from your `Pipfile` as you install/uninstall packages. It also generates the ever-important `Pipfile.lock`, which is used to produce DETERMINISTIC BUILDS. 層次比 virtualenv 高了一階，這些概念其實是來自其他語言的套件，例如 Composer、npm、Yarn 等。
  - [Pipfile vs setup.py - Advanced Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/advanced/#pipfile-vs-setuppy) #ril
      - Application 與 library 間有個微妙但很重大的差異 -- library 要讓其他 library 或 application 使用，所以不會寫死 subdependencies 的版本 (pin dependency versions)，只會宣告 abstract dependencies -- 只宣告需要什麼、或是要求一個範圍 (在 `setup.py` 的 `install_requires` 裡)，因為實際採用的版本是由使用它的 library/application 決定。
      - 而 application 會被佈署到特定的環境，所以 dependencies 及 subdependencies 的版本都要固定下來 (concrete)，而這正是 Pipenv 要解決的問題。
      - The decision of which version exactly to be installed and WHERE to obtain that dependency is not yours to make! 為什麼要強調 where? 莫非 `Pipfile`/`Pipfile.lock` 裡可以宣告位置??

## 基礎

### Hello, World! ??

### 新手上路 ??

  - [Kenneth Reitz \- Pipenv: The Future of Python Dependency Management \- PyCon 2018 \- YouTube](https://www.youtube.com/watch?v=GBQAKldqgZs) (2018-05-13) #ril
  - [Example Pipenv Workflow - Basic Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/basics/#example-pipenv-workflow) #ril
      - 拿到一個專案後，先執行 `pipenv install` (就跟 Node.js 的 `npm install` 一樣)。
      - 用 `pipenv install <package>` 可以安裝其他套件，若 `Pipfile` 不存在則會自動建立。
      - 要進入 pipenv 的環境 (activate) 用 `pipenv shell` -- spawn a new shell subprocess (這點跟 virtualenv 很不一樣)，要離開則執行 `exit` (比 virtualenv 的 `deactivate` 直覺)。
  - [Using installed packages - Pipenv & Virtual Environments — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/install/#using-installed-packages) 提到 `pipenv run <command>` 可以執行環境內的 script，跟 `pipenv shell` 進到該環境執行一樣。
  - [Basic Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/basics/) #ril
  - [Generating a requirements.txt - Advanced Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/advanced/#generating-a-requirements-txt) 為什麼要提供這項功能?? #ril
  - [Specifying Package Indexes - Advanced Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/advanced/#specifying-package-indexes) 可以指定每個 dependncy 的 source/index #ril
  - [Advanced Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/advanced/) #ril

### pyenv ??

  - 當 Pipenv 要求的 Python version 不存在時，若環境內有 pyenv，會問要不要自動安裝該版的 Python：

        $ pipenv install
        Warning: Python 3.5 was not found on your system…
        Would you like us to install CPython 3.5.6 with pyenv? [Y/n]: Y
        Installing CPython 3.5.6 with pyenv (this may take a few minutes)…

### 搭配 tox 使用 ??

  - [Tox Automation Project - Advanced Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/advanced/#tox-automation-project) #ril
  - [tox\-dev/tox\-pipenv: A pipenv plugin for Tox](https://github.com/tox-dev/tox-pipenv) #ril

## 安裝設定

  - [Installing Pipenv - Pipenv & Virtual Environments — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/install/#installing-pipenv) 提到 `brew install pipenv` 與 `pip install pipenv` 兩種方式 #ril

## 參考資料

  - [pypa/pipenv - GitHub](https://github.com/pypa/pipenv)
  - [pipenv - PyPI](https://pypi.org/project/pipenv/)

文件：

  - [Pipenv Documentation - Read the Docs](https://pipenv.readthedocs.io/)

### 手冊

  - [`pipenv` CLI Options](https://pipenv.readthedocs.io/en/latest/#pipenv-usage)
  - [Environment Variables](https://pipenv.readthedocs.io/en/latest/advanced/#configuration-with-environment-variables)
