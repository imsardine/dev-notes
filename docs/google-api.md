# Google APIs

  - [Google APIs \- Wikipedia](https://en.wikipedia.org/wiki/Google_APIs) #ril

## Authentication ??

  - [Credentials, access, security, and identity \- API Console Help](https://support.google.com/googleapi/answer/6158857?hl=en)

      - Each request to an API that is represented in the console must include a UNIQUE IDENTIFIER. Unique identifiers enable the console to tie requests to SPECIFIC PROJECTS to monitor traffic and enforce QUOTAS.

        這說明了為什麼 Google API 的調用都在某個 project 下，主要是由 unique ID (不同於 project ID) 監控特定 project 下 API 的用量。

      - Google supports two mechanisms for creating unique identifiers:

          - OAuth 2.0 client IDs: For applications that use the OAuth 2.0 protocol to call Google APIs, you can use an OAuth 2.0 client ID to generate an access token. The token contains a unique identifier. See Setting up OAuth 2.0 for more information.

            走 OAuth 2.0 的話，可以拿 client ID 去要 access token，這個 token 裡就帶有 unique identifier。

          - API keys: An API key is a unique identifier that you generate using the console. Using an API key does not require user action or consent. API keys do not grant access to any account information, and are NOT USED FOR AUTHORIZATION. 因為讀不到任何 user data，就沒有授權的問題?

            Use an API key when your application is running on a SERVER and accessing one of the following kinds of data:

              - Data that the data owner has identified as public, such as a public calendar or blog.
              - Data that is owned by a Google service such as Google Maps or Google Translate. (Access limitations might apply.)

            API key 可以在 API console 產生，使用時不需要使用者介入或同意 (consent)，也因為無關 authorization 的關係，只能存取公開資料，例如被公開的 calendar、blog，或是 Google 所擁有的服務 (Google Maps、Google Translate 等)，但會有 access limitation。

      - If you're calling only APIs that do not require USER DATA, such as the Google Custom Search API, then API keys might be simpler to use than OAuth 2.0 access tokens. However, if your application already uses an OAuth 2.0 access token, then there is no need to generate an API key as well. Google IGNORES passed API keys if a passed OAuth 2.0 access token is already associated with the corresponding project.

        如果不需要存取 (未公開的) user data，用 API key 會比 OAuth 2.0 簡單，不過一旦用了 OAuth 2.0 access token，就不用額外提供 API key 了，因為 request 同時帶有 OAuth 2.0 access token 與 API key 時，若 access token 已經可以找到對應的 project (監控流量才是目的)，就會直接略過 API key。

        若要存取 user data 但使用者無法介入同意怎麼辦？這時候就得用 Service Account，也是 OAuth 2.0 的一種應用。

      - Note: You must use EITHER an OAuth 2.0 access token or an API key for all requests to Google APIs represented in the API Console. Not all APIs require authorized calls. To learn whether authorization is required for a specific call, refer to the documentation for the API you're using.

## Service Account ??

  - [Using OAuth 2\.0 for Server to Server Applications  \|  Google Identity Platform  \|  Google Developers](https://developers.google.com/identity/protocols/OAuth2ServiceAccount) #ril

      - Important: If you are working with Google Cloud Platform, unless you plan to build your own client library, use service accounts and a Cloud Client Library instead of performing authorization explicitly as described in this document. For more information, see Authentication Overview in the Google Cloud Platform documentation.

        如果程式是執行在 GCP 上，就要採用 [Cloud Client Library](https://cloud.google.com/apis/docs/cloud-client-libraries)，以 Python 而言，GCP 用的 [googleapis/google-cloud-python](https://github.com/googleapis/google-cloud-python) 就跟這裡講的 [googleapis/google-api-python-client](https://github.com/googleapis/google-api-python-client) 不同。

      - The Google OAuth 2.0 system supports SERVER-TO-SERVER INTERACTIONS such as those between a web application and a Google service. For this scenario you need a SERVICE ACCOUNT, which is an account that BELONGS TO YOUR APPLICATION instead of to an individual end user. Your application calls Google APIs ON BEHALF OF THE SERVICE ACCOUNT, so users aren't directly involved.

        This scenario is sometimes called "TWO-LEGGED OAuth," or "2LO." (The related term "three-legged OAuth" refers to scenarios in which your application calls Google APIs ON BEHALF OF END USERS, and in which USER CONSENT is sometimes required.)

        3LO 跟 2LO 最大的差別是 on behalf of end user 或 of service account，代表 application 或是特定的 end user。

      - Typically, an application uses a service account when the application uses Google APIs to work with ITS OWN DATA rather than a USER'S DATA. For example, an application that uses Google Cloud Datastore for data persistence would use a service account to authenticate its calls to the Google Cloud Datastore API.

        不過若 user's data 有分享給 service account，也可以讀得到特定的 user's data。

      - G Suite domain administrators can also grant service accounts DOMAIN-WIDE AUTHORITY to access user data on behalf of users in the domain.

        就不用一項項資源分享了??

      - This document describes how an application can complete the server-to-server OAuth 2.0 FLOW by using either a [Google APIs client library](https://developers.google.com/api-client-library/) (recommended) or HTTP.
      - With some Google APIs, you can make authorized API calls using a signed JWT instead of using OAuth 2.0, which can SAVE?? you a network request. See Addendum: Service account authorization without OAuth. 以為 JWT 也是 OAuth 的一種應用??

    Overview

      - To support server-to-server interactions, first create a service account for your project in the API Console. If you want to access user data for users in your G Suite domain, then delegate domain-wide access to the service account.

      - Then, your application prepares to make authorized API calls by using the service account's CREDENTIALS to request an ACCESS TOKEN from the OAuth 2.0 auth server. Finally, your application can use the access token to call Google APIs. Finally, your application can use the access token to call Google APIs.

        雖然 OAuth flow 不同一般使用者，但還是要拿 credential 換 access token，或許這跟上面的 "save you a network request" 有關??

      - Recommendation: Your application can complete these tasks either by using the Google APIs client library for your language, or by directly interacting with the OAuth 2.0 system using HTTP. However, the mechanics of server-to-server authentication interactions require applications to create and cryptographically sign JSON Web Tokens (JWTs), and it's easy to make serious errors that can have a severe impact on the security of your application. ??

        For this reason, we strongly encourage you to use libraries, such as the Google APIs client libraries, that abstract the cryptography away from your application code. 不要自己處理認證加解密的部份，不過 HTTP/REST 有助於理解背後的運作方式，背後都是 JWT 的樣子 #ril

  - [Preparing to make an authorized API call (Python) - Using OAuth 2\.0 for Server to Server Applications  \|  Google Identity Platform  \|  Google Developers](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#authorizingrequests) #ril

      - After you obtain the CLIENT EMAIL address and PRIVATE KEY from the API Console, use the [Google APIs Client Library for Python](https://developers.google.com/api-client-library/python/) (`google-api-python-client`) to complete the following steps:

        為 service account 建立 credentials 會拿到 service account's credentials (在 API 裡叫 service account file)，上面 "client email" 跟 "private key" 的說法都會出現在裡面：

            {
              "type": "service_account",
              "project_id": "my-project",
              "private_key_id": "0123456789abcdef0123456789abcdef01234567",
              "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
              "client_email": "account-name@my-project.iam.gserviceaccount.com",
              "client_id": "123456789123456789123",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/account-name%40my-project.iam.gserviceaccount.com"
            }

      - Create a Credentials object from the service account's credentials and the SCOPES your application needs access to. For example:

        其中 scope 為什麼不是在建立 service account 的時候給?? 有可接受的值要去哪裡查??

            from google.oauth2 import service_account

            SCOPES = ['https://www.googleapis.com/auth/sqlservice.admin']
            SERVICE_ACCOUNT_FILE = '/path/to/service.json'

            credentials = service_account.Credentials.from_service_account_file(
                    SERVICE_ACCOUNT_FILE, scopes=SCOPES)

        Use the `Credentials` object to call Google APIs in your application.

        If you are developing an app on Google Cloud Platform, you can use the application DEFAULT CREDENTIALS instead, which can simplify the process. 難怪一開始講 GCP 建議改用 Cloud Client Library，畢竟執行在 GCP 裡，驗證的方式可以不用像在外部那麼麻煩。

        注意 `google.oauth2` 是來自 [Google Auth Library for Python (`google-auth`)](google-auth.md)，專注在 authentication，是 [API Client Library for Python (`google-api-python-client`)](google-api-python-client.md) [相依的套件之一](https://github.com/googleapis/google-api-python-client/blob/v1.7.8/setup.py#L43)，後者才真正跟 Google API 的操作有關。

    Delegate domain-wide authority

      - If you have delegated domain-wide access to the service account and you want to IMPERSONATE a user account, use the `with_subject` method of an existing `ServiceAccountCredentials` object. For example:

            delegated_credentials = credentials.with_subject('user@example.org')

  - [Calling Google APIs (Python) - Using OAuth 2\.0 for Server to Server Applications  \|  Google Identity Platform  \|  Google Developers](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#callinganapi)

    Use the authorized `Credentials` object to call Google APIs by completing the following steps:

     1. Build a SERVICE OBJECT for the API that you want to call. You build a a service object by calling the `build` function with the name and version of the API and the authorized `Credentials` object. For example, to call version 1beta3 of the Cloud SQL Administration API:

            import googleapiclient.discovery

            sqladmin = googleapiclient.discovery.build('sqladmin', 'v1beta3', credentials=credentials)

     2. Make requests to the API service using the INTERFACE provided by the service object. For example, to list the instances of Cloud SQL databases in the exciting-example-123 project:

            response = sqladmin.instances().list(project='exciting-example-123').execute() # 前面都在組 request，最後 execute() 才真的送出

        要去哪裡查不同 service object 的用法??

  - API Console > Credentials > Create credentials 有 3 種選項 -- API key、OAuth client ID 及 Service account key (Enable server-to-server, app-level authentication using robot accounts)。
  - [Create The Authentication Credentials - How to authenticate to any Google API](https://flaviocopes.com/google-api-authentication/#create-the-authentication-credentials) (2018-05-11)
      - 有 3 種方式可以驗證 -- OAuth 2、Service to Service 及 API key；API key 比較不安全且範圍受限，OAuth 2 是代表使用者送出要求 (make requests on behalf of a user)，較為複雜且需要有公開的 URL 處理 callback，至於 service to service 則是讓 application 透過 service account 跟 Google API 對話 (利用 JSON Web Token)，也是 server-side application 最簡單的方式。
      - 首先要產生 JSON key file；在 Create credentials 選 Service account key，在 key type 處選 JSON；新建 service account 時要給 account name (用途)、role (role-based access to the project)，會自動產生 service account ID (`<account_name>@<projec_id>.iam.gserviceaccount.com`，其實是 service account 的 email)，按下 Create 時會下載 key file (內含 private key)。
      - Service account 的 role 要怎麼選?? Service Accounts > Service Account User (Run operations as the service account) 好像是最接近的? 這份文件選 Monitoring Admin，但 下面的範例用 Analytics API，還有可存取 Google Drive API?
  - [juampynr/google\-spreadsheet\-reader: Reads data from a Google Spreadsheet that requires authentication](https://github.com/juampynr/google-spreadsheet-reader) 將 sheet 分享給 service account ID (email) 即可!! PHP 程式透過 application default credentials 的機制，參考環境變數 `GOOGLE_APPLICATION_CREDENTIALS` 指向的 service account (private key) file。

  - [Understanding Service Accounts  \|  Cloud Identity and Access Management Documentation  \|  Google Cloud](https://cloud.google.com/iam/docs/understanding-service-accounts) #ril
  - [How to authenticate to any Google API](https://flaviocopes.com/google-api-authentication/) 也提到 Service to Service #ril

## OAuth 2.0 ??

  - [Setting up OAuth 2\.0 \- API Console Help](https://support.google.com/googleapi/answer/6158849) #ril
      - 首先要有 OAuth 2.0 client ID，用來拿 access token。
      - 到 API Console > Credentials，按 Create credentials 選 OAuth client ID；
  - [Using OAuth 2\.0 to Access Google APIs  \|  Google Identity Platform  \|  Google Developers](https://developers.google.com/identity/protocols/OAuth2) #ril

## API Key ??

  - [Setting up API keys \- API Console Help](https://support.google.com/googleapi/answer/6158862) #ril
  - [Best practices for securely using API keys \- API Console Help](https://support.google.com/googleapi/answer/6310037) #ril

## 參考資料 {: #reference }

  - [Google API Console](https://console.developers.google.com/apis/)
  - [API Dashboard - Google Cloud Platform](https://console.cloud.google.com/apis/dashboard)
  - [Google APIs - GitHub](https://github.com/googleapis)

更多：

  - [Python Client](google-api-python-client.md)

