---
title: Workday / Integration
---
# [Workday](workday.md) / Integration

  - [Setup Considerations: Integrations • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/Ac4rVLAw3NRAINhHHOOoiQ)

      - You can use this topic to help make decisions when planning your configuration and use of Workday integrations. It explains:

          - Why to set them up.
          - How they fit into the rest of Workday.
          - Downstream impacts ?? and cross-product interactions.
          - Security requirements and business process configurations. 流程可以整合外部系統!!
          - Questions and limitations to consider before implementation.

    What It Is

      - Workday integrations enable you to exchange data efficiently between Workday and an EXTERNAL ENDPOINT. Examples:

          - EXPORT payroll data from Workday to a THIRD-PARTY PAYROLL PROVIDER.
          - IMPORT data for employee hires into Workday using Enterprise Interface Builder (EIB).

        雙向的資料交換；其中 EIB 也分 inbound 跟 outbound。

      - You can use Workday integrations to:

          - Efficiently export and import large volumes of data.
          - Initiate integrations ad hoc or on schedule.
          - Complete most tasks in bulk that you can perform in Workday.

    Business Benefits

      - Workday integrations make some tasks easier and other tasks possible. Example, an integration:

          - Can save you time and effort when transferring data from other applications into Workday.

          - Is necessary to send large volumes of payroll results regularly to a third-party payroll service IN THE FORMAT THEY REQUIRE.

            竟然不是 3rd-party payroll service 要來遷就 Workday。

      - When you need to exchange large volumes of data in a specific format with an external endpoint, Workday integrations are a good choice. With Workday integrations, you can AVOID MANUAL RE-ENTRY of data between Workday and an external application.

    Questions to Ask

      - Does a Workday-delivered INTEGRATION TEMPLATE support your use case?

        If a Workday-delivered integration template supports your use case, using that template can simplify building the integration.

      - Do you need to import and export data regularly, or infrequently?

        You can configure most Workday integrations to run on a schedule.

      - Can workers at your organization build the integrations using the technology approach that you select?

        Workday provides customer training for EIB, some Workday Connectors, and Workday Studio. 另外還有 template、API。

    Recommendations

      - Workday provides several integration technologies. The best technology for your use case varies DEPENDING ON THE USE CASE.

      - Inbound Enterprise Interface Builder (EIB)

        A tool for building simple integrations that load data into Workday.

        Advantages:

          - Available in Workday tenant.

            唯獨 Workday Studio 沒提到這點，想強調透過設定就可完成 (不用寫程式)?

          - Simpler to use than other Workday integration technologies.
          - Can use an INBOUND WEB SERVICE as a data source.

          - Can generate spreadsheet for data entry by workers who don't have access to Workday.

            產生對應的 spreadsheet 讓使用者輸入 (內含選項、驗證 ??)，再匯進 Workday。

          - Enables automation of multistep data entry in Workday (Example: Hire business process).

            若 Workday 裡的 business process 可以透過外部資料啟動，可以衍生出很多應用!! 例如這裡提到的 "multistep data entry" 透過 spreadsheet 來輸入會更有效率，尤其初上線筆數很多時。

          - Best for ONE-TIME BULK DATA LOADS. 通常是系統初上線時。

      - Outbound Enterprise Interface Builder (EIB)

        A tool for building simple integrations that export data from Workday.

        Advantages:

          - Available in Workday tenant.
          - Relatively simple to use.

          - Can use 1 Workday CUSTOM REPORT or outbound web service as a data source.

            這裡的 "outbound web service" 指的是 Workday 自己的 outbound web service operation；雖然要 Workday 遶回自己的 web service 拉資料有點奇妙。

          - Can run on schedule or LAUNCH FROM BUSINESS PROCESS STEP.

            流程中往系統外部推送資料，通常是在 process 走完時；有機會做到等外部系統產生結果再往下走嗎 ??

      - Template-Based Integrations (for specific endpoints)

        Tools for building integrations to specific services and vendors (Example: Salesforce.com). These integrations support FILE FORMATS that are SPECIFIC TO THE SERVICE.

        相較於 inbound/outbound EIB 採 Workday 要求的格式，這裡則反過來採 external endpoint 要求的格式。若外部系統不在名單裡，可以透過 template-based connector 來自訂。

        Advantages:

          - Available in Workday tenant.
          - Workday preconfigures much of the template for the specific endpoint it supports.
          - Integration supports vendor file format without additional configuration required.
          - Can run on schedule or launch from business process step.
          - Simpler than Workday Studio or WWS API.
          - Best solution if you have to integrate with the endpoint that the integration template supports.

        但 EIB 似乎也是種 integration template ??

      - Template-Based Connectors

        Tools for building integrations that export data of a specific type (Example: Worker, Organization) and export or import data in a Workday-defined XML format.

        進出都是 Workday 要求的格式，跟 inbound/outbound EIB 有什麼不同 ?? 多了 import 也可以排程、由 business process step 觸發。

        Advantages:

          - Available in Workday tenant.
          - Provides a broad range of data fields.
          - Can run on schedule or launch from business process step.
          - Some Connectors can export additional report field output if the Connector doesn't already include a field for that data.
          - Outbound Connectors can use Document Transformation Connector ?? to convert Workday XML into the file format used by the external endpoint.
          - Best solution when Workday doesn't provide an integration template for your specific endpoint.

      - Workday Studio

        An Eclipse-based Integrated Development Environment (IDE). You can build CUSTOM INTEGRATIONS that follow the same TEMPLATE-BASED MODEL as Workday Connectors.

        用 Workday Studio 開發自訂的 Template-Based Connector，稱做 "Studio Integration"。

        Advantages:

          - Flexible developer tool available from Workday.
          - Enables you to build custom integrations that reside IN YOUR WORKDAY TENANT.

          - STUDIO INTEGRATIONS can access data from ANY Workday Web Service operation.

            開發人員看得到所有的資料 ??

          - Can run on schedule or launch from business process step.
          - Best solution if your developers have completed Workday Studio training.

    Limitations

      - Inbound Enterprise Interface Builder (EIB)

        Supports only 1 data source per EIB.

      - Outbound Enterprise Interface Builder (EIB)

        Supports only 1 data source (Custom Report or web service) per EIB.

      - Template-based Integration (specific endpoint)

          - Can be more complex to configure than EIB.
          - Integration template can't support any other endpoint, even if use case is similar.

      - Template-based Connector

          - Can be more complex to configure than EIB.
          - You can't add additional data sources to the integration, except for report fields.

      - Workday Studio

          - Studio is separate from Workday tenant.
          - Studio requires trained developer to use.
          - Development time required can be longer than for template-based integrations and Connectors.

        若想開發附加套件來賣，Workday Studio 會是更好的選擇；但若是公司專屬的應用，SOAP/REST API 才是正解 ??

    Tenant Setup

      - The Edit Tenant Setup - Integrations task enables you to:

          - Require that Studio integrations include source code. ?? Including source code can make it easier to troubleshoot a Studio integration after you've deployed it.

          - Disable integration subscription notifications for all integrations in your tenant.

    Security

      - Integrations (except EIBs) require an associated Integration System User (ISU) account. This account DOESN'T HAVE AN ASSOCIATED WORKER.

        很像是 AWS/GCP 的 service account，可以限定程式可以存取的範圍。

      - ISUs enable you to give an integration security ACCESS TO ONLY THE DOMAINS needed to run the integration. The ISU requires Get and Put access to the domains that secure the integration data sources. #ril

    Business Processes

      - Workday provides 1 business process and 1 type of business process step all integrations except EIBs:

        以子流程、step 的方式將 integration 整進某個 process ??

      - You can configure the Integration Process Event business process definition in the Integration functional area to control how an integration runs. Examples:

        透過 Integration Process Event 流程啟用 integration ??

        Inbound integration:

          - Initiate.
          - Retrieve file from external endpoint.
          - Fire (load data into Workday).

        Outbound integration:

          - Initiate.
          - Send approval request to the worker you designate.
          - After approval, fire (extract data from Workday).
          - Send data file to external endpoint.

      - The "Integration" business process step enables you to launch an integration from any business process that supports this step type. View the business process definition to see if the business process supports an Integration step.

        在 Type 選 Integration 然後呢 ?? 沒地方可以選要接哪個 integration?

        Example: You can add an integration step to the Complete Form I-9 business process. This step launches an E-Verify integration to send data for the worker.

    Reporting

      - Workday provides these reports for integrations:

      - View Integration System

        Displays all integration systems (EIB, Connector, Studio, and so on) that you've created.

      - View Integration Template

        Displays all integration templates that Workday provides, enabling you to find the template you need efficiently.

      - Integration Events

        Displays:

          - A summary of integration events that are in process or completed.
          - Details about the status for each integration event.

        不同於一般的 (business process) event，這裡的 event 是 integration 歷次執行的記錄。

    Touchpoints

      - Workday integrations interact with various parts of Workday, depending on the product area, purpose, and data sources for the integration:

          - Outbound integrations extract data from Workday, but DON'T CHANGE THE DATA in Workday.
          - Inbound integrations add and update data in Workday.

      - Workday offers a Touchpoints Kit ?? with resources to help you understand CONFIGURATION RELATIONSHIPS across your tenant. Learn more about the Workday Touchpoints Kit on Workday Community.

## EIB (Enterprise Interface Builder) {: #eib }

  - [Setup Considerations: Enterprise Interface Builder \(EIB\) • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/CTqionLqcqBBxu2fkwnrRg) #ril

  - [Concept: Enterprise Interface Builder • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/ujgXOK5Lg0sNYPHwwKcnbw)

      - Use the Enterprise Interface Builder (EIB) to build simple inbound and outbound integrations between Workday and external endpoints. EIB gives you a FRAMEWORK to build your own integrations based on your unique business needs.

    Inbound (import data)

      - Upload data into Workday by using:

          - An attachment.
          - A REST-based URL. 由 Workday 往外部 URL 拉資料，還是外面往 Workday 的 URL 打??
          - A file transfer from an external SFTP, FTP/SSL, or FTP endpoint.

        Examples:

          - Import accounting journals into Workday from an Excel spreadsheet that you provide as an attachment.

            但 Excel 也要符合一定的格式??

          - Import data into Workday from an Excel spreadsheet to perform a BULK BUSINESS PROCESS. Example: hiring a group of employees, or requesting mass compensation changes.

            不限於初期系統上線時。

          - Import transactions for expense credit cards from a card issuer. You can then process the transactions in Workday Expenses.

    Outbound (export data)

      - Export data from Workday in various formats, such as:

          - CSV
          - [Google Data (GData)](https://en.wikipedia.org/wiki/GData) #ril
          - JavaScript Object Notation (JSON)
          - Really Simple Syndication (RSS)
          - Text files
          - Workday XML

      - Then send the data to an external endpoint by using various protocols, such as:

          - [AS2](https://en.wikipedia.org/wiki/AS2) - 規範如何在 Internet 上安全地交換結構他的 B2B 資料 #ril
          - Email
          - SFTP, FTP/SSL, or FTP
          - HTTP/SSL

        Examples:

          - Export all active employees from Workday in XML format and send it to an external endpoint with SFTP.
          - Export employee hours and billing rates from Workday in CSV format and send it to an external endpoint with SFTP.
          - Export employee headcount and contribution data from Workday in CSV format and send it to a life insurance provider by email.

        Note: Outbound EIBs can’t export data in Microsoft Excel format. Export data in CSV format, then open the CSV file using Microsoft Excel.

    EIB Components

      - Workday represents the integration as an Enterprise Interface, which you build and configure before the integration is ready to launch. You can design an Enterprise Interface by using a WIZARD DESIGN method. Create simple inbound or outbound integrations in a few steps with the wizard, which guides your configuration with appropriate options based on the DATA FLOW.

      - An EIB has 3 components:

          - Get Data

            This component can indicate:

              - The data Workday receives from an external source (Example: a spreadsheet of budget data) and the location of that data (Example: a specific URL or FTP site).
              - The data that the integration extracts from Workday (Example: a specific CUSTOM REPORT)

          - Transform

            This component CONVERTS the data into a format that Workday or the receiving external endpoint can understand. Workday provides some delivered TRANSFORMATIONS, but you can also create your own transformations.

          - Delivery

            This component defines how Workday imports data from or exports data to an external endpoint. Examples: email, SFTP, and web services.

  - [Steps: Set Up Outbound EIB • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/tcLTf0IIOachasS5P8DqyA)

    Prerequisites

      - Determine the data source (web service or custom report) that best fits your needs.

    Context

      - You can create an outbound Enterprise Interface Builder (EIB) integration that exports Workday data to an external endpoint. You can configure your EIB to get data from 1 of these data sources:

          - Web service. You can select a public, outbound Workday Web Service operation.

            要 Workday 往自己的 web service 要資料，有點奇妙!

          - Custom report. You can select (or create and select) a custom report.

    Steps

     1. Create a data source for the outbound EIB.

          - (Web service) [Create Web Service Data Source](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/2lqQYiTTOVLx2j3VrNRwBw). #ril
          - (Custom advanced report) [Steps: Create Advanced Reports](https://doc.workday.com/reader/HAJOEAaClxziA9ljvuBqZA/BPZtRpG8bsb3UJb2yj_SqA). #ril
          - (Custom search report) [Steps: Create Search Reports](https://doc.workday.com/reader/HAJOEAaClxziA9ljvuBqZA/fs6Sh2oFsP3ndjVtNfsN0A).

        When creating a custom report, select the Enable As Web Service check box. 往回打 Workday 自己??

     2. (Custom report) [Create Security Proxy to Grant Report Access](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/7Z7YAaMDohGr~Kqn0pMHqQ). #ril

     3. (Web service) [Set Up Launch Parameters for Web Service Data Source](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/VFoUW7ZWdKm3MzWuXNXYvg). #ril

     4. [Set Up Outbound EIB Integration](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/ixWSpgUjrsbPIevBZ4z3WQ). #ril

     5. (Optional) Grant the integration Get and Put access to the Integration Event security domain.

        See: [Steps: Grant Integration or External Endpoint Access to Workday](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/n_FMD9ZqglJWCQiPkO6jUQ).

## Business Process

  - [Concept: Integration Business Processes • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/gImnQNUvlYvq8EumW5cUOw) #ril

## Run

  - [Schedule or Manually Launch an Integration • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/vJoFEmMHwCtWwjE9KjM3zQ) #ril

    Prerequisites

      - Your tenant must have a definition for the Integration Process Event business process including these steps:

          - Initiation.
          - Fire Integration.

        用 `bp:Integration Process Event` 可以找到 Integration Process Event (Default Definition)。

      - Security: Integration Event domain in the Integration functional area.

        預設 Integration Administrator 有這個權限。

    Context

      - You can schedule an integration to run:

          - Immediately.
          - A single time (Example: 8 PM this evening).
          - On a recurring basis (Example: daily, weekly, or monthly).

      - You can also specify any LAUNCH CRITERIA that an integration requires. You can specify these values or have Workday determine the values using a report field?? or calculated field when the integration runs.

        Example: use "As Of Entry DateTime of Last Completed Integration Event". This launch parameter ?? returns the "As Of Entry DateTime" value for the last integration event that has 1 of these statuses:

          - Completed.
          - Completed with Errors.
          - Completed with Warnings.

      - For EIBs, this report field returns the "Initiated At" or "Sent On" moment for that integration event. For Connectors, the "As Of Entry DateTime" represents the moment up to which any data used by the integration must have been previously entered into Workday.

        這裡的 connector 泛指了 Template-Based Integration/Connector，甚至是 Studio Integration，因為都是基於 template-based model。

        Note: Don't use Datetime of Last Successful Integration Event (Do Not Use) as a launch parameter. ??

    Steps

     1. Access the Launch / Schedule Integration task.

        You can't select an integration system with Critical errors. This restriction applies to integrations launched by:

          - Schedule.
          - Integration step on a business process.
          - Integration subscriptions.
          - API call.

        沒錯，task name 裡面有個 `/`。

     2. (Manual launch) Select the Organization. The prompt varies depending on the Integration Process Event and on your security access:

          - Owning Organization

            Displays if the Integration Process Event for this integration is ASSOCIATED WITH A SPECIFIC ORGANIZATION. You can select the organization or any of its subordinate organizations if:

              - You're a member of the organization.
              - You have an organizational role for that organization.

          - Organization By Type

            Displays if the Integration Process Event for this integration has no associated organization. You can select ANY ORGANIZATION and subordinate organization of which you're a member or have an organization role.

        For scheduled integrations, Workday ignores the Organization field value, basing the organization context (if any) on the Integration Process Event for the integration.

        為什麼非排程的 integration 要看 organization??

     3. Select a Run Frequency.

     4. (Optional) Workday uses the Request Name field as the Integration Name.

        Workday displays this name in the Process Monitor and Scheduled Future Processes reports to help you identify a specific process request.

     5. If the integration system has launch criteria, specify the required values on the Integration Criteria tab. Workday uses Specify Value unless you override this setting; a recurring integration uses the same value each time it runs.

        When scheduling integrations with a minute, hourly, daily, or weekly recurrence, use the Concurrent Integration Scheduling section to: ??

          - Configure a new integration event on the same schedule to launch if another integration event from the same schedule is in progress.

            Daily and weekly recurrent schedules default to this option, while minute and hourly recurrent schedules don't default to this option.

          - Prevent concurrent integration events that use the same launch parameters, except for launch parameters that are configured with Use System Prompt. Workday ignores Deleted launch parameters.

        Launch parameter 跟 launch criteria 是什麼關係??

     6. If you're scheduling the integration to run later, define the schedule on the Schedule tab.

        Example: The Start Date is 12:01 A.M. on the first possible day that a process could be scheduled, based on the recurrence criteria. The End Date is 11:59 P.M. on the last possible day that a recurrence could be scheduled and must be greater than or equal to the Start Date.

        You can't specify an End Date beyond December 31 of the next calendar year. 不能超過 1 年 ??

    Result

      - If you scheduled the integration to run at a scheduled time, you OWN the schedule. If your Workday account becomes inactive, any integrations that you scheduled DON'T LAUNCH, and Workday sends no notifications.

        不能掛在特定員工身上，否則離職就停擺了 ??

      - The integration background process performs any required transformations and returns the appropriate files or web service messages, which you can access with the Process Monitor report. If the integration ran for a specific organization, the organization displays on the business process event for the integration run.

      - When multiple integrations have the same run schedule time, Workday prioritizes the integrations based on the priority configuration in the Edit Tenant Setup - Integrations task. #ril

    Next Steps

      - To modify, suspend, or delete a scheduled integration, access the Scheduled Future Processes report, and use the related actions menu on the request name.

        沒有 Request Name 的欄位，指的應該是 Scheduled Process，因為 menu > Schedule Future Process 下有 Suspend、Delete 等不同的選項。

      - To rerun the DOCUMENT DELIVERY for an EIB, access the integration event for the EIB and select Integration Event > Re-Deliver Document as a related action.

        To rerun the document delivery of an Integration Process Event, access the integration event for the Document Delivery and select Integration Event > Re-Deliver Document as a related action.

        跟 Scheduled Future Processes 無關，應該是在講 Integration Events ?? 但又找不到 Integration Event > Re-Deliver Document 的選項...

## Sequence Generator

  - [Set Up Integration Sequence Generators • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/8CFxLvHIyDoF8p2vgqR_JA)

    Prerequisites

      - Security: Integration Configure domain in the Integration functional area.

    Context

      - Enable integrations to generate a unique, sequenced number each time they run.

      - If a process generates multiple requests for the next sequence number very close together:

          - Workday attempts to generate the sequence numbers.
          - Workday can generate SKIPPED, NONCONSECUTIVE numbers.

    Steps

     1. Select Integration System > Configure Integration Sequence Generators as a related action on your integration system.

     2. Specify Most Recent Sequence values:

          - Last Number Used

            Manually sets the last sequence number. This option is useful if:

              - You previously used a different ID generator.
              - You want to continue from where the ID ended.

            When you set the number, the initial sequence number will be your number plus the Increment by value.

          - Last Date Used

            Specify this date, plus an interval for Restart Every to determine whether the date is before or after the last restart interval. Then Workday sets the sequence number based on the date.

     3. Specify Sequence Definition values:

          - Increment by

            Specify the value to increment sequence numbers by.

          - Restart Every

            Specify how often Workday resets the sequence numbers.

          - Restart Based on Time Zone

            The standard time zone is Pacific Standard Time/Pacific Daylight Time (PST/PDT). To use a different time zone for the file generation date and time used in the Format/Syntax field, select the time zone from the prompt.

            This value doesn't affect when the event actually occurs. Use this prompt only to localize the date for display purposes.

          - Restart at Number

            Specify the number Workday uses when restarting sequence numbers. To use this field, you set the Restart Every value.

          - Padding with '0'

            To pad sequence numbers, specify the number of zeros that Workday uses to pad each sequence number.

          - Format/Syntax

            Define the filename format by entering:

              - A string constant.
              - A pattern for the date and time.
              - A sequence number pattern.
              - The file extension.

            Workday can dynamically generate only date values and a sequence number for use in the filename. Any other values are static; they're identical for all files generated by the integration. Hold your CURSOR OVER this field to see the full list of valid sequence generator and date/time patterns.

            例如 `FILE-[Seq].xml`，其中 `[Seq]` 會被代換成 sequence number，其餘都是常數。

          - Low Volume (Ignore if gapless)

            (Optional) Select to ensure that sequences generated by the sequence generator don't have gaps. Use this option when you experience both of these situations:

              - You aren't using the sequence in high-volume transactions.
              - You experience unwanted gaps in the generated sequence.

        Press TAB to view a sample value in the Example area. Verify that the sample meets your requirements.

     4. (Optional) Select 1 or more target environments for this sequence generator from the Restricted to Environment prompt.

        If you select more than 1 environment, Workday DOESN'T SYNCHRONIZE the sequence numbers across environments. ??

    Example

      - Format/Syntax: `[yyyy][MM][dd]_[Seq]_ER-GMS.csv`

        Example: the integration first runs on January 1st, 2018, and runs on the 1st and 15th day of each month. The integration events for February 2018 generate output files named `20180201_3_ER-GMS.csv` and `20180215_4_ER-GMS.csv`.

## 參考資料 {: #reference }

  - [Integrations - Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/root)
  - [Integration Cloud Platform](https://community.workday.com/icp)

更多：

  - [Payroll Interface](workday-intsys-pi.md)
  - [Import External Payslip](workday-intsys-external-payslips.md)

手冊：

Workday Objects:

  - All Integration Systems
  - Edit Tenant Setup - Integrations (Task)
  - Integration Process Event (Business process)
  - View Integration System (Report) - 列出特定 integration 的設定
  - View Integration Template (Report)
  - Integration Events (Report)
  - Launch / Schedule Integration (Task)
  - Process Monitor - 列出最近已執行的背景工作，包括 integration、report 等不同的 process type
  - Scheduled Future Processes - 列出接下來會執行的背景工作
  - Create Integration System
  - Create Integration System User
  - Integration System User Security Configuration -- 列出所有的 ISU 及其所屬的 (integration) security group
  - Move Integration Users to Integration System Security Group (Unconstrained)

相關：

  - [Workday Studio](workday-studio.md)
