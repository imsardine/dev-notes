# DKIM (DomainKeys Identified Mail)

  - DKIM [唸做 ‵di-kɪm](https://youglish.com/pronounce/dkim/english?)，而不是 D-K-I-M。

---

  - [DomainKeys Identified Mail \- Wikipedia](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail)

      - DomainKeys Identified Mail (DKIM) is an EMAIL AUTHENTICATION method designed to detect FORGED SENDER addresses in email (EMAIL SPOOFING), a technique often used in phishing and email spam.

      - DKIM allows the receiver to check that an email CLAIMED to have COME FROM A SPECIFIC DOMAIN was indeed authorized by the owner of that domain. It achieves this by AFFIXING A DIGITAL SIGNATURE, LINKED TO A DOMAIN NAME, to each outgoing email message.

        The recipient system can verify this by looking up the SENDER'S PUBLIC KEY published in the DNS. A valid signature also guarantees that some parts of the email (possibly including attachments) have not been modified since the signature was affixed.

        Usually, DKIM signatures are not visible to end-users, and are affixed or verified by the infrastructure rather than the message's authors and recipients.

      - DKIM is an Internet Standard. It is defined in RFC 6376, dated September 2011; with updates in RFC 8301 and RFC 8463.

    Overview

      - The need for email validated identification arises because forged addresses and content are otherwise easily created—and widely used in spam, phishing and other email-based fraud. For example, a fraudster may send a message claiming to be from sender@example.com, with the goal of convincing the recipient to accept and to read the email—and it is difficult for recipients to establish whether to trust this message. System administrators also have to deal with complaints about malicious email that appears to have originated from their systems, but did not.

      - DKIM provides the ability to sign a message, and allows the signer (author organization) to COMMUNICATE which email it considers LEGITIMATE. It does not directly prevent or disclose abusive behavior.

        DKIM also provides a process for verifying a signed message. Verifying modules typically act ON BEHALF OF THE RECEIVER ORGANIZATION, possibly at each hop.

      - All of this is independent of Simple Mail Transfer Protocol (SMTP) routing aspects, in that it operates on the RFC 5322 message—the transported mail's header and body—not the SMTP "envelope" defined in RFC 5321. Hence, DKIM signatures SURVIVE basic relaying across multiple MTAs.

    Relationship to SPF and DMARC

      - In essence, both DKIM and SPF provide DIFFERENT MEASURES of email AUTHENTICITY.

      - DMARC provides the ability for an organisation to publish a policy that specifies which mechanism (DKIM, SPF, or both) is employed when sending email from that domain; how to check the `From:` field presented to end users; how the receiver should deal with failures—and a reporting mechanism for actions performed under those policies.

        沒有 DMARC 接收端就不知道用方麼方式驗證??

  - [What are SPF and DKIM? \- YouTube](https://www.youtube.com/watch?v=8V2nfKLzc84)

    SPF and DKIM help prevent spammers from IMPERSONATING your organization.

    DKIM, or DomainKeys Identified Mail Standard, was created for the same reason as SPF - to prevent spammers from impersonating you as an email sender.

    With DKIM, you sign your emails with a unique signature that lets the receiving server check if the sender is really you and verify the message was not changed after you sent it.

    When you set up DKIM within your domain provider's DNS settings, you’re adding another way to tell your receivers “yes, it’s really me who’s sending this message”.

  - [Why set up email Authentication? \- YouTube](https://www.youtube.com/watch?v=0sSGSYYyrHk)

    Email authentication helps prevent messages your organization sends FROM BEING FLAGGED AS SPAM.

  - [Set up DKIM to prevent email spoofing \- Google Workspace Admin Help](https://support.google.com/a/answer/174124?hl=en)

    Make your email more secure and protect your domain

      - Use the DomainKeys Identified Mail (DKIM) standard to help prevent spoofing on outgoing messages sent from your domain.

        Email spoofing is when email content is changed to make the message appear from someone or somewhere other than the actual source. Spoofing is a common unauthorized use of email, so some email servers require DKIM to prevent email spoofing.

      - DKIM adds an encrypted signature to the HEADER of all outgoing messages. Email servers that get signed messages use DKIM to decrypt the message header, and verify the message was not changed after it was sent.

      - If you want more email security, we recommend setting up these security methods along with DKIM:

          - Sender Policy Framework (SPF) – SPF specifies which domains can send messages for your organization. ??
          - Domain-based Message Authentication, Reporting & Conformance (DMARC) – DMARC specifies how your domain handles suspicious emails.

    If you don't set up DKIM, Gmail uses default DKIM

      - DKIM signing increases email security and helps prevent email spoofing. We recommend you use YOUR OWN DKIM key on all outgoing messages.

      - If you don't generate your own DKIM domain key, Gmail signs all outgoing messages with this default DKIM domain key: `d=*.gappssmtp.com`

        Messages sent from servers outside of `mail.google.com` won't be signed with the default DKIM key.

    Steps to set up DKIM

     1. Generate the domain key for your domain.
     2. Add the public key to your domain's DNS records. Email servers can use this key to verify your messages' DKIM signatures.
     3. Turn on DKIM signing to start adding a DKIM signature to all outgoing messages.

    ----

    How does DKIM work?

      - DKIM uses a pair of keys, one private and one public, to verify messages.

        A private domain key adds an encrypted signature header to all outgoing messages sent from your Gmail domain.

        A matching public key is added to the Domain Name System (DNS) record for your Gmail domain. Email servers that get messages from your domain use the public key to decrypt the message signature and verify the signed message sources.

        When you turn on email authentication in Gmail, DKIM starts signing the headers of outgoing messages.

    What if my domain already has a DKIM key?

      - If you already use DKIM in your domain (with another email system), you must generate a new, unique domain key to use with Gmail.

      - Domain keys include a text string called the SELECTOR PREFIX, which you can modify when you generate the key.

        The default selector prefix for the Google Workspace domain key is `google`. When you generate the key, you can change the default selector prefix from `google` to the text of your choice, and use the new selector in parallel with the domain's existing DKIM key configuration.

    How do I set up DKIM for a server that modifies the content of outgoing emails?

      - If you use an OUTBOUND MAIL GATEWAY that changes outgoing messages, the DKIM signature is VOIDED. One example is email servers that add a footer to every outgoing message. To avoid this issue, take one of these actions:

          - Set up the gateway so that it does not modify outgoing messages.
          - Set up to the gateway to change the message first, then add the DKIM signature after.

    What if emails from my domain are rejected because they don't pass DKIM?

      - If messages from your domain are rejected, contact the administrator for the rejecting email server. Email servers SHOULD NOT reject messages because of missing or unverifiable DKIM signatures (RFC 4871).

## 參考資料 {: #reference }

相關：

  - [Email Authentication](email-auth.md)

手冊：

  - [RFC 6376 - DomainKeys Identified Mail (DKIM) Signatures](https://www.rfc-editor.org/info/rfc6376)
  - [RFC 8301 - Cryptographic Algorithm and Key Usage Update to DomainKeys Identified Mail (DKIM)](https://www.rfc-editor.org/info/rfc8301)
  - [RFC 8463 - A New Cryptographic Signature Method for DomainKeys Identified Mail (DKIM)](https://www.rfc-editor.org/info/rfc8463)
  - [RFC 4871 - DomainKeys Identified Mail (DKIM) Signatures](https://www.rfc-editor.org/info/rfc4871)
