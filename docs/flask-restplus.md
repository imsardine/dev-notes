# Flask-RESTPlus

  - [Welcome to Flask\-RESTPlus’s documentation\! — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/) #ril
      - 是個 Flask extension，幫助快速建立 REST APIs。本身鼓勵 best practices with minimal setup，提供許多 decorators/tools 用來描述 API，並揭露 API 文件 (背後用 Swagger UI)。

## 新手上路 {: #getting-started }

  - [Quick start — Flask\-RESTPlus 0\.10\.1 documentation](http://flask-restplus.readthedocs.io/en/stable/quickstart.html) #ril
      - `from flask_restplus import Api`，如同其他 extension，可以一開始就給 application object (`api = Api(app)`)，也可以事後再給 (`api.init_app(app)`)

```
from flask import Flask
from flask_restplus import Resource, Api

app = Flask(__name__)
api = Api(app)

@api.route('/hello')
class HelloWorld(Resource): # resourceful routing 對象是 class
    def get(self):
        return {'hello': 'world'} # 預設 content type 採 application/json

if __name__ == '__main__':
    app.run(debug=True)
```

      - 實驗確認，若是採用 `app.route()` 而非 `api.route()`，`return {'hello': 'world'}` 會丟出 `TypeError: 'dict' object is not callable` 的錯誤，而且 content type 是 `text/html` 而不是 `application/json`。
      - 預設會在 API root 產生 Swagger UI 文件，以這個例子而言是 http://127.0.0.1:5000/
      - Flask-RESTPlus 主要的 building block 是 resource -- 基於 Flask 的 [plugable view](http://flask.pocoo.org/docs/1.0/views/) (based on classes instead of functions)，只要定義 (view/resource) class 的不同 method，就能實作不同的 HTTP methods，例如：

```
from flask import Flask, request
from flask_restplus import Resource, Api

app = Flask(__name__)
api = Api(app)

todos = {}

@api.route('/<string:todo_id>')
class TodoSimple(Resource):
    def get(self, todo_id):
        return {todo_id: todos[todo_id]}

    def put(self, todo_id):
        todos[todo_id] = request.form['data']
        return {todo_id: todos[todo_id]}

if __name__ == '__main__':
    app.run(debug=True)
```

  - [Full example — Flask\-RESTPlus 0\.10\.1 documentation](http://flask-restplus.readthedocs.io/en/stable/example.html) #ril

## Request Parsing ??

  - [Request Parsing — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/parsing.html) #ril
      - Argument Locations 提到，可以限定 value 來自 POST body、query string、header、cookie 或是 uploads
  - [API — Flask\-RESTPlus 0\.10\.1 documentation](http://flask-restplus.readthedocs.io/en/stable/api.html#flask_restplus.reqparse.Argument) 雖說 `type` 是 "type to which the request argument should be converted"，但實際上可以是 function，若轉換/檢查的過程丟出 exception，就會回傳 error message #ril

## Response Marshalling ??

  - [Response marshalling — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/marshalling.html) #ril

## Versioning ??

  - [Multiple APIs with reusable namespaces - Scaling your project — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/scaling.html#multiple-apis-with-reusable-namespaces) #ril

## OAuth ??

  - [Documenting authorizations - Swagger documentation — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/swagger.html#documenting-authorizations) #ril
  - [How to Use Token Based Authentication in Flask\-RESTPlus \- YouTube](https://www.youtube.com/watch?v=xF30i_A6cRw) #ril
  - [frol/flask\-restplus\-server\-example: Real\-life RESTful server example on Flask\-RESTplus](https://github.com/frol/flask-restplus-server-example) 提到 oahthlib #ril
  - [OAuth2 password credential doesn't work in SwaggerUI · Issue \#138 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/138) 出現 `@oauth.require_oauth('member:read')` 的用法 #ril
  - [Flask\-OAuthlib — Flask\-OAuthlib 0\.9\.5 documentation](https://flask-oauthlib.readthedocs.io/en/latest/) #irl

## 如何自動產生 API 文件?

  - Building beautiful REST APIs using Flask, Swagger UI and Flask-RESTPlus - Michał Karzyński http://michal.karzynski.pl/blog/2016/06/19/building-beautiful-restful-apis-using-flask-swagger-ui-flask-restplus/ 支持 Markdown? #ril

## 安裝設定 {: #installation }

```
$ pip install flask-restplus
$ pip install enum34 # Python 2.7
```

參考資料：

  - [Installation - Welcome to Flask\-RESTPlus’s documentation\! — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/#installation) 安裝 `flask-restplus` 套件，支援 Python 2.7+
  - [Installation — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/installation.html) 支持 Python 2.7, 3.3+ 及 PyPy、PyPy3。
  - 在 Python 2.7 下執行，會出現 "ImportError: cannot import name IntEnum" 的錯誤，加裝 `enum34` 套件即可。

## 參考資料 {: #reference }

  - [Flask-RESTPlus Documentation](http://flask-restplus.readthedocs.io/)
  - [noirbizarre/flask-restplus - GitHub](https://github.com/noirbizarre/flask-restplus)

手冊：

  - [Changelog](http://flask-restplus.readthedocs.io/en/stable/changelog.html)
  - [API Documentation](http://flask-restplus.readthedocs.io/en/stable/api.html)
