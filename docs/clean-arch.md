# Clean Architecture

  - [The Clean Architecture - Clean Coder Blog](http://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) (2012-08-13)
      - Though these architectures all vary somewhat in their details, they are very similar. They all have the same objective, which is the SEPARATION OF CONCERNS. They all achieve this separation by dividing the software into LAYERS. Each has at least one layer for BUSINESS RULES, and another for INTERFACES.
      - Each of these architectures produce systems that are: 從 "business rules" 出現的次數，可想而知其居於核心的位置
          - Independent of Frameworks. The architecture does not depend on the existence of some library of feature laden software. This allows you to use such frameworks as TOOLS, rather than having to cram your system into their limited constraints.
          - TESTABLE. The business rules can be tested without the UI, Database, Web Server, or any other EXTERNAL ELEMENT.
          - Independent of UI. The UI can change easily, without changing the rest of the system. A Web UI could be replaced with a console UI, for example, without changing the business rules. 又或者相同的 business rule 必須同時面對不同的 UI。
          - Independent of Database. You can swap out Oracle or SQL Server, for Mongo, BigTable, CouchDB, or something else. Your business rules are not bound to the database.
          - Independent of any EXTERNAL AGENCY (像是 driver、API 的媒介??). In fact your business rules simply don’t know anything at all about the outside world.

        The diagram at the top of this article is an attempt at integrating all these architectures into a single ACTIONABLE IDEA. 所以 clean architecture 並不是另一個 architecture，只是從現有的架構中理出一些規則??

        ![](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

    The Dependency Rule

      - The concentric circles represent different areas of software. In general, the further in you go, the HIGHER LEVEL the software becomes. The outer circles are MECHANISMS. The inner circles are POLICIES.
      - The overriding rule that makes this architecture work is The Dependency Rule. This rule says that SOURCE CODE DEPENDENCIES can only point INWARDS. Nothing in an inner circle can know anything at all about something in an outer circle.

        In particular, the name of something declared in an outer circle must not be mentioned by the code in the an inner circle. That includes, functions, classes. variables, or any other named software entity.

      - By the same token, data FORMATS used in an outer circle should not be used by an inner circle, especially if those formats are generate by a framework in an outer circle. We don’t want anything in an outer circle to impact the inner circles. 這裡的 format 比 data type 更為廣義

    Entities

      - Entities encapsulate ENTERPRISE WIDE BUSINESS RULES. An entity can be an object with methods, or it can be a set of data structures and functions. It doesn’t matter so long as the entities could be USED BY MANY DIFFERENT APPLICATIONS in the enterprise.
      - If you don’t have an enterprise, and are just writing a single application, then these entities are the BUSINESS OBJECTS of the application. They encapsulate the most general and HIGH-LEVEL RULES. They are THE LEAST LIKELY TO CHANGE WHEN SOMETHING EXTERNAL CHANGES. For example, you would not expect these objects to be affected by a change to page navigation, or SECURITY. No OPERATIONAL CHANGE to any particular application should affect the entity layer.

        這也就是為何 DDD 主張權限的檢查要做在 facade。

    Use Cases

      - The software in this layer contains APPLICATION SPECIFIC business rules. It encapsulates and implements all of the USE CASES of the system. These use cases orchestrate the flow of data to and from the entities, and direct those entities to USE THEIR ENTERPRISE WIDE BUSINESS RULES to achieve the goals of the use case.

        呼應上面 entity "used by many different applications in the enterprise" 的說法，application 怎麼利用 entity 來達成 application 特有的功能 (UI 上呈現出來，可以讓使用者完成的事)，這些跟 operation 相關的邏輯就叫 use case；聽起來很像 DDD 裡的 APPLICATION facade!!

      - We do not expect changes in this layer to affect the entities. We also do not expect this layer to be affected by changes to EXTERNALITIES (外部事物) such as the database, the UI, or any of the COMMON FRAMEWORKS. This layer is isolated from such CONCERNS.

        這裡的 externality 指的是這個 layer 以外的地方 (而非整個 application 的外部)，也就是 use case 的實作不會涉及 DB、UI 及 common framework。所謂 common framework 指的應該是 [Flask](flask.md)、[Click](click.md)、[Scrapy](scrapy.md) 這類規範 "event 進來後如何分派、回應" 的 [software framework](https://en.wikipedia.org/wiki/Software_framework)。

      - We do, however, expect that changes to the OPERATION OF THE APPLICATION will affect the use-cases and therefore the software in this layer. If the details of a USE-CASE change, then some code in this layer will certainly be affected.

    Interface Adapters ??

      - The software in this layer is a set of ADAPTERS that convert data from the format most convenient for the use cases and entities, to the format most convenient for some EXTERNAL AGENCY such as the Database or the Web. It is this layer, for example, that will wholly contain the MVC architecture of a GUI. The Presenters, Views, and Controllers all belong in here. The models are likely just DATA STRUCTURES (沒有行為) that are passed from the controllers to the use cases, and then back from the use cases to the presenters and views.
      - Similarly, data is converted, in this layer, from the form most convenient for entities and use cases, into the form most convenient for whatever persistence framework is being used. i.e. The Database. No code inward of this circle should know anything at all about the database. If the database is a SQL database, then all the SQL should be restricted to this layer, and in particular to the parts of this layer that have to do with the database.
      - Also in this layer is any other adapter necessary to convert data from some external form, such as an external service, to the internal form used by the use cases and entities.

    Frameworks and Drivers.

      - The outermost layer is generally composed of FRAMEWORKS and TOOLS such as the Database, the Web Framework, etc. Generally you don’t write much code in this layer other than GLUE CODE that communicates to the next circle inwards.

        其中 "glue code" 暗示著，像 Flask 的 routing 這一層，應該越薄越好。

      - This layer is where all the DETAILS go. The Web is a detail. The database is a detail. We keep these things on the outside where they can do little harm.

        事實上，這些都是我們不用管的 "實作細節" (幫我們省掉很多事)，我們真正要做的事都在同心圓的內圈。

    Only Four Circles?

      - No, the circles are SCHEMATIC. You may find that you need more than just these four. There’s no rule that says you must always have just these four. However, The Dependency Rule always applies. SOURCE CODE DEPENDENCIES ALWAYS POINT INWARDS. As you move inwards the LEVEL OF ABSTRACTION INCREASES. The outermost circle is low level concrete detail. As you move inwards the software grows more abstract, and encapsulates higher level POLICIES. The inner most circle is the MOST GENERAL (可重用性高).

        注意是 source code dependency 而非機制上的 dependency，例如 entity 本身有參與 ORM，似乎跟 DB 有關，但 source code 上確實是沒有關聯的 (雖然會宣告一些 mapping、relationship)，所以 entity 與 DB 在同心圓上分別位在中心點與最外圈，看似沒有關聯。

    Crossing boundaries. ??

      - At the lower right of the diagram is an example of how we cross the circle boundaries. It shows the Controllers and Presenters communicating with the Use Cases in the next layer. Note the flow of control. It begins in the controller, moves through the use case, and then winds up executing in the presenter. Note also the source code dependencies. Each one of them points inwards towards the use cases.
      - We usually resolve this apparent contradiction (矛盾) by using the Dependency Inversion Principle. In a language like Java, for example, we would arrange interfaces and inheritance relationships such that the source code dependencies oppose the flow of control at just the right points across the boundary.
      - For example, consider that the use case needs to call the presenter. However, this call must not be direct because that would violate The Dependency Rule: No name in an outer circle can be mentioned by an inner circle. So we have the use case call an interface (Shown here as Use Case Output Port) in the inner circle, and have the presenter in the outer circle implement it.
      - The same technique is used to cross all the boundaries in the architectures. We take advantage of dynamic polymorphism to create source code dependencies that oppose the flow of control so that we can conform to The Dependency Rule no matter what direction the flow of control is going in.

    What data crosses the boundaries. ??

      - Typically the data that crosses the boundaries is SIMPLE DATA STRUCTURES. You can use basic structs or simple Data Transfer objects if you like. Or the data can simply be arguments in function calls. Or you can pack it into a HASHMAP, or construct it into an object. The important thing is that ISOLATED, simple, data structures are passed across the boundaries. We don’t want to CHEAT and pass Entities or Database rows. We don’t want the data structures to have any kind of dependency that violates The Dependency Rule.
      - For example, many database frameworks return a convenient data format in response to a query. We might call this a `RowStructure`. We don’t want to pass that row structure inwards across a boundary. That would violate The Dependency Rule because it would force an inner circle to KNOW SOMETHING ABOUT AN OUTER CIRCLE.
      - So when we pass data across a boundary, it is always in the form that is MOST CONVENIENT FOR THE INNER CIRCLE.

    Conclusion

      - Conforming to these simple rules is not hard, and will save you a lot of headaches going forward. By SEPARATING THE SOFTWARE INTO LAYERS, and conforming to The DEPENDENCY RULE, you will create a system that is intrinsically TESTABLE, with all the benefits that implies. When any of the external parts of the system become OBSOLETE, like the database, or the web framework, you can replace those obsolete elements with a minimum of fuss.

        隨著時間過去，"the external parts of the system becom obsolete" 很常發生，但內圈的 application/enterprise business rule 卻不太會變。

## 參考資料

  - [Clean Coders](https://cleancoders.com/)
  - [Clean Coder Blog](http://blog.cleancoder.com/)

書籍：

  - [Clean Architecture: A Craftsman's Guide to Software Structure and Design - Prentice Hall](http://www.informit.com/store/clean-architecture-a-craftsmans-guide-to-software-structure-9780134494166) (2017.09)
  - [Clean Code: A Handbook of Agile Software Craftsmanship - Prentice Hall](http://www.informit.com/store/clean-code-a-handbook-of-agile-software-craftsmanship-9780132350884)
  - [Clean Coder, The: A Code of Conduct for Professional Programmers - Prentice Hall](http://www.informit.com/store/clean-coder-a-code-of-conduct-for-professional-programmers-9780137081073)
