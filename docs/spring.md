# Spring

  - [Spring](https://spring.io/)

    Spring: the source for modern java

      - Spring Boot -- BUILD ANYTHING

        Spring Boot is designed to get you up and running as quickly as possible, with minimal upfront configuration of Spring. Spring Boot takes an OPINIONATED view of building production-ready applications.

      - Spring Cloud -- COORDINATE ANYTHING

        Built directly on Spring Boot's innovative approach to enterprise Java, Spring Cloud simplifies distributed, MICROSERVICE-STYLE architecture by implementing PROVEN PATTERNS to bring resilience, reliability, and coordination to your microservices.

      - Spring Cloud Data Flow -- CONNECT ANYTHING

        Connect the Enterprise to the Internet of Anything—mobile devices, sensors, wearables, automobiles, and more. Spring Cloud Data Flow provides a unified service for creating COMPOSABLE data microservices that address streaming and [ETL-based](https://en.wikipedia.org/wiki/Extract,_transform,_load) data processing patterns. #ril

        這裡 mobile device 也被定位成 IoT。

    Spring Framework 5 -- THE RIGHT TECHNOLOGY STACK FOR THE JOB AT HAND

      - Developers are constantly challenged with choosing the most effective runtime, programming model, and architecture for their application's requirements and team's skill set.

        For example, some use cases are best handled by a technology stack based on synchronous blocking I/O architecture, whereas others would be better served by an asynchronous, nonblocking stack built on the REACTIVE design principles described in the [Reactive Streams Specification](http://www.reactive-streams.org/). #ril

        ![](https://spring.io/img/homepage/diagram-boot-reactor.svg)

        這張圖在比較 Spring MVC (Servlet Stack, non-blocking I/O, one-request-per-thread) 與 Spring WebFlux (Reactive Stack, blocking I/O)。

        最上層是 Spring Boot，這意謂著 Spring Boot 是基於 Spring Framework，呼應上面 "opinionated view" 的說法 ??

        從 [Spring Web MVC](https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html) 與 [Spring WebFlux](https://docs.spring.io/spring/docs/current/spring-framework-reference/web-reactive.html) 抬頭跟 URL 看來 (前者是 `spring-framework-reference/web.html` Web on Servlet Stack，後者是 `spring-framework-reference/web-reactive.html` Web on Reactive Stack)，Web MVC 跟 WebFlux 兩者都是基於 Spring Framework，只是上面的比較圖沒有明確指出而已。

      - Reactive Spring represents a platform-wide initiative to deliver reactive support at every level of the development stack: web, security, data, messaging, etc.

        Spring Framework 5 delivers on this vision by providing a new reactive web stack called Spring WebFlux, which is offered SIDE BY SIDE with the TRADITIONAL Spring MVC web stack. The choice is yours!

        [WebFlux Reference Documentation](https://docs.spring.io/spring/docs/current/spring-framework-reference/web-reactive.html#spring-webflux) 比較 Spring MVC 與 Spring WebFlux 兩種不同的 Programming Model #ril

        這裡的 "side by side" 是指 Spring MVC 與 WebFlux 可以混用?? 所以才能匯集為上層的 Spring Boot。

## 參考資料 {: #reference }

  - [Spring](https://spring.io/)

更多：

  - [Framework](spring-framework.md)
  - [Web MVC](spring-webmvc.md)
  - [Boot](spring-boot.md)
