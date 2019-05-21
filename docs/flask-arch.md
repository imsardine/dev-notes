---
title: Flask / Architecture
---
# [Flask](flask.md) / Architecture

## Blueprint ??

  - [Modular Applications with Blueprints — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/blueprints/) #ril
      - 跟模組化有關；Flask 用 blueprint 來表現 application components，可以簡化 large application 的架構 -- 將 application 拆解成多個 blueprint；實務上可以生成一個 application object，然後初始化 extensions，再註冊 (register) blueprints。
      - "supporting common patterns within an application or across applications" 跟 "provide a central means for Flask extensions to register operations on applications" 不知道在說什麼?? 因為 [extensions](http://flask.pocoo.org/docs/1.0/extensions/) 完全沒提到 blueprint? 或許答案在 "Register a blueprint on an application for any of these cases when initializing a Flask extension." 這句話?
      - `Blueprint` 的運作方式很像 `Flask` (application object)，但並不是一個 application。
      - 一個 blueprint 可以用來提供 template filter、static files、templates、utilities，不一定要提供 view functions。
  - [Application Factories — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/patterns/appfactories/) `from yourapplication.views.admin import admin` 這種寫法看來，blueprint 是一種 view，不過這種 by layer 的切法好像不太優?

## Application Factory ??

  - [Application Factories — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/patterns/appfactories/) #ril
      - If you are already using packages and blueprints for your application there are a couple of really nice ways to further improve the experience. A common pattern is creating the application object WHEN THE BLUEPRINT IS IMPORTED. But if you move the creation of this object into a function, you can then CREATE MULTIPLE INSTANCES OF THIS APP LATER.

        為什麼有多個 application object 很重要? 因為 config/settings 都在 application object 上，下面提到的 extension object，在初始化時也會將設定記在 application object 上。

      - So why would you want to do this?
          - Testing. You can have instances of the application with different settings to test every case.
          - Multiple instances. Imagine you want to run different versions of the same application. Of course you could have multiple instances with different configs set up in your webserver, but if you use factories, you can have multiple instances of the same application running in the same application process which can be handy.

            不論是 same/different version，除了 testing 的考量，有多個 application instance 聽起來都很怪?

    Basic Factories

      - The idea is to set up the application in a function. Like this:

            def create_app(config_filename):
                app = Flask(__name__)
                app.config.from_pyfile(config_filename)

                from yourapplication.model import db
                db.init_app(app)

                from yourapplication.views.admin import admin
                from yourapplication.views.frontend import frontend
                app.register_blueprint(admin)
                app.register_blueprint(frontend)

                return app

        不過 blueprint 本身還是在 import time 就建立了，只有 application object 才是 factory method 被呼叫時才建立。

      - The downside is that you cannot use the application object in the blueprints at IMPORT TIME. You can however use it from within a request. How do you get access to the application with the config? Use `current_app`:

            from flask import current_app, Blueprint, render_template
            admin = Blueprint('admin', __name__, url_prefix='/admin')

            @admin.route('/')
            def index():
                return render_template(current_app.config['INDEX_TEMPLATE'])

    Factories & Extensions

      - It’s preferable to create your extensions and app factories so that the extension object does not INITIALLY GET BOUND TO the application. Using Flask-SQLAlchemy, as an example, you should not do something along those lines:

            def create_app(config_filename):
                app = Flask(__name__)
                app.config.from_pyfile(config_filename)

                db = SQLAlchemy(app)

        But, rather, in `model.py` (or equivalent):

            db = SQLAlchemy()

        and in your `application.py` (or equivalent):

            def create_app(config_filename):
                app = Flask(__name__)
                app.config.from_pyfile(config_filename)

                from yourapplication.model import db
                db.init_app(app)

      - Using this design pattern, no application-specific state is stored on the extension object, so one extension object can be USED FOR MULTIPLE APPS.

        不懂為何共用 extension object 那麼重要? 況且 multiple apps 的應用並不常見?

        研究 Flask-SQLAlchemy 下 [`SQLAlchemy.__init__(app)`](https://github.com/pallets/flask-sqlalchemy/blob/2.3.2/flask_sqlalchemy/__init__.py#L671) 與 [`SQLAlchemy.init_app(app)`](https://github.com/pallets/flask-sqlalchemy/blob/2.3.2/flask_sqlalchemy/__init__.py#L763) 的實作細節，發現 `__init__(app)` 裡只有 `self.app = app` 這一行跟特定 application object 綁定，而 `SQLAlchemy.init_app(app)` 大部份的邏輯都在設定 `app.config` 的預設值。

        之後看到 [Extension Code - Flask Extension Development — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/extensiondev/#the-extension-code) 一切都懂了：

            def init_app(self, app):
                app.config.setdefault('SQLITE3_DATABASE', ':memory:')
                app.teardown_appcontext(self.teardown)

            def connect(self):
                return sqlite3.connect(current_app.config['SQLITE3_DATABASE'])

        原來是 `app.config` 寫入、再由 `current_app.config` 讀出；這樣的搭配手法，總覺得很有問題?? 不過這畢竟是 Flask extension 的慣例，可以兼顧 convention 跟 testability 最好。

  - 以 Flask 而言，為了減少 [lazy-initialization](http://flask.pocoo.org/docs/0.12/patterns/appfactories/#factories-extensions)，讓 object 不會一開始處於 uninitialized 的狀態，可以考慮在 `wsgi.py` 做 wiring，在 `app` module 建立 singleton (`app.db = SQLAlchemy(flask_app)`)，其他要引用這個 singleton 的人，可以在 function 裡動態引用 `from app import db`，這樣測試期間，只要換掉 `app.db` 即可。

