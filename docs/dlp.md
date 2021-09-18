# DLP (Data Loss Prevention)

  - [What Is DLP and How Does It Work? \| McAfee](https://www.mcafee.com/enterprise/en-us/security-awareness/data-protection/how-data-loss-prevention-dlp-technology-works.html) #ril

      - Data loss prevention solutions are growing in popularity as enterprises look for ways to reduce the risk of sensitive data leaking outside the company. Gartner estimates that by 2021, 90% of organizations will have implemented at least one form of INTEGRATED DLP, up from 50% in 2017.

        A DLP solution relies on several core technologies that enable its engine to ACCURATELY IDENTIFY the sensitive data that enterprises need to secure and take REMEDIATION ACTION to prevent incidents. This post covers the different technologies employed by DLP solutions today.

    What is DLP?

      - Data loss prevention (DLP), per Gartner, may be defined as technologies which perform both CONTENT INSPECTION and CONTEXTUAL ANALYSIS of data sent via messaging applications such as email and instant messaging, in motion over the network, in use on a managed endpoint device, and at rest in on-premises file servers or in cloud applications and cloud storage. These solutions execute responses based on policy and rules defined to address the risk of inadvertent or accidental leaks or exposure of sensitive data outside authorized channels.
      - DLP technologies are broadly divided into two categories – Enterprise DLP and Integrated DLP. While Enterprise DLP solutions are COMPREHENSIVE and packaged in agent software for desktops and servers, physical and virtual appliances for monitoring networks and email traffic, or soft appliances for data discovery, Integrated DLP is LIMITED to secure web gateways (SWGs), secure email gateways (SEGs), email encryption products, enterprise content management (ECM) platforms, data classification tools, data discovery tools, and cloud access security brokers (CASBs).

    How does DLP work?

      - Understanding the differences between CONTENT AWARENESS and CONTEXTUAL ANALYSIS is essential to comprehend any DLP solution in its entirety. A useful way to think of the difference is if content is a letter, context is the envelope. While content awareness involves capturing the envelope and peering inside it to analyze the content, context includes external factors such as header, size, format, etc., anything that doesn’t include the content of the letter.

        The idea behind content awareness is that although we want to use the context to gain more intelligence on the content, we don’t want to be restricted to a single context. ??

      - Once the envelope is opened and the content processed, there are multiple content analysis techniques which can be used to trigger POLICY VIOLATIONS, including:

          - Rule-Based/Regular Expressions: The most common analysis technique used in DLP involves an engine analyzing content for specific rules such as 16-digit credit card numbers, 9-digit U.S. social security numbers, etc. This technique is an EXCELLENT FIRST-PASS FILTER since the rules can be configured and processed quickly, although they can be prone to high false positive rates without checksum validation?? to identify valid patterns.
          - Database Fingerprinting: Also known as Exact Data Matching, this mechanism looks at exact matches from a database dump or live database. Although database dumps or live database connections affect performance, this is an option for structured data from databases.
          - Exact File Matching: File contents are not analyzed; however, the hashes of files are matches against exact fingerprints. Provides low false positives although this approach does not work for files with multiple similar but not identical versions.
          - Partial Document Matching: Looks for complete or partial match on specific files such as multiple versions of a form that have been filled out by different users.
          - Conceptual/Lexicon: Using a combination of dictionaries, rules, etc., these policies can alert on completely unstructured ideas that defy simple categorization. It needs to be customized for the DLP solution provided.
          - Statistical Analysis: Uses machine learning or other statistical methods such as Bayesian analysis to trigger policy violations in secure content. Requires a large volume of data to scan from, the bigger the better, else prone to false positives and negatives.
          - Pre-built categories: Pre-built categories with rules and dictionaries for common types of sensitive data, such as credit card numbers/PCI protection, HIPAA, etc.

      - There are myriad techniques in the market today that deliver different types of content inspection. One thing to consider is that while many DLP vendors have developed their own content engines, some employ third-party technology that is not designed for DLP. For example, rather than building pattern matching for credit card numbers, a DLP vendor may license technology from a search engine provider to pattern match credit card numbers. When evaluating DLP solutions, pay close attention to the types of patterns detected by each solution against a REAL CORPUS of sensitive data to confirm the accuracy of its content engine.

      - Data protection is one of the primary concerns when adopting cloud services. The average enterprise uses 1,427 cloud services, and employees often INTRODUCE NEW SERVICES ON THEIR OWN.

        Analyzing cloud usage data for 30 million users, McAfee (formerly Skyhigh Networks) found that 18.1% of documents uploaded to file-sharing services contain sensitive information, such as personally identifiable information (PII), protected health information (PHI), payment card data, or intellectual property, thus creating compliance concerns.

        It follows that employing the right DLP solution in the cloud encompassing accuracy, real-time monitoring, analysis of data in motion, incident remediation, and data loss policy authoring is essential for successful cloud adoption.

        有點難想像往 cloud service 的 traffic 如何監控?
