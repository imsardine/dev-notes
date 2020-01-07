---
title: UML / Activity Diagram
---
# [UML](uml.md) / Activity Diagram

  - [Activity diagram \- Wikipedia](https://en.wikipedia.org/wiki/Activity_diagram) #ril

      - Activity diagrams are graphical representations of workflows of STEPWISE activities and actions[1] with support for choice, iteration and concurrency. In the Unified Modeling Language, activity diagrams are intended to model both computational and organizational processes (i.e., workflows), as well as the data flows intersecting with the related activities.[2][3] Although activity diagrams primarily show the overall flow of control, they can also include elements showing the flow of data between activities through one or more data stores.

## 跟 Sequence Diagram 的不同？ {: vs-sequence-diagram }

  - [Difference between Sequence Diagram and Activity Diagram \- GeeksforGeeks](https://www.geeksforgeeks.org/difference-between-sequence-diagram-and-activity-diagram/) #ril

    What is Sequence Diagram ?

      - A sequence diagram simply depicts INTERACTION BETWEEN OBJECTS in a sequential order i.e. the order in which these interactions take place. We can also use the terms event diagrams or event scenarios to refer to a sequence diagram. Sequence diagrams describe HOW and IN WHAT ORDER the objects in a system FUNCTION.

        These diagrams are widely used by BUSINESSMEN and software developers to document and understand requirements for new and existing systems.

        商業人士容易懂嗎? 上面 "in a system function" 似乎在暗示 sequence diagram 主要用在演算法??

      - Example: A sequence diagram for an emotion based music player:

        ![](https://media.geeksforgeeks.org/wp-content/uploads/seq19.png)

    What is Activity Diagram ?

      - An Activity Diagram is basically a FLOWCHART (Unified Modelling Language) diagram which is used to describe the dynamic aspect of the system. the flowchart represents the FLOW OF ACTIVITIES from one activity to another activity. The activities can be described as the OPERATION OF A SYSTEM.

        The FLOW OF CONTROL in the activity diagram is drawn from one operation to another. This flow can be sequential, branched or concurrent.

      - Example: An activity diagram for an emotion based music player

        ![](https://media.geeksforgeeks.org/wp-content/uploads/UML-Activity-Diagram.png)

    Similarities Between Sequence and Activity Diagram:

      - Both Sequence Diagram and Activity Diagram are UML diagrams.

      - Both Sequence and Activity Diagrams are used to represent the CONTROL FLOW OF MESSAGES.

        就 message 而言，Sequence Diagram 似乎更能表現?

    Differences Between Sequence Diagram and Activity Diagram

      - The Sequence diagram represents the UML, which is used to visualize the SEQUENCE OF CALLS in a system that is used to perform a specific functionality.

        The Activity diagram represents the UML, which is used to model the WORKFLOW of a system.

      - The Sequence diagram shows the MESSAGE FLOW from one OBJECT to another object.

        The Activity diagram shows the MESSAGE FLOW from one ACTIVITY to another.

      - Sequence diagram is used for the purpose of DYNAMIC MODELLING.

        Activity diagram is used for the purpose of FUNCTIONAL MODELLING.

      - Sequence diagram is used to describe the behavior of several OBJECTS in a SINGLE use case

        Activity diagrams is used to describe the general sequence of ACTIONS for SEVERAL objects and use cases.

      - Sequence diagram is mainly used to represent the time order of a process.

        Activity diagram is used to represent the EXECUTION of the process.

  - [uml \- What's the difference between activity diagram and sequence diagram? \- Stack Overflow](https://stackoverflow.com/questions/38184182/) #ril

## Data Flow ??

  - [Object Flow Edge - Activity Diagrams](https://www.uml-diagrams.org/activity-diagrams.html#object-flow-edge) #ril
  - [UMLet Homepage \- Free UML Tool](http://www.itmeyer.at/umlet/uml2/ActivityClass1.html) 在 activity 間的線條加上長方形，就可以表示 input/output ??

## 參考資料 {: #reference }

相關：

  - Activity Diagram 也是 [Flowchart](flowchart.md) 的一種。
