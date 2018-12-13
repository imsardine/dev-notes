# Pipenv

  - [Pipenv: Python Dev Workflow for Humans — pipenv 2018\.7\.1\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/) #ril
      - Slogan 是 Python Dev Workflow for Humans，重點在 DEV Workflow。
      - It automatically creates and manages a VIRTUALENV for your projects, as well as adds/removes packages from your `Pipfile` as you install/uninstall packages. It also generates the ever-important `Pipfile.lock`, which is used to produce DETERMINISTIC BUILDS. 層次比 virtualenv 高了一階，這些概念其實是來自其他語言的套件，例如 Composer、npm、Yarn 等。
      - Pipenv is primarily meant to provide USERS and DEVELOPERS of applications with an easy method to setup a working environment. 兼顧 user 與 developer，呼應 `pipenv install` 與 `pip --env install` 的用法。
  - [Installing Pipenv - Pipenv & Virtual Environments — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/install/#installing-pipenv) Pipenv is a DEPENDENCY MANAGER for Python projects. If you’re familiar with Node.js’ npm or Ruby’s bundler, it is similar in spirit to those tools. While pip can install Python packages, Pipenv is recommended as it’s a HIGHER-LEVEL TOOL that simplifies dependency management for common use cases. 說明了 pip 與 Pipenv 的關係 -- Pipenv 是 pip 的高階應用。

## 新手上路 ?? {: #getting-started }

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

## Pipfile, Pipfile.lock ??

  - [General Recommendations & Version Control - Basic Usage of Pipenv — pipenv 2018\.11\.27\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/basics/#general-recommendations-version-control) #ril
      - Generally, keep both `Pipfile` and `Pipfile.lock` in version control. Do not keep `Pipfile.lock` in version control if multiple versions of Python are being targeted. 後者通常指的是 library。
      - Specify your target Python version in your Pipfile’s `[requires]` section. Ideally, you should only have one target Python version, as this is a DEPLOYMENT tool. 不是 development tool??

## Pipfile 與 setup.py

  - Library 性質的專案，仍會將 library 需要的 (abstract) dependencies 寫在 `setup.py` 的 `install_requires` 裡，開發相關的套件才會宣告在 `Pipfile` 的 `[dev-packages]` 裡 (`[packages]` 底下空白)；開發時先用 `pipenv install -e .` 安裝 (abstract) dependencies，再用 `pipenv install --dev` 安裝開發相關的套件。
  - Application 性質的專案，通常只有 `Pipfile`，將 application 執行期與開發時會用到的套件分別宣告在 `[packages]` 與 `[dev-packages]` 底下，再分別用 `pipenv install` 與 `pipenv install --dev` 安裝。

參考資料：

  - [Pipfile vs setup.py - Advanced Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/advanced/#pipfile-vs-setuppy)
      - Application 與 library 間有個微妙但很重大的差異 -- library 要讓其他 library 或 application 使用，所以不會寫死 subdependencies 的版本 (pin dependency versions)，只會宣告 abstract dependencies -- 只宣告需要什麼、或是要求一個範圍 (在 `setup.py` 的 `install_requires` 裡)，因為實際採用的版本是由使用它的 library/application 決定。
      - 而 application 會被佈署到特定的環境，所以 dependencies 及 subdependencies 的版本都要固定下來 (concrete)，而這正是 Pipenv 要解決的問題。
      - For applications, define dependencies and where to get them in the Pipfile and use this file to update the set of concrete dependencies in `Pipfile.lock`. This file defines a specific IDEMPOTENT environment that is known to work for your project. The `Pipfile.lock` is your SOURCE OF TRUTH. The `Pipfile` is a convenience for you to create that lock-file, in that it allows you to still remain somewhat VAGUE about the exact version of a dependency to be used. Pipenv is there to help you define a working CONFLICT-FREE SET OF SPECIFIC DEPENDENCY-VERSIONS (協調不同套件間的要求), which would otherwise be a very tedious task.
      - For libraries, define abstract dependencies via `install_requires` in `setup.py`. The decision of which version exactly to be installed and where to obtain that dependency is not yours to make! Of course, `Pipfile` and Pipenv are still useful for library developers, as they can be used to define a development or test environment. 也就是 `setup.py` 會宣告安裝這個 library 時需要的 abstract dependencies，但開發時會用到的套件則會宣告在 `Pipfile` (`[dev-packages]`)，並不相衝突。
      - 最後提到 `pipenv install -e .` This will tell Pipenv to lock all your `setup.py`–declared dependencies. 實驗發現，要有 `Pipfile` (空的也沒關係)，否則會遇到 `pipenv.vendor.requirementslib.exceptions.RequirementError: Error parsing requirement . -- are you sure it is installable?` 的錯誤；它會把套件安裝到 virtualenv 裡 (當然也就包含 `setup.py` 裡宣告的 `install_requires`)，至於 `Pipfile` 裡的 `[dev-packages]` 則要透過 `pipenv install --dev` 安裝。
  - [Pipenv does not respect dependencies in setup.py - Frequently Encountered Pipenv Problems — pipenv 2018\.11\.27\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/diagnose/#pipenv-does-not-respect-dependencies-in-setup-py) No, it does not, intentionally. `Pipfile` and `setup.py` serve different purposes, and should not consider each other by default. 但 `pipenv install -e .` 是個例外。
  - [Editable Dependencies (e.g. -e . ) - Basic Usage of Pipenv — pipenv 2018\.11\.27\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/basics/#editable-dependencies-e-g-e) #ril
  - [How to keep setup\.py install\_requires and Pipfile in sync · Issue \#1263 · pypa/pipenv](https://github.com/pypa/pipenv/issues/1263) #ril
      - Korijn: 在寫 Python package，但如何維持 `setup(install_requires=...)` 與 `Pipfile` 同步? For applications that are deployed or distributed in installers, I just use `Pipfile`. For applications that are distributed as packages with `setup.py`, I put all my dependencies in `install_requires`, and I add an `extras_require` CATEGORY labeled "dev" for my development dependencies. Then I make my `Pipfile` depend on `setup.py` by running `pipenv install '-e .'` first, and then `pipenv install --dev '-e .[dev]'`. 但 dev 相關的套件宣告在 `Pipfile` 的 `[dev-packages]` 底下不是更直接?
      - uranusjr: (member) I thiink @Korijn’s approach is best practice here. `Pipfile` (and `requirements.txt`) is for applications; `setup.py` is for packages. They serve different purposes. IF YOU NEED TO SYNC THEM, YOU’RE DOING IT WRONG (IMO). 兩邊負責的東西不同，其實不需要 sync；`setup.py` 是定義 library 需要的 dependencies，而 `Pipfile` 只宣告開發專用的 dependencies (`[dev-packages]`)。
  - [requests/requests: Python HTTP Requests for Humans](https://github.com/requests/requests) 同時有 `setup.py` 與 `Pipfile`
      - [let's see if this works · requests/requests@c00783c](https://github.com/requests/requests/commit/c00783cd86b3de9592f498f4670a5ebad1e99e83#diff-1e61a31bf9b94805f869dc4137ec1885) 第一次把 `requirements.txt` 及 `requirements-to-freeze.txt` 拿掉，用 `Pipfile` 及 `Pipfile.lock` 取代；`Makefile` 也從 `pip install -r requirements.txt` 改成 `pipenv install --dev`。
      - [Updated Pipfile to reflect version specs in setup\.py; added Sphinx · requests/requests@7b190ac](https://github.com/requests/requests/commit/7b190acf82e41f8203143ad08eb8c76aaffc2f14#diff-1e61a31bf9b94805f869dc4137ec1885) 特別宣告 `pytest = ">=2.8.0"` 及 `pytest-httpbin = "==0.0.7"`，跟 `setup.py` 裡的 `test_requirements = ['pytest>=2.8.0', 'pytest-httpbin==0.0.7', 'pytest-cov', 'pytest-mock']` 一致。
      - [faster · requests/requests@6746b25](https://github.com/requests/requests/commit/6746b2540dbf4f7a1389b499f2fd1fe3fca6d854#diff-1e61a31bf9b94805f869dc4137ec1885) 把 `Pipfile.lock` 刪掉，又出現 `requirements.txt` 了；雖然目前 master 是沒有這支檔案的。
      - [pipfile · requests/requests@4c300c2](https://github.com/requests/requests/commit/4c300c2067517738e80c3e908279828a6edc7de3#diff-1e61a31bf9b94805f869dc4137ec1885) `Pipfile.lock` 再次回歸。
  - [pypa/pipenv: Python Development Workflow for Humans\.](https://github.com/pypa/pipenv) 也同時有 `setup.py` 與 `Pipfile`!! `Pipfile` 裡只用到 `[dev-packages]`，但 `setup.py` 裡用到 `python_requires`、`setup_requires` 與 `install_requires`。
  - [serum/Pipfile at master · suned/serum](https://github.com/suned/serum/blob/master/Pipfile) 沒有相依套件，但開發用套件都宣告在 `Pipfile` 裡 (`[dev-packages]`)，所以 `setup.py` 沒有任何 `*_requires`。

## `pipenv` CLI ??

## Virtualenv 的位置 ??

  - [Virtualenv mapping caveat - Pipenv & Virtual Environments — pipenv 2018\.11\.27\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/install/#virtualenv-mapping-caveat) #ril
      - The virtualenv is stored GLOBALLY with the name of the project’s root directory plus the HASH OF THE FULL PATH to the project’s root (e.g., `my_project-a3de50`). If you change your project’s path, you break such a default mapping and pipenv will no longer be able to find and to use the project’s virtualenv. 這大概是 virtualenv 使用者一開始最不習慣的點
      - You might want to set export `PIPENV_VENV_IN_PROJECT=1` in your `.bashrc`/`.zshrc` (or any shell configuration file) for creating the virtualenv inside your project’s directory, avoiding problems with subsequent path changes. 實驗發現，virtualenv 會建在 `.venv/`，而且 `pipenv` 若發現 CWD 有 `.venv/`，就算沒有 `PIPENV_VENV_IN_PROJECT=1` 也會以它為 virtualenv。

## Packaging ??

  - [documentation/question: package publishing · Issue \#1288 · pypa/pipenv](https://github.com/pypa/pipenv/issues/1288) Pipenv 跟 packaging 似乎不是完全沒有關聯? #ril

## pyenv ??

  - 當 Pipenv 要求的 Python version 不存在時，若環境內有 pyenv，會問要不要自動安裝該版的 Python：

        $ pipenv install
        Warning: Python 3.5 was not found on your system…
        Would you like us to install CPython 3.5.6 with pyenv? [Y/n]: Y
        Installing CPython 3.5.6 with pyenv (this may take a few minutes)…

## 搭配 tox 使用 ??

  - [Tox Automation Project - Advanced Usage of Pipenv — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/advanced/#tox-automation-project) #ril
  - [tox\-dev/tox\-pipenv: A pipenv plugin for Tox](https://github.com/tox-dev/tox-pipenv) #ril

## 安裝設定 {: #installation }

  - [Pipenv: Python Dev Workflow for Humans — pipenv 2018\.11\.27\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/#install-pipenv-today) 提到 `brew install pipenv` 與 `sudo dnf install pipenv`，就是沒提到 `pip install pipenv`?
  - [How to keep setup\.py install\_requires and Pipfile in sync · Issue \#1263 · pypa/pipenv](https://github.com/pypa/pipenv/issues/1263) uranusjr: Pipenv should only be installed once (usually globally), and is used outside the project’s virtualenv to manage it, not inside the project’s virtualenv.
  - [Installing Pipenv - Pipenv & Virtual Environments — pipenv 2018\.10\.14\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/install/#installing-pipenv) 提到 `brew install pipenv` 與 `pip install pipenv` 兩種方式 #ril

## 參考資料 {: #reference }

  - [pypa/pipenv - GitHub](https://github.com/pypa/pipenv)
  - [pipenv - PyPI](https://pypi.org/project/pipenv/)

文件：

  - [Pipenv Documentation - Read the Docs](https://pipenv.readthedocs.io/)

相關：

  - [Reproducible/Deterministic Build](reproducible-build.md)
  - [tox](tox.md)
  - [pyenv](pyenv.md)
  - [.env](dotenv.md)

手冊：

  - [`pipenv` CLI Options](https://pipenv.readthedocs.io/en/latest/#pipenv-usage)
  - [Environment Variables](https://pipenv.readthedocs.io/en/latest/advanced/#configuration-with-environment-variables)
