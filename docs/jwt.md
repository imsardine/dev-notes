# JWT (JSON Web Token)

  - [JSON Web Tokens \- jwt\.io](https://jwt.io/)

      - SON Web Tokens are an open, industry standard RFC 7519 method for representing CLAIMS securely between two parties.

      - JWT.IO allows you to decode, verify and generate JWT.

        因為資料只做 Base64 編碼，所以是 decode 不是 decrypt；但要驗證 signature，不就要把 secret 放在 JWT.IO ?? 什麼情況下會有由 JWT.IO 產生 token 的需求??

  - [JSON Web Token \- Wikipedia](https://en.wikipedia.org/wiki/JSON_Web_Token)

      - JSON Web Token (JWT, sometimes pronounced /dʒɒt/ ??) is an Internet standard for creating JSON-based ACCESS TOKENS that ASSERT some number of CLAIMS.

        For example, a server could generate a token that has the CLAIM "logged in as admin" and provide that to a client. The client could then use that token to PROVE that it is logged in as admin.

      - The tokens are SIGNED by one party's private key (usually the server's), so that both parties (the other already being, by some suitable and trustworthy means, in possession of the corresponding public key) are able to VERIFY that the token is LEGITIMATE.

      - The tokens are designed to be COMPACT, URL-SAFE, and usable especially in a web-browser single-sign-on (SSO) context. JWT claims can be typically used to pass identity of authenticated users between an identity provider and a service provider, or any other type of claims as required by business processes.

        反正 SSO 也是拿到一個 token，但 JWT 如果不是靠 cookie，是如何達到 SSO 的??

      - JWT relies on other JSON-based standards: JSON Web Signature and JSON Web Encryption. ??

  - [JSON Web Token Introduction \- jwt\.io](https://jwt.io/introduction/)

    What is JSON Web Token?

      - JSON Web Token (JWT) is an open standard (RFC 7519) that defines a compact and SELF-CONTAINED way for securely transmitting information between parties as a JSON object.

        This information can be VERIFIED and trusted because it is DIGITALLY SIGNED. JWTs can be signed using a SECRET (with the HMAC algorithm) or a public/private key pair using RSA or ECDSA.

        HMAC 是算出 hash，但 public/private key 是對內容加密，後者如何產生 header.payload.signature 中的 signature ??

      - Although JWTs can be ENCRYPTED to also provide secrecy between parties, we will focus on SIGNED TOKENS.

        Signed tokens can verify the INTEGRITY of the claims contained within it, while encrypted tokens hide those claims from other parties. When tokens are signed using public/private key pairs, the signature also certifies that only the party holding the private key is the one that signed it.

        加密並非必要，但至少可以驗證 token (內含 claims) 是可信任的。

    When should you use JSON Web Tokens?

      - Here are some scenarios where JSON Web Tokens are useful:

      - Authorization

        This is the most common scenario for using JWT. Once the user is logged in, each subsequent request will include the JWT, allowing the user to access routes, services, and resources that are permitted with that token.

        也就是 JWT 跟 authentication 無關，而是身份驗證後的 authorization -- 是什麼身份、可以做什麼事。

        Single Sign On is a feature that widely uses JWT nowadays, because of its SMALL OVERHEAD and its ability to be easily used across different domains.

      - Information Exchange

        JSON Web Tokens are a good way of securely transmitting information between parties. Because JWTs can be signed—for example, using public/private key pairs—you can be sure the senders are who they say they are.

        Additionally, as the signature is calculated using the header and the payload, you can also verify that the content hasn't been tampered with.

        有夾帶額外資訊的能力 (又可驗證)，增加了 JWT 的應用能力。

    Why should we use JSON Web Tokens?

      - Let's talk about the benefits of JSON Web Tokens (JWT) when compared to Simple Web Tokens (SWT) and Security Assertion Markup Language Tokens (SAML).

      - As JSON is less verbose than XML, when it is encoded its size is also smaller, making JWT more compact than SAML. This makes JWT a good choice to be passed in HTML and HTTP environments.

      - Security-wise, SWT can only be symmetrically signed by a SHARED SECRET using the HMAC algorithm. However, JWT and SAML tokens can use a public/private key pair in the form of a X.509 certificate for signing. Signing XML with XML Digital Signature without introducing obscure security holes is very difficult when compared to the simplicity of signing JSON.

        XML 怎麼可以有這麼多問題!!?

      - JSON parsers are common in most programming languages because they MAP DIRECTLY to objects. Conversely, XML doesn't have a natural document-to-object mapping. This makes it easier to work with JWT than SAML assertions.

      - Regarding usage, JWT is used at INTERNET SCALE. This highlights the ease of client-side processing of the JSON Web token on multiple platforms, especially mobile.

        為何 SAML 就不行?? 不過要在 brower 裡處理 SAML 確實費工 ...

        ![Comparing the length of an encoded JWT and an encoded SAML](https://cdn.auth0.com/content/jwt/comparing-jwt-vs-saml2.png)

      - If you want to read more about JSON Web Tokens and even start using them to perform authentication in your own applications, browse to the JSON Web Token landing page at Auth0.

        對照上面 How do JSON Web Tokens work? 的一張圖，Auth0 雖然被標上 "Authorization Server"，但它主要的定位是 authentication ??

## 新手上路 {: #getting-started }

  - JWT 就只是一種結構化的 access token， 它的特性是 compact, signed, self-contained，本身就是一種 credential

      - 因為是 credential，拿到的人要善盡保管的義務，所以這裡不討論 token 外流的問題，也不討論 token 的來源是否正確。

        當初把 token 交付給誰，誰能出示 token，就認定是當初交付的人。

      - 因為是 signed、只有我們有 secret，所以可以確保這 token 沒有被動過手腳；裡面的 claim 宣稱可以做什麼，我們就信了，不用再查表 (self-contained)。

        我們不會把 secret (假設採用 HMAC algorithm) 給 client，因為可以做什麼事，不是由 client 決定的。

  - 它跟 authorization 有關，但跟 authentication request 無關；當然，authentication response 採 JWT 又是另一回事。

    透過 autentication 拿到 JWT (有人稱之為 "自動簽證")，本質上就是拿 credentials (通常是帳密) 來換另一個有時效的 credentials (這裡指的是 JWT)；自動產生的 JWT 通常有 expiration，但 "純驗證" (事先發給 token，而不是動態透過 authentication 拿到) 比較難做到這裡，除非雙方覺得定期換 token 不麻煩。

---

參考資料：

  - [What is the JSON Web Token structure? - JSON Web Token Introduction \- jwt\.io](https://jwt.io/introduction/)

      - In its compact form, JSON Web Tokens consist of three parts separated by DOTS (`.`), which are:

          - Header
          - Payload
          - Signature

      - Therefore, a JWT typically looks like the following.

            xxxxx.yyyyy.zzzzz

        Let's break down the different parts.

    Header

      - The header typically consists of two parts: the type of the token, which is JWT, and the SIGNING ALGORITHM being used, such as HMAC SHA256 or RSA.

        For example:

            {
              "alg": "HS256",
              "typ": "JWT"
            }

        [8. Implementation Requirements - RFC 7519 \- JSON Web Token \(JWT\)](https://tools.ietf.org/html/rfc7519#section-8):

        > Of the signature and MAC algorithms specified in JSON Web Algorithms [JWA], only HMAC SHA-256 ("HS256") and "none" MUST be implemented by conforming JWT implementations.

        所有的 algorithm 都定義在 RFC 7518 - JSON Web Algorithms (JWA) 裡，而 `HS256` 指的就是 HMAC SHA-256。

        如果用 public/private key 要怎麼表示?? 光有 `alg` 跟 `typ` 是不夠的。

      - Then, this JSON is Base64Url encoded to form the first part of the JWT.

    Payload

      - The second part of the token is the payload, which contains the claims. Claims are STATEMENTS ABOUT AN ENTITY (typically, the user) and additional data. There are three types of claims: registered, public, and private claims.

          - Registered claims

            These are a set of PREDEFINED claims which are NOT MANDATORY BUT RECOMMENDED, to provide a set of useful, INTEROPERABLE claims. Some of them are: `iss` (issuer), `exp` (expiration time), `sub` (subject) ??, `aud` (audience), and others.

            Notice that the claim names are only three characters long as JWT is meant to be compact.

            下面提到的 IANA JSON Web Token Registry，除了這裡列舉的幾個 3 個字元的 claim 外，有不少 claim name 是超過 3 個字元的 (例如 `nickname`)，甚至有些是由多個用底線隔開的單字組成 (例如 `family_name`)。

          - Public claims

            These can be defined AT WILL by those using JWTs. But to avoid collisions they should be defined in the [IANA JSON Web Token Registry](https://www.iana.org/assignments/jwt/jwt.xhtml) or be defined as a URI that contains a collision resistant namespace. ??

            跟 private claims 也可以自定義，有人麼不同??

          - Private claims

            These are the CUSTOM claims created to share information between parties that agree on using them and are NEITHER registered or public claims.

        但因為所有 claims 的 key/value 都寫在同一層，共用了 namespace，所以要注意命名衝突的問題。

      - An example payload could be:

            {
              "sub": "1234567890",
              "name": "John Doe",
              "admin": true
            }

      - The payload is then Base64Url encoded to form the second part of the JSON Web Token.

      - Do note that for signed tokens this information, though protected against tampering, is readable by anyone. DO NOT PUT SECRET information in the payload or header elements of a JWT UNLESS IT IS ENCRYPTED.

        走 public/private key 就沒這個問題 ??

    Signature

      - To create the signature part you have to take the ENCODED header, the encoded payload, a SECRET, the algorithm specified in the header, and sign that.

        文件一直在講 secret，暗示著 HMAC 比較常用，而 public/private key 比較少用??

      - For example if you want to use the HMAC SHA256 algorithm, the signature will be created in the following way:

            HMACSHA256(
              base64UrlEncode(header) + "." +
              base64UrlEncode(payload),
              secret)

      - The signature is used to verify the message wasn't changed along the way, and, in the case of tokens signed with a private key, it can also verify that the sender of the JWT is who it says it is.

    Putting all together

      - The output is three Base64-URL strings separated by dots that can be easily passed in HTML and HTTP environments, while being more compact when compared to XML-based standards such as SAML.

        也就是 SSO 若有用到 JWT 就跟 SAML 無關。

      - The following shows a JWT that has the previous header and payload encoded, and it is signed with a secret.

        ![Encoded JWT](https://cdn.auth0.com/content/jwt/encoded-jwt3.png)

        這裡 "a JWT" 的說法有點特別? JWT 既是一種規格，也是一種符合這規格的 token。

      - If you want to play with JWT and put these concepts into practice, you can use jwt.io Debugger to decode, verify, and generate JWTs.

        ![JWT.io Debugger](https://cdn.auth0.com/blog/legacy-app-auth/legacy-app-auth-5.png)

  - [How do JSON Web Tokens work? - JSON Web Token Introduction \- jwt\.io](https://jwt.io/introduction/)

      - In authentication, when the user successfully logs in using their credentials, a JSON Web Token will be returned. Since tokens ARE CREDENTIALS, great care must be taken to prevent security issues. In general, you should NOT KEEP TOKENS LONGER THAN REQUIRED.

        這裡提到兩個 credentials -- 除了使用者登入時提供的 credentials，通過身份認證後拿到的 access token 也是一種 credentials!! 由於持有 access token 可以以該使用者的身份做事，應該要有 expiration 的概念!!

      - You also [should not store sensitive session data in browser storage due to lack of security](https://cheatsheetseries.owasp.org/cheatsheets/HTML5_Security_Cheat_Sheet.html#local-storage). #ril

        但有些情況下還是得存 access token，例如 server 對 server 的應用??

      - Whenever the user wants to access a protected route or resource, the user agent should send the JWT, typically in the `Authorization` header using the `Bearer` SCHEMA. The content of the header should look like the following:

            Authorization: Bearer <token>

        This can be, in certain cases, a STATELESS authorization mechanism. The server's protected routes will check for a valid JWT in the `Authorization` header, and if it's present, the user will be allowed to access protected resources.

        所謂 stateless 是對 server 而言；每個 request 都要檢查一次 token 是否 (還) 有效。

      - If the JWT contains the necessary data, the need to query the database for certain operations may be reduced, though this may not always be the case.

        呼應上面 Information Exchange 的應用??

      - If the token is sent in the `Authorization` header, Cross-Origin Resource Sharing (CORS) won't be an issue as it doesn't use cookies. ??

      - The following diagram shows how a JWT is obtained and used to access APIs or resources:

        ![How does a JSON Web Token work](https://cdn2.auth0.com/docs/media/articles/api-auth/client-credentials-grant.png)

         1. The application or client requests authorization to the authorization server. This is performed through one of the different authorization flows.

            For example, a typical OpenID Connect compliant web application will go through the `/oauth/authorize` endpoint using the authorization code flow. ??

         2. When the authorization is granted, the authorization server returns an ACCESS TOKEN to the application.

         3. The application uses the access token to access a protected resource (like an API).

        Do note that with signed tokens, all the information contained within the token is EXPOSED to users or other parties, even though they are UNABLE TO CHANGE IT. This means you should not put secret information within the token.

        呼應了上面說 JWT 是 credential 的說法。

  - [Structure - JSON Web Token \- Wikipedia](https://en.wikipedia.org/wiki/JSON_Web_Token#Structure) #ril
  - [5 Easy Steps to Understanding JSON Web Tokens \(JWT\)](https://medium.com/vandium-software/5-easy-steps-to-understanding-json-web-tokens-jwt-1164c0adfcec) (2016-05-17) #ril

## Python

  - [JSON Web Tokens \- jwt\.io](https://jwt.io/#libraries-io)

      - 星星數 PyJWT 最高，Authlib 其次；另一方面，Authlib 支援所有的 check，而 PyJWT 少了 `sub` check 與 `jti` check。

## 參考資料 {: #reference }

  - [JSON Web Tokens - jwt.io](https://jwt.io/)

社群：

  - [Auth0 Community](https://community.auth0.com/)

工具：

  - [Debugger - JWT.IO](https://jwt.io/#debugger-io)

書籍：

  - [JWT Handbook](https://auth0.com/resources/ebooks/jwt-handbook)

相關：

  - [REST / Security](rest-security.md)

手冊：

  - [IANA JSON Web Token Registry](https://www.iana.org/assignments/jwt/jwt.xhtml)
  - [RFC 7519 - JSON Web Token (JWT)](https://tools.ietf.org/html/rfc7519)
  - [RFC 7518 - JSON Web Algorithms (JWA)](https://tools.ietf.org/html/rfc7518)
  - [RFC 7515 - JSON Web Signature (JWS)](https://tools.ietf.org/html/rfc7515)
  - [RFC 7516 - JSON Web Encryption (JWE)](https://tools.ietf.org/html/rfc7516)
