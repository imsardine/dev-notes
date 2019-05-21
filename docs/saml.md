# SAML (Security Assertion Markup Language)

  - [Security Assertion Markup Language - Common Configurations - Single sign\-on \- Wikipedia](https://en.wikipedia.org/wiki/Single_sign-on#Security_Assertion_Markup_Language)
      - SAML 與 Kerberos-based、Smart-card-based、Integrated Windows Authentication 並列在 Common Configurations 下。
      - SAML 是一種在 SAML identity provider 與 SAML service provider 間交換 user security information 的 XML-based solution。
  - [Security Assertion Markup Language \- Wikipedia](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) #ril
      - SAML 唸做 "sam-el" (sey-mal)，是 identity provider 及 service provider 間交換 authentication & authorization data 的開發標準。
  - [SAML Tutorial: How SAML Authentication Works \- SAML 2\.0 SSO Flow Diagram](https://developers.onelogin.com/saml) A standard for logging users into applications based on their SESSIONS IN ANOTHER CONTEXT. 這說法滿有趣的；後面不用記 & 不用打帳密的說法似乎有點歪了? 實際上是在講已經登入 domain/intranet，所以應該用這些資訊幫使用者登入其他服務，所以不會用到帳密，而 SAML 可以優雅地實現 SSO，這裡出現 "SAML SSO" 的說法。
  - [How SAML Works - SAML Tutorial: How SAML Authentication Works \- SAML 2\.0 SSO Flow Diagram](https://developers.onelogin.com/saml) SAML SSO 透過 digitally signed XML 在 identity provider 與 service provider 間交換 user's identity。
  - [What is SAML and How Does it Work?](https://blog.varonis.com/what-is-saml/) (2018-08-21)
      - allows identity providers (IdP) to pass AUTHORIZATION CREDENTIALS to service providers (SP). SAML is the LINK between the authentication of a user’s identity and the AUTHORIZATION TO USE A SERVICE. 這說法也滿特別的，出現 "SAML transactions" 的說法。
      - SAML adoption allows IT shops to use software as a service (SaaS) solutions while maintaining a secure FEDERATED identity management system. 原來跟 SaaS 有這層關係。

## SAML 1, 2 ??

  - [What is SAML and How Does it Work?](https://blog.varonis.com/what-is-saml/) (2018-08-21) SAML 2.0 在 2005 年由 OASIS Consortium 核定，跟 SAML 1.1 差異很大 (不相容)。
  - [SAML 2\.0 \- Wikipedia](https://en.wikipedia.org/wiki/SAML_2.0) #ril

## 跟 OAuth 的關係 ??

  - [SAML vs. OAuth - What is SAML and How Does it Work?](https://blog.varonis.com/what-is-saml/) #ril

## Flow ??

  - [How SAML Works - SAML Tutorial: How SAML Authentication Works \- SAML 2\.0 SSO Flow Diagram](https://developers.onelogin.com/saml)
      - 首先 application 會把使用者導向 identity provider 做 authentication -- 登入 identity provider (沒有 existing active browser session with the identity provider 的話)，這個動作叫做送出 "authentication request"。
      - Identity provider 會回應 authentication response，格式是包含 username 或 email address 的 XML，重點是 XML 會用 X.509 certificate 簽章 (sign)，並往原 service provider 送。
      - Service provider 事先知道 identity provider 的 certificate fingerprint，收到 authentication response 就可以驗證它的合法性，就能識別該用戶 (identity of the user is established)。
      - SAML SSO Flow 提到 service provider-initiated SSO 與 Identity provider-initiated SSO 兩種機制，後者只包含後半段的步驟。很清楚看到，是 service provider 往 identity provider (IDP) 送 SAML request，之後 identity provider 會將 SAML response 送回原 service provider。
  - [What is SAML and How Does it Work?](https://blog.varonis.com/what-is-saml/) (2018-08-21) #ril
  - [What is SAML, what is it used for and how does it work? \| CSO Online](https://www.csoonline.com/article/3232355/authentication/what-is-saml-what-is-it-used-for-and-how-does-it-work.html) (2017-10-12) #ril
  - [How SAML Authentication Works](https://auth0.com/blog/how-saml-authentication-works/) #ril

## Assertion ??

  - [Security Assertion Markup Language \- Wikipedia](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SAML 裡的 "security assertion" 指的是 "statements that service providers use to make ACCESS-CONTROL DECISIONS"，所謂 assertion 指的就是 "判斷並做決定"。
  - [What is a SAML Assertion? - What is SAML and How Does it Work?](https://blog.varonis.com/what-is-saml/) #ril

## Tools ??

  - [List of single sign\-on implementations \- Wikipedia](https://en.wikipedia.org/wiki/List_of_single_sign-on_implementations) #ril

## 參考資料 {: #reference }

