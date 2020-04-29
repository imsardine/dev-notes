---
title: Active Directory / Federation Services (ADFS)
---
# [Active Directory](ad.md) / Federation Services (ADFS)

  - [Active Directory Federation Services \- Wikipedia](https://en.wikipedia.org/wiki/Active_Directory_Federation_Services)

      - Active Directory Federation Services (AD FS), a software COMPONENT developed by Microsoft, can run on Windows Server operating systems to provide users with SINGLE SIGN-ON access to systems and applications located ACROSS ORGANIZATIONAL BOUNDARIES.

        AD 本身只是驗證身份，SSO 是 ADFS 疊加上去的功能；正確地說，ADFS 把 AD 做為 Identity Provider。

      - It uses a CLAIMS-BASED ACCESS-CONTROL AUTHORIZATION model to maintain application security and to implement FEDERATED IDENTITY.

        Claims-based authentication involves authenticating a user based on a set of claims about that user's identity contained in a trusted token. Such a token is often issued and signed by an entity that is able to authenticate the user by other means, and that is trusted by the entity doing the claims-based authentication. It is part of the Active Directory Services.

        這裡 "claims-based authentication" 應該是 authorization??

      - In AD FS, IDENTITY FEDERATION is established between two organizations by establishing trust between two SECURITY REALMS. A federation server on one side (the ACCOUNTS SIDE) authenticates the user through the standard means in Active Directory Domain Services and then issues a token containing a series of claims about the user, including its identity.

        為了跟 ADFS 區隔，AD 可以用 "Domain Services" 來強調。

        On the other side, the RESOURCES SIDE, another federation server validates the token and issues ANOTHER TOKEN for the local servers to accept the claimed identity.

        This allows a system to provide controlled access to its resources or services to a user that belongs to another security realm without requiring the user to authenticate directly to the system and without the two systems sharing a database of user identities or passwords.

        統一驗證身份，但 access control 由各個 security realm 各自管控。

      - In practice a user might typically perceive this approach as follows:

         1. The user logs into their local PC (as they typically would when commencing work in the morning).
         2. The user needs to obtain information from a partner company's EXTRANET website, for example to obtain pricing or product details.
         3. The user navigates to the partner-company extranet site, for example: http://example.com.

         4. The partner website now does not require any password to be typed in; instead, the user credentials are passed to the partner extranet site using AD FS.

            把 credentials 傳給 partner，聽起來很危險??

         5. The user is now logged into the partner website and can interact with the website as if logged in.

      - AD FS integrates with Active Directory Domain Services, using it as an IDENTITY PROVIDER. AD FS can interact with other WS-* and SAML 2.0-compliant federation services as FEDERATION PARTNERS.

        如果一個 application 要搭配 ADFS 實現 SSO，本身也要是 federation partner 嗎??

