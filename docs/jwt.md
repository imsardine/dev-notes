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

        Signed tokens can verify the INTEGRITY of the claims contained within it, while encrypted tokens HIDE THOSE CLAIMS from other parties. When tokens are signed using public/private key pairs, the signature also certifies that only the party holding the private key is the one that signed it.

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

        As JSON is less verbose than XML, when it is encoded its size is also smaller, making JWT more compact than SAML. This makes JWT a good choice to be passed in HTML and HTTP environments.

        Security-wise, SWT can only be symmetrically signed by a SHARED SECRET using the HMAC algorithm. However, JWT and SAML tokens can use a public/private key pair in the form of a X.509 certificate for signing. Signing XML with XML Digital Signature without introducing obscure security holes is very difficult when compared to the simplicity of signing JSON.

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

        An example payload could be:

            {
              "sub": "1234567890",
              "name": "John Doe",
              "admin": true
            }

        實務上設計成 `scope` (array) 會比這裡的 `"admin": true` 好擴充，而且可以根據 scope 給予不同長度的效期 (`exp` claim) ??

      - The payload is then Base64Url encoded to form the second part of the JSON Web Token.

      - Do note that for signed tokens this information, though protected against tampering, is readable by anyone. DO NOT PUT SECRET information in the payload or header elements of a JWT UNLESS IT IS ENCRYPTED.

        走 public/private key 就沒這個問題，但 JWT 的重點是 signed 而非 encrypted。

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

      - Whenever the user wants to access a protected route or resource, the user agent should send the JWT, typically in the `Authorization` header using the `Bearer` schema. The content of the header should look like the following:

            Authorization: Bearer <token>

        [1.2. Terminology - RFC 6750 \- The OAuth 2\.0 Authorization Framework: Bearer Token Usage](https://tools.ietf.org/html/rfc6750#section-1.2)

        > Bearer Token - A security token with the property that any party in possession of the token (a "bearer") can use the token in any way that ANY OTHER party in possession of it can. Using a bearer token does not require a bearer to prove possession of cryptographic key material (proof-of-possession).

        `Bearer` authentication scheme 的使用不一定跟 OAuth 2.0 有關，它不像 `Basic` 需要出示真正的 credentials。

      - This can be, in certain cases, a STATELESS authorization mechanism. The server's protected routes will check for a valid JWT in the `Authorization` header, and if it's present, the user will be allowed to access protected resources.

        所謂 stateless 是對 server 而言；每個 request 都要檢查一次 token 是否 (還) 有效。

      - If the JWT contains the necessary data, the NEED TO QUERY THE DATABASE for certain operations may be reduced, though this may not always be the case.

        拜 JWT self-contained 的特性所賜；呼應上面 Information Exchange 的應用?

      - If the token is sent in the `Authorization` header, Cross-Origin Resource Sharing (CORS) won't be an issue as it doesn't use cookies. ??

      - The following diagram shows how a JWT is obtained and used to access APIs or resources:

        ![How does a JSON Web Token work](https://cdn2.auth0.com/docs/media/articles/api-auth/client-credentials-grant.png)

         1. The application or client requests authorization to the authorization server. This is performed through one of the different authorization flows.

            For example, a typical OpenID Connect compliant web application will go through the `/oauth/authorize` endpoint using the authorization code flow. ??

         2. When the authorization is granted, the authorization server returns an ACCESS TOKEN to the application.

         3. The application uses the access token to access a protected resource (like an API).

        Do note that with signed tokens, all the information contained within the token is EXPOSED to users or other parties, even though they are UNABLE TO CHANGE IT. This means you should not put secret information within the token.

        呼應了上面說 JWT 是 credential 的說法。

  - [Get Started with JSON Web Tokens \- Auth0](https://auth0.com/learn/json-web-tokens/) #ril
  - [Structure - JSON Web Token \- Wikipedia](https://en.wikipedia.org/wiki/JSON_Web_Token#Structure) #ril
  - [5 Easy Steps to Understanding JSON Web Tokens \(JWT\)](https://medium.com/vandium-software/5-easy-steps-to-understanding-json-web-tokens-jwt-1164c0adfcec) (2016-05-17) #ril

## Claim

  - [Payload - What is the JSON Web Token structure? - JSON Web Token Introduction \- jwt\.io](https://jwt.io/introduction/)

      - The second part of the token is the payload, which contains the claims. Claims are STATEMENTS ABOUT AN ENTITY (typically, the user) and additional data. There are three types of claims: registered, public, and private claims.

          - Registered claims

            These are a set of PREDEFINED claims which are NOT MANDATORY BUT RECOMMENDED, to provide a set of useful, INTEROPERABLE claims. Some of them are: `iss` (issuer), `exp` (expiration time), `sub` (subject), `aud` (audience), and others.

            從 [4.1. Registered Claim Names - RFC 7519 \- JSON Web Token \(JWT\)](https://tools.ietf.org/html/rfc7519#section-4.1) 對 `iss`、`sub`、`aud` 的說明看來，一再強調 application specific 與 optional，好像很難達到 registered claims 的目的 -- interoperable?

            Notice that the claim names are only three characters long as JWT is meant to be compact.

            下面提到的 IANA JSON Web Token Registry，除了這裡列舉的幾個 3 個字元的 claim 外，有不少 claim name 是超過 3 個字元的 (例如 `nickname`)，甚至有些是由多個用底線隔開的單字組成 (例如 `family_name`)。

          - Public claims

            These can be defined AT WILL by those using JWTs. But to avoid collisions they should be defined in the [IANA JSON Web Token Registry](https://www.iana.org/assignments/jwt/jwt.xhtml) or be defined as a URI that contains a collision resistant namespace. ??

            跟 private claims 也可以自定義，有人麼不同??

          - Private claims

            These are the CUSTOM claims created to share information between parties that agree on using them and are NEITHER registered or public claims.

        但因為所有 claims 的 key/value 都寫在同一層，共用了 namespace，所以要注意命名衝突的問題。

  - [4.1. Registered Claim Names - RFC 7519 \- JSON Web Token \(JWT\)](https://tools.ietf.org/html/rfc7519#section-4.1)

      - The following Claim Names are registered in the IANA "JSON Web Token Claims" registry established by Section 10.1. NONE of the claims defined below are intended to be MANDATORY to use or implement in all cases, but rather they provide a starting point for a set of useful, interoperable claims.

        Applications using JWTs should define which specific claims they use and when they are REQUIRED OR OPTIONAL. All the names are short because a core goal of JWTs is for the representation to be compact.

        Spec 本身只是給建議，這些 claim 都是 optional，但個別 application 應該自己明定哪些是 required。

      - The "iss" (issuer) claim identifies the PRINCIPAL (當事人) that issued the JWT. The processing of this claim is generally application specific. The "iss" value is a CASE-SENSITIVE string containing a StringOrURI value. Use of this claim is OPTIONAL.

        [2. Terminology - RFC 7519 \- JSON Web Token \(JWT\)](https://tools.ietf.org/html/rfc7519#section-2) 對 StringOrURI 的說明是：

        > A JSON string value, with the additional requirement that while arbitrary string values MAY be used, any value containing a ":" character MUST be a URI [RFC3986]. StringOrURI values are compared as case-sensitive strings with no transformations or canonicalizations applied.

        因為是 StringOrURI，所以網路上很常看到 `"iss": "https://..."` 的用法，例如 [JSON Web Token \(JWT\) Profile for OAuth 2\.0 Access Tokens](https://tools.ietf.org/id/draft-bertocci-oauth-access-token-jwt-00.html) 的 `"iss": "https://authorization-server.example.com/"` 與 `"aud": "https://rs.example.com/"`，其中 `iss` 代表從哪個網站拿到這個 token，而 `aud` 則表示這個 token 可以用在哪幾個網站。

      - The "sub" (subject) claim identifies the principal that is the SUBJECT of the JWT. The claims in a JWT are normally STATEMENTS ABOUT THE SUBJECT. The subject value MUST either be scoped to be LOCALLY UNIQUE in the context of the issuer or be GLOBALLY UNIQUE.

        Subject 可以解釋成文法上的 "主詞"，其實就是 user ID；[Reserved claims - JSON Web Token Claims](https://auth0.com/docs/tokens/jwt-claims#reserved-claims) 明確指出 `sub` claim 就是 Subject of the JWT (the user)。

        The processing of this claim is generally application specific. The "sub" value is a case-sensitive string containing a StringOrURI value. Use of this claim is OPTIONAL.

      - The "aud" (audience) claim identifies the RECIPIENTS that the JWT is intended for. Each principal intended to process the JWT MUST identify itself with a value in the audience claim. If the principal processing the claim does not identify itself with a value in the "aud" claim when this claim is present, then the JWT MUST be REJECTED.

        表示 issuer 當初只授權這個 JWT 被用在哪些地方 (類似證件影本會標註限定做為什麼用途)；收到這個 JWT 的人，如果有 `aud` 就要先判斷自己是否在授權範圍內，否則就算有能力驗證 signature 的合法性，也不該同意存取。

        In the general case, the "aud" value is an ARRAY of case-sensitive strings, each containing a StringOrURI value. In the special case when the JWT has one audience, the "aud" value MAY be a single case-sensitive string containing a StringOrURI value. The interpretation of audience values is generally application specific. Use of this claim is OPTIONAL.

      - The "exp" (expiration time) claim identifies the expiration time on or after which the JWT MUST NOT be accepted for processing. The processing of the "exp" claim requires that the current date/time MUST be before the expiration date/time listed in the "exp" claim.

        Implementers MAY provide for some small LEEWAY, usually no more than A FEW MINUTES, to account for clock skew. Its value MUST be a number containing a NumericDate value. Use of this claim is OPTIONAL.

        雖然說是 optional，但如果將 revocation 考量進來，它就會是 required/mandatory!!

        [2. Terminology - RFC 7519 \- JSON Web Token \(JWT\)](https://tools.ietf.org/html/rfc7519#section-2) 對 NumericDate 的說明是：

        > A JSON numeric value representing the number of SECONDS from 1970-01-01T00:00:00Z UTC until the specified UTC date/time, ignoring leap seconds. This is equivalent to the IEEE Std 1003.1, 2013 Edition [POSIX.1] definition "Seconds Since the Epoch", in which each day is accounted for by exactly 86400 seconds, other than that non-integer values can be represented. See RFC 3339 [RFC3339] for details regarding date/times in general and UTC in particular.

        簡單地講就是 Unix timestamp (不是 millisecond)。

      - The "nbf" (not before) claim identifies the time before which the JWT MUST NOT be accepted for processing. The processing of the "nbf" claim requires that the current date/time MUST be after or equal to the not-before date/time listed in the "nbf" claim.

        可以解釋為 "生效時間"。

        Implementers MAY provide for some small leeway, usually no more than a few minutes, to account for clock skew. Its value MUST be a number containing a NumericDate value. Use of this claim is OPTIONAL.

      - The "iat" (issued at) claim identifies the time at which the JWT was issued. This claim can be used to determine the AGE of the JWT. Its value MUST be a number containing a NumericDate value. Use of this claim is OPTIONAL.

        算出 JWT 的 age 在實務上的應用??

      - The "jti" (JWT ID) claim provides a unique identifier for the JWT. The identifier value MUST be assigned in a manner that ensures that there is a NEGLIGIBLE probability that the same value will be accidentally assigned to a different data object; if the application uses multiple issuers, collisions MUST be prevented among values produced by different issuers as well.

        The "jti" claim can be used to prevent the JWT from being REPLAYED. The "jti" value is a case- sensitive string. Use of this claim is OPTIONAL. ??

  - [JSON Web Token Claims](https://auth0.com/docs/tokens/jwt-claims) #ril

## Scope

  - 撇開 OAuth 不談，把 JWT 做為 API 的 access token，就是一種 API key 的應用。
  - JWT 做為 APK key 最大的好處是 granular security/control，可以利用 `scopes` custom claim 明確指出這個 APK key 可以做哪些事情。

---

參考資料：

  - [Using JSON Web Tokens as API Keys](https://auth0.com/blog/using-json-web-tokens-as-api-keys/)

      - Most APIs today use an API Key to authenticate legitimate clients. API Keys are very simple to use from the consumer perspective:

          - You get an API key from the service (in essence a shared secret).
          - Add the key to an `Authorization` header.
          - Call the API.

        It can't get simpler than that, but this approach has some limitations.

      - The last couple of months, we've been working on our API v2. We wanted to share what we've learnt implementing a more powerful security model using JSON Web Tokens.

        Using a JSON Web Token offers many advantages:

          - Granular Security: API Keys provide an ALL-OR-NOTHING access. JSON Web Tokens can provide much finer grained control.
          - Homogenous Auth Architecture: Today we use cookies, API keys, home grown SSO solutions, OAuth etc. Standardizing on JSON Web Tokens gives you an HOMOGENOUS TOKEN FORMAT across the board.
          - Decentralized Issuance: API keys depend on a central storage and a service to issue them. JSON Web Tokens can be "self-issued" or be completely EXTERNALIZED, opening interesting scenarios as we will see below.
          - OAuth2 Compliance: OAuth2 uses an OPAQUE token that relies on a CENTRAL STORAGE. You can return a STATELESS JWT instead, with the allowed SCOPES and expiration.
          - Debuggability: API keys are opaque random strings. JSON Web Tokens can be inspected.
          - Expiration Control: API keys usually don't expire unless you revoke them. JSON Web Tokens can (and often do) have an expiration.
          - Devices: You can't put an API key that has full access on a device, because what is on a phone or tablet can easily be stolen. But you can put a JWT with the right set of permissions.

    Granular Security

      - One of the most interesting benefits of using JWTs is the first one listed above. Back in the old days, when databases were at the center of our client-server applications, we could create users with specific permissions on the database:

      - APIs are becoming central pieces of our distributed systems architecture. They are now the "GATEKEEPERS" of our data. But in contrast with what was available in databases, virtually all API keys provide ALL-OR-NOTHING ACCESS.

        Readers will likely be familiar with the `scope` parameter of OAuth2 based systems that offers this finer grained consent to access.

      - There are many situations in which you want to keep the simplicity of an API Key but only for a subset of all possible API operations.

        GitHub acknowledged this requirement and now provides a way of creating a token with the scopes you need (mimicking the OAuth2 consent):

        GitHub > Settings > Developer settings > Personal access tokens 可以做到很細的控制。例如 `read:org`、`read:user`、`admin:repo_hook`、`repo:invite`、`repo_deployment` 都是分開控制的 (命名有點亂?)，`user` 下細分出 `read:user`、`user:email`、`user:follow` (`user` 包含 `user:email` 與 `user:follow`)。更多細節可以參考 [Understanding scopes for OAuth Apps \| GitHub Developer Guide](https://developer.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/) #ril

        In the next section, we will go through the details of how this can be implemented.

    How to implement it?

      - We don't know how GitHub implemented it (they probably used Ruby), but we will use it as an example. Let's say we want to implement an endpoint in the API to create new repos. You could MODEL this with the following JSON Web Token payload. If you provide any of those scopes, then you can create repos:

            {
              iat: 1416929109, // when the token was issued (seconds since epoch)
              jti: "aa7f8d0a95c", // a unique id for this token (for revocation purposes)
              scopes: ["repo", "public_repo"]  // what capabilities this token has
            }

      - The API endpoint would simply check for the presence of the right scope atribute (this example is written in node.js but any language would work):

            // intercept all calls to API and validae the token
            app.use('/api', express_jwt({secret: SECRET, userProperty: 'token_payload'}));

            // for POST /user/repo validate that there is a scope `repo` OR `public_repo`
            app.post('/api/user/repo',
                    check_scopes(['repo', 'public_repo']),
                    function(req, res, next) {
                // create a repo
                ....
            });

        Notice the `check_scopes` middleware on the `/api/user/repo` route. This is how the `check_scopes` function is implemented:

            function check_scopes(scopes) {
              return function(req, res, next) {
                //
                // check if any of the scopes defined in the token,
                // is ONE OF the scopes declared on check_scopes
                //
                var token = req.token_payload;
                for (var i =0; i<token.scopes.length; i++){
                  for (var j=0; j<scopes.length; j++){
                      if(scopes[j] === token.scopes[i]) return next();
                  }
                }

                return res.send(401, 'insufficient scopes')
              }
            }

        Notice that no one can change the scopes variables. JWTs are digitally signed, so its content cannot be tampered with.

        為什麼只要符合其中一個 scope 即可? 以 GitHub `user:follow` (`user` 包含 `user:email` 與 `user:follow`) 為例，若要 follow 某個 user，有 `user` 或 `user:follow` 都可以。

      - Documenting an API is equally important. What would be a good way for surfacing this on an API explorer?

        For Auth0, we decided to build our own documentation using swagger. Since we are a multi-tenant system, each tenant has an API Key and Secret that is used to sign the token. As a developer, you mark which scopes you need and a token will be auto-generated. You can copy and paste it to jwt.io to see the structure (this is the debuggable piece, by the way).

        Scopes required by each operation are clearly identified:

        ![](https://s3.amazonaws.com/blog.auth0.com/api-scopes2.png)

        下面提到 Swagger's support for arbitrary authorizations objects and a slightly customized swagger-ui template to render the scopes per operation. 原來是要客制才有的

      - Our token format is a bit different from the one in the example we showed for GitHub. The good thing about JWTs is that they can contain ANY DATA STRUCTURE:

            {
              iat: 1416929061,
              jti: "802057ff9b5b4eb7fbb8856b6eb2cc5b",
              scopes: {
                users: {
                  actions: ['read', 'create']
                },
                users_app_metadata: {
                  actions: ['read', 'create']
                }
              }
            }

        如何讓使用者選擇 scope 是一回事，在 JWT 裡如何表現又是另一回事；因為 JSON 的關係，所以 JWT 的表現能力也很強!!

        The string representation of the scope is `read:users` but in the JSON Web Token, we are using a MORE STRUCTURED REPRESENTATION (note the hierarchy), this allows us to be more consistent. It also allows us to have an easy way to extend it for other scenarios.

  - [Can an access token contain scope\-values · Issue \#1239 · mitreid\-connect/OpenID\-Connect\-Java\-Spring\-Server](https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/issues/1239)

      - gueuselambix: the access token mitreid provides is a JWT. Can it contain the scope values, so the resource server is NOT REQUIRED TO PERFORM THE TOKEN INTROSPECTION?

        I thought introspection was optional, because the resource server could validate the access token based on its signature (except for revocation of course), but it needs the scope values to authorize the request.

        根據 [OAuth 2\.0 Token Introspection](https://oauth.net/2/token-introspection/) 的說法：

        > The Token Introspection extension defines a mechanism for resource servers to obtain information about access tokens. With this spec, resource servers can check the validity of access tokens, and find out other information such as which user and which SCOPES are ASSOCIATED with the token.

        如果 JWT 還要到其他地方問 token 的其他細節，就是把 JWT 當成 [oauth 2\.0 \- How can I revoke a JWT token? \- Stack Overflow](https://stackoverflow.com/questions/31919067/) 中 João Angelo 所說的 by-reference token 來用了，完全沒有發揮到 JWT 的特性。

      - bodewig: `.claim("scope", String.join(" ", accessToken.getScope()))` 把 OAuth 的 `scope` (空白隔開) 直接塞進 `scope` claim?

  - [Is it OK to include the OAuth scopes inside a JWT? \- Stack Overflow](https://stackoverflow.com/questions/53002693/)

      - Lahiru Chandima: When a token issued for specific OAuth scopes, it looks better to embed the scopes for which the token is issued inside the token itself, because it is easier to validate whether the token has access to perform a CERTAIN ACTION BY LOOKING AT THE TOKEN, when the client uses the issued token later to perform some action.

        But, the standard claim fields of a JWT doesn't seem to include a suitable field to stamp the OAuth scopes. So, would it be OK to include the scopes as custom claims in the JWT? Is there any other way to embed the scope details in the JWT?

      - Kavindu Dodanduwa: Also, if you are after standard registered claims, they can be found here - https://www.iana.org/assignments/jwt/jwt.xhtml

        在 public domain 裡還真的有 `scope` claim!!

  - [JSON Web Token \(JWT\)](https://www.iana.org/assignments/jwt/jwt.xhtml)

      - `scope` -- Scope Values

      - 它的參考資料指向 [4.2. "scope" (Scopes) Claim - OAuth 2.0 Token Exchange draft-ietf-oauth-token-exchange-19](https://datatracker.ietf.org/doc/draft-ietf-oauth-token-exchange/?include_text=1)

        The value of the "scope" claim is a JSON string containing a SPACE-SEPARATED list of scopes associated with the token, in the format described in Section 3.3 of [RFC6749].

        Figure 7 illustrates the "scope" claim within a JWT Claims Set.

            {
              "aud":"https://consumer.example.com",
              "iss":"https://issuer.example.com",
              "exp":1443904177,
              "nbf":1443904077,
              "sub":"dgaf4mvfs75Fci_FL3heQA",
              "scope":"email profile phone address"
            }

  - [JWT security apparently incompatible with Auth0 · Issue \#1398 · goadesign/goa](https://github.com/goadesign/goa/issues/1398)

      - iancmcc: Auth0 generates JWTs that include scopes using the claim `scope`, and, as far as I can tell, there's no way to control that. Goa is hardcoded to look for the claim `scopes`, and there's no way to control that, either, short of patching it.

      - raphael: However I'm wondering if it wouldn't be better to just modify the middleware to check for both `scope` and - if not present - `scopes`.

        不過為什麼 goa 一開始會設計成只考慮 `scopes` ??

  - [Ldapwiki: Scp \(Scopes\) Claim](https://ldapwiki.com/wiki/Scp%20%28Scopes%29%20Claim)

      - Scp (Scopes) Claim is described in OAuth 2.0 Token Exchange as an ARRAY OF STRINGS, each of which represents an OAuth Scope granted for the issued security token.

        Each array entry of the claim value is a SCOPE-TOKEN, as defined in Section 3.3 of OAuth 2.0 RFC 6749.

      - The following example illustrates the "scp" claim within a JWT Claims Set with four scope-tokens.

            {
              "aud":"https://consumer.example.com",
              "iss":"https://issuer.example.com",
              "exp":1443904177,
              "nbf":1443904077,
              "sub":"dgaf4mvfs75Fci_FL3heQA",
              "scp":["email","address","profile","phone"]
            }

      - OAuth 2.0 Token Introspection RFC 7662 defines the "scope" parameter to convey the scopes associated with the token.

  - [Sample Use Cases \- Scopes and Claims](https://auth0.com/docs/scopes/current/sample-use-cases#add-custom-claims-to-a-token) #ril

  - [JSON Web Token \(JWT\)](https://www.jsonwebtoken.io/) 出現 `"scope": ["self","admins"]` 的用法 #ril

  - [JWT authentication Basics](https://exante.eu/clientsarea/tutorials/jwt/) 把 `aud` claim 拿來當 `scope` 用 -- `"aud":["symbols","ohlc","feed","change","crossrates"]` ?!

  - [JSON Web Token \(JWT\) Profile for OAuth 2\.0 Access Tokens](https://tools.ietf.org/id/draft-bertocci-oauth-access-token-jwt-00.html) - 出現 `"scope": "openid profile reademail"` 的用法

  - [Glewlwyd OpenID Connect Plugin documentation \| glewlwyd](https://babelouest.github.io/glewlwyd/docs/OIDC.html) 出現 `"scope":"scope1 g_profile"` 的用法。

  - [go \- Scopes Not Present in JWT Claim in Golang and Goa \- Stack Overflow](https://stackoverflow.com/questions/44036579/) 出現 `"scopes": "read:meta"` 的用法。

## Authentication Scheme

  - [How do JSON Web Tokens work? - JSON Web Token Introduction \- jwt\.io](https://jwt.io/introduction/)

    Whenever the user wants to access a protected route or resource, the user agent should send the JWT, typically in the `Authorization` header using the `Bearer` schema. The content of the header should look like the following:

          Authorization: Bearer <token>

  - [Part 2: JWT to authenticate Servers API’s \- codeburst](https://codeburst.io/jwt-to-authenticate-servers-apis-c6e179aa8c4e) (2018-01-13)

    The best HTTP header for your client to send an access token (JWT or any other token) is the `Authorization` header with the `Bearer` authentication scheme.

  - [Best HTTP Authorization header type for JWT \- Stack Overflow](https://stackoverflow.com/questions/33265812/) #ril

      - Zag zag..: I'm wondering what is the best appropriate `Authorization` HTTP header type for JWT tokens.

        One of the probably most popular type is `Basic`. For instance:

            Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==

        It handle two parameters such as a login and a password. So it is not relevant for JWT tokens.

        Also, I heard about `Bearer` type, for instance:

            Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ

        However, I don't know its meaning. Is it related to bears?

        Is there a particular way to use JWT tokens in the HTTP `Authorization` header? Should we use `Bearer`, or should we simplify and just use:

            Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ

        Or maybe, just a `JWT` HTTP header:

            JWT: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ

      - Florent Morselli: The best HTTP header for your client to send an access token (JWT or any other token) is the `Authorization` header with the `Bearer` authentication scheme.

        This scheme is described by the RFC6750.

        Example:

            GET /resource HTTP/1.1
            Host: server.example.com
            Authorization: Bearer eyJhbGciOiJIUzI1NiIXVCJ9TJV...r7E20RMHrHDcEfxjoYZgeFONFh7HgQ

        Note that even if this RFC and the above specifications are related to the OAuth2 Framework protocol, they can be used in ANY OTHER CONTEXTS that require a TOKEN EXCHANGE BETWEEN A CLIENT AND A SERVER.

        Unlike the custom `JWT` scheme you mention in your question, the `Bearer` one is registered at the IANA.

        Concerning the `Basic` and `Digest` authentication schemes, they are dedicated to authentication using a username and a secret (see RFC7616 and RFC7617) so not applicable in that context.

      - cassiomolin: The `Bearer` authentication scheme is registered in IANA and originally defined in the RFC 6750 for the OAuth 2.0 authorization framework, but NOTHING STOPS YOU from using the `Bearer` scheme for access tokens in applications that don't use OAuth 2.0.

        Stick to the standards as much as you can and don't create your own authentication schemes.

        很衷肯的建議!!

  - [JWT authorization in Flask \- codeburst](https://codeburst.io/jwt-authorization-in-flask-c63c1acf4eeb)

    Now to access this resource you need to add a header to your request in format `Authorization: Bearer <JWT>`.

  - [Basic Usage — flask\-jwt\-extended 3\.24\.1 documentation](https://flask-jwt-extended.readthedocs.io/en/stable/basic_usage/)

    To access a `jwt_required` protected view, all we have to do is send in the JWT with the request. By default, this is done with an authorization header that looks like:

        Authorization: Bearer <access_token>

    [Configuration Options — flask\-jwt\-extended 3\.24\.1 documentation](https://flask-jwt-extended.readthedocs.io/en/stable/options/#header-options):

    `JWT_HEADER_TYPE` - What type of header the JWT is in. Defaults to `'Bearer'`. This can be an EMPTY STRING, in which case the header contains only the JWT (insead of something like `HeaderName: Bearer <JWT>`)

     但不帶 authentication scheme 好像不符合 `Authorization` header 的規定?

  - [Flask\-JWT — Flask\-JWT 0\.3\.2 documentation](https://pythonhosted.org/Flask-JWT/)

      - `Authorization: JWT eyJhbGciOiJIUzI1Ni ...`

      - `JWT_AUTH_HEADER_PREFIX`

        The `Authorization` header value prefix. Defaults to `JWT` as to NOT CONFLICT with OAuth2 `Bearer` tokens. This is not a case sensitive value.

        `JWT` authencation scheme 這用法似乎不常見? 用 `Bearer` 會怎樣嗎??

## Revocation

  - [oauth 2\.0 \- How can I revoke a JWT token? \- Stack Overflow](https://stackoverflow.com/questions/31919067/)

      - João Angelo: In general the easiest answer would be to say that you CANNOT revoke a JWT token, but that's simply not true. The honest answer is that the COST of supporting JWT revocation is SUFFICIENTLY BIG FOR NOT BEING WORTH most of the times or plainly reconsider an alternative to JWT.

        就算成本太高，也要先想過 revocation 的可能性，否則遇到了卻苦無對策也不對。

        Having said that, in some scenarios you might need both JWT and IMMEDIATE token revocation so lets go through what it would take, but first we'll cover some concepts.

        JWT (Learn JSON Web Tokens) just specifies a TOKEN FORMAT, this revocation problem would also apply to any format used in what's usually known as a self-contained or BY-VALUE TOKEN. I like the latter terminology, because it makes a good contrast with by-reference tokens.

        這問題是 JWT 的特性使然，不是 JWT 才有。

          - by-value token - associated information, including token LIFETIME, is contained in the token itself and the information can be verified as originating from a trusted source (digital signatures to the rescue)

            如果一開始有把 revocation 考量進來，`exp` claim 就不會是 optional。

          - by-reference token - associated information is KEPT ON SERVER-SIDE STORAGE that is then obtained using the token value as the KEY; being server-side storage the associated information is implicitly trusted

        Before the JWT Big Bang we already dealt with tokens in our authentication systems; it was common for an application to create a SESSION IDENTIFIER upon user login that would then be used so that the user did not had to repeat the login process each time. These session identifiers were used as key indexes for server-side storage and if this sounds similar to something you recently read, you're right, this indeed classifies as a by-reference token.

        Using the same analogy, understanding revocation for by-reference tokens is TRIVIAL; we just delete the server-side storage mapped to that key and the next time the key is provided it will be invalid.

        For by-value tokens we just need to implement the OPPOSITE. When you request the revocation of the token you STORE SOMETHING that allows you to uniquely identify that token so that next time you receive it you can additionally check if it was revoked. If you're already thinking that something like this will NOT SCALE, have in mind that you only need to store the data until the time the token would expire and in most cases you could probably just store an HASH OF THE TOKEN so it would always be something of a known size.

        這更突顯了 `exp` claim 的重要性，否則一旦開始做 revocation，黑名單只能往上增加。放 Redis 可以減少為了檢查是否在 revocation 的黑名單裡而對 DB 的存取 ??

        As a last note and to center this on OAuth 2.0, the revocation of by-value access tokens is currently NOT STANDARDIZED. Nonetheless, the OAuth 2.0 Token revocation specifically states that it can still be achieved as long as both the authorization server and resource server agree to a CUSTOM WAY of handling this:

        > In the former case (self-contained tokens), some (currently non-standardized) BACKEND INTERACTION between the authorization server and the resource server may be used when IMMEDIATE access token revocation is desired.

        If you control both the authorization server and resource server this is very easy to achieve. On the other hand if you delegate the authorization server role to a cloud provider like Auth0 or a third-party component like Spring OAuth 2.0 you most likely need to approach things differently as you'll probably only get what's already standardized.

      - Huanghq: The JWT cann't be revoked. But here is the a alternative solution called as JWT old for new exchange schema.

        Because we can’t invalidate the issued token BEFORE EXPIRE TIME, we always use SHORT-TIME TOKEN, such as 30 minute. When the token expired, we use the old token exchange a new token. The critical point is one old token can exchange one new token only.

        任何發出去的 JWT 都要記起來 (至少是 hash)，好像哪裡怪怪的?

      - kstra: One way to revoke a JWT is by leveraging a distributed event system that notifies services when refresh tokens have been revoked. The identity provider broadcasts an event when a refresh token is revoked and other backends/services listen for the event. When an event is received the backends/services update a local cache that maintains a set of users whose refresh tokens have been revoked.

        This cache is then checked whenever a JWT is verified to determine if the JWT should be revoked or not. This is all based on the duration of JWTs and EXPIRATION INSTANT of individual JWTs.

        Authorization server 跟 resource server 間可以透過 event system 通報要擋下哪些 token，但前題還是 JWT 自己要有 `exp` claim。

  - [I don’t see the point in Revoking or Blacklisting JWT – Getting Connected](https://www.dinochiesa.net/?p=1388) (2015-06-01) #ril
  - [Blacklisting JSON Web Token API Keys](https://auth0.com/blog/blacklist-json-web-token-api-keys/) (2015-03-10) #ril
  - [What Happens If Your JWT Is Stolen? \| Okta Developer](https://developer.okta.com/blog/2018/06/20/what-happens-if-your-jwt-is-stolen) (2018-06-20) #ril
  - [Revoking JWTs \- FusionAuth](https://fusionauth.io/learn/expert-advice/tokens/revoking-jwts) #ril

## Libraries {: #lib }

  - [JSON Web Tokens \- jwt\.io](https://jwt.io/#libraries-io)

    Python

      - 星星數 PyJWT 最高，Authlib 其次；另一方面，Authlib 支援所有的 check，而 PyJWT 少了 `sub` check 與 `jti` check。

    Java

      - 星星數 JJWT 最高，Auth0 的 Java JWT 其次；JJWT 與 jose4j 支援所有的 check。答案顯然是 JJWT 了，它同時也支援 Android。

## 參考資料 {: #reference }

  - [JSON Web Tokens - jwt.io](https://jwt.io/)

社群：

  - ['jwt' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/jwt)
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
