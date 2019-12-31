# Context Diagram

## UML

  - [UML context diagram \- Stack Overflow](https://stackoverflow.com/questions/13676386/)

    Christian: A UML context diagram does not exist. The UML defines many diagram types but no context diagrams. In UML you would use e.g. USE CASE DIAGRAMS for the same purpose.

  - [UML replacement for context diagram \- Stack Overflow](https://stackoverflow.com/questions/23761522/)

      - Aleks: I've just found the following definition: http://en.wikipedia.org/wiki/System_context_diagram That's probably what you need.

        > A context diagram defines a BOUNDARY BETWEEN THE SYSTEM, or part of a system, and its environment, showing the ENTITIES THAT INTERACT WITH IT.

          - There is no single diagram in UML that would map to this definition, but I have some good news - there are several diagrams (out of total of 14) that can show the frontier between the system and its surrounding world from different perspectives. This is much more flexible than only a context diagram.

          - First of all, I would mention a special UML element - a BOUNDARY. It can be used in any diagram type to show some kind of delimitation. You might want to optionally use it to visually delimit between the system and its environment, especially in situations when this is not explicit.

          - The following diagrams can show the boundary between the system and its environment:

              - Use case diagram (your example) support the context explicitly on the functional level. Use cases are elements of the system under development, while the actors are EXTERN entities (systems or human users). Before mentioned boundary is often used to visually delimit between the system and its environment.
              - Component diagram is used to model some kind of software modules (applications, DBs, external systems, libraries, etc). You can use it to show both internal and EXTERNAL components and the way they interact. A boundary can be used to clearly draw the SEPARATION LINE.
              - Activity diagram can show your system/business/usage processes. Some activities can be performed internally, others externally. Here you don't need the boundary, but the so called SWIMLANES to depict who does what.
              - Sequence/collaboration diagrams are another option. They show the communication sequences between several objects. If you split those objects in internal and external ones and wrap them up with the boundaries, there is another context diagram. :)

            只要能區分出 internal 與 external，就有一點 context diagram 的功效。

          - UML is flexible, there are probably further options, but I think this is enough to get the idea.

## 參考資料 {: #reference }

相關：

  - [Architecture Diagram](architecture-diagram.md) - Context diagram 屬於 architecture diagram 的一環，用來描述系統邊界。

