---
title: pytest / Fixture
---
# [pytest](pytest.md) / Fixture

  - 別讓 fixture 有點 "固定" 的意思給誤導，fixture object 只是 pre-initialized objecti，單純就是傳統 setup 裡準備好的 object，可能是資料，也可能是工具，甚至是一種環境/狀況 (例如固定將 CWD 切換到全新的資料夾)。

參考資料：

  - [pytest fixtures: explicit, modular, scalable — pytest documentation](https://docs.pytest.org/en/latest/fixture.html) Fixture 提供固定的 baseline，有助於讓測試達到 reliable & repeatable；但 pytest fixture 有別於傳統 xUnit setup/teardown 的做法 (還是支援舊的做法)。
  - [Fixtures as Function arguments - pytest fixtures: explicit, modular, scalable — pytest documentation](https://docs.pytest.org/en/latest/fixture.html#fixtures-as-function-arguments) #ril
      - Test function 透過 input argument 取得 fixture object -- pytest 會去找同名的 fixture function (標示有 `@pytest.fixture`) 拿 fixture object。
      - Fixtures: a prime example of dependency injection 提到 pytest fixture 的做法正是 dependency injection 最好的範例，test function 不需要知道 import/setup/cleanup 的細節，就可以拿到準備好的 (fixture) object。
  - [classic xunit\-style setup — pytest documentation](https://docs.pytest.org/en/latest/xunit_setup.html) #ril

## capsys ??

  - [Builtin fixtures/function arguments - Pytest API and builtin fixtures — pytest documentation](https://docs.pytest.org/en/latest/builtin.html#builtin-fixtures-function-arguments) 提到 `capsys` 與 `capsysbinary` #ril
      - `capsys` 會啟用 sys.stdout/sys.stderr 的 capturing，呼叫 `capsys.readouterr()` 會得到一個 `(out, err)` tuple，分別是 stdout 與 stderr 在這個測試過程中抓取到的輸出。

## caplog ??

  - [Logging — pytest documentation (3.3.2)](https://docs.pytest.org/en/3.3.2/logging.html)
      - pytest 會自動補捉 (capture) 測試過程中寫出的 log messages，測試失敗時才會印出來 (連同補捉到的 stdout 與 stderr)；這項功能做為 pytest-catchlog plugin (從 pytest-capturelog 分出來) 的 drop-in replacement。
      - `pytest` 有許多參數可以調整 logging 的補捉行為，包括用 `--log-format` 與 `--log-date-format` 自訂 format，`--no-print-logs` 要求失敗時不印 captured logs，不過可以從 test 裡頭控制、驗證這些 log messages 才是比較有用的 -- `caplog` fixture。
      - `caplog.records` 可以拿到 list of `logging.LogRecord`，而 `caplog.text` 可以取得 final log text。要比對 log message 也可以用 `aplog.record_tuples`，它是 (logger name, severity, message) 的 tuple。過程中也可以用 `caplog.clear()` 將之前補捉到的 logs 都清掉；實驗發現，清掉的 log messages 在 test 失敗時還是會出現，不影響 debugging。
  - [Logging — pytest documentation (3.6.1)](https://docs.pytest.org/en/3.6.1/logging.html) #ril
      - 特別強調 3.3 開始支援，但 3.4 有重大改變；一樣會自動補捉測試過程中寫出的 log messages，但預設僅限於 level 高於 `WARNING` (含) 者。
  - [LogRecord attributes - 15\.7\. logging — Logging facility for Python — Python 2\.7\.14 documentation](https://docs.python.org/2/library/logging.html#logrecord-attributes) 常用的有 `levelname`/`levelno`、`message`、`name`、`thread`/`threadName`；從 logs 來測 multi-threading 似乎很有用??

## tmpdir ??

```
import os, py

def test_something(tmpdir):
    assert isinstance(tmpdir, py.path.local)

```

不過 `py.path.local` 並不是 file-like，所以有許多地方不能用，還是得轉回路徑名稱：

```
def test_howto_get_fullpath(tmpdir):
    fullpath = os.path.join(tmpdir.dirname, tmpdir.basename)
    assert fullpath == tmpdir.strpath # undocumented
```

參考資料：

  - [Reference — pytest documentation](https://docs.pytest.org/en/latest/reference.html#tmpdir) #ril
  - [Temporary directories and files — pytest documentation](https://docs.pytest.org/en/latest/tmpdir.html)
      - `tmpdir` fixture 會在 base temporary directory 底下為 test 提供獨立的 temporary directory (`pytest-NNN`)。預設的 base dir 是 system temporary directory，可以用 `--basetemp` 自訂。
      - 型態是 [`py.path.local`](http://py.readthedocs.io/en/latest/path.html#py-path-local-local-file-system-path)，提供比 `os.path` 更多的 methods，可以簡化檔案的操作/檢查。
  - [pytest\-dev/py: Python development support library \(note: maintenance only\)](https://github.com/pytest-dev/py) 這個 library 已經進入 maintenance mode，新的 code 不要再用它；這樣 test code 用它好嗎? => 用吧，確實能少做很做事，若之後 pytest 要換掉它，也會有替代方案。
  - [writing a pytest function to check outputting to a file in python? \- Stack Overflow](https://stackoverflow.com/questions/20531072/) flub: 提到 `tmp.strpath` (或 `str(tmpdir)`) 的用法；多數的 API 都不接受 `py.path.local`。
  - [pytest\-datafiles · PyPI](https://pypi.org/project/pytest-datafiles/) 看到 `str(datafiles)` 的用法，搭配 Convert from py.path object to path (str) 的註解。

## request ??

  - [Reference — pytest documentation](https://docs.pytest.org/en/latest/reference.html#request) #ril
      - 可以取得 requesting test function 的一些資訊。

## 自建 Fixture Plugin ??

如何自己打包像 [pytest-datafiles](https://pypi.org/project/pytest-datafiles/) 的套件，裝了就有 `datafiles` fixture 可以用，不用額外設定？

參考資料：

  - 裝完 `pytest-datafiles`，透過 `pytest --fixtures` 就可以看到 "fixtures defined from pytest_datafiles"，確認 `datafiles` 的說明，是從[標有 `@pytest.fixture` 的 `datafiles()`](https://github.com/omarkohl/pytest-datafiles/blob/master/pytest_datafiles.py#L64) 來的。
  - [pytest\-datafiles/setup\.py at master · omarkohl/pytest\-datafiles](https://github.com/omarkohl/pytest-datafiles/blob/master/setup.py#L36) `entry_points={ 'pytest11': ['pytest_datafiles = pytest_datafiles'], }`，不需要設定就能使用 `datafiles` fixture 的關鍵就在這裡。
  - [Making your plugin installable by others - Writing plugins — pytest documentation](https://docs.pytest.org/en/latest/writing_plugins.html#setuptools-entry-points) #ril
      - 
      - 建議為 plugin 加上 `Framework :: Pytest` 的 PyPI classifier，方便使用者找 plugins。

## 如何實現 setup/teardown??

  - [Fixture finalization / executing teardown code - pytest fixtures: explicit, modular, scalable — pytest documentation](https://docs.pytest.org/en/latest/fixture.html#fixture-finalization-executing-teardown-code) 將 `return` 改為 yield 即可 #ril

## 如何取得事先安排好的 data file?

`conftest.py`:

```
from os import path
import pytest

class DataFileHelper(object):

    def __init__(self, base_dir):
        self._base_dir = base_dir

    def read(self, fn):
        with open(path.join(self._base_dir, fn)) as f:
            return f.read()

    def json(self, fn):
        import json
        return json.loads(self.read(fn))

@pytest.fixture
def datafile(request):
    # 以 request.module.__file__ 的位置為起點，找出 `data/`
    base_dir = path.join(path.dirname(request.module.__file__), 'data')
    return DataFileHelper(base_dir)
```

用起來像是：

```
def test_xxx(datafile):
    json = datafile.json('api_output.json')
```

參考資料：

  - [omarkohl/pytest\-datafiles: pytest plugin to create a tmpdir containing a preconfigured set of files and/or directories\.](https://github.com/omarkohl/pytest-datafiles) 把檔案複製到 tmpdir，所以測試不會影響原來的檔案；如果單純要讀 data files 好像不需要用到這個。
  - [pytest\-datafiles 1\.0 : Python Package Index](https://pypi.python.org/pypi/pytest-datafiles) 出現 `FIXTURE_DIR = os.path.join( os.path.dirname(os.path.realpath(__file__)), 'test_files',)` 的用法。

## 如何為 Fixture 提供參數??

  - [omarkohl/pytest\-datafiles: pytest plugin to create a tmpdir containing a preconfigured set of files and/or directories\.](https://github.com/omarkohl/pytest-datafiles)
      - 用 `datafiles` fixture 搭配 `@pytest.mark.datafiles` 提供 data files。
      - [pytest\-datafiles/pytest\_datafiles\.py at master · omarkohl/pytest\-datafiles](https://github.com/omarkohl/pytest-datafiles/blob/master/pytest_datafiles.py#L64) 用 `request.keywords.get('datafiles').args` 與 `request.keywords.get('datafiles').kwargs` 取得透過 `@pytest.mark.datafiles(...)` 傳進來的資料。

## 參考資料 {: #reference }

手冊：

  - [Builtin fixtures/function arguments](https://docs.pytest.org/en/latest/builtin.html)
  - [Fixtures - Reference](https://docs.pytest.org/en/latest/reference.html#fixtures)
  - [py.path.local](https://py.readthedocs.io/en/latest/path.html#py-path-local-local-file-system-path)
