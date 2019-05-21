---
title: Python / XML-RPC
---
[Python](python.md) / [XML-RPC](xml-rpc.md)

  - [20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html) #ril

      - The `xmlrpclib` module has been renamed to `xmlrpc.client` in Python 3. The `2to3` tool will automatically adapt imports when converting your sources to Python 3.

      - XML-RPC is a Remote Procedure Call method that uses XML passed via HTTP(S) as a transport. With it, a client can call methods with parameters on a remote server (the server is named by a URI) and get back structured data.

        Changed in version 2.7.9: For HTTPS URIs, `xmlrpclib` now performs all the necessary CERTIFICATE AND HOSTNAME CHECKS by default.

      - This module supports writing XML-RPC client code; it handles all the details of TRANSLATING between conformable Python objects and XML on the wire.

        The `xmlrpclib` module is not secure against maliciously constructed data. If you need to parse untrusted or unauthenticated data see XML vulnerabilities.

        自動把 ODM (Object Document Mapping) 做掉了；因為會自動解析/轉換 XML response 的關係，有可能遭到攻擊。

  - [xmlrpc — XMLRPC server and client modules — Python 3\.7\.3 documentation](https://docs.python.org/3/library/xmlrpc.html) #ril
  - [xmlrpc\.client — XML\-RPC client access — Python 3\.7\.2 documentation](https://docs.python.org/3/library/xmlrpc.client.html) #ril

# 參考資料 {: #reference }

  - [cpython/xmlrpclib.py at 2.7 · python/cpython](https://github.com/python/cpython/blob/2.7/Lib/xmlrpclib.py)
  - [cpython/client\.py at 3\.7 · python/cpython](https://github.com/python/cpython/blob/3.7/Lib/xmlrpc/client.py)
