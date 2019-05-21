---
title: REST / Security
---
# [REST](rest.md) / Security

  - [SSL everywhere - all the time - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#ssl)
      - 總是使用 SSL，沒有例外! 避免資料被偷聽 (eavesdropping) 或透過 authentication credentials 被劫持 (hijackted) 用來假扮 (impersonation)。
      - 同時，因為 SSL 的通訊是加密的，可以大幅簡化 authentication -- 只要傳 simple access token 即可，不需要為每個 API request 加密。
      - 不要把 non-SSL request 轉向 SSL counterpart，直接丟錯。除非對像是 unencrypted endpoint，就靜靜地轉向 encrpyted endpoint 即可。

  - [Why Does Security Matter? - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=2)

    Organizations Understand the Need for API Security

      - In today’s CONNECTED WORLD, where information is being shared via APIs to external stakeholders and within internal teams, security is a TOP CONCERN.

      - API security is the single biggest challenge organizations want to see solved in the years ahead, and solving the security challenge is expected to be a catalyst (催化劑) for growth in the API world.

        呼應下面 Security is the #4 technology area expected to drive the most API growth in the next two years; 24% of API providers say digital security will drive the most API growth in the next two years. 的說法，沒有 security 的話 API 確實很難發展出規模。

      - With the explosive growth of RESTful APIs, the security layer is often the one that is most OVERLOOKED in the architectural design of the API.

    Data Protection

      - A RESTful API is the way in which a given service can PRESENT VALUE TO THE WORLD. As a result, protection of the data provided via RESTful endpoints should always be a high priority.
      - You have to define CLEAR ACCESS RIGHTS, especially for methods like DELETE (deletes a resource) and PUT (updates a resource). Those methods must be accessed by AUTHENTICATED users only, and for each such call, an AUDIT must be saved.

    TLS

      - Transport Layer Security (TLS) and its predecessor, Secure Sockets Layer (SSL), are cryptographic protocols that provide communications security over a computer network.

      - When secured by TLS, connections between a client and a server have one or more of the following properties:

          - The connection is private (or secure) because symmetric cryptography is used to encrypt the data transmitted.
          - The keys for this symmetric encryption are generated uniquely for each connection and are based on a shared secret negotiated at the start of the session.
          - The identity of the communicating parties can be authenticated using public-key cryptography. ??
          - The connection ensures integrity because each message transmitted includes a message integrity check using a MESSAGE AUTHENTICATION CODE to prevent undetected loss or alteration of the data during transmission. 本來就有的機制!!

    DOS Attacks

      - In a Denial of Service (DOS) attack, the attacker usually sends excessive messages asking the network or server to authenticate requests that have INVALID RETURN ADDRESSES. DOS attacks can render a RESTful API into a non-functional state if the right SECURITY MEASURES are not taken.
      - Today, even if your API is not exposed to the public, it still might be accessible by others. This means that REST API security is getting more and more valuable and important. Consider that someone succeeds in making a DOS attack- it means that all the connected clients (partners, apps, mobile devices, and more) will not be able to access your API.

    Anti-Farming

      - Today, there are several marketing-heavy websites that offer consumers the best deal on everything from flights to vehicles and even groceries. In many of these cases, the aggregated service is taking advantage of other APIs to obtain the information they want you to utilize. When this happens, the RESTful API is being FARMED OUT (外包) for the benefit of another entity. ??
      - In case your API does not have an Authorization/Authentication mechanism, it might lead to misuse of your API, loading the servers and the API itself, making it less responsive to others.

  - [Secure Your REST API: Best Practices - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=12) #ril

  - [JSON Web Token (JWT) - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=8) #ril
  - [Security Assessment Markup Language (SAML) - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=6) #ril
  - [OAuth 2 - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=7) #ril
  - [Authentication - Best Practices for Designing a Pragmatic RESTful API \| Vinay Sahni](https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#authentication) #ril

## Authentication ??

  - [REST API Authentication Types Overview - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=3)

      - RESTful applications rely on the underlying security of the API ecosystem rather than including security within the REST architecture style. In addition to securing RESTful API calls with the HTTPS protocol, SESSION-BASED AUTHENTICATION should be utilized. Currently, most RESTful applications leverage OAuth 2.0 and JWT is the newcomer that is gaining more and more popularity with API developers.

      - OAuth, JWT, and Basic Auth all use HEADERS for transmitting credentials, and API providers should be doing the same with all API KEYS. While easy to do as parameters, they are more secure as headers.

        用 header 來傳 credentials 相較 query string 安全。只是 OAuth 過程中不像 Basic Auth 要拿到帳密，但最終都是根據某種 token 來識別身份，原理都跟 API key 很像。

        [OAuth 2 - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=7) 提到 "Since an access token is like A SPECIAL TYPE OF API KEY, the most likely place to put it is the authorization header, ..."

  - [Basic Authentication - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=4)

      - HTTP Basic authentication implementation is the simplest technique for enforcing access controls to web resources because it DOESN’T REQUIRE COOKIES, SESSION IDENTIFIERS, or LOGIN PAGES; rather, HTTP Basic authentication uses standard fields in the HTTP header, REMOVING THE NEED FOR HANDSHAKES.
      - To receive authorization, the client sends the userid and password, separated by a single colon (":") character, within a Base64 encoded string in the credentials.
      - If the user agent wishes to send the userid "Aladdin" and password "open sesame," it would use the following header field: `Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==`

      - The Basic authentication scheme is not a secure method of user authentication, nor does it in any way protect the entity, which is transmitted in CLEARTEXT across the physical network used as the carrier.

        The most serious flaw in Basic authentication is that it results in the essentially cleartext transmission of the user's password over the physical network.

        Because Basic authentication involves the cleartext transmission of passwords, it should be used over TLS or SSL protocols (HTTPS) in order to protect sensitive or valuable information.

        結論是，Basic Authentication 本身並不安全，但搭配 TLS/SSL 還可以？

  - [3 Common Methods of API Authentication Explained \| Nordic APIs \|](https://nordicapis.com/3-common-methods-api-authentication-explained/) (2018-02-06) 在 authentication 與 authorization 的差別這一段解釋得很清楚 #ril

  - [RESTful API Authentication Basics](https://blog.restcase.com/restful-api-authentication-basics/) (2016-11-28) #ril

## API Key ??

  - [API Keys - REST API Security \- DZone \- Refcardz](https://dzone.com/refcardz/rest-api-security-1?chapter=5)

      - Not any formal standard, but something in common practice by API providers, and supported by API management providers. It is the usage of ONE OR TWO KEYS WHAT ACCOMPANY EVERY API CALL. API keys are really more about IDENTIFYING THE APPLICATION AND USER over being anything about security, but is perceived as secure by many.

        注意是 application + user 的組合，也就是不同 application 不該用相同的 API key。搭配 TLS/SSL 妥善保管 API key 還是有些保護作用，雖然 API key 主要是用來識別 application + user 以控制用量、計費。

      - Public REST services without access control run the risk of BEING FARMED, leading to excessive bills for bandwidth or compute cycles. API keys can be used to mitigate this risk. They are also often used by organization to MONETIZE APIs; instead of blocking high-frequency calls, clients are given access in accordance to a purchased access plan.

      - Typically, an API key gives full access to every operation an API can perform, including writing new data or deleting existing data. If you use THE SAME API KEY IN MULTIPLE APPS, a broken app could destroy your users' data without an easy way to stop just that one app. Some apps let users generate new API keys, or even have multiple API keys with the option to REVOKE one that may have gone into the wrong hands. The ABILITY TO CHANGE AN API KEY limits the security downsides.

        如果 API key 可以動態 revoke 的話，問題會更小一點；問題是這些 key 在後端要怎麼管理??

  - [API Key Authentication - An Introduction to API’s – The RESTful Web](https://restful.io/an-introduction-to-api-s-cee90581ca1b#c3db) (2015-08-26)

      - API Key Authentication is a technique that overcomes the weakness of using SHARED CREDENTIALS. by requiring the API to be accessed with a UNIQUE KEY. Unlike Basic Auth, API keys were CONCEIVED at multiple companies in the early days of the web. As a result, API Key Authentication has NO STANDARD and everybody has its own way of doing it.

        "大家構想出來的做法，並沒有標準的做法"，這段故事很有趣，為了改善 Basic Auth 的缺點 -- 要交換帳密。

      - The most common approach has been to include it onto the URL (`http://example.com?apikey=mysecret_key`). 放 header 會好一點?

  - [API Keys - 3 Common Methods of API Authentication Explained \| Nordic APIs \|](https://nordicapis.com/3-common-methods-api-authentication-explained/#apikeys) (2018-02-06)

      - API keys are an INDUSTRY STANDARD, but shouldn’t be considered a HOLISTIC (全部的) SECURITY MEASURE.
      - API Keys were created as somewhat of a FIX to the early authentication issues of HTTP Basic Authentication and other such systems. In this approach, a unique generated value is assigned to each FIRST TIME USER, signifying that the user is known. When the user attempts to RE-ENTER the system, their unique key (sometimes generated from their hardware combination and IP data, and other times randomly generated by the server which knows them) is used to prove that they’re THE SAME USER AS BEFORE.

      - On one hand, this is very FAST. The ability to prove identity once and move on is very AGILE, and is why it has been used for many years now as a DEFAULT APPROACH for many API providers. Additionally, setting up the system itself is quite easy, and CONTROLLING THESE KEYS once generated is even easier. This also allows systems to PURGE KEYS, thereby removing authentication after the fact and denying entry to any system attempting to use a removed key.

        看起來 API key 並不糟，跟 OAuth 有不同的應用情境??

      - The problem, however, is that API keys are often used for what they’re not – an API key is NOT A METHOD OF AUTHORIZATION, it’s a method of AUTHENTICATION. Because anyone who makes a request of a service transmits their key, in theory, this key can be picked up just as easy as any network transmission, and if any point in the entire network is insecure, the entire network is exposed. This makes API keys a hard thing to recommend – often misused and fundamentally insecure, they nonetheless do have their place when PROPERLY SECURED and hemmed in by authorization systems.

        似乎有點難區分 authentication 與 authorization，不過在上面 Authentication vs Authorization 有解釋到：

        > Consider for a moment a driver’s license. In many countries, a driver’s license proves both that you are who you say you are via a picture or other certified element, and then goes further to prove that you have a right to drive the vehicle class you’re driving. In such a case, we have authentication and authorization – and in many API solutions, we have systems that give a piece of code that BOTH AUTHENTICATES THE USER AND PROVES THEIR AUTHORIZATION. In such a case, we have HYBRID SOLUTIONS.

  - [API Keys ≠ Security: Why API Keys Are Not Enough \| Nordic APIs \|](https://nordicapis.com/why-api-keys-are-not-enough/) (2018-02-02) #ril

      - Unfortunately, many API providers make a dangerous mistake that exposes a large amount of data and makes an entire ecosystem insecure. In plain English — if you’re only using API keys, you may be doing it wrong!

    What is an API Key?

      - An API Key is a piece of code assigned to a specific program, developer, or user that is used whenever that entity makes a call to an API. This Key is typically a long string of generated characters which follow a set of GENERATION RULES specified by the authority that creates them: `IP84UTvzJKds1Jomx8gIbTXcEEJSUilGqpxCcmnx`

      - Upon account creation or app registration, many API providers assign API keys to their developers, allowing them to function in a way similar to an account username and password. API keys are unique, and because of this, many providers have opted to use these keys as a type of SECURITY LAYER, barring entry and further rights to anyone unable to provide the key for the service being requested.

        感覺 API Key 要複雜到無法猜測，後端也要有防止一直嘗試的異常行為??

      - Despite the alluring simplicity and ease of utilizing API Keys in this method, the shifting of security responsibility, lack of GRANULAR CONTROL, and misunderstanding of purpose and use amongst most developers makes solely relying on API Keys a poor decision. More than just protecting API keys, we need to program robust identity control and access management features to safeguard the entire API platform.

    Shifting of Responsibility

      - In most common implementations of the API Key process, the security of the system as a whole is entirely dependent on the ability of the developer consumer to PROTECT THEIR API KEYS and maintain security. However, this isn’t always stable. Take Andrew Hoffman’s [$2375 Amazon EC2 Mistake](http://www.programmableweb.com/news/why-exposed-api-keys-and-sensitive-data-are-growing-cause-concern/analysis/2015/01/05) that involved a fluke API key push to GitHub. As developers rely on cloud-based development tools, the accidental or malicious public exposure of API keys can be a real concern.

        把責任推給使用者，要把 API key 保管好；不過 OAuth、JWT 等要由 client 提供 token 的做法，不也有相同的問題??

      - From the moment a key is generated, it is passed through the network to the user over a connection with limited encryption and security options. Once the user receives the key, which in many common implementations is provided in PLAIN TEXT, the user must then save the key using a PASSWORD MANAGER, write it down, or save it to a file on the desktop. Another common method for API Key storage is device storage, which takes the generated key and saves it to the device on which it was requested.
      - When a key is used, the API provider must RELY ON THE DEVELOPER to encrypt their traffic, secure their network, and uphold their side of the security bargain. There are many vulnerabilities at stake (在危急關頭) here: applications that contain keys can be decompiled to extract keys, or deobfuscated from on-device storage, plaintext files can be stolen for unapproved use, and password managers are SUSCEPTIBLE to security risks as with any application. 問題在於，API key 怎麼保存都有被偷的風險。
      - Due to its relative simplicity, most common implementations of the API Key method provide a sense of FALSE SECURITY. Developers embed the keys in Github pushes, utilize them in third-party API calls, or even share them between various services, each with their own security caveats. In such a vulnerable situation, security is a huge issue, but it’s one that isn’t really brought up with API Keys because “they’re so simple — and the user will keep them secure!”
      - This is a reckless (不顧後果的) viewpoint. API Keys are ONLY SECURE WHEN USED WITH SSL, which isn’t even a requirement in the basic implementation of the methodology. Other systems, such as OAuth 2, Amazon Auth, and more, require the use of SSL for this very reason. Shifting the responsibility from the service provider to the developer consumer is also a negligent (粗心的) decision from a UX perspective. 本來就要搭配 SSL 不是，問題是有 SSL 就沒問題了嗎??

    Lack of Granular Control

      - Some people FORGIVE the lack of security. After all, it’s on the developer to make sure solutions like SSL are implemented. However, even if you do assure security, your issues don’t stop there — API Keys by design LACK GRANULAR CONTROL??.
      - Somewhat IRONICALLY, before API keys were used with RESTful services, we had [WS-Security](https://en.wikipedia.org/wiki/WS-Security) tokens for SOAP services that let us perform many things with more fine-grained control. While other solutions can be scoped, audienced, controlled, and managed down to the smallest of minutia, API Keys, more often than not, ONLY PROVIDE ACCESS UNTIL REVOKED. They can’t be specifically controlled dynamically.
      - That’s not to say API Keys lack any control — relatively useful read/write/readwrite control is definitely possible in an API Key application. However, the needs of the average API developer often warrant more full-fledged options.
      - This is not a LOCALIZED issue either. As more and more devices are integrated into the Internet of Things, this control will become more important than ever before, magnifying the choices made in the early stages of development to gargantuan proportions later on in the API Lifecycle. ??

  - [Supported Auth Repositories - API Key Auth Provider](https://docs.servicestack.net/api-key-authprovider#supported-auth-repositories) `RedisAuthRepository` - Uses Redis back-end data store 似乎可以把 API key 存在 Redis #ril

  - [Google Maps Platform  \|  Google Developers](https://developers.google.com/maps/api-key-best-practices) #ril
  - [Best practices for securely storing API keys – freeCodeCamp\.org](https://medium.freecodecamp.org/how-to-securely-store-api-keys-4ff3ea19ebda) (2017-10-25) #ril
  - [Best practices for building secure API Keys – freeCodeCamp\.org](https://medium.freecodecamp.org/best-practices-for-building-api-keys-97c26eabfea9) (2018-09-29) #ril

## 參考資料 {: #reference }

  - [APIsecurity.io](https://apisecurity.io/)

更多：

  - [JWT (JSON Web Token)](jwt.md)
