# S/MIME

  - [What is S/MIME and How Does It Work?](https://www.compuquip.com/blog/what-is-smime) (2020-02-06)

      - If you’re wondering “what is S/MIME?” after reading the title of this post, don’t worry, you’re not alone. The term S/MIME (sometimes rendered as “SMIME”) isn’t something that most users of the internet are familiar with—even though they may have sent emails using S/MIME encryption certificates numerous times if they have a BUSINESS EMAIL ADDRESS.

        Read on for an explanation of what S/MIME is, how it works, and how to use it to protect your emails.

    What is S/MIME?

      - S/MIME is an acronym for Secure/Multipurpose Internet Mail Extensions. It references a type of PUBLIC ENCRYPTION and SIGNING of MIME data (a.k.a. email messages) to verify a SENDER’S IDENTITY. With S/MIME, it is possible to send and receive encrypted emails.

      - S/MIME has been around for a long while—long enough that Microsoft puts their help article for S/MIME under “Legacy security capabilities” on their website.

        Over the years, S/MIME has undergone several changes to eliminate security weaknesses such as EFAIL, a security vulnerability affecting END-TO-END ENCRYPTION solutions like S/MIME and PGP.

    How Does S/MIME Work?

      - As mentioned above, S/MIME is a type of “end-to-end” encryption solution used for email messages. To be more specific, it uses asymmetric cryptography to protect emails from BEING READ BY A THIRD PARTY.

        As noted by GlobalSign, a company specializing in Public Key Infrastructure (PKI) solutions for enterprises to secure communications, S/MIME used a public key to encrypt emails and “The email can ONLY BE DECRYPTED WITH THE CORRESPONDING PRIVATE KEY, which is supposed to be in sole possession of the recipient.”

In other words, it’s a two-key system that leverages two different, but mathematically-related cryptography keys to work. This is why it’s called “asymmetric cryptography.” One key may be public, but without the hidden private key held by the recipient, the email should be nigh impossible to crack.

One common criticism of the way that S/MIME encryption works is that, because it encrypts all of the contents of an email, it can make it harder for antivirus/antimalware scanners to detect malicious software downloads and site links in an email. This can make it more difficult for some security measures to stop email-based cyberattacks where a legitimate sender’s email account is either used maliciously or hijacked by hackers.



