# pytest-benchmark

  - [Proxying objects in Python \| ionel's codelog](https://blog.ionelmc.ro/2015/01/12/proxying-objects-in-python/) (2015-01-12) 第一次在這裡看到 `pytest-benchmark`，而這份文件的作者正是 `pytest-benchmark` 的開發者。

  - [ionelmc/pytest\-benchmark: py\.test fixture for benchmarking code](https://github.com/ionelmc/pytest-benchmark)

      - A pytest FIXTURE for benchmarking code. It will group the tests into ROUNDS that are CALIBRATED to the chosen timer. See calibration and FAQ.

        會有 "rounds that are calibrated" 的說法，是因為每個 round 要執行幾次 benchmarked function 是在 calibration phase 即使評估後決定的。

  - [Frequently Asked Questions — pytest\-benchmark 3\.2\.2 documentation](https://pytest-benchmark.readthedocs.io/en/latest/faq.html) #ril

## Hello, World!

```
$ cat test.py
import os
import time

SLEEP_MS = int(os.getenv('SLEEP_MS')) # (1)

def benchmarked_function():
    time.sleep(SLEEP_MS / 1000.0)

def test_datetime_now(benchmark):
    benchmark(benchmarked_function)
```

 1. 刻意用 `SLEEP_MS` 來控制執行速度，方便觀察 benchmark 的變化。

```
$ SLEEP_MS=1 pytest --benchmark-save=sleep-1ms test.py
============================================================================ test session starts ============================================================================
platform darwin -- Python 2.7.10, pytest-4.5.0, py-1.8.0, pluggy-0.11.0
benchmark: 3.2.2 (defaults: timer=time.time disable_gc=False min_rounds=5 min_time=0.000005 max_time=1.0 calibration_precision=10 warmup=False warmup_iterations=100000)
rootdir: /private/tmp/perf
plugins: benchmark-3.2.2
collected 1 item

test.py .                                                                                                                                                             [100%]
Saved benchmark data in: /private/tmp/perf/.benchmarks/Darwin-CPython-2.7-64bit/0001_sleep-1ms.json (1)



-------------------------------------------- benchmark: 1 tests --------------------------------------------
Name (time in ms)        Min     Max    Mean  StdDev  Median     IQR  Outliers       OPS  Rounds  Iterations (2)
------------------------------------------------------------------------------------------------------------
test_datetime_now     1.0099  2.8200  1.2903  0.1287  1.2791  0.1118    148;61  775.0020     902           1 (3)
------------------------------------------------------------------------------------------------------------

Legend:
  Outliers: 1 Standard Deviation from Mean; 1.5 IQR (InterQuartile Range) from 1st Quartile and 3rd Quartile.
  OPS: Operations Per Second, computed as 1 / Mean
========================================================================= 1 passed in 2.42 seconds ==========================================================================

$ SLEEP_MS=2 pytest --benchmark-save=sleep-2ms test.py
============================================================================ test session starts ============================================================================
platform darwin -- Python 2.7.10, pytest-4.5.0, py-1.8.0, pluggy-0.11.0
benchmark: 3.2.2 (defaults: timer=time.time disable_gc=False min_rounds=5 min_time=0.000005 max_time=1.0 calibration_precision=10 warmup=False warmup_iterations=100000)
rootdir: /private/tmp/perf
plugins: benchmark-3.2.2
collected 1 item

test.py .                                                                                                                                                             [100%]
Saved benchmark data in: /private/tmp/perf/.benchmarks/Darwin-CPython-2.7-64bit/0002_sleep-2ms.json



-------------------------------------------- benchmark: 1 tests --------------------------------------------
Name (time in ms)        Min     Max    Mean  StdDev  Median     IQR  Outliers       OPS  Rounds  Iterations
------------------------------------------------------------------------------------------------------------
test_datetime_now     2.0211  3.2320  2.5328  0.1702  2.6190  0.1232     60;57  394.8176     381           1 (4)
------------------------------------------------------------------------------------------------------------

Legend:
  Outliers: 1 Standard Deviation from Mean; 1.5 IQR (InterQuartile Range) from 1st Quartile and 3rd Quartile.
  OPS: Operations Per Second, computed as 1 / Mean
========================================================================= 1 passed in 2.21 seconds ==========================================================================
```

 1. 因為 `--benchmark-save=sleep-1ms` 的關係，benchmark 的結果會寫到 `./benchmarks/.../NNNN_sleep-1ms.json`，之後可以與其他 benchmark 比較。
 2. Name (time in ms) 提示了 result table 中各項數據的單位 -- 會隨著 benchmarked 的快慢而異，可能是 ns (nanosecond)、us (microsecond)、ms (millisecond) 或 s (second) 等。
 3. 中間暫停 1ms -- 每個 round 執行 1 次 benchmarked iteration (因為 1ms 已經大於 10 x timer resolution)，總共執行了 902 次。
 4. 中間暫停 2ms -- 每個 round 執行 1 次 benchmarked iteration，總共執行了 381 次；初步看來，時間差不多就是第一次的 2 倍。

```
$ pytest-benchmark compare

--------------------------------------------------------------------------------------- benchmark: 2 tests --------------------------------------------------------------------------------------
Name (time in ms)                       Min               Max              Mean            StdDev            Median               IQR            Outliers       OPS            Rounds  Iterations
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
test_datetime_now (0001_sleep-1)     1.0099 (1.0)      2.8200 (1.0)      1.2903 (1.0)      0.1287 (1.0)      1.2791 (1.0)      0.1118 (1.0)        148;61  775.0020 (1.0)         902           1 (1)
test_datetime_now (0002_sleep-2)     2.0211 (2.00)     3.2320 (1.15)     2.5328 (1.96)     0.1702 (1.32)     2.6190 (2.05)     0.1232 (1.10)        60;57  394.8176 (0.51)        381           1 (2)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Legend:
  Outliers: 1 Standard Deviation from Mean; 1.5 IQR (InterQuartile Range) from 1st Quartile and 3rd Quartile.
  OPS: Operations Per Second, computed as 1 / Mean
```

 1. 中間暫停 1ms；第一行數據是基準，所以各項數據後面都是 (1.0)，表示倍率。
 2. 中間佔停 2ms；各項數據後面是基準的倍數，Min、Max、Mean、Median 符合預期都在 2.0 左右。

## 新手上路 {: #getting-started }

  - [Better tests and benchmarks with pytest\-benchmark \- Python High Performance \- Second Edition](https://subscription.packtpub.com/book/application_development/9781787282896/1/ch01lvl1sec2/better-tests-and-benchmarks-with-pytest-benchmark)

      - The Unix `time` command is a versatile tool that can be used to assess the running time of small programs on a variety of platforms. For larger Python applications and libraries, a more comprehensive solution that deals with BOTH TESTING AND BENCHMARKING is `pytest`, in combination with its `pytest-benchmark` plugin.

  - [Calibration — pytest\-benchmark 3\.2\.2 documentation](https://pytest-benchmark.readthedocs.io/en/latest/calibration.html)

    先瞭解 calibration 跟 timer resolution 的問題，接下來的 Glossary 才知道在講什麼，也才看得懂 result table 中各項數據的意義。

      - `pytest-benchmark` will run your function MULTIPLE TIMES BETWEEN MEASUREMENTS. A round is that SET OF RUNS done between measurements. This is quite similar to the builtin `timeit` module but it’s MORE ROBUST.

        其中的 run 在 pytest-benchmark 裡有另一個 iteration 的說法，指的都是 benchmarked function 執行一次。

      - The problem with measuring SINGLE RUNS appears when you have VERY FAST CODE. To illustrate:

        ![](https://github.com/ionelmc/pytest-benchmark/raw/master/docs/measurement-issues.png)

        關鍵在左上方的 Timer resolution: 500ns，所以最上面 Benchmark A & B 不足 500ns 被視為 0ns，中間 Benchmark C & D 不足 1µs 視為 500ns。

        注意下方 Benchmark A & C 開始的時間比較晚，因為 Benchmark A 沒跨過 1µs 但 Benchmark C 有跨過，所以就有 500ns 與 1µs 的差別。

      - In other words, a round is a set of runs that are AVERAGED TOGETHER, those resulting numbers are then used to compute the result tables.

        The default settings will try to KEEP THE ROUND SMALL ENOUGH (so that you get to see variance), but not too small, because then you have the TIMER CALIBRATION ISSUES illustrated above (your test function is FASTER THAN OR AS FAST AS THE RESOLUTION OF THE TIMER).

        由於 benchmarked function 單次執行時間可能遠低於 timer resolution，所以每個 round 會連續執行多次使總執行時間貼近 10 倍 timer resolution，再透過平均值求取單次的執行時間；多個 round 就有多個數據，也就可以算 min、max、mean、stddev、median 等。

        而 calibration phase 就是試著執行看看 benchmarked function 以決定一個 round 要執行幾次，才能遶開 timer resolution 可能不夠細的問題。

      - By default `pytest-benchmark` will try to run your function AS MANY TIMES NEEDED TO FIT A 10 x `TIMER_RESOLUTION` period. You can fine tune this with the `--benchmark-min-time` and `--benchmark-calibration-precision` options.

  - [Glossary — pytest\-benchmark 3\.2\.2 documentation](https://pytest-benchmark.readthedocs.io/en/latest/glossary.html)

    要先有 calibration 的基礎。

      - Iteration

        A SINGLE RUN of your benchmarked function.

      - Round

        A SET OF ITERATIONS. The size of a round is COMPUTED IN THE CALIBRATION PHASE.

        Stats are computed with rounds, not with iterations. The duration for a round is an AVERAGE of all the iterations in that round.

        See: Calibration for an explanation of why it’s like this.

      - Mean

        TODO: 平均值

      - Median

        TODO: 中位數

      - IQR

        InterQuertile Range. This is a different way to measure VARIANCE. Good explanation [here](https://www.dataz.io/display/Public/2013/03/20/Describing+Data%3A+Why+median+and+IQR+are+often+better+than+mean+and+standard+deviation) #ril
      - StdDev

        TODO: Standard Deviation

      - Outliers (TODO)

  - [Examples - ionelmc/pytest\-benchmark: py\.test fixture for benchmarking code](https://github.com/ionelmc/pytest-benchmark#examples)

    But first, a prologue:

      - This plugin TIGHTLY INTEGRATES into pytest. To use this effectively you should know a thing or two about pytest first. Take a look at the introductory material or watch talks.

        事實上 `pytest-benchmark` 對 `pytest` 的版本也很要求，否則會遇到累似下面的錯誤：

            pluggy.manager.PluginValidationError: Plugin 'benchmark' could not be loaded: (pytest 3.7.1 (/tmp/tox/py3/lib/python3.7/site-packages), Requirement.parse('pytest>=3.8'))!

        Few notes:

          - This plugin benchmarks FUNCTIONS and only that. If you want to measure block of code or whole programs you will need to write a WRAPPER FUNCTION.
          - In a test you can only benchmark ONE FUNCTION. If you want to benchmark many functions write more tests or use [parametrization](http://docs.pytest.org/en/latest/parametrize.html).
          - To run the benchmarks you simply use pytest to run your "tests". The plugin will automatically do the benchmarking and generate a RESULT TABLE. Run `pytest --help` for more details.

        This plugin provides a `benchmark` FIXTURE. This fixture is a CALLABLE object that will benchmark any function passed to it.

        因為是 fixture，所以不用 import。

      - Example:

            def something(duration=0.000001):
                """
                Function that needs some serious benchmarking.
                """
                time.sleep(duration)
                # You may return anything you want, like the result of a computation
                return 123

            def test_my_stuff(benchmark):
                # benchmark something
                result = benchmark(something) # 這樣是執行幾次 ??

                # Extra code, to verify that the run completed correctly.
                # Sometimes you may want to check the result, fast functions
                # are no good if they return incorrect results :-)
                assert result == 123 # 為何不是 assert 執行時間低於某個標準 ??

      - You can also pass extra arguments:

            def test_my_stuff(benchmark):
                benchmark(time.sleep, 0.02)

        Or even keyword arguments:

            def test_my_stuff(benchmark):
                benchmark(time.sleep, duration=0.02)

      - Another pattern seen in the wild, that is not recommended for MICRO-BENCHMARKS (very fast code) but may be convenient:

            def test_my_stuff(benchmark):
                @benchmark
                def something():  # unnecessary function call
                    time.sleep(0.000001)

        A better way is to just benchmark THE FINAL FUNCTION:

            def test_my_stuff(benchmark):
                benchmark(time.sleep, 0.000001)  # way more accurate results!

      - If you need to do fine control over how the benchmark is run (like a setup function, exact control of iterations and rounds) there's a special mode - pedantic:

            def my_special_setup():
                ...

            def test_with_setup(benchmark):
                benchmark.pedantic(something, setup=my_special_setup, args=(1, 2, 3), kwargs={'foo': 'bar'}, iterations=10, rounds=100)

  - [Usage — pytest\-benchmark 3\.2\.2 documentation](https://pytest-benchmark.readthedocs.io/en/latest/usage.html) #ril
  - [Writing tests and benchmarks \- Python High Performance \- Second Edition](https://subscription.packtpub.com/book/application_development/9781787282896/1/ch01lvl1sec1/writing-tests-and-benchmarks) #ril
  - [Pedantic mode — pytest\-benchmark 3\.2\.2 documentation](https://pytest-benchmark.readthedocs.io/en/latest/pedantic.html) #ril

## Comparsion ??

  - 在硬體條件不變的情況下，比較不同次 benchmark 的結果才有意義。

    以 GitLab CI 為例，每個 build 的測試都可能跑在不同的 runner 上，比較不同 build 的 benchmark 就不太有意義？

---

參考資料：

  - [Comparing past runs — pytest\-benchmark 3\.2\.2 documentation](https://pytest-benchmark.readthedocs.io/en/latest/comparing.html) 在 test code 裡不會檢查 benchmark 的結果 ?? #ril
  - [Comparison CLI - Usage — pytest\-benchmark 3\.2\.2 documentation](https://pytest-benchmark.readthedocs.io/en/latest/usage.html#comparison-cli) #ril

## Assertion ??

  - [pytest\-benchmark/fixture\.py at master · ionelmc/pytest\-benchmark](https://github.com/ionelmc/pytest-benchmark/blob/master/src/pytest_benchmark/fixture.py#L65) `benchmark.stats` 似乎可以用來判定結果 #ril
  - https://github.com/ionelmc/pytest-benchmark/blob/master/src/pytest_benchmark/stats.py #ril
  - [pytest\-benchmark/stats\.py at master · ionelmc/pytest\-benchmark](https://github.com/ionelmc/pytest-benchmark/blob/master/src/pytest_benchmark/stats.py) 記錄了 benchmark 的結果 #ril

## 安裝設定 {: #installation }

  - [Installation - ionelmc/pytest\-benchmark: py\.test fixture for benchmarking code](https://github.com/ionelmc/pytest-benchmark#installation)

        pip install pytest-benchmark

## 參考資料 {: #reference }

  - [ionelmc/pytest-benchmark](https://github.com/ionelmc/pytest-benchmark)
  - [pytest-benchmark - PyPI](https://pypi.org/project/pytest-benchmark/)

文件：

  - [pytest-benchmark Documentation](https://pytest-benchmark.readthedocs.io/en/latest/)

手冊：

  - [Commandline Options](https://pytest-benchmark.readthedocs.io/en/latest/usage.html#commandline-options)
