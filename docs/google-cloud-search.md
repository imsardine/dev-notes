# Google Cloud Search

  - [Google Cloud Search – Search Gmail, Calendar, Drive and more\.](https://gsuite.google.com/products/cloud-search/)

    The information you need, right when you need it

      - Use the power of Google to search across your COMPANY’S CONTENT. From Gmail and Drive to Docs, Sheets, Slides, Calendar, and more, Google Cloud Search answers your questions and delivers relevant suggestions to help you throughout the day.

    The best of Google Search for your business

      - Powered by machine learning, Cloud Search brings you NATURAL LANGUAGE UNDERSTANDING, instant QUERY PREDICTIONS, CONTEXTUAL RESULTS ??, and more. Get the speed, performance and reliability that only Google can provide — all in over 100 different languages. Cloud Search will also be available as a [STANDALONE OFFERING](https://cloud.google.com/products/search/).

        其中 standalone offering 指的是獨立於 G Suite 之外；兩者有什麼差別嗎 ??

    Privacy and security that meets your needs

      - Search results reflect the SECURITY MODELS of your organization as it changes over time. Cloud Search supports NEAR-INSTANT updates to group access — so users ONLY SEE SEARCH RESULTS FOR CONTENT THEY HAVE ACCESS TO.

        不會找到不能看的。

    Seamlessly integrated with G Suite

      - Cloud Search is seamlessly integrated with other G Suite apps. Search across Gmail, Docs, Drive, Calendar, and more.

    Rapid deployment

      - With powerful web and mobile apps, teams can start using Cloud Search in no time.

    Find people faster

      - Search your company directory. See colleagues’ contact details, plus events and files you have in common.

    Available in G Suite Business and Enterprise editions

      - Cloud Search is available for customers using G Suite Business and Enterprise editions.

        只有 Basic Edition 沒這項功能。

  - [Cloud Search  \|  Google Cloud](https://cloud.google.com/products/search/)

      - The best of Google Search for your company.

    Find what you need — quickly and securely

      - With Cloud Search, we’re bringing the best of Google Search to your business. Whether integrated with G Suite or THIRD-PARTY APPLICATIONS, Cloud Search helps your employees quickly, easily, and SECURELY find information ACROSS THE BUSINESS.

    Powered by machine learning

      - Searching THROUGH YOUR COMPANY’S DATA should be easy. Cloud Search utilizes MACHINE LEARNING to bring instant QUERY SUGGESTIONS and surface the most relevant results across different CONTENT SYSTEMS — in over 100 different languages. What Google does for web, Cloud Search does for your business.

        可以自行調整權重嗎?? 從其他 source 取得的資料，如何搭配才能做到 granular access-level controls ??

    Privacy and security models that meet your needs

      - Your search results reflect the security models of your organization. Granular access-level controls — including INDIVIDUAL-LEVEL, GROUP-LEVEL, and CONTENT-BASED HIERARCHIES ?? — help ensure that USERS ONLY SEE THE SEARCH RESULTS THEY SHOULD. And because updates are quickly reflected, these permissions change as your organization evolves.

    Built on a trusted, proven platform

      - Cloud Search runs on the same trusted infrastructure that supports multiple billion user products including Google web search. With Cloud Search, you get the speed, performance, and reliability that only Google can provide.

  - [Pricing Plans \| G Suite](https://gsuite.google.com/pricing.html)

      - Smart search across G Suite with Cloud Search

        Search across your company’s content in G Suite, from Gmail and Drive to Docs, Sheets, Slides, Calendar, and more. Cloud Search answers your questions and delivers relevant suggestions to help you throughout the day.

        從 Business Edition 開始有 Cloud Search，從 "across G Suite" 看來，是否在暗示只能搜 G Suite 的資料，無法餵其他資料進去 ??

## 新手上路 {: #getting-started }

  - [Introduction to Google Cloud Search  \|  Cloud Search  \|  Google Developers](https://developers.google.com/cloud-search/docs/guides/)

      - Google Cloud Search allows employees of a company to search and retrieve information, such as internal documents, database fields, and CRM data, from the company's INTERNAL DATA REPOSITORIES.

    Architectural overview

      - Figure 1 (Key components of Google Cloud Search) shows all the key components of a Google Cloud Search implementation:

        ![](https://developers.google.com/cloud-search/images/architecture-overview.png)

        分為 repository、data source 與 search interface 三塊，其中 content connector 把 data 透過 Indexing API 餵進 data source，而 search interface 則透過 Query API 查詢 data sources 裡的資料。

      - Here are the definitions of the most important terms from Figure 1:

        Repository

          - Software used by an enterprise to store its data, such as database used to store employee information.

        Data source

          - Data from a repository that HAS BEEN INDEXED and stored in Google Cloud Search.

            注意這裡的視角已經是 search interface，所以將面對的 index 稱做 data source，而資料的源頭才改稱 repository。

          - Search interface -- The user interface used by employees to search a data source. A search interface CAN BE DEVELOPED for use on any device, from a mobile phone to a desktop computer.
          - The GOOGLE-PROVIDED SEARCH WIDGET can also be deployed to enable search within your internal web sites. The SEARCH APPLICATION ID ?? is included with every search to ensure that the CONTEXT of that search, such as within a customer service tool, is known. The site cloudsearch.google.com contains a search interface.

        Search application

          - A GROUP OF SETTINGS that, when associated with a search interface, provide CONTEXTUAL INFORMATION about searches.
          - Contextual information includes the DATA SOURCES and SEARCH RANKINGS that should be used for a search using that interface. Search applications also include mechanisms for filtering results and enable REPORTING ?? on data sources, such as number of queries made over a given time period.

        Schema

          - A DATA STRUCTURE outlining how the data in a enterprise’s repository should be represented for Google Cloud Search. A schema defines the employee Google Cloud Search experience, such as how things are FILTERED ?? and displayed.

        Content connector

          - A software program used to TRAVERSE the data in an enterprise's repository and POPULATE a data source.

        Identity connector

          - A software program used to SYNC ENTERPRISE IDENTITIES (users and groups) to the identities required by Google Cloud Search.

            跟 "users only see the search results they should" 有關。

    Google Cloud Search use cases

      - Here are some use cases that might be solved by Google Cloud Search:

          - Employees need a way to find corporate policies, documents, and content authored by other employees.
          - Customer service team members need to find relevant troubleshooting documents to send to customers.
          - Employees need to find internal information about company projects.
          - A sales representative wants to view the status of all support issues for a particular customer.
          - Employees want a definition for a COMPANY-SPECIFIC TERM.

      - The first step in implementing Google Cloud Search is to identify the use cases solved by Google Cloud Search.

    Implement Google Cloud Search

      - By default, Google Cloud Search indexes G Suite data, such as Google documents and spreadsheets. You DO NOT need to implement Google Cloud search for G Suite data. However, you need to implement Google Cloud Search for NON-G SUITE DATA, such as data stored in a third-party database, file systems like Windows Fileshare, OneDrive or intranet portals like Sharepoint.

      - The following steps are required to implement Google Cloud Search for your enterprise.

         1. Determine a USE CASE that Google Cloud Search helps to solve.
         2. Identify the REPOSITORIES holding data relevant to the use case.
         3. Identify the IDENTITY SYSTEMS used by your company to MANAGE ACCESS to data in each repository.
         4. Configure access to the Google Cloud Search REST API.
         5. Add a DATA SOURCE to Google Cloud Search.
         6. Create and register a SCHEMA FOR EACH DATA SOURCE.

         7. Determine if there is a CONTENT CONNECTOR available for your repository. For a list of pre-built connectors, refer to the [Cloud Search connector directory](https://developers.google.com/cloud-search/docs/connector-directory/). If a content connector is available, skip to step 9.

            可惜除了最上面 7 個 connector/plugin 由 Google 提供之外，下面一大串都是 Partner developed connectors，也就是要收費的部份。

         8. Create a content connector to access data in each repository and index it into a Cloud Search data source.

         9. Determine if you need an IDENTITY CONNECTOR. If you don't need an identity connector, skip to step 11.

            什麼情況下需要 identity connector ??

        10. Create an identity connector to map your repository or enterprise identities to Google identities.
        11. Set up search applications.
        12. Create a search interface to perform search queries.
        13. Deploy your connectors and search interfaces. If you used a pre-built connector, follow the instructions for the connector to obtain and deploy the connector. Available connectors are listed in the Google Cloud Search Connector Directory

    Next steps

      - Try the Google Cloud Search getting started tutorial.
      - Determine use case(s) for which you'll use Google Cloud Search.
      - Identify the repositories relevant to these use cases.
      - Identify any identity systems used by your repositories.
      - Continue to Configure access to the Google Cloud Search API.

## Third-party / Non-G Suite Content ??

從 [G Suite 介紹](https://gsuite.google.com/products/cloud-search/) 及 [G Suite Admin Help](https://support.google.com/a/answer/7056471) 的說法看來，G Suite 的 Cloud Search 應該也要可以索引非 G Suite 的資料才對，不過 Enterprise Edition 是基本條件：

> We are expanding Cloud Search to support third-party content repositories with a FIRST WAVE OF CUSTOMERS.

> This feature is available with Cloud Search Platform or the G Suite Enterprise edition.
>
> Important: if you are a G Suite Enterprise customer, and you don't see the Third-party data sources card, your account has not yet been enabled for the Cloud Search for third-party repositories service. This service requires SUBSTANTIAL EFFORT and EXPERTISE to deploy, including in-house system integration expertise, and is rolling out gradually to customers as well as evolving to reduce the required effort for deployment.
>
> If you are a G Suite Enterprise customer and want your access to this service expedited, please contact G Suite Support.

就算有 G Suite Enterprise Edition，也可能要找 partner 才行。

---

參考資料：

  - [Google Cloud Search – Search Gmail, Calendar, Drive and more\.](https://gsuite.google.com/products/cloud-search/)

    Does Cloud Search support third-party data?

      - We are expanding Cloud Search to support third-party content repositories with a FIRST WAVE OF CUSTOMERS.

        感覺這是很新的東西，一定要透過 partner 才搞得起來的感覺?? 有 1000 以上才能用??

  - [Cloud Search  \|  Google Cloud](https://cloud.google.com/products/search/)

      - Featured partners 提到有廠商可以協助 connect the dots across DISPARATE DATA SILOS 也就是不在 Google 生產力工具裡的資料。

    Anything and everything at your fingertips

      - Cloud Search makes available ROBUST SDKs and READY-TO-USE APIs that help you scalably INDEX VAST AMOUNTS OF DATA FROM ANY SOURCE.

        With 80+ connectors, you can index your third-party content from 60+ enterprise sources. This includes storage solutions like Amazon S3, Box, and Microsoft OneDrive; databases like Oracle, MySQL, and PostgreSQL; collaboration solutions like Atlassian Confluence, Jira, and Microsoft Sharepoint; documentation, ERP, sales, and support systems like Salesforce, SAP, and ServiceNow — just to name a few.

        So whether your data is ON-PREMISES or in another cloud, you can stay on top of all the things you care about.

        如何自行開發 connector ??

      - Cloud Search will also make available out-of-the-box connectors for indexing third-party databases like Oracle and MySQL, file systems like Windows file systems, intranet solutions like Microsoft SharePoint, and plugins for popular web crawlers like Nutch and Norconex.

        這是早期的說法，多了 crawlers 的部份，那 Scrapy 呢??

    Global partners

      - Looking to bring Cloud Search to your organization? Our global network of partners — including system integrators and independent software vendors — can help you connect the dots across DISPARATE DATA SILOS.

      - 最下面 Get started > Sign up today 提到 Cloud Search is currently available to our FIRST WAVE OF CUSTOMERS. Sign up below to express interest and tell us about your use case. 按下 Sing Up 要留資料 -- We’re beginning to roll out Cloud Search to customers. 就算是 system integrator 也可以。

  - [Cloud Search Platform \- G Suite Admin Help](https://support.google.com/a/answer/9161406?hl=en)

      - Google Cloud Search Platform gives your organization the power to search across your third-party repositories, such as databases and file systems. Integrate Cloud Search Platform with your G Suite edition or use it in a standalone solution.

        這裡沒講明 G Suite 哪個版本才能整合 third-party 資料。

  - [Add a data source to search \- G Suite Admin Help](https://support.google.com/a/answer/7056471)

      - This feature is available with Cloud Search Platform or the G Suite Enterprise edition.

      - Important: if you are a G Suite Enterprise customer, and you don't see the Third-party data sources card, your account has not yet been enabled for the Cloud Search for third-party repositories service. This service requires SUBSTANTIAL EFFORT and EXPERTISE to deploy, including in-house system integration expertise, and is rolling out gradually to customers as well as evolving to reduce the required effort for deployment.

        If you are a G Suite Enterprise customer and want your access to this service expedited, please contact G Suite Support.

        看來 G Suite Enterprise 的用戶也不是直接能用，還是得找 partner ??

  - [Who can use Cloud Search - Fishbowl Solutions \- The wait is over\! Google Cloud Search with third\-party connectivity is now available\. Here's what you need to know\.](https://www.fishbowlsolutions.com/2018/11/the-wait-is-over-google-cloud-search-with-third-party-connectivity-is-now-available-heres-what-you-need-to-know/) (2018-11-05)

      - Any enterprise can purchase Cloud Search as a STANDALONE PLATFORM EDITION regardless of whether you use other Google products such as G Suite or Google Cloud Platform.

      - If users in your domain already have G Suite ENTERPRISE licenses, they will now be able to access results from third-party data via the Cloud Search application provided as part of the G Suite. You will be allotted a FIXED QUOTA OF THIRD-PARTY DATA that you can index, based on the NUMBER OF ENTERPRISE LICENSES.

        G Suite customers can also purchase the standalone platform edition if additional quota or search applications are required.

        就算是 Enterprise Edition 還是會受限於授權的數量，未來也可能要增購 Cloud Search Standalone Edition，雖然這聽起來有點怪，但顯然是個坑。

  - [Google Cloud Search: A Fully Managed Secure Enterprise Search Platform from Google \(Cloud Next '18\) \- YouTube](https://youtu.be/5vXyg0J6wro?t=531) (2018-07-26)

      - 08:51 Available in two editions:

          - Bundled with G Suite Enterprise for customer with >5000 licenses
          - Standalone offering for any customer

  - [Cloud Search getting started tutorial  \|  Cloud Search  \|  Google Developers](https://developers.google.com/cloud-search/docs/tutorials/end-to-end/) #ril
  - [Configure access to the Google Cloud Search REST API  \|  Cloud Search  \|  Google Developers](https://developers.google.com/cloud-search/docs/guides/project-setup) #ril
  - [Create and register a schema  \|  Cloud Search  \|  Google Developers](https://developers.google.com/cloud-search/docs/guides/schema-guide) #ril
  - [Create a content connector  \|  Cloud Search  \|  Google Developers](https://developers.google.com/cloud-search/docs/guides/content-connector) #ril
  - [Create a custom search experience \- G Suite Admin Help](https://support.google.com/a/answer/9043922) #ril
  - [The search interface  \|  Cloud Search  \|  Google Developers](https://developers.google.com/cloud-search/docs/guides/search-interface) #ril

## 參考資料 {: #reference }

  - [Cloud Search](https://cloudsearch.google.com/) (入口)
  - [Google Cloud Search (G Suite)](https://gsuite.google.com/products/cloud-search/)
  - [Cloud Search (Standalone Offering)](https://cloud.google.com/products/search/)

文件：

  - [Introduction to Google Cloud Search | Cloud Search | Google Developers](https://developers.google.com/cloud-search/docs/guides/)

更多：

  - [API](google-cloud-search-api.md)

手冊：

  - [Google Cloud Search Connector Directory](https://developers.google.com/cloud-search/docs/connector-directory/)
