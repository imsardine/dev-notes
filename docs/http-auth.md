---
title: HTTP / Authentication
---
# [HTTP](http.md) / Authentication

  - [HTTP authentication \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication) #ril

      - HTTP provides a GENERAL FRAMEWORK for ACCESS CONTROL and AUTHENTICATION. The most common HTTP authentication is based on the "Basic" SCHEMA. This page shows an introduction to the HTTP framework for authentication and shows how to restrict access to your server using the HTTP "Basic" schema.

        下面 Authentication schemes 一開始提到 The general HTTP authentication framework is used by several authentication schemes 大概因為所有的 authentication scheme 都用 `WWW-Authenticate` 與 `Authorization` 兩個 header 在運作，所以才說是 general framework。

        只有這裡講 schema，接下來都講 scheme ??

    The general HTTP authentication framework

      - RFC 7235 defines the HTTP authentication framework which can be used by a server to CHALLENGE a client request and by a client to provide authentication information.

      - The CHALLENGE AND RESPONSE FLOW works like this: The server responds to a client with a `401` (Unauthorized) response status and provides information on HOW TO AUTHORIZE with a `WWW-Authenticate` response header containing at least one CHALLENGE.

        雖然 `WWW-Authenticat` 裡放的是 authentication scheme，但這跟接下來 client 要如何代為盤問 (challenge) 使用者有關，所以才會有 "at least one challenge" 的說法。

        A client that wants to authenticate itself with a server can then do so by including an `Authorization` request header field with the credentials. Usually a client will present a password prompt to the user and will then issue the request including the correct `Authorization` header.

        ![](https://mdn.mozillademos.org/files/14689/HTTPAuth.png)

        In the case of a "Basic" authentication like shown in the figure, the exchange must happen over an HTTPS (TLS) connection to be secure.

    Authentication schemes

      - The general HTTP authentication framework is used by several authentication schemes. Schemes can differ in security strength and in their availability in client or server software.

      - The most common authentication scheme is the "Basic" authentication scheme which is introduced in more details below. IANA maintains a list of authentication schemes, but there are other schemes offered by HOST SERVICES, such as Amazon AWS. Common authentication schemes include:

          - `Basic` (see RFC 7617, base64-encoded credentials. See below for more information.),

          - `Bearer` (see RFC 6750, bearer tokens to access OAuth 2.0-protected resources),

            [1.2. Terminology - RFC 6750 \- The OAuth 2\.0 Authorization Framework: Bearer Token Usage](https://tools.ietf.org/html/rfc6750#section-1.2)

            > Bearer Token - A security token with the property that any party in possession of the token (a "bearer") can use the token in any way that ANY OTHER party in possession of it can. Using a bearer token does not require a bearer to prove possession of cryptographic key material (proof-of-possession).

            其實也不一定跟 OAuth 2.0 有關，不像 `Basic` 需要出示真正的 credentials，只認 token 不認人。

          - `Digest` (see RFC 7616, only md5 hashing is supported in Firefox, see bug 472823 for SHA encryption support),
          - `HOBA` (see RFC 7486, Section 3, HTTP Origin-Bound Authentication, digital-signature-based),
          - `Mutual` (see RFC 8120),
          - `AWS4-HMAC-SHA256` (see AWS docs).

  - [Challenge\-response authentication \- MDN Web Docs Glossary: Definitions of Web\-related terms \| MDN](https://developer.mozilla.org/en-US/docs/Glossary/challenge) #ril

## 新手上路 {: #getting-started }

  - [httpbin\(1\): HTTP Client Testing Service](https://httpbin.org/) 用 `/basic-auth/:user/:passwd` 測試?

## Authentication Flow, Method/Scheme ??

  - [HTTP authentication \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication)
      - 流程 (challenge and response flow) 上，server 會先回應 401 (Unauthorized) 並透過 `WWW-Authenticate` response header 提供 "how to authorize" 的資訊 -- 裡面至少有一個 "口令" (challenge)，接著 client 再送出一個 request 並附上 `Authorization` request header，內含 credentials (可能經過編碼)。此時若驗證失敗，會得到 403 Forbidden。
      - 流程圖以 Basic authentication 舉例 (走 HTTPS (TLS) 才安全)，401 帶 `WWW-Authenticate: Basic realm="Access to the staging site"`，之後再送一次 request 帶 `Authorization: Basic XYZ12345...`；所以接下來所有 request 都要帶 `Authorization` 這個 header 才行。
  - [WWW-Authenticate and Proxy-Authenticate headers - HTTP authentication \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#WWW-Authenticate_and_Proxy-Authenticate_headers) #ril
      - `WWW-Authenticate` response header 定義了存取該 resource 的 authentication method；正確地來說，是指明要採用的 authentication scheme，這樣 client 才知到要如何提供 credentials。
      - 語法是 `WWW-Authenticate: <type> realm=<realm>`，其中 `<type>` 就是 authentication scheme (以 `Basic` 最為常見)，而 `<realm>` 則用來描述 "protected area" 或 "scope of protection"，實務上會成為使用者會看到的訊息，例如 "Access to the staging site"，得以判斷正要存取哪個 space 的資源。
      - `Authorization` request header 包含 credentials，語法上是 `Authorization: <type> <credentials>`，其中 `<type>` 跟 `WWW-Authenticate` 中的一樣，不過後面 `<credentials>` 的寫法 (是否需要 encode/encrypt) 則依 authentication scheme 而定。
  - [Authentication schemes - HTTP authentication \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#Authentication_schemes) #ril

## Basic Authentication

  - [Basic Authentication \- Swagger](https://swagger.io/docs/specification/authentication/basic-authentication/) #ril

      - Basic authentication 是內建在 HTTP potocol 裡的驗證方案 (scheme) -- client 送出 HTTP request 時帶有 `Authorization` header，內容是 `Basic CREDENTIAL`，其中 `CREDENTIAL` 是 `username:password` 做過 Base64 encoding 的結果，例如 `demo / p@55w0rd` 要送出 `Authorization: Basic ZGVtbzpwQDU1dzByZA==`。
      - 由於 Base64 很容易 decode，所以只應用在安全的連線，例如 HTTPS/SSL。

  - [Basic access authentication \- Wikipedia](https://en.wikipedia.org/wiki/Basic_access_authentication) #ril

  - [Authorization \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization)

      - The HTTP `Authorization` request header contains the credentials to AUTHENTICATE a user agent with a server, usually AFTER the server has responded with a `401 Unauthorized` status and the `WWW-Authenticate` header.

    Syntax

            Authorization: <type> <credentials>

    Directives

      - `<type>

        AUTHENTICATION type. A common type is `Basic`. Other types:

          - IANA registry of Authentication schemes
          - Authentification for AWS servers (`AWS4-HMAC-SHA256`)

        只有 header name 是 authorization，這裡講的都是 authentication ??

      - `<credentials>`

        If the `Basic` authentication scheme is used, the credentials are constructed like this:

          - The username and the password are combined with a colon (`aladdin:opensesame`).
          - The resulting string is base64 encoded (`YWxhZGRpbjpvcGVuc2VzYW1l`).

        Note: Base64 encoding does not mean encryption or hashing! This method is equally secure as sending the credentials in clear text (base64 is a reversible encoding). Prefer to use HTTPS in conjunction with Basic Authentication.

## Digest Access Authentication ??

  - [Digest access authentication \- Wikipedia](https://en.wikipedia.org/wiki/Digest_access_authentication) #ril
  - [RFC 7616 \- HTTP Digest Access Authentication](https://tools.ietf.org/html/rfc7616) #ril

## 參考資料 {: #reference }

手冊：

  - [RFC 7235 - Hypertext Transfer Protocol (HTTP/1.1): Authentication](https://tools.ietf.org/html/rfc7235)
  - [RFC 7616 - HTTP Digest Access Authentication](https://tools.ietf.org/html/rfc7616)
