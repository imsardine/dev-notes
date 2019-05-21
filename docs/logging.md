# Logging

  - [Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/logging.html) 用來記錄 software 執行過程式各種 event 的方式，用 logging call 來表示 "certain events have occurred"

## 使用時機 ??

  - [When to use logging - Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/logging.html#when-to-use-logging) 除了要輸出訊息用 `print()` 外，其餘大部份都用 `logging.xxx()`，但若是 library 的 client code 改變用法就能避開的 warning 要用 `warnings.warn()` 而非 `logging.warning()`。

## Event, Message, Level/Severity ??

  - [Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/logging.html) #ril
      - 一個 event 由 (descriptive) message (裡面可能含有 variable data) 及 importanace 組成，其中 importance 也稱做 level/severity。
  - [Printing methods and the basic selection rule - Chapter 2: Architecture](https://logback.qos.ch/manual/architecture.html#basic_selection) 把 level 區分為 request level 與 effective level 兩種 #ril

## Log Level -- DEBUG, INFO, WARNING, ERROR, CRITICAL ??

  - 就如同 comment 要說明一些假設時用 assertion 取代，當 comment 要說明接下來這一段 code 要做什麼時，可以考慮用 INFO/DEBUG log 取代。
  - DEBUG 雖然做為 diagnostic 用途，但若是 variable data 用 debug 印出，平常 level 就要開 DEBUG? 看來做為能 reproduce 某個 error 的 input 都要用 INFO 寫出才行?? => 可以在發生錯誤時，挾帶足夠的資訊，平常不用輸出 debug 也沒關係，這樣似乎取得了折衷?
  - 最難區分的是 DEBUG 與 INFO；INFO 用在 business/domain 的層級，而 DEBUG 用在實作細節的層級。

參考資料：

  - [Logging levels \- Logback \- rule\-of\-thumb to assign log levels \- Stack Overflow](https://stackoverflow.com/questions/7839565/) #ril
      - ecodan: 都在做大型系統，會從 production support 的角度來看。
      - Phil Parker: INFO 是給 operator 看 (例如一個 request 就一個 INFO)，甚至覺得 DEBUG 完全不該用!? 開發時期用 TDD + Debugging。
  - [Choosing Log Levels \| SysteMajik Consulting](https://www.systemajik.com/blog/loglevels/) #ril
  - [Choosing a Log Level \| preaction \[blogs\.perl\.org\]](http://blogs.perl.org/users/preaction/2017/03/choosing-a-log-level.html) (2017-03-27) #ril

## Log 加在 operation 前/後? 加在 function 裡/外??

  - Caller 端用 INFO log，內部則用 DEBUG log?? 外部的 script 才知道步驟，而且 function 也可能被不同的 process 調用?
  - Function 內可以用 debug 印出 argument，因為 caller 端的 parameter 可能是計算出來的，要同時做 logging 不太方便；log call 太多會降低可讀性。
  - Function 的 return 值由 caller 來做 log，因為一個 function 可能有多個出口，但 function 內倒是可以 log 出 indirect input。

## 如何在 log message 揭露重要的數據??

  - Log message 會夾帶有助於診斷問題的資訊，例如 `Create user; name = [Jeremy], job = [Developer] ...`。
  - 其中 `[...]` 用中括號框起來方便識別空白字元，不過有些語言的 string formatting 支援 literal 輸出，例如 Python 的 `%r`，用起來像是 `logger.info('Create user; name = %r, job = %r', name, job)`，就不用自己加 `[...]` 這些框框。

## 參考資料 {: #reference }

更多：

  - [Python](python-logging.md)

