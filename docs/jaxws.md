# JAX-WS (Java API for XML Web Services)

  - [Java API for XML Web Services \- Wikipedia](https://en.wikipedia.org/wiki/Java_API_for_XML_Web_Services) #ril

      - The Java API for XML Web Services (JAX-WS) is a Java programming language API for CREATING web services, particularly SOAP services. JAX-WS is one of the Java XML programming APIs. It is part of the Java EE platform.

        這裡只強調跟建造 web service 有關，跟 web service 使用端的關係是??

    Overview

      - The JAX-WS 2.2 specification JSR 224 defines a standard Java-to-WSDL mapping which determines HOW WSDL OPERATIONS ARE BOUND TO JAVA METHODS when a SOAP message invokes a WSDL operation.

        This Java-to-WSDL mapping determines which Java method gets invoked and how that SOAP message is mapped to the method’s parameters.

        This mapping also determines how the method’s return value gets mapped to the SOAP response.

      - JAX-WS uses annotations, introduced in Java SE 5, to simplify the development and deployment of web service CLIENTS and ENDPOINTS. It is part of the [Java Web Services Development Pack](https://en.wikipedia.org/wiki/Java_Web_Services_Development_Pack). #ril

        JAX-WS can be used in Java SE starting with version 6. JAX-WS 2.0 replaced the JAX-RPC API in Java Platform, Enterprise Edition 5 which leans more towards document style Web Services.

      - This API provides the core of [Project Metro](https://en.wikipedia.org/wiki/Project_Metro), inside the GlassFish open-source Application Server community of Oracle Corporation. #ril

      - JAX-WS also is one of the foundations of [WSIT](https://en.wikipedia.org/wiki/Web_Services_Interoperability_Technology). #ril

## 新手上路 {: #getting-started }

  - [Introduction to JAX\-WS \| Baeldung](https://www.baeldung.com/jax-ws) (2019-01-17) #ril

## 參考資料 {: #reference }

  - [JAX-WS](https://javaee.github.io/metro-jax-ws/)

手冊：

  - [JSR 224: Java API for XML-Based Web Services (JAX-WS) 2.0](https://jcp.org/en/jsr/detail?id=224)
