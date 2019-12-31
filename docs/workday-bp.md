---
title: Workday / Business Process
---
# [Workday](workday.md) / Business Process

  - [Concept: Business Processes and Organizations • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/G9K_pGWc18mq9w_C4CAhZg) #ril

      - To define a custom business process, you must first ASSOCIATE IT WITH A BUSINESS OBJECT (typically an organization). The business process definition is then available within that organization and, if that organization has a hierarchy, all organizations beneath it.

        從哪裡新建 process ?? 又如何讓 process 出現在首頁 ??

        To determine which ORGANIZATION TYPES you can associate with a business process, run the Business Process Configuration Options report. ??

      - If you are in a supervisory organization and its parent organization has a business process defined, you can use that business process. However, you can create YOUR OWN VERSION of that same business process in the child supervisory organization. When you do, the version associated with the parent organization is no longer available.

      - You can't have 2 versions of the same business process in the same organization. If you need a variation, either use conditions or create another organization for the second version of the business process.

      - When you initiate a business process, Workday identifies which version of the business process to run by looking at the organizations associated with the object of the business process. Example: For business processes that ACT ON employee job records, the target is a job or a position assigned to an organization. ??

      - An exception is a business process that handles a worker's person-related data, as this information isn't associated with a specific organization. In this case, Workday selects the business process definition for the organization related to the worker's PRIMARY JOB or INTERNATIONAL ASSIGNMENT ??, if they have one.

        This exception is important because workers with more than 1 job (a primary job and an additional job or jobs) might be assigned to more than 1 organization.

  - [Event • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/YJCBPIJ3q42m6v9C0NBMIg)

    A business process TRANSACTION that occurs within your organization, such as hiring or terminating an employee.

  - [Concept: Find Events • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/Ef~iPpz10vmODOYHhA4P9A) #ril

## Create

  - [Create Custom Business Processes • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/w22AwVgXVHU_7F9XVETR0g) #ril

    Prerequisites

      - Security: Business Process Administration domain in the System functional area.

## Custom Validation

  - [Configure Validation Text • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/UPHci9o43srKWwD4cbYhJQ) #ril

    Context

      - Workday enables you to OVERRIDE the DEFAULT VALIDATION MESSAGE with configurable message text. Validation messages are used in the following 3 areas in Workday, and configuration is the same for all 3 types:

          - Absence types
          - Business process validations
          - Custom validations (used in Financials)

        訊息都可以自訂，但為什麼 custom validation 只用在財務??

      - Validation messages take different forms, but they are all based on conditions and send a message to the end user when a condition is encountered. By default, the message contains the name of the associated condition; however, you can configure custom validation text to replace it.

  - [Steps: Set Up Custom Validations • Financial Management • Reader • Administrator Guide](https://doc.workday.com/reader/dHvoVCr~P~0GOgQgE5Ot4A/5kRo7d6B9RAg1C2nPd8c~Q) #ril

    Prerequisites

      - Security: Business Process Administration domain in the System functional area.

        畢竟這還是跟 business process 有關，雖然這份文件在 Financial Management 下。

    Context

      - You can use custom validations to help workers identify TRANSACTION ISSUES. The custom validations you can create varies by TRANSACTION TYPE. Create custom validations to:

          - Alert transaction APPROVERS to conditions that need more careful review.
          - Display warning or error messages when workers create a transaction that meets the conditions for the validation.
          - Prevent workers from submitting invalid transactions until they resolve an error.

        跟錢的交易有關，要儘早辨識出問題，所以 custom valiation 只有 FIN module 有??

    Steps

      - (Optional) Access the Maintain Condition Rule Categories task.

        To organize your custom validation rules, define the condition rule categories by selecting the Custom Validation Rule option.

      - [Set Up Custom Validation Severity and Conditions](https://doc.workday.com/reader/dHvoVCr~P~0GOgQgE5Ot4A/X4ciT4oo9Wtj0I2UZ26EdQ). #ril

      - [Configure Custom Validation Messages](https://doc.workday.com/reader/dHvoVCr~P~0GOgQgE5Ot4A/2ya8wW63DdMDk6PoT3AdVw). #ril

    Next Steps

      - You can use Object Transporter (OX) ?? to MIGRATE custom validations from 1 tenant to another. Example: You can test custom validations in your Sandbox tenant, then migrate them to your Production tenant.

## Delegation ??

 - [Concept: Delegation \- Act On Behalf Of Another User • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/VE6QO05yYizUY3ShPh1vwA)

      - Workday makes it easy for you to manage and perform delegated tasks. When tasks are delegated to you, you can switch accounts to perform the tasks ON BEHALF OF ANOTHER USER. Workday displays the Switch Account option

          - in the menu displayed when you click your name or photo in the application header.
          - in delegated Inbox tasks displayed in your Inbox.

        只能針對 delegated task 操作，不會拿到另一個人的權限，或是看到另一個人才能看的東西 ??

      - Selecting Switch Account presents you with a list of users who have delegated Inbox tasks or Initiating Actions to you. Select the user for whom you want to act as a DELEGATE. Once you switch accounts, Workday displays:

        Delegate 可以用另一個人 (delegator) 的身份起單、在 process 過程中採取 action，在測試 business process 的過程尤其實用!!

          - On Behalf of, followed by the name and photo of the DELEGATOR.
          - The Delegation Dashboard ?? which includes the Delegated Actions worklet ??, and from which you can take Initiating Actions on any business processes that have been delegated to you by the user on whose behalf you are acting.
          - The Inbox which (when selected) contains only the Inbox tasks delegated to you by the user on whose behalf you are acting, and from which you can view the details and complete the tasks.

        Note: Delegated Inbox tasks are displayed in your Inbox (for your Workday account) as well. The action item titles display On Behalf of, followed by the name of the delegator to indicate that they are delegated tasks. However, you cannot view the details or complete the tasks until you switch accounts. In addition, you CANNOT VIEW THE DETAILS of or complete delegated Tasks steps, such as those found in the Onboarding business process.

      - To switch back to your Workday account, select Switch Account again, and select your own name.

  - [Set Up Delegations • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/pjUnzsXxq4b8On9vr_3gPg) #ril

    Prerequisites

      - Configure the Request Delegation Change (Default Definition) business process and security policy in the System functional area.

        該流程預設只有一個 step，起單後直接結束。

      - Security: Business Process Delegation domain in the System functional area.

    Context

      - You can configure delegations in your tenant so that workers can select a delegate to complete Inbox tasks and initiate business process actions.

    Steps

      - Access the Manage Delegation Settings report.

      - Click Request Delegation Change.

        這裡的 Worker 要選 delegator (委派工作的一方)，而非 delegate (被委派的一方)。

      - As you complete the task, consider:

          - Begin Date, End Date

            Delegation begins and ends based on the TIME ZONE OF THE DELEGATOR.

            雖然 End Date 沒有星號，但也是必填。

          - Use Default Alternate

            Workday displays the check box when you select Apply Routing Restrictions During Delegation on the Edit Tenant Setup - Business Processes task. The default alternate is the PRIMARY MANAGER DELEGATE.

            這裡應該是在講 Delegate 的設定 (必填)，沒填預設是往主管委派 ??

          - Start On My Behalf

            Select the initiating actions the delegate can perform.

          - Do Inbox Tasks On My Behalf

            這一段文件沒提到，有 For all Business Processes、For Business Process、None of the above 可選。

    Next Steps

      - Run the Business Process Tasks Not Delegated report to review tasks that Workday doesn't delegate due to ROUTING RESTRICTIONS ??.

## Request

  - [Setup Considerations: Requests • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/PGI3Br2majE9o4c1IqaLcw) #ril

      - You can use this topic to help make decisions when planning your configuration and use of Requests. It explains:

          - Why to set it up.
          - How it fits into the rest of Workday.
          - Downstream impacts and cross-product interactions.
          - Security requirements and business process configurations.
          - Questions and limitations to consider before implementation.

        Refer to detailed task instructions for full configuration details.

        High-level process:

          - Administrators can create multiple REQUEST TYPES with different steps and approvers.
          - Users initiate requests.
          - Process users implement requests by approving, closing, and setting resolutions on closed requests.

    What It Is

      - The Request business process, enables you to set up CUSTOM REQUEST PROCESSES that are initiated and tracked within Workday. You control who makes, approves, and completes the request. You also have A RECORD OF THIS INFORMATION when the process completes.

    Business Benefits

      - Workday requests free you from using WORD OF MOUTH, or email and messaging software, to REQUEST CHANGES or COLLECT INFORMATION. The Request business process enables you to KEEP TRACK of the initiation, approval, implementation, and final verification processes for your request.

        The business process history for completed requests is available for AUDITING PURPOSES.

        在系統裡留下記錄，這不就是公文簽辦單的功能?

      - If the request is ASSOCIATED with a Workday business object, you can view the request on the audit trail for that business object. Requests enable you to define your own request types and PROCESS FLOWS. You configure the security access, steps, and LEVELS OF REQUIRED APPROVAL.

    Use Cases

      - Here are examples of use cases for requests:

          - Business process changes.
          - Organization changes.
          - System account access.
          - Equipment.
          - Learning courses.
          - New security groups.
          - New reports.
          - New job profiles.

    Questions to Ask

      - Do I want users to request changes using Workday?
      - Is there information that I want to collect?

    Recommendations

      - Create a RULE BASED Request business process definition for each request type you use. In this way, you create independent process flows for different request types.
      - Display relevant tasks and reports in an easily accessible format by configuring the Requests WORKLET?? on the Workday-delivered Home dashboard.

    Requirements

      - Workday requests don't replace existing functionality.

    Limitations

      - A request DOESN'T CHANGE ANYTHING on its own. It's a REQUEST FOR ACTION.
      - Only the request initiator can change request content.

      - You can only LINK requests to these business objects:

          - Business Process Definition.
          - Committee.
          - ~Employee. 前面的毛毛蟲 ??
          - ~Worker.
          - ~Contingent Worker.
          - Union.
          - Organization.
          - Location.
          - Accounting Journal.
          - Supplier Contract.
          - Business Asset.
          - Supplier Invoice Document.
          - Customer Invoice Document.
          - Academic Record.
          - Course Definition.
          - Student.
          - Course Section Definition.

    Tenant Setup

      - No impact.

    Security

      - Administrators must configure a security policy for the Request business process default definition in your tenant (secured to the Set Up: Requests domain). Members with modify permissions on the Set Up: Requests domain security policy have access to the Create Request Type task, enabling them to create request types.

        一開始是空的，所以要知道如何改 domain 的 security policy。

      - When you configure the security policy for the Request business process default definition, include all of the security groups that you might use when creating other business process request types.

        Other request types you create will use a SUBSET of the security groups you set up on the Request business process security policy.

      - Understand segment-based security groups and segmented security, and determine how you want to restrict request type access for groups of workers.

        如果 request 只是 request for change/request，為什麼會跟 segment 有關??

      - When you configure security for a request type, security groups you select for the View All field can view all event details for requests OF THIS REQUEST TYPE.

        安全性也是依 request type 拆開的。

      - Configure the 5 domain security policies for the Request business process:

          - Set Up: Requests in the System functional area.

            Users secured to this domain can access the:

              - Create Request Type task.
              - View Request Types report.

          - Self-Service: Requests in the System functional area.

            Users secured to this domain can access these reports:

              - My Requests.
              - My Recent Requests.
              - View Request Types.

          - View: Requests in the System functional area.

            Users secured to this domain can view results on these reports:

              - My Recent Requests.
              - My Requests.

            比 Self-Service: Requests 少了 View Request Types，實務上有什麼差別??

          - Requests Segmented Setup in the System functional area.

            Users secured to this domain can access this task: Create Request Type Security Segment.

          - Reports: Requests in the System functional area.

            Users secured to this domain can access these reports:

              - All Requests.
              - Requests in Progress.

    Business Processes

      - Business process administrators can add multiple steps to a Request business process definition, including approvals or additional questionnaires.

        Workday routes request steps according to the organization OF THE REQUEST INITIATOR. Example: Workday routes a step to the HR Partner of the initiator and not the subject of the request.

        可以處理 acting 的狀況嗎??

      - If you DON'T create a rule based Request business process definition for a request type, Workday uses the default Request business process definition. However, if you configure a rule based request business process definition, you can create a HIERARCHY OF CONDITION RULES that determines which Request business definition Workday runs.

        所謂 rule based 是指大家都用同一個 Request BP，但 BP 會根據 request type 走不同的路??

      - The Close Request action step must always be the completion step in a Request business process.

## Custom Field

  - [Custom Fields: Configuration and Administration \| Workday Community](https://community.workday.com/node/393235) #ril

      - Once configured, custom fields are available throughout the application, from reporting, to business rules, to integrations.

  - [Custom Objects and Labels • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/MsTDuohl3TabdzwtzjXbRw) #ril

## 參考資料 {: #reference }

  - [Business Processes - Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/Y6D0oWkd27J4gI9YBdfqbQ)

手冊：

  - Manage Delegation Settings - 有 Request Delegation Change 可以調整設定
  - Business Process Tasks Not Delegated - 查看哪些 BP 因為某些限制無法成功被 delegate。
  - Business Process Unassigned Step Audit - 查看哪些 BP 因找不到人而卡關
