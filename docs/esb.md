# ESB (Enterprise Service Bus)

  - [Enterprise service bus \- Wikipedia](https://en.wikipedia.org/wiki/Enterprise_service_bus)

      - An enterprise service bus (ESB) implements a COMMUNICATION SYSTEM between mutually interacting software applications in a SERVICE-ORIENTED ARCHITECTURE (SOA).

        下面提到 ESB 是 SOA 常見的一種 implementation pattern。

        It represents a software architecture for DISTRIBUTED COMPUTING, and is a special variant of the more general client-server model, wherein any application may behave as SERVER OR CLIENT.

      - ESB promotes agility and flexibility with regard to HIGH-LEVEL PROTOCOL COMMUNICATION between applications. Its primary use is in enterprise application integration (EAI) of heterogeneous and complex service landscapes.

    Architecture

      - The concept of the enterprise service bus is analogous to the BUS concept found in COMPUTER HARDWARE architecture combined with the modular and concurrent design of high-performance computer operating systems.

        The motivation for the development of the architecture was to find a standard, structured, and general purpose concept for describing implementation of LOOSELY COUPLED SOFTWARE COMPONENTS (called services) that are expected to be independently deployed, running, heterogeneous, and disparate within a network.

      - ESB is also a common IMPLEMENTATION PATTERN for service-oriented architecture, including the intrinsically adopted network design of the World Wide Web.

      - No global standards exist for enterprise service bus concepts or implementations. Most providers of MESSAGE-ORIENTED MIDDLEWARE have adopted the enterprise service bus concept as de facto standard for a service-oriented architecture.

        The implementations of ESB use EVENT-DRIVEN and standards-based message-oriented middleware in combination with MESSAGE QUEUES as technology frameworks. However, some software manufacturers RELABEL existing middleware and communication solutions as ESB without adopting the crucial aspect of a bus concept.

    Functions

      - An ESB applies the design concept of modern operating systems to independent services running within networks of disparate and independent computers. Like concurrent operating systems, an ESB provides COMMODITY SERVICES in addition to adoption, translation and routing of CLIENT REQUESTS TO APPROPRIATE ANSWERING SERVICES.

        > Commodity services are type of services that allow purchasers or sellers to meet the counterparty to trade a commodity or commodity related investment items.
        >
        > -- [Commodity Services Market - Allied Market Research](https://www.alliedmarketresearch.com/commodity-services-market-A06703)

      - The primary duties of an ESB are:

          - Route messages between services
          - Monitor and control routing of message exchange between services
          - Resolve CONTENTION between communicating service components
          - Control deployment and versioning of services
          - Marshal use of redundant services

          - Provide commodity services like event handling, DATA TRANSFORMATION AND MAPPING, message and event queuing and sequencing, SECURITY or exception handling, protocol conversion and enforcing proper quality of communication service.

            為什麼這些要稱做 commodity services??

    History

      - The first published usage of the term "enterprise service bus" is attributed to Roy W. Schulte from the Gartner Group 2002 and the book The Enterprise Service Bus by David Chappell.

        Although a number of companies take credit for coining the phrase, in an interview, Schulte said that the first time he heard the phrase was from a company named Candle and went on to say: "The most direct ancestor to the ESB was Candle’s Roma product from 1998" whose Chief Architect and patent application holder was Gary Aven.

        Roma was first sold in 1998 making it the first commercial ESB in the market, but that Sonic's product from 2002 was also one of the early ESBs on the market.

      - E, S, B

          - Service - denotes NON-ITERATIVE and autonomously executing programs that communicate with other services through message exchange
          - Bus - is used in analogy to a computer hardware bus
          - Enterprise - the concept has been originally invented to reduce complexity of enterprise application integration within an enterprise; the restriction has become obsolete since modern Internet communication is no longer limited to a corporate entity

    ESB as software

      - The ESB is implemented in software that operates between the business applications, and enables communication among them. Ideally, the ESB should be able to REPLACE ALL DIRECT CONTACT with the applications on the bus, so that all communication takes place via the ESB.

      - To achieve this objective, the ESB must ENCAPSULATE the functionality offered by its COMPONENT APPLICATIONS in a MEANINGFUL WAY.

        This typically occurs through the use of an ENTERPRISE MESSAGE MODEL. The message model defines a STANDARD SET OF MESSAGES that the ESB transmits and receives. When the ESB receives a message, it routes the message to the appropriate application. Often, because that application evolved without the same message model, the ESB has to TRANSFORM the message into a format that the application can interpret.

        A software ADAPTER fulfills the task of effecting these transformations, analogously to a physical adapter.

      - ESBs rely on accurately constructing the enterprise message model and properly designing the functionality offered by applications.

        If the message model does not COMPLETELY encapsulate the application functionality, then other applications that desire that functionality may have to BYPASS the bus, and invoke the mismatched applications directly. Doing so violates the principles of the ESB model, and negates many of the advantages of using this architecture.

      - The beauty of the ESB lies in its PLATFORM-AGNOSTIC nature and the ability to integrate with anything at any condition.

        It is important that Application Lifecycle Management vendors truly apply all the ESB capabilities in their integration products while adopting SOA. Therefore, the challenges and opportunities for EAI vendors are to provide an integration solution that is low-cost, easily configurable, intuitive, user-friendly, and open to any tools customers choose.

    Key benefits

      - Scales from point-solutions to enterprise-wide deployment (distributed bus)
      - MORE CONFIGURATION RATHER THAN INTEGRATION CODING
      - No central rules-engine, no central broker ??
      - Easy plug-in and plug-out and loosely coupling system

    Key disadvantages

      - Slower communication speed, especially for those already compatible services
      - Single point of failure, can bring down all communications in the Enterprise
      - High configuration and maintenance complexity

    Products #ril

## ESB vs. Microservice {: #vs-microservice }

  - [ESB vs\. Microservices: Understanding Key Differences \- DreamFactory Software\- Blog](https://blog.dreamfactory.com/esb-vs-microservices-understanding-key-differences/) (2020-01-28) #ril
  - [Microservices vs ESB \- Yenlo](https://www.yenlo.com/blogs/microservices-vs-esb/) (2021-08-05) #ril
  - [ESB vs\. Microservices: What's the Difference? \| IBM](https://www.ibm.com/cloud/blog/esb-vs-microservices) (2021-09-03) #ril

## 參考資料 {: #reference }

書籍：

  - [Enterprise Service Bus: Theory in Practice - O'Reilly](https://www.amazon.com/Enterprise-Service-Bus-Theory-Practice/dp/0596006756) (2004-06)

相關：

  - [EAI (Enterprise Application Integration)](eai.md)
