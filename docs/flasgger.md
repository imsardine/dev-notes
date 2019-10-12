# Flasgger

  - [httpbin.org](https://httpbin.org/) 第一次在 httpbin.org 看到 Flasgger 被使用 -- Powered by Flasgger；參考 [httpbin/setup\.py at master · requests/httpbin](https://github.com/requests/httpbin/blob/master/setup.py)

  - [rochacbruno/flasgger: Easy Swagger UI for your Flask API](https://github.com/rochacbruno/flasgger)

      - Flasgger is a Flask extension to EXTRACT OpenAPI-Specification from all Flask views registered in your API.

        Flasgger also comes with SwaggerUI embedded so you can access http://localhost:5000/apidocs and visualize and interact with your API resources.

      - Flasgger also provides VALIDATION of the incoming data, using the same specification it can validates if the data received as as a POST, PUT, PATCH is valid against the schema defined using YAML, Python dictionaries or [Marshmallow Schemas](https://marshmallow.readthedocs.io/). #ril

      - Flasgger can work with simple function views or `MethodView`s using docstring as specification, or using `@swag_from` decorator to get specification from YAML or dict and also provides `SwaggerView` which can use Marshmallow Schemas as specification. #ril

      - Flasgger is compatible with Flask-RESTful so you can use `Resource`s and swag specifications together, take a look at [restful example](https://github.com/flasgger/flasgger/blob/master/examples/restful.py).

        看來 Flask-RESTPlus 跟 Flasgger 都是基於 Flask-RESTful 整合了 OpenAPI Specification 進來，只是兩者的方法很不一樣，前者用大量的 decorator，後者則將 specification 內嵌在 docstring 裡。

        [httpbin/core\.py at master · requests/httpbin](https://github.com/requests/httpbin/blob/master/httpbin/core.py) 就是用 docstrings (但沒用 Flask-RESTful)

      - Flasgger also supports Marshmallow APISpec as base template for specification, if you are using APISPec from Marshmallow take a look at [apispec example](https://github.com/flasgger/flasgger/blob/master/examples/apispec_example.py). #ril

## 新手上路 {: #getting-started }

  - [Getting started - flasgger/flasgger: Easy OpenAPI specs and Swagger UI for your Flask API](https://github.com/flasgger/flasgger#getting-started) #ril

    Using docstrings as specification

      - Create a file called for example `colors.py`

            from flask import Flask, jsonify
            from flasgger import Swagger

            app = Flask(__name__)
            swagger = Swagger(app)

            @app.route('/colors/<palette>/')
            def colors(palette):
                """Example endpoint returning a list of colors by palette
                This is using docstrings for specifications.
                ---
                parameters:
                  - name: palette
                    in: path
                    type: string
                    enum: ['all', 'rgb', 'cmyk']
                    required: true
                    default: all
                definitions:
                  Palette:
                    type: object
                    properties:
                      palette_name:
                        type: array
                        items:
                          $ref: '#/definitions/Color'
                  Color:
                    type: string
                responses:
                  200:
                    description: A list of colors (may be filtered by palette)
                    schema:
                      $ref: '#/definitions/Palette'
                    examples:
                      rgb: ['red', 'green', 'blue']
                """
                all_colors = {
                    'cmyk': ['cian', 'magenta', 'yellow', 'black'],
                    'rgb': ['red', 'green', 'blue']
                }
                if palette == 'all':
                    result = all_colors
                else:
                    result = {palette: all_colors.get(palette)}

                return jsonify(result)

            app.run(debug=True)

        在 docstring 裡寫 YAML，跟 doctest 的概念很像；只是塞在 docstring 裡 Swagger Editor 就派不上用場了。

        語法幾乎跟 OpenAPI 一樣? 不過很明顯地，docstring 允許 `definitions:` 這種 external definition 的用法也出現 spec 裡，猜想在執行期會將所有 endpoint 的 spec 合併在一起。

      - Now run:

            python colors.py

        And go to: http://localhost:5000/apidocs/

        You should get:

        ![colors](https://github.com/flasgger/flasgger/blob/master/docs/colors.png)

    Using external YAML files

      - Save a new file `colors.yml`

            Example endpoint returning a list of colors by palette
            In this example the specification is taken from external YAML file
            ---
            parameters:
              - name: palette
                in: path
                type: string
                enum: ['all', 'rgb', 'cmyk']
                required: true
                default: all
            definitions:
              Palette:
                type: object
                properties:
                  palette_name:
                    type: array
                    items:
                      $ref: '#/definitions/Color'
              Color:
                type: string
            responses:
              200:
                description: A list of colors (may be filtered by palette)
                schema:
                  $ref: '#/definitions/Palette'
                examples:
                  rgb: ['red', 'green', 'blue']

      - lets use the same example changing only the view function.

            from flasgger import swag_from

            @app.route('/colors/<palette>/')
            @swag_from('colors.yml')
            def colors(palette):
                ...

        寫在外部檔，不會讓 Python code 因過長的 docstring 而降低可讀性；依不同 endpoint 拆成多個 YAML 檔，Swagger Editor 也不支援這樣的用法。

      - If you do not want to use the decorator you can use the docstring `file:` shortcut.

            @app.route('/colors/<palette>/')
            def colors(palette):
                """
                file: colors.yml
                """
                ...

    Using dictionaries as raw specs

      - Create a Python dictionary as:

            specs_dict = {
              "parameters": [
                {
                  "name": "palette",
                  "in": "path",
                  "type": "string",
                  "enum": [
                    "all",
                    "rgb",
                    "cmyk"
                  ],
                  "required": "true",
                  "default": "all"
                }
              ],
              "definitions": {
                "Palette": {
                  "type": "object",
                  "properties": {
                    "palette_name": {
                      "type": "array",
                      "items": {
                        "$ref": "#/definitions/Color"
                      }
                    }
                  }
                },
                "Color": {
                  "type": "string"
                }
              },
              "responses": {
                "200": {
                  "description": "A list of colors (may be filtered by palette)",
                  "schema": {
                    "$ref": "#/definitions/Palette"
                  },
                  "examples": {
                    "rgb": [
                      "red",
                      "green",
                      "blue"
                    ]
                  }
                }
              }
            }

        用 Python dict 來寫的優勢是什麼?

      - Now take the same function and use the dict in the place of YAML file.

            @app.route('/colors/<palette>/')
            @swag_from(specs_dict)
            def colors(palette):
                """Example endpoint returning a list of colors by palette
                In this example the specification is taken from specs_dict
                """
                ...

## OpenAPI Specification

  - [OpenAPI 3.0 Support - flasgger/flasgger: Easy OpenAPI specs and Swagger UI for your Flask API](https://github.com/flasgger/flasgger#openapi-30-support) #ril

## Validation

  - [Use the same data to validate your API POST body - flasgger/flasgger: Easy OpenAPI specs and Swagger UI for your Flask API](https://github.com/flasgger/flasgger#use-the-same-data-to-validate-your-api-post-body) #ril

## Swagger UI

  - [Swagger UI and templates - flasgger/flasgger: Easy OpenAPI specs and Swagger UI for your Flask API](https://github.com/flasgger/flasgger#swagger-ui-and-templates) #ril
  - [Externally loading Swagger UI and jQuery JS/CSS - flasgger/flasgger: Easy OpenAPI specs and Swagger UI for your Flask API](https://github.com/flasgger/flasgger#externally-loading-swagger-ui-and-jquery-jscss) #ril

## Flask-RESTful Integration

  - [Using Flask RESTful Resources - flasgger/flasgger: Easy OpenAPI specs and Swagger UI for your Flask API](https://github.com/flasgger/flasgger#using-flask-restful-resources) #ril

## 安裝設置 {: #setup }

  - [Installation - flasgger/flasgger: Easy OpenAPI specs and Swagger UI for your Flask API](https://github.com/flasgger/flasgger#installation)

        pip install flasgger

    NOTE: If you want to use Marshmallow Schemas you also need to run `pip install marshmallow apispec`

## 參考資料 {: #reference }

  - [rochacbruno/flasgger - GitHub](https://github.com/rochacbruno/flasgger)
  - [Flasgger Demo](http://flasgger.pythonanywhere.com/) ([source](https://github.com/flasgger/flasgger/tree/master/examples))

相關：

  - 做為 [Flask](flask.md) extension，可以從 docstring 取出 [OpenAPI Specification](swagger-spec.md)，並自動產生 [Swagger UI](swagger.md#ui)。
  - 可以搭配 [Flask-RESTful](flask-restful.md) 的 `Resource` 使用。
  - 替代方案有 [Flask-RESTPlus](flask-restplus.md)、[Connexion](connexion.md)。
