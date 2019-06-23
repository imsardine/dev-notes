---
title: pytest / Assertion
---
# [pytest](pytest.md) / Assertion

## Exception ??

參考資料：

  - [Assertions about expected exceptions - The writing and reporting of assertions in tests — pytest documentation](https://docs.pytest.org/en/latest/assert.html#assertions-about-expected-exceptions) #ril
      - 把 `pytest.raises()` 當成 context manager 來用，就可以攔截特定的 exception，例如 `with pytest.raises(ZeroDivisionError):` 或 `with pytest.raises(RuntimeError) as excinfo:`。
      - 其中 `excinfo` 的型態是 `ExceptionInfo` (pytest 內部的型態，對 raised exception 的 wrapper)，主要的 attribute 裡 `.type` (exception type)、`.value` (exception)、`traceback`。
      - 雖然 `@pytest.mark.xfail(raises=ZeroDivisionError)` 也可以達成類似的效果，但 `pytest.raises` 比較常用在 deliberately raising，而 `@pytest.mark.xfail` 則用在 unfixed bugs 的 documentation。另外 `pytest.raises` 還提供 `match` keyword argument 比對 exception 的 string representation，例如 `with pytest.raises(ValueError, match=r'.* 123 .*'):`，其中 regex 背後是用 `re.search`，所以寫成 `match='123'` 也可以。
  - [Asserting that a certain exception is raised - Installation and Getting Started — pytest documentation](https://docs.pytest.org/en/latest/getting-started.html#asserting-that-a-certain-exception-is-raised) 用 `with pytest.raises(EXCEPTION_TYPE):` 將可能丟出 error 的程式包起來。
  - [28\.1\. sys — System\-specific parameters and functions — Python 2\.7\.14 documentation](https://docs.python.org/2/library/sys.html#sys.exc_info) 回傳 `(type, value, traceback)`。
  - [python \- How to use pytest to check that Error is NOT raised \- Stack Overflow](https://stackoverflow.com/questions/20274987/) 如何驗證沒有丟出 exception? Faruk Sahin: 攔截 exception 並呼叫 `pytest.fail(...)`；可這樣 stack trace 不見了??
  - [Writing well integrated assertion helpers - Basic patterns and examples — pytest documentation](https://docs.pytest.org/en/latest/example/simple.html#writing-well-integrated-assertion-helpers) 提到 test helper 可以呼叫 `pytest.fail()` marker? 讓 test 失敗並說明原因

## Assertion Introspection ??

  - [Create your fist test - Installation and Getting Started — pytest documentation](https://docs.pytest.org/en/latest/getting-started.html#create-your-first-test) 提到因為 assertion introspection 的關係，pytest 可以指出 assert expression 在執行期的 intermediate values，不需要去記 `assert*()` - 這裡稱之為 JUnit legacy methods。
  - [The writing and reporting of assertions in tests — pytest documentation](https://docs.pytest.org/en/latest/assert.html) 這裡都是 `assert ACTUAL == EXPECTED` 的寫法，比較符合 Python code 的寫法 #ril
  - [26\.4\. unittest — Unit testing framework — Python 3\.6\.5 documentation](https://docs.python.org/3/library/unittest.html#basic-example) 提醒用 `assert*()` 而非 `assert` statement，這樣才能累積測試結果並產生 report。
  - [Advanced assertion introspection - The writing and reporting of assertions in tests — pytest documentation](https://docs.pytest.org/en/latest/assert.html#advanced-assertion-introspection) 說明 assertion introspection 背後的原理 #ril

## 驗證浮點數 {: #floating-point }

```
from pytest import approx

def test_simple_equal__not_working():
    assert not 1.0 / 7 == 0.142857142857

def test_almost_equal__approx():
    assert repr(approx(0.5, rel=1e-3)) == '0.5 +- 5.0e-04'
    assert repr(approx(0.5, abs=1e-3)) == '0.5 +- 1.0e-03'

    assert 1.0 / 7 == approx(0.142857142857) # rel=1e-6, abs=1e-12
    assert 1.0 / 7 == approx(0.1428, abs=1e-4) # 0.1427 ... 0.1429

def test_almost_equal__scale():
    assert int((1.0 / 7) * 10**4) == 1428 # 0.1428... x 10000 = 1428...
```

參考資料：

  - [pytest.approx - Reference — pytest documentation](https://docs.pytest.org/en/latest/reference.html#pytest-approx)

      - Assert that two numbers (or two sets of numbers) are equal to each other WITHIN SOME TOLERANCE.

        Due to the intricacies of floating-point arithmetic, numbers that we would intuitively expect to be equal are not always so:

            >>> 0.1 + 0.2 == 0.3
            False

      - This problem is commonly encountered when writing tests, e.g. when making sure that floating-point values are what you expect them to be. One way to deal with this problem is to assert that two floating-point numbers are equal to within some appropriate tolerance:

            >>> abs((0.1 + 0.2) - 0.3) < 1e-6
            True

      - However, comparisons like this are tedious to write and DIFFICULT TO UNDERSTAND. Furthermore, ABSOLUTE COMPARISONS like the one above are USUALLY DISCOURAGED because there’s no tolerance that works well for ALL SITUATIONS.

        1e-6 is good for numbers around 1, but too small for very big numbers and too big for very small ones. It’s better to express the tolerance as a FRACTION OF THE EXPECTED VALUE, but RELATIVE COMPARISONS like that are even more difficult to write correctly and concisely.

        上面這種 absolute comparison 其實不建議用 (寫起來煩是另一回事)，因為 `1e-6` 對 1 可能剛好，但對比較大的數字而言又嫌太小，所以建議用 relative comparison (fraction of the expected value)。這概念還滿特別的，而且預設 1/1000000 對大部份情況已經夠精確，除非要比對的數字很大。

      - The `approx` class performs floating-point comparisons using a syntax that’s as INTUITIVE as possible:

            >>> from pytest import approx
            >>> 0.1 + 0.2 == approx(0.3)
            True

        The same syntax also works for sequences of numbers:

            >>> (0.1 + 0.2, 0.2 + 0.4) == approx((0.3, 0.6))
            True

        Dictionary values:

            >>> {'a': 0.1 + 0.2, 'b': 0.2 + 0.4} == approx({'a': 0.3, 'b': 0.6})
            True

        numpy arrays:

            >>> import numpy as np
            >>> np.array([0.1, 0.2]) + np.array([0.2, 0.4]) == approx(np.array([0.3, 0.6]))
            True

        And for a numpy array against a scalar:

            >>> import numpy as np
            >>> np.array([0.1, 0.2]) + np.array([0.2, 0.1]) == approx(0.3)
            True

      - By default, `approx` considers numbers within a RELATIVE TOLERANCE of `1e-6` (i.e. one part in a million) of its expected value to be equal.

        This treatment would lead to surprising results if the expected value was 0.0, because nothing but 0.0 itself is relatively close to 0.0. To handle this case less surprisingly, `approx` also considers numbers within an ABSOLUTE TOLERANCE of `1e-12` of its expected value to be equal.

      - Infinity and NaN are special cases. Infinity is only considered equal to itself, regardless of the relative tolerance. NaN is not considered equal to anything by default, but you can make it be equal to itself by setting the `nan_ok` argument to `True`. (This is meant to facilitate comparing arrays that use NaN to mean “no data”.)

        這是 NumPy 才有的東西 ??

      - Both the relative and absolute tolerances can be changed by passing arguments to the `approx` constructor:

            >>> 1.0001 == approx(1)
            False
            >>> 1.0001 == approx(1, rel=1e-3)
            True
            >>> 1.0001 == approx(1, abs=1e-3)
            True

        If you specify `abs` but not `rel`, the comparison will NOT consider the relative tolerance at all. In other words, two numbers that are within the default relative tolerance of 1e-6 will still be considered unequal if they exceed the specified absolute tolerance. If you specify both `abs` and `rel`, the numbers will be considered equal if EITHER tolerance is met:

            >>> 1 + 1e-8 == approx(1)
            True
            >>> 1 + 1e-8 == approx(1, abs=1e-12)
            False
            >>> 1 + 1e-8 == approx(1, rel=1e-6, abs=1e-12)
            True

        注意同時指定時，兩個條件的關係是 OR 不是 AND。另外 relative/absolute tolerance 預設值只有在 `rel` 跟 `abs` 都沒有給的情況下才會有作用；大部份的情況下兩者都不用給。

  - [python \- pytest: assert almost equal \- Stack Overflow](https://stackoverflow.com/questions/8560131/)
      - 如何驗證 float 的 "almost equal"? 甚至是在資料結構裡，例如 `(1.32, 2.4)`
      - dbn: pytest 3.0 開始提供 `approx()`，用法像是 `assert 2.2 == pytest.approx(2.3)` (不會過，因為預設的誤差是 `1e-6`) 或 `assert 2.2 == pytest.approx(2.3, 0.1)` (會過，因為 `0.1` 或 `1e-1` 是指容許下數後一位數的差異)

### 自訂 Assertion Comparison ??

  - [Defining your own assertion comparison - The writing and reporting of assertions in tests — pytest documentation](https://docs.pytest.org/en/latest/assert.html#defining-your-own-assertion-comparison) 為了 detailed explanations? 要在 `conftest.py` 提供 `pytest_assertrepr_compare()` 好不直覺，實作自己的 `__repr__()` 不行嗎?? #ril

## 參考資料

手冊：

  - [class `ExceptionInfo`](https://docs.pytest.org/en/latest/reference.html#exceptioninfo)
