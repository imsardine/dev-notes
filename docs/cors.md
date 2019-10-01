# CORS (Cross Origin Resource Sharing)

  - [Cross\-Origin Resource Sharing \(CORS\) \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) #ril

      - Cross-Origin Resource Sharing (CORS) is a mechanism that uses additional HTTP headers to tell a browser to let a web application running at one ORIGIN (domain) have permission to access selected resources from a server at a different origin.

        A web application executes a CROSS-ORIGIN HTTP REQUEST when it requests a resource that has a different ORIGIN (DOMAIN, PROTOCOL, AND PORT) than its own origin.

        從 "let ... running at one origin domain have permission to ..." 看來，感覺像是讓 web application 脫離 same-origin policy 的限制，但按照下面 "unless the response from the other origin ..." 的說法，其實是先往 the other origin 送出 request 了，browser 才根據 CORS headers 來決定這個 request 要不要擋下來。

      - An example of a cross-origin request: The frontend JavaScript code for a web application served from http://domain-a.com uses `XMLHttpRequest` to make a request for `http://api.domain-b.com/data.json`.

        For security reasons, browsers restrict cross-origin HTTP requests INITIATED FROM WITHIN SCRIPTS. For example, `XMLHttpRequest` and the Fetch API follow the SAME-ORIGIN POLICY. This means that a web application using those APIs can only request HTTP resources from the same origin the application was loaded from, UNLESS THE RESPONSE FROM THE OTHER ORIGIN includes the right CORS HEADERS.

      - The CORS mechanism supports secure cross-origin requests and data transfers between browsers and web servers. Modern browsers use CORS in an API container such as `XMLHttpRequest` or Fetch to help MITIGATE the risks of cross-origin HTTP requests.

        ![](https://mdn.mozillademos.org/files/14295/CORS_principle.png)

        Same-origin policy 只針對 script ?? 圖中 Canvas w/ image from 會踩到 same-origin policy 的問題正是因為 Canvas 是透過 JavaScript 來畫圖。

    Who should read this article?

      - Everyone, really.

        More specifically, this article is for web administrators, server developers, and front-end developers.

      - Modern browsers handle the client-side components of CROSS-ORIGIN SHARING, including headers and POLICY ENFORCEMENT. But this new standard means SERVERS have to handle new REQUEST AND RESPONSE HEADERS. Another article for server developers discussing cross-origin sharing from a server perspective (with PHP code snippets) is supplementary reading.

        為什麼跟 request header 有關 ??

    What requests use CORS?

      - This cross-origin sharing standard is used to enable cross-site HTTP requests for:

          - Invocations of the `XMLHttpRequest` or Fetch APIs in a cross-site manner, as discussed above.
          - Web Fonts (for cross-domain font usage in `@font-face` within CSS), so that servers can deploy TrueType fonts that can only be cross-site loaded and used by web sites that are permitted to do so.
          - WebGL textures.
          - Images/video frames drawn to a canvas using `drawImage()`.

        為什麼 font 跟 texture 會受到 same-origin policy 的限制 ??

      - This article is a general discussion of Cross-Origin Resource Sharing and includes a discussion of the necessary HTTP headers.

    Functional overview

      - The Cross-Origin Resource Sharing standard works by adding new HTTP headers that allow servers to describe the SET OF ORIGINS THAT ARE PERMITTED TO READ THAT INFORMATION using a web browser.

        由 server 來控制誰能讀取 response。

      - Additionally, for HTTP request methods that can cause side-effects on server's data (in particular, for HTTP methods other than GET, or for POST usage with certain MIME types), the specification mandates that browsers "PREFLIGHT" the request, soliciting supported methods from the server with an HTTP `OPTIONS` request method, and then, upon "approval" from the server, sending the actual request with the actual HTTP request method. Servers can also notify clients whether "credentials" (including Cookies and HTTP Authentication data) should be sent with requests. ??

      - CORS failures result in errors, but for security reasons, specifics about what went wrong are not available to JavaScript code. All the code knows is that an error occurred. The only way to determine what specifically went wrong is to look at the browser's console for details.

      - Subsequent sections discuss scenarios, as well as provide a breakdown of the HTTP headers used.

  - [Server\-Side Access Control \(CORS\) \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Server-Side_Access_Control) #ril

## No 'Access-Control-Allow-Origin' header is present on the requested resource. ??

  - [jquery \- Why does my JavaScript get a "No 'Access\-Control\-Allow\-Origin' header is present on the requested resource" error when Postman does not? \- Stack Overflow](https://stackoverflow.com/questions/20035101/) 跟 CORS 有關 #ril

## Proxy

  - 若 reverse proxy 可以幫忙加 CORS header，那 CORS 實作在 web server 上就好，什麼時候要從 application 來做 ??

參考資料：

  - [enable cross\-origin resource sharing](https://enable-cors.org/server_nginx.html) #ril
  - [crossorigin\.me](https://corsproxy.github.io/) #ril
  - [Cors proxies](https://gist.github.com/jimmywarting/ac1be6ea0297c16c477e17f8fbe51347) #ril

## 參考資料 {: #reference }

手冊：

  - [Origin - HTTP | MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Origin)
  - [Access-Control-Allow-Origin - HTTP | MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin)
