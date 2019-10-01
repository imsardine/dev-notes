---
title: Python / XML-RPC
---
[Python](python.md) / [XML-RPC](xml-rpc.md)

  - [20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html) #ril

      - The `xmlrpclib` module has been renamed to `xmlrpc.client` in Python 3. The `2to3` tool will automatically adapt imports when converting your sources to Python 3.

      - XML-RPC is a Remote Procedure Call method that uses XML passed via HTTP(S) as a transport. With it, a client can call methods WITH PARAMETERS on a remote server (the server is named by a URI) and get back STRUCTURED DATA.

        Changed in version 2.7.9: For HTTPS URIs, `xmlrpclib` now performs all the necessary CERTIFICATE AND HOSTNAME CHECKS by default.

      - This module supports writing XML-RPC client code; it handles all the details of TRANSLATING between conformable Python objects and XML on the wire.

        The `xmlrpclib` module is not secure against maliciously constructed data. If you need to parse untrusted or unauthenticated data see XML vulnerabilities.

        自動把 ODM (Object Document Mapping) 做掉了；因為會自動解析/轉換 XML response 的關係，有可能遭到攻擊。

  - [xmlrpc — XMLRPC server and client modules — Python 3\.7\.3 documentation](https://docs.python.org/3/library/xmlrpc.html) #ril
  - [xmlrpc\.client — XML\-RPC client access — Python 3\.7\.2 documentation](https://docs.python.org/3/library/xmlrpc.client.html) #ril

## 新手上路 {: #getting-started }

  - [Example of Client Usage - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#example-of-client-usage)

        # simple test program (from the XML-RPC specification)
        from xmlrpclib import ServerProxy, Error

        # server = ServerProxy("http://localhost:8000") # local server
        server = ServerProxy("http://betty.userland.com")

        print server

        try:
            print server.examples.getStateName(41)
        except Error as v:
            print "ERROR", v

    透過 `ServerProxy` 跟 XML-RPC server 溝通，範例 `.examples.getStateName(41)` 中的 `getStateName(41)` 是 method 與 parameters，那 `examples` 是什麼 ??

## ServerProxy

  - [class `xmlrpclib.ServerProxy` - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#xmlrpclib.ServerProxy)

        class xmlrpclib.ServerProxy(uri[, transport[, encoding[, verbose[, allow_none[, use_datetime[, context]]]]]])

      - A `ServerProxy` instance is an object that manages communication with a remote XML-RPC server. The required first argument is a URI (Uniform Resource Indicator), and will normally be the URL of the server.

        `Server` is retained as an alias for `ServerProxy` for backwards compatibility. New code should use `ServerProxy`.

      - The optional second argument is a TRANSPORT FACTORY instance; by default it is an internal `SafeTransport` instance for https: URLs and an internal HTTP `Transport` instance otherwise.

        The optional third argument is an encoding, by default UTF-8. The optional fourth argument is a debugging flag.

      - The following parameters govern the use of the RETURNED PROXY INSTANCE. If `allow_none` is true, the Python constant `None` will be translated into XML; the default behaviour is for `None` to raise a `TypeError`. This is a commonly-used extension to the XML-RPC specification, but isn’t supported by all clients and servers; see http://ontosys.com/xml-rpc/extensions.php for a description.

        `allow_none` 是控制 Python --> XML-RPC 的轉換，預設 `None` 會丟出 `TypeError`，好奇 `None` 在 XML 裡會怎麼表現 ??

        The `use_datetime` flag can be used to cause date/time values to be presented as `datetime.datetime` objects; this is false by default. `datetime.datetime` objects may be passed to calls.

        搭配 "to be presented as" 與 "may be passed to calls" 的說法，呼叫時一定可以傳 `datetime.datetime`，`use_datetime` 是在控制 XML-RPC --> Python 的轉換。

      - Both the HTTP and HTTPS transports support the URL syntax extension for HTTP Basic Authentication: `http://user:pass@host:port/path`. The `user:pass` portion will be BASE64-ENCODED as an HTTP ‘Authorization’ header, and sent to the remote server as part of the connection process when invoking an XML-RPC method. You only need to use this if the remote server requires a Basic Authentication user and password.

        不用自己做 Base64 編碼，寫成 `user:pass` 內部會自動處理編碼。

        If an HTTPS URL is provided, context may be `ssl.SSLContext` and configures the SSL settings of the underlying HTTPS connection.

        只能用這種方式驗證身份嗎 ??

      - The returned instance is a PROXY OBJECT with methods that can be used to invoke corresponding RPC calls on the remote server.

        `ServerProxy` 名副其實是個 proxy object !!

      - Changed in version 2.5: The `use_datetime` flag was added.

      - Changed in version 2.6: Instances of new-style classes can be passed in if they have an `__dict__` attribute and don’t have a base class that is marshalled in a special way.

      - Changed in version 2.7.9: Added the `context` argument.

  - [ServerProxy Objects - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#serverproxy-objects) #ril

      - A `ServerProxy` instance has a method corresponding to each remote procedure call accepted by the XML-RPC server. Calling the method performs an RPC, dispatched by both name and argument signature (e.g. the same method name can be OVERLOADED with multiple argument signatures).

        The RPC finishes by returning a value, which may be either returned data in a conformant type or a `Fault` or `ProtocolError` object indicating an error.

## Data Type

  - [class `xmlrpclib.ServerProxy` - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#xmlrpclib.ServerProxy)

      - Types that are conformable (e.g. that can be MARSHALLED through XML), include the following (and except where noted, they are UNMARSHALLED as the same Python type):

        XML-RPC type -> Python type

          - `boolean` -> `bool`
          - `int` / `i4` --> `int` or `long` in range from -2147483648 to 2147483647.
          - `double` -> `float`
          - `string` -> `str` or `unicode`
          - `array` -> `list` or `tuple` containing conformable elements. Arrays are returned as `list`s.

          - `struct` -> `dict`.

             Keys must be strings, values may be any conformable type. Objects of user-defined classes can be passed in; only their `__dict__` attribute is transmitted.

          - `dateTime.iso8601` -> `xmlrpclib.DateTime` or `datetime.datetime`. Returned type depends on values of the `use_datetime` flags.

            預設傳回 `xmlrpclib.DateTime`，啟用 `use_datetime` 才會傳回 `datetime.datetime`；但有什麼理由不用 `datetime.datetime` ??

          - `base64` -> `xmlrpclib.Binary`

            為什麼不是 `str` (Python 2) 或 `bytes` (Python 3)? 會跟 `string` -> `str`/`unicode` 混淆 ??

          - `nil` -> The `None` constant. Passing is allowed only if `allow_none` is true.

            若 XML-RPC 有 `nil` 的概念，為什麼傳入 `None` 要特別用 `allow_none` 控制，而且預設還沒開啟 ??

      - Note that even though starting with Python 2.2 you can subclass built-in types, the `xmlrpclib` module currently does not marshal instances of such subclasses. ??

        這跟上面的一段說明有關：

        > Changed in version 2.6: Instances of new-style classes can be passed in if they have an `__dict__` attribute and don’t have a base class that is marshalled in a special way.

      - When passing strings, characters special to XML such as `<`, `>`, and `&` will be AUTOMATICALLY ESCAPED. However, it’s the caller’s responsibility to ensure that the string is free of characters that aren’t allowed in XML, such as the CONTROL CHARACTERS with ASCII values between 0 and 31 (except, of course, tab, newline and carriage return); failing to do this will result in an XML-RPC request that ISN’T WELL-FORMED XML.

        If you have to pass arbitrary strings via XML-RPC, use the `Binary` wrapper class described below.

  - [Boolean Objects - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#boolean-objects) #ril
  - [DateTime Objects - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#datetime-objects) #ril
  - [Binary Objects - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#binary-objects) #ril

## Error Handling

  - [class `xmlrpclib.ServerProxy` - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#xmlrpclib.ServerProxy)

      - This is the full set of data types supported by XML-RPC. Method calls may also raise a special `Fault` instance, used to signal XML-RPC server errors, or `ProtocolError` used to signal an error in the HTTP/HTTPS transport layer. Both `Fault` and `ProtocolError` derive from a base class called `Error`.

        可以把 `Fault` 理解成 server-side error，而 `ProtocolError` 是 connection error；而 `xmlrpclib.Error` 則是[繼承自 `Exception`](https://github.com/python/cpython/blob/2.7/Lib/xmlrpclib.py#L223)。

  - [Fault Objects - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#fault-objects) #ril
  - [ProtocolError Objects - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#protocolerror-objects) #ril

## Instrospection API

  - [class `xmlrpclib.ServerProxy` - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#xmlrpclib.ServerProxy)

      - If the remote server supports the INTROSPECTION API, the proxy can also be used to QUERY the remote server for the methods it supports (SERVICE DISCOVERY) and fetch other server-associated metadata.

  - [ServerProxy Objects - 20\.23\. xmlrpclib — XML\-RPC client access — Python 2\.7\.16 documentation](https://docs.python.org/2/library/xmlrpclib.html#serverproxy-objects) #ril

    Servers that support the XML introspection API support some common methods grouped under the RESERVED `system` attribute:

## 參考資料 {: #reference }

相關：

  - [XML-RPC](xml-rpc.md)

手冊：

  - [cpython/xmlrpclib.py at 2.7 · python/cpython](https://github.com/python/cpython/blob/2.7/Lib/xmlrpclib.py)
  - [cpython/client\.py at 3\.7 · python/cpython](https://github.com/python/cpython/blob/3.7/Lib/xmlrpc/client.py)
