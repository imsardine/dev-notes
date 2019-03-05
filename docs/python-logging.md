---
title: Python / Logging
---
# [Python](python.md) / Logging

## 新手上路 ?? {: #getting-started }

  - [Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html) #ril
  - [Logging Cookbook — Python 3\.6\.4 documentation](https://docs.python.org/3.6/howto/logging-cookbook.html) #ril
  - [15\.7\. logging — Logging facility for Python — Python 2\.7\.14 documentation](https://docs.python.org/2/library/logging.html) #ril

## Logger、handler、filter、formatter ??

  - Logger (level) -> filter -> hander (level) -> filter -> formatter -> output

參考資料：

  - [Logging Flow - Logging HOWTO — Python 3\.6\.5 documentation](https://docs.python.org/3.6/howto/logging.html#logging-flow) #ril
      - Handler 作用 (attach) 在 logger 上，而 filter 則可以作用在 logger 與 handler 上，分別控制 logger 要不要往 handler 送，或是 handler 要不要往 output 送 (經過 formatter)。
      - 注意 filter 是在 logger/handler 檢查 logging level 之後；所以 logger 有 `setLevel()`、`addHandler()`、`addFilter()`，而 handler 則有 `setLevel()`、`addFilter()` 與 `setFormatter()` (少了 `addFilter()` 但多了 `setFormatter()`)

## Logging Level ??

  - [Logging Levels - logging — Logging facility for Python — Python 3\.7\.0 documentation](https://docs.python.org/3/library/logging.html#logging-levels)
      - 每個 logging level 背後都對應了 numeric value。需要知道這個 numeric value，通常是想要自訂 level，需要知道相對於 predefined level 的位置。
      - 事實上 `logging.INFO` (20)、`logging.DEBUG` (10) 等常數的值就是這裡列出來的 numeric value；注意還有個 `logging.NOTSET` (0)
  - [When to use logging - Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/logging.html#when-to-use-logging) #ril
      - `logging.debug()` 跟 `logging.info()` 用在 normal operation 時記錄 events (確認 "things are working as expected")，只是 `debug()` 做為 diagnostic 用途會更細。
      - Warning 就如字面上的意思，警告發現一些不尋常的狀況，未來可能會出事 (例如用到 deprecated API)；分為 `warning.warn()` 與 `logging.warning()`，兩者的差異在於前者 client code 可以調整，後者則跟 client code 調整無關；前者在寫 library 時會用到，有點像是 programming error，改一下寫法就好了。
      - `logging.error()`、`logging.exception()` 跟 `logging.critical()` 都用在錯誤被壓下來 (suppression)，不會往外拋例外 (所以搭配 `raise` 是不好的??)；例如 long-running server process。
      - `logging.error()` 跟 `logging.exception()` 分別用在 application domain 與 specific error；從 `Logger.exception` 的文件看來，總是會把 exception info 加到 logging message 裡，所以只應用在 exception handler 裡。

## LogRecord ??

  - [LogRecord Objects - logging — Logging facility for Python — Python 3\.7\.0 documentation](https://docs.python.org/3/library/logging.html#logrecord-objects) #ril
      - `LogRecord` 會在 `Logger.xxx()` 記錄 message 時產生，內含 logged event 所有相關的資訊。
      - 主要的資訊是 `msg` 與 `args`，合併這兩者 (`str(msg) % args`) 就可以得到 `message` (注意 `msg` 與 `message` 的差別)；透過 `LogRecord` constructor 傳入的資訊，還可以推算出 `LogRecord` 許多不同的 attributes，而這些 attributes 正是 formatting string 裡 `%(xxx)s` 引用的來源，但 constructor parameters 跟 attributes 並非 1:1 的關係，例如 `level` (numeric) 會轉換成 `levelno` (numeric) 與 `levelname` 兩個 attribute。
  - [Formatter Objects - logging — Logging facility for Python — Python 3\.7\.0 documentation](https://docs.python.org/3/library/logging.html#formatter-objects) Responsible for converting a `LogRecord` to (usually) a string which can be interpreted by either a human or an external system. 透過 formatting string (預設是 `%(message)`) 將 `LogRecord` 轉成文字。
  - [Using arbitrary objects as messages - Logging HOWTO — Python 3\.7\.0 documentation](https://docs.python.org/3/howto/logging.html#using-arbitrary-objects-as-messages) 在這之前都假設 message 是個 string，但 message 其實可以是任何 object，當內部需要 string representation 時，就會呼叫它的 `__str__()`。事實上內部也不一定會將它轉成 string，像是 `SocketHandler` 將 message 直接 pickle 就往外送了。

## Handler ??

  - Handler 決定了 destination，若只是想要改變輸出的內容，應該要從 formatter 下手，搭配現有的 handler。

參考資料：

  - [Handlers - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#handlers) #ril
      - `Handler` objects are responsible for DISPATCHING the appropriate log messages (based on the log messages’ severity) to the handler’s specified destination. 重點在 "如何傳送" log 到目的地，所以下面 Useful Handlers 所列的 handler 主要的差別在於 "輸出方式" 不同，例如 `StreamHandler`、`FileHandler`、`SocketHandler`、`SMTPHandler` ...
  - [Useful Handlers - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#useful-handlers) #ril
  - [Python Custom Logging Handler Example \- DZone Big Data](https://dzone.com/articles/python-custom-logging-handler-example) (2018-09-01) #ril

## Formatter ??

  - [Advanced Logging Tutorial - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#advanced-logging-tutorial)
      - Formatters specify the layout of log records in the final output. Log event information is passed between loggers, handlers, filters and formatters in a `LogRecord` instance. 搭配 Logging Flow 看來，formatting 是 handler flow 寫出 output 前的最後一個步驟，也就是將 `LogRecord` 轉成 handler destination 可以接受的型態，通常是 string。
      - The default format set by `basicConfig()` for messages is: `severity:logger name:message` 注意這是 `basicConfig()` 預設採用的 format string，不是 `logging.Formatter` 的預設值。
  - [cpython/\_\_init\_\_\.py at v3\.7\.1 · python/cpython](https://github.com/python/cpython/blob/v3.7.1/Lib/logging/__init__.py#L460) `BASIC_FORMAT = "%(levelname)s:%(name)s:%(message)s"`
  - [Formatters - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#formatters)
      - Formatter objects configure the final order, structure, and contents of the log message. 其中 order 指的是不同 `LogRecord` 欄位顯示的順序，例如 `%(asctime)s - %(levelname)s - %(message)s` 是先顯示時間、level 然後才是 message 本身。
      - Unlike the base `logging.Handler` class, application code may instantiate formatter classes, although you could likely subclass the formatter if your application needs special behavior. 不同於 `logging.Handler` 做為一個 base class，不能被 instantiate；若只是想調整 format string，直接用 `logging.Formatter` 即可。
      - The constructor takes three optional arguments – a message format string (`fmt`), a date format string (`datefmt`) and a style indicator (`style`) - `logging.Formatter.__init__(fmt=None, datefmt=None, style='%')` - If there is no message format string, the default is to use the RAW MESSAGE. If there is no date format string, the default date format is: `%Y-%m-%d %H:%M:%S` with the milliseconds tacked on at the end. 也就是 message format string 是 `%(message)s` (跟 `basicConfig()` 預設的 `%(levelname)s:%(name)s:%(message)s` 明顯不同)，而 date format string 則用來設定如何展開 message format string 裡的 `%(asctime)s`，但時區又是另一件事；只是為什麼 date format string 裡沒有 milliseconds，但固定會輸出在後面?? 例如 `2018-12-02 08:46:19,190` 結尾的 `,190`。
      - Formatters use a user-configurable function to convert the creation time (指 `LogRecord` 生成的時間) of a record to a tuple. By default, `time.localtime()` is used; to change this for a particular formatter instance, set the `converter` attribute of the instance to a function with the same signature as `time.localtime()` or `time.gmtime()`. 也就是預設採 local time，透過 `handler.formatter.converter = time.gmtime` 可以改成 UTC 時間。
      - The style is one of `%`, `{` or `$`. If one of these is not specified, then `%` will be used. If the style is `%`, the message format string uses `%(<dictionary key>)s` styled string substitution; the possible keys are documented in `LogRecord` attributes. If the style is `{`, the message format string is assumed to be compatible with `str.format()` (using keyword arguments), while if the style is `$` then the message format string should conform to what is expected by `string.Template.substitute()`. 雖然有這麼多選擇，但文件都還是只用 `%`；其他地方也出現 %-style、%-format(ting) 的說法。
  - [cpython/\_\_init\_\_\.py at v3\.7\.1 · python/cpython](https://github.com/python/cpython/blob/v3.7.1/Lib/logging/__init__.py#L641) 從 `logging.Handler` 原始碼 `_defaultFormatter = Formatter()` 看來，當 handler 在處理 log record 時若發現沒有 formatter，會拿 `logging.Formatter` 來將 `LogRecord` 轉成 string。
  - [Formatter Objects - logging — Logging facility for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/logging.html#formatter-objects) #ril
  - [Using particular formatting styles throughout your application - Logging Cookbook — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging-cookbook.html#using-particular-formatting-styles-throughout-your-application) ... completely orthogonal to how an individual logging message is constructed #ril

## Configuration ??

  - [Configuring Logging - Logging HOWTO — Python 3\.6\.5 documentation](https://docs.python.org/3.6/howto/logging.html#configuring-logging) #ril
  - [Configuring Logging - Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2.7/howto/logging.html#configuring-logging) #ril
  - [16\.7\. logging\.config — Logging configuration — Python 3\.6\.5 documentation](https://docs.python.org/3.6/library/logging.config.html) #ril

## logging.xxx() 與 logger.xxx()

  - `logging.xxx()` 寫在 root logger，也就是 message format string 裡的 `%(name)s` 永遠都是 `root`，看不出 message 是從哪個 module 來的。
  - 如果 application 不大的話 (例如簡單的 script)，用 `logging.xxx()` 倒是沒什麼問題，不過若是有一定規模的話，還是建議用 `logger.xxx()`。

參考資料：

  - Logging HOWTO — Python 2.7.14 documentation https://docs.python.org/2/howto/logging.html 前段都在講 `logging.xxx()`，從 Advanced Logging Tutorial 才開始提到 logger
  - Logging HOWTO — Python 2.7.14 documentation https://docs.python.org/2/howto/logging.html#logging-from-multiple-modules Logging from multiple modules 提到都用 `logging.xxx()` 的話，會不知道 message 從哪個 module 來，顯然這種用法不太推薦? Advanced Logging Tutorial 建議用 `logger = logging.getLogger(__name__)` 的方式建立 module-level logger，剛好對應 package/module hierarchy，"which just call the same-named method of the root logger" 說明了，`logging.xxx()` 只是轉呼叫 root logger。
  - 15.7. logging — Logging facility for Python — Python 2.7.14 documentation https://docs.python.org/2/library/logging.html#logging.info `logging.xxx()` 的說明都寫 Logs a message with level XXX on the root logger.

## Logger 間形成階層 (hierarchy) 有什麼影響?

  - 15.7. logging — Logging facility for Python — Python 2.7.14 documentation https://docs.python.org/2/library/logging.html#logging.Logger.propagate 預設 `propagate` 為 `True`，通常將 handler 加在 root logger 而已，剩下的交給 propagation，否則一個訊息會 log 多次。

## 如何達成 log file rotation?

  - Logging HOWTO — Python 2.7.14 documentation https://docs.python.org/2/howto/logging.html#useful-handlers 提到 `RotatingFileHandler` 支援 maximum log file sizes 及 log file rotation。

## 如何將錯誤的 log 送往 Slack?

  - Handler 出問題 (例如網路不通)，會影響到 application 正常的運作嗎? 或是網路速度不佳，會不會拖慢 application 的效能?
  - slacker-log-handler 1.6.1 : Python Package Index https://pypi.python.org/pypi/slacker-log-handler #ril

## 跟 warnings 有何不同?

  - 28.6. warnings — Warning control — Python 2.7.14 documentation https://docs.python.org/2/library/warnings.html #ril
  - Logging HOWTO — Python 2.7.14 documentation https://docs.python.org/2/howto/logging.html 提到都是 warning，但若是 client application 可以避開的 warning 用 `warnings.warn()`，若 client application 什麼也不能做則用 `logging.warn()`。

## 如何做 logging?

  - 習慣用 `_logger = logging.getLogger(__name__)`?

參考資料：

  - 15.7. logging — Logging facility for Python — Python 2.7.14rc1 documentation https://docs.python.org/2.7/library/logging.html #ril

## 如何取得 root logger?

  - 15.7. logging — Logging facility for Python — Python 2.7.14 documentation https://docs.python.org/2/library/logging.html#logging.getLogger 原來 `getLogger(name)` 中的 name 是 optional，沒有提供時就是傳回 root logger。

## 為什麼 `basicConfig()` 預設寫到 STDERR 而不是 STDOUT?

  - STDERR 除了 error message 外，也用於 diagnostics，預設寫往 STDERR 並沒有什麼不對；若要輸出到外部檔，可以用 `> log.txt 2>&1`。
  - 從另一個角度想，如果你寫的是 console 程式，透過 STDIN & STDOUT 來跟使用者互動，你大概不會想透過 `>` 把 output 導到另一個檔案時，debug message 也在裡頭。

參考資料：

  - [Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/logging.html#advanced-logging-tutorial) Advanced Logging Tutorial 提到 "if no destination is set; and if one is not set, they will set a destination of the console (sys.stderr) ..." 為什麼是 STDERR?
  - Standard streams - Wikipedia https://en.wikipedia.org/wiki/Standard_streams#Standard_error_.28stderr.29 Standard error (stderr) 提到 STDERR 用於 error message 或 diagnostics。

## 如何在 log message 揭露重要的數據?

由於 `logging` 仍採用 %-style string formatting，搭配 `%r` 就能輕易輸出不同型態的字面表示，不用擔心會看漏空白字元，例如：

```
>>> logging.warn('Create order; no = %r, items = %r.', 'RX0134', ['Keyboard', 'Mouse', 'Monitor'])
WARNING:root:Create order; no = 'RX0134', items = ['Keyboard', 'Mouse', 'Monitor'].
```

參考資料：

  - [Logging variable data - Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/logging.html#logging-variable-data) 採用 %-style of string formatting，
  - [5.6.2. String Formatting Operations - 5\. Built\-in Types — Python 2\.7\.14 documentation](https://docs.python.org/2.7/library/stdtypes.html#string-formatting-operations) 說明 string formatting/interpolation 的用法，其中 `%r` (由 `repr()` 取得) 不同於 `%s` (由 `str()` 取得)。
  - [repr(object) - 2\. Built\-in Functions — Python 2\.7\.14 documentation](https://docs.python.org/2.7/library/functions.html#func-repr) `repr(object)` 會回傳 printable representation of an object。

## 如何動態調整 logger 的 level?

參考資料：

  - [logging \- Dynamically changing log level in python without restarting the application \- Stack Overflow](https://stackoverflow.com/questions/19617355/dynamically-changing-log-level-in-python-without-restarting-the-application) Martijn Pieters: 呼叫 `logger.setLevel()` 即可，通常會針對 root (`getLogger()`)。

## Rotation ??

  - [`TimedRotatingFileHandler` - logging\.handlers — Logging handlers — Python 3\.7\.2 documentation](https://docs.python.org/3/library/logging.handlers.html#timedrotatingfilehandler) #ril
      - The `TimedRotatingFileHandler` class, located in the `logging.handlers` module, supports rotation of disk log files at certain timed INTERVALS.

        "at certain timed intervals" 會讓人誤以為 rollover 會定期發生? 但 logging 背後並沒有一個 daemon，所以 rollover 也要有 log output 觸發才行。也因此你不能預期 `when='D', interval=1` 就會每天產生一支檔案，而且不定會發生在半夜 12:00 (跟起始的 `atTime` 有關)。

      - `class logging.handlers.TimedRotatingFileHandler(filename, when='h', interval=1, backupCount=0, encoding=None, delay=False, utc=False, atTime=None)`

        Returns a new instance of the `TimedRotatingFileHandler` class. The specified file is opened and used as the STREAM for logging. On rotating it also sets the filename suffix. Rotating happens based on the PRODUCT of `when` and `interval`.

        The system will save old log files by appending extensions to the filename. The extensions are DATE-AND-TIME BASED, using the strftime format `%Y-%m-%d_%H-%M-%S` or a leading portion thereof, depending on the ROLLOVER INTERVAL. 若 interval 是天，顯示 hour、minute、second 就沒有必要??

        When computing the NEXT ROLLOVER TIME for the first time (when the handler is created), the LAST MODIFICATION TIME OF AN EXISTING LOG FILE, or else the current time, is used to compute when the next rotation will occur.

        注意一直都是 interval，即便是 `when='h', interval=1' 也並不代表 rollover 會發生在整點，因為一開始是以現有的 log file 或當下的時間起算；搭配 `atTime` 可以達成整點、半夜換檔的效果。

        If the `utc` argument is true, times in UTC will be used; otherwise local time is used.

      - If `backupCount` is nonzero (預設就是 `0`), at most `backupCount` files will be kept, and if more would be created WHEN ROLLOVER OCCURS, the oldest one is deleted. The deletion logic uses the `interval` to determine which files to delete, so changing the `interval` may leave old files lying around. 為什麼只看 `interval` 就知道要刪掉哪些檔案??

      - If `atTime` is not `None`, it must be a `datetime.time` instance which specifies the TIME OF DAY when rollover occurs, for the cases where rollover is set to happen “at midnight” or “on a particular weekday”. Note that in these cases, the `atTime` value is effectively used to compute the INITIAL ROLLOVER, and subsequent rollovers would be calculated via the normal interval calculation.

      - If `delay` is true, then file opening is deferred until the first call to `emit()`. 實務上的應用??

      - You can use the `when` to specify the TYPE OF `interval`. The list of possible values is below. Note that they are NOT case sensitive.

      - When using weekday-based rotation, specify ‘W0’ for Monday, ‘W1’ for Tuesday, and so on up to ‘W6’ for Sunday. In this case, the value passed for `interval` isn’t used.

## JSON Lines Output ??

  - [madzak/python\-json\-logger: Json Formatter for the standard python logger](https://github.com/madzak/python-json-logger) #ril
      - Sample JSON with a FULL FORMATTER (basically the log message from the unit test). Every log message will appear on 1 line like a typical logger. 實驗確會輸出 JSON lines，其中 full formatter 應該是把 `LogRecord` 的 attribute 都列出來，例如 `jsonlogger.JsonFormatter('(threadName) (name) (created) ...')`
      - 實驗發現，在 format string 裡不用列 `(exc_info)`，用 `logger.exception()` 就會產生帶有 `exc_info` 欄位的 JSON。
  - [Python logging into file as a dictionary or JSON \- Stack Overflow](https://stackoverflow.com/questions/50144628/) #ril
  - [JSON Formatted Logging « Python recipes « ActiveState Code](http://code.activestate.com/recipes/580667-json-formatted-logging/) #ril
  - [Python Logging Best Practices with Json Steroids \-](https://logmatic.io/blog/python-logging-with-json-steroids/) #ril
  - [marselester/json\-log\-formatter: Python JSON log formatter](https://github.com/marselester/json-log-formatter) #ril
  - [thangbn/json\-logging\-python: Python logging library to emit JSON log that can be easily indexed and searchable by logging infrastructure such as ELK \(Elasticsearch, Logstash, and Kibana\)](https://github.com/thangbn/json-logging-python) #ril

## 參考資料 {: #reference }

文件：

  - [logging — Logging facility for Python — Python 2 documentation](https://docs.python.org/2/library/logging.html)
  - [logging — Logging facility for Python — Python 3 documentation](https://docs.python.org/3/library/logging.html)

手冊：

  - [`LogRecord` Attributes](https://docs.python.org/3/library/logging.html#logrecord-attributes)
