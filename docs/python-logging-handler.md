---
title: Python / Logging / Handler
---
# [Python / Logging](python-logging.md) / Handler

  - Handler 決定了 destination，若只是想要改變輸出的內容，應該要從 formatter 下手，搭配現有的 handler。

參考資料：

  - [Handlers - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#handlers) #ril
      - `Handler` objects are responsible for DISPATCHING the appropriate log messages (based on the log messages’ severity) to the handler’s specified destination. 重點在 "如何傳送" log 到目的地，所以下面 Useful Handlers 所列的 handler 主要的差別在於 "輸出方式" 不同，例如 `StreamHandler`、`FileHandler`、`SocketHandler`、`SMTPHandler` ...
  - [Useful Handlers - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#useful-handlers) #ril
  - [Python Custom Logging Handler Example \- DZone Big Data](https://dzone.com/articles/python-custom-logging-handler-example) (2018-09-01) #ril

## Formatter ??

  - [Advanced Logging Tutorial - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#advanced-logging-tutorial)

      - Formatters specify the LAYOUT of log records in the final output. Log event information is passed between loggers, handlers, filters and formatters in a `LogRecord` instance.

        搭配 Logging Flow 看來，formatting 是 handler flow 寫出 output 前的最後一個步驟，也就是將 `LogRecord` 轉成 handler destination 可以接受的型態，通常是 string。

      - The default format set by `basicConfig()` for messages is: `severity:logger name:message`

        注意這是 `basicConfig()` 預設採用的 format string，不是 `logging.Formatter` 的預設值。

  - [cpython/\_\_init\_\_\.py at v3\.7\.1 · python/cpython](https://github.com/python/cpython/blob/v3.7.1/Lib/logging/__init__.py#L460)

        BASIC_FORMAT = "%(levelname)s:%(name)s:%(message)s"

  - [Formatters - Logging HOWTO — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging.html#formatters)

      - Formatter objects configure the final order, structure, and contents of the log message.

        其中 order 指的是不同 `LogRecord` 欄位顯示的順序，例如 `%(asctime)s - %(levelname)s - %(message)s` 是先顯示時間、level 然後才是 message 本身。

      - Unlike the base `logging.Handler` class, application code may instantiate formatter classes, although you could likely subclass the formatter if your application needs special behavior.

        不同於 `logging.Handler` 做為一個 base class，不能被 instantiate；若只是想調整 format string，直接用 `logging.Formatter` 即可。

      - The constructor takes three optional arguments – a message format string (`fmt`), a date format string (`datefmt`) and a style INDICATOR (`style`) - `logging.Formatter.__init__(fmt=None, datefmt=None, style='%')` - If there is no message format string, the default is to use the RAW MESSAGE. If there is no date format string, the default date format is: `%Y-%m-%d %H:%M:%S` with the milliseconds tacked on at the end.

        也就是 message format string 是 `%(message)s` (跟 `basicConfig()` 預設的 `%(levelname)s:%(name)s:%(message)s` 明顯不同)，而 date format string 則用來設定如何展開 message format string 裡的 `%(asctime)s`，但時區又是另一件事；只是為什麼 date format string 裡沒有 milliseconds，但固定會輸出在後面?? 例如 `2018-12-02 08:46:19,190` 結尾的 `,190`。

      - Formatters use a user-configurable function to convert the creation time (指 `LogRecord` 生成的時間) of a record to a tuple. By default, `time.localtime()` is used; to change this for a particular formatter instance, set the `converter` attribute of the instance to a function with the same signature as `time.localtime()` or `time.gmtime()`.

        也就是預設採 local time，透過 `handler.formatter.converter = time.gmtime` 可以改成 UTC 時間。

      - The style is one of `%`, `{` or `$`. If one of these is not specified, then `%` will be used. If the style is `%`, the message format string uses `%(<dictionary key>)s` styled string substitution; the possible keys are documented in `LogRecord` attributes. If the style is `{`, the message format string is assumed to be compatible with `str.format()` (using keyword arguments), while if the style is `$` then the message format string should conform to what is expected by `string.Template.substitute()`.

        雖然有這麼多選擇，但文件都還是只用 `%`；其他地方也出現 %-style、%-format(ting) 的說法。

  - [cpython/\_\_init\_\_\.py at v3\.7\.1 · python/cpython](https://github.com/python/cpython/blob/v3.7.1/Lib/logging/__init__.py#L641) 從 `logging.Handler` 原始碼 `_defaultFormatter = Formatter()` 看來，當 handler 在處理 log record 時若發現沒有 formatter，會拿 `logging.Formatter` 來將 `LogRecord` 轉成 string。

  - [Formatter Objects - logging — Logging facility for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/logging.html#formatter-objects)
      - `Formatter` objects have the following attributes and methods. They are responsible for CONVERTING A `LogRecord` TO (USUALLY) A STRING which can be interpreted by either a human or an external system. The base `Formatter` allows a FORMATTING STRING to be specified. If none is supplied, the default value of `'%(message)s'` is used, which just includes the message in the logging call. To have additional items of information in the formatted output (such as a timestamp), keep reading.
      - A `Formatter` can be initialized with a format string which makes use of knowledge of the `LogRecord` attributes - such as the default value mentioned above making use of the fact that the user’s message and arguments are PRE-FORMATTED into a `LogRecord`’s `message` attribute. This format string contains standard Python %-style mapping keys.

        預設的 format string 會這麼簡單，是因為假設了所有的資訊都編進了 `message` attribute，但通常不是，所以要自訂 format string。

        The useful mapping keys in a `LogRecord` are given in the section on `LogRecord` attributes.

  - [`class logging.Formatter(fmt=None, datefmt=None, style='%')` - logging — Logging facility for Python — Python 3\.7\.3rc1 documentation](https://docs.python.org/3/library/logging.html#logging.Formatter)
      - Returns a new instance of the `Formatter` class. The instance is initialized with a format string for the MESSAGE AS A WHOLE, as well as a format string for the DATE/TIME PORTION of a message. If no `fmt` is specified, `'%(message)s'` is used. If no `datefmt` is specified, a format is used which is described in the `formatTime()` documentation.

        若要自訂 formatter 的話，不一定會有 format string 的概念不是?? 例如 JSON Lines 的輸出，根本沒有下面 "merged with its data" 的需求。

        最後一段的說法，Python 2 & 3 明顯不同：

        > - Python 3: If no `datefmt` is specified, a format is used which is described in the `formatTime()` documentation. 也就是 `%Y-%m-%d %H:%M:%S,uuu`，不是 ISO8601
        > - Python 2: If no `datefmt` is specified, the ISO8601 date format is used.

        另外 constructor 裡的 `style='%'` 也是 Python 3 才有的。

      - The `style` parameter can be one of ‘`%`’, ‘`{`‘ or ‘`$`’ and determines how the format string will be MERGED WITH ITS DATA: using one of %-formatting, `str.format()` or `string.Template`. See Using particular formatting styles throughout your application for more information on using `{`- and `$`-formatting for log messages.

        Changed in version 3.2: The `style` parameter was added.

    `format(record)`

      - The record’s ATTRIBUTE DICTIONARY is used as the operand to a string formatting operation. Returns the resulting string.

        Before formatting the dictionary, a couple of preparatory steps are carried out. The `message` attribute of the record is computed using `msg % args`. If the formatting string contains `'(asctime)'`, `formatTime()` is called to format the event time. If there is exception information, it is formatted using `formatException()` and appended to the message.

        Note that the formatted exception information is cached in attribute `exc_text`. This is useful because the exception information can be pickled and sent across the wire, but you should be careful if you have more than one `Formatter` subclass which customizes the formatting of exception information. In this case, you will have to clear the cached value AFTER A FORMATTER HAS DONE ITS FORMATTING (自己清，而不是交給下一個人清), so that the next formatter to handle the event doesn’t use the cached value but recalculates it afresh.

        If stack information is available, it’s appended after the exception information, using `formatStack()` to transform it if necessary.

        注意 exception information 與 stack information 不同，分別由 `formatException()` 與 `formatStack()` 轉換；雖然 stack information 是 Python 3 才有的，但什麼是 stack information??

      - [CPython 3.7 `logging.Formatter.format()`](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py#L606) 的實作如下：

            def format(self, record):
                record.message = record.getMessage() # (1)
                if self.usesTime():
                    record.asctime = self.formatTime(record, self.datefmt) # (3)
                s = self.formatMessage(record)       # (2)
                if record.exc_info:
                    # Cache the traceback text to avoid converting it multiple times
                    # (it's constant anyway)
                    if not record.exc_text:
                        record.exc_text = self.formatException(record.exc_info)
                if record.exc_text:
                    if s[-1:] != "\n":
                        s = s + "\n"
                    s = s + record.exc_text
                if record.stack_info:
                    if s[-1:] != "\n":
                        s = s + "\n"
                    s = s + self.formatStack(record.stack_info)
                return s

         1. 根據 [`logging.LogRecord.getMessage()` 的實作](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py#L371)，才知道 `LogRecord` 一開始是將 `debug(msg, *args)` 中的 `msg` 與 `args` 分開存，直到被呼叫 `getMessage()` 時才做 string formatting 以產生 message；跟 logging 的 formatter 無關。
         2. `formatMessage()` 這時候才是 logging 的 formatting 在作用；上面 `LogRecord.getMessage()` 的結果會記錄在 `LogRecord.message` (不同於 `LogRecord.msg`)，將由 format string 裡的 `%(message)s` 帶出來)。
         3. 跟 `LogRecord.message` 一樣，`LogRecord.asctime` 也是經過 formatter 加工才產生的。其中 `LogRecord.message` 符合 [LogRecord attributes](https://docs.python.org/3/library/logging.html#logrecord-attributes) 的說法 -- "The logged message, computed as `msg % args`. This is set when `Formatter.format()` is invoked."，但 `LogRecord.asctime` 文件就沒有明確寫出產生的時機。

    `formatTime(record, datefmt=None)`

      - This method should be called from `format()` by a formatter which wants to make use of a formatted time. This method can be overridden in formatters to provide for any specific requirement, but the basic behavior is as follows: if `datefmt` (a string) is specified, it is used with `time.strftime()` to format the creation time of the record. Otherwise, the format ‘`%Y-%m-%d %H:%M:%S,uuu`’ is used, where the `uuu` part is a millisecond value and the other letters are as per the `time.strftime()` documentation. An example time in this format is `2003-01-23 00:29:50,411`. The resulting string is returned.
      - This function uses a USER-CONFIGURABLE FUNCTION to convert the creation time to a tuple. By default, `time.localtime()` is used; to change this for a particular formatter instance, set the `converter` attribute to a function with the same signature as `time.localtime()` or `time.gmtime()`. To change it for all formatters, for example if you want all logging times to be shown in GMT, set the `converter` attribute in the `Formatter` class.

        跟時區的轉換有關，至於 formatting 還是看 `datefmt`。

      - Changed in version 3.3: Previously, the default format was hard-coded as in this example: `2010-09-06 22:38:15,292` where the part before the comma is handled by a `strptime` format string (`'%Y-%m-%d %H:%M:%S'`), and the part after the comma is a millisecond value. Because `strptime` does not have a format placeholder for milliseconds, the millisecond value is appended using another format string, `'%s,%03d'` — and both of these format strings have been hardcoded into this method. With the change, these strings are DEFINED AS CLASS-LEVEL ATTRIBUTES WHICH CAN BE OVERRIDDEN AT THE INSTANCE LEVEL WHEN DESIRED. The names of the attributes are `default_time_format` (for the `strptime` format string) and `default_msec_format` (for appending the millisecond value).

        在 [Python 2](https://docs.python.org/2/library/logging.html#logging.Formatter.formatTime) 的行為則是沒指定 `datefmt` 時就採用 ISO8601。

        > Otherwise, the ISO8601 format is used. The resulting string is returned.

      - [CPython 3.7 `logging.Formatter.formatTime()`](https://github.com/python/cpython/blob/3.7/Lib/logging/__init__.py#L539) 的實作如下：

            converter = time.localtime
            default_time_format = '%Y-%m-%d %H:%M:%S' # 根本不是 ISO8601
            default_msec_format = '%s,%03d'

            def formatTime(self, record, datefmt=None):
                ct = self.converter(record.created)
                if datefmt:
                    s = time.strftime(datefmt, ct)
                else:
                    t = time.strftime(self.default_time_format, ct)
                    s = self.default_msec_format % (t, record.msecs)
                return s

    `formatException(exc_info)`

      - Formats the specified exception information (a standard exception tuple as returned by `sys.exc_info()`) as a string. This default implementation just uses `traceback.print_exception()`. The resulting string is returned.

    `formatStack(stack_info)`

      - Formats the specified stack information (a string as returned by `traceback.print_stack()`, but with the last newline removed) as a string. This default implementation just returns the input value.

  - [Using particular formatting styles throughout your application - Logging Cookbook — Python 3\.7\.1 documentation](https://docs.python.org/3/howto/logging-cookbook.html#using-particular-formatting-styles-throughout-your-application) ... completely orthogonal to how an individual logging message is constructed #ril

## Multiprocessing ??

  - [Logging Cookbook — Python 3\.7\.3 documentation](https://docs.python.org/3/howto/logging-cookbook.html#logging-to-a-single-file-from-multiple-processes) #ril

    Logging to a single file from multiple processes

      - Although logging is thread-safe, and logging to a single file from MULTIPLE THREADS in a single process is supported, LOGGING TO A SINGLE FILE FROM MULTIPLE PROCESSES IS NOT SUPPORTED, because there is no standard way to SERIALIZE ACCESS TO A SINGLE FILE across multiple processes in Python.

        無論如何，"SERIALIZE access to a single file" 聽起來對 application 效能都有影響，最好的方式會不會是寫不同的檔案，事後再合併檢視 ??

      - If you need to log to a single file from multiple processes, one way of doing this is to HAVE ALL THE PROCESSES LOG TO A `SocketHandler`, and have a SEPARATE PROCESS which implements a SOCKET SERVER which reads from the socket and logs to file. (If you prefer, you can dedicate one thread in one of the existing processes to perform this function.)

        This section documents this approach in more detail and includes a working SOCKET RECEIVER which can be used as a starting point for you to adapt in your own applications.

      - If you are using a recent version of Python which includes the `multiprocessing` module, you could write your own handler which uses the `Lock` class from this module to serialize access to the file from your processes. The existing `FileHandler` and subclasses DO NOT make use of multiprocessing at present, though they MAY DO SO IN THE FUTURE. Note that at present, the `multiprocessing` module does not provide working lock functionality on all platforms (see https://bugs.python.org/issue3770).

        如果平台支援，這似乎是最簡單的方式? 不過這也要 master process 是自己寫的才行 ??

      - Alternatively, you can use a `Queue` and a `QueueHandler` to send all logging events to one of the processes in your multi-process application. The following example script demonstrates how you can do this; in the example a SEPARATE LISTENER PROCESS listens for events sent by other processes and logs them according to its own logging configuration.

        Although the example only demonstrates one way of doing it (for example, you may want to use a listener thread rather than a separate listener process – the implementation would be analogous) it does allow for COMPLETELY DIFFERENT LOGGING CONFIGURATIONS for the listener and the other processes in your application, and can be used as the basis for code meeting your own specific requirements:

            # You'll need these imports in your own code
            import logging
            import logging.handlers
            import multiprocessing

            # Next two import lines for this demo only
            from random import choice, random
            import time

            #
            # Because you'll want to define the logging configurations for listener and workers, the
            # listener and worker process functions take a configurer parameter which is a callable
            # for configuring logging for that process. These functions are also passed the queue,
            # which they use for communication.
            #
            # In practice, you can configure the listener however you want, but note that in this
            # simple example, the listener does not apply level or filter logic to received records.
            # In practice, you would probably want to do this logic in the worker processes, to AVOID
            # SENDING EVENTS WHICH WOULD BE FILTERED OUT BETWEEN PROCESSES.
            #
            # The size of the rotated files is made small so you can see the results easily.
            def listener_configurer():
                root = logging.getLogger()
                h = logging.handlers.RotatingFileHandler('mptest.log', 'a', 300, 10)
                f = logging.Formatter('%(asctime)s %(processName)-10s %(name)s %(levelname)-8s %(message)s')
                h.setFormatter(f)
                root.addHandler(h)

            # This is the listener process top-level loop: wait for logging events
            # (LogRecords)on the queue and handle them, quit when you get a None for a
            # LogRecord.
            def listener_process(queue, configurer):
                configurer()
                while True:
                    try:
                        record = queue.get()
                        if record is None:  # We send this as a sentinel to tell the listener to quit.
                            break
                        logger = logging.getLogger(record.name)
                        logger.handle(record)  # No level or filter logic applied - just do it!
                    except Exception:
                        import sys, traceback
                        print('Whoops! Problem:', file=sys.stderr)
                        traceback.print_exc(file=sys.stderr)

            # Arrays used for random selections in this demo

            LEVELS = [logging.DEBUG, logging.INFO, logging.WARNING,
                      logging.ERROR, logging.CRITICAL]

            LOGGERS = ['a.b.c', 'd.e.f']

            MESSAGES = [
                'Random message #1',
                'Random message #2',
                'Random message #3',
            ]

            # The worker configuration is done at the start of the worker process run.
            # Note that on Windows you can't rely on fork semantics, so each process
            # will run the logging configuration code when it starts.
            def worker_configurer(queue):
                h = logging.handlers.QueueHandler(queue)  # Just the one handler needed
                root = logging.getLogger()
                root.addHandler(h)
                # send all messages, for demo; no other level or filter logic applied.
                root.setLevel(logging.DEBUG)

            # This is the worker process top-level loop, which just logs ten events with
            # random intervening delays before terminating.
            # The print messages are just so you know it's doing something!
            def worker_process(queue, configurer):
                configurer(queue)
                name = multiprocessing.current_process().name
                print('Worker started: %s' % name)
                for i in range(10):
                    time.sleep(random())
                    logger = logging.getLogger(choice(LOGGERS))
                    level = choice(LEVELS)
                    message = choice(MESSAGES)
                    logger.log(level, message)
                print('Worker finished: %s' % name)

            # Here's where the demo gets orchestrated. Create the queue, create and start
            # the listener, create ten workers and start them, wait for them to finish,
            # then send a None to the queue to tell the listener to finish.
            def main():
                queue = multiprocessing.Queue(-1)
                listener = multiprocessing.Process(target=listener_process,
                                                   args=(queue, listener_configurer))
                listener.start()
                workers = []
                for i in range(10):
                    worker = multiprocessing.Process(target=worker_process,
                                                     args=(queue, worker_configurer))
                    workers.append(worker)
                    worker.start()
                for w in workers:
                    w.join()
                queue.put_nowait(None)
                listener.join()

            if __name__ == '__main__':
                main()

      - A variant of the above script keeps the logging in the main process, in a separate thread:

            import logging
            import logging.config
            import logging.handlers
            from multiprocessing import Process, Queue
            import random
            import threading
            import time

            def logger_thread(q):
                while True:
                    record = q.get()
                    if record is None:
                        break
                    logger = logging.getLogger(record.name)
                    logger.handle(record)


            def worker_process(q):
                qh = logging.handlers.QueueHandler(q)
                root = logging.getLogger()
                root.setLevel(logging.DEBUG)
                root.addHandler(qh)
                levels = [logging.DEBUG, logging.INFO, logging.WARNING, logging.ERROR,
                          logging.CRITICAL]
                loggers = ['foo', 'foo.bar', 'foo.bar.baz',
                           'spam', 'spam.ham', 'spam.ham.eggs']
                for i in range(100):
                    lvl = random.choice(levels)
                    logger = logging.getLogger(random.choice(loggers))
                    logger.log(lvl, 'Message no. %d', i)

            if __name__ == '__main__':
                q = Queue()
                d = {
                    'version': 1,
                    'formatters': {
                        'detailed': {
                            'class': 'logging.Formatter',
                            'format': '%(asctime)s %(name)-15s %(levelname)-8s %(processName)-10s %(message)s'
                        }
                    },
                    'handlers': {
                        'console': {
                            'class': 'logging.StreamHandler',
                            'level': 'INFO',
                        },
                        'file': {
                            'class': 'logging.FileHandler',
                            'filename': 'mplog.log',
                            'mode': 'w',
                            'formatter': 'detailed',
                        },
                        'foofile': {
                            'class': 'logging.FileHandler',
                            'filename': 'mplog-foo.log',
                            'mode': 'w',
                            'formatter': 'detailed',
                        },
                        'errors': {
                            'class': 'logging.FileHandler',
                            'filename': 'mplog-errors.log',
                            'mode': 'w',
                            'level': 'ERROR',
                            'formatter': 'detailed',
                        },
                    },
                    'loggers': {
                        'foo': {
                            'handlers': ['foofile']
                        }
                    },
                    'root': {
                        'level': 'DEBUG',
                        'handlers': ['console', 'file', 'errors']
                    },
                }
                workers = []
                for i in range(5):
                    wp = Process(target=worker_process, name='worker %d' % (i + 1), args=(q,))
                    workers.append(wp)
                    wp.start()
                logging.config.dictConfig(d)
                lp = threading.Thread(target=logger_thread, args=(q,))
                lp.start()
                # At this point, the main process could do some useful work of its own
                # Once it's done that, it can wait for the workers to terminate...
                for wp in workers:
                    wp.join()
                # And now tell the logging thread to finish up, too
                q.put(None)
                lp.join()

        This variant shows how you can e.g. apply configuration for particular loggers - e.g. the `foo` logger has a special handler which stores all events in the foo subsystem in a file `mplog-foo.log`. This will be used by the logging machinery in the main process (even though the logging events are generated in the worker processes) to direct the messages to the appropriate destinations.

    Sending and receiving logging events across a network

      - Let’s say you want to send logging events across a network, and handle them at the receiving end. A simple way of doing this is attaching a `SocketHandler` instance to the root logger at the sending end:

            import logging, logging.handlers

            rootLogger = logging.getLogger('')
            rootLogger.setLevel(logging.DEBUG)
            socketHandler = logging.handlers.SocketHandler('localhost',
                                logging.handlers.DEFAULT_TCP_LOGGING_PORT)
            # don't bother with a formatter, since a socket handler sends the event as
            # an unformatted pickle
            rootLogger.addHandler(socketHandler)

            # Now, we can log to the root logger, or any other logger. First the root...
            logging.info('Jackdaws love my big sphinx of quartz.')

            # Now, define a couple of other loggers which might represent areas in your
            # application:

            logger1 = logging.getLogger('myapp.area1')
            logger2 = logging.getLogger('myapp.area2')

            logger1.debug('Quick zephyrs blow, vexing daft Jim.')
            logger1.info('How quickly daft jumping zebras vex.')
            logger2.warning('Jail zesty vixen who grabbed pay from quack.')
            logger2.error('The five boxing wizards jump quickly.')

        At the receiving end, you can set up a receiver using the socketserver module. Here is a basic working example:

            import pickle
            import logging
            import logging.handlers
            import socketserver
            import struct


            class LogRecordStreamHandler(socketserver.StreamRequestHandler):
                """Handler for a streaming logging request.

                This basically logs the record using whatever logging policy is
                configured locally.
                """

                def handle(self):
                    """
                    Handle multiple requests - each expected to be a 4-byte length,
                    followed by the LogRecord in pickle format. Logs the record
                    according to whatever policy is configured locally.
                    """
                    while True:
                        chunk = self.connection.recv(4)
                        if len(chunk) < 4:
                            break
                        slen = struct.unpack('>L', chunk)[0]
                        chunk = self.connection.recv(slen)
                        while len(chunk) < slen:
                            chunk = chunk + self.connection.recv(slen - len(chunk))
                        obj = self.unPickle(chunk)
                        record = logging.makeLogRecord(obj)
                        self.handleLogRecord(record)

                def unPickle(self, data):
                    return pickle.loads(data)

                def handleLogRecord(self, record):
                    # if a name is specified, we use the named logger rather than the one
                    # implied by the record.
                    if self.server.logname is not None:
                        name = self.server.logname
                    else:
                        name = record.name
                    logger = logging.getLogger(name)
                    # N.B. EVERY record gets logged. This is because Logger.handle
                    # is normally called AFTER logger-level filtering. If you want
                    # to do filtering, do it at the client end to save wasting
                    # cycles and network bandwidth!
                    logger.handle(record)

            class LogRecordSocketReceiver(socketserver.ThreadingTCPServer):
                """
                Simple TCP socket-based logging receiver suitable for testing.
                """

                allow_reuse_address = True

                def __init__(self, host='localhost',
                             port=logging.handlers.DEFAULT_TCP_LOGGING_PORT,
                             handler=LogRecordStreamHandler):
                    socketserver.ThreadingTCPServer.__init__(self, (host, port), handler)
                    self.abort = 0
                    self.timeout = 1
                    self.logname = None

                def serve_until_stopped(self):
                    import select
                    abort = 0
                    while not abort:
                        rd, wr, ex = select.select([self.socket.fileno()],
                                                   [], [],
                                                   self.timeout)
                        if rd:
                            self.handle_request()
                        abort = self.abort

            def main():
                logging.basicConfig(
                    format='%(relativeCreated)5d %(name)-15s %(levelname)-8s %(message)s')
                tcpserver = LogRecordSocketReceiver()
                print('About to start TCP server...')
                tcpserver.serve_until_stopped()

            if __name__ == '__main__':
                main()

      - First run the server, and then the client. On the client side, nothing is printed on the console; on the server side, you should see something like:

            About to start TCP server...
               59 root            INFO     Jackdaws love my big sphinx of quartz.
               59 myapp.area1     DEBUG    Quick zephyrs blow, vexing daft Jim.
               69 myapp.area1     INFO     How quickly daft jumping zebras vex.
               69 myapp.area2     WARNING  Jail zesty vixen who grabbed pay from quack.
               69 myapp.area2     ERROR    The five boxing wizards jump quickly.

      - Note that there are some security issues with pickle in some scenarios. If these affect you, you can use an alternative serialization scheme by overriding the `makePickle()` method and implementing your alternative there, as well as adapting the above script to use your alternative serialization.

    A more elaborate multiprocessing example #ril

      - The following working example shows how logging can be used with multiprocessing using configuration files. The configurations are fairly simple, but serve to illustrate how more complex ones could be implemented in a real multiprocessing scenario.

  - [Logging - multiprocessing — Process\-based parallelism — Python 3\.7\.3 documentation](https://docs.python.org/3/library/multiprocessing.html#logging)

      - SOME support for logging is available. Note, however, that the `logging` package does NOT USE PROCESS SHARED LOCKS so it is possible (depending on the handler type) for messages from different processes to GET MIXED UP.

        這呼應了 [Logging Cookbook — Python 3\.7\.3 documentation](https://docs.python.org/3/howto/logging-cookbook.html#logging-to-a-single-file-from-multiple-processes) 裡的說法：

        > The existing `FileHandler` and subclasses DO NOT make use of multiprocessing at present, though they MAY DO SO IN THE FUTURE.

  - [\[Design Question\] How do gunicorn workers log correctly? · Issue \#1272 · benoitc/gunicorn](https://github.com/benoitc/gunicorn/issues/1272) #ril

  - [python \- How do I log using gunicorn and multiprocessing? \- Stack Overflow](https://stackoverflow.com/questions/32565328/) #ril

  - [logging \- How should I log while using multiprocessing in Python? \- Stack Overflow](https://stackoverflow.com/questions/641420/)

      - cdleary: Right now I have a central module IN A FRAMEWORK that spawns multiple processes using the Python 2.6 `multiprocessing` module. Because it uses `multiprocessing`, there is module-level MULTIPROCESSING-AWARE LOG, `LOG = multiprocessing.get_logger()`. Per [the docs](http://docs.python.org/library/multiprocessing.html#logging), this logger has process-shared locks so that you don't garble things up in `sys.stderr` (or whatever filehandle) by having multiple processes writing to it simultaneously.

        The issue I have now is that THE OTHER MODULES in the framework are NOT MULTIPROCESSING-AWARE. The way I see it, I need to make all dependencies on this central module use multiprocessing-aware logging. That's annoying within the framework, let alone for all clients of the framework. Are there alternatives I'm not thinking of?

      - Sebastian Blask: The docs you link to, state the exact opposite of what you say, the logger has no process shared locks and things get mixed up - a problem I had as well.

      - vladr: The only way to deal with this NON-INTRUSIVELY is to:

         1. Spawn each worker process such that its log goes to a DIFFERENT FILE DESCRIPTOR (to disk or to pipe.) Ideally, all log entries should be timestamped.

            分開寫，事後再合併就不會有衝突。

         2. Your controller process can then do one of the following:

              - If using disk files: Coalesce the log files at the end of the run, sorted by timestamp
              - If using pipes (recommended): Coalesce log entries ON-THE-FLY FROM ALL PIPES, into a central log file. (E.g., Periodically select from the pipes' file descriptors, perform merge-sort on the available log entries, and flush to centralized log. Repeat.)

        Brandon Rhodes: Why not just use a `multiprocessing.Queue` and a logging thread in the main process instead? Seems simpler.

