# Service Virtualization

  - [Service virtualization \- Wikipedia](https://en.wikipedia.org/wiki/Service_virtualization) #ril

      - In software engineering, service virtualization or service virtualisation is a method to emulate the behavior of specific COMPONENTS in heterogeneous component-based applications such as API-driven applications, cloud-based applications and SERVICE-ORIENTED ARCHITECTURES.

      - It is used to provide software development and QA/testing teams access to dependent system components that are needed to exercise an application under test (AUT), but are UNAVAILABLE OR DIFFICULT-TO-ACCESS for development and testing purposes.

        With the behavior of the dependent components "virtualized", testing and development can proceed without accessing the actual live components. Service virtualization is recognized by vendors, industry analysts, and industry publications as being DIFFERENT THAN MOCKING.

    Overview

      - Service virtualization emulates the behavior of software components to remove DEPENDENCY CONSTRAINTS on development and testing teams. Such constraints occur in complex, interdependent environments when a component connected to the application under test is:

          - Not yet completed
          - Still evolving
          - Controlled by a third-party or partner
          - Available for testing only in limited capacity or at inconvenient times

          - DIFFICULT TO PROVISION OR CONFIGURE IN A TEST ENVIRONMENT

            就開發測試而言，最困難就是 test data 不是自己可以控制的。

          - Needed for simultaneous access by different teams with VARIED TEST DATA setup and other requirements

          - Restricted or costly to use for load and performance testing

            測試 AUT 會存取其他 component 而產生費用時。

      - Although the term "service virtualization" reflects the technique's initial focus on virtualizing web services, service virtualization extends across ALL ASPECTS of composite applications: services, databases, mainframes, ESBs, and other components that communicate using COMMON MESSAGING PROTOCOLS.

        Other similar tools are called API simulators, API mocking tools, over the wire test doubles.

        雖然 service 被擴大解釋了，但 "common messaging protocols" 都跟 networking 的溝通有關。

      - Service virtualization emulates only the behavior of the specific dependent components that developers or testers need to exercise in order to complete their END-TO-END TRANSACTIONS. Rather than virtualizing entire systems, it virtualizes only SPECIFIC SLICES OF DEPENDENT BEHAVIOR critical to the execution of development and testing tasks.

        This provides JUST ENOUGH application logic so that the developers or testers get what they need without having to wait for the actual service to be completed and readily available. For instance, instead of virtualizing an entire database (and performing all associated test data management as well as setting up the database for every test session), you MONITOR how the application interacts with the database, then you emulate the related database behavior (the SQL queries that are passed to the database, the corresponding result sets that are returned, and so forth).

        這裡的 monitor 大概就是 "錄製" application 與其他 component 的 "網路溝通"，開發測試期間再 "重播" 即可。

## Mocking ?? {: #vs-mocking }

  - [Service Virtualization as an Alternative to Mocking](https://www.infoq.com/news/2013/04/Service-Virtualization/) (2013-04-22) #ril
  - [Service virtualization arises to meet services testing obstacles](https://searchmicroservices.techtarget.com/news/2240150279/Service-virtualization-arises-to-meet-services-testing-obstacles) (2012-05-15) #ril

## 工具 {: #tools }

  - [Comparison of API simulation tools \- Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_API_simulation_tools)

      - The tools listed here support emulating or simulating APIs and software systems. They are also called API MOCKING tools, SERVICE VIRTUALIZATION tools, over the wire test doubles and tools for stubbing and mocking HTTP(S) and other protocols. They enable COMPONENT TESTING in isolation.

      - In alphabetical order by name (click on a column heading to sort by that column):

        包括 Hoverfly、Wiremock 等，為何 mitmproxy 不在裡面?

  - [Topic: service\-virtualization - GitHub](https://github.com/topics/service-virtualization) #ril
  - [10 Best Service Virtualization Tools in 2019: Microservices and Mocking](https://www.guru99.com/service-virtualization-tools.html) #ril

## 參考資料 {: #reference }

工具：

  - [Hoverfly](hoverfly.md)
  - [Wiremock](wiremock.md)
