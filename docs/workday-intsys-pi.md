---
:title: Workday / Payroll Interface (PI)
---
# [Workday](workday) / Payroll Interface (PI)

  - [Concept: Workday Payroll Interfaces • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/SsX9X8kZbGAzIE_fPx1QCg)

      - Workday Payroll Interfaces (Payroll Effective Change Interface and Payroll Interface), enable you to manage payroll data and send it to an EXTERNAL PAYROLL PROVIDER. You can:

          - Set up a payroll organization. ??
          - Define earnings and deductions. ??
          - CAPTURE CHANGES to employee data.
          - Configure a PAYROLL EXTRACT to deliver to an external system.

        其中 "Payroll Effective Change Interface" 跟 "Payroll Interface" 在新建 integration system 時，是不同的 template。

      - There are different ways to integrate with Workday Payroll Interfaces. You can:

          - Create an integration with the an INTEGRATION TEMPLATE.
          - Have Workday Professional Services create a custom solution.
          - Build your own custom integration.

      - Payroll Interfaces are integration templates with a configurable set of HCM data. Because payroll providers only need a SUBSET of the employee data in Workday, you can specify:

          - DATA ELEMENTS to include in payroll extracts.
          - When to include the data elements.

      - When launched, the integration captures changes to employee data for the PAY GROUP and PAY PERIOD. The integration creates an output file in XML or CSV format. You can:

          - Deliver the output file to an external system.
          - Perform additional transformations to the output file.
          - Use Workday audit reports to identify changes for manual data entry into an external system. ??

      - You can create FULL extracts of employee data with integrations that use the Payroll Interface templates. This option:

          - Helps during initial implementation.
          - Supports payroll providers that require full files.
          - Enables system resynchronization.

        Full extracts include all data for ACTIVE employees and data for TERMINATED employees that have changes.

        根據 "all ... that haved changes" 的說法，所謂 full 指的不是所有人，而是所有的 data element，但一定受限於 pay group 與 pay period ??

  - [Concept: Payroll Interface Workflow • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/vNHy1KfTzI25xDlepaIgbA)

      - The Workday Payroll Interface extract process requests:

          - Who to include.
          - What changes to examine.
          - When to examine the changes. 這跟上一點有何不同??

      - When you launch a Payroll Interface integration, you specify:

          - Pay group.
          - Pay period.

      - If your payroll interface is PRIMARY, then pay group and pay period are the only launch options. If you launch a non-Primary Payroll Interface integration, then you also specify:

          - Date and time of the last successful run.
          - Change detection method.
          - (Optional) Specific staffing transactions.
          - (Optional) Pay group members.

        Workday:

          - Selects the appropriate employees.
          - Looks for field changes to employee data.
          - Generates a payroll extract for the changes.

      - The Workday TRANSACTION LOG tracks event changes to employee data. The integration identifies employee changes to send to your payroll provider. The transaction log service is optional. If you configure this service, Workday includes employees based on their transaction log entries in the specified time period. Otherwise, all employees pass to the next process stage.

      - Workday uses these rules to create a payroll extract:

          - Find employees who are members of the pay group at the start or end of the pay period. The payroll extract includes employees who TRANSFERRED IN OR OUT of the pay group during the pay period.

            概念上是 "時間 (pay period) x 空間 (pay group)"。

          - If the transaction log service is configured:

              - Select employees who have transaction log events that are effective in the prior and current pay periods.
              - Exclude events with effective dates in future pay periods.

          - Compare data for the selected employees at the beginning and end of the pay period.
          - Identify field data changes.

          - Determine if the changed data is included in the integration output. Examples:

              - Personal data.
              - Position and status data.
              - Earnings and deductions.

          - Include employees who have data changes.
          - Exclude employees who have no data changes or changes that do not affect data.
          - Send earnings and deductions when they start, when the amounts change, and when they end.

          - Provide data for STAFFING EVENTS based on the event type:

              - New hires = all data.
              - Transfers into pay companies or pay groups = all data.
              - Terminations = changed data.
              - Leave of absence and return from leave = changed data.
              - Transfers out of pay companies or pay groups = all data as of one day before the transfer.

## 新手上路 {: #getting-started }

  - [Steps: Set Up Workday Payroll Interface • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/_BnBTE1wmGvVAWvbfzyrOQ)

    Prerequisites

      - We recommend that you use Workday Professional Services or a Workday Consulting partner when implementing Payroll Interface. If you implement Payroll Interface without assistance, ensure that a member of your team attends a Workday Integration training class. Ensure that you read the Payroll Interface documentation.

    Steps

     1. Set up a payroll organization.

        See Steps: Establish Third-Party Payroll Organization. #ril

     2. Create and assign pay groups for third-party payroll.

        See Steps: Create and Assign Third-Party Payroll Pay Groups. #ril

     3. Define external payroll earnings and deductions.

        See Steps: Define Third-Party Payroll Earnings and Deductions. #ril

     4. Create a third-party payroll integration.

        See Steps: Create Third-Party Payroll Integration. #ril

  - [Steps: Create Third\-Party Payroll Integration • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/JOmNqGTwFpdF_yJ_HBuE1A)

    Context

      - Create an integration system that sends employee data to an external payroll provider. These steps apply to Workday Payroll Interface and Workday Payroll Effective Change Interface.

    Steps

     1. Steps: Set Up Payroll Integration System.
     2. Select Fields for Payroll Extract. #ril
     3. Configure Payroll Interface Attributes and Maps. #ril

     4. Set Up Integration Delivery. #ril

        Before you configure integration delivery options, enable the PI Delivery Service integration service. ??

     5. (Optional) Set Up Integration Sequence Generators. #ril

        To create output files with unique filenames, configure the sequence generator. Enable the integration services for the file types you want to generate filenames:

          - Integration output file: PI Filename
          - Data Changes Audit: PI Data Changes Audit Filename
          - Diagnostic Audit: PI Diagnostic Audit Filename

     6. (Optional) Add Custom Fields to Payroll Integration. #ril

     7. (Optional) Set up a document transformation to modify the output file before you send it to an external provider.

        See Steps: Set Up Document Transformation Connector. #ril

     8. Access the Maintain Functional Areas task.

        Select the Enabled check box for the USA Payroll functional area for your tenant. Do this step to view payroll extract files.

        Security: Security Configuration domain in the System functional area.

        跟 USA 什麼關係??

     9. Launch or Schedule Payroll Integration. #ril

        Generate a payroll extract for external processing.

  - [Steps: Set Up Payroll Integration System • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/UEn2wecSJy3usLsbNncLbw) #ril

    Context

      - Create an integration system that extracts and sends data to an external payroll provider.

    Steps

     1. Access the Create Integration System task.
     2. Give the integration a meaningful System Name. Record this name; you use it when you launch the integration.
     3. Click the New using Template prompt, then select Cloud Connect for Third Party Payroll > Payroll Interface.

     4. In the Integration Services grid, select the Enabled check box for each integration service that you want to activate. The integration services provide categories of data or configuration options for the output file.

        一開始可以先勾 Enable All Services。

        Note: The integration services Payroll Interface and PI Launch Parameters are required and enabled by default, and not listed here. The Transaction Log Service isn't enabled by default, but is required for change detection processing.

          - PI Members Launch Parameters

            Provides additional launch parameters to the Launch/Schedule Integration task that enables you to select individual Pay Group members for inclusion in Payroll Interface. You typically enable this service only for an integration that processes AD HOC payroll runs.

            測試期間很實用!!

          - PI Change Detection Launch Parameters

            Provides additional launch parameters to the Launch/Schedule Integration task for ad hoc payroll integration events. You typically enable this service only for an integration that processes ad hoc payroll runs.

          - PI Full Extract With No Diff Launch Parameter

            Provides additional launch parameters to the Launch/Schedule Integration task. The parameters enable you to extract payees as of the Current Date Entry Time and Pay Period End Date, regardless of whether they’ve changed. Enable this parameter to generate output that INITIALLY populates the external system. These output files don't include earnings and deductions.

          - PI Personal Data Section Fields

            Provides employee personal data and contact information.

        接下來一堆 PI xxx Data Section Fields 都在控制要不要輸出哪一方面的資訊；一開始建議簡單一點，免得踩到權限不足的問題。

          - Time Tracking Data

            Provides time tracking data.

          - Time Tracking Correction Data

            Provides time tracking correction data.

          - Transaction Log Service

            Provides a record of event-based changes to employee data that are relevant to payroll integrations. Don't enable this service in integrations that generate full extracts.

          - PI Delivery Service

            Provides file transport and encryption options for the output file.

            但 file 不能留存在 Workday 裡，一定要往外送嗎?? 開發時很不方便!!

          - PI Filename

            Provides unique filenames for integration output documents by using the Workday sequence generator.

          - PI Data Changes Audit Filename

            Enables your integration system to generate a unique, sequenced filename for the Data Changes Audit each time it runs. If selected, you must configure the integration sequence generator for your integration system.

          - PI Diagnostic Audit Filename

            Enables your integration system to generate a unique, sequenced filename for the Diagnostic Audit each time it runs. If selected, you must configure the integration sequence generator for your integration system.

     5. Grant the integration Get and Put access to these domains:

          - Payroll Interface
          - Worker Data: Benefit Elections
          - Person Data: Birth Place
          - Person Data: Citizenship Status
          - Worker Data: Compensation
          - Person Data: Disabilities
          - Person Data: Ethnicity
          - Person Data: Gender
          - Person Data: Marital Status
          - Person Data: Military Status
          - Person Data: Religion
          - Worker Data: Nationalities
          - Worker Data: Skills and Experience
          - Worker Data: Worker ID Information
          - Manage: Organization Update Integration
          - Manage: Organization Integration

        See: Steps: Grant Integration or External Endpoint Access to Workday

     6. Configure the integration service for the transaction log:

          - As a related action on the integration system, select Integration System > Configure Integration Transaction Log.

          - Click Subscribe to all Transaction Types except and select the transactions to exclude from payroll interface processing. Typically, payroll providers only need information about staffing events and employee changes that have a payroll effect. These changes include changes to earnings and deductions, payment elections, and certain types of personal data. ??

  - [Steps: Grant Integration or External Endpoint Access to Workday • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/n_FMD9ZqglJWCQiPkO6jUQ) #ril

## 參考資料 {: #reference }

手冊：

  - [Payroll Interface Connector Versions](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/fosLKrrWCXVddGwQQ6IuGQ)
  - [Data Sections for Payroll Interface](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/zs3znJ~PM5MVfvFoyE258g)
  - [Staffing Events in Payroll Interface Extracts](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/V4Nqc~OB_kYMcXCfeLRFcg)
