---
title: Workday / Security
---
# [Workday](workday.md) / Security

參考資料：

  - [Cross Application Services Glossary • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/mRhpZCroayySk~vbh892aA) 跟 security policy 相關的用詞：

      - Securable Item

        An action, report, or data that is part of a security policy. You secure access by defining the security policy to restrict access to an item to specified security groups. Related securable items are grouped into domains.

      - Domain

        A collection of RELATED securable items such as actions, reports, report data, report data sources, or custom report fields. Each domain is secured by a domain security policy.

      - Functional Area

        A collection of domain or business process security policies that are related to the same set of PRODUCT FEATURES, for example, Benefits or Compensation.

        都是 RELATED securable items, 但 functional area 是從 product feature 的角度看，而 domain 則是從資料本身的專業領域看 ??

      - Business Process Security Policy

        A business process security policy secures the STEPS AND PROCESS-WIDE actions including view, rescind, cancel and correct. It specifies which security groups have access to each action.

      - Domain Security Policy

        A collection of related securable elements of different TYPES and user-specified security groups that have access to elements of EACH TYPE.

      - View (business process)

        A securable item used to allow members to view status of a business process and report on it. A securable item in a business process security policy.

        為什麼 business process 下的 view 這麼特別要另外提出來 ??

  - [Steps: Configure Security • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/uX81UWcttjSaqVs3k5EgGQ)

    Prerequisites

      - Security: Security Configuration domain in the System functional area.

    Context

      - You can assign users to security groups and ATTACH those groups to domain security policies and business process security policies. You can also update and AUDIT ?? your security configurations.

    Steps

     1. Access the Maintain Functional Areas task.

        表格的呈現方式是 Workday Solution, Functional Area, Description, Enabled, Includes Domains, Includes Business Processes；其中 Includes Domains 項目越多，表示搭配 domain security policy 可以做到越細的控制。

        由於啟用的單位是一個 functional area，猜想一個 domain 或 process 只會歸屬於一個 functional area ?? 不過一個 functional area 可能來自多個 Workday solution 是確定的，例如 Budgets (functional area) 對應的 Workday solution 有 Core Financials、Grants、HCM、Planning。

        Select the Enabled check box for the functional areas you want to use.

     2. Access the Domain Security Policies for Functional Area report.

        以 Budgets (functional area) 為例，它在 Maintain Functional Areas 下 Includes Domains 有 Access Plan Type (Segmented)、Process: Budget、Reports: Manager Budgets、Reports: Manager Financial Budgets、Reports: Manager Position Budgets ...，在 Domain Security Policies for Functional Area 左側的選單就會看到一樣的項目，雖然有項目會藏在像資料夾的結構底下，例如 Reports: Manager Financial Budgets、Reports: Manager Position Budgets 會歸在 Reports: Manager Budgets 底下，代表著不同粗細度的控制。

        Select Domain Security Policy > Enable from the related actions menu of the Domain Security Policy.

        怎麼會有 disabled security policy? 還是預設會整個保護起來 ??

        Security: Security Activation domain in the System functional area.

        可以透過 Domain Security Policies for Functional Area > System > Security Administration > Security Activiation 查看，就可以看到哪些 security group 可以 view 或 modify。

     3. Access the Business Process Security Policies for Functional Area report.

        要先選 functional area 再選 business process，有點不太方便；是因為不同 functional area 下，可能有同名的 business process ??

        Select Business Process Policy > Edit from the related actions menu of the business process type. (這裡的 Process Policy 指的就是 Security Policy)

        左側樹狀結構的根節點是剛選定的 business process，底下展開的節點是 Business Process Type? 子流程 ??

        Add the appropriate security groups on the relevant INITIATING ACTION. You can disable the business process security policy by removing all the security groups from the relevant initiating action.

        只針對 initiating action ?? 每個 step 裡哪些 action 可以由哪些人執行不在這裡設定 ??

     4. Activate your pending security policy changes.

        修改的過程中會有 alert 提示：

        > Activate your security policy changes using the Activate Pending Security Policy Changes task, and update the security evaluation moment, which is currently set to ...

        為什麼 activate 要藏這麼深 Orz ...

     5. Assign users to security groups.

        See Concept: Security Groups.

     6. Edit Domain Security Policies.
     7. Edit Business Process Security Policies.

     8. Review your security configuration.

        See Reference: Security-Related Reports.

  - [Concept: Configurable Security • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/1x3I4QWhkFJITT_tN8Jy1g)

      - Workday groups solutions into distinct functional areas. Each functional area is FURTHER DIVIDED INTO domains and business processes. A domain is a PREDEFINED SET OF related securable items (reports, tasks, instance sets, report fields, and data sources).

        Example: HCM includes the Succession Planning functional area comprising a number of domains and business processes related to talent management.

      - The contents of a domain AREN’T CONFIGURABLE.

        Although you can’t change the securable items comprising a domain, you can control access to a domain through its domain security policy. You can use the domain security policy to link a domain with any Workday security groups that should have access.

      - A business process is a set of configurable steps used to complete a larger overall task, such as hiring an employee. You control access to a business process through its business process security policy. The policy defines the security groups that have access to the COMPONENTS of a specific business process, including:

          - Initiating the business process.
          - Action steps in the business process.
          - Approvals.
          - Overall actions on the business process (View, Rescind, Cancel, and Correct).
          - Policy restrictions, such as delegation, comments, and attachments.

    Security Groups

      - A security group is a collection of Workday users that you can LINK TO one or more domain or business process security policies. Workday determines security group membership FOR INDIVIDUAL USERS:

          - You explicitly add to a group.
          - Indirectly through relevant information stored about them in Workday such as role, position, or geographic location.

    Security Policies

      - When you link a security group to a domain through the security policy, you specify whether the security group has View or Modify access to the domain. For integrations, access to the domain is controlled by Get or Put PERMISSIONS.

        You can include secured items in more than 1 domain security policy. ?? Workers with different levels of access in different domains receive the LEAST restrictive access.

        第一次出現 permission 的說法，是 security policy 細分出來的概念，例如 Report/Task Permissions 分為 View 跟 Modify，而 Integration 分為 Get 跟 Put。

      - Security groups also are linked to business processes through business process security policies.

    Inheritance in Domain Security Policies

      - Workday defines PARENT-CHILD RELATIONSHIPS so that child security policies can INHERIT the permissions of a parent security policy.

        Example: The Set Up: Accounting Rules domain inherits permissions from the Set Up: Financial Accounting domain. The parent-child relationships can help you more easily maintain security permissions. You can view whether a domain security policy inherits permissions by accessing the View Domain Security Policy ?? report.

        用 `domain:Set Up: Accounting Rules` 可以找到該 domain，進到 domain 的頁面會看到：

          - Functional Areas: Common Financial Management
          - Part Of Domain Groups: Common Financial Management
          - Super Domain: Super Domain

        從 "Functiona Areas" (有 s) 的命名看來，一個 domain 可能跟多個 functional area 有關 ?? 什麼是 domain group ??

        順著 functional area 的選單 Functional Area > View Domain Security Policies，左側選單可以在 Set Up: Financial Accounting 下面可以找到 Set Up: Accounting Rules，視覺化表現了其間的父子關係。

      - When the child security policy requires different permissions, you can OVERRIDE the permissions that it inherits from the parent security policy. Overriding the permissions doesn’t affect the inheritance on any of the other child security policies. When you want to return to the permissions from the parent security policy, click Use Parent Permissions on the View Domain Security Policy report.

      - Secured items in a parent security policy include the items from the super domain and all subdomains. A super domain might not have securable items of its own. The security policy on the super domain only secures items on the subdomain when the subdomain inherits permissions from the super domain. When the policy on the subdomain doesn't inherit permissions from the super domain, Workday only displays the items when you view the subdomain. Items can only display in 1 subdomain. ??

        為什麼一再出現 "secured item in security policy" 的說法 ?? 因為 domain 是多個 securable item 的集合，所以一個 domain security policy 下會看到 Securable Actions、Securable Reporting Items 並不意外

      - Workday validates the permissions on a domain security policy only when the security policy is active.

        意思 disable 時，存取完全不受限 ??

    Inherent Permissions

      - Workday provides default access to certain securable items through inherent permissions. While you can remove security groups from some of the domain security policies, the security groups retain access to the items secured by the security policies.

        Example: The Implementers security group has inherent permissions to the User-Based Security Group Administration domain security policy. Members of the Implementers security group have PERMANENT access to items secured by the domain.

        用 `domain:User-Based Security Group Administration` 會看到 "Inherent Permissions: View and Modify - Implementers"

      - The Inherent Permission field on the View Domain report lists the security groups that have permanent access to a domain security policy.

    Security Policy Change Control

      - When you modify your security policies, Workday keeps track of the date and time of each change. Workday then evaluates the security configuration as of a time stamp. As you make changes, Workday saves them as PENDING until you activate them. When you activate them, Workday records the time stamp as of that moment. You can activate a previous time stamp if needed.

        有點像版本控制，可以回覆到舊版。

  - [Concept: Assigning Users to Security Policies • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/JDPOr9Pw5d~n2z_030psNw)

    You can assign users to security policies in 2 ways.

      - Assign Users Directly to Security Groups

        You can assign:

          - Users to Workday-delivered or custom user-based security groups.
          - Integration system users to integration system security groups.

      - Derive Security Group Membership

        You can configure security group membership based on relevant information about the user. You can assign:

          - Worker positions to organization roles. If you need organization-specific security access, you can create organization roles and role-based security groups.
          - The appropriate job profile during the hire or job change process.
          - Users to the appropriate organizations when you configure organization-based security groups.
          - Users to the appropriate locations when you configure location-based security groups.

    Assign Security Group to a Policy

      - After you assign your users to a security group, you must assign the security group to a domain or business process security policy using these tasks:

          - Edit Domain Security Policies
          - Edit Business Process Security Policies

  - [Concept: Assigning Users to Security Policies • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/JDPOr9Pw5d~n2z_030psNw) #ril

      - Workday enables you to:

          - Report on the securable items that are accessible to a specific security group using the Action Summary for Security Group report.

            查看特定 security group 被納入哪些 domain security policy 及 business security policy

          - Report on how delivered items such as reports, tasks, and data sources are secured using the View Security for Securable Item report.

            用關鍵字搜尋 securable item，再查看各自的 security 設定。

    Action Summary for Security Group

      - Select a security group from the Security Group prompt.
      - This report lists the domain Security Policies and Business Process Policies on separate tabs.
      - In the Secured Items column, click the number beside each type of secured item (such as Data Sources and Report Fields) to view detailed information for each secured item of that type.

    View Security for Securable Item

      - Select a securable item from the Securable Item prompt.

        這裡 SELECT 的說法有誤，應該是輸入關鍵字，按 OK 會找出許多 securable items (task、report、report field 等)，按對應的 View Security 才能看到細節。

      - Enter at least 3 characters of the securable item you want to evaluate and click OK to view results that match the search. Click the View Security button for the item you want to evaluate.

  - [FAQ: Configurable Security • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/kjekCzW6Y0RRNvRoL_ioBg) #ril

## Security Group

  - [Cross Application Services Glossary • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/mRhpZCroayySk~vbh892aA) 相關的用詞：

      - Security Group

        A COLLECTION OF USERS or objects that are related to users. Security group access to a securable item in a security policy grants access to the users associated with the security group.

        "Security group access to a securable item in a security policy" 有點繞口，意思是 securable item 可以透過 security policy 限制存取；security group 若被選進該 policy，屬於該 security group 的所有使用者，就能存取該 securable item。

        這裡唯獨沒提到 Segment-Based Security Group。

      - Aggregation Security Group (OR)

        A security group whose members are OTHER SECURITY GROUPS. Grants access to workers associated with ANY included security group.

      - Intersection Security Group (AND)

        A security group whose members are other security groups. Members associated with ALL included security groups are granted access through an intersection security group.

      - Job-Based Security Group

        A security group that includes one or more JOB-RELATED ATTRIBUTES or objects including job profile, job family, job category, management level, or exempt/non-exempt status.

      - Location Membership Security Group

        A security group whose members are any workers assigned to that location.

      - Organization Security Group

        A security group whose members are any workers assigned to that organization.

      - Predefined Security Group

        Security groups whose members are ASSIGNED THROUGH A BUSINESS PROCESS. These groups CANNOT BE CHANGED except by reversing the business process or executing a new business process, such as applying for a position, or being hired. Examples include: Employee, Contingent Worker, and Pre-Hire.

      - Role-Based Security Group

        A security group that specifies one ORGANIZATION ROLE and includes workers in positions defined for that organization role.

      - User-Based Security Group

        A security group whose MEMBERS ARE WORKERS. In a security policy, it grants access to the securable items to all members of the group.

        所有的 security group 最終都是展開成 user/worker，這裡 user-based 指的是直接列使用者的白名單，不像其他型態的 security group 是透過條件篩選而來。

## Segment

  - View Domain > Segmented Setup 可以看到底下有哪些 subdomains。

參考資料：

  - [Segment • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/geSr2ofG9OuR~xXtU_1deQ)

    A grouping of RELATED securable items, such as pay components, that can be secured together using a segment-based security group for that segment.

    解讀成 "segments of data" 會比較容易懂，比如將 supplier 畫分成不同性質，這樣不同業務性質的 buyer 才不會看到不相干的 supplier (及背後的交易細節)。

    跟 domain、functional area 是什麼關係 ??

  - [Create Segment\-Based Security Groups • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/ZsLMQnhxPORDkzOFpO6QWA) #ril

    Prerequisites

      - Security: Security Configuration domain in the System functional area.

    Context

      - A segment-based security group comprises members of other security groups, and grants access to SELECTED COMPONENTS (SEGMENTS) OF A SECURED ITEM.

        Use a segment-based security group in a security policy to control access to secured items that are contained in the segment. Members can be part of multiple groups and have access to multiple security segments.

      - Workday enables you to DEFINE security segments in many different areas. To define a security segment, you must belong to a security group with Modify permissions on the Segmented Setup domain.

      - Example: Create a Benefits Deductions segment-based security group for pay components. Include the Benefits Administrator and Benefits Partner security groups, and configure it for access only to these pay components:

          - Dental
          - Medical
          - Vision

        The Benefits Administrator security group is a user-based group, and is NOT CONTEXT SENSITIVE. Any member of this group can see the benefits-related Pay Results (dental, medical, and vision pay components) on employee records.

        The Benefits Partner security group is a role-based group; members can see the same pay results as the Benefits Administrator security group, but only for employees in their organization.

Steps
Access the Create Security Group task.
(Optional) You can inactivate the security group, unless you:
Grant the security group permission to the Security Configuration domain.
Include the security group as a member of another security group.
Specify the security group as an administrator for another security group.
Select one or more Security Groups to identify who has access to the securable items.
In the Access to Segments prompt, select the security segments to which members of the specified security groups have access. You can select from the tenanted or Workday owned security segments available in the prompt, or create a tenanted security segment.
Workday owned security segments include:
Job Application - Contingent Worker
Job Application - Employee
Job Application - External
Note: You can't combine security segments of different types in a segment-based security group.
Next Steps
A user with access to a domain through both a segment-based and a non-segment-based security group has access to all segments. Ensure that non-segment-based security groups are associated only with users allowed access to all segments by:
Reviewing all security groups on the policy before adding segment-based security groups.
Reviewing all included security groups in any aggregation security groups.

  - [Steps: Restrict Access to Supplier Information • Financial Management • Reader • Administrator Guide](https://doc.workday.com/reader/dHvoVCr~P~0GOgQgE5Ot4A/h5MU_QOMoIv~3nx8KnDULQ) #ril

    Prerequisites

      - Determine whether you need to restrict SEGMENTS OF DATA to groups of workers.
      - You must have permission on the Supplier Segmented Setup domain in the System functional area.
      - Security: Security Configuration domain in the System functional area.

    Context

      - You can use SEGMENTED SECURITY to restrict access to DESIGNATED SUPPLIERS and visibility into important supplier information. Workers who don't have access to a security segment CAN ONLY VIEW TRANSACTION DETAILS and can't:

        為什麼可以看到 transaction details ??

          - Select suppliers that they don't have access to when creating, editing, reporting, or searching for transactions.
          - View search results for suppliers or supplier as a worktag ??. Workday masks the supplier name with asterisks and doesn't display other information.
          - Print or view supplier documents, such as invoices, contracts, or purchase orders.

      - On the Supplier Portal ??, supplier contacts can view only the suppliers assign to them.

    Steps

     1. Access the Create Supplier Security Segment task.

        Select the suppliers, supplier groups, or supplier categories that you want to include in the segment.

        三種過濾條件 (supplier, group, category) 是 OR 的關係，而非 AND；這聽起來合理，否則單選 supplier 這種條件就不需存在。

        Included values can cross multiple segments or be mutually exclusive. Workday recommends that you build from least to most restrictive segment.

        根據需求不同，segment 間可以有重疊或是完全不重疊。

        Security: Supplier Segmented Setup domain in the System functional area.

     2. Create Segment-Based Security Groups.

        Select Segment-Based Security Group from the Type of Tenanted Security Group prompt.

        從 Create Security Group (task) 進去

        Select the supplier security segment you created from the Access to Segments prompt.

     3. Edit Domain Security Policies.

        Select these functional areas and domain security policies:

          - Suppliers: Select the Access Supplier (Segmented) domain security policy, remove the All Users security group, and add the groups you want to include.
          - Procurement: Select the Access Requisition Supplier (Segmented) domain security policy and configure permissions.

     4. Activate Pending Security Policy Changes.

    Example

      - Your international talent agency subjects client data to strict restrictions. You implement supplier segmented security to make sure only workers with access to the East Canada and UK security segments can find, view, and update supplier information.

      - To create the East Canada security segment, you select all the supplier groups available today, including the Quebec SUPPLIER GROUP. Later, when you create a supplier and select the Quebec supplier group, Workday automatically adds the new supplier to the East Canada security segment.

        根據 supplier group；有新 supplier 出現時加入 supplier group 即可，segment 本身不用再調整。

      - To create the UK security segment, you INDIVIDUALLY SELECT all the suppliers based in Great Britain. Later, when you create a new supplier that is based in England, you must MANUALLY add it to the UK security segment.

        個別選定的 supplier；有新 supplier 出現時要再調整 segment。

## 參考資料 {: #reference }

  - [Authentication and Security - Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/root)

手冊：

  - [Reference: Security-Related Reports - Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/jrF_ZvJvQuoiUZHD0XGiBQ)

  - Maintain Functional Areas - 列出所有的 functional area
  - Domain Security Policies for Functional Area - 查看特定 functional area 的 domain security policy
  - Domain Security Policy Summary - ?
  - Business Process Security Policies for Functional Area - 查看特定 functional area 的 business process security policy
  - Action Summary for Security Group - 查看特定 security group 被納入哪些 domain security policy 及 business security policy
  - View Security for Securable Item - 用關鍵字搜尋 securable item，再查看各自的 security 設定
  - Activate Pending Security Policy Changes
  - View All Security Timestamps - 查看過去啟用 security policy 變更的記錄，但看不出是誰套用的?
  - Create Security Group

  - Assign User-Based Security Groups for Person - 設定員工屬於哪些 user-based group
  - Assign Users to User-Based Security Group  - 設定 user-based security group 裡有哪些人
  - User-Based Security Group Assignments - 列出所有 user-based security group，分別有哪些成員
  - View Security Groups for User - 員工整體上屬於哪些 security group
  - Compare Permissions of Two Security Groups - 比較 2 個 security group 的差別
