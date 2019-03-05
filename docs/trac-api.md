---
title: Trac / Remote API
---
# [Trac](trac.md) / Remote API

## API ??

  - [TracDev/ApiDocs – The Trac Project](https://trac.edgewall.org/wiki/TracDev/ApiDocs) 這裡是 Trac 自身開發會用到的 API，跟 Remote API 無關。
  - [Does trac have remote API? \- Stack Overflow](https://stackoverflow.com/questions/2304670/) Jens A. Koch: Trac 對外沒有提供 API，可以安裝 Trac XML-RPC Plugin，提供 XML-RPC 與 JSON-RPC 兩種 access。
  - [REST API for Trac\.Wiki \- Super User](https://superuser.com/questions/459964/) David Roussel: XmlRpcPlugin 提供 RPC interface，但不是 REST。
  - [\#217 \(XML\-RPC/SOAP/etc\. interface\) – The Trac Project](https://trac.edgewall.org/ticket/217) (2004-04-01) #ril

## Hello, World! ??

  - [Django: Access Trac from Your Webapp Using XML\-RPC](https://kpetrovi.ch/django/python/2012/05/31/django-access-trac-from-your-webapp.html) (2012-05-31) #ril

## XML-RPC ??

  - [XmlRpcPlugin – Trac Hacks \- Plugins Macros etc\.](https://trac-hacks.org/wiki/XmlRpcPlugin) #ril
      - 瀏覽 `$TRAC_URL/rpc` 就可以看到 RPC 文件。

## Authentication ??

  - [trac\.web\.auth – Trac Authentication — Trac branches\-1\.2\-stable\-r16563 documentation](https://www.edgewall.org/docs/branches-1.2-stable/html/api/trac_web_auth.html) #ril
      - 只支援 HTTP Basic 與 Digest；這好像是供 server-side 實作參考的?

## 參考資料

手冊：

