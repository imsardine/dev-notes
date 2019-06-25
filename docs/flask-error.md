---
title: Flask / Error Handling
---
# [Flask](flask.md) / Error Handling

  - [Application Errors — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/errorhandling/) #ril

      - Applications fail, servers fail. Sooner or later you will see an exception in production. Even if your code is 100% correct, you will still see exceptions from time to time. Why? Because everything else involved will fail. Here are some situations where perfectly fine code can lead to server errors:

          - the client terminated the request early and the application was still reading from the incoming data
          - the database server was overloaded and could not handle the query
          - a filesystem is full
          - a harddrive crashed
          - a backend server overloaded
          - a programming error in a library you are using
          - network connection of the server to another system failed

        And that’s just a small sample of issues you could be facing. So how do we deal with that sort of problem? By default if your application runs in production mode, Flask will display a very SIMPLE PAGE for you and LOG THE EXCEPTION TO THE `logger`.

        都是不可控制的因素。雖然 "log the exception to the logger" 是指 [`flask.Flask.logger`](http://flask.pocoo.org/docs/1.0/api/#flask.Flask.logger)，但確認從 root logger 可以攔截到，會寫出 traceback (固定回 500)，也因此沒自訂 error handling 也沒關係，除非想要自訂 error response 的格式。

        從 [Logging - Basic Configuration](http://flask.pocoo.org/docs/1.0/logging/#basic-configuration) 看來，不用擔心 `flask.app` 又被安排其他 handler：

        > If `app.logger` is accessed before logging is configured, it will add a default handler. If possible, CONFIGURE LOGGING BEFORE CREATING THE APPLICATION OBJECT.

        實驗發現 `flask.app` 會不會被安排其他 handler 跟 application object 的建立無關，而是跟 `app.logger` 什麼時候被存取有關。也就是 `app.logger` 被存取時會檢查 root logger 有沒有 handler，如果沒有的話會在 `flask.app` 安排 handler ... 聽起來有點怪，但在 entry point 一開始就設定好 configuration 就不會有奇奇怪怪的問題。

      - But there is more you can do, and we will cover some better setups to deal with errors.

  - [Error handlers - Application Errors — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/errorhandling/#error-handlers) #ril

      - You might want to show CUSTOM ERROR PAGES to the user when an error occurs. This can be done by REGISTERING ERROR HANDLERS.

      - An error handler is a NORMAL VIEW FUNCTION that return a response, but instead of being registered for a route, it is registered for an exception or HTTP status code that would is raised while trying to handle a request.

    Registering

      - Register handlers by decorating a function with `errorhandler()`. Or use `register_error_handler()` to register the function later. Remember to set the error code when returning the response.

            @app.errorhandler(werkzeug.exceptions.BadRequest)
            def handle_bad_request(e):
                return 'bad request!', 400

            # or, without the decorator
            app.register_error_handler(400, handle_bad_request)

        `werkzeug.exceptions.HTTPException` subclasses like `BadRequest` and their HTTP codes are interchangeable when registering handlers. (`BadRequest.code == 400`)

      - Non-standard HTTP codes cannot be registered by code because they are not known by Werkzeug. Instead, define a subclass of `HTTPException` with the appropriate code and register and raise that exception class.

            class InsufficientStorage(werkzeug.exceptions.HTTPException):
                code = 507
                description = 'Not enough storage space.'

            app.register_error_handler(InsuffcientStorage, handle_507)

            raise InsufficientStorage()

      - Handlers can be registered for any exception class, not just `HTTPException` subclasses or HTTP status codes. Handlers can be registered for a specific class, or for all subclasses of a parent class.

        這一點很適合有發展自己 exception hierarchy 的應用。

    Handling

      - When an exception is caught by Flask while handling a request, it is first looked up by CODE. If no handler is registered for the code, it is looked up by its CLASS HIERARCHY; the MOST SPECIFIC handler is chosen.

        If no handler is registered, `HTTPException` subclasses show a generic message about their code, while other exceptions are converted to a generic 500 Internal Server Error.

        過程中只有一個 handler 會處理到 request 過去中丟出的 error；實驗發現，若走進自訂的 handler，就不會自動做上述的 "log the exception to the `logger`"。

      - For example, if an instance of `ConnectionRefusedError` is raised, and a handler is registered for `ConnectionError` and `ConnectionRefusedError`, the more specific `ConnectionRefusedError` handler is called with the exception instance to generate the response.

        不過 Flask 在什麼情況下會丟 `ConnectionRefusedError` ??

      - Handlers registered on the BLUEPRINT take precedence over those registered GLOBALLY on the application, assuming a blueprint is handling the request that raises the exception. However, the blueprint CANNOT HANDLE 404 routing errors because the 404 occurs at the ROUTING LEVEL before the blueprint can be determined.

## Logging

  - [Error Logging Tools - Application Errors — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/errorhandling/#error-logging-tools)

      - Sending error mails, even if just for critical ones, can become OVERWHELMING if enough users are hitting the error and log files are TYPICALLY NEVER LOOKED AT.

        This is why we recommend using Sentry for dealing with application errors. It’s available as an Open Source project on GitHub and is also available as a hosted version which you can try for free.

        Sentry AGGREGATES duplicate errors, captures the full stack trace and LOCAL VARIABLES for debugging, and sends you mails based on NEW ERRORS or FREQUENCY THRESHOLDS.

        就像是 server-side application 的 HockeyApp / App Center。

      - To use Sentry you need to install the `raven` client with extra `flask` dependencies:

            $ pip install raven[flask]

        And then add this to your Flask app:

            from raven.contrib.flask import Sentry
            sentry = Sentry(app, dsn='YOUR_DSN_HERE')

        Or if you are using factories you can also init it later:

            from raven.contrib.flask import Sentry
            sentry = Sentry(dsn='YOUR_DSN_HERE')

            def create_app():
                app = Flask(__name__)
                sentry.init_app(app)
                ...
                return app

        The `YOUR_DSN_HERE` value needs to be replaced with the DSN value ?? you get from your Sentry installation.

        猜想 `sentry.init_app(app)` 會在 application object 裡註冊 error handler，再往 Sentry 送?

      - Afterwards failures are automatically reported to Sentry and from there you can receive error notifications.

  - [Email Errors to Admins - Logging — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/logging/#email-errors-to-admins) #ril

## 參考資料 {: #reference }

相關：

  - Error logging 官方文件建議用 [Sentry](sentry.md)

手冊：

  - [`flask.Flask.errorhandler(code_or_exception)`](http://flask.pocoo.org/docs/1.0/api/#flask.Flask.errorhandler)
  - [`flask.Flask.register_error_handler(code_or_exception, f)`](http://flask.pocoo.org/docs/1.0/api/#flask.Flask.register_error_handler)
