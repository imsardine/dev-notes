---
title: Email / Authentication
---
# [Email](email.md) / Authentication

  - [Prevent spam, spoofing & phishing with Gmail authentication \- Google Workspace Admin Help](https://support.google.com/a/answer/10583557?hl=en)

    Set up SPF, DKIM & DMARC for your organization

      - Gmail administrators should set up email authentication to protect their organization's email. Authentication helps prevent messages from your organization from being marked as spam. It also prevents spammers from impersonating your domain or organization in spoofing and phishing emails.

      - If spammers send forged messages using your organization's name or domain, people who get these messages might report them as spam.

        This means legitimate messages from your organization might also be marked as spam. Over time, your organization's INTERNET REPUTATION can be negatively affected.

    Set up email authentication for Gmail

      - First, ensure mail delivery & prevent spoofing with SPF

        SPF lets you specify the servers and domains that are allowed to send email for your organization. When receiving mail servers get a message from your organization, they compare the sending server to your list of ALLOWED SERVERS. This lets receiving servers verify the message actually came from you.

      - Then, increase security for outgoing email with DKIM

        DKIMs adds an encrypted digital signature to every message sent from your organization. Receiving mail servers use a public key to read the signature, and verify the message actually came from you. DKIM also prevents message content from being changed when the message is sent between servers.

      - Finally, enhance security for forged spam with DMARC

        DMARC tells receiving servers what to do with messages from your organization when they DON'T PASS either SPF or DKIM.

        DMARC also sends reports that tell you which messages pass or fail SPF and DKIM. These reports help you identify POSSIBLE EMAIL ATTACKS and other vulnerabilities.

        若有 report 可以觀測濫用的情形，DMARC 就很值得啟用。

      - Optionally, add your BRAND LOGO to DMARC-authenticated messages

        After you set up DMARC, you can optionally turn on Brand Indicators for Message Identification (BIMI). When messages pass DMARC, email clients that support BIMI, including Gmail, display your verified brand logo in the INBOX AVATAR slot.

## 參考資料 {: #reference }

工具：

  - [Check MX: Check MX and SPF Records.](https://toolbox.googleapps.com/apps/checkmx/)

相關：

  - [DKIM](dkim.md)
  - [SPF](spf.md)
  - [DMARC](dmarc.md)
