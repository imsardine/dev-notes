# tox

  - tox 只能用在 [`setup.py`](setuptools.md) based project
  - tox 支援的 test tool 有 [pytest](pytest.md)、[nose](nose.md) 與 unittest
  - tox 背後用 [virtualenv](virtualenv.md) 來安排不同的 test environment

參考資料：

  - [tox 3\.0\.0rc4 : Python Package Index](https://pypi.python.org/pypi/tox)
      - 開宗明義 vision: standardize testing in Python
      - 基於 virtualenv，專注在 testing；利用 virtualenv 檢查在不同的 test environment (主要是不同的 Python version) 都能安裝成功、通過測試 (支援不同的 test tool)；過程中會自動建立 virtualenv，也難怪會有 "virtualenv managment" 的說法。
      - 做為 CI server 的 frontend??
  - [Welcome to the tox automation project — tox 3\.0\.0rc3\.dev10 documentation](https://tox.readthedocs.io/en/latest/) #ril
      - 自動/標準化 Python 的 testing，支援 "setup.py based project" (透過 `setup.py` 安裝到不同的 virtual environment)，而 test tool 則支援 pytest、nose、unittest 等。
      - 支援 CPython 2.7/3.4+、Jython 及 pypy。
      - Current features ...
  - [Run/Debug Configuration: Tox \- Help \| PyCharm](https://www.jetbrains.com/help/pycharm/run-debug-configuration-tox.html) PyCharm 支援 tox 設定 #ril

## 跟 `setup.py`、`requirements.txt` 的關係 ??

  - `tox --develop` (install package in the venv using 'setup.py develop') 這種用法的存在，感覺 `tox` 像是 `setup.py` 的 frontend。
  - the tox automation project https://tox.readthedocs.io/en/latest/ 提到 "installs your setup.py based project into each virtual environment"，所以執行 `tox` 時若 `setup.py` 不存在，會丟出 `tox.MissingFile: MissingFile: path/to/project/setup.py` 的錯誤。
  - [Tox tricks and patterns \| ionel's codelog](https://blog.ionelmc.ro/2015/04/14/tox-tricks-and-patterns/#lack-of-packaging) (2015-04-14) 若專案沒有 `setup.py` 但又想用 tox，在 `tox.ini` 增加 `[tox] skipsdist = true` 就可以。

## 有哪些知名的專案在用 tox?

  - [sampleproject/tox\.ini at master · pypa/sampleproject](https://github.com/pypa/sampleproject/blob/master/tox.ini) Python Packaging Authority (PyPA) 的範例
  - requests/tox.ini at master · requests/requests https://github.com/requests/requests/blob/master/tox.ini
  - flask/tox.ini at master · pallets/flask https://github.com/pallets/flask/blob/master/tox.ini
  - django/tox.ini at master · django/django https://github.com/django/django/blob/master/tox.ini
  - nose/tox.ini at master · nose-devs/nose https://github.com/nose-devs/nose/blob/master/tox.ini
  - nose2/tox.ini at master · nose-devs/nose2 https://github.com/nose-devs/nose2/blob/master/tox.ini
  - pylint/tox.ini at master · PyCQA/pylint https://github.com/PyCQA/pylint/blob/master/tox.ini
  - selenium/tox.ini at master · SeleniumHQ/selenium https://github.com/SeleniumHQ/selenium/blob/master/py/tox.ini
  - ansible/tox.ini at devel · ansible/ansible https://github.com/ansible/ansible/blob/devel/tox.ini

## 跟 Docker 的關係 ??

  - [themattrix/docker\-tox: Docker base image for running tox with Python 2\.6, 2\.7, 3\.3, 3\.4, 3\.5, 3\.6, PyPy, and PyPy3\.](https://github.com/themattrix/docker-tox) 同時有各版本 Python 的 image! 做 library 時好用。
  - [dcrosta/tox\-docker: A tox plugin to run one or more Docker containers during tests](https://github.com/dcrosta/tox-docker) 在不同 environment 起不同的 container，用在 integration test 好像不錯? #ril
  - [Using Docker to run tox without adding Pythons to your system \- Ideas\.Offby1](https://ideas.offby1.net/posts/docker-runner-for-tox.html) 如何自己準備支援 tox 及不同 Python 版本的環境 #ril
  - [openstack/dox: Run tests in a docker container](https://github.com/openstack/dox) 靈感來自 tox #ril
  - [Dox a tool that run python (or others) tests in a docker container – Chmouel's Blog](https://blog.chmouel.com/2014/09/08/dox-a-tool-that-run-python-or-others-tests-in-a-docker-container/) (2014-09-08) #ril
  - [Testing Python Packages \| Integration with tox and Travis CI](http://pramodk.net/posts/2017/07/testing-python-packages/) (2017-07-16) #ril

## 跟 pyenv 的關係 ??

  - [pyenv does... - pyenv/pyenv: Simple Python version management](https://github.com/pyenv/pyenv#user-content-pyenv-does) 提到 Search commands from multiple versions of Python at a time. This may be helpful to test across Python versions with tox. 這跟 tox 什麼關係??
  - [Running Tox inside a pyenv virutalenv · Issue \#21 · pyenv/pyenv\-virtualenv](https://github.com/pyenv/pyenv-virtualenv/issues/21) #ril
  - [Using tox, pyenv and multiple version of python on OSX](https://gist.github.com/jstoiko/5492f8baa69c1722b984) pyenv 似乎就用來安裝多個版本的 Python interpreter?
  - [Using tox with pyenv · Issue \#92 · pyenv/pyenv](https://github.com/pyenv/pyenv/issues/92) #ril
  - [tox\-pyenv · PyPI](https://pypi.org/project/tox-pyenv/) #ril

## Hello, World!

```
def test_hello_world(cli):
    cli.src('tox.ini', r"""
    [tox]
    envlist = py27,py36

    [testenv]
    deps = pytest
    commands = pytest
    """)

    # setup.py in the same directory
    cli.src('setup.py', r"""
    from setuptools import setup

    setup(
        name='hello-world',
        packages=['hello'],
    )
    """)

    # production code
    cli.src('hello/__init__.py')
    cli.src('hello/hello.py', r"""
    def say_hello(who='World'):
        return 'Hello, %s!' % who
    """)

    # test code; at least one test
    cli.src('tests/test_hello.py', r"""
    from hello import hello

    def test_hello():
        assert hello.say_hello() == 'Hello, World!'
        assert hello.say_hello('pytest') == 'Hello, pytest!'
    """)

    r = cli.run('tox')
    assert 'py27: commands succeeded' in r.out
    assert 'py36: commands succeeded' in r.out

    # directories .tox/ and *.egg-info/ got created
    assert cli.exists('.tox/')
    assert cli.exists('hello_world.egg-info/')
```

參考資料：

  - [Basic example - Welcome to the tox automation project — tox 3\.0\.0rc3\.dev10 documentation](https://tox.readthedocs.io/en/latest/#basic-example) #ril
      - 透過 `pip install tox` 安裝，寫 `tox.ini` (也可以用 `tox-quickstart` 產生)，之後就能用 `tox` 指令來做事。
      - `tox.ini` 放在 `setup.py` 同一目錄下，裡面宣告要進行測試的多個 (virtualenv) test environment，以及會用到什麼套件，例如：

            [tox]
            envlist = py27,py36

            [testenv]
            deps = pytest
            commands = pytest

      - 執行 `tox` 就會打包 sdist package，分別安裝到 Python 2.7 與 3.6 的 virtualenv 進行測試 (第一次跑 tox 還要安裝 dependencies 比較花時間)；有打包進 package 才測得到!!
      - 注意不同版本的 Python 要自己先安裝好，否則會發生錯誤，這不是 tox 可以幫忙做掉的。

  - [Basic usage — tox 3\.0\.0rc3\.dev10 documentation](https://tox.readthedocs.io/en/latest/example/basic.html) #ril

## Configuration ??

  - [tox configuration specification — tox 3\.2\.2\.dev6 documentation](https://tox.readthedocs.io/en/latest/config.html) 裡面只有 `TOX_TESTENV_PASSENV` (space-separated) 與 `TOX_LIMITED_SHEBANG` #ril
  - [Selecting one or more environments to run tests against - General tips and tricks — tox 3\.2\.2\.dev9 documentation](https://tox.readthedocs.io/en/latest/example/general.html#selecting-one-or-more-environments-to-run-tests-against) 還有個 `TOXENV` #ril
  - [environment variable substitutions - tox configuration specification — tox 3\.2\.2\.dev6 documentation](https://tox.readthedocs.io/en/latest/config.html#environment-variable-substitutions) 從 `{env:KEY}` 看來，tox 對外溝通的介面是 environment variable，但除非用 `passenv` 指定，否則不會往下傳 #ril

## 使用 pytest ??

  - [pytest and tox — tox 3\.0\.0rc3\.dev10 documentation](https://tox.readthedocs.io/en/latest/example/pytest.html) #ril

## tox (CLI) ??

## tox-quickstart (CLI) ??

## 測試已經打包好的 package ??

  - [Welcome to twine’s documentation\! — twine 1\.11\.0 documentation](https://twine.readthedocs.io/en/stable/) Uploading files that have already been created, allowing testing of distributions before release；強調 testability 是因為，過往 `python setup.py upload` 只能上傳同一個 command invocation 產生的 package (例如 `python setup.py sdist upload`)，所以沒機會在 upload 前先驗證一下 package。
  - [1.4.3 (2013-02-28) - Changelog history — tox 3\.2\.2\.dev6 documentation](https://tox.readthedocs.io/en/latest/changelog.html#id229) 實驗性引入 `--installpkg=PATH` 直接安裝 package，而非建立新的 sdist；試過 `tox --installpkg dist/mylib-1.0.0-py2.py3-none-any.whl` 是沒有問題的。
  - [\[TIP\] Testing a binary distribution with Tox](http://lists.idyll.org/pipermail/testing-in-python/2015-June/006489.html) 提到用 `python setup.py bdist_wheel` 產生 wheel，再用 `tox --installpkg ARTIFACT_PATH` 的方式測試，就可以確保 "the binary distribution is good to go"。
  - [tox must create the source distribution with the Python of the virtual environment · Issue \#236 · tox\-dev/tox](https://github.com/tox-dev/tox/issues/236) pytoxbot: Note that there is a `--installpkg PATH` option which lets tox skip building alltogether. With a little "tox-front" script you could probably do the building yourself and then call `tox --installpkg=... -e env1,env2` for the time being.
  - [Avoiding expensive sdist - General tips and tricks — tox 3\.2\.2\.dev9 documentation](https://tox.readthedocs.io/en/latest/example/general.html#avoiding-expensive-sdist)
      - Some projects are large enough that running an sdist, followed by an install every time can be prohibitively costly. 原來會慢在這裡，在 `[tox]` 下加了 `skipsdist = True` 後，真的就變快了一些。
      - 一開始用 `--installpkg` 時還是會有 `xxx.egg-info` 產生，加上這個宣告後就不會了。
  - 後來發現加了 `skipsdist=True` 後，沒有打包 `.whl` 也能測試，好像直接拿 source code 了?
      - [1.6.0 (2013-08-15) - Changelog history — tox 3\.2\.2\.dev9 documentation](https://tox.readthedocs.io/en/latest/changelog.html?highlight=skipsdist#id220) add new config options `usedevelop` and `skipsdist` as well as a command line option `--develop` to install the package-under-test in DEVELOP MODE. thanks Monty Tailor for the PR. 感覺 `skipsdist=True` 時，也啟動了 developer mode??
  - [python \- How do I run tox in a project that has no setup\.py? \- Stack Overflow](https://stackoverflow.com/questions/18962403/) #ril

## Private Package Index ??

  - [using a different default PyPI url - Basic usage — tox 3\.1\.0a2\.dev1 documentation](http://tox.readthedocs.io/en/latest/example/basic.html#using-a-different-default-pypi-url) #ril
  - [installing dependencies from multiple PyPI servers - Basic usage — tox 3\.1\.0a2\.dev1 documentation](http://tox.readthedocs.io/en/latest/example/basic.html#installing-dependencies-from-multiple-pypi-servers) #ril

## 搭配 setup.py test 使用

tox 一定要搭配 `setup.py` 使用，但 setuptools 測試的慣例是 `setup.py test`，如何讓 `setup.py test` 用 tox 執行測試?

[tox-setuptools](https://pypi.org/project/tox-setuptools/) 可以讓你輕鬆完成這件事，不過 2016/10 後，整合 tox 與 `setup.py test` 就不被鼓勵，因為 `setup.py test` 預期在同一個 invocation interpreter，而不會像 tox 另外建立 virtualenvs，這會衍生一些問題，所以若真要整合的話，官方建議整合最終的 test tool (例如 pytest)。

不過按照 tox 的說法，Python 漸漸不以 `setup.py` 做為 tool entry point，整合 `setup.py test` 好像也沒什麼必要？

> As the python eco-system rather moves away from using `setup.py` as a tool entry point it’s maybe best to not go for any `setup.py test` integration.
>
> -- [Integration with “setup.py test” command - Basic usage](http://tox.readthedocs.io/en/latest/example/basic.html#integration-with-setup-py-test-command)]

參考資料：

  - [tox\-setuptools · PyPI](https://pypi.org/project/tox-setuptools/)
      - 整合 tox 與 setuptools 的 test runner，說是從 tox 官方文件的 sample code 而來；不過[現在官方文件](http://tox.readthedocs.io/en/latest/example/basic.html#integration-with-setup-py-test-command) 已經不建議整合 tox 與 `setup.py test` (2016/10 後)。
      - 在 `setup.py` 的 `setup()` 加上 `setup_requires=['tox-setuptools']` 即可，執行 `python setup.py test` 就會跑 tox。
  - [Integration with “setup.py test” command - Basic usage — tox 3\.1\.0a2\.dev1 documentation](http://tox.readthedocs.io/en/latest/example/basic.html#integration-with-setup-py-test-command) #ril
      - 整合 tox 與 `setup.py test` 從 2016/10 就不被鼓勵，因為它打破了 downstream distributions? 的預期 -- `setup.py test` 會執行在 invocation interpreter 而非另外建立 virtualenvs。
      - 若真想整合 `setup.py test`，建議整合最終的 test runner (例如 pytest)，而非中間的 tox。
      - As the python eco-system rather moves away from using setup.py as a tool entry point it’s maybe best to not go for any setup.py test integration. 這是真的嗎? 慢慢偏離 `setup.py`，就做為 "tool entry point" 這點而言。
  - [Packaging a python library \| ionel's codelog](https://blog.ionelmc.ro/2014/05/25/python-packaging/#running-the-tests) (2014-04-25) 覺得 `setup.py test` 的做法沒必要? #ril
  - [setuptools integration - Open Sourcing a Python Project the Right Way](https://jeffknupp.com/blog/2013/08/16/open-sourcing-a-python-project-the-right-way/) (2013-08-16) setuptools integration 重新定義了 `test` command。
  - [Python microlibs – Inside Shazam](https://blog.shazam.com/python-microlibs-5be9461ad979) (2017-04-12) 有用 tox，但 `setup.py` 只自訂了 `install` 與 `develop` 兩個 command #ril

## CI Integration ??

  - [Using tox with the Jenkins Integration Server — tox 3\.0\.0rc3\.dev10 documentation](https://tox.readthedocs.io/en/latest/example/jenkins.html) #ril

## Virtualenv Test Environment, Default Environment, Matrix ??

  - [Basic usage — tox 3\.0\.0rc3\.dev49 documentation](http://tox.readthedocs.io/en/latest/example/basic.html) 出現 default environments 的說法，包含 py、py2、py27、py3、py34...、jython、pypy、pypy3 等。
  - 在 `tox.ini` 裡，`[tox]` 下的 `envlist` 給所有的 test environment 不同的名字 (就是 virtualenv 的名稱，預設是 `.tox/<env>/`)，再由 `[testenv]` 底下的 `commands` 分別設定不同的 environment 執行不同的指令、帶不同的參數...
  - selenium/tox.ini at master · SeleniumHQ/selenium https://github.com/SeleniumHQ/selenium/blob/master/py/tox.ini 原來 test environment 不只是 Python 版本，還可以包含採用不同的 driver。
  - [Development environment — tox 3\.0\.0rc3\.dev10 documentation](https://tox.readthedocs.io/en/latest/example/devenv.html) #ril
  - [Compressing dependency matrix - Basic usage — tox 3\.0\.0rc3\.dev49 documentation](https://tox.readthedocs.io/en/latest/example/basic.html#compressing-dependency-matrix) #ril
  - `envlist = py{2,3}-requests{1,2}` 確實 `tox -l` 會列出 4 種組合，但 `tox -e request1` 還是能跑? 試過 tox 2.9.1 跟 3.x 都是一樣。
  - [Generative envlist - tox configuration specification — tox 3\.0\.0rc3\.dev49 documentation](https://tox.readthedocs.io/en/latest/config.html#generative-envlist) 說明 bash-style syntax 會產生幾種 environments #ril

參考資料：

  - [Virtualenv test environment settings - tox configuration specification — tox 3\.0\.0rc3\.dev43 documentation](http://tox.readthedocs.io/en/latest/config.html#virtualenv-test-environment-settings) Test environment 特有的設定寫在 `[testenv:NAME]`，通用的設定則寫在 `[testenv]`。
  - [Basic usage — tox 3\.0\.0rc3\.dev43 documentation](http://tox.readthedocs.io/en/latest/example/basic.html) #ril

## `tox.ini` 要怎麼寫?

  - 可以用 `tox-quickstart` 產生，再做修改。

```
[tox]
envlist = py26, py27

[testenv]
commands = pytest
deps =
    pytest
```

參考資料：

  - Welcome to the tox automation project https://tox.readthedocs.io/en/latest/ `tox.ini` 可以用 `tox-quickstart` 來產生
  - tox configuration specification — tox documentation http://tox.readthedocs.io/en/latest/config.html #ril
  - tox configuration and usage examples — tox documentation https://tox.readthedocs.io/en/latest/examples.html #ril

## 產生 JUnit XML report?

  - Using Tox with the Jenkins Integration Server — tox documentation http://tox.readthedocs.io/en/latest/example/jenkins.html 加上 `--junitxml=junit-{envname}.xml` 就會產生 JUnit XML reports；這裡 `--junitxml` 是 pytest 的用法，但 tox 提供 `{envname}` 這個變數。
  - 如何合併多個 environment 的結果?

## 合併多個測試環境的 Coverage ??

  - [python \- How can I combine coverage results with tox? \- Stack Overflow](https://stackoverflow.com/questions/50895525/)
      - Tim Martin: 假設有安裝 `pytest-coverage`，可以在 `[tool:pytest].addopts` 加上 `--cov-append` (其實就是為 `pytest` 加上 `--cov-append` 參數)，這會合併多次 test run 的結果，有助於把拆分 integration/unit tests。但後來提問的 Martin Thoma 說這並沒有解決問題 XD

## 執行速度很慢 ?? {: #slow }

  - [tox startup is very slow due to setup\.py and \.tox virtualenvs · Issue \#293 · tox\-dev/tox](https://github.com/tox-dev/tox/issues/293)

      - spookylukey: It could be considered a performance bug in setuptools, but fixing that is looking quite hard. I'm wondering if fixing it via tox would be better - after all, tox is triggering the really poor performance of `setup.py` by PUTTING THOUSANDS OF FILES IN THE WORKING DIRECTORY, and then suffering from it.

          - Solution 1: specify a toxworkdir outside the package directory - http://tox.readthedocs.org/en/latest/config.html#tox-global-settings

            The problem with this is that it is difficult to find a place which would be appropriate when you consider multiple people working on a project, possibly on different platforms. Also, it needs to be applied in every project that notices the problem.

            但為什麼把 `toxworkdir` 從 `{toxinidir}/.tox` 改到其他地方就會變快?

          - Solution 2: have a different default value for `toxworkdir`, something like `~/.cache/tox/virtualenvs/{project}`, where `{project}` gets substituted by something appropriate, like a mangled version of the working directory, perhaps combined with a platform name or something. This might also address issue #44 https://bitbucket.org/hpk42/tox/issues/44/cant-share-a-tox-directory-between-os-x

      - spookylukey: pypa/setuptools#450 was closed without a patch being merged, but pypa/setuptools#764 was merged, which hopefully addresses this.

      - spookylukey: With my test case, instead of tox having a startup overhead of: 10 minutes (cold start) or 40 seconds (warm start) ...it now has a startup overhead of: 40 seconds (cold start) or 1-2 seconds (warm start). Yay! This makes a world of difference.

        To see these benefits, you will need setuptools 28.5 or later in the virtualenv that has tox in it, and I think also in the virtualenvs that tox builds - so you may need to use `tox --recreate` to force the new version of setuptools to be installed. You also need to avoid use of `global_include` in your `MANIFEST` file, which will force all files to be scanned - and is probably not what you wanted anyway, because it will include files from hidden directories like `.git`, `.hg`, `.tox` etc.

        The tests aren't exact for a bunch of reasons, but should give a rough idea. The speedup I'm seeing is DUE TO TOX HAVING A LARGE NUMBER OF VIRTUALENVS, so in other cases it will be less extreme. The point to note is that you are no longer punished for having a large number of virtualenvs, which were being unnecessarily scanned by setuptools before (due to them being stored within `.tox` in the project directory).

        什麼是 code/warm start ?? 不過把 `.tox` 搬出 project directory 真的變很快!! 跑 `tox --notest` 準備多個 virtualenvs 時就感受得到。

## 安裝設置 {: #setup }

  - 在 virtualenv 下用 `pip install tox` 安裝，就會有 `tox` 與 `tox-quickstart` 指令可用。

參考資料：

  - [tox installation — tox 3\.0\.0rc3\.dev10 documentation](https://tox.readthedocs.io/en/latest/install.html) "It is fine to install tox itself into a virtualenv environment" 不是 test environment，而是另外一個 virtual environment 裝 tox。

## 參考資料 {: #reference }

  - [tox automation project](https://tox.readthedocs.io/)
  - [tox - PyPI](https://pypi.python.org/pypi/tox)
  - [tox-dev/tox - GitHub](https://github.com/tox-dev/tox)

社群：

  - ['tox' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/tox)

手冊：

  - [tox configuration specification](https://tox.readthedocs.io/en/latest/config.html)
  - [`tox` CLI](https://tox.readthedocs.io/en/latest/config.html#tox)
