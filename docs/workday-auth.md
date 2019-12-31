---
title: Workday / Authentication
---
# [Workday](workday.md) / Authentication

  - [Change Workday Password for User • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/MtfgoUieSOZyoJwKmIi_6A) #ril
  - [Configure Password Reset • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/OFHl2aPfIZOfT5wfWfppsA) #ril

## SAML

  - [Concept: SAML Authentication • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/isnv08HWriJaS_fTijJoRA)

      - You can use Security Assertion Markup Language (SAML) for single sign-on (SSO) and single logout (SLO) ?? in Workday. SAML is a standard for exchanging authentication and AUTHORIZATION data between SECURITY DOMAINS, enabling you to centrally manage user credentials through a third-party identity provider (IdP).

        Example: A security administrator can disable a user's account without directly signing in to Workday.

      - Workday supports the SAML 2.0 SSO standard for signing in to Workday from other identity providers.

    How SAML Works

      - When you enable SAML authentication for signing in to Workday:

          - Your SAML IdP authenticates users and sends a SAML response message to Workday.
          - Workday either grants or denies access to a user based on the SAML ASSERTION in the message.

      - You can configure 2 types of FLOWS in Workday based on WHO SENDS THE FIRST SAML MESSAGE:

          - In IdP-initiated SAML, the SAML PROVIDER sends an unsolicited SAML response message to Workday.
          - In SP-initiated SAML, Workday sends a SAML AUTHENTICATION REQUEST message to your SAML provider.

        第一則 SAML provider 指的是 IdP，因為提供 SAML assertion 的不會是 SP (Workday)。

      - When you enable SAML for signing out of Workday using your IdP, you can configure 2 types of flows in Workday based on who sends the first SAML message:

          - In IdP-initiated SLO, your SAML provider sends a SAML LogoutRequest message to Workday.
          - In Workday-initiated SLO, Workday signs the user out of Workday and sends a SAML LogoutRequest message to your IdP.

      - During the SAML authentication process, all SAML messages must:

          - Pass through the user's browser or mobile client. Workday doesn't support SAML Artifacts. ??
          - Use HTTPS.

          - Be signed if they are incoming to Workday.

            相反地，如果由 Workday 這端發出 request 或返回 response，也要用自己的 private key 簽署過。

    Redirect URLs

      - SAML redirect URLs facilitate the integration of SAML with Workday. Specify redirect URLs as alternative URLs to reference when users make unauthenticated requests to Workday. These redirect URLs:

          - Apply to the Sign In to Workday page, the Workday Sign Out button, and DEEPLINKs that reference Workday authentication URLs.
          - Must use HTTPS.
          - Apply to all users.

        當使用者直接對 Workday 存取時，要先轉去哪裡做驗證?

        Redirect URL 跟 SAML request 的關係是什麼??

      - To avoid continuous loops when the IdP session is still active, use different URLs for the Login Redirect URL and Logout Redirect URL. In addition, if you're not using SLO, signing out of Workday doesn't end a user's IdP session, which might enable the user to access Workday again without authenticating.

        所謂 SLO 是登出整個 IdP session。

    SAML Deeplinks

      - When Workday receives an authentication request from a user accessing a deeplink, such as when a user clicks an email link, Workday stores deeplinks during SSO redirects for both IdP-initiated and SP-initiated SAML.

        完成登入後，會把使用者帶到原先想存取的頁面。

    X.509 and SAML

      - Workday's SAML features require that you use X.509 certificates to sign SAML messages.

        不論是 SSO 或 SLO，不論是 IdP-initiated 或 Workday-initiated，送出訊息的一方都會用自己的 X.509 private key 簽署，另一方則用對應的 X.509 public key 確認來源，中間一定是走 HTTPS。

      - You must create an X.509 public key in Workday to verify the digital signature on incoming SAML sign in and sign out requests. Your IdP must use a corresponding X.509 private key to sign those files.

        這裡 sign in/out request 指的都是 IdP-iniated SAML/SLO，所以是 IdP 端用它的 private key 簽署，而 SP 這端 (Workday) 則用對應的 public key 檢查。

      - To configure Workday to participate in SAML sign out transactions, you must create an X.509 private key pair in Workday, and ensure that the public key is available to your IdP.

        When Workday generates SAML sign out request and sign out response messages, it uses the X.509 private key to sign the messages. Your IdP uses the corresponding X.509 public key to verify that the SAML sign out requests and responses came from your Workday tenant. Public keys must be in PEM format.

        這裡指的是 SP-initiated SAML/SLO，所以是 SP 這端 (Workday) 用自己的 private key 簽署，而 IdP 顱則用對應的 public key 檢查。

        為什麼這裡只講 sign out? 因為轉去 IdP 那邊真的會觸發 logout，所以要先由 Workday 這邊 sign 過? 為什麼 sign-on 不用 Workday 這方的 private key? 因為不會實際產生動作，只是帶到要輸入帳密的頁面??

        從 "sign out response" 看來，即便是 IdP-initiated SAML/SLO，當 SP (Workday) 產生 response 時，也會用到自己的 private key。

  - [Configure Identity Provider\-Initiated SAML Authentication • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/1SrUii41GTc5l3k14I02lA) #ril

    Prerequisites

      - Enable Security Assertion Markup Language (SAML) authentication and set up 1 OR MORE SAML identity providers (IdPs) for your tenant.
      - Security: Set Up: Tenant Setup - Security domain in the System functional area.

    Context

      - Configure additional settings and SAML redirect URLs for IdP-initiated SAML authentication.

    Steps

     1. Access the Edit Tenant Setup - Security task.

     2. In the SAML Setup section, configure settings for IdP-initiated SAML.

  - [Configure Service Provider\-Initiated SAML Authentication • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/eFGI5mDeWCUC9rCSrUSyYA) #ril

    Prerequisites

      - Enable SAML (Security Assertion Markup Language) authentication and set up the SAML identity providers for your tenant.
      - Get the URLs for the SAML providers where Workday must send AUTHENTICATION REQUESTS (IdP SSO Service URL).
      - Security: Set Up: Tenant Setup - Security domain in the System functional area.

    Context

      - Configure Service Provider (SP)-initiated SAML authentication for your tenant. Workday supports 1 SP-initiated SAML configuration PER ENVIRONMENT.

        這跟 IdP-initiated 很不一樣，因為 Workday 發現使用者未登入時，只能轉往一個地方做驗證。

    Steps

     1. Access the Edit Tenant Setup - Security task.

     2. In the SAML Identity Providers grid for each environment for which you're configuring SP-initiated SAML, consider:

          - SP Initiated

            Select to specify SP-initiated SAML authentication for the environment selected in the Used for Environments field.

            若 SAML Identity Providers 表格就是給 SP-initiated SAML 用的，為什麼還要特別勾這個??

          - Service Provider ID

            Identifies Workday as the service provider in the `Issuer` element in SAML messages sent to the IdP.

            別跟表格中的 Issuer 欄位搞混，那是指 incoming reqest/response 從 IdP 那端來的 issuer。

          - Sign SP-initiated Request

            (Optional) Workday signs authentication request messages with the private key (x509 Private Key Pair). You need to provide the public key to your SAML providers.

            因為 authentication request 沒有實質作用，只是把使用者帶往輸入帳密的頁面，所以才會是 optional??

          - Do Not Deflate SP-initiated Request

            (Optional) If the IdP deflates the authentication request message, select this check box to ensure that Workday doesn't try to deflate the message again. ??

          - Always Require IdP Authentication

            (Optional) Select the check box and an option to require users to reauthenticate even if they already have a session with their IdP. To force reauthentication if your IdP is ADFS 2.0, you must select the Force Authn and RequestedAuthnContext option. ??

          - IdP SSO Service URL

            Enter the URL where Workday sends SAML authentication requests. You can get this information from your SAML provider.

     3. Configure additional settings for SP-initiated SAML. As you complete the task, consider:

          - x509 Private Key Pair

            Select or create the X.509 private key pair that Workday uses to sign SAML sign in and sign out requests. You need to provide the public key to your SAML providers.

          - Authentication Request Signature Method

            Workday requires that you use SHA256 as the method for signing authentication requests if you select the Sign SP-initiated Authentication Request check box.

          - Enable Signature KeyInfo Validation

            (Optional) Workday compares the optional SAML `keyInfo` element (if present) in incoming SAML messages with the stored SAML public key of your tenant. If the values don't match, Workday rejects the authentication request and records an error message on the Signons and Attempted Signons report.

          - Additional Negative Skew (in minutes), Additional Positive Skew (in minutes)

            (Optional) The number of minutes to add to the `NotBefore`/`NotOnOrAfter` time (the current time minus/plus the SKEW TIME) when processing the validity of a SAML assertion.

            Workday enforces a combined maximum of 3 minutes in either direction from the `IssueInstant` of the message and the current Workday server time. Skew is the difference between the Workday server time and your IdP server time.

     4. In the Single Sign-on section, enter SAML redirect URLs.

          - Redirect URLs must use HTTPS. You can:

              - Select the Workday Environment to which these URLs apply. For each environment except Production, you can apply redirect URLs to preview tenants (select the Preview Only check box).

                這裡的 preview 跟名為 preview 的 tenant 無關，但什麼是 preview??

              - Add more rows to set different redirect URLs for each environment.

        實驗發現，尚未登入時會直接收到 302 轉向另一個 URL，跟 SAML message 無關，這跟 SP-initiated 是什麼關係??

        As you complete the task, consider:

          - Redirect Type

            The login redirect, mobile app login redirect, and mobile browser login redirect URLs that Workday uses for SAML SSO.

              - Single URL uses a single authentication option FOR ALL USERS. This option uses the 3 login redirect URLs configured in the adjacent cells of the Redirection URLs grid.

              - Authentication Selector uses the login redirect URLs configured on the selected authentication selector. Select this option if USER GROUPS from your organization use different authentication options to sign in. ??

                If you select Authentication Selector, Workday builds a CUSTOM SIGN-IN PAGE for your tenant based on the authentication selector configuration.

            差別在於所有使用者要一體適用，還是要分群。

          - Login Redirect URL

            (Single URL redirect type only) Enter this URL to redirect users for authentication: https://<workdayhost>/<tenantname>/login-saml2.htmld.

          - Logout Redirect URL

            Enter the URL to redirect users to when they click the Sign Out button.

          - Timeout Redirect URL

            Enter the URL to redirect users to when their Workday session times out. Typically, this URL is the same as the Logout Redirect URL.

          - Mobile App Login Redirect URL

            (Optional - Single URL redirect type only) Enter this URL to redirect users to when they access Workday on iPad, iPhone, or Android: https://<workdayhost>/<tenantname>/login-saml2.htmld. If you don't enter a URL, Workday automatically redirects mobile users to the Sign In to Workday page.

          - Mobile Browser Login Redirect URL

            (Optional - Single URL redirect type only) Enter this URL to redirect users to when they access Workday on a mobile browser: https://<workdayhost>/<tenantname>/login-saml2.htmld. If you don't enter a URL, Workday automatically redirects mobile users to the Sign In to Workday page.

    Result

      - Users can access Workday after successfully authenticating using your SAML provider.

    Next Steps

      - Access the Signons and Attempted Signons report to monitor SAML authentication attempts during a specific time period.

        在啟用 SSO 後的觀察很方便。

  - [Generate SAML Metadata • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/MY3TeKRseKRfx_VFFi4olw)

    Context

      - Workday enables you to generate SAML metadata, so that SAML Service Providers that rely on Workday as a SAML Identity Provider for authentication can be easily configured.

        Workday 自己也可以做為 IdP? Workday 做為公司的 ERP，直接當做 IdP 也是有可能。

    Steps

      - From the related actions menu of a SAML SSO Link or Quicklink, select SAML SSO Link > Generate Metadata. ??

        注意這跟 `Generate Workday SAML Metadata` Task 無關，這是在產生 SP metadata -- Workday 做為 SP 而非 IdP。

    Result

      - This task returns the SAML metadata necessary for the configuration of a SAML Service Provider:

          - SAML entity ID
          - SAML public key
          - URL (and the associated binding) to which unauthenticated user agents are sent

  - [Create or Edit SAML SSO Links • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/_sMK~PTf2v9XEkiRpNfjJQ) #ril

    Prerequisites

      - Configure these settings on the Edit Tenant Setup - Security task:

          - x509 Private Key Pair, which Workday uses to sign the SAML Response sent to your SAML Identity Provider (IdP).
          - Service Provider ID, which Workday uses as the default Issuer ID in all SAML SSO links.

      - Security: Set Up: Tenant Setup - Security domain in the System functional area.

    Context

      - You can create and edit SAML SSO links that use Workday as a SAML IdP to SIGN IN TO OTHER SYSTEMS FROM WORKDAY. Depending on your link configuration, you can also pass contextual data to external systems. Workday supports both SAML 1.1 and SAML 2.0.

        確實是把 Workday 當成 IdP 在用!!

  - [Configure Identity Provider\-Initiated SAML Authentication • Authentication and Security • Reader • Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/1SrUii41GTc5l3k14I02lA) #ril

  - [Tutorial: Azure Active Directory single sign\-on \(SSO\) integration with Workday \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/active-directory/saas-apps/workday-tutorial) (2019-08-20)

      - In this tutorial, you'll learn how to integrate Workday with Azure Active Directory (Azure AD). When you integrate Workday with Azure AD, you can:

          - Control in Azure AD WHO HAS ACCESS to Workday.

            某種程度上的 authorization。

          - Enable your users to be automatically signed-in to Workday with their Azure AD accounts.
          - Manage your accounts in one central location - the Azure portal.

        有趣的是，過程完全沒用到 `Generate Workday SAML Metadata` Task。

    Prerequisites

      - To get started, you need the following items:

          - An Azure AD subscription. If you don't have a subscription, you can get a free account.
          - Workday single sign-on (SSO) enabled subscription.

        Subscription 是 AAD 這邊的說法?

    Scenario description

      - In this tutorial, you configure and test Azure AD SSO in a test environment. Workday supports SP initiated SSO.

    Adding Workday from the gallery

      - To configure the integration of Workday into Azure AD, you need to add Workday from the GALLERY to your list of managed SaaS apps.

         1. Sign in to the Azure portal using either a work or school account, or a personal Microsoft account.
         2. On the left navigation pane, select the Azure Active Directory service.
         3. Navigate to Enterprise Applications and then select All Applications.
         4. To add new application, select New application.
         5. In the Add from the gallery section, type Workday in the search box.
         6. Select Workday from results panel and then add the app. Wait a few seconds while the app is added to your TENANT.

    Configure and test Azure AD single sign-on for Workday

      - Configure and test Azure AD SSO with Workday using a test user called B.Simon. For SSO to work, you need to establish a LINK RELATIONSHIP between an Azure AD user and the related user in Workday.

        這個 link 每個 user 都要手動做??

      - To configure and test Azure AD SSO with Workday, complete the following building blocks:

         1. Configure Azure AD SSO to enable your users to use this feature.

              - Create an Azure AD test user to test Azure AD single sign-on with B.Simon.
              - Assign the Azure AD test user to enable B.Simon to use Azure AD single sign-on.

            只是讓使用者可以用 SSO，但跟 Workday 沒有關係??

         2. Configure Workday to configure the SSO settings on application side.

            Create Workday test user to have a counterpart of B.Simon in Workday that is linked to the Azure AD representation of user.

         3. Test SSO to verify whether the configuration works.

    Configure Azure AD SSO

      - Follow these steps to enable Azure AD SSO in the Azure portal.

         1. In the Azure portal, on the Workday application integration page, find the Manage section and select Single sign-on.
         2. On the Select a Single sign-on method page, select SAML.
         3. On the Set up Single Sign-On with SAML page, click the edit/pen icon for Basic SAML Configuration to edit the settings.

         4. On the Basic SAML Configuration page, enter the values for the following fields:

              - In the Sign-on URL text box, type a URL using the following pattern: `https://impl.workday.com/<tenant>/login-saml2.flex`

                結尾的 `.flex` 是誤植，應該是 `.htmld` ??

              - In the Identifier text box, type a URL using the following pattern: `http://www.workday.com`
              - In the Reply URL text box, type a URL using the following pattern: `https://impl.workday.com/<tenant>/login-saml.htmld`

            Note: These values are not the real. Update these values with the actual Sign-on URL and Reply URL. Your reply URL must have a subdomain for example: `www`, `wd2`, `wd3`, `wd3-impl`, `wd5`, `wd5-impl`). Using something like `http://www.myworkday.com` works but `http://myworkday.com` does not. Contact Workday Client support team to get these values. You can also refer to the patterns shown in the Basic SAML Configuration section in the Azure portal.

            這些值到底在系統的哪裡查得到? 真的只能問客服??

         5. Your Workday application expects the SAML ASSERTIONS in a specific format, which requires you to add CUSTOM ATTRIBUTE MAPPINGS to your SAML token attributes configuration.

            The following screenshot shows the list of default attributes, where as `name` identifier is mapped with `user.userprincipalname`. Workday application expects `name` identifier to be mapped with `user.mail`, UPN, etc., so you need to edit the attribute mapping by clicking on Edit icon and change the attribute mapping.

            ![](https://docs.microsoft.com/en-us/azure/active-directory/saas-apps/common/edit-attribute.png)

            Note: Here we have mapped the Name ID with UPN (`user.userprincipalname`) as default. You need to map the Name ID with actual User ID in your Workday account (your email, UPN, etc.) for successful working of SSO.

            因為 Workday 預期 `name` 是 email，所以要確認 UPN 是不是 email ??

         6. On the Set up Single Sign-On with SAML page, in the SAML Signing Certificate section, find Certificate (Base64) and select Download to download the certificate and save it on your computer.

            這就是 IdP 的 public key，交給 SP 驗證 ??

         7. To modify the Signing options as per your requirement, click Edit button to open SAML Signing Certificate dialog.

            ![](https://docs.microsoft.com/en-us/azure/active-directory/saas-apps/media/workday-tutorial/signing-option.png)

            畫面上有 Signing Option: Sign SAML response and assertion 及 Signing Algorithm: SHA-256。

         8. On the Set up Workday section, copy the appropriate URL(s) based on your requirement.

            ![](https://docs.microsoft.com/en-us/azure/active-directory/saas-apps/common/copy-configuration-urls.png)

            畫面上有：

              - Login URL -- 除做為 Redirection URLs 下的 Login/Redirect/Mobile Redirect URL，也做為 SAML Identity Providers 下的 IdP SSO Service URL。
              - Azure AD Identifier -- 做為 SAML Identity Providers 下的 Issuer
              - Logout URL -- 除做為 Redirection URLs 下的 Logout Redirect URL，也做為 SAML Identity Providers 下的 Logout Response URL。

    Create an Azure AD test user

      - In this section, you'll create a test user in the Azure portal called B.Simon.

         1. From the left pane in the Azure portal, select Azure Active Directory, select Users, and then select All users.
         2. Select New user at the top of the screen.
         3. In the User properties, follow these steps:

              - In the Name field, enter `B.Simon`.
              - In the User name field, enter the `username@companydomain.extension`. For example, `B.Simon@contoso.com`.
              - Select the Show password check box, and then write down the value that's displayed in the Password box.
              - Click Create.

    Assign the Azure AD test user

      - In this section, you'll enable B.Simon to use Azure single sign-on by granting access to Workday.

         1. In the Azure portal, select Enterprise Applications, and then select All applications.
         2. In the applications list, select Workday.
         3. In the app's overview page, find the Manage section and select Users and groups.
         4. Select Add user, then select Users and groups in the Add Assignment dialog.
         5. In the Users and groups dialog, select B.Simon from the Users list, then click the Select button at the bottom of the screen.

         6. If you're expecting any ROLE VALUE in the SAML assertion, in the Select Role dialog, select the appropriate role for the user from the list and then click the Select button at the bottom of the screen.

            這跟 Workday 的 Organization Role 是什麼關係 ??

         7. In the Add Assignment dialog, click the Assign button.

    Configure Workday

     1. In a different web browser window, sign in to your Workday company site as an administrator.
     2. In the Search box search with the name `Edit Tenant Setup – Security` on the top left side of the home page.

     3. In the Redirection URLs section, perform the following steps:

          - Click Add Row.
          - In the Login Redirect URL, Timeout Redirect URL and Mobile Redirect URL textbox, paste the Login URL which you have copied from the Set up Workday section of Azure portal.
          - In the Logout Redirect URL textbox, paste the Logout URL which you have copied from the Set up Workday section of Azure portal.
          - In Used for Environments textbox, select the environment name.

        Note: The value of the Environment attribute is tied to the value of the tenant URL:

          - If the domain name of the Workday tenant URL starts with `impl` for example: https://impl.workday.com/<tenant>/login-saml2.flex), the Environment attribute must be set to Implementation.

            但為什麼 `wd3-impl.workday.com/...` 是 Sandbox ??

          - If the domain name starts with something else, you need to contact Workday Client support team to get the matching Environment value.

     4. In the SAML Setup section, perform the following steps:

          - Select Enable SAML Authentication.
          - Click Add Row.

     5. In the SAML Identity Providers section, perform the following steps:

          - In the Identity Provider Name textbox, type a provider name (for example: `SPInitiatedSSO`).

            為什麼一直強調 SP-initiated ??

          - In the Azure portal, on the Set up Workday section, copy the Azure AD Identifier value, and then paste it into the Issuer textbox.
          - In the Azure portal, on the Set up Workday section, copy the Logout URL value, and then paste it into the Logout Response URL textbox.
          - In the Azure portal, on the Set up Workday section, copy the Login URL value, and then paste it into the IdP SSO Service URL textbox.
          - In Used for Environments textbox, select the environment name.
          - Click Identity Provider Public Key Certificate, and then click Create.
          - Click Create x509 Public Key.

     6. In the View x509 Public Key section, perform the following steps:

          - In the Name textbox, type a name for your certificate (for example: `PPE_SP`).

          - In the Valid From textbox, type the valid from attribute value of your certificate.
          - In the Valid To textbox, type the valid to attribute value of your certificate.

            Note: You can get the valid from date and the valid to date from the downloaded certificate by double-clicking it. The dates are listed under the Details tab.

          - Open your base-64 encoded certificate in notepad, and then copy the content of it.
          - In the Certificate textbox, paste the content of your clipboard.
          - Click OK.

        建立 IdP 提供的 public key ?? 如果是這樣，valid from/to 為何要手動提供?

     7. Perform the following steps:

          - In the Service Provider ID textbox, type `http://www.workday.com`.

            跟 AAD 上 Basic SAML Configuration 的 Identifier 對應。

          - Select Do Not Deflate SP-initiated Authentication Request. ??
          - As Authentication Request Signature Method, select SHA256.
          - Click OK.

        Note: Please ensure you set up single sign-on correctly. In case you enable single sign-on with incorrect setup, you may not be able to enter the application with your credentials and get LOCKED OUT. In this situation, Workday provides a BACKUP LOG-IN URL where users can sign-in using their normal username and password in the following format: `[Your Workday URL]/login.flex?redirect=n`

    Create Workday test user

      - In this section, you create a user called B.Simon in Workday. Work with Workday Client support team to add the users in the Workday platform. Users must be created and activated before you use single sign-on.

    Test SSO

      - When you select the Workday TILE in the Access Panel, you should be automatically signed in to the Workday for which you set up SSO. For more information about the Access Panel, see Introduction to the Access Panel.

## 參考資料 {: #reference }

文件：

  - [Authentication - Administrator Guide](https://doc.workday.com/reader/Z9lz_01hqDMDg6NSf7wCBQ/xeLJBYTXe1Lh2_tVXobgLA)
