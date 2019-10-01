---
title: Python / Logging
---
# [Python](python.md) / [Logging](logging.md)

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

## `logging.NOTSET` {: #notset }

  - [logging — Logging facility for Python — Python 3\.7\.3 documentation](https://docs.python.org/3/library/logging.html)

    `Logger.setLevel(level)`

      - When a logger is created, the level is set to `NOTSET` (which causes ALL messages to be processed when the logger is the ROOT LOGGER, or DELEGATION TO THE PARENT when the logger is a NON-ROOT LOGGER). Note that the root logger is created with level `WARNING`.

        Level 在 logger 裡的定位 "不完全是" threshold (也難怪在這裡完全沒提到 "threshold")，更重要的是推導該 logger 的 effective level，所以 `NOTSET` 對 non-root logger 在這裡可以解釋成 "不知道，去問上層吧"，對 root logger 則可以解釋成 "別管 level 了"。

      - The term ‘delegation to the parent’ means that if a logger has a level of `NOTSET`, its chain of ancestor loggers is traversed until either an ancestor with a level other than `NOTSET` is found, or the root is reached.

        If an ancestor is found with a level other than `NOTSET`, then that ancestor’s level is treated as the EFFECTIVE LEVEL of the logger WHERE THE ANCESTOR SEARCH BEGAN, and is used to determine how a logging event is handled.

        If the root is reached, and it has a level of `NOTSET`, then all messages will be processed. Otherwise, the root’s level will be used as the effective level.

    `Logger.isEnabledFor(lvl)`

      - Indicates if a message of severity `lvl` would be processed by this logger. This method checks first the module-level level set by logging.disable(lvl) and then the logger’s effective level as determined by getEffectiveLevel().

    `Logger.getEffectiveLevel()`

      - Indicates the effective level for this logger. If a value other than `NOTSET` has been set using `setLevel()`, it is returned. Otherwise, the hierarchy is traversed towards the root until a value other than `NOTSET` is found, and that value is returned.

        The value returned is an integer, typically one of `logging.DEBUG`, `logging.INFO` etc.

    `Handler.setLevel(level)`

      - Sets the THRESHOLD for this handler to `level`. Logging messages which are less severe than level will be ignored. When a handler is created, the level is set to `NOTSET` (which causes ALL MESSAGES TO BE PROCESSED).

        Level 在 handler 裡的定位才是 threshold，而 `NOTSET` 在這裡可以解釋成 "不管 level，都交給我處理吧"。

      - Changed in version 3.2: The `level` parameter now accepts a string representation of the level such as `'INFO'` as an alternative to the integer constants such as `INFO`.

    `logging.disable(lvl=CRITICAL)`

      - Provides an OVERRIDING LEVEL `lvl` for all loggers which takes precedence over the logger’s own level. When the need arises to TEMPORARILY THROTTLE logging output down across the whole application, this function can be useful.

      - If `logging.disable(logging.NOTSET)` is called, it effectively removes this overriding level, so that logging output again depends on the effective levels of individual loggers.

        這時候 `NOTSET` 又有不同的意義了 -- 不 override，參考各 logger 的 effective level。

## Configuration ??

  - STDERR 除了 error message 外，也用於 diagnostics，預設寫往 STDERR 並沒有什麼不對；若要輸出到外部檔，可以用 `> log.txt 2>&1`。
  - 從另一個角度想，如果你寫的是 console 程式，透過 STDIN & STDOUT 來跟使用者互動，你大概不會想透過 `>` 把 output 導到另一個檔案時，debug message 也在裡頭。

參考資料：

  - [`logging.basicConfig(**kwargs)` - logging — Logging facility for Python — Python 3\.7\.3 documentation](https://docs.python.org/3/library/logging.html#logging.basicConfig)
      - Does basic configuration for the logging system by creating a `StreamHandler` with a default `Formatter` and adding it to the ROOT LOGGER.
      - The functions `debug()`, `info()`, `warning()`, `error()` and `critical()` will call `basicConfig()` automatically if no handlers are defined for the root logger. This function DOES NOTHING if the root logger already has handlers configured for it.

        也因此，`logging.basicConfig()` 要在程式 entry point 的很早期被呼叫，而且單元測試時不會被調用。

      - Note This function should be called from the MAIN THREAD before other threads are started. In versions of Python prior to 2.7.1 and 3.2, if this function is called from multiple threads, it is possible (in rare circumstances) that a handler will be added to the root logger more than once, leading to unexpected results such as messages being duplicated in the log.
      - The following keyword arguments are supported.
          - `filename` - Specifies that a `FileHandler` be created, using the specified filename, rather than a `StreamHandler`.
          - `filemode` - If filename is specified, open the file in this mode. Defaults to `'a'`.
          - `format` - Use the specified format string for the handler.
          - `datefmt` - Use the specified date/time format, as accepted by `time.strftime()`.
          - `style` - If format is specified, use this style for the format string. One of `'%'`, `'{'` or `'$'` for printf-style, `str.format()` or `string.Template` respectively. Defaults to `'%'`.

            Changed in version 3.2: The `style` argument was added.

          - `level` - Set the root logger level to the specified level.
          - `stream` - Use the specified stream to initialize the `StreamHandler`. Note that this argument is incompatible with `filename` - if both are present, a `ValueError` is raised.
          - `handlers` - If specified, this should be an iterable of already created handlers to add to the root logger. Any handlers which don’t already have a formatter set will be assigned the DEFAULT FORMATTER created in this function. Note that this argument is incompatible with `filename` or `stream` - if both are present, a `ValueError` is raised.

            Changed in version 3.3: The `handlers` argument was added. Additional checks were added to catch situations where incompatible arguments are specified (e.g. `handlers` together with `stream` or `filename`, or `stream` together with `filename`).

        總地來看，handler(s) 可能因 `filename`、`stream` 自動建立 `FileHandler` 或 `StreamHandler`，或是由 `handlers` 直接提供；如果都沒給的話，則會採用 `StreamHandler`。

  - [Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2/howto/logging.html#advanced-logging-tutorial) Advanced Logging Tutorial 提到 "if no destination is set; and if one is not set, they will set a destination of the console (sys.stderr) ..." 為什麼是 STDERR?
  - Standard streams - Wikipedia https://en.wikipedia.org/wiki/Standard_streams#Standard_error_.28stderr.29 Standard error (stderr) 提到 STDERR 用於 error message 或 diagnostics。

  - [Configuring Logging - Logging HOWTO — Python 3\.6\.5 documentation](https://docs.python.org/3.6/howto/logging.html#configuring-logging) #ril
  - [Configuring Logging - Logging HOWTO — Python 2\.7\.14 documentation](https://docs.python.org/2.7/howto/logging.html#configuring-logging) #ril
  - [16\.7\. logging\.config — Logging configuration — Python 3\.6\.5 documentation](https://docs.python.org/3.6/library/logging.config.html) #ril

## `LogRecord` ??

  - [LogRecord Objects - logging — Logging facility for Python — Python 3\.7\.0 documentation](https://docs.python.org/3/library/logging.html#logrecord-objects)
      - `LogRecord` instances are created automatically by the `Logger` every time something is logged, and can be created manually via `makeLogRecord()` (for example, from a pickled event received over the wire). 指對 attribute dictionary 做 pickling，再透過 `makeLogRecord()` 重建。

    `class logging.LogRecord(name, level, pathname, lineno, msg, args, exc_info, func=None, sinfo=None)`

      - Contains all the information pertinent to the event being logged.
      - The PRIMARY INFORMATION is passed in `msg` and `args`, which are combined using `msg % args` to create the `message` field of the record. 合併成 `message` 的動作發生在 formatter 裡。
      - Parameters:
          - `name` – The name of the logger used to log the event represented by this `LogRecord`. Note that this name will always have this value, even though it may be emitted by a handler attached to a different (ancestor) logger.
          - `level` – The NUMERIC level of the logging event (one of `DEBUG`, `INFO` etc.) Note that this is CONVERTED to two attributes of the `LogRecord`: `levelno` for the numeric value and `levelname` for the corresponding level name.
          - `pathname` – The full pathname of the source file where the logging call was made.
          - `lineno` – The line number in the source file where the logging call was made.
          - `msg` – The event description message, possibly a format string with placeholders for variable data.
          - `args` – Variable data to merge into the `msg` argument to obtain the event description.
          - `exc_info` – An exception tuple with the current exception information, or `None` if no exception information is available.
          - `func` – The name of the function or method from which the logging call was invoked.
          - `sinfo` – A text string representing stack information from the base of the stack in the current thread, up to the logging call.

      - 主要的資訊是 `msg` 與 `args`，合併這兩者 (`str(msg) % args`) 就可以得到 `message` (注意 `msg` 與 `message` 的差別)；透過 `LogRecord` constructor 傳入的資訊，還可以推算出 `LogRecord` 許多不同的 attributes，而這些 attributes 正是 formatting string 裡 `%(xxx)s` 引用的來源，但 constructor parameters 跟 attributes 並非 1:1 的關係，例如 `level` (numeric) 會轉換成 `levelno` (numeric) 與 `levelname` 兩個 attribute。

    `getMessage()`

      - Returns the message for this `LogRecord` instance after MERGING any user-supplied arguments with the message. If the user-supplied message argument to the logging call is not a string, `str()` is called on it to convert it to a string. This allows use of USER-DEFINED CLASSES AS MESSAGES, whose `__str__` method can return the ACTUAL FORMAT STRING to be used.

        原來像 [python-json-logger](python-json-logger.md) 可以接受 `dict` 做為 `msg` 的做法，是有根據的! 不過轉成 string 再做 formatting 意義不大；有 [Using arbitrary objects as messages](https://docs.python.org/3/howto/logging.html#arbitrary-object-messages) 專門的章節在講這個 #ril

    `LogRecord` Factory

      - Changed in version 3.2: The creation of a `LogRecord` has been made more configurable by providing a factory which is used to create the record. The factory can be set using `getLogRecordFactory()` and `setLogRecordFactory()` (see this for the factory’s signature).
      - This functionality can be used to INJECT YOUR OWN VALUES INTO A `LogRecord` AT CREATION TIME. You can use the following pattern:

            old_factory = logging.getLogRecordFactory()

            def record_factory(*args, **kwargs):
                record = old_factory(*args, **kwargs)
                record.custom_attribute = 0xdecafbad
                return record

            logging.setLogRecordFactory(record_factory)

      - With this pattern, MULTIPLE FACTORIES COULD BE CHAINED, and as long as they don’t overwrite each other’s attributes or unintentionally overwrite the standard attributes listed above, there should be no surprises.

  - [LogRecord attributes - logging — Logging facility for Python — Python 3\.7\.3 documentation](https://docs.python.org/3/library/logging.html#logrecord-attributes)
      - The `LogRecord` has a number of attributes, most of which are DERIVED from the parameters to the constructor. (Note that the names do not always correspond exactly between the `LogRecord` constructor parameters and the `LogRecord` attributes.) These attributes can be used to MERGE DATA FROM THE RECORD INTO THE FORMAT STRING. The following table lists (in alphabetical order) the attribute names, their meanings and the corresponding placeholder in a %-style format string.
      - If you are using {}-formatting (`str.format()`), you can use `{attrname}` as the placeholder in the format string. If you are using $-formatting (`string.Template`), use the form `${attrname}`. In both cases, of course, replace `attrname` with the actual attribute name you want to use.
      - In the case of {}-formatting, you can specify formatting flags by placing them after the attribute name, separated from it with a colon. For example: a placeholder of `{msecs:03d}` would format a millisecond value of 4 as 004. Refer to the `str.format()` documentation for full details on the options available to you.

    Attributes:

      - `args` - You shouldn’t need to format this yourself.

        The tuple of arguments merged into `msg` to produce `message`, or a dict whose values are used for the merge (when there is only one argument, and it is a dictionary). 後者 dict 的用法是怎麼回事??

      - `asctime` - `%(asctime)s`

        Human-readable time when the `LogRecord` was created. By default this is of the form ‘2003-07-08 16:49:45,896’ (the numbers after the comma are millisecond portion of the time).

      - `created` - `%(created)f`

        Time when the `LogRecord` was created (as returned by `time.time()`). 也就是 Unix timestamp，可以用 `time.gmtime()` 轉成易懂的單位，例如：

            >>> t = time.time()
            >>> time.gmtime(t)     # UTC 時間
            time.struct_time(tm_year=2019, tm_mon=3, tm_mday=27, tm_hour=2, tm_min=18, tm_sec=1, tm_wday=2, tm_yday=86, tm_isdst=0)
            >>> time.localtime(t)  # 本地時間
            time.struct_time(tm_year=2019, tm_mon=3, tm_mday=27, tm_hour=10, tm_min=18, tm_sec=1, tm_wday=2, tm_yday=86, tm_isdst=0)

      - `exc_info` - You shouldn’t need to format this yourself.

        Exception tuple (à la `sys.exc_info`) or, if no exception has occurred, `None`.

      - `filename` - `%(filename)s`

        Filename portion of pathname.

      - `funcName` - `%(funcName)s`

        Name of function containing the logging call.

      - `levelname` - `%(levelname)s`

        Text logging level for the message (`'DEBUG'`, `'INFO'`, `'WARNING'`, `'ERROR'`, `'CRITICAL'`).

      - `levelno` - `%(levelno)s`

        Numeric logging level for the message (`DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`).

      - `lineno` - `%(lineno)d`

        Source line number where the logging call was issued (if available).

      - `message` - `%(message)s`

        The logged message, computed as `msg % args`. This is set when `Formatter.format()` is invoked. 跟其他的 attribute 不同，大部份都在 `LogRecord` 建立時就有了。

      - `module` - `%(module)s`

        Module (name portion of filename).

      - `msecs` - `%(msecs)d`

        Millisecond portion of the time when the `LogRecord` was created.

      - `msg` - You shouldn’t need to format this yourself.

        The format string passed in the original logging call. Merged with `args` to produce `message`, or an ARBITRARY OBJECT (see Using arbitrary objects as messages).

      - `name` - `%(name)s`

        Name of the logger used to log the call.

      - `pathname` - `%(pathname)s`

        Full pathname of the source file where the logging call was issued (if available).

      - `process` - `%(process)d`

        Process ID (if available).

      - `processName` - `%(processName)s`

        Process name (if available).

      - `relativeCreated` - `%(relativeCreated)d`

        Time IN MILLISECONDS when the `LogRecord` was created, relative to the time the logging module was loaded.

      - `stack_info` - You shouldn’t need to format this yourself.

        Stack frame information (where available) from the bottom of the stack in the current thread, up to and including the stack frame of the logging call which resulted in the creation of this record.

      - `thread` - `%(thread)d`

        Thread ID (if available).

      - `threadName` - `%(threadName)s`

        Thread name (if available).

  - [Formatter Objects - logging — Logging facility for Python — Python 3\.7\.0 documentation](https://docs.python.org/3/library/logging.html#formatter-objects) Responsible for converting a `LogRecord` to (usually) a string which can be interpreted by either a human or an external system. 透過 formatting string (預設是 `%(message)`) 將 `LogRecord` 轉成文字。
  - [Using arbitrary objects as messages - Logging HOWTO — Python 3\.7\.0 documentation](https://docs.python.org/3/howto/logging.html#using-arbitrary-objects-as-messages) 在這之前都假設 message 是個 string，但 message 其實可以是任何 object，當內部需要 string representation 時，就會呼叫它的 `__str__()`。事實上內部也不一定會將它轉成 string，像是 `SocketHandler` 將 message 直接 pickle 就往外送了。

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

## 如何做 logging?

  - 習慣用 `_logger = logging.getLogger(__name__)`?

參考資料：

  - 15.7. logging — Logging facility for Python — Python 2.7.14rc1 documentation https://docs.python.org/2.7/library/logging.html #ril

## 如何取得 root logger?

  - 15.7. logging — Logging facility for Python — Python 2.7.14 documentation https://docs.python.org/2/library/logging.html#logging.getLogger 原來 `getLogger(name)` 中的 name 是 optional，沒有提供時就是傳回 root logger。

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

## Extra

  - [`logging.debug()` - logging — Logging facility for Python — Python 3\.7\.3 documentation](https://docs.python.org/3/library/logging.html#logging.debug)

      - The third optional keyword argument is `extra` which can be used to pass a dictionary which is used to populate the `__dict__` of the `LogRecord` created for the logging event with USER-DEFINED ATTRIBUTES.

      - These custom attributes can then be used as you like. For example, they could be incorporated into logged messages. For example:

            FORMAT = '%(asctime)-15s %(clientip)s %(user)-8s %(message)s' # 直接在 format string 裡引用
            logging.basicConfig(format=FORMAT)
            d = {'clientip': '192.168.0.1', 'user': 'fbloggs'}
            logging.warning('Protocol problem: %s', 'connection reset', extra=d)

        would print something like:

            2006-02-08 22:20:02,165 192.168.0.1 fbloggs  Protocol problem: connection reset

        可想而知，`LogRecord` 不會有一個 attribute 叫 `extra`，而是將 `extra` dictionary 的 keys 抄到 `LogRecord` 上，所以下面才會有 "should not clash" 的說法。[`Logger.makeRecord()` 的實作](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py#L1474)也確實是這樣：

            def makeRecord(self, name, level, fn, lno, msg, args, exc_info,
                           func=None, extra=None, sinfo=None):
                """
                A factory method which can be overridden in subclasses to create
                specialized LogRecords.
                """
                rv = _logRecordFactory(name, level, fn, lno, msg, args, exc_info, func,
                                     sinfo)
                if extra is not None:
                    for key in extra:
                        if (key in ["message", "asctime"]) or (key in rv.__dict__):
                            raise KeyError("Attempt to overwrite %r in LogRecord" % key)
                        rv.__dict__[key] = extra[key]
                return rv

        所幸 `if (key in ["message", "asctime"]) or (key in rv.__dict__)` 做了一些防範。

      - The keys in the dictionary passed in `extra` SHOULD NOT CLASH with the keys used by the logging system. (See the Formatter documentation for more information on which keys are used by the logging system.)

        避免命名衝突，從 [`LogRecord`](https://docs.python.org/3/library/logging.html#logrecord-attributes) 揭露的 attributes 看來，自訂 attribute 以底線開頭倒是滿安全的。

        另一種可能的方式是再包一層 dictionary，例如：

            >>> import logging
            >>> logging.basicConfig(level=logging.DEBUG, format="%(message)s; data: %(data)s")
            >>> logging.debug('Create a document', extra={'data': {'user': 'jermey', 'doc': 'README.md'}})
            Create a document; data: {'doc': 'README.md', 'user': 'jermey'}
            >>>

        搭配 JSONL 的輸出效果會更好；不過在 format string 就無法用 `%(...)s` 引用個別的欄位，例如 `%(user)s` 或 `%(data.user)s`。

      - If you choose to use these attributes in logged messages, you need to exercise some care. In the above example, for instance, the `Formatter` has been set up with a format string which expects `clientip` and `user` in the ATTRIBUTE DICTIONARY of the `LogRecord`.

        If these are MISSING, the message will not be logged because a string formatting exception will occur. So in this case, you ALWAYS need to pass the `extra` dictionary with these keys.

        While this might be annoying, this feature is intended for use in specialized circumstances, such as MULTI-THREADED SERVERS where the same code executes in many contexts, and interesting conditions which arise are dependent on this context (such as remote client IP address and authenticated user name, in the above example). In such circumstances, it is likely that SPECIALIZED `Formatter`s would be used with particular `Handler`s.

        也就是內建的 formatter (`logging.Formatter`) 不會自動判斷某個 user-defined attribute 是否存在，解法之一就是改用自訂的 formatter。

        記錄到個別使用者，logging level 通常都是 DEBUG 了。

## 取得所有的 logger ?? {: #all-loggers }

  - [Run Scrapy from a script - Common Practices — Scrapy 1\.6\.0 documentation](https://docs.scrapy.org/en/latest/topics/practices.html#run-scrapy-from-a-script)

      - The first utility you can use to run your spiders is `scrapy.crawler.CrawlerProcess`. This class will start a Twisted reactor for you, CONFIGURING THE LOGGING and setting shutdown handlers.

        有些第三方套件會介入設定 logger，但這可能不是你要的。從 [source code](https://github.com/scrapy/scrapy/blob/1.6.0/scrapy/crawler.py#L253) 看來會轉呼叫 `scrapy.utils.log.configure_logging()`:

            configure_logging(self.settings, install_root_handler)

        而 [`configure_logging()` 的文件](https://docs.scrapy.org/en/latest/topics/logging.html#scrapy.utils.log.configure_logging)這麼寫著：

          - Route warnings and twisted logging through Python standard logging
          - Assign `DEBUG` and `ERROR` level to Scrapy and Twisted loggers respectively
          - Route stdout to log if `LOG_STDOUT` setting is True

        實驗下來，發現 Scrapy 在 import time 就會對設定一些 logger，甚至還安排了 handler：

            >>> import logging
            >>> def all_loggers():
            ...     loggers = []
            ...     for name, logger in logging.root.manager.loggerDict.items():
            ...         if not isinstance(logger, logging.Logger):
            ...             continue
            ...         loggers.append((name, logging.getLevelName(logger.level), logger.handlers))
            ...     return loggers
            ...
            >>> all_loggers()
            []
            >>> import scrapy
            >>> all_loggers()
            [('scrapy.spiders.sitemap', 'NOTSET', []), ('scrapy.utils.iterators', 'NOTSET', []), ('scrapy.utils.spider', 'NOTSET', [])]
            >>> from scrapy.crawler import CrawlerProcess
            >>> all_loggers()
            [('scrapy.core.engine', 'NOTSET', []), ('scrapy.utils.log', 'NOTSET', []), ('scrapy.crawler', 'NOTSET', []), ('scrapy.core.scraper', 'NOTSET', []), ('scrapy.spiders.sitemap', 'NOTSET', []), ('scrapy.utils.signal', 'NOTSET', []), ('scrapy.utils.iterators', 'NOTSET', []), ('scrapy.middleware', 'NOTSET', []), ('pyasn1', 'DEBUG', [<logging.StreamHandler object at 0x1021aad50>]), ('scrapy.utils.spider', 'NOTSET', [])]
            >>> CrawlerProcess(install_root_handler=False)
            No handlers could be found for logger "scrapy.utils.log"
            <scrapy.crawler.CrawlerProcess object at 0x1019aa3d0>
            >>> all_loggers()
            [('scrapy.core.engine', 'NOTSET', []), ('scrapy.utils.log', 'NOTSET', []), ('twisted', 'ERROR', []), ('scrapy.crawler', 'NOTSET', []), ('scrapy', 'DEBUG', []), ('scrapy.core.scraper', 'NOTSET', []), ('scrapy.spiders.sitemap', 'NOTSET', []), ('scrapy.utils.signal', 'NOTSET', []), ('scrapy.utils.iterators', 'NOTSET', []), ('scrapy.middleware', 'NOTSET', []), ('pyasn1', 'DEBUG', [<logging.StreamHandler object at 0x1021aad50>]), ('scrapy.utils.spider', 'NOTSET', [])]

  - [Finding all loggers?](https://mail.python.org/pipermail/python-list/2012-June/625343.html)

        >>> import logging
        >>> logging.Logger.manager.loggerDict
        {}
        >>> logging.getLogger('foo')
        <logging.Logger object at 0x7f11d4d104d0>
        >>> logging.getLogger('bar')
        <logging.Logger object at 0x7f11d4cb7ad0>
        >>> logging.Logger.manager.loggerDict
        {'foo': <logging.Logger object at 0x7f11d4d104d0>, 'bar':
        <logging.Logger object at 0x7f11d4cb7ad0>}

  - [How to get the list all existing loggers using python\.logging module \- Stack Overflow](https://stackoverflow.com/questions/53249304/)

      - Will Keeling: Loggers are held in a hierarchy by a `logging.Manager` instance. You could interrogate the `Manager` on the ROOT LOGGER for the loggers it knows about.

            import logging

            loggers = [logging.getLogger(name) for name in logging.root.manager.loggerDict]

        為什麼不直接拿 `loggerDict.values()` 做為 logger 呢? 原來可能會遇到 `PlaceHolder`，例如：

            >>> import logging
            >>> logging.root.manager.loggerDict
            {}
            >>> logging.getLogger('x.y.z')
            <logging.Logger object at 0x10fcb9cd0>
            >>> logging.root.manager.loggerDict
            {'x.y': <logging.PlaceHolder object at 0x10fdb1090>, 'x': <logging.PlaceHolder object at 0x10fdb1110>, 'x.y.z': <logging.Logger object at 0x10fcb9cd0>}
            >>>

        只有 `x.y.z` 是 `logging.Logger`，中間的階層 (`x` 跟 `x.y`) 都是 `logging.PlaceHolder`。

## Change Configuration at Runtime ??

  - [Optimization - Logging HOWTO — Python 2\.7\.16 documentation](https://docs.python.org/2/howto/logging.html#optimization)

      - Such a cached value would only need to be recomputed when the LOGGING CONFIGURATION CHANGES DYNAMICALLY while the application is running (which is not all that common).

## 參考資料 {: #reference }

文件：

  - [logging — Logging facility for Python — Python 2 documentation](https://docs.python.org/2/library/logging.html)
  - [logging — Logging facility for Python — Python 3 documentation](https://docs.python.org/3/library/logging.html)

更多：

  - [Handler](python-logging-handler.md)
  - [Performance](python-logging-perf.md)
  - [python-json-logger](python-json-logger.md)

相關：

  - [JSON Lines](jsonlines.md)

手冊：

  - [`cpython/__init__.py` at 3.7 - python/cpython](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py)
  - [`LogRecord` Attributes](https://docs.python.org/3/library/logging.html#logrecord-attributes)
