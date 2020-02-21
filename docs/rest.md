# REST (REpresentational State Transfer)

  - REST = REpresentational State Transfer。
  - REST 的命名是為了喚起 well-behaved web application 應有的樣子 - web application 是一個由 a network of web resources 組成的 virtual state-machine，對某個 resource 的存取/操作 (內部發生 state transition)，會導致把 next state 的 representation 移轉 (transfer) 給使用者。
  - REST 是一種 architectural style 而非 standard，提出了 6 點架構上的要求 (architectural constraints) - client-server architecture、statelessness、cacheability、layered system、code on demand (optional) 與 uniform interface，設計上符合 REST architecture constraints 的 web service API 就稱做 RESTful API，而 HTTP-based RESTful API 只是其種一種實現方式。

參考資料：

  - Representational state transfer - Wikipedia https://en.wikipedia.org/wiki/Representational_state_transfer
  - APIs & Reference  |  Translation API  |  Google Cloud Platform https://cloud.google.com/translate/docs/apis 出現 "REST API Reference" 的說法，為何不用 RESTful API?

  - http - What exactly is RESTful programming? - Stack Overflow https://stackoverflow.com/questions/671118/ #ril

  - [REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=1)

    - REST (or REpresentational State Transfer) is an ARCHITECTURAL STYLE that evolved as [Fielding](https://en.wikipedia.org/wiki/Roy_Fielding) wrote the HTTP/1.1 and URI specs and has proven to be well-suited for developing DISTRIBUTED hypermedia applications. While REST is more widely applicable, it is most commonly used within the context of communicating with services via HTTP.

## RESTful API 跟 user-friendly URL 的關係?

  - Representational state transfer - Wikipedia https://en.wikipedia.org/wiki/Representational_state_transfer Relationship between URL and HTTP methods 提到 "REST is an architectural style"，而 Uniform interface 這個 constraint 也沒有提到 URL 要怎麼規劃。
  - http - What exactly is RESTful programming? - Stack Overflow https://stackoverflow.com/questions/671118/ Shirgill Farhan Ansari: REST architecture does not require these “pretty URLs”

## 可供測試的 RESTful APIs ??

  - [Postman Echo](https://docs.postman-echo.com/) #ril
  - [toddmotto/public\-apis: A collective list of public JSON APIs for use in web development\.](https://github.com/toddmotto/public-apis) #ril
  - [httpbin\(1\): HTTP Client Testing Service](https://httpbin.org/) #ril
  - [Endpoints for HTTP Testing \| LornaJane](https://lornajane.net/posts/2013/endpoints-for-http-testing) #ril
  - [Mockbin by Mashape](http://mockbin.org/) #ril

## 如何規劃 RESTful API 的 URL?

  - [Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api) #ril
      - 當背後的 data model 已經趨於穩定，想要透過 public API 公開，但 API 一旦公佈之後就很難改動，希望在釋出前就儘量做對。
      - 網路上不乏許多意見，但沒有真正的標準，問題在於選擇太多 ... 如何做 authentication? 要不要做 versioning ... My goal with this post is to describe best practices for a pragmatic API designed for today's web applications. I make no attempt to satisfy a standard if it doesn't FEEL RIGHT. 跟著直覺走，其中以 "It should be friendly to the developer and be explorable via a browser address bar" 的考量最重要 => An API is a developer's UI - just like any UI, it's important to ensure the user's experience is thought out carefully! 關於 browser explorability，在 JSON only responses 一節有句話 "To ensure browser explorability, it should be in the URL." 這說法簡單易懂。
      - The key principles of REST involve separating your API into LOGICAL RESOURCES. These resources are manipulated using HTTP requests where the method (GET, POST, PUT, PATCH, DELETE) has specific meaning.
      - 要如何定義 resource? these should be NOUNS (not verbs!) that make sense from the perspective of the API consumer. Although your internal models may map neatly to resources, it isn't necessarily a ONE-TO-ONE MAPPING. The key here is to not LEAK irrelevant implementation details out to your API! 名詞，從 API consumer 的角度來看，且不一定要跟後端的 data model 有 one-to-one 的對應關係，注意不要洩漏了後端的實作細節。
      - 找出 resource 後，接下來要找出有哪些 action 可以作用在該 resource、如何對應到 API 的操作。RESTful principles 提供了 CRUD action 與 HTTP methods 的對應 (以 ticket 為例)：`GET /tickets` (取得 list of tickets)、`GET /tickets/12` (取得特定 ticket)、`POST /tickets` (建立一個 ticket，注意仍有 `s`)、`PUT /tickets/12` (更新 ticket)、`PATCH /tickets/12` (局部更新 ticket)、`DELETE /tickets/12` (刪除 ticket) -- 利用現有的 HTTP methods，將重要的功能集中在 `/tickets` 同一個 endpoint 下。

  - [API Design – 7 Important Lessons When Designing an API](https://nordicapis.com/7-api-design-lessons-world-tour-roundup/) (2017-11-02) #ril
  - [The Entire API Lifecycle \| Nordic APIs](https://nordicapis.com/envisioning-the-entire-api-lifecycle/) (2015-10-13) #ril
  - [Simple rules for a sane RESTful API design \(Example\)](https://coderwall.com/p/gbxelq/simple-rules-for-a-sane-restful-api-design) (2017-03-30) #ril
  - [RESTful API Designing guidelines — The best practices](https://hackernoon.com/restful-api-designing-guidelines-the-best-practices-60e1d954e7c9) (2017-02-03) #ril
  - [RESTful and User\-Friendly URLs](https://www.artima.com/weblogs/viewpost.jsp?thread=153170) #ril
  - [10 Best Practices for Better RESTful API \| Thinking Mobile](https://blog.mwaysolutions.com/2014/06/05/10-best-practices-for-better-restful-api/) (2014-06-05) #ril
  - [URL Design for RESTful Web Services \| API UX](http://apiux.com/2013/04/03/url-design-restful-web-services/) 在講 API 的 UX #ril
  - Semantic URL - Wikipedia https://en.wikipedia.org/wiki/Semantic_URL #ril

之前 Wonder 提到 GCP 的 translation restful API，發現也是有人不用 namespace 的，且 hostname 也是看用途的命名 https://cloud.google.com/translate/docs/reference/translate
- translation.googleapis.com/language/translate/v2
- translation.googleapis.com/language/translate/v2/detect
- translation.googleapis.com/language/translate/v2/languages

## Resource ??

  - [Resources](http://restful-api-design.readthedocs.io/en/latest/resources.html) #ril

## Relationship ??

  - [But how do you deal with relations? - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api)
      - 如果有從屬關係 (a relation can only exist within another resource)，就把它放 parent 的 endpoint 下，例如 ticket 下有許多 message，可以規劃成 `GET /tickets/12/messages`、`GET /tickets/12/messages/5`。
      - 但如果可以獨立存在 (exist independently of the resource)，就可以在另一個 resource 的 output representation 裡輸出另一個 (independent) resource 的 identifier，也就是 API consumer 需要再打 (hit) 另一個 resource 的 endpoint，若是這樣的 relation 很常用，也可以考慮直接內嵌 (embed) 另一個 resource 的 representation，這樣就可以免除 second hit to the API。
  - [Auto loading related resource representations - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#autoloading) #ril
  - [How to build a good API: Relationships and endpoints](https://medium.com/@factoryhr/how-to-build-a-good-api-relationships-and-endpoints-8b07aa37097c) (2017-01-13) #ril
  - [Relationships](http://restful-api-design.readthedocs.io/en/latest/relationships.html) #ril

## Singular / Plural ??

  - [Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api)
      - Should the endpoint name be singular or plural? 儘管文法上會認為 "it's wrong to describe a single instance of a resource using a plural"，但實務上建議一致採用 plural，不過 "Not having to deal with odd pluralization (person/people, goose/geese) makes the life of the API consumer better" 是不要管特殊的變化型嗎??
  - [REST URI convention \- Singular or plural name of resource while creating it \- Stack Overflow](https://stackoverflow.com/questions/6845772/) #ril

## CRUD 以外的操作，例如 Search、Activate、Star/Unstar ??

  - [What about actions that don't fit into the world of CRUD operations? - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api) 做法有很多種
      - Restructure the action to appear like a field of a resource. 尤其 action 不帶其他參數時，例如 activate 的動作，可以對應 `activated` 欄位，透過 `PATCH` method 做 partial update。
      - Treat it like a sub-resource with RESTful principles. 像 GitHub 的 [star/unstar](http://developer.github.com/v3/gists/#star-a-gist) 分別用 `PUT /gists/:id/star` 與 `DELETE /gists/:id/star` 表現。
      - Sometimes you really have no way to map the action to a sensible RESTful structure. For example, a multi-resource search doesn't really make sense to be applied to a SPECIFIC resource's endpoint. 這種狀況下就用 `/search` 也沒關係，即便它不是個 resource -- 重點還是 "right from the perspective of the API consumer"

## Filtering/Searching, Sorting, Pagination ??

  - [Result filtering, sorting & searching - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#advanced-queries)
      - It's best to keep the base resource URLs as lean as possible. 其他像是 result filtering、sorting、searching 等，建議在 base URL 的基礎上用 query parameters 來實作。
      - Use a unique query parameter for each field that implements filtering. 例如 `GET /tickets?state=open` 可以針對 `state` 過濾。
      - Similar to filtering, a generic parameter `sort` can be used to describe sorting rules. 例如 `GET /tickets?sort=-priority` (用 `-` 來表示 descending)，複雜的排序則可以用逗號隔開多個欄位，例如 `GET /tickets?sort=-priority,created_at`。
      - Sometimes basic filters aren't enough and you need the power of FULL TEXT SEARCH. 也就是說 filtering 也是一種 search，可以用 `q` query parameter 來表示，例如 `GET /tickets?q=return&state=open&sort=-priority,created_at`。
      - To make the API experience more pleasant for the average consumer, consider packaging up sets of conditions into easily accessible RESTful paths. 這個考量還滿特別的 (alias 的概念)，例如 `GET /tickets/recently_closed`。
  - [Pagination - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#pagination) #ril

## Response -- Format, Status Code ??

  - [Updates & creation should return a resource representation - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#useful-post-responses)
      - PUT、POST、PATCH 等會對 underlying resource 造成除了 modification to fileds 外的異動 (例如 `create_at` 或 `updated_at` timestamp)，為了避免 API consumer 必須再呼叫一次 API 以取得 updated representation，API 的 response 應該帶有 updated/created representation。
      - 依照 [RFC 2616](https://www.ietf.org/rfc/rfc2616.txt) Hypertext Transfer Protocol -- HTTP/1.1 的說法 -- If a resource has been created on the origin server, the response SHOULD be 201 (Created) and contain an entity which describes the status of the request and refers to the new resource, and a Location header，所以 response 要帶 created representation 嗎?
  - [Should you HATEOAS? - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#hateoas) #ril
      - 這裡討論 links (指 URL to resources?) 該由 API consumer 自己串接，還是該由 API 提供? 
  - [snake_case vs camelCase for field names - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#snake-vs-camel) #ril
  - [Pretty print by default & ensure gzip is supported - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#pretty-print-gzip) #ril
  - [Don't use an envelope by default, but make it possible when needed - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#envelope) #ril
  - [JSON encoded POST, PUT & PATCH bodies - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#json-requests) #ril

## Partial Response ??

  - [Limiting which fields are returned by the API - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#limiting-fields)
      - API consumer 不一定總是需要 resource 的 FULL representation，能夠讓 consumer 選定要傳回哪些 fields，可以簡少 network traffic，同時也加速 response。
      - 用 `fields` query paramter 羅列要傳回哪些 fields，例如 `GET /tickets?fields=id,subject,customer_name,updated_at&state=open&sort=-updated_at`。
  - [RESTful API Design: can your API give developers just the information they need? \| Apigee](https://apigee.com/about/blog/technology/restful-api-design-can-your-api-give-developers-just-information-they-need) (2011-12-23) #ril
  - [Partial Response in RESTful API Design \| Yaogang Lian](http://yaoganglian.com/2013/07/01/partial-response/) (2013-07-01) #ril
  - [Working with partial resources - Performance Tips  \|  Drive REST API  \|  Google Developers](https://developers.google.com/drive/api/v3/performance#partial) #ril
  - [gregwhitaker/catnap: Partial JSON response framework for RESTful web services](https://github.com/gregwhitaker/catnap) #ril
  - [json \- REST \- Partial Resources \- Stack Overflow](https://stackoverflow.com/questions/32855356/) #ril
  - [Partial response \(includes and excludes\)](https://dev.targetprocess.com/docs/partial-response-includes-and-excludes) #ril
  - [3 Ways to Make Your API Responses Flexible \- The Zapier Engineering Blog \| Zapier](https://zapier.com/engineering/flexible-api-responses/) (2017-01-05) 最後提到 GraphQL #ril

## Throttling ??

  - [Rate limiting - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#rate-limiting) #ril
  - [Everything You Need To Know About API Rate Limiting \| Nordic APIs \|](https://nordicapis.com/everything-you-need-to-know-about-api-rate-limiting/) (2019-04-18) #ril

## Caching ??

  - [Caching - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#caching) #ril

## Documentation ??

  - 常用的工具有 [API Blueprint](https://apiblueprint.org/)、[Swagger](https://swagger.io/)、[RAML](https://raml.org/)。
  - API Blueprint 支持 Markdown 似乎不錯?
  - 從 code 來產生 API 文件，在實務上會有什麼問題嗎?
  - 是否該考量 OpenAPI 的標準?

參考資料：

  - [Documentation - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#docs)
      - An API is only as good as its documentation. 這說法簡潔有力! 重點是容易存取 -- 不要用 PDF、不需要登入 (sign in)
      - 提供具備 complete request/response cycles 的文件，最好是 pastable -- 可以貼到網址列的 URL 或是 curl 指令，這方面 GitHub 跟 Stripe 做得很好。
      - Once you release a public API, you've committed to not breaking things without notice. 提到 "deprecation schedules" 的概念，有異動應透過 blog 跟 mailing list 通知。
  - OpenAPI-Specification/README.md at master · OAI/OpenAPI-Specification https://github.com/OAI/OpenAPI-Specification/blob/master/README.md #ril

## Errors ??

  - [Errors - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#errors)

      - Just like an HTML error page shows a useful error message to a visitor, an API should provide a USEFUL error message in a KNOWN CONSUMABLE FORMAT. The representation of an error should be NO DIFFERENT than the representation of any resource, just with ITS OWN SET of fields.

        這跟 API 的 UX 有關。

      - The API should always return sensible HTTP status codes. API errors typically break down into 2 types: 400 series status codes for client issues & 500 series status codes for server issues.

        At a minimum, the API should standardize that all 400 series errors come with consumable JSON error representation. If possible (i.e. if load balancers & reverse proxies can create custom error bodies), this should EXTEND to 500 series status codes.

      - A JSON error body should provide a few things for the developer - a useful error message, a unique error code (that can be looked up for more details IN THE DOCS) and possibly a detailed description. JSON output representation for something like this would look like:


            {
              "code" : 1234,
              "message" : "Something bad happened :(",
              "description" : "More details about the error here"
            }

      - Validation errors for `PUT`, `PATCH` and `POST` requests will need a FIELD BREAKDOWN. This is best modeled by using a fixed top-level error code for validation failures and providing the detailed errors in an additional `errors` field, like so:


            {
              "code" : 1024,
              "message" : "Validation Failed",
              "errors" : [
                {
                  "code" : 5432,
                  "field" : "first_name",
                  "message" : "First name cannot have fancy characters"
                },
                {
                   "code" : 5622,
                   "field" : "password",
                   "message" : "Password cannot be blank"
                }
              ]
            }

        這又更進一步，要一次提示多個欄位的問題；也跟 API UX 有關。

  - [REST API Error Handling Best Practices](http://blog.restcase.com/rest-api-error-codes-101/) (2015-12-10) 不要過度濫用 status code，用 200、400、500 應該就夠了。FB  #ril
  - [Documenting status and error codes \| Document REST APIs](http://idratherbewriting.com/learnapidoc/docapis_doc_status_codes.html) #ril

## Versioning??

  - 採 `/<version>/<endpoint>` 或 `/<endpoint>/<version>`，應該是前著，因為一個 version 下會怎麼拆分不同的 endpoints 會依 version 不同。

參考資料：

  - [Versioning - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#versioning)
      - Always version your API. Versioning helps you ITERATE FASTER and prevents invalid requests from hitting updated endpoints. 避免卡到自己。
      - An API is never going to be completely stable. Change is inevitable. What's important is how that change is MANAGED.
      - 但 version 應該放 header 還是 URL? 學術上認為要放 header，但基於 "be explorable via a browser address bar" 的考量，選擇放 URL。
      - 作者很喜歡 [Stripe 在 API versioning 這方面的做法](https://stripe.com/docs/api#versioning) -- URL 只有 major version (例如 `/v1/`)，但發生 backwards-incompatible changes 時，會釋出 dated version (例如 `2018-07-27`)，平常 request 會採用 API settings 裡指定的 dated version，但也可以透過 `Stripe-Version` header 指定。
  - [Versioning a REST API \| Baeldung](http://www.baeldung.com/rest-versioning) #ril

## Tools

  - [mozilla/agithub: Agnostic Github client API \-\- An EDSL for connecting to REST servers](https://github.com/mozilla/agithub) 可以做 rapid prototyping #ril

## 參考資料 {: #rerference }

  - [REST API and Beyond](http://blog.restcase.com/)

社群：

  - ['rest' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/rest)

更多：

  - [Security](rest-security.md)

