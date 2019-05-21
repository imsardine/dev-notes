---
title: Trac / Remote API
---
# [Trac](trac.md) / Remote API

  - [TracDev/ApiDocs – The Trac Project](https://trac.edgewall.org/wiki/TracDev/ApiDocs) 這裡是 Trac 自身開發會用到的 API，跟 Remote API 無關。
  - [Does trac have remote API? \- Stack Overflow](https://stackoverflow.com/questions/2304670/) Jens A. Koch: Trac 對外沒有提供 API，可以安裝 Trac XML-RPC Plugin，提供 XML-RPC 與 JSON-RPC 兩種 access。
  - [REST API for Trac\.Wiki \- Super User](https://superuser.com/questions/459964/) David Roussel: XmlRpcPlugin 提供 RPC interface，但不是 REST。
  - [\#217 \(XML\-RPC/SOAP/etc\. interface\) – The Trac Project](https://trac.edgewall.org/ticket/217) (2004-04-01) #ril

## XML-RPC ??

  - [XmlRpcPlugin – Trac Hacks \- Plugins Macros etc\.](https://trac-hacks.org/wiki/XmlRpcPlugin)

      - This plugin allows Trac plugins to export SELECT PARTS of their interface via XML-RPC and JSON-RPC (if `json` or `simplejson` is available). Latest trunk version includes a pluggable API for EXTENDING PROTOCOLS, and see for instance TracRpcProtocolsPlugin for more protocols.

        所謂 "extending protocols" 指的是像 JSON-RPC 這類不同的 RPC 管道。

      - The BROWSABLE XML-RPC URI suffix is `/rpc`, but most XML-RPC clients should use the authenticated URL suffix `/login/rpc` as this will provide AUTHENTICATED REQUESTS through Trac.

        The `XML_RPC` permission is used to grant users access to using the RPC interface. If you do want to use `/rpc` and UNAUTHENTICATED ACCESS, you must grant the `XML_RPC` permission to the `anonymous` user.

        `$TRAC_HOST/rpc` 可以看 RPC API 文件，如果沒有權限，存取 `/rpc` 會看到 "XML_RPC privileges are required to perform this operation. You don't have the required permissions." 的提示。

        `/login/rpc` 才是給程式走的，API 文件裡會標示每個 function 的權限要求 (permission required)，有 `XML_RPC`、`TICKET_VIEW`、`TICKET_CREATE`、By resource 等。

        為什麼下面 Python End-User Usage 的範例都用 `/xmlrpc` 而非 `/login/rpc` ? 按照 [Remote Procedure Call (RPC) – Trac Hacks](https://trac-hacks.org/rpc) 的說法，`/rpc`/`/login/rpc` 走 JSON-RPC，而 `/xmlrpc`/`/login/xmlrpc` 則是 XML-RPC，其中 `/login/...` 都是 authenticated access。

      - Method status:

          - Ticket API is also complete, with the following types exported: component, version, milestone, type, status, resolution, priority and severity.
          - The WikiRPC API ?? is complete, mostly thanks to mgood.

      - Protocol and method documentation for the latest version of the plugin can be found [here](https://trac-hacks.org/rpc). 註冊帳號後就能存取

## 新手上路 {: #getting-started }

  - [Remote Procedure Call \(RPC\) – Trac Hacks \- Plugins Macros etc\.](https://trac-hacks.org/rpc) #ril
  - [Python End-User Usage - XmlRpcPlugin – Trac Hacks \- Plugins Macros etc\.](https://trac-hacks.org/wiki/XmlRpcPlugin#PythonEnd-UserUsage) #ril
  - [Django: Access Trac from Your Webapp Using XML\-RPC](https://kpetrovi.ch/django/python/2012/05/31/django-access-trac-from-your-webapp.html) (2012-05-31) #ril

## Authentication ??

  - [trac\.web\.auth – Trac Authentication — Trac branches\-1\.2\-stable\-r16563 documentation](https://www.edgewall.org/docs/branches-1.2-stable/html/api/trac_web_auth.html) #ril
      - 只支援 HTTP Basic 與 Digest；這好像是供 server-side 實作參考的?

  - [Using Digest Authentication in Python - XmlRpcPlugin – Trac Hacks \- Plugins Macros etc\.](https://trac-hacks.org/wiki/XmlRpcPlugin#UsingDigestAuthenticationinPython) #ril
  - [Problems with Digest HTTP authentication - XmlRpcPlugin – Trac Hacks \- Plugins Macros etc\.](https://trac-hacks.org/wiki/XmlRpcPlugin#ProblemswithDigestHTTPauthentication) #ril

## 參考資料 {: #reference }

  - [XmlRpcPlugin – Trac Hacks](https://trac-hacks.org/wiki/XmlRpcPlugin)
  - [TracXMLRPC - PyPI](https://pypi.org/project/TracXMLRPC/)

相關：

  - Trac 的 API 透過 [XML-RPC](xml-rpc.md) 或 [JSON-RPC](json-rpc.md) 公開

手冊：

  - [Remote Procedure Call (RPC) – Trac Hacks](https://trac-hacks.org/rpc)
