# Flask-RESTPlus

  - [Welcome to Flask\-RESTPlus’s documentation\! — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/)

      - Flask-RESTPlus is an extension for Flask that adds support for quickly building REST APIs. Flask-RESTPlus encourages best practices with minimal setup. If you are familiar with Flask, Flask-RESTPlus should be easy to pick up. It provides a COHERENT COLLECTION OF DECORATORS and tools to describe your API and expose its documentation properly (using Swagger).

        提供許多 decorators/tools 用來描述 API，並揭露 API 文件 (Swagger UI)；自動產生 API 文件這點，是多數人從 Flask-RESTful 改用 Flask-RESTPlus 的原因。

  - [Replace all occurence of Flask\-Restful \(fix \#148\) · noirbizarre/flask\-restplus@43e9548](https://github.com/noirbizarre/flask-restplus/commit/43e9548cfd2168351fb2d0c2fd009ebb8ccedd6b#diff-88b99bb28683bd5b7e3a204826ead112) (2016-04-08)

    Replace all occurence of Flask-Restful (fix #148)

    [Get rid of "Flask\-Restful" references since it is not based on it anymore\! · Issue \#148 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/148) (2016-05-07)

    [Drop flask\-restful dependency · Issue \#90 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/90): (2015-11-04)

    > noirbizarre: To improve performance and maintainability, flask-restplus should drop flask-restful dependency after merging the required sources.

    早期 Flask-RESTplus 真的是基於 Flask-RESTful，但後來因為 performance/maintainability 就與 Flask-RESTful 斷開關係了。

  - [Flask\-RESTful vs Flask\-RESTplus \- Stack Overflow](https://stackoverflow.com/questions/40165665/)

      - masterforker: Other than the ability to automatically generate an interactive documentation for our API using Swagger UI, are there any real advantages of using Flask-RESTplus over Flask-RESTful?

      - .j.torres: I've used both, and THE ONLY REASON we switched too Flask-restplus was the desire to have auto generated Swagger documentation. In my experience, there are no other noticeable differences. Flask-RESTplus started as a FORK of Flask-RESTful, so if you were so inclined, you could read the commit history and see if there are any other noticeable differences.

      - Guest User: According to https://github.com/noirbizarre/flask-restplus/issues/593, the Flask Restplus is most probably dead and abandoned. The last commit was on October 1, 2018. It looks like the project is not being actively maintained anymore.

        Prince Odame: Looks like the project is NOT GOING TO DIE after all. According to this post, noirbizarre, the creator of the project is looking to onboard new maintainers and keep the project alive.

  - [Is the project abandoned? · Issue \#593 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/593) #ril

## OpenAPI Specification

  - Flask-RESTPlus 產生的 API 文件，左上方有 OpenAPI Specification 下載的連結 (`swagger.json`)，從 v0.12.1 的輸出內含 `"swagger": "2.0"` 看來，尚未支援 OpenAPI 3.0。

---

參考資料：

  - [OpenAPI 3\.0\.x Support · Issue \#518 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/518) #ril

## 新手上路 {: #getting-started }

  - [Quick start — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/quickstart.html) #ril

    Initialization

      - As every other extension, you can initialize it with an application object:

            from flask import Flask
            from flask_restplus import Api

            app = Flask(__name__)
            api = Api(app)

        or lazily with the factory pattern:

            from flask import Flask
            from flask_restplus import Api

            api = Api()

            app = Flask(__name__)
            api.init_app(app)

    A Minimal API

      - A minimal Flask-RESTPlus API looks like this:

            from flask import Flask
            from flask_restplus import Resource, Api

            app = Flask(__name__)
            api = Api(app)

            @api.route('/hello')
            class HelloWorld(Resource):
                def get(self):
                    return {'hello': 'world'}

            if __name__ == '__main__':
                app.run(debug=True)

      - Save this as `api.py` and run it using your Python interpreter. Note that we’ve enabled Flask debugging mode to provide code reloading and better error messages.

            $ python api.py
            * Running on http://127.0.0.1:5000/
            * Restarting with reloader

      - Now open up a new prompt to test out your API using `curl`:

            $ curl http://127.0.0.1:5000/hello
            {"hello": "world"}

        完整的輸出如下：

            $ curl -i  http://127.0.0.1:5000/hello
            HTTP/1.0 200 OK
            Content-Type: application/json
            Content-Length: 25
            Server: Werkzeug/0.15.4 Python/2.7.10
            Date: Thu, 11 Jul 2019 03:43:20 GMT

            {
                "hello": "world"
            }

        Content type 會自動設為 `application/json`。

      - You can also use the AUTOMATIC DOCUMENTATION on you API ROOT (by default). In this case: http://127.0.0.1:5000/. See Swagger UI for a complete documentation on the automatic documentation.

        文件放 root 好嗎? 還是要拉出一層 `/docs` ??

    Resourceful Routing

      - The main building block provided by Flask-RESTPlus are RESOURCES. Resources are built on top of [Flask pluggable views](http://flask.pocoo.org/docs/views/#views), giving you easy access to multiple HTTP methods just by DEFINING METHODS ON YOUR RESOURCE. A basic CRUD resource for a todo application (of course) looks like this:

            from flask import Flask, request
            from flask_restplus import Resource, Api

            app = Flask(__name__)
            api = Api(app)

            todos = {}

            @api.route('/<string:todo_id>')               # (1)
            class TodoSimple(Resource):
                def get(self, todo_id):
                    return {todo_id: todos[todo_id]}      # (2)

                def put(self, todo_id):
                    todos[todo_id] = request.form['data'] # (3)
                    return {todo_id: todos[todo_id]}

            if __name__ == '__main__':
                app.run(debug=True)

         1. 很明顯地，同一個 resource 不同的 HTTP method 有著相同的 URI (routing)，這從 RESTful 的角度來看相當直覺；呼應小標題 resourceful routing 的說法。
         2. 直接回傳 dict，就會寫出 JSON，也就是 response content type `application/json`。
         3. 走 `request.form` 表示 request 的 content type 是 `application/x-www-form-urlencoded`，呼應下面 `curl -d "data=..."` 的用法，不過這與一般 RESTful request/response 都走 JSON 的設計明顯不同 ??

        所謂 [pluggable view](http://flask.pocoo.org/docs/views/#views) 是指 "based on classes instead of functions"，只要定義 (view/resource) class 的不同 method，就能實作不同的 HTTP methods，例如：

      - You can try it like this:

            $ curl http://localhost:5000/todo1 -d "data=Remember the milk" -X PUT
            {"todo1": "Remember the milk"}
            $ curl http://localhost:5000/todo1
            {"todo1": "Remember the milk"}
            $ curl http://localhost:5000/todo2 -d "data=Change my brakepads" -X PUT
            {"todo2": "Change my brakepads"}
            $ curl http://localhost:5000/todo2
            {"todo2": "Change my brakepads"}

        Or from python if you have the Requests library installed:

            >>> from requests import put, get
            >>> put('http://localhost:5000/todo1', data={'data': 'Remember the milk'}).json()
            {u'todo1': u'Remember the milk'}
            >>> get('http://localhost:5000/todo1').json()
            {u'todo1': u'Remember the milk'}
            >>> put('http://localhost:5000/todo2', data={'data': 'Change my brakepads'}).json()
            {u'todo2': u'Change my brakepads'}
            >>> get('http://localhost:5000/todo2').json()
            {u'todo2': u'Change my brakepads'}

      - Flask-RESTPlus understands multiple kinds of return values from view methods. Similar to Flask, you can return any iterable and it will be converted into a response, including raw Flask response objects.

        實驗發現，Flask 直接回傳 dict 也會自動轉成 JSON，而且 content type 也會被設為 `application/json` (不用透過 `jsonify()`)，這部份似乎跟 Flask-RESTPlus 是一樣的 ??

        Flask-RESTPlus also support setting the response code and response headers using multiple return values, as shown below:

            class Todo1(Resource):
                def get(self):
                    # Default to 200 OK
                    return {'task': 'Hello world'}

            class Todo2(Resource):
                def get(self):
                    # Set the response code to 201
                    return {'task': 'Hello world'}, 201

            class Todo3(Resource):
                def get(self):
                    # Set the response code to 201 and return custom headers
                    return {'task': 'Hello world'}, 201, {'Etag': 'some-opaque-string'}

    Endpoints

      - MANY TIMES in an API, your resource will have multiple URLs. You can pass multiple URLs to the `add_resource()` method or to the `route()` decorator, both on the `Api` object. Each one will be routed to your `Resource`:

            api.add_resource(HelloWorld, '/hello', '/world')

            # or

            @api.route('/hello', '/world')
            class HelloWorld(Resource):
                pass

        什麼情況下會有多個 URL 的需求 ??

      - You can also match parts of the path as variables to your RESOURCE METHODs.

            api.add_resource(Todo, '/todo/<int:todo_id>', endpoint='todo_ep')

            # or

            @api.route('/todo/<int:todo_id>', endpoint='todo_ep')
            class HelloWorld(Resource):
                pass

      - Note: If a request does not match any of your application’s endpoints, Flask-RESTPlus will return a 404 error message with SUGGESTIONS OF OTHER ENDPOINTS that closely match the requested endpoint. This can be disabled by setting `ERROR_404_HELP` to False in your application config.

  - [Full example — Flask\-RESTPlus 0\.10\.1 documentation](http://flask-restplus.readthedocs.io/en/stable/example.html) #ril

## Namespace & Blueprint {: #namespace }

  - [Scaling your project — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/scaling.html)

    Multiple namespaces

      - There are many different ways to organize your Flask-RESTPlus app, but here we’ll describe one that SCALES pretty well with larger apps and maintains a nice level organization.

        Flask-RESTPlus provides a way to use almost the same pattern as Flask’s blueprint. The main idea is to split your app into REUSABLE NAMESPACEs.

        就像 blueprint 可以將 application object 拆細一樣，namespace 可以將單一個 API object 拆細；其間的關係是 application > blueprint > API > namespace。

        按下面 "Multiple APIs with reusable namespaces" 的說法，所謂 reusable 是指在不同 API version 間 reuse，不過 API 之所以會跳版，就是因為 interface 出現無法向下相容的改變? 把 API 拆細成不同的 namespace，在不同 API version 間共用一部份 interface 就變得可能了。

      - Here’s an example directory structure:

            project/
            ├── app.py
            ├── core
            │   ├── __init__.py
            │   ├── utils.py
            │   └── ...
            └── apis
                ├── __init__.py
                ├── namespace1.py
                ├── namespace2.py
                ├── ...
                └── namespaceX.py

          - The `app` module will serve as a MAIN APPLICATION ENTRY POINT following one of the classic Flask patterns (See Larger Applications and Application Factories).

          - The `core` module is an example, it contains the BUSINESS LOGIC. In fact, you call it whatever you want, and there CAN BE MANY PACKAGES.

            看清 `app.py` 跟 `apis/` 都是系統對外的 UI，就可以知道 `core/` 是跟 UI 無關的 business logic，也就是 domain model 所在的位置。

          - The `apis` package will be your MAIN API ENTRY POINT that you need to IMPORT AND REGISTER ON THE APPLICATION, whereas the namespaces modules are reusable namespaces designed like you would do with Flask’s Blueprint.

            按下面  The `apis.__init__` module should aggregate them 的做法，會將多個 namespace object 組裝成一個 API object，不過 "import and register on the application" 則要看情形，若有用 application factory 的話，登記的對象就會是 blueprint。

      - A namespace module contains MODELS AND RESOURCES DECLARATIONS. For example:

            from flask_restplus import Namespace, Resource, fields

            api = Namespace('cats', description='Cats related operations')

            cat = api.model('Cat', {
                'id': fields.String(required=True, description='The cat identifier'),
                'name': fields.String(required=True, description='The cat name'),
            })

            CATS = [
                {'id': 'felix', 'name': 'Felix'},
            ]

            @api.route('/')
            class CatList(Resource):
                @api.doc('list_cats')
                @api.marshal_list_with(cat)
                def get(self):
                    '''List all cats'''
                    return CATS

            @api.route('/<id>')
            @api.param('id', 'The cat identifier')
            @api.response(404, 'Cat not found')
            class Cat(Resource):
                @api.doc('get_cat')
                @api.marshal_with(cat)
                def get(self, id):
                    '''Fetch a cat given its identifier'''
                    for cat in CATS:
                        if cat['id'] == id:
                            return cat
                    api.abort(404)

        從 `api = Namespace('cats', description='Cats related operations')` 的用法看來，除了跟 URL prefix 有關之外 (預設用 `/cats`) ，namespace 跟 API doc 的呈現也有關係；Namespace 下所有的 entry point 會顯示在一起，可以一起收合/展開，沒有宣告 namespace 則會列在 `default` namespace 下。

      - The `apis.__init__` module should AGGREGATE them:

            from flask_restplus import Api

            from .namespace1 import api as ns1
            from .namespace2 import api as ns2
            # ...
            from .namespaceX import api as nsX

            api = Api(
                title='My Title',
                version='1.0',
                description='A description',
                # All API metadatas
            )

            api.add_namespace(ns1)
            api.add_namespace(ns2)
            # ...
            api.add_namespace(nsX)

      - You can define custom url-prefixes for namespaces during registering them in your API. You don’t have to BIND URL-PREFIX while declaration of `Namespace` object.

            from flask_restplus import Api

            from .namespace1 import api as ns1
            from .namespace2 import api as ns2
            # ...
            from .namespaceX import api as nsX

            api = Api(
                title='My Title',
                version='1.0',
                description='A description',
                # All API metadatas
            )

            api.add_namespace(ns1, path='/prefix/of/ns1')
            api.add_namespace(ns2, path='/prefix/of/ns2')
            # ...
            api.add_namespace(nsX, path='/prefix/of/nsX')

        增加 namespace 的重用性。

        實驗確認，並不會在 `Namepace()` 自帶的 path 上疊加，而是取代，所以 `api.add_namespace(Namespace('Cats'), path='cats')` 最後的 prefix 只有 `/cats`，不會是 `/cats/Cats`。

      - Using this pattern, you simple have to register your API in `app.py` like that:

            from flask import Flask
            from apis import api

            app = Flask(__name__)
            api.init_app(app)

            app.run(debug=True)

    Use With Blueprints

      - See Modular Applications with Blueprints in the Flask documentation for what blueprints are and why you should use them. Here’s an example of how to link an Api up to a Blueprint.

            from flask import Blueprint
            from flask_restplus import Api

            blueprint = Blueprint('api', __name__)
            api = Api(blueprint)
            # ...

      - Using a blueprint will allow you to MOUNT YOUR API ON ANY URL PREFIX and/or subdomain in you application:

            from flask import Flask
            from apis import blueprint as api

            app = Flask(__name__)
            app.register_blueprint(api, url_prefix='/api/1')
            app.run(debug=True)

        注意 `register_blueprint(api)` 並沒有把 API object 當做 blueprint 用，因為 `import blueprint as api` 的關係，可能讓人搞混。

        Note: Calling `Api.init_app()` is not required here because registering the blueprint with the app takes care of setting up the routing for the application.

      - Note: When using blueprints, remember to use the blueprint name with `url_for()`:

            # without blueprint
            url_for('my_api_endpoint')

            # with blueprint
            url_for('api.my_api_endpoint')

    Multiple APIs with reusable namespaces

      - Sometimes you need to maintain multiple versions of an API. If you built your API using namespaces composition, it’s quite simple to scale it to multiple APIs.

      - Given the previous layout, we can migrate it to the following directory structure:

            project/
            ├── app.py
            ├── apiv1.py
            ├── apiv2.py
            └── apis
                ├── __init__.py
                ├── namespace1.py
                ├── namespace2.py
                ├── ...
                └── namespaceX.py

        Each `apivX` module will have the following pattern:

            from flask import Blueprint
            from flask_restplus import Api

            api = Api(blueprint)

            from .apis.namespace1 import api as ns1
            from .apis.namespace2 import api as ns2
            # ...
            from .apis.namespaceX import api as nsX

            blueprint = Blueprint('api', __name__, url_prefix='/api/1')
            api = Api(blueprint
                title='My Title',
                version='1.0',
                description='A description',
                # All API metadatas
            )

            api.add_namespace(ns1)
            api.add_namespace(ns2)
            # ...
            api.add_namespace(nsX)

        跟之前 `apis.__init__` 在做 aggregation 一樣。

        And the app will simply MOUNT them:

            from flask import Flask
            from api1 import blueprint as api1
            from apiX import blueprint as apiX

            app = Flask(__name__)
            app.register_blueprint(api1)
            app.register_blueprint(apiX)
            app.run(debug=True)

      - These are only proposals and you can do whatever suits your needs. Look at the [github repository examples folder](https://github.com/noirbizarre/flask-restplus/tree/master/examples) for more complete examples. #ril

## Representation ??

  - [flask\-restplus/xml\_representation\.py at master · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/blob/master/examples/xml_representation.py) 示範 'application/xml' #ril

## Input Validation

  - [Argument Parsing - Quick start — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/quickstart.html#argument-parsing)

      - While Flask provides easy access to request data (i.e. querystring or POST form encoded data), it’s still a pain to VALIDATE FORM DATA. Flask-RESTPlus has built-in support for REQUEST DATA VALIDATION using a library similar to `argparse`.

            from flask_restplus import reqparse

            parser = reqparse.RequestParser()
            parser.add_argument('rate', type=int, help='Rate to charge for this resource')
            args = parser.parse_args()

        Note: Unlike the `argparse` module, `parse_args()` returns a Python dictionary instead of a custom data structure.

      - Using the `RequestParser` class also gives you sane error messages for free. If an argument fails to pass validation, Flask-RESTPlus will respond with a 400 Bad Request and a response HIGHLIGHTING THE ERROR.

            $ curl -d 'rate=foo' http://127.0.0.1:5000/todos
            {'status': 400, 'message': 'foo cannot be converted to int'}

        文件似乎有點舊，在 v0.12.1 試出來的訊息很不一樣：

            $ curl -i -d 'rate=foo' http://127.0.0.1:5000/todos
            HTTP/1.0 400 BAD REQUEST
            Content-Type: application/json
            Content-Length: 174
            Server: Werkzeug/0.15.4 Python/2.7.10
            Date: Thu, 11 Jul 2019 03:23:41 GMT

            {
                "message": "Input payload validation failed",
                "errors": {
                    "rate": "Rate to charge for this resource invalid literal for int() with base 10: 'foo'"
                }
            }

      - The `inputs` module provides a number of included common CONVERSION FUNCTIONS such as `date()` and `url()`.

        例如 `parser.add_argument('url', type=inputs.URL(schemes=['http', 'https']))`

      - Calling `parse_args()` with `strict=True` ensures that an error is thrown if the request includes arguments your parser does not define.

            args = parser.parse_args(strict=True)

  - [Request Parsing — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/parsing.html) #ril

      - Argument Locations 提到，可以限定 value 來自 POST body、query string、header、cookie 或是 uploads

  - [API — Flask\-RESTPlus 0\.10\.1 documentation](http://flask-restplus.readthedocs.io/en/stable/api.html#flask_restplus.reqparse.Argument) 雖說 `type` 是 "type to which the request argument should be converted"，但實際上可以是 function，若轉換/檢查的過程丟出 exception，就會回傳 error message #ril

## JSON Request ??

  - `RequestParser.add_argument()` 搭配 `location='json'` 時，Swagger UI 的 parameter name 下方才會標示 "(body)"，description 也才會提示 Parameter content type: application/json。

    也就是 `location='json'` 或 `location='form' 都會決定 request 該有的 content type，若同時出現 `location='json'` 與 `location='form'` 的 argument，會遇到下面的錯誤：

        ERROR  flask_restplus.api - Unable to render schema
        SpecsError: Can't use formData and body at the same time

---

參考資料：

  - [Can I Post a json? · Issue \#116 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/116) #ril
  - [Request Parsing — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/parsing.html) 出現 `location='json'` 的用法 #ril

  - [Marshalling vs Parsing · Issue \#372 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/372) #ril

      - Elfayer: Let's start with the marshalling. It is defined in the doc that it should be used "to control what data you actually render in your response OR EXPECT AS IN INPUT PAYLOAD". So it is for input and output then? Why is the section called "Response Marshalling" if it also takes care of the input?

        上面的說法來自 [Response marshalling — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/marshalling.html)，裡面完全沒提到 `expect()`，只有 `marshal_with()`。

        So on my end points, I do things as follow:

            @namespace.expect(user)
            @namespace.marshal_with(user_full)
            def put(self):

        I have a DIFFERENT SCHEMA expected for input and marshalled for output.

        這還滿合理的，但 [Full example — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/example.html?highlight=expect) 卻只示範了 input 跟 output 都採用同一個 model 的狀況：

            @ns.expect(todo)
            @ns.marshal_with(todo)
            def put(self, id):

        Now here comes the thing. I defined what I want on entry, and output. What do I need Parsing for? If my user schema looks like:

            user = namespace.model('User', {
                'id': fields.Integer(required=True),
                'first_name': fields.String(required=True),
                'last_name': fields.String(required=True),
                'email': fields.String(required=True),
                'age': fields.Integer(required=True)
            })

        Why do I need to define the parsing as follow, while the model is already defined?

            parser = reqparse.RequestParser()
            parser.add_argument('id', required=True)
            parser.add_argument('first_name', required=True)
            parser.add_argument('last_name', required=True)
            parser.add_argument('email', required=True)
            parser.add_argument('age', required=True, type=int)
            args = parser.parse_args()

        這裡很明顯有個問題，model 跟 parser 完全沒有連結 ...

      - avilaton: It is enough with using the decorator `@namespace.expect(user)` to get INPUT VALIDATION. Please have a look at the example in http://flask-restplus.readthedocs.io/en/stable/example.html?highlight=expect

        也就是 `@namespace.expect(model)` 處理了 (JSON) body 的 validation，但若同時想驗證 query string、header 呢 ?? 有機會連結 model 與 `expect(parser)` 的用法嗎 ??

  - [Documenting Input Body · Issue \#61 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/61) #ril

    出現 `@api.doc(expect=package)` 與 `@api.doc(parser=packages_parser)` 的用法，合併使用是不是就解了 ??

  - [Building beautiful REST APIs using Flask, Swagger UI and Flask\-RESTPlus \- Michał Karzyński](http://michal.karzynski.pl/blog/2016/06/19/building-beautiful-restful-apis-using-flask-swagger-ui-flask-restplus/) (2016-06-19) 講到 JSON 時又不用 parser 了 #ril

  - [Confusion between request parsing and response marshalling · Issue \#214 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/issues/214) #ril

  - [Swagger documentation — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/swagger.html#the-api-expect-decorator) #ril

    出現 `@api.doc(body=resource_fields)` 的用法，試過 `@api.doc(body=model, parser=parser)` 的用法不會出問題!!不過不是走 `expect(model/parser)` 好像就不會檢查 ??

  - [`Resource.validate_payload()` - API — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/api.html#flask_restplus.Resource.validate_payload)  #ril

    `expect(parser)` 搭配 `validate_payload()` 會不會是一種方法 ??

  - [Custom Validation in Flask RESTPlus \| mdickin\.com](http://mdickin.com/2016/07/14/custom-validation-in-flask-restplus/) (2016-07-14) #ril

  - [Better fields and validation in Flask Restplus · Avi Aryan](https://aviaryan.com/blog/gsoc/restplus-validation-custom-fields) (2016-06-12) #ril

## Response Marshalling ??

  - [Response marshalling — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/marshalling.html) #ril

    這裡提到的 model 也可以用在 input，這是文件最讓人不解的地方；最後竟也支援 JSON Schema。

  - [Models - API — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/api.html#models) #ril

## Error Handling

  - [Error handling — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/errors.html) #ril

    HTTPException handling

      - Werkzeug `HTTPException` are automatically properly seriliazed reusing the `description` attribute.

            from werkzeug.exceptions import BadRequest
            raise BadRequest()

        will return a 400 HTTP code and output

            {
                "message": "The browser (or proxy) sent a request that this server could not understand."
            }

        whereas this:

            from werkzeug.exceptions import BadRequest
            raise BadRequest('My custom message')

        will output

            {
                "message": "My custom message"
            }

        從標題看來，Flask-RESTPlus 對 `HTTPException` 會有特殊的處理 ??

      - You can attach extras attributes to the output by providing a `data` attribute to your exception.

            from werkzeug.exceptions import BadRequest
            e = BadRequest('My custom message')
            e.data = {'custom': 'value'}
            raise e

        will output

            {
                "message": "My custom message",
                "custom": "value"
            }

  - [flask\-restplus/api\.py at 0\.12\.1 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/blob/0.12.1/flask_restplus/api.py#L585)

    `Api.handle_error()` 是 error handling 的入口

        def handle_error(self, e):
            '''
            Error handler for the API transforms a raised exception into a Flask response,
            with the appropriate HTTP status code and body.
            :param Exception e: the raised Exception object
            '''
            got_request_exception.send(current_app._get_current_object(), exception=e)

            include_message_in_response = current_app.config.get("ERROR_INCLUDE_MESSAGE", True)
            default_data = {}

            headers = Headers()

            for typecheck, handler in six.iteritems(self._own_and_child_error_handlers): # (1)
                if isinstance(e, typecheck): # BadRequest (HTTPException), Exception
                    result = handler(e)
                    default_data, code, headers = unpack(result, HTTPStatus.INTERNAL_SERVER_ERROR) # (2)(3)
                    break
            else:
                if isinstance(e, HTTPException):
                    code = HTTPStatus(e.code)
                    if include_message_in_response:
                        default_data = {
                            'message': getattr(e, 'description', code.phrase)
                        }
                    headers = e.get_response().headers
                elif self._default_error_handler:
                    result = self._default_error_handler(e)
                    default_data, code, headers = unpack(result, HTTPStatus.INTERNAL_SERVER_ERROR)
                else:
                    code = HTTPStatus.INTERNAL_SERVER_ERROR
                    if include_message_in_response:
                        default_data = {
                            'message': code.phrase,
                        }

            if include_message_in_response:
                default_data['message'] = default_data.get('message', str(e)) # (3)

            data = getattr(e, 'data', default_data)                           # (3)
            fallback_mediatype = None

            if code >= HTTPStatus.INTERNAL_SERVER_ERROR:
                exc_info = sys.exc_info()
                if exc_info[1] is None:
                    exc_info = None
                current_app.log_exception(exc_info)                           # (4)

            elif code == HTTPStatus.NOT_FOUND and current_app.config.get("ERROR_404_HELP", True) \
                    and include_message_in_response:
                data['message'] = self._help_on_404(data.get('message', None))

            elif code == HTTPStatus.NOT_ACCEPTABLE and self.default_mediatype is None:
                # if we are handling NotAcceptable (406), make sure that
                # make_response uses a representation we support as the
                # default mediatype (so that make_response doesn't throw
                # another NotAcceptable error).
                supported_mediatypes = list(self.representations.keys())
                fallback_mediatype = supported_mediatypes[0] if supported_mediatypes else "text/plain"

            # Remove blacklisted headers
            for header in HEADERS_BLACKLIST:
                headers.pop(header, None)

            resp = self.make_response(data, code, headers, fallback_mediatype=fallback_mediatype)

            if code == HTTPStatus.UNAUTHORIZED:
                resp = self.unauthorized(resp)
            return resp

        @property
        def _own_and_child_error_handlers(self): # (1)
            rv = {}
            rv.update(self.error_handlers)
            for ns in self.namespaces:
                for exception, handler in six.iteritems(ns.error_handlers):
                    rv[exception] = handler
            return rv

     1. 先遶過所有用 `@errorhandler` 自訂的 error handler。

     2. Error handler 回傳值有不同的解讀方式

            result = handler(e)
            default_data, code, headers = unpack(result, HTTPStatus.INTERNAL_SERVER_ERROR)

        細節要看 [`utils.unpack()`](https://github.com/noirbizarre/flask-restplus/blob/0.12.1/flask_restplus/utils.py#L82) 內部的實作，展開成 `(data, code, headers)`：

            def unpack(response, default_code=HTTPStatus.OK):

                if not isinstance(response, tuple):
                    # data only
                    return response, default_code, {}
                elif len(response) == 1:
                    # data only as tuple
                    return response[0], default_code, {}
                elif len(response) == 2:
                    # data and code
                    data, code = response
                    return data, code, {}
                elif len(response) == 3:
                    # data, code and headers
                    data, code, headers = response
                    return data, code or default_code, headers
                else:
                    raise ValueError('Too many response values')

        預設視為 500 Internal Server Error。

     3. 就算由自訂的 handler 處理，回傳的 data 也只是 `default_data`，暗示 handler 不完全能控制輸出格式：

            if include_message_in_response:
                default_data['message'] = default_data.get('message', str(e))

            data = getattr(e, 'data', default_data)

            resp = self.make_response(data, code, headers, fallback_mediatype=fallback_mediatype)

        Exception object 沒有 `data` attribute 時才會採用 `default_data`；只好在 `handler(e)` 過程中對 exception object 動點手腳 ?? -- 把 `data` attribute 拿掉，或是把要回傳的資料安排好在 `data` attribute 裡。

     4. 只有發生伺服器內部錯誤時，才會自動 log exception：

            if code >= HTTPStatus.INTERNAL_SERVER_ERROR:
                exc_info = sys.exc_info()
                if exc_info[1] is None:
                    exc_info = None
                current_app.log_exception(exc_info)

        這好像滿合理的，因為其他 404 Not Found 等並不需要記錄。

  - [Propagate exceptions from the flask\-restplus handler if propagate exceptions is enabled by orishoshan · Pull Request \#527 · noirbizarre/flask\-restplus](https://github.com/noirbizarre/flask-restplus/pull/527) #ril

  - 實驗發現，若用 `@api.errorhandler(Exception)` 自訂錯誤處理：

      - 在 validation error 時，`return {'message': 'custom message'}, 444` 竟然只有 status code 有生效，body message 完全無法自訂 ??
      - 要如果何 `HTTPException` 回歸原有的處理方式 ?? 又這跟 Flask application 層級 `@app.errorhandler(Exception)` 的用法是什麼關係 ??

## Versioning ??

  - [Multiple APIs with reusable namespaces - Scaling your project — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/scaling.html#multiple-apis-with-reusable-namespaces) #ril

## Authentication

  - [API — Flask\-RESTPlus 0\.12\.1 documentation](https://flask-restplus.readthedocs.io/en/stable/api.html#flask_restplus.Api) `flask_restplus.Api` 跟 `flask_restplus.Namespace` 的 constructor 都有一個 `authorizations=None` 的參數，但為什麼只有 `Api` 有 `security=None` 參數 ??

  - [Documenting authorizations - Swagger documentation — Flask\-RESTPlus 0\.11\.0 documentation](http://flask-restplus.readthedocs.io/en/stable/swagger.html#documenting-authorizations)

      - You can use the `authorizations` keyword argument to document authorization information:

            authorizations = {
                'apikey': {
                    'type': 'apiKey',
                    'in': 'header',
                    'name': 'X-API-KEY'
                }
            }
            api = Api(app, authorizations=authorizations)

        這只是定義 authentication type 而已，真正的套用是透過 `security`。

      - Then decorate each resource and method that requires authorization:

            @api.route('/resource/')
            class Resource1(Resource):
                @api.doc(security='apikey')
                def get(self):
                    pass

                @api.doc(security='apikey')
                def post(self):
                    pass

      - You can apply this requirement GLOBALLY with the `security` parameter on the `Api` constructor:

            authorizations = {
                'apikey': {
                    'type': 'apiKey',
                    'in': 'header',
                    'name': 'X-API-KEY'
                }
            }
            api = Api(app, authorizations=authorizations, security='apikey')

      - You can have multiple security schemes:

            authorizations = {
                'apikey': {
                    'type': 'apiKey',
                    'in': 'header',
                    'name': 'X-API'
                },
                'oauth2': {
                    'type': 'oauth2',
                    'flow': 'accessCode',
                    'tokenUrl': 'https://somewhere.com/token',
                    'scopes': {
                        'read': 'Grant read-only access',
                        'write': 'Grant read-write access',
                    }
                }
            }
            api = Api(self.app, security=['apikey', {'oauth2': 'read'}], authorizations=authorizations)

      - Security schemes can be overridden for a particular method:

            @api.route('/authorizations/')
            class Authorized(Resource):
                @api.doc(security=[{'oauth2': ['read', 'write']}])
                def get(self):
                    return {}

        You can disable security on a given RESOURCE or METHOD by passing `None` or an empty list as the `security` parameter:

            @api.route('/without-authorization/')
            class WithoutAuthorization(Resource):
                @api.doc(security=[])
                def get(self):
                    return {}

                @api.doc(security=None)
                def post(self):
                    return {}

  - [How to Use Token Based Authentication in Flask\-RESTPlus \- YouTube](https://www.youtube.com/watch?v=xF30i_A6cRw)

    在 Swagger UI 出現 Authorize 按鈕是一回事，後端的檢查又是一回事，要自己寫 decorator；或許 [Flask-HTTPAuth](https://flask-httpauth.readthedocs.io/) 可以幫上忙? #ril

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

更多：

  - API 文件用 [Swagger UI](swagger.md#ui) 表現。

手冊：

  - [Changelog](http://flask-restplus.readthedocs.io/en/stable/changelog.html)

  - [API Documentation](http://flask-restplus.readthedocs.io/en/stable/api.html)

      - [Class `flask_restplus.Namespace`](https://flask-restplus.readthedocs.io/en/stable/api.html#flask_restplus.Namespace)
      - [Class `flask_restplus.reqparse.RequestParser`](https://flask-restplus.readthedocs.io/en/stable/api.html#flask_restplus.reqparse.RequestParser)
      - [Class `flask_restplus.reqparse.Argument`](https://flask-restplus.readthedocs.io/en/stable/api.html#flask_restplus.reqparse.Argument)
