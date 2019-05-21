# XML-RPC

  - [XML\-RPC \- Wikipedia](https://en.wikipedia.org/wiki/XML-RPC)

      - XML-RPC is a REMOTE PROCEDURE CALL (RPC) protocol which uses XML to encode its calls and HTTP as a transport mechanism.
      - The XML-RPC protocol was created in 1998 by Dave Winer of UserLand Software and Microsoft, with Microsoft seeing the protocol as an essential part of scaling up its efforts in BUSINESS-TO-BUSINESS E-COMMERCE. As new functionality was introduced, the standard evolved into what is now SOAP.

      - In XML-RPC, a client performs an RPC by sending an HTTP request to a server that implements XML-RPC and receives the HTTP response. A call can have MULTIPLE PARAMETERS and ONE RESULT. The protocol defines a few DATA TYPES for the parameters and result. Some of these data types are complex, i.e. nested. For example, you can have a parameter that is an array of five integers.

        The parameters/result structure and the set of data types are meant to MIRROR those used in common programming languages.

      - Identification of clients for authorization purposes can be achieved using popular HTTP security methods. BASIC ACCESS AUTHENTICATION can be used for identification and authentication.

        The protocol DOES NOT allow HTTPS, but it is a common and obvious variation to use HTTPS in place of HTTP. 不允許 HTTPS 應該只是當時規格沒載明?

      - In comparison to RESTful protocols, where RESOURCE REPRESENTATIONS (documents) are transferred, XML-RPC is designed to CALL METHODS. The practical difference is just that XML-RPC is much more structured, which means COMMON LIBRARY CODE can be used to implement clients and servers and there is LESS DESIGN AND DOCUMENTATION WORK for a specific application protocol.

        One salient technical difference between typical RESTful protocols and XML-RPC is that the RESTful protocol uses the HTTP URI for PARAMETER information whereas with XML-RPC, the URI just identifies the server.

        JSON-RPC is similar to XML-RPC.

        應該說 XML-RPC 比較受限 (JSON-RPC 會不會好點?)，但這也不完全是壞事；XML-RPC 的 parameter 也做為 XML payload 的一部份，不像 RESTful 會有部份在 URI。

      - Recent critics (from 2010 and onwards) of XML-RPC argue that RPC calls can be made with plain XML, and that XML-RPC DOES NOT ADD ANY VALUE OVER XML. Both XML-RPC and XML require an application-level data model, such as which field names are defined in the XML schema or the parameter names in XML-RPC. Furthermore, XML-RPC uses about 4 times the number of bytes compared to plain XML to encode the same objects, which is itself verbose compared to JSON.

        言下之意，JSON-RPC 會是更好的選擇?? 不過 Python 只內建對 XML-RPC 的支援。

## Data Type ??

  - [Data types - XML\-RPC \- Wikipedia](https://en.wikipedia.org/wiki/XML-RPC#Data_types) #ril

## 應用實例 {: #powered-by }

  - [Trac Remote API](trac-api.md#xml-rpc)

## 參考資料 {: #reference }

  - [XML-RPC Home](http://xmlrpc.scripting.com/)

社群：

  - ['xml-rpc' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/xml-rpc)

更多：

  - [Python](python-xml-rpc.md)

相關：

  - XML-RPC 是 [SOAP](soap.md) 的前身
  - 類似於 [JSON-RPC](json-rpc.md)
  - 常被拿來跟 [RESTful](rest.md) 比較
