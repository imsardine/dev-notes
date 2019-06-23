# pytest

  - pytest: helps you write better programs — pytest documentation https://docs.pytest.org/en/latest/ 是個 test framework，可以寫簡單的 small test，也可以寫複雜的 functional test #ril

## pytest 或 py.test ??

  - 專案、工具名稱都叫 pytest，[PR #1633](https://github.com/pytest-dev/pytest/pull/1633) 改以 `pytest` 做為新的 entry point。

參考資料：

  - Changelog history — pytest documentation https://docs.pytest.org/en/latest/changelog.html Introduce pytest command as recommended entry point. Note that py.test still works and is not scheduled for removal.
  - python - "py.test" vs "pytest" command - Stack Overflow https://stackoverflow.com/questions/39495429/ `py.test` 是舊的用法，已被 `pytest` 取代；雖然兩者會並存很長一段時間...
  - pytest introduction - Python Testing (2013-01-15) http://pythontesting.net/framework/pytest/pytest-introduction/ pytest 指專案，`py.test` 是 command line。

## 應用實例 {: #powered-by }

  - requests/pytest.ini at master · requests/requests https://github.com/requests/requests/blob/master/pytest.ini
  - flask/test-requirements.txt at master · pallets/flask https://github.com/pallets/flask/blob/master/test-requirements.txt
  - pylint/pytest.ini at master · PyCQA/pylint https://github.com/PyCQA/pylint/blob/master/pytest.ini
  - selenium/conftest.py at master · SeleniumHQ/selenium https://github.com/SeleniumHQ/selenium/blob/master/py/conftest.py
  - [SQLAlchemy](https://github.com/zzzeek/sqlalchemy/blob/master/tox.ini)
  - [Scrapy](https://github.com/scrapy/scrapy/blob/master/pytest.ini)
  - [numpy/pytest\.ini at master · numpy/numpy](https://github.com/numpy/numpy/blob/master/pytest.ini)

## 為什麼要用 pytest? 測試跟它綁太緊好嗎? 要捨棄 unittest??

  - 許多用了 pytest 的知名專案，用 `git grep pytest | wc -l` 會發現用量還滿大的，同時 `git grep unittest` 還真的沒有結果；包括 Requests、Flask 等。
  - pytest fixtures: explicit, modular, scalable — pytest documentation https://docs.pytest.org/en/latest/fixture.html 許多地方要用 `@pytest`，從此 test code 就跟 pytest 綁定了，對其他人也增加了 pytest 的學習成本?
  - pytest vs nose2 | LibHunt https://python.libhunt.com/project/pytest/vs/nose2 從 fork 數跟 Google Trends，pytest 根本是大勝 nose2
  - Switching from nose to py.test at Mozilla (2015-06-02) https://agopian.info/presentations/2015_06_djangocon_europe/ pytest 的作者同時也參與 tox、pypy 的開發，支援 mark (像 Java 的 annotation，可以做 test filtering)、fixture (透過 test method 的 parameter 注入)、parametrized test；直接用 `assert` 比 `self.assertEqual` 更為 pythonic。組態檔分為 `pytest.ini` (mark、default prarameter) 與 `conftest.py` (fixture, plugin)；pytest + tox + travis 的組合很強大...

  - Why I use py.test and you probably should too (2013-07) http://halfcooked.com/presentations/pyconau2013/why_I_use_pytest.html #ril

## 新手上路 {: #getting-started }

  - [Installation and Getting Started — pytest documentation](https://docs.pytest.org/en/latest/getting-started.html) #ril

## CLI (pytest) ??

  - [Usage and Invocations — pytest documentation](https://docs.pytest.org/en/latest/usage.html) #ril

## Configuration ??

  - [Configuration — pytest documentation](https://docs.pytest.org/en/latest/customize.html) #ril
  - `pytest -h` 看到 "[pytest] ini-options in the first pytest.ini|tox.ini|setup.cfg file found"，難怪之前看到有些設定沒有寫在 `pytest.ini` 也可以作用，從 `tox.ini` 可見 pytest + tox 是多麼常見的組合。

## Live Log ??

  - [Live Logs - Logging — pytest documentation](https://docs.pytest.org/en/latest/logging.html#live-logs) #ril
      - 把 `log_cli` option 設為 `true` 時，pytest 會直接將 log 輸出到 console。

## skip, xfail, xpass ??

  - [Skip and xfail: dealing with tests that cannot succeed — pytest documentation](https://docs.pytest.org/en/stable/skipping.html) #ril

      - You can mark test functions that cannot be run on CERTAIN PLATFORMS or that you expect to fail so pytest can deal with them accordingly and present a summary of the test session, while keeping the test suite green.

        其中 certain platforms 是相對陝義的說法，下面 "some conditions are met" 的說法比較適當。

      - A skip means that you expect your test to pass ONLY IF SOME CONDITIONS ARE MET, otherwise pytest should skip running the test altogether. Common examples are skipping windows-only tests on non-windows platforms, or skipping tests that depend on an external resource which is not available at the moment (for example a database).

        skip 是指符合某些條件時才執行測試 (通常根據 Python 或 OS version)，例如 windows-only test 在 non-windows 平台就會被 skip 掉；是完全不執行，而非 skip 結果。

      - A xfail means that you EXPECT A TEST TO FAIL FOR SOME REASON.

        A common example is a test for a FEATURE NOT YET IMPLEMENTED, or a BUG NOT YET FIXED. When a test passes despite being expected to fail (marked with `pytest.mark.xfail`), it’s an xpass and will be reported in the test summary.

        xfail (`pytest.mark.xfail`) 是指你預期測試 "應該" 因為某種原因而失敗 (expected to fail)，所以測試通過了反而有問題，會被視為 xpass (unexpectedly passing)，例如功能尚未實作、問題當未修正等。

        上述 "feature not yet implemented" 與 "bug not yet fixed" 的說法，意謂著開發過程中可以善用 xfail 做為 TODO，也比較容易看出是否改壞了哪些應該通過的測試。

        不過 xpass 預設也只會 "reported in the test summary" 而已，並不會讓測試錯誤；可以透過 `xfail_strict=true` (或 `-o xfail_strict=true`) 強制讓它錯誤。

      - pytest counts and lists skip and xfail tests SEPARATELY. Detailed information about skipped/xfailed tests is not shown by default to avoid cluttering the output. You can use the `-r` option to see details corresponding to the “short” letters shown in the test progress:

            pytest -rxXs  # show extra info on xfailed, xpassed, and skipped tests

        More details on the `-r` option can be found by running `pytest -h`.

  - [Reference — pytest documentation](https://docs.pytest.org/en/3.5.0/reference.html#pytest-mark-skipif-ref) #ril

## 區分 Python 2 & 3 的測試 ??

```
import sys, pytest

py2_only = pytest.mark.skipif(sys.version_info[0] >= 3, reason='Python 2')
py3_later = pytest.mark.skipif(sys.version_info[0] <= 2, reason='Python 3+')

@py2_only
def test_xxx_py2():
    ...

@py3_later
def test_xxx_py3:
    ...
```

```
@pytest.fixture(scope="session")
def py2():
    return sys.version_info[0] == 2
```

## Parameterized Tests ??

參考資料：

  - [Parametrizing fixtures and test functions — pytest documentation](https://docs.pytest.org/en/latest/parametrize.html) #ril
      - pytest 可以在不同層級實現 test parametrization (同 parameterization 參數化) -- `@pytest.fixture()` 用在 fixture function，`@pytest.mark.parametrize()` 用在 test function/class，而 `pytest_generate_tests()` 則可以用來自訂 test parametrization??
      - `@pytest.mark.parametrize()` decorator 可以對 test function 的 arguments 進行參數化，例如： 注意第一個參數是 arguments 列表 (不是 list of str)，第二個參數是 list of tuple，依序代入不同的 pair of values。

```
import pytest
@pytest.mark.parametrize("test_input,expected", [
    ("3+5", 8),
    ("2+4", 6),
    ("6*9", 42),
])
def test_eval(test_input, expected):
    assert eval(test_input) == expected
```

      - 其中 pair of values 可以透過 `pytest.param(values, ..., marks=...)` 加上 marker，例如： `("6*9", 42)` 的組合會被視為 xfail

```
import pytest
@pytest.mark.parametrize("test_input,expected", [
    ("3+5", 8),
    ("2+4", 6),
    pytest.param("6*9", 42,
                 marks=pytest.mark.xfail),
])
def test_eval(test_input, expected):
    assert eval(test_input) == expected
```

      - 使用多個 `@pytest.mark.parametrize()` 會有 matrix 的效果。下面的例子會產生 `[0, 1]` x `[2, 3]` = 4 種組合。

```
import pytest
@pytest.mark.parametrize("x", [0, 1])
@pytest.mark.parametrize("y", [2, 3])
def test_foo(x, y):
    pass
```

  - [Parametrizing fixtures - pytest fixtures: explicit, modular, scalable — pytest documentation](https://docs.pytest.org/en/latest/fixture.html#fixture-parametrize) #ril
  - [Using marks with parametrized fixtures - pytest fixtures: explicit, modular, scalable — pytest documentation](https://docs.pytest.org/en/latest/fixture.html#using-marks-with-parametrized-fixtures) #ril
  - [Parametrizing tests — pytest documentation](https://docs.pytest.org/en/latest/example/parametrize.html) #ril
  - [& : Pytest parametrization — passing multiple data\-items to a single test](https://dpb.bitbucket.io/pytest-parametrization.html) (2015-03) #ril
  - [Create Tests via Parametrization \(2016\) — pytest\-tricks](https://hackebrot.github.io/pytest-tricks/create_tests_via_parametrization/) (2016-02-23) #ril
  - [TDD reading from excel with pytest\.mark\.parametrize · Issue \#1610 · pytest\-dev/pytest](https://github.com/pytest-dev/pytest/issues/1610) (2016-06-14) #ril

## Collection

  - 預設以當前的目錄往下找，只看 `test_*` 或 `*_test.py`；這一點和 `unittest` 的 test discovery 會看 `test*.py` 有些不同。
  - Module 裡 class 外的 function 會看 `test*()`，注意 `test` 後不一定要有底線。
  - Class 裡的 method 規則一樣，不過 class 若不是繼承 `unittest.TestCase` 的話，就只看名稱以 `Test` 開頭的 class (為什麼不是以 `Test` 結尾??)
  - 可以用 `--collect-only` 來看 test discovery 會找到哪些 test case，但不會真的執行測試。
  - `pytest -h` 的 `collection:` 列出所有跟 test collection 相關的參數。

參考資料：

  - Running multiple tests - Installation and Getting Started — pytest documentation https://docs.pytest.org/en/latest/getting-started.html#running-multiple-tests 從 current director 及 subdirectories 找 `test_.py` 及 `*_test.py`。
  - [25.3.3. Test Discovery - 25\.3\. unittest — Unit testing framework — Python 2\.7\.14 documentation](https://docs.python.org/2/library/unittest.html#test-discovery) Python `unittest` 預設的 pattern 是 `test*.py`，少了中間的底線。
  - [Specifying tests / selecting tests - Usage and Invocations — pytest documentation](https://docs.pytest.org/en/latest/usage.html#specifying-tests-selecting-tests) `pytest [OPTIONS] [...]` 中 `[...]` 的用法好多種，可以是 module、directory、ID 等 #ril
  - Conventions for Python test discovery - Good Integration Practices — pytest documentation https://docs.pytest.org/en/latest/goodpractices.html#conventions-for-python-test-discovery 首先找出 `test_*.py` 與 `*_test.py`，然後 import，除了 module 裡的 `test_*` functions，也會找 `Test*` class (不需要繼承特定的 class) 下的 `test_*` method，另外 `unittest.TestCase` 的 subclass 也會考量進來。
  - 用 pytest 3.2.3 試驗 (不該被執行的 `assert False`)，確認檔案只會找 `test_*.py`/`*_test.py` (中間的 `_` 一定要有)，但 class 外的 test method 只要 `test` 開頭就好 (不一定要是 `test_` 開頭)，至於 class name，若是繼承 `unittest.TestCase`，什麼命名都沒關係，如果不是的話則只看 `Test` 開頭的 class，最後 class 裡 test method 也只要以 `test` 開頭即可；結果跟官方文件寫的不太一樣...
  - [Naming conventions and test discovery](https://pytest.readthedocs.io/en/reorganize-docs/new-docs/user/naming_conventions.html) 提到 `pytest --collect-only` 可以測試 pytest 會找到哪些 test，但不會真的執行。
  - [Changing naming conventions - Changing standard \(Python\) test discovery — pytest documentation](https://docs.pytest.org/en/latest/example/pythoncollection.html#changing-naming-conventions) 可以用 `python_files`、`python_classes`、`python_functions` 自訂規則；例如 `python_classes=*Test` 就可以改用 `Test` 為結尾來判斷。

## Plugins??

  - [Installing and Using plugins — pytest documentation](https://docs.pytest.org/en/latest/plugins.html)
      - 安裝 plugin 一樣透過 `pip` 安裝 `pytest-*` 套件即可 (例如 `pip install pytest-cov`)，pytest 會自己找到它，不用特別 activate，除非是自己放在 test module 或 conftest file 裡的 plugin。
      - Plugin 的完整列表可以看 [pytest Plugin Compatibility](http://plugincompat.herokuapp.com/) (Py 2 & 3 的相容性測試結果) 或 [Index of Packages Matching 'pytest\-' - PyPI](https://pypi.python.org/pypi?%3Aaction=search&term=pytest-&submit=search) 找出 `pytest-*` 套件。
      - Pytest default plugin reference 內建許多 plugin，包括 `capture`、`junitxml`、`mark`、`tmpdir` 等。
  - [Writing plugins — pytest documentation](https://docs.pytest.org/en/latest/writing_plugins.html) #ril

## Code Coverage??

用 [pytest-cov](pytest-cov.md)，背後是接 [coverage.py](coverage.py.md)。

## Marker??

  - [Working with custom markers — pytest documentation](https://docs.pytest.org/en/latest/example/markers.html) #ril
  - [Grouping tests with pytest\.mark](http://pytest.readthedocs.io/en/reorganize-docs/new-docs/user/pytestmark.html) `-m <MARK>` 跟 `-m "not <MARK>` 可以只跑該 mark，或是不跑該 mark #ril
  - [Marking test functions with attributes — pytest documentation](https://docs.pytest.org/en/latest/mark.html) #ril

## pytest 不習慣把 test method 寫在 class 裡??

  - 測一個 class 時，可以把多個 test case 集中在一個 test class/suite 裡?
  - [flask/test\_helpers\.py at master · pallets/flask](https://github.com/pallets/flask/blob/master/tests/test_helpers.py#L57) `TestJSON` 就是把許多 test methods 集中在一個 class，但畢竟這還是少數。
  - [requests/test\_requests\.py at master · requests/requests](https://github.com/requests/requests/blob/master/tests/test_requests.py) requests 倒是不少寫在 class 裡的 test methods。

## 如何設定受測程式碼的位置??

後來發現 'No module named XXX' 的錯誤，跟 `tests/__init__.py` 是不存在有很大的關係。

參考資料：

  - [pytest import mechanisms and sys\.path/PYTHONPATH — pytest documentation](https://docs.pytest.org/en/latest/pythonpath.html#pythonpath) 講 "change sys.path in order to import test modules or conftest.py files" 為什麼沒提到受測程式?
  - `pytest --help` 看不到跟 `PYTHONPATH` 相關的設定。
  - [pytest\-pythonpath 0\.7\.1 : Python Package Index](https://pypi.python.org/pypi/pytest-pythonpath) PyTest 的 plugin，在測試執行前參考 `pytest.ini` 設定 `PYTHONPATH`
  - [Packaging a python library \| ionel's codelog](https://blog.ionelmc.ro/2014/05/25/python-packaging/#the-structure) 推廣 `src/mypkg` 的擺法，也用 pytest 在測試；或許用了 tox 的關係，會先安裝再測試，所以沒有自訂 `PYTHONPATH` 的需求? 但如果想用 pytest 單測一部份 test code 呢? #ril
  - [Initialization: determining rootdir and inifile - Configuration — pytest documentation](https://docs.pytest.org/en/latest/customize.html#initialization-determining-rootdir-and-inifile) 執行 `pytest` 一開始印出的 `rootdir:` 主要是用於併湊 node ID，也讓 plugins 知道可以把測試相關的資訊存在哪裡，也之所以規則會找 `pytest.ini`、`setup.cfg`、`tox.ini`、`setup.py` 等的位置，幾乎就是 project 的根目錄。不過再三強調這不會影響 `sys.path`/`PYTHONPATH`。
  - [python \- Ensuring py\.test includes the application directory in sys\.path \- Stack Overflow](https://stackoverflow.com/questions/20971619/) #ril
  - [python \- Py\.test No module named \* \- Stack Overflow](https://stackoverflow.com/questions/20985157/) #ril
  - [python \- PATH issue with pytest 'ImportError: No module named YadaYadaYada' \- Stack Overflow](https://stackoverflow.com/questions/10253826/) #ril

## pytest 會自動產生 `__pycache__` 與 `.cache`??

  - [Initialization: determining rootdir and inifile - Configuration — pytest documentation](https://docs.pytest.org/en/latest/customize.html#initialization-determining-rootdir-and-inifile) 提到內部的 cache plugin 會在 rootdir 下建立一個 `.cache` 資料夾，用來存放 cross-test run state??
  - [disable the creation of the \_\_pycache\_\_ directory · Issue \#200 · pytest\-dev/pytest](https://github.com/pytest-dev/pytest/issues/200) 搭配 `PYTHONDONTWRITEBYTECODE=1` 就不會產生 `__pycache__` 目錄。

## 對 Functional Test 提供哪些支援??

  - Going functional: requesting a unique temporary directory - Installation and Getting Started — pytest documentation https://docs.pytest.org/en/latest/getting-started.html#going-functional-requesting-a-unique-temporary-directory 對 functional tests 而言，最重要的是 fixture 的支援 #ril
  - incremental testing - test steps - Basic patterns and examples — pytest documentation https://docs.pytest.org/en/latest/example/simple.html#incremental-testing-test-steps 這裡 "a series of test steps" 的狀況應該是 functional tests 才會有 #ril
  - Why Pytest for writing functional API tests | Skimlinks (2015-04-21) https://skimlinks.com/blog/why-pytest-for-writing-functional-api-tests #ril
  - Pytest - One Solution for Unit, Functional and Acceptance Tests | Xoriant Blog (2017-01-12) https://www.xoriant.com/blog/product-engineering/pytest-one-solution-for-unit-functional-and-acceptance-tests.html #ril

## 如何安排 test code 的目錄結構??

  - Choosing a test layout / import rules - Good Integration Practices — pytest documentation https://docs.pytest.org/en/latest/goodpractices.html#choosing-a-test-layout-import-rules 只討論 test code 是否跟 application code 拆開，但都沒有提及 unit test 與 function test 的拆分；有沒有 `__init__.py` 會影響 pytest 匯入 test code 的方式，這裡建議把 source code 放 `src/mypkg/` 也滿特別的 #ril
  - Test directory structure http://pytest.readthedocs.io/en/reorganize-docs/new-docs/user/directory_structure.html #ril
  - Python unit testing with Pytest and Mock – Brendan Fortuner – Medium https://medium.com/@bfortuner/python-unit-testing-with-pytest-and-mock-197499c4623c `tests/` 下分為 `unit_tests/` 與 `integ_tests/` #ril

  - flask/tests at master · pallets/flask https://github.com/pallets/flask/tree/master/tests 沒有區分 unit 與 functional tests
  - requests/tests at master · requests/requests https://github.com/requests/requests/tree/master/tests 沒有區分 unit 與 functional tests
  - Usage and Invocations — pytest documentation https://docs.pytest.org/en/latest/usage.html 或許用 `@pytest.mark.slow` 來區分? 而非目錄結構
  - pytest is awesome - zerokspot.com https://zerokspot.com/weblog/2013/07/10/pytest-is-awesome/ 出現 `@pytest.mark.unit` 與 `@pytest.mark.integration` 的用法，`-m unit` 只執行 unit tests #ril
  - Categorise integration tests using PyTest. https://gist.github.com/billyshambrook/264624b039fb3caa9278 利用 `conftest.py` 搭配 `--integration` 選項 #ril
  - Marking test functions and selecting them for a run - Working with custom markers — pytest documentation https://docs.pytest.org/en/latest/example/markers.html#marking-test-functions-and-selecting-them-for-a-run 示範 `pytest.mark.webtest` 的用法 #ril
  - Custom marker and command line option to control test runs - Working with custom markers — pytest documentation https://docs.pytest.org/en/latest/example/markers.html#custom-marker-and-command-line-option-to-control-test-runs 跟上面 `--integration` 的設計有關 #ril

## 如何產生 JUnit XML Report??

  - Installing and Using plugins — pytest documentation https://docs.pytest.org/en/latest/plugins.html 提到 `_pytest.junitxml`
  - [Usage and Invocations — pytest documentation](https://docs.pytest.org/en/latest/usage.html#creating-junitxml-format-files) 用 `--junitxml=path` #ril

## 如何搭配 tox 使用??

  - Tox - Good Integration Practices — pytest documentation https://docs.pytest.org/en/latest/goodpractices.html#tox #ril

## 安裝設定 {: #installation }

  - 用 `virtualenv pytest` 建立一個虛擬環境，然後在環境內安裝 `pytest` 套件，再用 symbolic link 將環境內 `bin/pytest` 引出來即可。
  - 但如何引用開發環境 virtualenv 的其他相依性、受測的 code??

參考資料：

  - Installation and Getting Started — pytest documentation https://docs.pytest.org/en/latest/getting-started.html #ril
  - flask/test-requirements.txt at master · pallets/flask https://github.com/pallets/flask/blob/master/test-requirements.txt 出現 `test-requirements.txt` 的用法。

## 參考資料 {: #reference }

  - [pytest](https://docs.pytest.org/)
  - [pytest-dev/pytest - GitHub](https://github.com/pytest-dev/pytest)
  - [pytest Plugin Compatibility](http://plugincompat.herokuapp.com/)

社群：

  - ['py.test' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/py.test)

更多：

  - [Fixture](pytest-fixture.md)
  - [Assertion](pytest-assert.md)
  - [Docker](pytest-docker.md)

相關：

  - [pytest-cov](pytest-cov.md)
  - [pytest-benchmark](pytest-benchmark.md)

手冊：

  - [pytest Documentation](https://docs.pytest.org/)
  - [Reference - pytest](https://docs.pytest.org/en/latest/reference.html)
  - [Configuration Options](https://docs.pytest.org/en/latest/reference.html#configuration-options)
