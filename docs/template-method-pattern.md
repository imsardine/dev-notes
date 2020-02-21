# Template Method Pattern

  - [Template method pattern \- Wikipedia](https://en.wikipedia.org/wiki/Template_method_pattern) #ril

      - In object-oriented programming, the template method is one of the behavioral design patterns identified by Gamma et al. in the book Design Patterns.

        The template method is a method in a superclass, usually an abstract superclass, and defines the SKELETON OF AN OPERATION in terms of a number of HIGH-LEVEL STEPS. These steps are themselves implemented by additional HELPER METHODS in the same class as the TEMPLATE METHOD.

      - The helper methods may be either abstract methods, for which case subclasses are required to provide concrete implementations, or HOOK METHODS, which have empty bodies in the superclass.

        Subclasses can (but are not required to) customize the operation by overriding the hook methods. The intent of the template method is to define the OVERALL STRUCTURE OF THE OPERATION, while allowing subclasses to refine, or redefine, certain STEPS.

  - [Template Method Design Pattern](https://sourcemaking.com/design_patterns/template_method) #ril

    Intent

      - Define the SKELETON OF AN ALGORITHM IN AN OPERATION, deferring some STEPS to CLIENT SUBCLASSES. Template Method lets subclasses redefine certain steps of an algorithm WITHOUT CHANGING THE ALGORITHM'S STRUCTURE.

        最後一句 without chaning the algorith's structure 是關鍵 -- 大的框架不能變，但可以自訂某些 step。

      - Base class declares algorithm 'PLACEHOLDERS', and derived classes implement the placeholders.

    Problem

      - Two different components have significant similarities, but demonstrate no reuse of common interface or implementation. If a change common to both components becomes necessary, duplicate effort must be expended. ??

    Discussion

      - The COMPONENT DESIGNER decides which steps of an algorithm are INVARIANT (or STANDARD), and which are VARIANT (or CUSTOMIZABLE). The invariant steps are implemented in an abstract base class, while the variant steps are either given a default implementation, or no implementation at all.

        The variant steps represent "hooks", or "placeholders", that can, or must, be supplied by the component's client in a concrete derived class.

      - The component designer mandates the required steps of an algorithm, and the ordering of the steps, but allows the component client to extend or replace some number of these steps.

      - Template Method is used prominently in FRAMEWORKS. Each framework implements the invariant pieces of a DOMAIN'S ARCHITECTURE, and defines "placeholders" for all necessary or interesting client customization options.

        In so doing, the framework becomes the "center of the universe", and the client customizations are simply "the third rock from the sun". This INVERTED CONTROL structure has been affectionately labelled "the Hollywood principle" - "DON'T CALL US, WE'LL CALL YOU".

        從過去各種 framework 的體驗來看，step 不一定是動作，也可能是回傳某些資訊。

  - [Template Method](https://refactoring.guru/design-patterns/template-method) #ril
