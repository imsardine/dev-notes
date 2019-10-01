# pyrollbar

pyrollbar is a Python SDK for reporting exceptions, errors, and log messages to Rollbar.

## 新手上路 {: #getting-started }

  - [Quick start - Python](https://docs.rollbar.com/docs/python#section-quick-start)

        import rollbar
        rollbar.init('POST_SERVER_ITEM_ACCESS_TOKEN', 'production')  # access_token, environment

        try:
            main_app_loop()
        except IOError:
            rollbar.report_message('Got an IOError in the main loop', 'warning')
        except:
            # catch-all
            rollbar.report_exc_info()
            # equivalent to rollbar.report_exc_info(sys.exc_info())

    看起來 `rollbar` 像是個 singleton，`rollbar.init()` 並不會安插什麼 hook，還是要自己在 error handler 叫用 `rollbar.report_*()`。

  - [pyrollbar/\_\_init\_\_\.py at v0\.14\.7 · rollbar/pyrollbar](https://github.com/rollbar/pyrollbar/blob/v0.14.7/rollbar/__init__.py#L320)

    就 `rollbar.init()` 傳入的 `access_token` 與 `environment` 而言，只是把它存在 global `SETTINGS` 而已：

        def init(access_token, environment='production', scrub_fields=None, url_fields=None, **kw):
            ...
            SETTINGS['access_token'] = access_token
            SETTINGS['environment'] = environment

## Log Handler ??

  - [Django - Configuration - Python](https://docs.rollbar.com/docs/python#section-django)

      - If you'd like to be able to use a Django `LOGGING` handler that could catch errors that happen OUTSIDE OF THE MIDDLEWARE and ship them to Rollbar, such as in celery job queue tasks that run in the background SEPARATE FROM WEB REQUESTS, do the following:

        Add this to the `handlers` key:

            'rollbar': {
                'filters': ['require_debug_false'],
                'access_token': 'POST_SERVER_ITEM_ACCESS_TOKEN',
                'environment': 'production',
                'class': 'rollbar.logger.RollbarHandler'
            },

        Then add the handler to the `loggers` key values where you want it to fire off.

            'myappwithtasks': {
                'handlers': ['console', 'logfile', 'rollbar'],
                'level': 'DEBUG',
                'propagate': True,
            },

  - [pyrollbar/app\.py at v0\.14\.7 · rollbar/pyrollbar](https://github.com/rollbar/pyrollbar/blob/v0.14.7/rollbar/examples/flask/app.py)

        import logging

        from flask import Flask

        import rollbar
        from rollbar.logger import RollbarHandler # (1)

        ACCESS_TOKEN = 'ACCESS_TOKEN'
        ENVIRONMENT = 'development'

        rollbar.init(ACCESS_TOKEN, ENVIRONMENT)

        logger = logging.getLogger(__name__)
        logger.setLevel(logging.DEBUG)

        # report WARNING and above to Rollbar
        rollbar_handler = RollbarHandler(history_size=3) # (2)
        rollbar_handler.setLevel(logging.WARNING)

        # gather history for DEBUG+ log messages
        rollbar_handler.setHistoryLevel(logging.DEBUG)   # (2)

        # attach the history handler to the root logger
        logger.addHandler(rollbar_handler)


        app = Flask(__name__)

        @app.route('/')
        def root():
            logger.info('about to call foo()')
            try:
                foo()
            except:
                logger.exception('Caught exception') # (3)

            return '<html><body>Hello World</body></html>'

        if __name__ == '__main__':
            app.run()

     1. 雖然[官方文件](https://docs.rollbar.com/docs/python#section-django) 是在 Django 看到 logging handler 的用法，但範例卻在 Flask。
     2. 什麼是 history ??
     3. 舉的例子不是很好懂，應該搭配 `@app.errorhandler(Exception)` 來實作會比較好。

  - [pyrollbar/logger\.py at master · rollbar/pyrollbar](https://github.com/rollbar/pyrollbar/blob/master/rollbar/logger.py)

        Hooks for integrating with the python logging framework.

        Usage:
            import logging
            from rollbar.logger import RollbarHandler

            rollbar.init('ACCESS_TOKEN', 'ENVIRONMENT')

            logger = logging.getLogger(__name__)
            logger.setLevel(logging.DEBUG)

            # report ERROR and above to Rollbar
            rollbar_handler = RollbarHandler()
            rollbar_handler.setLevel(logging.ERROR)

            # attach the handlers to the root logger
            logger.addHandler(rollbar_handler)

  - [pyrollbar/logger\.py at v0\.14\.7 · rollbar/pyrollbar](https://github.com/rollbar/pyrollbar/blob/v0.14.7/rollbar/logger.py#L48)

    雖然 `RollbarHandler` 的 constructor 也提供 `access_token` 與 `environment` 參數，但內部也是轉呼叫 `rollbar.init()`：

        if access_token is not None:
            rollbar.init(access_token, environment, **kw)

  - [History for rollbar/logger\.py \- rollbar/pyrollbar](https://github.com/rollbar/pyrollbar/commits/v0.6.0/rollbar/logger.py)

    從 Git log 看來，`RollbarHandler` 第一次出現在 v0.6.0。

## 安裝設定 {: #installation }

  - [Quick start - Python](https://docs.rollbar.com/docs/python#section-quick-start)

      - Install using pip:

            pip install rollbar

    Requirements

      - Python 2.7, 3.3, 3.4, 3.5, or 3.6
      - requests 0.12+  --> Python 內建對 HTTP 的支援應該是夠的
      - A Rollbar account

## 參考資料 {: #reference }

  - [Python SDK - Rollbar](https://docs.rollbar.com/docs/python)
  - [rollbar/pyrollbar - GitHub](https://github.com/rollbar/pyrollbar)
