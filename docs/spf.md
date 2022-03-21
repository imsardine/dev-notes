# SPF (Sender Policy Framework)

  - [Sender Policy Framework \- Wikipedia](https://en.wikipedia.org/wiki/Sender_Policy_Framework)

      - Sender Policy Framework (SPF) is an EMAIL AUTHENTICATION method designed to detect forging sender addresses during the delivery of the email.

        SPF alone, though, is limited to detecting a forged sender claim in the ENVELOPE of the email, which is used when the mail gets BOUNCED. ?? Only in combination with DMARC can it be used to detect the forging of the VISIBLE SENDER in emails (email spoofing), a technique often used in phishing and email spam.

      - SPF allows the receiving mail server to check during mail delivery that a mail claiming to come from a specific domain is submitted by an IP ADDRESS authorized by that domain's administrators.

        The list of authorized sending hosts and IP addresses for a domain is published in the DNS records for that domain.

      - Sender Policy Framework is defined in RFC 7208 dated April 2014 as a "proposed standard".

  - [What are SPF and DKIM? \- YouTube](https://www.youtube.com/watch?v=8V2nfKLzc84)

    SPF and DKIM help prevent spammers from IMPERSONATING your organization.

    SPF, or Sender Policy Framework, lets you specify the MAIL SERVERS THAT ARE AUTHORIZED TO SEND EMAIL FOR YOUR DOMAIN.

    This helps receiving servers identify fake messages that appear to come from your organization.

    SPF also helps ensure that your messages are delivered correctly.

## 參考資料 {: #reference }

相關：

  - [Email Authentication](email-auth.md)

手冊：

  - [RFC 7208 - Sender Policy Framework (SPF) for Authorizing Use of Domains in Email, Version 1](https://www.rfc-editor.org/info/rfc7208)
