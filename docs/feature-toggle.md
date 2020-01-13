# Feature Toggle/Flag

  - [Feature toggle \- Wikipedia](https://en.wikipedia.org/wiki/Feature_toggle) #ril

      - A feature toggle (also feature switch, feature flag, feature flipper, conditional feature, etc.) is a technique in software development that attempts to provide an ALTERNATIVE to maintaining multiple SOURCE-CODE BRANCHES (known as feature branches), such that a feature can be tested even before it is completed and ready for release.

        這說法很務實 -- source code 可以併進 master，但功能可以只在 testing 環境開啟測試；後面新的 feature 還是可以繼續推，不會卡在有些已在 testing 環境的 feature 還不想推出。

        Feature toggle is used to hide, enable or disable the feature during run time. For example, during the development process, a developer can enable the feature for testing and disable it for other users.

      - Continuous release and continuous deployment provide developers with rapid feedback about their coding. This requires the integration of their code changes as early as possible. Feature branches introduce a BYPASS to this process. Feature toggles are an IMPORTANT TECHNIQUE used for the implementation of continuous delivery.

        之前沒想過它跟 CI & CD 的關係；看似沒什麼，但確實省下許多 branching & merging 的成本。

      - The technique allows developers to release a version of a product that has UNFINISHED features. These unfinished features are HIDDEN (TOGGLED) so they do not appear in the user interface.

        This allows many small incremental versions of software to be delivered without the COST OF CONSTANT BRANCHING AND MERGING. Feature toggles may allow shorter software integration cycles. A team working on a project can use feature toggle to speed up the process of development, that can include the incomplete code as well.

  - [Feature Toggles \(aka Feature Flags\)](https://martinfowler.com/articles/feature-toggles.html) #ril

      - Feature Toggles (often also refered to as Feature FLAGS) are a powerful technique, allowing teams to modify system behavior without changing code. They fall into various usage categories, and it's important to take that categorization into account when implementing and managing toggles.

        Toggles introduce COMPLEXITY. We can keep that complexity in check by using SMART toggle implementation practices and appropriate TOOLS to manage our TOGGLE CONFIGURATION, but we should also aim to CONSTRAIN the number of toggles in our system.

      - "Feature Toggling" is a SET OF PATTERNS which can help a team to deliver new functionality to users RAPIDLY BUT SAFELY. In this article on Feature Toggling we'll start off with a short story showing some typical scenarios where Feature Toggles are helpful. Then we'll dig into the details, covering specific patterns and practices which will help a team succeed with Feature Toggles.

        Feature Toggles are also refered to as Feature Flags, Feature Bits, or Feature Flippers. These are all synonyms for the same set of techniques. Throughout this article I'll use feature toggles and feature flags interchangebly.
