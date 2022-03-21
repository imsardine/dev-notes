# Single Source of Truth (SSOT)

  - [Single source of truth \- Wikipedia](https://en.wikipedia.org/wiki/Single_source_of_truth)

      - In information systems design and theory, single source of truth (SSOT) is the practice of structuring information models and associated data schema such that every data element is MASTERED (OR EDITED) IN ONLY ONE PLACE. Any possible LINKAGES to this data element (possibly in other areas of the relational schema or even in distant federated databases) are BY REFERENCE ONLY.

        Because all other locations of the data just REFER BACK TO THE PRIMARY "SOURCE OF TRUTH" LOCATION, updates to the data element in the primary location PROPAGATE to the entire system without the possibility of a DUPLICATE VALUE somewhere being forgotten.

      - Deployment of an SSOT architecture is becoming increasingly important in enterprise settings where incorrectly linked duplicate or DE-NORMALIZED data elements (a direct consequence of intentional or unintentional denormalization of any explicit data model) pose a risk for retrieval of OUTDATED, and therefore incorrect, information.

      - A common example would be the electronic health record, where it is imperative to accurately validate patient identity against a single referential repository, which serves as the SSOT.

        Duplicate REPRESENTATIONS of data within the enterprise would be implemented by the use of POINTERS rather than duplicate database tables, rows, or cells. This ensures that data updates to elements in the AUTHORITATIVE LOCATION are comprehensively distributed to all federated database constituencies in the larger overall enterprise architecture.

      - SSOT systems provide data that are AUTHENTIC, relevant, and REFERABLE.

    Implementation

      - The "ideal" implementation of SSOT as described above is RARELY POSSIBLE in most enterprises. This is because many organisations have multiple information systems, each of which needs access to data relating to the same entities (e.g., customer).

        Often these systems are purchased "OFF-THE-SHELF" from vendors and cannot be modified in non-trivial ways. Each of these various systems therefore needs to store its own version of common data or entities, and therefore each system must retain its own copy of a record (hence immediately violating the SSOT approach defined above).

      - For example, an ERP (enterprise resource planning) system (such as SAP or Oracle e-Business Suite) may store a customer record; the CRM (customer relationship management) system also needs a copy of the customer record (or part of it) and the warehouse dispatch system might also need a copy of some or all of the customer data (e.g., shipping address).

        In cases where vendors do not support such modifications, it is not always possible to replace these records with pointers to the SSOT.

      - For organisations (with more than one information system) wishing to implement a Single Source of Truth (without modifying all but ONE MASTER SYSTEM to store pointers to other systems for all entities), four supporting architectures are commonly used:

          - Enterprise service bus (ESB)
          - Master data management (MDM)
          - Data warehouse (DW)
          - Service Oriented Architecture (SOA)

    Enterprise service bus (ESB)

      - An enterprise service bus (ESB) allows any number of systems in an organisation to RECEIVE UPDATES OF DATA THAT HAS CHANGED IN ANOTHER SYSTEM.

        To implement a Single Source of Truth, a single source system of correct data for any entity must be identified. Changes to this entity (creates, updates, and deletes) are then PUBLISHED via the ESB; other systems which need to RETAIN A COPY of that data SUBSCRIBE to this update, and update their own records accordingly.

      - For any given entity, the MASTER SOURCE must be identified (sometimes called the GOLDEN RECORD). Any given system could publish (be the source of truth for) information on a particular entity (e.g., customer) and also subscribe to updates from another system for information on some other entity (e.g., product).

        An alternative approach is point-to-point data updates, but these become exponentially more expensive to maintain as the number of systems increases, and this approach is increasingly out of favour as an IT architecture.

## 參考資料 {: #reference }

相關：

  - [ESB (Enterprise Service Bus)](esb.md)
