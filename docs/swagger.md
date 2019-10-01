# Swagger

  - Swagger 唸做 [‵swæɡɚ]，意思是 "昂首闊步"。
  - 做為 OpenAPI Specification (OAS，舊稱 Swagger Specification) 的 API tooling，照顧到了整個 API development/delivery lifecycle - design (Swagger Editor)、build (Swagger Codegen)、documentation (Swagger UI)、test 與 deployment。
  - 背後是 SmartBear，自稱最懂 API，因為 SoapUI 也是產品之一。

參考資料：

  - [World's Most Popular API Framework \| Swagger](https://swagger.io/) 最流行的 API tooling (就 OpenAPI Specification(OAS) 而言)，橫跨整個 API development/delivery lifecycle - design、documentation、test 跟 deployment。背後的公司是 SmartBear，同時也是 SoapUI 建造者。怎會有 "framework of API developer tools" 這種既是 framework 又是 tool 的說法??
  - [Getting Started with Swagger \[I\] \- What is Swagger? \- Swagger](https://swagger.io/blog/getting-started-with-swagger-i-what-is-swagger/) (2015-08-27) #ril
  - [Documenting APIs: A guide for technical writers \| Document REST APIs](http://idratherbewriting.com/learnapidoc/) 寫 API 文件是 technical writers 的工作之一，花了很大的篇幅在講 OpenAPI specification and Swagger #ril

## OpenAPI Specification (OAS)

  - OpenAPI Specification (OAS) 是一種描述 RESTful API 的格式 (舊稱 Swagger Specification)，也就是 RESTful contract for your API；包括 endpoints、operations、input parameters、output、authentication 等。
  - OpenAPI file 可以用 JSON 或 YAML 寫，跟程式語言無關 (language-agnostic)，強調 human & machine readable。

參考資料：

  - [World's Most Popular API Framework \| Swagger](https://swagger.io/) 一開始就提到 "framework of API developer tools for the OpenAPI Specification (OAS)"，之前叫做 Swagger Specification。所謂 specification 就是 "RESTful contract for your API"，用 human & machine-readable format 描述 resources & operations。另外在 Tried & Trusted 提到 "accepted standard for describing RESTful APIs" 且大量被採用。
  - [About Swagger Specification \| Documentation \| Swagger](https://swagger.io/docs/specification/about/) 一種 API description format，可以用 JSON 或 YAML 寫。一個 OpenAPI file 用來描述整個 API，包括 endpoints (例如 `/users`)、operations (例如 `GET /users`、`POST /users`)、就 operation 有哪些 input parameters 及 output、驗證的方式 (authentication)、聯絡方式、授權等。
  - [OpenAPI Specification \- Wikipedia](https://en.wikipedia.org/wiki/OpenAPI_Specification) 做為 interface file 的 specification #ril
  - [OpenAPI Specification \| Swagger](https://swagger.io/specification/) 文件好長，像是參考手冊 #ril

## OpenAPI Specification 與 RAML、API Blueprint?

  - 2015 年 SmartBear 藉 Linux Foundation 的贊助創了一個 Open API Initiative (OAI)，並把 Swagger Specification 捐給該組織，當時 RAML 與 API Blueprint 也在考慮之列。
  - 或許是因為 Swagger 在 API tooling 這一塊持續耕耕，Swagger Specification 在 2016 更名為 OpenAPI Specification，之後 2017 RAML (RESTful API Modeling Language) 的主要開發商 MuleSoft 也加入 OAI 並開源自己的工具，可以從 RAML 轉出 OAS。整個局勢看來已是 OAS 的天下。 

參考資料：

  - [OpenAPI Specification \- Wikipedia](https://en.wikipedia.org/wiki/OpenAPI_Specification) 2015 SmartBear 藉由 Linux Foundation 的贊助起了一個 Open API Initiative (OAI) 的組織，並把 Swagger Specification 捐給該組織 (當時 RAML 與 API Blueprint 也在考慮之列)，2016 更名為 OpenAPI Specification，2017 RAML (RESTful API Modeling Language) 的主要開發商 MuleSoft 也加入 OAI 並開源自己的工具，可以從 RAML 轉出 OAS。
  - [Current Members \- Open API Initiative](https://www.openapis.org/membership/members) OAI 的成員很嚇人，有 IBM、Google、Adobe、Microsoft、Atlassian、SAP、Salesforce 等。

## 新手上路 {: #getting-started }

  - 先把 OpenAPI Specification (OAS) 與 Swagger 的關係搞懂。
  - 知道 Swagger Editor、Codegen、UI 各自的用途 - 對應到 API development lifecycle 的哪個階段。

參考資料：

  - [Create Your First OpenAPI Definition with Swagger Editor \| BlazeMeter](https://www.blazemeter.com/blog/create-your-first-openapi-definition-with-swagger-editor) 拿 ipify 的 RESTful API 來塑模 (2017-11-09) #ril
  - [Getting Started with Swagger \- Swagger](https://swagger.io/getting-started/) 提到 API provider & consumer 兩種角色，前者可以用 Swagger Editor 設計，然後用 Swagger Codegen 產生 server stubs/impl.，後者可以用 Swagger Codegen 根據 OpenAPI file 產生 client library。
  - [Writing OpenAPI \(Swagger\) Specification Tutorial \- Part 1 \- Introduction \| API Handyman](https://apihandyman.io/writing-openapi-swagger-specification-tutorial-part-1-introduction/) (2016-03-02) #ril

## Swagger Editor、Codegen、UI、SwaggerHub?

  - [Open Source API Developer Tool Kit \| Swagger](https://swagger.io/tools/) 工具都是 open source，核心的 Swagger Core 是用 Java 寫的。Editor 用於設計 API specification，而 Codegen 將 specification 轉成 server stubs 與 client libraries (支援 40+ 語言)，最後 UI 用於產生 interactive documentation，方便使用者上手。其他還有 Swagger JS、Swagger Node、Swagger Parser、Validator-Badge
  - [API Development Tools \| Swagger Editor \| Swagger](https://swagger.io/swagger-editor/) #ril
  - [API Development Tools \| Swagger Codegen \| Swagger](https://swagger.io/swagger-codegen/) #ril
  - [SwaggerHub Powerful API Design Platform, Built for Teams](https://swaggerhub.com/) 共同協作 API 設計、文件的平台，強調 team、collaboration、workflow #ril
  - [SwaggerHub Plans](https://swaggerhub.com/pricing/) 5 個使用者，月費 $75 鎂。

## Swagger UI {: #ui}

  - [API Development Tools \| Swagger UI \| Swagger](https://swagger.io/swagger-ui/) #ril

## 跟 Test 的關係??

  - [World's Most Popular API Framework \| Swagger](https://swagger.io/) 提到 "enabling development across the entire API lifecycle, from design and documentation, to test and deployment"，在 Swagger Codegen 的簡介中提到可以產生 "server stubs"，應該跟 testing 也有關係??
  - [Online API Testing Tool \| Inspector \| Swagger](https://swagger.io/swagger-inspector/) 一種 API testing tool #ril
  - [Testing an API using Swagger : Assertible](https://assertible.com/blog/testing-an-api-using-swagger) (2017-05-02) #ril

## 跟 Deployment 的關係??

  - [World's Most Popular API Framework \| Swagger](https://swagger.io/) 提到 "enabling development across the entire API lifecycle, from design and documentation, to test and deployment"
  - [Deploy Your API](https://swaggerhub.com/api-deployment/) 提到 AWS API Gateway #ril
  - AWS API Gateway Console 的 Get Started 按下去，提示 "Welcome to Amazon API Gateway. To create your first API, we have pre-populated the import form with a Pet Store API defined using Swagger 2.0. To get started, close this modal and select Import in the Create API form."

## 參考資料 {: #reference }

  - [Swagger](https://swagger.io/)
  - [Swagger - GitHub](https://github.com/swagger-api)
  - [swaggerapi - Docker Hub](https://hub.docker.com/u/swaggerapi/)
  - [Open API Initiative (OAI)](https://www.openapis.org/)
  - [Open API Initiative - GitHub](https://github.com/oai)

社群：

  - [Online Google Forum | Swagger](https://swagger.io/forum/)
  - ['swagger' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/swagger)
  - [Swagger (@SwaggerApi) | Twitter](https://twitter.com/@SwaggerApi)

更多：

  - [OpenAPI Specification](swagger-spec.md)
  - [Codegen](swagger-codegen.md)

手冊：

  - [OpenAPI Specification | Swagger](https://swagger.io/specification/)
