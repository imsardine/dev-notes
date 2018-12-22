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

  - [Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/) 一開始就講 It's a pre-fork worker model
  - [Quick Start - Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/#quickstart) Server 一啟動時 (`Listening at: http://127.0.0.1:8000`)，緊接著其他 worker process 就預先產生了 ` Booting worker with pid: ...`，這就是 pre-fork worker?
  - [Design — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/design.html) 提到 master、worker、thread #ril
  - [Worker Processes - FAQ — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/faq.html#worker-processes) #ril

## Sync/Async Worker ??

  - [Installation - Gunicorn \- Python WSGI HTTP Server for UNIX](http://gunicorn.org/) 範例出現 `[INFO] Using worker: sync`。
  - [Async Workers - Installation — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/install.html#async-workers) "pause for extended periods of time during request processing" 時要採用 async worker，加裝 [Eventlet](http://eventlet.net/) 或 [Gevent](http://www.gevent.org/)。
  - [Understanding gunicorn's async worker concurrency model \| Volant\.is](https://words.volant.is/articles/understanding-gunicorns-async-worker-concurrency-model/) (2014-04-21) #ril

## Configuration ??

  - [Configuration Overview — Gunicorn 19\.8\.1 documentation](http://docs.gunicorn.org/en/latest/configure.html) #ril

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

  - [Support sharing registry across multiple workers \(where possible\) · Issue \#30 · prometheus/client\_python](https://github.com/prometheus/client_python/issues/30)
      - discordianfish: 用 Prometheus Client Library 遇到 Gunicorn/uWSGI 這類會起多個 worker 的 server 時，每次都只會刮取到單一個 worker 的數據 (each scrape it hits only one worker since they can't share state with others)，uWSGI 支援 [sharedarea](http://uwsgi-docs.readthedocs.org/en/latest/SharedArea.html) 可以在 worker 間共享 registry，或許 Gunicorn 也支援類似的機制?
      - brian-brazil: (member) 可能要自己實作 sharing mechanism 才能跨系統使用，僅限於 counter-based metrics 使用? 之後提出 https://github.com/brian-brazil/client_python/commit/d2d88ea1b22dcf96416877a81e0ec31ad999e96f 裡面有 `MultiProcessCollector`。
      - justyns: 跟 brian-brazil 對話看來，`prometheus_multiproc_dir` 環境變數要給，底下會產生 `.db` 共用數據，但 server 停止後不會刪掉。
      - brian-brazil: 重新整理在 https://github.com/prometheus/client_python/tree/multiproc，隨後也加上 gauge 的支援；最後送出 https://github.com/prometheus/client_python/pull/66 裡面有用到 mmap，每個 process 一支 `.db` 的樣子?
      - rvrignaud: 針對 Gunicorn? brian-brazil: 沒有，只是用 Gunicorn 來測試而已。
      - grobie: 有做過 benchmark 嗎? brian-brazil: 沒有，there's a fdatasync in there that I need to eliminate though.
      - gjcarneiro: I think this whole "sharing" design you guys are attempting is just over-engineered. 後面跟 brian-brazil 有一長串的討論，後來好像從 exporter 的角度下手? #ril
  - [python \- Sharing static global data among processes in a Gunicorn / Flask app \- Stack Overflow](https://stackoverflow.com/questions/26854594/) aaa90210: nmap #ril

## 安裝設定 {: #installation }

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

