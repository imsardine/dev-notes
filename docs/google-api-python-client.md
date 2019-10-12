---
title: Google APIs / Python Client
---
# [Google APIs](google-api.md) / Python Client

  - [API Client Library for Python  \|  Google Developers](https://developers.google.com/api-client-library/python/)

    Call Google APIs simply. Use the simple, clean library to make calls from Python to one of the many supported Google APIs. This example uses the Google+ API:

        # List my public Google+ activities.
        result = service.activities().list(userId='me', collection='public').execute()
        tasks = result.get('items', [])
        for task in tasks:
          print task['title']

## 新手上路 ?? {: #getting-started }

  - [Building and calling a service - Getting Started  \|  API Client Library for Python  \|  Google Developers](https://developers.google.com/api-client-library/python/start/get_started#building-and-calling-a-service)

    Build the service object

      - Whether you are using simple or authorized API access, you use the `build()` function to create a SERVICE OBJECT. It takes an API name and API version as arguments. You can see the list of all API versions on the Supported APIs page. The service object is constructed with methods specific to the given API. To create it, do the following:

            from googleapiclient.discovery import build
            service = build('api_name', 'api_version', ...)

        雖然這裡稱 service object，但 [`build()`](http://googleapis.github.io/google-api-python-client/docs/epy/googleapiclient.discovery-module.html#build) 的 API 文件是寫 "Returns: A RESOURCE object with methods for interacting with the service."，但確實可以把最頂層的 resource 視為 service (object) 沒錯。

    Collections

      - Each API service provides access to one or more RESOURCES. A set of resources of the same type is called a COLLECTION. The names of these collections are specific to the API. The service object is constructed with a function for every collection defined by the API. If the given API has a collection named `stamps`, you create the collection object like this:

            collection = service.stamps()

        It is also possible for collections to be nested:

            nested_collection = service.featured().stamps()

        不太懂 "The service object is constructed with a function ..." 這樣的說法，service object 不是透過上面的 `build()` 產生了嗎? 或許可以把 "service object" 都解讀為 resource，只是層級不同? 以 [Drive API](https://developers.google.com/resources/api-libraries/documentation/drive/v3/python/latest/) 的 `files()` 為例，作用也是 "Returns the files RESOURCE."

        也就是面對下面有不同 resource 時，我們稱 service，面對一群同型態的 resource 時，我們則稱 collection，但底層都是 resource。

    Methods and requests

      - Every collection has a list of methods defined by the API. Calling a collection's method returns an `HttpRequest` object. (還沒有真的送出) If the given API collection has a method named `list` that takes an argument called `cents`, you create a request object for that method like this:

            request = collection.list(cents=5)

    Execution and response

      - Creating a request DOES NOT ACTUALLY CALL THE API. To execute the request and get a response, call the `execute()` function:

            response = request.execute()

        Alternatively, you can combine previous steps on a single line:

            response = service.stamps().list(cents=5).execute()

    Working with the response

      - The response is a Python object BUILT FROM THE JSON RESPONSE sent by the API server. The JSON structure is specific to the API; for details, see the API's reference documentation. You can also simply print the JSON to see the structure:

            import json
            ...
            print json.dumps(response, sort_keys=True, indent=4)

        For example, if the printed JSON is the following: 真的就是單純的資料結構

            {
                "count": 2,
                "items": [
                    {
                        "cents": 5,
                        "name": "#586 1923-26 5-cent blue Theodore Roosevelt MLH perf 10"
                    },
                    {
                        "cents": 5,
                        "name": "#628 1926 5-cent Ericsson Memorial MLH"
                    }
                ]
            }

        You can access the data like this:

            print 'Num 5 cent stamps: %d' % response['count']
            print 'First stamp name: %s' % response['items'][0]['name']

  - [Python Quickstart  \|  Sheets API  \|  Google Developers](https://developers.google.com/sheets/api/quickstart/python) 這裡的 `service.spreadsheets().values().get()` 呼應 Sheets API 的文件 #ril
  - [Method: spreadsheets\.values\.get  \|  Sheets API  \|  Google Developers](https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/get) #ril

## Authentication ??

  - [Authentication and authorization - Getting Started  \|  API Client Library for Python  \|  Google Developers](https://developers.google.com/api-client-library/python/start/get_started#authentication-and-authorization)

      - It is important to understand the basics of how API authentication and authorization are handled. All API calls must use either SIMPLE or AUTHORIZED access (defined below). Many API methods require authorized access, but some can use either. Some API methods that can use either behave differently, depending on whether you use simple or authorized access. See the API's method documentation to determine the appropriate access type.

    Simple API access (API keys)

      - These API calls DO NOT access any private user data. Your application must AUTHENTICATE ITSELF AS AN APPLICATION belonging to your Google API Console project. This is needed to measure project usage for accounting purposes.

      - API key: To authenticate your application, use an API key for your API Console project. Every simple access call your application makes must include this key.

        Warning: Keep your API key private. If someone obtains your key, they could use it to consume your quota or incur charges against your API Console project.

    Authorized API access (OAuth 2.0)

      - These API calls access PRIVATE USER DATA. Before you can call them, the user that has access to the private data must GRANT YOUR APPLICATION ACCESS. Therefore, your application must be authenticated, the user must grant access for your application, and the user must be authenticated in order to grant that access. All of this is accomplished with OAuth 2.0 and libraries written for it.

        除了像 API key 要認證 application 本身之外，還要使用者授權 (grant access)，當然使用者自己也要先通過認證才能授權。

      - Scope: Each API defines one or more scopes that declare A SET OF OPERATIONS PERMITTED. For example, an API might have read-only and read-write scopes. When your application requests access to user data, the request must include one or more scopes. The user needs to approve the scope of access your application is requesting.

      - Refresh and access tokens: When a user grants your application access, the OAuth 2.0 authorization server provides your application with REFRESH AND ACCESS TOKENS. These tokens are only valid for the scope requested. Your application uses access tokens to authorize API calls. ACCESS TOKENS EXPIRE, BUT REFRESH TOKENS DO NOT. Your application can USE A REFRESH TOKEN TO ACQUIRE A NEW ACCESS TOKEN.

        Warning: Keep refresh and access tokens private. If someone obtains your tokens, they could use them to access private user data.

      - Client ID and client secret: These strings uniquely IDENTIFY YOUR APPLICATION and are used to ACQUIRE TOKENS. They are created for your project on the API Console. There are three types of client IDs, so be sure to get the correct type for your application:

          - Web application client IDs ??
          - Installed application client IDs ??
          - Service Account client IDs

        不過 server-to-server 的應用，好像不會涉及 client ID 與 client secret? 而 client secret 指的該不會是 service account credentials?? 裡面就有 `client_id` (值等同 service account 的 unique ID)。

        Warning: Keep your client secret private. If someone obtains your client secret, they could use it to consume your quota, incur charges against your Console project, and request access to user data.

## Pagination ??

  - [Pagination  \|  API Client Library for Python  \|  Google Developers](https://developers.google.com/api-client-library/python/guide/pagination) #ril

      - Some API methods may return very large lists of data. To reduce the response size, many of these API methods support PAGINATION. With paginated results, your application can iteratively request and process large lists one page at a time. For API methods that support it, there exist similarly named methods with a "`_next`" suffix. For example, if a method is named `list()`, there may also be a method named `list_next()`. These methods can be found in the API's PyDoc documentation on the Supported APIs page.
      - To process the first page of results, create a request object and call `execute()` as you normally would. For further pages, you call the corresponding `method_name_next()` method, and pass it the PREVIOUS REQUEST AND RESPONSE. Continue paging until `method_name_next()` returns `None`.

        In the following code snippet, the paginated results of a Google Plus activities `list()` method are processed:

            activities = service.activities()
            request = activities.list(userId='someUserId', collection='public')

            while request is not None:
              activities_doc = request.execute(http=http)

              # Do something with the activities

              request = activities.list_next(request, activities_doc)

        Note that you only call `execute()` on the request once INSIDE THE WHILE LOOP.

        把 request 跟 response 傳進 `xxx_next()` 的做法好奇特，內部方便從 response 分析需不需要有下一個 request。

## 安裝設置 {: #setup }

  - [Installation  \|  API Client Library for Python  \|  Google Developers](https://developers.google.com/api-client-library/python/start/installation)

      - Python 2.7, or 3.4 or higher
      - `pip install --upgrade google-api-python-client`

## 參考資料 {: #reference }

  - [googleapis/google-api-python-client - GitHub](https://github.com/googleapis/google-api-python-client)
  - [google-api-python-client - PyPI](https://pypi.org/project/google-api-python-client/)

文件：

  - [Sample Code](https://github.com/googleapis/google-api-python-client/tree/master/samples)

手冊：

  - [API Documentation](http://googleapis.github.io/google-api-python-client/docs/epy/index.html)
  - [`googleapiclient.discovery.build()`](http://googleapis.github.io/google-api-python-client/docs/epy/googleapiclient.discovery-module.html#build)
  - [Supported Google APIs](https://developers.google.com/api-client-library/python/apis/)
