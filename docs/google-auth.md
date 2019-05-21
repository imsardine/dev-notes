# Google Auth Library for Python (`google-auth`)

  - [google\-auth — google\-auth 1\.5\.1 documentation](https://google-auth.readthedocs.io/en/latest/index.html)
      - Provides the ability to authenticate to Google APIs using VARIOUS METHODS. It also provides integration with several HTTP libraries.
      - 從 Support for Google ... credentials 看來，各平台驗證的方式都不太一樣，但就技術上而言都是要帶一些 HTTP headers，而這個 library 都將其視為概念上的 credentials。
  - [User Guide — google\-auth 1\.5\.1 documentation](https://google-auth.readthedocs.io/en/latest/user-guide.html) 先取 credentials，再 make authenticated requests #ril
      - `Credentials` 是識別 application/user 的手段，可以從 service account 或 user account 取得。
      - 根據 service account 取得的 credentials 用於 server-to-server use case，例如存取資料庫，這個 library 主要用來取得 service account credentials。
      - 根據 user account 取得 credentials，要尋問使用者的意思 (asking the user to authorize access to their data)，用於 application 需要存取另一個服務中的 user data (例如 Google Drive 中的文件)。但最後又說 "provides no support for obtaining user credentials"??

## 新手上路 ?? {: #getting-started }

  - [User Guide — google\-auth 1\.5\.1 documentation](https://google-auth.readthedocs.io/en/latest/user-guide.html) 先取 credentials，再 make authenticated requests #ril

## 參考資料 {: #reference }

  - [google-auth - Read the Docs](https://google-auth.readthedocs.io/en/latest/)
  - [googleapis/google-auth-library-python - GitHub](https://github.com/googleapis/google-auth-library-python)
  - [google-auth - PyPI](https://pypi.org/project/google-auth/)

文件：

  - [google-auth Documentation](https://google-auth.readthedocs.io/en/latest/)
