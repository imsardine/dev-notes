# Connexion

  - [Welcome to Connexion’s documentation\! — Connexion 2\.0 documentation](https://connexion.readthedocs.io/en/latest/)

      - Connexion is a framework on top of Flask that automagically handles HTTP requests defined using OpenAPI (formerly known as Swagger), supporting both v2.0 and v3.0 of the specification.

      - Connexion allows you to WRITE THESE SPECIFICATIONS, then MAPS THE ENDPOINTS TO YOUR PYTHON FUNCTIONS.

        This is what makes it unique from other tools that GENERATE THE SPECIFICATION BASED ON YOUR PYTHON CODE. You are free to describe your REST API with as much detail as you want and then Connexion guarantees that it will work as you specified. We built Connexion this way in order to:

          - Simplify the development process
          - Reduce misinterpretation about what an API is going to look like

        Flask-RESTPlus 正是那種從 Python code 產生 specification 的做法，但這種 self-documenting 的做法有什麼問題? 不過先寫 spec 似乎能讓我們更專注在 interface 而非實作，code review 時很清楚哪些屬於 interface，那些是實作 #ril

  - [Server stub generator HOWTO · swagger\-api/swagger\-codegen Wiki](https://github.com/swagger-api/swagger-codegen/wiki/Server-stub-generator-HOWTO#user-content-python-flask-connexion) 第一次知道 Connexion，是 Swagger Codegen 的範例。

  - [zalando/connexion: Swagger/OpenAPI First framework for Python on top of Flask with automatic endpoint validation & OAuth2 support](https://github.com/zalando/connexion) #ril

    Connexion Features:

      - Validates requests and endpoint parameters automatically, based on your specification
      - Provides a Web Swagger Console UI so that the users of your API can have live documentation and even call your API's endpoints through it
      - Handles OAuth 2 token-based authentication #ril
      - Supports API versioning
      - Supports automatic serialization of payloads. If your specification defines that an endpoint returns JSON, Connexion will automatically serialize the return value for you and set the right content type in the HTTP header.

    Why Connexion

      - With Connexion, you WRITE THE SPEC FIRST. Connexion then calls your Python code, handling the mapping from the specification to the code. This incentivizes you to write the specification so that all of your developers can understand what your API does, even before you write a single line of code.

        呼應了抬頭 "OpenAPI First" 的說法。

      - If multiple teams depend on your APIs, you can use Connexion to easily send them the documentation of your API. This guarantees that your API will follow the specification that you wrote.

        This is a different process from that offered by frameworks such as [Hug](https://github.com/hugapi/hug), which generates a specification after you've written the code. Some disadvantages of generating specifications based on code is that they often end up LACKING DETAILS or MIX YOUR DOCUMENTATION WITH THE CODE LOGIC of your application.

        以 Flask-RESTPlus 而言，程式確實會混雜很多 decorator；不過透過模組化應該可以緩解?

## 新手上路 {: #getting-started }

  - [Quickstart — Connexion 2\.0 documentation](https://connexion.readthedocs.io/en/latest/quickstart.html) #ril

## 參考資料 {: #reference }

  - [zalando/connexion - GitHub](https://github.com/zalando/connexion)

文件：

  - [Connexion’s Documentation - Read the Docs](https://connexion.readthedocs.io/)

相關：

  - 強調先寫 [OpenAPI/Swagger](swagger.md) specification 與其他先寫 Python code (例如 [Flask-RESTPlus](flask-restplus.md)) 的做法不同。
