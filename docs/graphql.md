# GraphQL

  - 做為 [REST](rest.md) 的替代方案，它讓 client 得以指定 (dictate) 需要哪些資料，避開 over-fetching/under-fetching of data 的問題；這一點讓我想到 [DTO](dto.md) 很需要 client 端能描述需要拿多少資料，尤其是 relationship 要不要往下展開之類的...

---

參考資料：

  - [GraphQL \- Wikipedia](https://en.wikipedia.org/wiki/GraphQL)

      - GraphQL is an open-source DATA QUERY AND MANIPULATION LANGUAGE for APIs, and A RUNTIME for fulfilling queries with existing data.

        這裡的 "a runtime" 指的是支援這種溝通方式的 server side。

      - GraphQL was developed internally by Facebook in 2012 before being publicly released in 2015. On 7 November 2018, the GraphQL project was moved from Facebook to the newly-established GraphQL Foundation, hosted by the non-profit Linux Foundation.

      - It provides an efficient, powerful and flexible approach to developing web APIs, and has been compared and contrasted with REST and other web service architectures. It ALLOWS CLIENTS TO DEFINE THE STRUCTURE OF THE DATA REQUIRED, and exactly the same structure of the data is returned from the server, therefore preventing EXCESSIVELY large amounts of data from being returned, but this has implications for how effective WEB CACHING of query results can be.

        The flexibility and richness of the query language also adds complexity that MAY NOT BE WORTHWHILE for simple APIs. It consists of a TYPE SYSTEM, query language and execution semantics, static validation, and type introspection.

        要給 client 這樣的彈性，自然增加了 server 的複雜性，上面 "how effective web caching of query results can be" 確實會是個問題，因為查詢方式變得多樣，將結果快取下來也不一定有機會被用上。

      - GraphQL supports reading, writing (mutating) and SUBSCRIBING TO CHANGES TO DATA (realtime updates). #ril

      - Major GraphQL clients include [Apollo Client](https://www.apollographql.com/docs/react/) and [Relay](https://facebook.github.io/relay/).

        GraphQL servers are available for multiple languages, including Haskell, [JavaScript](https://github.com/graphql/graphql-js), [Python](https://graphene-python.org/), Ruby, Java, C#, Scala, Go, [Elixir](http://absinthe-graphql.org/), Erlang, PHP, R, and Clojure.

        Server side 的支援明顯比 client side 多，但為何 client side 只提供 JavaScript 方案 ?? server side 也可能要存取另一個 GraphQL API。

      - On 9 February 2018, the GraphQL Schema Definition Language (SDL) was made part of the specification.

  - [GraphQL \| A query language for your API](https://graphql.org/)

      - Describe your data

            type Project {
              name: String
              tagline: String
              contributors: [User]
            }

        Ask for what you want

            {
              project(name: "GraphQL") {
                tagline
              }
            }

        Get predictable results

            {
              "project": {
                "tagline": "A query language for APIs"
              }

    A query language for your API

      - GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data.

        GraphQL provides a COMPLETE AND UNDERSTANDABLE DESCRIPTION OF THE DATA in your API, gives clients the power to ASK FOR EXACTLY WHAT THEY NEED AND NOTHING MORE, makes it EASIER TO EVOLVE APIs OVER TIME, and enables powerful developer tools.

        其中 "easier to evolve APIs over time" 應該是因為只要定義好 data type，需要哪些資料就由 client 決定，不用為了不同的需求增加專用的 endpoint -- GraphQL 只有一個 endpoint。

    Ask for what you need, get exactly that

      - Send a GraphQL query to your API and get exactly what you need, nothing more and nothing less. GraphQL queries always return PREDICTABLE results. Apps using GraphQL are FAST AND STABLE because they control the data they get, not the server.

        快可以理解，但 stable 就不太懂了 ??

    Get many resources in a single request

      - GraphQL queries access not just the properties of one resource but also smoothly FOLLOW REFERENCES between them.

        While typical REST APIs require LOADING FROM MULTIPLE URLs, GraphQL APIs get all the data your app needs in a single request. Apps using GraphQL can be quick even on slow mobile network connections.

        這可能是 RESTful API 天生的弱點，因為 RESTful 以 resource 的角度出發，不同的 resource 就有不同的 URL，所以要處理有關聯的不同 resource，就得發出多個 request。

        右側的動畫說明傳入：

            {
              hero {
                name
                friends {
                  name
                }
              }
            }

        就能一次拿到：

            {
              "hero": {
                "name": "Luke Skywalker",
                "friends": [
                  { "name": "Obi-Wan Kenobi" },
                  { "name": "R2-D2" },
                  { "name": "Han Solo" },
                  { "name": "Leia Organa" }
                ]
              }
            }

    Describe what’s possible with a type system

      - GraphQL APIs are ORGANIZED IN TERMS OF TYPES AND FIELDS, NOT ENDPOINTS. Access the full capabilities of your data from a SINGLE ENDPOINT.

        很難想像單一個 endpoint 除了查詢資料外，還能應付資料的修改、其他操作 ??

      - GraphQL uses types to ensure Apps only ask for what’s possible and provide clear and helpful errors. Apps can USE TYPES TO AVOID WRITING MANUAL PARSING CODE.

        類似 [Protocol Buffers](https://developers.google.com/protocol-buffers/)，有了 type 就可以產生 parsing code，減少人為出錯的機會。

    Move faster with powerful developer tools

      - Know exactly what data you CAN request from your API without leaving your editor, highlight potential issues BEFORE SENDING A QUERY, and take advantage of improved code intelligence.

        GraphQL makes it easy to build powerful tools like [GraphiQL](https://github.com/graphql/graphiql) by leveraging your API’s type system.

        就 RESTful API 而言，如果有提供 OpenAPI/Swagger Specification 的話，一樣能做到類似的事。

    Evolve your API without versions

      - Add new fields and types to your GraphQL API WITHOUT IMPACTING EXISTING QUERIES. Aging fields can be deprecated and hidden from tools.

        過去 RESTful API 增加欄位會出事嗎? 應該是檢查得太嚴格?

        By using a SINGLE EVOLVING VERSION, GraphQL APIs give apps CONTINUOUS ACCESS to new features and encourage cleaner, more maintainable server code.

    Who’s using GraphQL?

      - Facebook's mobile apps have been powered by GraphQL since 2012. A GraphQL spec was open sourced in 2015 and is now available in many environments and used by teams of all sizes.

        [Who's Using \| GraphQL](https://graphql.org/users/) 展開有點驚人。

## 新手上路 {: #getting-started }

  - [Code \| GraphQL](https://graphql.org/code/) #ril
  - [GraphQL Best Practices \| GraphQL](http://graphql.org/learn/best-practices/) #ril

## 工具 {: #tools }

  - [graphql/graphiql: An in\-browser IDE for exploring GraphQL\.](https://github.com/graphql/graphiql)

## 參考資料 {: #reference }

  - [GraphQL](https://graphql.org/)
  - [facebook/graphql - GitHub](https://github.com/facebook/graphql)
  - [Facebook GraphQL - GitHub](https://github.com/graphql)

社群：

  - ['graphql' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/graphql)
  - [GraphQL (@GraphQL) | Twitter](https://twitter.com/GraphQL)

相關：

  - [RESTful API](rest.md) / [Swagger](swagger.md)

手冊：

  - [APIs-guru/graphql-apis](https://github.com/APIs-guru/graphql-apis) - 支援 GraphQL 的 APIs。
