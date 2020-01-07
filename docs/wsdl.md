# WSDL (Web Services Description Language)

  - [Web Services Description Language \- Wikipedia](https://en.wikipedia.org/wiki/Web_Services_Description_Language) #ril

      - The Web Services Description Language (WSDL /ˈwɪz dəl/) is an XML-based INTERFACE description language that is used for describing the functionality offered by a web service. The acronym is also used for any specific WSDL description of a web service (also referred to as a WSDL file), which provides a MACHINE-READABLE description of how the service can be called, what parameters it expects, and what data structures it returns.

        Therefore, its purpose is roughly similar to that of a TYPE SIGNATURE in a programming language.

        [pronunciations of wsdl in English](https://youglish.com/pronounce/wsdl/english?) 才知道真的唸做 `ˈwɪz dəl` 而非 W-S-D-L。

      - The current version of WSDL is WSDL 2.0. The meaning of the acronym has changed from version 1.1 where the "D" stood for "Definition".

    Description

      - The WSDL describes services as collections of network ENDPOINTS, or PORTS. The WSDL specification provides an XML format for documents for this purpose. The abstract definitions of ports and messages are separated from their concrete use or instance, allowing the reuse of these definitions.

        A port is defined by associating a network address with a REUSABLE BINDING ??, and a COLLECTION OF PORTS defines a SERVICE. Messages are abstract descriptions of the data being exchanged, and PORT TYPES are abstract collections of supported OPERATIONS.

        The concrete protocol and data format specifications for a particular port type constitutes a reusable binding, where the operations and messages are then bound to a concrete network protocol and message format. In this way, WSDL describes the public interface to the Web service. ??

      - WSDL is often used in combination with SOAP and an XML Schema to provide Web services over the Internet. A client program connecting to a Web service can read the WSDL file to determine WHAT OPERATIONS ARE AVAILABLE on the server. Any special datatypes used are embedded in the WSDL file in the form of XML Schema. The client can then use SOAP to actually call one of the operations listed in the WSDL file using for example XML over HTTP.

        所以 SOAP 跟 WSDL 的關係是什麼??

      - The current version of the specification is 2.0; version 1.1 has not been endorsed by the W3C but version 2.0 is a W3C recommendation.

        ![Representation of concepts defined by WSDL 1.1 and WSDL 2.0 documents.](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/WSDL_11vs20.png/560px-WSDL_11vs20.png)

        WSDL 1.2 was renamed WSDL 2.0 because of its SUBSTANTIAL DIFFERENCES from WSDL 1.1. By accepting binding to all the HTTP request methods (not only `GET` and `POST` as in version 1.1), the WSDL 2.0 specification offers better support for RESTful web services, and is much simpler to implement.

        WSDL 跟 RESTful 什麼關係??

        However support for this specification is still poor in software development kits for Web Services which often offer tools only for WSDL 1.1. For example, the version 2.0 of the Business Process Execution Language (BPEL) only supports WSDL 1.1.

## 新手上路 {: #getting-started }

  - [Working with WSDL Files \| Documentation \| SoapUI](https://www.soapui.org/soap-and-wsdl/working-with-wsdls.html) #ril

## 參考資料 {: #reference }

手冊：

  - [Web Services Description Language (WSDL) 1.1 - W3C](https://www.w3.org/TR/wsdl.html)
