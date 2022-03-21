# DMARC (Domain-based Message Authentication, Reporting and Conformance)

  - [DMARC \- Wikipedia](https://en.wikipedia.org/wiki/DMARC)

      - DMARC (Domain-based Message Authentication, Reporting and Conformance) is an EMAIL AUTHENTICATION PROTOCOL. It is designed to give email domain owners the ability to protect their domain from unauthorized use, commonly known as email spoofing.

        The purpose and primary outcome of implementing DMARC is to protect a domain from being used in BUSINESS EMAIL COMPROMISE ATTACKS, phishing emails, email scams and other cyber threat activities.

      - Once the DMARC DNS entry is published, any receiving email server can authenticate the incoming email based on the INSTRUCTIONS published by the domain owner within the DNS entry.

        If the email passes the authentication, it will be delivered and can be trusted. If the email fails the check, depending on the instructions held within the DMARC record the email could be delivered, quarantined or rejected.

        For example, one email forwarding service delivers the mail, but as "From: no-reply@<forwarding service>". ??

      - DMARC EXTENDS two existing email authentication mechanisms, Sender Policy Framework (SPF) and DomainKeys Identified Mail (DKIM).

        It allows the administrative owner of a domain to publish a POLICY in their DNS records to specify which mechanism (DKIM, SPF or both) is employed when sending email from that domain; how to check the From: FIELD PRESENTED TO END USERS; how the receiver should deal with failures - and a reporting mechanism for actions performed under those policies.

      - DMARC is defined in the Internet Engineering Task Force's published document RFC 7489, dated March 2015, as "Informational".

## 參考資料 {: #reference }

相關：

  - [Email Authentication](email-auth.md)

手冊：

  - [RFC 7489 - Domain-based Message Authentication, Reporting, and Conformance (DMARC)](https://www.rfc-editor.org/info/rfc7489)
