# Flask

  - [Welcome \| Flask (A Python Microframework)](http://flask.pocoo.org/)
      - 基於 Werkzeug 及 Jinja2 的 Python-based microframework；相容於 WSGI 1.0
      - 內建 development server 及 debugger，提供了 unit testing 的支援。
      - RESTful request dispatching -- 指 routing。
      - 支援 cookies (client side session)
  - [What Flask is, What Flask is Not - Design Decisions in Flask — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/design/#what-flask-is-what-flask-is-not) Flask 永遠不會有 database layer、form library 等，它只是橋接了 Werkzeug (WSGI application) 及 Jinja2 (templating)，其他的都是 extension，因為大家都有不同的需求。
  - [Deploy and scale Python & Django in the cloud \| Heroku](https://www.heroku.com/python) Choice of frameworks 提到 MVC web apps with Django, lightweight APIs with Flask, flexible apps with Pyramid, evented apps with Twisted and headless worker apps 似乎 Django、Flask、Pyramid, Twisted 有各自不同的定位，顯然 Flask 很適合用來寫 API。

## 跟 Werkzeug 的關係

  - [Installation — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/installation/) Werkzeug 實作了 WSGI，做為 application 與 web server 間的標準 Python interface。
  - [Welcome \| Flask (A Python Microframework)](http://flask.pocoo.org/) 基於 Werkzeug 及 Jinja2 的 Python-based microframework。

## 跟 Jinja2 的關係

  - [Welcome \| Flask (A Python Microframework)](http://flask.pocoo.org/) 基於 Werkzeug 及 Jinja2 的 Python-based microframework；拿 Jinja2 當 template engine。
  - [Installation — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/installation/) Jinja 是一種 template language，用來畫 (render) web pages；Jinja 會帶出 MarkupSafe -- 將 untrusted input 做 escape，避免 injection 攻擊。

## Hello, World! ??

`hello.py`:

```
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'
```

```
$ FLASK_APP=hello.py FLASK_DEBUG=1 flask run
$ curl http://127.0.0.1:5000/
Hello, World!
```

若採用 package 的話 (`hello/__init__.py`)，Flask 1.0 前要用：

```
$ FLASK_APP=hello/__init__.py FLASK_DEBUG=1 flask run
```

或

```
$ FLASK_APP=hello FLASK_DEBUG=1 python -m flask run
```

參考資料：

  - [Welcome to Flask — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/) #ril
  - [Quickstart — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/quickstart/) #ril
  - [Tutorial — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/tutorial/) #ril

## 新手上路 {: #getting-started }

  - 用 virtualenv 安裝 `Flask` 套件。
  - 跟著 Qucikstart 做過一遍。

參考資料：

  - Quickstart — Flask Documentation http://flask.pocoo.org/docs/latest/quickstart/ #ril
  - realpython/flask-skeleton: Real Python Flask Starter Project https://github.com/realpython/flask-skeleton #ril
  - Quickstart — Flask Documentation http://flask.pocoo.org/docs/quickstart/ #ril
  - http://flask.pocoo.org/docs/latest/ 學習路徑: 安裝 > Quickstart > Tutorial > Patterns
  - 為什麼 `app = Flask(__name__)` 會是這種用法?? 傳入的 `__name__` 說是 "the name of the application package" ...
  - 怎麼做 logging? => https://gist.github.com/ibeex/3257877 用 `app.logger.xxx()`
  - 什麼是 WSGI application?? 相關的工具的支援...
  - Tutorial — Flask Documentation http://flask.pocoo.org/docs/latest/tutorial/ 完整的範例 #ril
  - [Patterns for Flask — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/patterns/#patterns) #ril

## Routing ??

  - 什麼是 `path` converter?? 可以用在 rule 中間嗎? 又怎麼沒有 `bool` converter??

參考資料：

  - [Welcome \| Flask (A Python Microframework)](http://flask.pocoo.org/) 提到 RESTful request dispatching 就是 routing，但跟 RESTful 什麼關係??
  - [python \- Can Flask have optional URL parameters? \- Stack Overflow](https://stackoverflow.com/questions/14032066/) 宣告兩個 route，搭配 function 的 default value (可讀性比[官方文件](http://flask.pocoo.org/docs/0.12/api/#url-route-registrations)裡 `@app.route('/users/', defaults={'page': 1})` 的用法更高)；若一個 function 有多個 route，那 `url_for()` 怎麼用??

        @app.route('/<user_id>')
        @app.route('/<user_id>/<username>')
        def show(user_id, username='Anonymous'):
            return user_id + ':' + username

## Context Local ??

  - [Context Locals - Quickstart — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/quickstart/#context-locals)
      - Insider Information: If you want to understand how that works and how you can implement TESTS with context locals, read this section, otherwise just skip it. 跟測試有關??
      - Certain objects in Flask are GLOBAL objects, but not of the usual kind. These objects are actually PROXIES to objects that are LOCAL TO A SPECIFIC CONTEXT. What a mouthful. But that is actually quite easy to understand.
      - Imagine the context being the HANDLING THREAD. A request comes in and the web server decides to spawn a new thread (or something else, the underlying object is capable of dealing with concurrency systems other than threads). When Flask starts its internal request handling it figures out that the current thread is the active context and BINDS the current application and the WSGI environments to that context (thread). It does that in an intelligent way so that one application can INVOKE ANOTHER APPLICATION?? without breaking.
      - So what does this mean to you? Basically you can completely ignore that this is the case unless you are doing something like UNIT TESTING. You will notice that code which depends on a request object will suddenly break because there is no request object. The solution is creating a request object yourself and binding it to the context. The easiest solution for unit testing is to use the `test_request_context()` context manager. In combination with the `with` statement it will bind a test request so that you can interact with it. Here is an example:

            from flask import request

            with app.test_request_context('/hello', method='POST'):
                # now you can do something with the request until the
                # end of the with block, such as basic assertions:
                assert request.path == '/hello'
                assert request.method == 'POST'

        這跟 `Flask.test_client()` 是什麼關係?? 好像可以不用從 routing 這一層測試? 不過話說回來，離開 routing 這一層還跟 Flask 有相依，也是個問題...

      - The other possibility is passing a whole WSGI environment to the `request_context()` method: 直接模擬環境變數??

            from flask import request

            with app.request_context(environ):
                assert request.method == 'POST'

  - [Context Locals — Werkzeug Documentation \(0\.14\)](http://werkzeug.pocoo.org/docs/0.14/local/) #ril

## Request??

  - [Quickstart — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/quickstart/#accessing-request-data)
      - For web applications it’s crucial to react to the data a client sends to the server. In Flask this information is provided by the GLOBAL `request` object. If you have some experience with Python you might be wondering how that object can be global and how Flask manages to still be THREADSAFE. The answer is CONTEXT LOCALS:

    The Request Object

      - The request object is documented in the API section and we will not cover it here in detail (see `Request`). Here is a broad overview of some of the most common operations. First of all you have to import it from the `flask` module: `from flask import request`
      - The current request method is available by using the `method` attribute. To access form data (data transmitted in a POST or PUT request) you can use the `form` attribute. Here is a full example of the two attributes mentioned above:

            @app.route('/login', methods=['POST', 'GET'])
            def login():
                error = None
                if request.method == 'POST':
                    if valid_login(request.form['username'],
                                   request.form['password']):
                        return log_the_user_in(request.form['username']) # 裡面應該會實現 Redirect After Post
                    else:
                        error = 'Invalid username/password'
                # the code below is executed if the request method
                # was GET or the credentials were invalid
                return render_template('login.html', error=error)

      - What happens if the key does not exist in the `form` attribute? In that case a special `KeyError` is raised. You can catch it like a standard `KeyError` but if you don’t do that, a HTTP 400 Bad Request error page is shown instead. So for many situations you DON’T have to deal with that problem.
      - To access parameters submitted in the URL (`?key=value`) you can use the `args` attribute:

            searchword = request.args.get('key', '')

      - We recommend accessing URL parameters with `get` or by catching the `KeyError` because users might change the URL and presenting them a 400 bad request page in that case is NOT USER FRIENDLY.

        還是得看情況吧，如果必要的參數沒拿到，又沒有合理的預設值，回 400 也是很合理的?

      - For a full list of methods and attributes of the request object, head over to the `Request` documentation.

  - [The Request Context — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/reqcontext/) #ril
      - The request context keeps track of the REQUEST-LEVEL data during a request. Rather than passing the request object to each function that runs during a request, the `request` and `session` PROXIES are accessed instead.
      - This is similar to the The Application Context, which keeps track of the APPLICATION-LEVEL data independent of a request. A corresponding application context is PUSHED when a request context is pushed.

        關於 push/pop, context 要先看過下面 How the Context Works 才會懂，簡單的講 `request`、`session` 這些 proxy object 都參照 request/application context stack 最上方的 context 來決定 current request/application，所以 push/pop 的動作很關鍵。

    Purpose of the Context

      - When the `Flask` application handles a request, it creates a `Request` object based on the environment it received from the WSGI server. Because a WORKER (thread, process, or COROUTINE depending on the server) handles only one request at a time, the request data can be considered GLOBAL TO THAT WORKER during that request. Flask uses the term CONTEXT LOCAL for this.

        原來 worker 是這麼抽象，背後可能有不同的實作方式，但 worker 同時間只會面對一個 reqeust，這一點是肯定的。

      - Flask automatically pushes a request context when handling a request. View functions, error handlers, and other functions that run during a request will have access to the request proxy, which POINTS TO the request object for the current request.

    Lifetime of the Context

      - When a Flask application begins handling a request, it pushes a request context, which also pushes an The Application Context. When the request ends it pops the request context then the application context.
      - The context is unique to each thread (or other worker type). request cannot be passed to another thread, the other thread will have a different CONTEXT STACK and will not know about the request the PARENT THREAD?? was pointing to.
      - Context locals are implemented in Werkzeug. See [Context Locals](http://werkzeug.pocoo.org/docs/local/) for more information on how this works internally. 已經有 context，為何又要強調 local??

    ...

    How the Context Works

      - The `Flask.wsgi_app()` method is called to handle each request. It manages the contexts during the request. Internally, the request and application contexts work as STACKS, `_request_ctx_stack` and `_app_ctx_stack`. When contexts are PUSHED onto the stack, the proxies that depend on them are available and point at information from the TOP CONTEXT on the stack.

        難怪會有 push/pop 的說法，而且 request context 跟 application context 是兩個不同的 stack。

      - When the request starts, a `RequestContext` is created and pushed, which creates and pushes an `AppContext` FIRST if a context for that application is not already the top context. While these contexts are pushed, the `current_app`, `g`, `request`, and `session` proxies are available to the ORIGINAL THREAD handling the request.
      - After the request is dispatched and a response is generated and sent, the request context is popped, which then pops the application context. Immediately before they are popped, the `teardown_request()` and `teardown_appcontext()` functions are are executed. These execute EVEN IF an unhandled exception occurred during dispatch. 這 2 個 callback 都在 `flask.Flask` 上。

  - [class flask.request - API — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/api/#flask.request) 透過 `flask.request` (global) 可以拿到 active thread 的 request object (`flask.Request`)，事實上它是個 proxy (`werkzeug.local.LocalProxy`)。

  - [class flask.Request - API — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/api/#flask.Request) #ril
      - `form` 可以拿到 POST/PUT 的資料 (`MultiDict`)，但不含上傳的檔案 -- 檔案另外放在 `files`。
      - `args` 可以拿到 query string 的資料 (`MultiDict`)。
      - `values` 則可以同時拿到 `form` 跟 `args` 的資料 (`CombinedMultiDict`)，也就是資料從哪裡來不重要時。

  - 怎麼讀取 request data、URL query string?
      - 透過 [`flask.request`](http://flask.pocoo.org/docs/api/#flask.request)，型態是 [`flask.Request`](http://flask.pocoo.org/docs/api/#flask.Request)
      - Query string 可以透過 `flask.Request` 的 `args` 存取，例如 `flask.request.args['param']`。

## Response

  - View function 直接 return，不傳回任何東西，就是單純的 200 OK 嗎? 還是用 `abort(200)` 比較好?
      - 單純的 `return` (同 `return None`) 會引發 `ValueError: View function did not return a response` 的錯誤。
      - `abort(200)` 會引發 `LookupError: no exception for 200` 的錯誤。
      - 目前似乎只能回 `return ''` ??
  - Flask 裡怎麼先回應一些訊息，之後再透過 callback URL 再回一些?? 就算能把工作交出去，那之後結果要怎麼更新到前端??
      - http://stackoverflow.com/questions/12317667/ 用 Celery 或 Twisted，但需要搭配 external worker process；這會不會太小題大作了??
      - multithreading - How do I run a long-running job in the background in Python - Stack Overflow http://stackoverflow.com/questions/34321986/ "the route will return a url (using the guid) that the user can use to check progress." 這做法似乎不錯??
      - Celery Based Background Tasks — Flask Documentation http://flask.pocoo.org/docs/latest/patterns/celery/  官方的 pattern 也提到 Celery #ril

## Redirection ??

  - [Redirects and Errors - Quickstart — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/quickstart/#redirects-and-errors) #ril
  - [The Request Context — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/reqcontext/)
      - Because the contexts are stacks, other contexts may be pushed to CHANGE THE PROXIES DURING A REQUEST. While this is not a common pattern, it can be used in advanced applications to, for example, do INTERNAL REDIRECTS or chain different applications together. 怎麼達成 internal redirect??
  - [python \- Flask: redirect to same page after form submission \- Stack Overflow](https://stackoverflow.com/questions/41270855/) #ril

## Session ??

  - [Welcome \| Flask (A Python Microframework)](http://flask.pocoo.org/) 支援 cookies (client side session)
  - [Installation — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/installation/) ItsDangerous 可以做數位簽章 (signing)，Flask 用它來確保 session cookie 沒有被動過手腳 (integrity)。
  - [Sessions \| Flask (A Python Microframework)](http://flask.pocoo.org/snippets/category/sessions/) #ril
  - [Sessions - Quickstart — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/quickstart/#sessions) #ril
  - [class flask.session - API — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/api/#flask.session) #ril
  - http://flask.pocoo.org/docs/1.0/quickstart/                  #sessions
  - [實作 Flask Session Interface 將Session 資料存入資料庫 — 使用 FlaskSession套件](https://medium.com/pyladies-taiwan/95290b80b2ed) 使用 Flask-Session 後，cookie 裡只剩 session ID #ril

## RESTful ??

  - 可能的方案有 Flask-RESTful、Flask-RESTPlus、Connexion、Flasgger 等。
  - 提供 OAuth 驗證、產生 API 文件等，都是標準配備；目前好像只有 Connexion 內建支援 OAuth?

## Application Context ??

  - [The Application Context — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/appcontext/) #ril

## Proxy Object ??

  - [Note On Proxies - The Request Context — Flask 0\.12\.4 documentation](http://flask.pocoo.org/docs/0.12/reqcontext/#notes-on-proxies) #ril

## Development Server ??

  - [Welcome \| Flask (A Python Microframework)](http://flask.pocoo.org/) 提到內建 development server。
  - [Installation — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/installation/) Watchdog 提供更好的 reloader 讓 development server 使用。

## Debugger ??

  - [Welcome \| Flask (A Python Microframework)](http://flask.pocoo.org/) 提到內建 debugger。

## CLI (`flask`) ??

  - [Environment Variables From dotenv - Command Line Interface — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/cli/#environment-variables-from-dotenv) `.flaskenv` 放 public variables (例如 `FLASK_APP`)，而 `.env` 可以放 private variables，所以不該被放進 repository。 #ril
  - [Installation — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/installation/)
      - Click 可以用來寫 CLI，它提供了 `flask` command，還可以自訂其他 management command ??
      - python-dotenv 讓 `flask` command 支援 dotenv (`.env`)

## Template ??

  - [Step 7: The Templates — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/tutorial/templates/) #ril
  - [Templates — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/templating/) #ril

## Forms

參考資料：

  - [Form Validation with WTForms — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/patterns/wtforms/)
      - 為了處理 form data，很快就會讓 code 變得很難讀，WTForms 就是在解決這個問題；另外 feature 了 Flask-WTF
      - 首先要為 form 定義一個 class，不過這裡 "adding a separate module for the forms" 的建議似乎怪怪的?
      - Form 在 view function 裡用起來像是：

            @app.route('/register', methods=['GET', 'POST'])
            def register():
                form = RegistrationForm(request.form)
                if request.method == 'POST' and form.validate():
                    user = User(form.username.data, form.email.data,
                                form.password.data)
                    db_session.add(user)
                    flash('Thanks for registering')
                    return redirect(url_for('login'))
                return render_template('register.html', form=form)

      - 無論如何都將 `request.form` 傳入 form class (當 form 是 GET 送出時，要改用 `request.args`)；當  method 是 POST 時做驗證，是 GET (或驗證失敗時) 就拿去 render。
      - 驗證用 `validate()` (搭配 `request.method == 'POST' 的檢查，`validate_on_submit()` 是 Flask-WTF 加的)，取得個別欄位的資料用 `form.<NAME>`.data`。
      - 驗證成功會搭配 `redirect()` 轉向，若沒有成功則重新 render 一次；從這個角度來看，form 的 action 應該指向自己會比較好? 否則驗證失敗時 URL 會揭露一些原本沒打算讓 end user 看到的資訊，也可能被 bookmark??
      - 在 template 裡是用 field function (form.<NAME>()`) 畫出 form element。

  - [Rendering - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/fields.html#wtforms.fields.Field.__call__) To render a field, simply call it, providing any values the widget expects as keyword arguments. 好特別的設定，通常 keyword arguments 對應到其他的 HTML attributes

## Shell??

  - [Working with the Shell — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/shell/) #ril

## 用 `flask run` 取代 `Flask.run()` ??

  - [Development Server — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/server/) #ril
  - [python \- Why is flask CLI recommended over Flask\.run? \- Software Engineering Stack Exchange](https://softwareengineering.stackexchange.com/questions/326517/) #ril

## 如何打包成 Docker image??

  - [Get Started, Part 2: Containers \| Docker Documentation](https://docs.docker.com/get-started/part2/) 以 Flask 做為範例 #ril
  - [Dockerize Simple Flask App — Container Tutorials](http://containertutorials.com/docker-compose/flask-simple-app.html) #ril

## 如何用 uWSGI 啟動 app?

  - uWSGI 是 Flask/WSGI application 跟 full-featured web server (例如 nginx、lighttpd 等) 介接的方式之一，uWSGI server 跟 web server 間是走 uwsgi protocol (小寫)，在 Unix-like 上通常透過 socket 溝通；uWSGI server 會調用 application module/package 的 WSGI callable (`Flask`)。

        uwsgi --socket /tmp/yourapplication.sock --virtualenv venv \
              --manage-script-name --mount /path=yourapplication:app \
              --workers 4 --threads 4

        location = /yourapplication { rewrite ^ /yourapplication/; }
        location /yourapplication { try_files $uri @yourapplication; }
        location @yourapplication {
          include uwsgi_params;
          uwsgi_pass unix:/tmp/yourapplication.sock;
        }

  - 在 staging 環境，則可以搭配 `FLASK_DEBUG=1` 與 `--catch-exceptions` 印出 backtrace：(若要在 uWSGI 下啟用 interactive debugger，要另外處理，跟 `--catch-exceptions` 無關)

        FLASK_DEBUG=1 \
        uwsgi --socket /tmp/yourapplication.sock --virtualenv venv \
              --manage-script-name --mount /path=yourapplication:app \
              --workers 4 --threads 4 \
              --catch-exceptions

  - 在本地端開發，也可以用 uWSGI 來模擬 staging/production 的環境，例如：(注意 `--no-default-app` 可以避免 app 在 `/` 服務，跟 staging/production 不同，可能無法及早發覺某些錯誤)

        FLASK_DEBUG=1 \
        uwsgi --http 127.0.0.1:5000 --virtualenv venv \
              --manage-script-name --mount /path=yourapplication:app \
              --workers 4 --threads 4 \
              --catch-exceptions --no-default-app

參考資料：

  - uWSGI — Flask Documentation (0.12) http://flask.pocoo.org/docs/0.12/deploying/uwsgi/ 橋接 web server 與 WSGI application (通常走 socket)，支援 uwsgi、HTTP 等不同 protocol，也直接支援 virtual environment。
  - Native HTTP support — uWSGI 2.0 documentation http://uwsgi-docs.readthedocs.io/en/latest/HTTP.html `--http <address>:<port>` 可以做為 HTTP server。

## 大型應用程式用 application package 比較好?

  - 用 application package (而非 application module)，底下可以拆分成多個 module；不過 `FLASK_APP=package_name` 的用法，必須要 "安裝" 過才行，還好 `pip install -e .` (搭配 `setup.py`) 可以安裝成 edit mode，開發時期修改程式會自動 reload 不成問題。
  - 但用一個 startup module 帶出 package 不也是一樣? 而且不用安裝，搭配 blueprint 一樣可以把 route 拆到不同的 component。

參考資料：

  - Larger Applications — Flask Documentation (0.12) http://flask.pocoo.org/docs/0.12/patterns/packages/ 說明 "For larger applications it’s a good idea to use a package instead of a module."
  - Modular Applications with Blueprints — Flask Documentation (0.12) http://flask.pocoo.org/docs/0.12/blueprints/ #ril

## 疑難排解 {: #troubleshooting }

### Error: The file/path provided (xxx) does not appear to exist.

Flask 0.11 後，執行 development server 建議執行 `flask run`，搭配 `FLASK_APP` 指向 Python module 以取得 application object。

```
$ FLASK_APP=myapp flask run # 假如單純是個 module
$ FLASK_APP=myapp flask run # 假如複雜一點是個 package (myapp/__init__.py)
```

第二種狀況會遇到下面的錯誤：

```
Error: The file/path provided (myapp) does not appear to exist.  Please verify the path is correct.  If app is not on PYTHONPATH, ensure the extension is .py
```

雖然 [Larger Applications](http://flask.pocoo.org/docs/0.12/patterns/packages/) 說採用 package 時要用 `pip install --editable .` 安裝過才行，但追查過 [`flask/cli.py`](https://github.com/pallets/flask/blob/0.12.2/flask/cli.py#L58)，發現 `FLASK_APP=myapp/__init__.py flask run` 的寫法也可以，或是改用 `FLASK_APP=myapp python -m flask run`。

這項限制已在 [PR #2414](https://github.com/pallets/flask/pull/2414) 處理掉，但要 Flask 1.0 才會釋出。

參考資料：

  - [Issue using Flask CLI with module layout recommended in Large Applications · Issue \#1847 · pallets/flask](https://github.com/pallets/flask/issues/1847) #ril
  - [Creating a .wsgi file - mod\_wsgi (Apache) — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/deploying/mod_wsgi/#creating-a-wsgi-file) `.wsgi` file 只是用來取得 application object 的 Python module (跟採用 module/package 結構無關)
  - [Command Line Interface — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/cli/) Flask 0.11 開始提供 `flask` CLI，提到特殊情況下可用 `python -m flask` 效果一樣。`FLASK_APP` 可以是 import path 或 "a filename of a Python module"
  - [python \- How to run Flask app as a package in PyCharm \- Stack Overflow](https://stackoverflow.com/questions/45741800/) Flask 1.0 之前，必須將 `FLASK_APP` 指向 `/path/to/flask_app/__init__.py`。比較好的方式是安裝 package，然後將 `FLASK_APP` 指向 package name，開發時可用 `pip install -e .`。
  - [FLASK\_APP doesn't require \.py extension for local packages by davidism · Pull Request \#2414 · pallets/flask](https://github.com/pallets/flask/pull/2414) 明確指出 "This drops the requirement where FLASK_APP had to point to a .py file for packages that were not installed in develop mode. If the file is not importable, it will fail later in the loading process." 不過要 1.0 才有。
  - [Step 3: Installing flaskr as a Package — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/tutorial/packaging/) 也是要先安裝過 `pip install --editable .` 才能執行 `flask run`。
  - [Larger Applications — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/patterns/packages/) 大型 app 用 package，但要用 `pip install -e .` 安裝過。

```
$ flask --version
Flask 0.12.2
Python 2.7.10 (default, Jul 15 2017, 17:16:57)
[GCC 4.2.1 Compatible Apple LLVM 9.0.0 (clang-900.0.31)]
```

`bin/flask`:

```
# -*- coding: utf-8 -*-
import re
import sys

from flask.cli import main

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(main())
```

`lib/python2.7/site-packages/flask/cli.py`:

```
def prepare_exec_for_file(filename):
    """Given a filename this will try to calculate the python path, add it
    to the search path and return the actual module name that is expected.
    """
    module = []

    # Chop off file extensions or package markers 原來也接受 package/__init__.py 的寫法
    if os.path.split(filename)[1] == '__init__.py':
        filename = os.path.dirname(filename)
    elif filename.endswith('.py'):
        filename = filename[:-3]
    else:
        raise NoAppException('The file provided (%s) does exist but is not a '
                             'valid Python file.  This means that it cannot '
                             'be used as application.  Please change the '
                             'extension to .py' % filename)
    filename = os.path.realpath(filename)

    # 往上找到沒有 `__init__.py` 的那一層
    dirpath = filename
    while 1:
        dirpath, extra = os.path.split(dirpath)
        module.append(extra)
        if not os.path.isfile(os.path.join(dirpath, '__init__.py')):
            break

    sys.path.insert(0, dirpath) # 調整 sys.path
    return '.'.join(module[::-1])

def locate_app(app_id):
    """Attempts to locate the application."""
    __traceback_hide__ = True
    if ':' in app_id:
        module, app_obj = app_id.split(':', 1)
    else:
        module = app_id
        app_obj = None

    # 這行可以看出 flask run 與 python -m flask run 的差異
    print "app_id = %r, cwd = %r, sys.path[:2] = %r" % (app_id, os.getcwd(), sys.path[:2])

    try:
        __import__(module)
    except ImportError:
        # Reraise the ImportError if it occurred within the imported module.
        # Determine this by checking whether the trace has a depth > 1.
        if sys.exc_info()[-1].tb_next:
            raise
        else:
            raise NoAppException('The file/path provided (%s) does not appear'
                                 ' to exist.  Please verify the path is '
                                 'correct.  If app is not on PYTHONPATH, '
                                 'ensure the extension is .py' % module)


    mod = sys.modules[module]
    if app_obj is None:
        app = find_best_app(mod) # 找 app 或 application 或型態為 Flask 者
    else:
        app = getattr(mod, app_obj, None)
        if app is None:
            raise RuntimeError('Failed to find application in module "%s"'
                               % module)

    return app

def find_default_import_path():
    app = os.environ.get('FLASK_APP')
    if app is None:
        return
    if os.path.isfile(app): # 是檔案才會調整 sys.path
        return prepare_exec_for_file(app)
    return app # 直接視為 module name
```

```
$ FLASK_APP=myapp flask run
app_id = 'myapp', cwd = '/Users/jeremykao/data/work/learning/flask/testing', sys.path[:2] = ['/Users/jeremykao/data/work/learning/flask/testing/venv-flask-testing/bin', '/Users/jeremykao/data/work/learning/flask/testing/venv-flask-testing/lib/python27.zip']
Usage: flask run [OPTIONS]

Error: The file/path provided (myapp) does not appear to exist.  Please verify the path is correct.  If app is not on PYTHONPATH, ensure the extension is .py

$ FLASK_APP=myapp python -m flask run
app_id = 'myapp', cwd = '/Users/jeremykao/data/work/learning/flask/testing', sys.path[:2] = ['', '/Users/jeremykao/data/work/learning/flask/testing/venv-flask-testing/lib/python27.zip']
  - Serving Flask app "myapp"
  - Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

`flask run` 與 `python -m flask run` 的差別在於 `sys.path[0]` 不同，不知道為什麼 `sys.path[0]` 會指向 `flask` 指令所在的目錄?

### 如何在 uWSGI 下啟用 interactive debugger?

  - `FLASK_DEBUG=1 flask run` 發生錯誤時會調出 interactive debugger，但同樣的 app 用 `uwsgi --module myapp:app` 啟用時，發生錯誤只會有 Internal Server Error? 大概是因為 `flask run` 會參考 `FLASK_DEBUG` 將 `app.debug` 設為 `True`，並啟用 interactive debugger 的關係?
  - `uwsgi --catch-exceptions` 搭配 `FLASK_DEBUG=1` (或在程式裡明確做 `app.debug = True`) 確實可以在出錯時看到 traeback，但卻沒有 interactive runner，猜想 `Flask` instance 內部會參考 `FLASK_DEBUG` 要不要寫出 traceback，但 interactive debugger 則是 `flask run` 啟用的。
  - 在程式裡加上下面的程式，並用 `UWSGI_DEBUG` 控制 (避免使用 `flask run` 時套用兩層 debugger)，就可以在 staging 環境用 `UWSGI_DEBUG=1 uwsgi ...` 啟用 app，出問題時可以直接 debug。

```
if os.getenv('UWSGI_DEBUG'):
    app.debug = True
    from werkzeug.debug import DebuggedApplication
    app.wsgi_app = DebuggedApplication(app.wsgi_app, evalex=True, pin_security=False)
```

參考資料：

  - python - Flask debug=True does not work when going through uWSGI - Stack Overflow https://stackoverflow.com/questions/10364854/ #ril
      - Edwardr: cannot use Flask's debug option with uWSGI, because it's not to be used in a forking environment. 呼應 [Quick Start](http://flask.pocoo.org/docs/0.12/quickstart/) 裡 "Even though the interactive debugger does not work in forking environments (which makes it nearly impossible to use on production servers)" 的說法；在 uWSGI 裡可以用 `--catch-exceptions` 模擬 debugger? (只是印出 traceback)
      - gonz: 那是 "werkzeug error page"，所以要用 `DebuggedApplication` middleware，另外 GaretJax 提到必須要用 single worker (`--workers 1`)? 試過多個 worker 倒是沒什麼問題

            from werkzeug.debug import DebuggedApplication
            app.wsgi_app = DebuggedApplication(app.wsgi_app, True)

  - Dubugging Flask applications under uWSGI (2012-10-28) https://codeseekah.com/2012/10/28/dubugging-flask-applications-under-uwsgi/ 不懂為什麼 Flask 的 debugger 在 uWSGI 下不能用? 這裡用 `if app.debug:` 來判斷要不要加上 `DebuggedApplication`，不過這仍會造成用 `flask run` 執行時有兩層 debugger。
  - web application - Flask debug=True exploitation - Information Security Stack Exchange https://security.stackexchange.com/questions/140677/ 出現 `DebuggedApplication(app, evalex=True, pin_security=False)` 的用法，原來 PIN 是可以關閉的。
  - Quickstart — Flask Documentation (0.12) http://flask.pocoo.org/docs/0.12/quickstart/ Even though the interactive debugger does not work in forking environments (which makes it nearly impossible to use on production servers) 好像有這麼回事? 上面 uWSGI 加上 `DebuggedApplication` 的做法，有時帶出的 debugger 是不太正常，但大部份時候又能作用 ...

### 如何將所有錯誤都導到 log 裡?

參考資料：

  - How to Handle Errors in Flask | Damyan's Blog (2015-06-11) https://damyanon.net/flask-series-logging/ 為 `app.logger` 增加一個 handler，另外也攔截了 500 error 與 unhandled exception #ril
  - Logging — Flask Documentation (0.13-dev) http://flask.pocoo.org/docs/dev/logging/ #ril
  - Application Errors — Flask Documentation (0.12) http://flask.pocoo.org/docs/0.12/errorhandling/ #ril
      - 提到 "By default if your application runs in production mode, Flask will display a very simple page for you and log the exception to the logger." 指的是 `app.logger`
  - log exceptions using app.logger · Issue #192 · pallets/flask https://github.com/pallets/flask/issues/192 #ril

### 如何用 pdb 為 Flask app 除錯?

  - The Flask Mega-Tutorial, Part XVI: Debugging, Testing and Profiling - miguelgrinberg.com (2013-03-10) https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-xvi-debugging-testing-and-profiling #ril
  - Debugging Flask app with pdb (2015-05-28) http://www.pythonforhumans.com/notes/debugging-flask-app-with-pdb #ril
  - python - Debugging flask with pdb - Stack Overflow https://stackoverflow.com/questions/26812150/ #ril
  - Flask: drop into pdb on exception https://gist.github.com/alonho/4389137 #ril
  - Python: Using pdb with Flask application - Stack Overflow https://stackoverflow.com/questions/15726340/ #ril

## JSON

  - 如何判斷 request 是 JSON，讀取 JSON 的內容? => 用 `flask.Request.is_json` 判斷 MIME type，用 `flask.Request.get_json()` 取得 JSON 資料。
  - 要如何回應 JSON??
      - python - How to return json using Flask web framework - Stack Overflow http://stackoverflow.com/questions/13081532/ 傳回 [`flask.jsonify(*args, **kwargs)`](http://flask.pocoo.org/docs/api/#flask.json.jsonify) 即可。
  - [Custom Flask JSONEncoder \| Flask (A Python Microframework)](http://flask.pocoo.org/snippets/119/) 覆寫 `Flask.json_encoder` #ril
  - [json_encoder - API — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/api/#flask.Flask.json_encoder) alias of `flask.json.JSONEncoder`，沒講覆寫它可以自訂??
  - [flask.json.jsonify() - API — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/api/#flask.json.jsonify) #ril
      - This function wraps `dumps()` to add a few enhancements that make life easier. It turns the JSON output into a `Response` object with the `application/json` mimetype.
  - [flask.json.dumps() - API — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/api/#flask.json.dumps) #ril
      - Serialize `obj` to a JSON formatted `str` by using the application’s configured encoder (`json_encoder`) if there is an application on the stack. 看起來改寫 `Flask.json_encoder` 是可以自訂 JSON encoder 的。
  - 為什麼 `flask.json.jsonify` 的範例都寫 `from flask import jsonify` ??

## 其他

### manage.py 的作用是什麼?

  - Flask-Script — Flask-Script 0.4.0 documentation https://flask-script.readthedocs.io/en/latest/ 源自這個專案，但 Flask 0.11 後已經內建 CLI tool，應該可以取代? #ril
  - Command Line Interface — Flask Documentation (0.12) http://flask.pocoo.org/docs/0.12/cli/ #ril

### 如何實作 DB schema migration?

參考資料：

  - miguelgrinberg/Flask-Migrate: SQLAlchemy database migrations for Flask applications using Alembic https://github.com/miguelgrinberg/Flask-Migrate 背後用 Alembic #ril
  - 常用的指令有 `./manage.py db upgrade head` 昇級到最新版。

### 如何測試 Flask 應用程式?

  - Testing Flask Applications — Flask Documentation http://flask.pocoo.org/docs/latest/testing/ #ril
  - `test_request_context()` 似乎可以用實作 unit testing??

## 安裝設定 {: #installation }

  - 建議用 virtualenv 安裝 `Flask` 套件，安裝完成有 `flask` 指令可以用。

參考資料：

  - Welcome | Flask (A Python Microframework) http://flask.pocoo.org/ `pip install Flask` 即可安裝。
  - [Installation — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/installation/)
      - 支援 Python 3.4+, Python 2.7 及 PyPy；建議採最新版的 Python 3
      - 會自動安裝 Werkzeug、Jinja、ItsDangerous 及 Clik，另外可以視需求安裝 Blinker、SimpleJSON、python-dotenv 及 Watchdog。
      - Werkzeug 實作了 WSGI，做為 application 與 web server 間的標準 Python interface。
      - Jinja 是一種 template language，用來畫 (render) web pages；Jinja 會帶出 MarkupSafe -- 將 untrusted input 做 escape，避免 injection 攻擊。
      - ItsDangerous 可以做數位簽章 (signing)，Flask 用它來確保 session cookie 沒有被動過手腳 (integrity)。
      - Click 可以用來寫 CLI，它提供了 `flask` command，還可以自訂其他 management command
      - Blinker 讓 Flask 支援 signal 的概念 ??
      - SimpleJSON 相容於 Python 內建的 `json` module，但是更快；[如果有安裝的話，Flask 會優先採用它](https://github.com/pallets/flask/blob/master/docs/api.rst#json-support)
      - python-dotenv 讓 `flask` command 支援 dotenv (`.env`)
      - Watchdog 提供更好的 reloader 讓 development server 使用。
      - 在 dev/prod 都建議用 virtual environment 管理 dependencies；Python 3 內建 `venv` module，Python 2 則要加裝 `virtualenv` 套件。
  - [Installation — Flask 0\.12\.4 documentation](http://flask.pocoo.org/docs/0.12/installation/) 支援 Python 2.6+ 與 Python 3，最快的方法 (kick-ass method) 是用 virtualenv。

## 參考資料 {: #reference }

  - [Flask](http://flask.pocoo.org/)
  - [pallets/flask - GitHub](https://github.com/pallets/flask)
  - [Flask - PyPI](https://pypi.org/project/Flask/)

書籍：

  - [Flask Blueprints - PACKT](https://www.packtpub.com/web-development/flask-blueprints) (2015-11)

更多：

  - [Template](flask-template.md)
  - [Uploading/Downloading](flask-uploading.md)
  - [Architecture](flask-arch.md)

手冊：

  - [Flask API](http://flask.pocoo.org/docs/api/)
      - [`flask.Flask`](http://flask.pocoo.org/docs/api/#flask.Flask)
      - [`flask.Request`](http://flask.pocoo.org/docs/api/#flask.Request)
      - [`flask.Response`](http://flask.pocoo.org/docs/api/#flask.Response)
      - [`flask.url_for()`](http://flask.pocoo.org/docs/api/#flask.url_for)
      - [`flask.jsonify()`](http://flask.pocoo.org/docs/api/#flask.json.jsonify)

