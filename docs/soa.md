# SOA (Service-Oriented Architecture)

  - [Service\-oriented architecture \- Wikipedia](https://en.wikipedia.org/wiki/Service-oriented_architecture) #ril

      - Service-oriented architecture (SOA) is a style of software design where SERVICES ARE PROVIDED TO THE OTHER COMPONENTS BY APPLICATION COMPONENTS, through a COMMUNICATION PROTOCOL OVER A NETWORK.

        The basic principles of service-oriented architecture are independent of vendors, products and technologies. A service is a DISCRETE UNIT OF FUNCTIONALITY that can be accessed remotely and acted upon and updated INDEPENDENTLY, such as retrieving a credit card statement online.

      - A service has four properties according to one of many definitions of SOA:

          - It logically represents a BUSINESS ACTIVITY with a specified outcome.
          - It is SELF-CONTAINED.
          - It is a BLACK BOX FOR ITS CONSUMERS.
          - It may consist of other UNDERLYING SERVICES.

      - SOA was first termed Service-Based Architecture in 1998 by a team developing integrated foundational management services and then business process-type services based upon UNITS OF WORK and using CORBA for INTER-PROCESS COMMUNICATIONS.

      - Different services can be USED IN CONJUNCTION to provide the functionality of a large software application, a principle SOA shares with MODULAR PROGRAMMING.

        Service-oriented architecture integrates DISTRIBUTED, SEPARATELY-MAINTAINED and -DEPLOYED software components. It is enabled by technologies and standards that facilitate components' communication and cooperation OVER A NETWORK, especially over an IP network.

        "元件之間透過網路互相存取" 就 SOA 而言是必要條件。

    Overview

      - In SOA, services use PROTOCOLS that describe how they pass and parse messages using DESCRIPTION METADATA. This metadata describes both the functional characteristics of the service and quality-of-service characteristics.

      - Service-oriented architecture aims to allow users to COMBINE LARGE CHUNKS OF FUNCTIONALITY to form applications which are built purely from existing services and COMBINING THEM IN AN AD HOC MANNER.

        A service presents a SIMPLE INTERFACE to the requester that ABSTRACTS AWAY THE UNDERLYING COMPLEXITY acting as a BLACK BOX. Further users can also access these independent services without any knowledge of their internal implementation.

    Defining concepts

      - The related buzzword service-orientation promotes loose coupling between services. SOA separates functions into distinct units, or services,[7] which developers make accessible over a network in order to allow users to combine and reuse them in the production of applications. These services and their corresponding consumers communicate with each other by passing data in a well-defined, shared format, or by coordinating an activity between two or more services.

  - 補記錄 PET 的角色 幫推導 API，由 client 去 drive，Corp IT 再去想其他的應用

## 參考資料 {: #reference }
