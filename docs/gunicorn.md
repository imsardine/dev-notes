# Gunicorn

  - Gunicorn = "Green Unicorn" (logo 就是一隻綠色的獨角獸)，唸做 g-unicorn。

參考資料：

  - [Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/) Gunicorn 'Green Unicorn' is a Python WSGI HTTP Server for UNIX. It's a PRE-FORK WORKER MODEL.
  - [Ambiguous Pronunciation · Issue \#139 · benoitc/gunicorn](https://github.com/benoitc/gunicorn/issues/139) davisp (collaborator) 說 green unicorn、g-unicorn 或 gun-i-corn 都可以。
  - [Gunicorn - Standalone WSGI Containers — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/deploying/wsgi-standalone/#gunicorn) It’s a pre-fork worker model ported from Ruby’s [Unicorn project](https://en.wikipedia.org/wiki/Unicorn_(web_server)).

## 新手上路 ?? {: #getting-started }

  - [Installation - Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/)

        $ pip install gunicorn
        $ cat myapp.py
          def app(environ, start_response): <-- 同 WSGI 規範的，會收到資料 (environment info) 及 callback function
              data = b"Hello, World!\n"
              start_response("200 OK", [
                  ("Content-Type", "text/plain"),
                  ("Content-Length", str(len(data)))
              ])
              return iter([data])
        $ gunicorn -w 4 myapp:app <-- -w 4 表示要有 4 個 worker，後面
        [2014-09-10 10:22:28 +0000] [30869] [INFO] Listening at: http://127.0.0.1:8000 (30869) <-- 預設是 8000 port，但只在 localhost
        [2014-09-10 10:22:28 +0000] [30869] [INFO] Using worker: sync <-- sync worker?
        [2014-09-10 10:22:28 +0000] [30874] [INFO] Booting worker with pid: 30874 <-- 獨立的 worker process
        [2014-09-10 10:22:28 +0000] [30875] [INFO] Booting worker with pid: 30875
        [2014-09-10 10:22:28 +0000] [30876] [INFO] Booting worker with pid: 30876
        [2014-09-10 10:22:28 +0000] [30877] [INFO] Booting worker with pid: 30877

  - [Quickstart — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/quickstart/) 一開始就提到 First we imported the `Flask` class. An instance of this class will be our WSGI application，把它交給 Gunicorn 即可，就像上面不用任何 web framework 的 application object 一樣。
  - [Deployment Options — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/deploying/) 再次強調 Just remember that your `Flask` application object is the actual WSGI application.
  - [Gunicorn - Standalone WSGI Containers — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/deploying/wsgi-standalone/#gunicorn) These servers stand alone when they run; you can proxy to them from your web server. ... `gunicorn -w 4 -b 127.0.0.1:4000 myproject:app`

## `gunicorn` CLI ??

  - [Running Gunicorn — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/run.html) #ril
      - Basic usage: `$ gunicorn [OPTIONS] APP_MODULE` Where `APP_MODULE` is of the pattern `$(MODULE_NAME):$(VARIABLE_NAME)`. The module name can be a FULL DOTTED PATH. (例如 `myproj.main:app`) The variable name refers to a WSGI callable that should be found in the specified module. 例如 `test.py` 的內容：

            def app(environ, start_response):
                """Simplest possible application object"""
                ...

        可以用 `gunicorn --workers=2 test:app` 執行。

      - `-b BIND, --bind=BIND` - Specify a server socket to bind. Server sockets can be any of `$(HOST)`, `$(HOST):$(PORT)`, or `unix:$(PATH)`. An IP is a valid `$(HOST)`. 可以同時指定 host 跟 port；預設是 `127.0.0.0:8000`。
      - `-w WORKERS, --workers=WORKERS` - The number of worker processes. This number should generally be between 2-4 WORKERS PER CORE in the server. Check the FAQ for ideas on tuning this parameter.
      - Settings can be specified by using environment variable `GUNICORN_CMD_ARGS`. 這點對於包裝 Docker image 時很重要，因為 `gunicorn [OPTIONS] APP_MODULE` 中的 `APP_MODULE` 一定要擺最後面，若採用 `ENTRYPOINT ["gunicorn", "myproject.wsgi"]`，使用 image 的人就無法透過 `CMD` 給 options；實驗發現 `gunicorn APP_MODULE [OPTIONS]` 的用法也是可行的，雖然文件沒有明確提及。
      - 跟 Django 的整合提到 Gunicorn will look for a WSGI callable named `application` if not specified. So for a typical Django project, invoking Gunicorn would look like: `gunicorn myproject.wsgi`；原來 [Django 的樣板會這樣安排](https://docs.djangoproject.com/en/2.1/howto/deployment/wsgi/#the-application-object) -- The `startproject` command creates a file `<project_name>/wsgi.py` that contains such an `application` callable. 所以 [GitHub 上有一堆這樣的例子](https://github.com/search?q=filename%3Awsgi.py+django)。

## Pre-fork Worker Model ??

  - [Design — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/design.html) #ril

    Server Model

      - Gunicorn is based on the PRE-FORK WORKER MODEL. This means that there is a central MASTER PROCESS that manages a set of WORKER PROCESSES. The master NEVER knows anything about individual clients. All requests and responses are handled completely by worker processes.

    Server Model / Master

      - The master process is A SIMPLE LOOP that listens for various PROCESS SIGNALS and reacts accordingly. It manages the list of running workers by listening for SIGNALS ?? like TTIN, TTOU, and CHLD.

        TTIN and TTOU tell the master to increase or decrease the number of running workers. CHLD indicates that a child process has terminated, in this case the master process automatically restarts the failed worker.

        Gunicorn 的 master process 完全不會載入 Python code，跟 [uWSGI, Preforking and Lazy Apps](https://engineering.ticketea.com/uwsgi-preforking-lazy-apps/) 中 uWSGI, forking and copy-on-write 描述的狀況完全不且。

    Server Model / Sync Workers

      - The most basic and the DEFAULT worker type is a synchronous worker class that HANDLES A SINGLE REQUEST AT A TIME. This model is the simplest to reason about as any errors will affect AT MOST a single request.

        啟動時會看到 `[INFO] Using worker: sync` 的訊息。

        Though as we describe below only processing a single request at a time requires some ASSUMPTIONS ?? about how applications are programmed.

      - `sync` worker does NOT support PERSISTENT CONNECTIONS - each connection is closed after response has been sent (even if you manually add `Keep-Alive` or `Connection: keep-alive` header in your application).

        不適合 production ??

    Server Model/ Async Workers

      - The asynchronous workers available are based on Greenlets (via Eventlet and Gevent). Greenlets are an implementation of COOPERATIVE MULTI-THREADING ?? for Python. In general, an application should be able to make use of these worker classes WITH NO CHANGES.

    Server Model / Tornado Workers #ril

  - [Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/) 一開始就講 It's a pre-fork worker model
  - [Quick Start - Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/#quickstart) Server 一啟動時 (`Listening at: http://127.0.0.1:8000`)，緊接著其他 worker process 就預先產生了 ` Booting worker with pid: ...`，這就是 pre-fork worker?
  - [Worker Processes - FAQ — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/faq.html#worker-processes) #ril

## Sync/Async Worker ??

  - [Installation - Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/) 範例出現 `[INFO] Using worker: sync`。
  - [Async Workers - Installation — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/install.html#async-workers) "pause for extended periods of time during request processing" 時要採用 async worker，加裝 [Eventlet](http://eventlet.net/) 或 [Gevent](http://www.gevent.org/)。
  - [Understanding gunicorn's async worker concurrency model \| Volant\.is](https://words.volant.is/articles/understanding-gunicorns-async-worker-concurrency-model/) (2014-04-21) #ril

## Logging ??

  - [Logging - Settings — Gunicorn 19\.9\.0 documentation](http://docs.gunicorn.org/en/stable/settings.html#logging)

    `accesslog`

      - `--access-logfile FILE` 預設 `None`。
      - The Access log file to write to. `'-'` means log to stdout.

    `access_log_format`

      - `--access-logformat STRING` 預設 `%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"`

        有點難懂，舉個例子：

            172.17.0.1 -     -     [29/Mar/2019:02:27:46 +0000] "POST / HTTP/1.1" 500   290   "-"     "curl/7.54.0"
             %(h)s     %(l)s %(u)s %(t)s                        "%(r)s"           %(s)s %(b)s "%(f)s" "%(a)s"

    `errorlog`

      - `--error-logfile FILE`, `--log-file FILE`
      - The Error log file to write to. Using `'-'` for `FILE` makes gunicorn log to stderr.
      - Changed in version 19.2: Log to stderr by default.

      - 採用什麼格式? 實際的例子也看不太懂 ...

            [2019-03-29 02:27:46 +0000] [8] [DEBUG] POST /

        從 [Gunicorn default error logging date format is not standard ISO8601 · Issue \#1771 · benoitc/gunicorn](https://github.com/benoitc/gunicorn/issues/1771) 看來，似乎是對應 `r"%(asctime)s [%(process)d] [%(levelname)s] %(message)s"`

    `logger_class`

      - `--logger-class STRING` 預設 `gunicorn.glogging.Logger`
      - The logger you want to use to log events in Gunicorn. The default class (`gunicorn.glogging.Logge`r) handle most of normal usages in logging. It provides error and access logging.
      - You can provide your own logger by giving Gunicorn a PYTHON PATH to a subclass like `gunicorn.glogging.Logger`.

        雖然沒有 `--error-logformat` 可用，但繼承 `gunicorn.glogging.Logger` 改寫 log 的處理方式，是有機會將 access & error log 都寫出為 JSON Lines 的；也可以搭配 `--log-config` 使用。由 `--pythonpath STRING` 調整 Python path #ril

    `logconfig`

      - `--log-config FILE` 預設 `None`
      - The log config file to use. Gunicorn uses the standard Python logging module’s Configuration file format.

  - [python \- How can I configure gunicorn to use a consistent error log format? \- Stack Overflow](https://stackoverflow.com/questions/45088749/)

      - Kris Harper: I am using Gunicorn in front of a Python Flask app. I am able to configure the access log format using the `--access-log-format` command line parameter when I run gunicorn. But I can't figure out how to configure the error logs.

        I would be fine with the default format, except it's not consistent. It looks like Gunicorn status messages have one format, but application exceptions have a different format. This is making it difficult to use log aggregation. 不過若沒有 uncaught exception，就不會有這類問題?

            [2017-07-13 16:33:24 +0000] [15] [INFO] Booting worker with pid: 15
            [2017-07-13 16:33:24 +0000] [16] [INFO] Booting worker with pid: 16
            [2017-07-13 16:33:24 +0000] [17] [INFO] Booting worker with pid: 17
            [2017-07-13 16:33:24 +0000] [18] [INFO] Booting worker with pid: 18
            [2017-07-13 18:31:11,580] ERROR in app: Exception on /api/users [POST]
            Traceback (most recent call last):
              File "/usr/local/lib/python3.5/dist-packages/flask/app.py", line 1982, in wsgi_app
                response = self.full_dispatch_request()
              File "/usr/local/lib/python3.5/dist-packages/flask/app.py", line 1614, in full_dispatch_request
                rv = self.handle_user_exception(e)
            ...

      - aramaki: Using this logging config file, I was able to change the error log format

            [loggers]
            keys=root, gunicorn.error

            [handlers]
            keys=error_console

            [formatters]
            keys=generic

            [logger_root]
            level=INFO
            handlers=error_console

            [logger_gunicorn.error]
            level=INFO
            handlers=error_console
            propagate=0
            qualname=gunicorn.error

            [handler_error_console]
            class=StreamHandler
            formatter=generic
            args=(sys.stderr, )

            [formatter_generic]
            format=%(asctime)s %(levelname)-5s [%(module)s] ~ %(message)s
            datefmt=%Y-%m-%d %H:%M:%S %Z
            class=logging.Formatter

        The key is to overwrite the `gunicorn.error` logger config, and the snipped above does exactly that.

        Note the `propagate=0` field, it is important otherwise your log messages will be printed twice (gunicorn always keeps the default logging config).

  - [gunicorn/glogging\.py at 19\.9\.0 · benoitc/gunicorn](https://github.com/benoitc/gunicorn/blob/19.9.0/gunicorn/glogging.py#L171) #ril

        class Logger(object):

            LOG_LEVELS = {
                "critical": logging.CRITICAL,
                "error": logging.ERROR,
                "warning": logging.WARNING,
                "info": logging.INFO,
                "debug": logging.DEBUG
            }
            loglevel = logging.INFO

            error_fmt = r"%(asctime)s [%(process)d] [%(levelname)s] %(message)s"
            datefmt = r"[%Y-%m-%d %H:%M:%S %z]"

            access_fmt = "%(message)s"
            syslog_fmt = "[%(process)d] %(message)s"

            atoms_wrapper_class = SafeAtoms

            def __init__(self, cfg):
                self.error_log = logging.getLogger("gunicorn.error")
                self.error_log.propagate = False
                self.access_log = logging.getLogger("gunicorn.access")
                self.access_log.propagate = False
                self.error_handlers = []
                self.access_handlers = []
                self.logfile = None
                self.lock = threading.Lock()
                self.cfg = cfg
                self.setup(cfg)

## Configuration ??

  - [Configuration Overview — Gunicorn 19\.9\.0 documentation](http://docs.gunicorn.org/en/latest/configure.html)
      - Gunicorn pulls configuration information from three distinct places. in order of least to most authoritative: 1. Framework Settings 2. Configuration File 3. Command Line 其中 framework specific configuration file 只支援 Paster。
      - To check your configuration when using the command line or the configuration file you can run the following command: `$ gunicorn --check-config APP_MODULE` It also allows you to know if your application can be launched. 通常要搭配 `--config` 使用，因為 CLI options 有錯誤本來就會檢查；實驗發現，config file 裡有指定不對的 setting 時，例如 `preload` (正確是 `preload_app`)，執行 `gunicorn --config config.py --check-config ...` 會直接 exit，但 exit status 是 0，但不加 `--check-config` 就沒事。
      - Not all Gunicorn SETTINGS are available to be set from the command line. 用 `gunicorn --help` 看最準；注意 setting 與 configuration 的不同，前者是可以調整的點，後者是設定的管道 -- config file、CLI options 等。
      - The configuration file should be a valid Python source file. It only needs to be readable from the file system. More specifically, it does not need to be IMPORTABLE. Any Python is valid. Just consider that this will be run every time you start Gunicorn (including when you signal Gunicorn to reload). 重新執行，實際上會有什麼影響嗎?

  - [Settings — Gunicorn 19\.9\.0 documentation](http://docs.gunicorn.org/en/latest/settings.html) #ril
      - This is an exhaustive list of settings for Gunicorn. Some settings are only able to be set from a configuration file. The setting name is what should be used in the configuration file. 以 `preload_app`、`--preload`、`False` 為例，在 config file 裡要用 `preload_app` 設定，在 command line 要用 `--preload`，但預設值都是 `False`，另外 `default_proc_name`、`gunicorn` 沒有提示 `--xxx`，表示只能用在 config file 裡。
      - `raw_env`, `-e ENV, --env ENV`, `[]` -- Set environment variable (`key=value`). PASS variables to the execution environment. Ex.: `$ gunicorn -b 127.0.0.1:8000 --env FOO=1 test:app` 原來要特別指定，環境變數才進得去，跟 Docker、tox 的做法一樣，預設不會 pass all。

  - [Security - Settings — Gunicorn 19\.9\.0 documentation](http://docs.gunicorn.org/en/latest/settings.html#security) #ril

    `limit_request_line`

      - `--limit-request-line INT`, 4094

      - The maximum size of HTTP REQUEST LINE in bytes.

      - This parameter is used to limit the allowed size of a client’s HTTP request-line. Since the request-line consists of the HTTP method, URI, and protocol version, this directive places a restriction on the length of a request-URI allowed for a request on the server.

        A server needs this value to be large enough to hold any of its resource names, including any information that might be passed in the QUERY PART of a GET request. Value is a number from 0 (unlimited) to 8190.

        差不多就是 `https://...?key=value&...` 的長度，若要限制 body 的長度 ??

      - This parameter can be used to prevent any DDOS attack.

        跟 DDOS 攻擊為什麼有關係 ??

## Deployment ??

  - [Deploying Gunicorn — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/deploy.html) #ril
      - 一開始就說 We strongly recommend to use Gunicorn behind a proxy server. 為何??
  - [How might I test a proxy configuration? - FAQ — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/faq.html#how-might-i-test-a-proxy-configuration) #ril
      - 建議用 [Hey](https://github.com/rakyll/hey) 測試 "your proxy is correctly buffering responses for the synchronous workers"，看來 proxy server 要負責 queue 住 reqeust!!
  - [Why is there no HTTP Keep-Alive? - FAQ — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/faq.html#why-is-there-no-http-keep-alive) #ril
      - 預設的 sync worker 被設計用在 Nginx 背後 (only uses HTTP/1.0 with its upstream servers?) 如果要 Gunicorn 自己面對 unbuffered requests (直接面對來自 internet 的 request)，就必須要改用 async worker。

## statsD ??

  - [Instrumentation — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/instrumentation.html) #ril

## Sharing Data Between Workers ??

  - [Support sharing registry across multiple workers (where possible) · Issue \#30 · prometheus/client\_python](https://github.com/prometheus/client_python/issues/30)
      - discordianfish: 用 Prometheus Client Library 遇到 Gunicorn/uWSGI 這類會起多個 worker 的 server 時，每次都只會刮取到單一個 worker 的數據 (each scrape it hits only one worker since they can't share state with others)，uWSGI 支援 [sharedarea](http://uwsgi-docs.readthedocs.org/en/latest/SharedArea.html) 可以在 worker 間共享 registry，或許 Gunicorn 也支援類似的機制?
      - brian-brazil: (member) 可能要自己實作 sharing mechanism 才能跨系統使用，僅限於 counter-based metrics 使用? 之後提出 https://github.com/brian-brazil/client_python/commit/d2d88ea1b22dcf96416877a81e0ec31ad999e96f 裡面有 `MultiProcessCollector`。
      - justyns: 跟 brian-brazil 對話看來，`prometheus_multiproc_dir` 環境變數要給，底下會產生 `.db` 共用數據，但 server 停止後不會刪掉。
      - brian-brazil: 重新整理在 https://github.com/prometheus/client_python/tree/multiproc，隨後也加上 gauge 的支援；最後送出 https://github.com/prometheus/client_python/pull/66 裡面有用到 mmap，每個 process 一支 `.db` 的樣子?
      - rvrignaud: 針對 Gunicorn? brian-brazil: 沒有，只是用 Gunicorn 來測試而已。
      - grobie: 有做過 benchmark 嗎? brian-brazil: 沒有，there's a fdatasync in there that I need to eliminate though.
      - gjcarneiro: I think this whole "sharing" design you guys are attempting is just over-engineered. 後面跟 brian-brazil 有一長串的討論，後來好像從 exporter 的角度下手? #ril
  - [python \- Sharing static global data among processes in a Gunicorn / Flask app \- Stack Overflow](https://stackoverflow.com/questions/26854594/) aaa90210: nmap #ril

## 安裝設置 {: #setup }

  - [Installation — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/install.html) #ril

## Snippets

### `Dockerfile`

```
FROM python:3.7.0 AS runtime
ADD Pipfile* ./
RUN pip install pipenv==2018.11.26 \
    && pipenv install --system --deploy \
    && rm Pipfile*

FROM runtime AS dev
WORKDIR /workspace
ADD Pipfile* ./
RUN apt-get update && apt-get install -y --no-install-recommends \
        vim \
    && pipenv install --system --deploy --dev

FROM runtime
WORKDIR /workspace
ADD myproject myproject/
EXPOSE 8000
ENTRYPOINT ["gunicorn"]
CMD ["--bind=0.0.0.0:8000", "myporject.wsgi:app"]
```

佈署時要自訂 options 有兩種選擇：

  - 透過 `GUNICORN_CMD_ARGS` 環境變數，例如 `docker run --env GUNICORN_CMD_ARGS='--workers=2' ...`。
  - 覆寫 `CMD`，例如 `docker run ... --bind=0.0.0.0:8000 --workers=2 myporject.wsgi:app`；原有的 `CMD` 要重寫一次，相對麻煩。

## 參考資料 {: #reference }

  - [Gunicorn](http://gunicorn.org/)
  - [benoitc/gunicorn - GitHub](https://github.com/benoitc/gunicorn)
  - [gunicorn - PyPI](https://pypi.org/project/gunicorn/)

文件：

  - [Gunicorn Documentation](http://docs.gunicorn.org/en/stable/)

手冊：

  - [Settings — Gunicorn Documentation](http://docs.gunicorn.org/en/latest/settings.html)
  - [Access Log Format](http://docs.gunicorn.org/en/latest/settings.html#access-log-format)
