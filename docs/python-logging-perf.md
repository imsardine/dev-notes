---
title: Python / Logging / Performance
---
# [Python / Logging](python-logging.md) / Performance

  - 從 [logging flow](https://docs.python.org/3.6/howto/logging.html#logging-flow) 看來，呼叫 logging method 當下，在經過 level、filter 的檢查之後，就會馬上交由 handlers 寫出，所以 handler 寫出的動作確實會影響程式的執行速度。

  - 雖然 logging method 內部一定會做 `isEnabledFor(level)` 的檢查，但若是準備傳入 logging method 的參數需要花點時間，建議自行先做過 `isEnabledFor(level)` 的檢查，才不會花時間準備了資料，但最後卻用不到。

        if logger.isEnabledFor(logging.DEBUG):
            logger.debug("Diagnostic data; %r", _prepare_data())

  - 在 logging method 呼叫的當下，就會花時間蒐集 logging 的位置、當下的 thread、process 等，這些資訊若最後沒有要輸出，把一些開關關掉，就不用花時間蒐集：

        logging._srcfile = None
        logging.logThreads = False
        logging.logProcesses = False

    實驗確認，把 `logging._srcfile` 設為 `None`，在發生錯誤時 `logger.exception()` 仍然可以回報出錯的位置，不用擔心。

  - Handler 寫出 log 時受限於 I/O 效能，解法是把 I/O 拉到背景做 -- 呼叫 logging method 當下先將 `LogRecord` 寫進 queue，另一邊再將 queue 裡面的 `LogRecord` 轉換成 log 寫出。

---

參考資料：

  - [Logging Flow - Logging HOWTO — Python 3\.6\.8 documentation](https://docs.python.org/3.6/howto/logging.html#logging-flow) 從 flowchart 先釐清幾件事：

      - 左側 logger flow 從 logging call in user code 開始，經過 level、filter 判斷，就會進入 pass to handlers of current logger，這中間並非是 async 的，所以 handler 寫出 log 的過程，可能會拖慢 user code 的執行。
      - 右側 handler flow 在經過 level、filter 的判斷，最後要寫出前才會做 formatting。

  - [multithreading \- python logging performance comparison and options \- Stack Overflow](https://stackoverflow.com/questions/35520160/) #ril

  - [Optimization - Logging HOWTO — Python 2\.7\.16 documentation](https://docs.python.org/2/howto/logging.html#optimization) #ril

      - Formatting of message arguments is DEFERRED UNTIL IT CANNOT BE AVOIDED. However, COMPUTING THE ARGUMENTS passed to the logging method can also be expensive, and you may want to avoid doing it if the logger will just throw away your event.

        To decide what to do, you can call the `isEnabledFor()` method which takes a level argument and returns true if the event would be created by the `Logger` for that level of call. You can write code like this:

            if logger.isEnabledFor(logging.DEBUG):
                logger.debug('Message with %s, %s', expensive_func1(),
                                                    expensive_func2())

        so that if the logger’s threshold is set above `DEBUG`, the calls to `expensive_func1()` and `expensive_func2()` are never made.

      - Note In some cases, `isEnabledFor()` can itself be more expensive than you’d like (e.g. for DEEPLY NESTED LOGGERS where an explicit level is only set high up in the logger hierarchy).

        In such cases (or if you want to avoid calling a method in TIGHT LOOPS), you can cache the result of a call to `isEnabledFor()` in a local or instance variable, and use that instead of calling the method each time.

        Such a cached value would only need to be recomputed when the LOGGING CONFIGURATION CHANGES DYNAMICALLY while the application is running (which is not all that common).

        不過從 [`logging.Logger` 的實作](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py#L1356)看來，內部總會呼叫 `if self.isEnabledFor(level):`，且會將結果快取 (依 hierarchy 推算 effective level 會花點時間)，所以 client code 先做過 `isEnabledFor()` 的檢查肯定能省下準備 arguemnt 的時間，但 `isEnabledFor()` 時間花下去是否值得就不用多想了。

      - There are other optimizations which can be made for specific applications which need more precise control over what logging information is COLLECTED. Here’s a list of things you can do to avoid processing during logging which you don’t need:

          - Information about where calls were made from.

            Set `logging._srcfile` to `None`. This avoids calling `sys._getframe()`, which may help to speed up your code in environments like PyPy (which can’t speed up code that uses `sys._getframe()`).

          - Threading information.

            Set `logging.logThreads` to `0`.

          - Process information.

            Set `logging.logProcesses` to `0`.

        從 [`LoggerRecord` 的 constructor](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py#L282) 看來，`LogRecord.thread`、`LogRecord.threadName`、`LogRecord.process` 都是根據 `logging.logThreads`、`logging.logProcesses` 決定要不要 "即時" 取得這些資訊，跟 format string 是否有引用到 thread/process 相關的 attribute 無關，所以如果最後的輸出用不到，一開始就把它關了。

        至於 `logging._srcfile` 這個開關則是用在 [`Logger._log()`](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py#L1497) 裡，這也是很花時間的。實驗確認，把 `logging._srcfile` 設為 `None`，在發生錯誤時 `logger.exception()` 仍然可以回報出錯的位置，這樣就很夠了。

        Also note that the core logging module only includes the basic handlers. If you don’t import `logging.handlers` and `logging.config`, they won’t take up any memory.

  - [Adventures in Python Logging – Part 1 Avoiding expensive logging call parameters – Bespoke Bytes](https://bespokebytes.com/adventures-in-python-logging-part-1-avoiding-expensive-logging-call-parameters/) (2017-11-19) #ril

## Queue Solution {: #queue }

  - [Dealing with handlers that block - Logging Cookbook — Python 3\.7\.3 documentation](https://docs.python.org/3/howto/logging-cookbook.html#dealing-with-handlers-that-block)

      - Sometimes you have to get your logging handlers to do their work WITHOUT BLOCKING THE THREAD YOU’RE LOGGING FROM. This is common in Web applications, though of course it also occurs in other scenarios.

        A common culprit which demonstrates sluggish behaviour is the `SMTPHandler`: sending emails can take a long time, for a number of reasons outside the developer’s control (for example, a poorly performing mail or network infrastructure). But almost ANY NETWORK-BASED HANDLER CAN BLOCK: Even a `SocketHandler` operation may do a DNS query under the hood which is too slow (and this query can be DEEP in the socket library code, below the Python layer, and outside your control).

        Queue 不僅可以避開單一個 handler 寫出資料時可能遇到 blocking 的問題，也可以解多個 process 寫入一個檔案的問題。

      - One solution is to use a TWO-PART APPROACH. For the first part, attach only a `QueueHandler` to those loggers which are accessed from PERFORMANCE-CRITICAL THREADS. They simply write to their queue, which can be sized to a large enough capacity or initialized with no upper bound to their size.

        The write to the queue will typically be accepted quickly, though you will probably need to catch the `queue.Full` exception as a precaution in your code. If you are a LIBRARY DEVELOPER who has performance-critical threads in their code, be sure to document this (together with a suggestion to ATTACH ONLY `QueueHandler`S TO YOUR LOGGERS) for the benefit of other developers who will use your code.

        感覺整合 3rd-party library 時，可以將幾個比較大的 package 跟 application 的 log 拆開，例如：

            root = logging.getLogger()
            root.addHandler(logging.handlers.RotatingFileHandler('app.log'))

            twisted = logging.getLogger('twisted')
            twisted.setLevel(logging.ERROR)
            twisted.addHandler(logging.handlers.RotatingFileHandler('twisted.log'))
            twisted.propagate = False

      - The second part of the solution is `QueueListener`, which has been designed as the counterpart to `QueueHandler`. A `QueueListener` is very simple: it’s passed a queue and some handlers, and it fires up an INTERNAL THREAD which listens to its queue for `LogRecord`s sent from `QueueHandler`s (or any other source of `LogRecord`s, for that matter). The `LogRecord`s are removed from the queue and passed to the handlers for processing.

        The advantage of having a separate `QueueListener` class is that you can use the same instance to service multiple `QueueHandler`s. This is more resource-friendly than, say, having threaded versions of the existing handler classes, which would eat up one thread per handler for no particular benefit.

      - An example of using these two classes follows (imports omitted):

            que = queue.Queue(-1)  # no limit on size
            queue_handler = QueueHandler(que)
            handler = logging.StreamHandler()
            listener = QueueListener(que, handler)
            root = logging.getLogger()
            root.addHandler(queue_handler)
            formatter = logging.Formatter('%(threadName)s: %(message)s')
            handler.setFormatter(formatter)
            listener.start()
            # The log output will display the thread which generated
            # the event (the main thread) rather than the internal
            # thread which monitors the internal queue. This is what
            # you want to happen.
            root.warning('Look out!')
            listener.stop()

        which, when run, will produce:

            MainThread: Look out!

      - Changed in version 3.5: Prior to Python 3.5, the `QueueListener` always passed every message received from the queue to every handler it was initialized with. (This was because it was assumed that LEVEL FILTERING WAS ALL DONE ON THE OTHER SIDE, where the queue is filled.)

        From 3.5 onwards, this behaviour can be changed by passing a keyword argument `respect_handler_level=True` to the listener’s constructor. When this is done, the listener compares the level of each message with the handler’s level, and only passes a message to a handler if it’s appropriate to do so.

    Use of alternative formatting styles

      - One thing to note is that you pay no significant performance penalty with this approach: the actual formatting happens not when you make the logging call, but when (and if) the logged message is actually ABOUT TO BE OUTPUT TO A LOG by a handler.

        不過從上面 "without blocking the thread you’re logging from" 的說法來看，log 當下就會往 handler 寫，所以才要先寫進 queue 做為緩衝 ??

  - [logging\.handlers — Logging handlers — Python 3\.7\.3 documentation](https://docs.python.org/3/library/logging.handlers.html#queuehandler) #ril
