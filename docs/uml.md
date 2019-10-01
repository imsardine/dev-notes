# UML

  - [Unified Modeling Language \- Wikipedia](https://en.wikipedia.org/wiki/Unified_Modeling_Language)

      - The Unified Modeling Language (UML) is a GENERAL-PURPOSE, developmental, modeling language in the field of software engineering that is intended to provide a standard way to VISUALIZE THE DESIGN OF A SYSTEM.

        The creation of UML was originally motivated by the desire to STANDARDIZE the disparate notational systems and approaches to software design. It was developed by Grady Booch, Ivar Jacobson and James Rumbaugh at Rational Software in 1994–1995, with further development led by them through 1996.

      - In 1997 UML was adopted as a standard by the Object Management Group (OMG), and has been managed by this organization ever since. In 2005 UML was also published by the International Organization for Standardization (ISO) as an approved ISO standard. Since then the standard has been PERIODICALLY REVISED to cover the latest revision of UML.

        工具能否跟得上是一回事，但看圖的人一定要能跟上才能看懂，達到溝通的目的。

    Design

      - UML offers a way to visualize a system's architectural blueprints in a diagram, including elements such as:

          - any activities (jobs);
          - individual components of the system;
          - and how they can interact with other software components;
          - how the system will run;
          - how entities interact with others (components and interfaces);
          - external user interface.

      - Although originally intended for OBJECT-ORIENTED design documentation, UML has been extended to a larger set of design documentation (as listed above), and been found useful in many contexts.

    Modeling

      - It is important to distinguish between the UML model and the set of diagrams of a system. A diagram is a PARTIAL graphic representation of a system's model. The set of diagrams NEED NOT COMPLETELY cover the model and deleting a diagram does not change the model. The model may also contain DOCUMENTATION that drives the model elements and diagrams (such as written USE CASES).

        System model 是個整體，由 diagrams 跟 documentation 組成，每個 diagram 通常只會描繪 model 的某個面向 (view)。

      - UML diagrams represent two different VIEWS of a system model:

          - STATIC (or STRUCTURAL) view: emphasizes the static structure of the system using objects, attributes, operations and RELATIONSHIPS. It includes class diagrams and composite structure diagrams.

          - DYNAMIC (or BEHAVIORAL) view: emphasizes the dynamic behavior of the system by showing COLLABORATIONS among objects and changes to the internal states of objects. This view includes sequence diagrams, activity diagrams and state machine diagrams.

      - UML models can be exchanged among UML tools by using the XML Metadata Interchange (XMI) format.

        真有這麼容易轉?

      - In UML, one of the key tools for behavior modelling is the USE-CASE MODEL, caused by OOSE. Use cases are a way of specifying required usages of a system. Typically, they are used to capture the requirements of a system, that is, what a system is supposed to do.

        從上面 "written use cases" 的說法看來，use case diagram 的重點是伴隨的文件 ??

    Diagrams

      - UML 2 has many types of diagrams, which are divided into two categories. Some types represent structural information, and the rest represent general types of behavior, including a few that represent different aspects of interactions. These diagrams can be categorized hierarchically as shown in the following class diagram:

        ![Hierarchy of UML 2.2 Diagrams, shown as a class diagram](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/UML_diagrams_overview.svg/1200px-UML_diagrams_overview.svg.png)

        These diagrams may all contain COMMENTS or NOTES explaining usage, constraint, or intent.

        總會有 UML 語法受限的地方，都靠 note 來補。

      - Structure diagrams emphasize the things that must be PRESENT in the system being modeled.

        Since structure diagrams represent the structure, they are used extensively in documenting the software ARCHITECTURE of software systems. For example, the component diagram describes how a software system is split up into components and shows the DEPENDENCIES among these components.

      - Behavior diagrams emphasize what must HAPPEN in the system being modeled.

        Since behavior diagrams illustrate the behavior of a system, they are used extensively to describe the FUNCTIONALITY of software systems. As an example, the activity diagram describes the business and operational step-by-step activities of the components in a system.

      - Interaction diagrams, a subset of behavior diagrams, emphasize the FLOW OF CONTROL AND DATA among the things in the system being modeled. For example, the sequence diagram shows how objects communicate with each other regarding a sequence of MESSAGES.

        跟 behavior diagram 比較明顯的區分是 data flow? 因為 activity diagram 加上 swim lane 也可以表示 flow of control ??

## 新手上路 ?? {: #getting-started }

  - 可以將文字轉成圖表最好；目前以 PlantUML 的支援最完整，可惜不像 yUML 或 WebSequenceDiagrams 支援手繪風。
      - 用文字的好處是可以來回修改設計，不用等 test code 的 design feedback，尤其適用設計初期。
  - 多數輕量化的工具不支援所有類型的圖表，只要關鍵的 class diagram、sequence diagram 有支援就夠了。
  - 一張 class diagram 看要溝通什麼，只會將相關的 class 拉進來，也只會揭露必要的結節。呼應 DependencyAndAssociation - Martin Fowler (2013-09-17) https://martinfowler.com/bliki/DependencyAndAssociation.html 所說的 "You need to be very selective and show only those that are important to whatever it is you are communicating"。

## 參考資料 {: #reference }

  - [UML.org](https://www.uml.org/)

更多：

  - [Use Case Diagram](uml-use-case.md)
  - [Class Diagram](uml-class.md)
  - [State Diagram](uml-state.md)
  - [Activity Diagram](uml-activity.md)
  - [Sequence Diagram](uml-sequence.md)
  - [Component Diagram](uml-component.md)

相關：

  - [PlantUML](plantuml.md)
