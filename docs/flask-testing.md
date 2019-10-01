---
title: Flask / Testing
---
# [Flask](flask.md) / Testing

### Hello, World!

`myapp/hello/__init__.py`:

```
from flask import Blueprint

blueprint = Blueprint('hello', __name__, url_prefix='/hello')

@blueprint.route('/<somebody>')
def hello(somebody='World'):
    return 'Hello, %s!' % somebody
```

`tests/conftest.py`:

```
from myapp import create_app
import pytest

@pytest.fixture
def client():
    app = create_app()
    return app.test_client()
```

`tests/test_hello.py`:

```
def test_hello__somebody__hello_somebody(client):
    resp = client.get('/hello/Flask')
    assert resp.data == 'Hello, Flask!'
```

### 內建對 Testing 的支援??

  - [Testing Flask Applications — Flask Documentation \(0\.12\)](http://flask.pocoo.org/docs/0.12/testing/) #ril
      - Something that is untested is broken. 背後的問題在於 Untested applications make it HARD TO IMPROVE existing code
      - Flask 揭露了 Werkzeug 的 (test) `Client` (`app.test_client()`) 並自動處理 request context，在 test code 裡就能把它當 HTTP client 用。
      - 從範例看來 `Client.get()/post()` 有 `data`、`follow_redirects` 等 keyword arguments，但文件在哪呢?
  - [The Request Context — Flask Documentation \(0\.12\)](http://flask.pocoo.org/docs/0.12/reqcontext/) 解釋了 context locals，也就是 request context，以及如何在沒有 request 時 (例如 testing) 營造出 request context #ril
  - [test_client() - API — Flask Documentation \(0\.12\)](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.test_client) 提到要看 `flask.testing.FlaskClient` 的文件 #ril
  - [class flask.testing.FlaskClient - API — Flask Documentation \(0\.12\)](http://flask.pocoo.org/docs/0.12/api/#flask.testing.FlaskClient) 要看 `werkzeug.test.Client` 的文件 #ril
  - [Test Utilities — Werkzeug Documentation \(0\.14\)](http://werkzeug.pocoo.org/docs/0.14/test/) #ril
      - Werkzeug 提供一個 `Client` object (`werkzeug.test.Client`)，傳入 WSGI application (及非必要的 response wrapper)，就可以對它送 virtual request。
  - [class werkzeug.test.Client - Test Utilities — Werkzeug Documentation \(0\.14\)](http://werkzeug.pocoo.org/docs/0.14/test/#werkzeug.test.Client) `open()` 接受跟 `EnvironBuilder` 一樣的參數 #ril
  - [class werkzeug.test.EnvironBuilder - Test Utilities — Werkzeug Documentation \(0\.14\)](http://werkzeug.pocoo.org/docs/0.14/test/#werkzeug.test.EnvironBuilder) 終於看到 `query_string`、`data` 等參數 #ril
  - [python \- How can I fake request\.POST and GET params for unit testing in Flask? \- Stack Overflow](https://stackoverflow.com/questions/7428124/) #ril

## 參考資料

手冊：

  - [`flask.Flask.test_client()`](http://flask.pocoo.org/docs/0.12/api/#flask.Flask.test_client)
  - [class `flask.Response` - Flask Documentation](http://flask.pocoo.org/docs/0.12/api/#flask.Response)
  - [class `werkzeug.test.Client`](http://werkzeug.pocoo.org/docs/0.14/test/#werkzeug.test.Client)
  - [class `werkzeug.test.EnvironBuilder`](http://werkzeug.pocoo.org/docs/0.14/test/#werkzeug.test.EnvironBuilder)
