# Flask-SQLAlchemy

  - Flask-SQLAlchemy 做為 Flask 的 extension，使能在 Flask 裡輕鬆使用 SQLAlchemy 0.8+。

參考資料：

  - Flask-SQLAlchemy — Flask-SQLAlchemy Documentation (2.3) http://flask-sqlalchemy.pocoo.org/2.3/
  - Object Relational Tutorial — SQLAlchemy 1.2 Documentation http://docs.sqlalchemy.org/en/latest/orm/tutorial.html Session Lifecycle Patterns 提到 `Session` instance 的產生時機會因應用類型而異，而 Flask-SQLAlchemy 就是將 session lifecycle 整合進 Flask application 的 callback?
  - Flask-SQLAlchemy — Flask-SQLAlchemy Documentation (2.3) http://flask-sqlalchemy.pocoo.org/2.3/ 提到 "providing useful defaults and extra helpers"，指的是哪些?

## db.session ??

  - [Quickstart — Flask\-SQLAlchemy Documentation \(2\.3\)](http://flask-sqlalchemy.pocoo.org/2.3/quickstart/)
      - 提到 `db = SQLAlchemy(app)` (傳 `app` 進去，應該是 `app.config[...]` 取組態的慣例) 及 `db.session.commit()` 的用法
      - Road to Enlightenment 提到 "a preconfigured scoped session called session"，還強調 "don’t have to remove it at the end of the request, Flask-SQLAlchemy does that for you"，只要做 commit 就好 => 向 Flask 註冊 teardown function。
  - [create_scoped_session(options=None) - API — Flask\-SQLAlchemy Documentation \(2\.3\)](http://flask-sqlalchemy.pocoo.org/2.3/api/#flask_sqlalchemy.SQLAlchemy.create_scoped_session) 預設會利用的 Flask 的 app context stack identity 確保 `scoped_session` 會在進出 request/response cycle 時自動建立/刪除。
  - [flask\-sqlalchemy/\_\_init\_\_\.py at master · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/blob/master/flask_sqlalchemy/__init__.py#L801) 在 `init_app()` 裡利用 `@app.teardown_appcontext` 向 app 註冊 teardown function，如果有設定 `SQLALCHEMY_COMMIT_ON_TEARDOWN` 會先 commit (沒有錯誤的話)，再呼叫 `session.remove()`；為什麼有 exception 時不做 rollback? => `Session.remove()` 內部會做 rollback。
  - [teardown_appcontext(f) - API — Flask Documentation \(0\.12\)](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.teardown_appcontext)
      - 註冊一個在 application context 結束時會被呼叫的 function，但又補上一句 "These functions are TYPICALLY also called when the request context is popped" 是什麼意思?
      - "Since a request context typically also manages an application context it would also be called when you pop a request context." 這句話是說 request context 結束時也會呼叫? => 實驗發現，appcontext 或 request teardown function 在 request 結束時都會被呼叫，其間有什麼差異??
  - [remove() - Contextual/Thread\-local Sessions — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/contextual.html#sqlalchemy.orm.scoping.scoped_session.remove) `Session.remove()` 除了呼叫 `Session.close()` 及釋放 transactional/connection resource，特別提到 "transactions specifically are rolled back"。

## 如何入門 Flask-SQLAlchemy?

  - Quickstart — Flask-SQLAlchemy Documentation (2.3) http://flask-sqlalchemy.pocoo.org/2.3/quickstart/ #ril

## SQLAlchemy(metadata=None) 的用法??

  - 之前同事用另一個 subproject 定義 model，搭配 Flask-SQLAlchemy 使用；平常 application 執行沒問題，但 testing 時 model 無法跟 Flask-SQLAlchemy 的 `app.db.Model` 串起來，導致 `app.db.create_all()` 無效? 為什麼平常沒問題，測試期間就有問題? 後來同事將 `db = SQLAlchemy(app)` 改為 `db = SQLAlchemy(app, metadata=Base.metadata)` 即可。
  - [class flask_sqlalchemy.SQLAlchemy - API — Flask\-SQLAlchemy Documentation \(2\.3\)](http://flask-sqlalchemy.pocoo.org/2.3/api/#flask_sqlalchemy.SQLAlchemy) v2.1 才加上 `metadata` 參數 -- The metadata associated with db.Model。
  - 問題跟 metadata 有關是確定的，例如 [Object Relational Tutorial — SQLAlchemy](http://docs.sqlalchemy.org/en/latest/orm/tutorial.html) 就有提到 `MetaData.create_all()`

## Isolation Level ??

  - [changing isolation level · Issue \#120 · pallets/flask\-sqlalchemy](https://github.com/pallets/flask-sqlalchemy/issues/120) #ril
  - [Flask\-SQLAlchemy set per request isolation level](https://gist.github.com/robyoung/68e2121c045f117bea78) #ril

## 疑難排解 {: #troubleshooting }

### MySQL server has gone away

[Road to Enlightment - Flask-SQLAlchemy](http://flask-sqlalchemy.pocoo.org/2.3/quickstart/#road-to-enlightenment) 提到：

> You have to commit the session, but you don’t have to remove it at the end of the request, Flask-SQLAlchemy does that for you.

原來 [`SQLAlchemy.init_app()`](https://github.com/mitsuhiko/flask-sqlalchemy/blob/master/flask_sqlalchemy/__init__.py#L801) 會利用 `@app.teardown_appcontext` 向 app 註冊 teardown function，如果有設定 `SQLALCHEMY_COMMIT_ON_TEARDOWN` 會先 commit (沒有錯誤的話)，再呼叫 `session.remove()` (內部會做 rollback)。

```
@app.teardown_appcontext
def shutdown_session(response_or_exc):
    if app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN']:
        if response_or_exc is None:
            self.session.commit()

    self.session.remove()
    return response_or_exc
```

實驗確認 app context 的 teardown function 會在每個 request 結束時被呼叫，就像[文件](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.teardown_appcontext)上所宣稱的：

> Registers a function to be called when the application context ends. These functions are TYPICALLY also called when the request context is popped.

到這裡，我們可以排除因為沒有明確呼叫 `Session.close()` 導致 connection 沒有回到 connection pool 的可能性，因為 Flask-SQLAlchemy 會自動處理。問題回到，若是與 MySQL 間的連線真的這麼不穩定 (為什麼不穩定要另外找)，我們能怎麼做？

面對 pool 裡的 connection 可能失效 (stale) 的問題，[SQLAlchemy 支援 Pessimistic (悲觀) 與 Optimistic (樂觀) 兩種策略](http://docs.sqlalchemy.org/en/latest/core/pooling.html#dealing-with-disconnects)。所謂悲觀是指 "不看好連線穩定"，所以要從 pool 拿出 (checkout) connection 前，會先送出一個 test statement 以確定 connection 是有用的 (viable)，這個動作稱做 [pre ping](http://docs.sqlalchemy.org/en/latest/core/pooling.html#sqlalchemy.pool.Pool.params.pre_ping) (SQLAlchemy 1.2+)。雖然 pre ping 會對 checkout process 增加一些 overhead，但這是最簡單且可以完全排除拿到 stale pooled connection 的方法，應用端也不用擔心如何從 stale connection 回復的問題。

不過很不幸地，[Flask-SQLAlchemy 尚不支援 pre ping 的做法](https://github.com/mitsuhiko/flask-sqlalchemy/pull/600)，所以只能退而使用相對樂觀的策略 -- [Pool Recycle](http://docs.sqlalchemy.org/en/latest/core/pooling.html#setting-pool-recycle)。按照 [Flask-SQLAlchemy 官方文件](http://flask-sqlalchemy.pocoo.org/2.3/config/)的說法，遇到 MySQL 時會自動將 `SQLALCHEMY_POOL_RECYCLE` 設定成 2hr，雖然這低於 MySQL `wait_time` 預設的 8hr，若是 MySQL 的連線不穩定 (未超過 [`wait_timeout`](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_wait_timeout) 就中斷)，2hr 的設定就顯得有點長，設成每 5 分鐘 recycle 一次似乎也沒什麼不妥。

---

後來在 [Provide a way to configure the SA engine · Issue \#589 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/issues/589#issuecomment-361075700) 的對話中找到了解法 -- 覆寫 `flask_sqlalchemy.SQLAlchemy.apply_pool_defaults()` 並強制加上 `pool_pre_ping` 參數即可：

```
from flask_sqlalchemy import SQLAlchemy as SA

class SQLAlchemy(SA):
    def apply_pool_defaults(self, app, options):
        SA.apply_pool_defaults(self, app, options)
        options["pool_pre_ping"] = True

db = SQLAlchemy()
```

參考資料：

  - [add possibility to set pool\_pre\_ping in configuration by maximilianredt · Pull Request \#600 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/pull/600) 已經有人提出 `pool_pre_ping` 的支援，但 PR 還沒過 #ril
      - [Add SQLALCHEMY\_POOL\_PRE\_PING config by pigletfly · Pull Request \#577 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/pull/577) PR 最後被 close 了!? gilbsgilbs: 在 #589 中已經有解法。
  - [Provide a way to configure the SA engine · Issue \#589 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/issues/589#issuecomment-361075700) #ril

```
from flask_sqlalchemy import SQLAlchemy as SA

class SQLAlchemy(SA):
    def apply_pool_defaults(self, app, options):
        SA.apply_pool_defaults(self, app, options)
        options["pool_pre_ping"] = True

db = SQLAlchemy()
```

      - [flask\-sqlalchemy/\_\_init\_\_\.py at 50944e77522d4aa005fc3c833b5a2042280686d3 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/blob/50944e77522d4aa005fc3c833b5a2042280686d3/flask_sqlalchemy/__init__.py#L814) 按照 `_EngineConnector.get_engine()` 的實作，會先後呼叫 `SQLAlchemy.apply_pool_defaults()` 與 `SQLAlchemy.apply_driver_hacks()` 更新準備傳給 `create_engine()` 的 options -- `self._engine = rv = sqlalchemy.create_engine(info, **options)`。

  - [Support additional SQLAlchemy parameters\. by yangbaepark · Pull Request \#540 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/pull/540) 這個 PR 更全面地在討論傳更多的參數給背後的 SQLAlchemy，也包含 `pool_pre_ping`，但討論不太活躍 #ril
  - [Java\-Jersey 到 Python\-Flask 服務不中斷重構之旅](https://www.slideshare.net/maxcclai/javajersey-pythonflask) p21. Flask-SQLAlchemy 佈置上線後 你會看到 (OperationError) (2006, 'MySQL server has gone away') (2018-05-31)
      - 解法 1: `create_engine(mysql_db_url, pool_recycle=3600)` 縮短 pool recycle 時間，還是會出問題。
      - 解法 2: 每次操作前先做一次 connection test，例如 `SELECT 1`，而這就是 SQLAlchemy 1.2 新增的 `create_engine(..., pool_pre_ping=True)`。
  - [Avoiding "MySQL server has gone away" on infrequently used Python / Flask server with SQLAlchemy \- Stack Overflow](https://stackoverflow.com/questions/6471549/) 幾天才會存取一次，但第一次存取時會有 "MySQL server has gone away" 的錯誤，接下來又沒問題... #ril
  - [MySQL server has gone away error using db\.session · Issue \#449 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/issues/449) #ril
  - [SQL Alchemy MySQL Server has Gone away · Issue \#235 · mattupstate/flask\-security](https://github.com/mattupstate/flask-security/issues/235) #ril
  - [Getting this error daily: "SQLError: \(OperationalError\) \(2006, ‘MySQL server has gone away’\)" · Issue \#2 · mitsuhiko/flask\-sqlalchemy](https://github.com/mitsuhiko/flask-sqlalchemy/issues/2) #ril
      - aaront: 因為是 office intranet，發生在 8hr 沒有活動之後，每天都會。
      - mitsuhiko (owner): 因為 MySQL 預設為 PHP 組態 -- 常忘了關閉連線? 會為 MySQL 自動啟用 connection recycling；[判斷到 driver name 以 `mysql` 開頭時，自動加上 `pool_size = 10` 及 `pool_recycle = 7200` 的設定](https://github.com/mitsuhiko/flask-sqlalchemy/blob/2.1/flask_sqlalchemy/__init__.py#L846)
      - 2013-08-29 rawrgulmuffins、pakdev、nullzero 等又陸續遇到相同的問題，louking: 若 commit 失敗一定要做 rollback? 不過後來又說 `SQLALCHEMY_POOL_RECYCLE` 要小於 MySQL 的 `interactive_timeout` (應該是 `wait_timeout` 才對)
  - [Add support for MySQL connection recycling · Issue \#239 · coleifer/peewee](https://github.com/coleifer/peewee/issues/239) 跟 `threadlocals=True`? #ril
  - [python \- OperationalError: MySQL Connection not available \- Stack Overflow](https://stackoverflow.com/questions/19052973/) #ril
  - [SqlAlchemy: SQLError: \(OperationalError\) \(2006, ‘MySQL server has gone away’\) \| RAPD](https://rapd.wordpress.com/2008/03/02/sqlalchemy-sqlerror-operationalerror-2006-mysql-server-has-gone-away/) `engine = create_engine(db_path, pool_size = 100, pool_recycle=7200)` 其中 `pool_recycle` 每 N seconds 就會重新建立連線，確保 MySQL 連線是有效的。
  - [Flask\-Sqlalchemy, closing the session : flask](https://www.reddit.com/r/flask/comments/2vbphd/flasksqlalchemy_closing_the_session/#cogyz27) commit 之後要 close 嗎? manychairs: tutorial 裡沒在 close session 的，但放上 production 就開始出現 `OperationalError: (OperationalError) (2006, 'MySQL server has gone away')` 的錯誤，尤其是在停了幾小時候。後來將 pool recycle 的時間調低，也在 query 或 commit 後加上 `db.session.close()`，就沒這個問題了。
  - [SQLAlchemy in Flask — Flask Documentation \(0\.12\)](http://flask.pocoo.org/docs/0.12/patterns/sqlalchemy/) 提到不論是不是 declarative，在 request 結束跟 application context 結束時都要做 remove/close session，這裡用 `db_session.remove()`。
  - [Contextual/Thread\-local Sessions — SQLAlchemy 1\.2 Documentation](http://docs.sqlalchemy.org/en/latest/orm/contextual.html) 提到 `scoped_session.remove()` 會先呼叫 `Session.close()` 再釋放 `Session` 自己，讓 connection 回到 pool #ril
  - [How to call session\.remove\(\) "on request end" for SQLAlchemy · Issue \#451 · jfinkels/flask\-restless](https://github.com/jfinkels/flask-restless/issues/451) 整理了 SQLAlchemy session 與 web framework 的整合要用到 scoped session #ril
  - [python \- How to close a SQLAlchemy session? \- Stack Overflow](https://stackoverflow.com/questions/21738944/how-to-close-a-sqlalchemy-session) `session.close()` 會讓 connetion 回到 pool，而 `engine.dispose()` 會關閉 poll 裡所有的 connection #ril

Flask-SQLAlchemy:

  - Getting this error daily: "SQLError: (OperationalError) (2006, ‘MySQL server has gone away’)" · Issue #2 · mitsuhiko/flask-sqlalchemy https://github.com/mitsuhiko/flask-sqlalchemy/issues/2 #ril
      - wim: SQLAlchemy v1.2.0+ 支援 connection pool pre-ping - 從 pool 拿出 connection 時會先檢查 liveness，若已經中斷就會回收，這樣就不需要 `pool_recycle` flag，或是 restart DB 造成的斷線；不過 SQLAlchemy 1.2.x 在 2017-07-24 還處於 pre-release。
      - omerk: 提到 `app.config['SQLALCHEMY_POOL_RECYCLE'] = 280` 的用法。
  - Python SQLAlchemy - "MySQL server has gone away" - Stack Overflow https://stackoverflow.com/questions/18054225/ #ril
  - Using SQLAlchemy with MySQL | PythonAnywhere help http://help.pythonanywhere.com/pages/UsingSQLAlchemywithMySQL #ril
  - Configuration — Flask-SQLAlchemy Documentation (2.1) http://flask-sqlalchemy.pocoo.org/2.1/config/ 提到 `SQLALCHEMY_POOL_RECYCLE` #ril

## 參考資料 {: #reference }

  - [Flask-SQLAlchemy](http://flask-sqlalchemy.pocoo.org/)
  - [mitsuhiko/flask-sqlalchemy - GitHub](https://github.com/mitsuhiko/flask-sqlalchemy)

手冊：

  - [Flask-SQLAlchemy API](http://flask-sqlalchemy.pocoo.org/2.3/api/)
  - [`flask_sqlalchemy.SQLAlchemy`](http://flask-sqlalchemy.pocoo.org/2.3/api/#flask_sqlalchemy.SQLAlchemy)
  - [`flask_sqlalchemy.Model`](http://flask-sqlalchemy.pocoo.org/2.3/api/#flask_sqlalchemy.Model)

