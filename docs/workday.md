# Workday

  - [Manage Workday - Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/root) #ril

## NSC (Named Support Contact)

  - [NSC (Named Support Contact) - Workday Roles and Responsibilities \| Workday Community](https://community.workday.com/articles/460028)

      - How Many? There is a finite number BASED ON NUMBER OF EMPLOYEES and your subscription with Workday
      - Submit new cases ON THE CUSTOMER'S BEHALF using the Workday Customer Center
      - View and update existing cases using the Workday Customer Center
      - Review Customer Alerts ?? and communicate internally as needed
      - [ESCALATE Brainstorm Ideas](https://community.workday.com/ideas/escalations/home) in the Community #ril
      - Please refer to [Named Support Contact Responsibilities](https://community.workday.com/articles/44584) page for more information

    主要是代為發問 (先做過功課) 並跟緊後續的討論。

  - [Named Support Contact Responsibilities \| Workday Community](https://community.workday.com/articles/44584)

    What is a Named Support Contact?

      - Workday provides a finite number of Named Support Contacts (NSC) per customer based on the number of employees and Workday products implemented.

        It is the responsibility of the customer to assign ONE NSC during the deployment phase and the remaining NSCs prior to their go live date. The NSCs will attend a Transition to Production Services meeting, where they will be trained on NSC Responsibilities and how to log cases. Named Support Contacts are the only people designated by the customer who can submit cases on a customer’s behalf.

      - Only Named Support Contacts have access to do the following tasks:

          - Submit new cases on the customer's behalf using the Workday Customer Center
          - View and update existing cases using the Workday Customer Center
          - Manage Named Support Contacts, Named Read Only Contacts, and Training Coordinator access in the Workday Customer Center
          - Escalate Brainstorm Ideas in the Community

    Requirements

      - NSCs are required to have met the following requirements:

          - Identified BY NAME within the Workday Customer Center
          - Completed the [required NSC training](https://community.workday.com/node/45391) before cases are created
          - Secured Workday Customer Center and Workday Community login credentials
          - Verified and updated the Customer Center Profile for accuracy
          - Reviewed the Transition to Production Community page
          - Reviewed the “Workday Case Product and Sub-Product” documentation on the Workday Customer Center ??
          - Subscribed to Workday Community alerts ??
          - COMMUNICATE EFFECTIVELY IN ENGLISH

    Expectations

      - Workday requires customers to channel all collaboration with Workday Support through their Named Support Contact during issue resolution. Therefore, a Named Support Contact…

          - Will RESEARCH AND TRIAGE issues before a Support case is created
          - Will create cases in the Workday Customer Center
          - Will be available BY PHONE and by case for Severity 1 and Severity 2 cases, even during off hours
          - Will maintain current contact information (phone, email and time zone) in the Workday Customer Center
          - Will stay trained in the functional and technical areas they support
          - Will not delegate case responsibility to non-Named Support Contacts
          - Will facilitate collaboration and participate in discussions with non-Named Support Contacts, when needed
          - Will not share Workday Customer Center or Workday Community login credentials
          - Will manage their Support and Training Contacts ?? within the Workday Customer Center

    Adding or Removing NSCs

      - It is the customer’s responsibility to terminate access to the Workday Customer Center and Workday Community. For more details on how to manage access, please go to Contacts Management - NSC Self Service.
      - If Workday sees a lack of adherence to the policies above, Workday Support management will escalate to the customer’s management. Under extreme circumstances of abuse, Workday may disable the Named Support Contact’s access to the Customer Center.

  - [Training for an NSC \| Workday Community](https://community.workday.com/node/45391) #ril

  - [Contacts Management \- NSC Self Service \| Workday Community](https://community.workday.com/articles/415712) #ril

## Tenant

  - [Tenant Management \| Workday Community](https://community.workday.com/articles/24324) #ril

      - A tenant is a unique INSTANCE of the Workday Service with a separate set of data held by Workday in a LOGICALLY SEPARATED DATABASE (i.e., a database segregated through password-controlled access).

        Our tenants follow a weekly Service Update schedule that you can find on the Events Calendar. Additionally, each tenant has a UNIQUE URL and is subject to specific IP Addresses and DNS names.

        注意不是 unique HOSTNAME，所以跟 DNS 其實沒什麼關係。

    Tenant Types

      - Workday maintains six types of tenants:

        Production

          - The Production tenant contains data where the integrity and validity of the data is critical. We consider the data housed in the Production tenant as your SYSTEM OF RECORD.

          - Workday Administrators are responsible for ending active sessions and locking users prior to a DATA LOAD in the Production Tenant. They are also responsible for unlocking users after the data load. For more information, please review the [Production Data Loads](https://community.workday.com/node/35603) page. #ril

        Sandbox

          - The Sandbox tenant is a COPY of the Production tenant which Workday provides as a SECOND TENANT. The creation of your Sandbox tenant COINCIDES with the timing of your initial Workday Service go-live date.

          - We recommend that you use your Sandbox for a variety of purposes including testing configuration changes and training. Sandboxes are isolated from Production, therefore changes you make in Sandbox do not affect Production, and vice versa.

            Sandboxes are only refreshed with a copy of Production taken on Friday at 6:00 pm PT during our Weekly Service Updates.  However, you can request up to two consecutive Refresh Exemption Tenant Request if you do not want your changes in Sandbox overwritten by Production. It is important that you understand the refresh schedule and plan accordingly, especially if you are testing configuration changes.

          - You can not request to have your Sandbox refreshed on an ad hoc basis outside of the Weekly Service Update. If you need a tenant to be refreshed from Production during the week, please use an existing Implementation tenant or you can request to purchase a new Implementation tenant.

            看起來 Implementation tenant 的彈性更大，呼應下面 "greatest amount of flexibility" 的說法。

        Sandbox Preview

          - The Sandbox Preview tenant is a copy of the Production tenant, but it additionally contains new functionality that may be available in a future Feature Release.

            Generally, the preview features will be targeted for the next Feature Release, but that is not guaranteed. Preview features could be targeted for an unspecified future Feature Release. In addition, Preview features could undergo changes based on feedback or new desired behavior, or could be retracted as a Preview feature and never released.

          - The creation of your Sandbox Preview tenant COINCIDES with the timing of your initial Workday Service go-live date and it stays in existence forever.

            也就是說，新客戶一定會有 3 個 tenant -- Production、Sandbox 及 Sandbox Preview；或許是 Sandbox Preview 這說法會讓人搞不清是 Sandbox 還是 Preview，所以有人會簡稱 Preview，不過另外還有個 Implementation Preview，所以 Sandbox Preview 的說法還是比較精確的。

            在 Customer Center > Tenant Management 可以看到 tenant 列表，就會標示不同的 tenant type；這裡只會有 Sandbox Preview 這種完整的說法。

          - The main purpose of the Sandbox Preview tenant is to test new functionality as it become available in between Feature Releases. It is not recommended that you use the Sandbox Preview tenant for DEPLOYMENT WORK for these reasons:

              - Objects, such as reports and business processes, cannot be moved from a Preview tenant to a Non-Preview tenant using Solutions
              - The Sandbox Preview tenant contains new features, fields, and functionality that are not available in Non-Preview tenants
              - It is not guaranteed when the features in the Sandbox Preview tenant will be made available in Production

            為什麼說 Preview 不適合拿來測試? 因為無法像 Sandbox 將測試的東西 migrate 到 Production。

            For more details on preview tenants, please see the 'Preview Tenant Questions' section of the Update Process: Workday 22 and beyond FAQ.

          - The Sandbox Preview tenant is only refreshed from production when a Named Support Contact enters a Refresh Tenant Request during one of the Tenant Maintenance windows.

            Twice a year at the beginning of the Release Preparation Window, the Sandbox Preview tenant is AUTO-REFRESHED from a copy of Production taken on that Friday at 6:00 pm PT. Sandbox Preview Exemptions are not permitted.

        Implementation

          - The Implementation tenant provides you with the greatest amount of flexibility as related to tenant refreshes. We recommend an Implementation tenant if you are configuring new features and anticipate needing MORE THAN 3 WEEKS to complete the project.

            因為 Sandbox Refresh Exemption 最多只能連續申請 2 週，也就是停止刷新 3 週。

          - Although all of our Implementation tenants are subject to weekly Service Updates, the tenants are not refreshed with a copy of Production unless you specifically request to do so. There are no mandatory refreshes. For more information on how to purchase an Implementation tenant, please refer to Workday's [Deployment Tenant Policy and Pricing](http://community.workday.com/node/15409). #ril

          - NEW CUSTOMERS are temporarily provided with either a Global Modern Services (GMS), Green Oak Valley (GOV) or Alma Mater University (AMU) tenant that is pre-configured with demonstration data. The GMS, GOV or AMU tenant gives you an opportunity to see configured features and custom reports using FICTITIOUS ORGANIZATIONS AND WORKERS.

            It can be used as a great LEARNING TOOL for Named Support Contacts. No customer or testing data should be loaded into the GMS, GOV and AMU tenants. For more information on how to purchase a GMS/GOV/AMU tenant, please refer to Workday's Deployment Tenant Policy and Pricing.

            雖然說 Sandbox 也可以拿來練習，但 Sandbox 有真實資料，若不想限縮操作範圍，這些特殊的 tenant 好像很實用。

          - Please review the Implementation Tenant Maintenance Windows for information on when you can request to create, refresh or delete Implementation tenants.

        Implementation Preview

          - The Implementation Preview tenant contains new functionality that may be available in a future Feature Release.

            Generally, the preview features will be targeted for the next Feature Release, but that is not guaranteed. Preview features could be targeted for an unspecified future Feature Release.  In addition, Preview features could undergo changes based on feedback or new desired behavior, or could be retracted as a Preview feature and never released.

            第 2 段話跟上面 Sandbox Preview 是完全一樣的；第一段話的差別在於 Sandbox Preview 強調了 "copy of the Production tenant"。

          - We recommend an Implementation Preview tenant if you are testing future features and you do not have a Sandbox Preview tenant. The Implementation Preview tenants are subject to weekly Service Updates, but the tenants are not refreshed unless you specifically request to do so.

            什麼情況下會沒有 Sandbox Preview tenant ??

          - The creation of your Implementation Preview tenant must be requested using the Workday Customer Center or the Workday Partner Center. You must refresh the data in the Implementation tenant to TRANSFORM it into an Implementation Preview tenant.

              - Engagement Managers and Project Managers can request to transform an Implementation tenant into an Implementation Preview tenant by entering either a Create New or Refresh tenant request for the initial deployment or any subsequent deployments.
              - The Named Support Contact can request to do this transformation by entering a Refresh tenant request or a Purchase/Renew tenant request for a new Empty Tenant.

          - Please read the Community documentation to get further instructions on how to request for an Implementation Preview tenant using the Create New, Refresh and Purchase/Renew tenant requests.

            Please review the Implementation Tenant Maintenance Windows for information on when you can request to create, refresh or delete Implementation Preview tenants.

        Implementation Customer Central

          - Customer Central is a new type of Workday tenant that increases implementation security and efficiency through Single Sign-On and Configuration Catalog features. Named Support Contacts can request for a Customer Central tenant using the Implementation tenant request. ??

    Tenant Comparisons

      - Features 提到在 Repease Preparation Window 期間，除 Sandbox Preview 與 Implementation Preview 會變成新版外 (Future Feature Release)，其餘都會維持舊版 (Current Feature Release)。
      - Data 可能很明顯區分出 Sandbox 與 Implementation 的差別 -- Sandbox 一定是 customer data，但 Implementation 除了 customer data 外，也可以是 GMS/GOV/AMU data (假資料)。
      - Refresh Schedule 除了 Sandbox 會有每週的 Service Update 自動刷新之外，其餘的刷新都要手動申請；Production 跟 Implementation Customer Central 沒有刷新的概念。

    Tenant Versions

      - All of your tenants will be ON THE SAME VERSION of Workday.

        The Sandbox Preview tenant and Implementation Preview tenant banners will display the SAME VERSION as your Production, Sandbox, and Implementation tenants, even if they contain functionality that may be included in the next Feature Release.

        2020-01-16 登入 Sandbox Preview，發現左上角出現 "Sandbox Preview Preview -- xxx_preview"，第 2 的 "Preview" 是否意謂著將進入 Workday 2020R1 Preview Window (2020-02-01 ~ 2020-03-07) ??

      - You can identify the Preview tenants in two ways:

          - The top banner within the Preview tenant will contain text that will either read ‘Implementation Preview’ or ‘Sandbox Preview’.

          - The tenants displayed in the Workday Tenants tab within the Workday Customer Center will display with a Tenant Type of ‘Implementation Preview or ‘Sandbox Preview’.

            Engagement Managers and Project Managers would access the Workday Partner Center and navigate to the Accounts tab, select an account, and press the View Tenants button to see the customer’s tenants.

## Sandbox

  - Sandbox 的資料會定期跟 production 同步，除非暫時關閉這項功能 (Sandbox Refresh Exemption)，否則在 sandbox 所做的變更都會被覆蓋。

    登入頁面就會提示：

    > Your Sandbox will be unavailable for a maximum of 12 hours during the next Weekly Service Update; starting on Friday, October 4, 2019 at 6:00 p.m. PDT (GMT -7) until Saturday, October 5, 2019 at 6:00 a.m. PDT (GMT -7). Sandbox Refresh Exemptions must be requested by 10:00 a.m. PDT (GMT -7) on the day of the scheduled Weekly Service Update. Sandbox tenants which were exempt from refresh will be available by the end of the Service Update on Saturday. Sandbox tenants are refreshed from a copy of Production taken at 6:00 p.m. PDT (GMT -7) on Friday.

  - [Weekly Service Updates \| Workday Community](https://community.workday.com/articles/68235)

      - The Workday Service Update occurs EVERY WEEK. The details of each Service Update, such as the start time, end time and any special instructions, can be found in the [All Scheduled Maintenance calendar](https://community.workday.com/maintenance/all) by the type of tenant: Production, Sandbox, Sandbox Preview and Deployment (IMPL).

        可以進 Profile > Settings > Locale 修改時區。左側選 event type (Implementation, Production, Sandbox) 及 event date (年月)，什麼是 Implementation ?? 為什麼 event type 沒有 Preview Sandbox 可選 ??

        There are times when your tenant may become available before the scheduled end time. If you would like to receive notifications when your Production tenant is available after a Weekly Service Update or Workday Feature Release ??, please see [Notification When Tenant Becomes Available](http://community.workday.com/node/101981). #ril

      - When your tenant is unavailable during the planned Weekly Service Update and Workday Feature Release, users will be redirected to the below maintenance page describing the type of down time and the scheduled time frame.

      - Workday applies patches to ALL of your tenants during the weekly Service Update. We may also do monthly, quarterly or yearly maintenance during the weekly Service Update, as indicated in the calendar.

        所以時間有長有短。

      - The Named Support Contacts SHOULD READ the [Service Update Notes](https://community.workday.com/service-update-notes) every week to assess impact of fixes to your organization.

        Review [How Workday Delivers Features](https://community.workday.com/node/104024) to understand what is included in the Weekly Service Updates. #ril

      - We have compiled relevant Community posts to help you understand and receive important information regarding Weekly Service Updates. 沒有說在哪裡 ??

  - [Refresh Exemption Tenant Request \| Workday Community](https://community.workday.com/articles/889) #ril

      - You can request to postpone the refresh of the Sandbox tenant, which occurs EVERY WEEK during the Service Update, or postpone the refresh of the Sandbox Preview tenant, which only occurs at the beginning of each Release Preparation Window, TWICE A YEAR. Please see the instructions below for each type of exemption request.

    Postponing the Refresh of Sandbox

      - The Sandbox tenant is refreshed weekly with a COPY of Production taken on Friday at 6:00 pm PT. There are situations when you may want to postpone your Sandbox tenant refresh. For example, if you are still in the process of testing new configuration changes or new reports, you may want to keep the Sandbox for ANOTHER WEEK until your testing is complete.

      - Please be aware of the following Sandbox Refresh Exemption rules:

          - Your exempted Sandbox tenant will still be unavailable during the Weekly Service Update for patches. Requesting a Sandbox Refresh Exemption simply means that the DATA and CONFIGURATIONS will not be refreshed from Production on that week.

            程式還是會動，只保留 data 與 config。

          - We only allow for up to TWO CONSECUTIVE EXEMPTIONS. We will require that your Sandbox Tenant be refreshed on the third week. The purpose of a customer's Sandbox tenant is to allow the customer and Workday Support to REPRODUCE ISSUES. If the Sandbox tenant is not a recent copy of production, it hinders the customer and Support in effectively troubleshooting urgent, PRODUCTION ISSUES.

            所以測試最長可以維持 3 週；出現連續 2 個 exemption 時，通知信會提醒：

            > This is your second consecutive refresh exemption. Due to our refresh exemption policy, you will not be eligible for a refresh exemption the following Friday, 10-18-2019. Please plan any testing in your Sandbox accordingly.

          - PURCHASE a new Implementation tenant or use an existing Implementation tenant If you require a testing environment for more than two weeks,

          - Make sure you coordinate and communicate your decision to postpone your Sandbox refresh with other project team members that have access to your Sandbox.

          - This tenant request does not apply to your Sandbox Preview tenant. The Sandbox Preview tenant is only refreshed from production when a Named Support Contact enters a Refresh Tenant request. If you want to exempt the automatic refresh of the Sandbox Preview tenant at the start of the Release Preparation Window, please enter a 'Sandbox Preview - Refresh Exemption' request.

            Sandbox Preview 是有明確要求時才會 refresh，跟 Sandbox 預設每週一次，要明確要求才會暫停 refresh，兩邊的概念剛好相反。

          - We do not accept ad hoc Sandbox tenant refresh requests outside of our Weekly Service Update.

            If you require for two consecutive exemptions, you must submit a separate tenant request for each week. We do not have the ability to create a recurring event.

            也就是每次申請的期間以一週為限 (不能跨及 weekly service update)，連續申請最多也只能兩週。

          - You may not request a Sandbox refresh exemption prior to the Feature Release.

    Tenant Request Fields

      - To create a Tenant Management > Refresh Exemption request, please fill in the fields as described below.  Please reference the Tenant Management Request page for instructions on how to access the Tenant Management Home page to enter requests.  This request is only available to Named Support Contacts (NSC) in the Workday Customer Center.  Engagement Managers and Project Managers do not have this option available and must there be entered by the NSC.

      - Tenant (Required)

        Only the Sandbox and Sandbox Preview tenant displays for selection.

        Should only select the Sandbox Preview tenant when you are within 30 days of the next Feature Release.

      - Exemption Date (Required)

        Date when the Sandbox refresh exemption is requested.

          - For a Sandbox tenant, the Exemption Date MUST BE A FRIDAY. Exemptions are not allowed the Friday of the Feature Release. Only two consecutive exemptions are allowed.

            因為資料是 production 星期五的快照，所以就要安排在星期五? 但 Sandbox - Weekly Service Update 好像都安排在星期六，這有點違反直覺。可以想成星期五就不建立快照，自然就沒有快照去覆寫 Sandbox 的內容。

          - For a Sandbox Preview tenant, the Exemption Date must be the Friday of the start of the Release Preparation Window, which occurs only twice a year.
          - Request must be logged by 10:00 AM PT on the day of the scheduled maintenance.

      - Additional Notifications (Optiona)

        You can select other Named Support Contacts or consultants on your Account Team to receive the email notifications for the Refresh Exemption request. The person who entered the request and any selected names in this field will receive an email notification when the task is submitted, completed by Workday's Operations team, or canceled.

        這裡 Account Team 就是顧問 ??

        Use the Ctrl key to select multiple people when needed.

      - Reason for Exemption (Optional)

        Provide the reason for the exemption for informational purposes only. Please do not add any special instructions in this field, since they will NOT BE SEEN by Workday's Operations team.

        不過下面 Previous Exemptions 會顯示 reason，對於識別其他 exemption 是為了什麼提出很重要。

      - Previous Exemptions (View Only)

        This section of the page will display all submitted and completed Refresh Exemptions requested for TWO WEEKS AGO or scheduled for future dates. Please use the information in this section to ensure you do not request for a third consecutive exemption request.

## Customer Center

  - 帳號建立後會收到通知信：

    You have been granted access to the Workday Customer Center as a Named Support Contact (NSC). Workday Support works specifically with NSCs for coordination of issues reported by your organization. As a Named Support Contact you have the ability to submit Support Cases on behalf of your organization and coordinate tenant management activities through the Workday Customer Center. In addition, you will have access to reports, dashboards, and content.

    ...

    Once you log into the Workday Customer Center, we recommend you take the following steps:

      - Bookmark URL to the Workday Customer Center https://workdayinc.force.com/workdaycustomercenter
      - Select Products in your user profile for Product Support Cases
      - Review your Profile Contact Information to ensure it is accurate
      - Add your photo to our user profile
      - Select My Company Specific Information to tie Support Cases to your internal ticketing system if applicable

    The following references will introduce you to the role of an NSC and the Workday Customer Center:

      - Review the [Named Support Contact Responsibilities](https://community.workday.com/articles/44584) reference article in the Community to become familiar with the role of Named Support Contact #ril
      - Read the [Using the Workday Customer Center](https://community.workday.com/node/44586) reference article in the Community to learn more about the Customer Center #ril
      - Watch the the Workday Customer Center Learn On-Demand videos in the Workday Learning Center by searching for "Named Support Contact" and selecting the associated curriculum
      - Visit the [Named Support Contact user group](https://community.workday.com/groups-private-collaboration-group/552) in the Community to ask questions related to this role and to collaborate with other NSCs. #ril

## Search

  - [Concept: Workday Search • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/s0ZzhJR11p4O9caf4x2zUw)

      - Workday provides a powerful search engine that enables you to search for UNIQUE data, such as identifiers, transactions, and workers.

      - Workday Search delivers EXACT search result matches (such as specific invoices or expense reports).

        Workday Search initially finds the 7 best matched results after you type 3 characters, including up to 2 people and up to 2 organizations.

        至少要打 3 個字元才會觸發提示 best matched results，至少包含 2 people/organization 的設計是方便找人跟組織；很聰明的設計。

      - Search processes each term (or character string) separately. If you enter 2 terms SEPARATED BY A SPACE, Workday searches for ANY OBJECT or action with BOTH character strings in it, regardless of whether the strings are next to each other.

        Use longer search terms to improve the accuracy and reduce the time to return results. Example: If you’re searching for the Maintain Project Roles task, the search string `maintain project` finds more relevant results than the search string `main pro` work.

        To search for an ID, remove all special characters, such as dashes or spaces.

        感覺背後是用 Elasticsearch?

    Search Categories

      - Workday provides SEARCH CATEGORIES, which you can use to limit your search to produce faster and more accurate results. Workday automatically enables the "Common" Search Category, which includes only active workers and applicants, organizations, reports, and tasks.

        Use other categories to more efficiently search for specific types of data. Example:

          - To find Positions, Jobs, Applicants, Terminated Employees --> Use Staffing
          - To find Suppliers, Catalog Items --> Use Procurement

      - To change the default Search Category for your tenant, access the Edit Tenant Setup – Search task. To maximize performance, Workday recommends that you set the default to a specific category.

        要進到 Customer Center 設定 ??

      - To change your individual preferred search category, access the Change Preferences task and select a Preferred Search Category.

        試著換成 Procurement (要重新登入)，但好像沒什麼差別? 感覺 people/organization 一定會有?

    Search Catalogs

      - To improve search performance, Workday maintains these SEARCH CATALOGS:

          - The primary catalog indexes most BUSINESS OBJECTS in Workday.
          - The secondary catalog indexes certain HIGH VOLUME business objects, such as: Journal Entry, Project Scenario, Purchase Order, Supplier Invoice

        Workday searches the primary catalog first and searches the secondary catalog only if the primary catalog doesn’t find a match.

        例如搜尋 purchase order 的單號，若是夠長的話，在 primary catalog 找不到，才會到 secondary catalog 裡找。

      - Use primary objects, such as Worker, as the subject of your search. Secondary objects, such as expense reports, organizations, and Workday accounts, are related to the primary object. By correctly identifying the primary object of your search, you improve the accuracy of the search for relevant secondary objects. Example: When you search for Logan McNeil, your search results include Logan's expense payments, supervisory organization, and cost center.

        這裡 "correctly identifying the primary object" 指的是什麼? 聽起來將什麼認定為 primary/secondary object 是可以調整的 ??

      - To decrease the chance of finding unwanted matches in the primary search catalog, use a precise search string in the secondary catalog when searching for high volume business objects. Example: A document identifier with the relevant SEARCH PREFIX.

    Search Prefixes and Facets

      - Search prefixes restrict the search results to a particular TYPE of Workday object. Search prefixes are LOWERCASE letters, followed by a colon (`:`). Example: `bp:` finds all business process definitions.

        Example: A primary catalog position number is identical to a secondary catalog purchase order number. You search for the purchase order using its number without a search prefix. Workday finds the position in the primary catalog and doesn’t search the secondary catalog.

        呼應上面 primary catalog 有結果就不會找 secondary catalog 的特性；但什麼是 position number ??

      - To see a list of all search prefixes, enter a question mark (`?`) in the search box.

        原來有這招!! 當然要按 Enter 才行，因為至少要 3 個字元才會提示少量的 result。

      - In addition to the GLOBAL search box, you can use the faceted search boxes on Find reports to further filter the results. Example: Use the Find Workers report to search for employees and other workers living near a specific city.

        在 global search box 輸入 Find Workers 會看到 report，底下會有另一個 (faceted) search box。

    Advanced Search

      - Workday automatically performs searches using an AND operation in both the global search box and the faceted search boxes in Find reports, such as Find Workers and Find Candidates.

      - You can also use the faceted search boxes on Find reports to customize your search by specifying any combination of these operators:

          - `AND` or `&` or `&&` finds objects with both terms. Example: `Jones AND California` or `Jones California`.
          - `OR` or `|` or `||` finds objects with at least one of the terms. Example: `Liu OR McNeil`.
          - `NOT` or `-` excludes the term from the results.

              - When you use `NOT`, you must enclose the term within parentheses. Example: `NOT(London)`.
              - When you use the hyphen (`-`), the term must immediately follow without any space between the hyphen and the term. Example: `-London`. Your search must also contain at least one positively specified keyword. Example: `-London` isn’t valid by itself, but `UK & -London` is.

        組合技只能用在 faceted search box? 為什麼在 Find Workers 裡試不出 `A & -B` 的效果 ??

      - Workday processes operations from left to right in this order of precedence:

          - Parentheses `()`
          - `NOT` or `-`
          - `AND` or `&` or `&&`
          - `OR` or `|` or `||`

        Example: `Acme AND paid OR pending` finds objects that have:

          - both Acme and paid
          - pending only
          - all Acme, paid, and pending

      - You can override the operator precedence by using parentheses to group operations. Example: `Acme AND (paid OR pending)` finds objects that have:

          - both Acme and paid
          - both Acme and pending
          - all Acme, paid, and pending

      - If you use one of these delimiters in a search string, Workday might ignore the delimiter and divide the string into multiple search terms, resulting in more unwanted search results: `-`, `_`, `#`, `/`

  - [Reference: Search Prefixes for Recruiting • Human Capital Management • Reader • Administrator Guide](https://doc.workday.com/reader/gJQvxHUyQOZv_31Vknf~3w/5hWcKg8~34Y_Hoe98rWldg) #ril
  - [Quick Reference Guide: Search Prefixes](https://workday.uchicago.edu/sites/workday.uchicago.edu/files/uploads/qrg/Workday_Search_Prefixes.pdf) (PDF) 整理了很多 prefix #ril

## Worktag

  - [Concept: Worktags • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/_Q_ccWOLB3T310l9rhdAVQ) #ril

      - Worktags are keywords that you can assign to transactions and supporting data to make their business purposes clear and establish common relationships through CLASSIFICATION.

        Classification gives you a MULTIDIMENSIONAL VIEW of your business operations that you can act upon. You can find information easier, filter searches down to focused results, and analyze information in aggregated and summarized reporting by BUSINESS DIMENSION.

        就是 tag/label 的概念，方便一次被找出來，做後續的處理。

      - Example: When workers fill out purchase orders or expense reports they can assign worktags, such as the department and the project it's for.

## 參考資料 {: #reference }

  - [Cloud ERP System for Finance, HR, and Planning | Workday](https://www.workday.com/)
  - [Customer Center](https://workdayinc.force.com/workdaycustomercenter)
  - [Workday Community](https://community.workday.com/)

文件：

  - [Administrator Guide](https://doc.workday.com/) (先登入 Community)

更多：

  - [Community](workday-community.md)
  - [Training](workday-training.md)
  - [Organization](workday-org.md)
  - [Authentication](workday-auth.md)
  - [Security](workday-security.md)
  - [Business Process](workday-bp.md)
  - [Reporting](workday-report.md)
  - [Integration](workday-intsys.md)
  - [API](workday-api.md)
  - [Workday Studio](workday-studio.md)
  - [Slack](workday-slack.md)

手冊：

  - [Tenant Comparisons - Tenant Management | Workday Community](https://community.workday.com/articles/24324)
  - [Glossary - Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/M_r1GQrevkRxteNj1XyUmw)

