# pytest-cov

  - [pytest\-cov 2\.5\.1 : Python Package Index](https://pypi.python.org/pypi/pytest-cov) #ril
      - 量測並產生 coverage report 的 pytest plugin，支援 centralised/distributed testing (in both load and each modes)，也支援 coverage of subprocesses??
      - 背後用的是 coverage.py，可以透過 pytest-cov 或是 coverage.py 自己的組態檔設定。
  - [Welcome to pytest\-cov’s documentation\! — pytest\-cov 2\.5\.1 documentation](http://pytest-cov.readthedocs.io/en/latest/) #ril

## 新手上路 {: #getting-started }

  - [pytest\-cov 2\.5\.1 : Python Package Index](https://pypi.python.org/pypi/pytest-cov) #ril
      - 安裝 `pytest-cov` 套件，接著就能用 `--cov` 指定 package，再用 `--cov-report html` 或 `--cov-report xml` 輸出不同格式的 report。
      - `pytest --help | grep -e '--cov'` 會看到 `--cov=[path]          measure coverage for filesystem path (multi-allowed)` 原來可以指定多個。
      - 如果有多個 Python module 要檢查，`--cov` 要怎麼給?? 發現沒給 `--cov` 會自動找所有的 `.py`；給定一個 module 沒有問題。

## Branch Coverage ??

  - return True if condition 
  - [Changelog — pytest\-cov 2\.5\.1 documentation](http://pytest-cov.readthedocs.io/en/latest/changelog.html) 沒有文件整理出所有的 options，但 changelog 提到許多 `--cov-*` 的異動，包括 `--cov-branch` 可以啟用 branch coverage，這是其他文件沒提到的 #ril

## 合併多次測試的 Coverage ??

`Makefile`:

```
test:
	coverage erase # 清除 .coverage
	tox            # 內部累加 .coverage
	coverage html  # 產生 HTML report
```

參考資料：

  - [Coverage Data File - pytest\-cov · PyPI](https://pypi.org/project/pytest-cov/#coverage-data-file) 每個 test run 開始，coverage data file (`.coverage`) 會被清除，如果想要合併多次 test run 的 coverage，可以用 `--cov-append`，也就是一開始不會刪除 coverage data file；這個 data file 在 test run 結束時會留著，讓其他 coverage tool 可以利用。
  - [python \- How can I combine coverage results with tox? \- Stack Overflow](https://stackoverflow.com/questions/50895525/) 為 `pytest` 加上 `--cov-append` 參數，會合併多次 test run 的結果，有助於把拆分 integration/unit tests?
  - [2.1.0 (2015-08-23) - Changelog — pytest\-cov 2\.5\.1 documentation](https://pytest-cov.readthedocs.io/en/latest/changelog.html#id16) 2.1.0 加入 `--cov-append`，跟 [PR#80](https://github.com/pytest-dev/pytest-cov/pull/80) 有關。

## 安裝設置 {: #setup }

  - [Installation - pytest\-cov 2\.5\.1 : Python Package Index](https://pypi.python.org/pypi/pytest-cov#installation) 安裝 `pytest-cov` 套件，若要用 distributed testing 則要額外裝 `pytest-xdist`。
  - [Installation - Overview — pytest\-cov 2\.5\.1 documentation](http://pytest-cov.readthedocs.io/en/latest/readme.html#installation)

## 參考資料 {: #reference }

  - [pytest-cov - PyPI](https://pypi.python.org/pypi/pytest-cov)
  - [pytest-dev/pytest-cov - GitHub](https://github.com/pytest-dev/pytest-cov)

手冊：

  - [Changelog](http://pytest-cov.readthedocs.io/en/latest/changelog.html)
  - [pytest-cov Documentation](http://pytest-cov.readthedocs.io/en/latest/)
