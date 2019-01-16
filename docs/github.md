# GitHub

## Deploy Key, Machine User, Personal Access Token ??

  - [Building User and Organization Pages sites - User, Organization, and Project Pages \- User Documentation](https://help.github.com/articles/user-organization-and-project-pages/#building-user-and-organization-pages-sites) 提到 Deploy keys aren't supported for Organization Pages sites，要改用 machine users。
  - [Deploy keys - Managing deploy keys \| GitHub Developer Guide](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys)
      - An SSH key that grants access to a SINGLE REPOSITORY. GitHub attaches the public part of the key directly to your repository instead of a personal user account, and the private part of the key remains on your server. 一把專為 build job 產生的 key pair。
      - Deploy keys with WRITE ACCESS can perform the same actions as an organization member with admin access, or a collaborator on a personal repository. 在新增 deploy key 時，要勾選 "Allow write access" (Can this key be used to push to this repository? Deploy keys always have pull access.)，這大概是帳號 SSH key 跟 repository 的 deploy key 最大的不同，後者可以限制 write access。
      - Deploy keys only grant access to a single repository. More complex projects may have many repositories to pull to the same server. 例如有 submodule 時? 多個 project 可以用同一個 deploy key??
      - Deploy keys are usually not protected by a PASSPHRASE, making the key easily accessible if the server is compromised. 是應該要保護。
  - [Machine Users - Managing deploy keys \| GitHub Developer Guide](https://developer.github.com/v3/guides/managing-deploy-keys/#machine-users)
      - If your server needs to access MULTIPLE REPOSITORIES, you can create a new GitHub account and attach an SSH key that will be USED EXCLUSIVELY FOR AUTOMATION. Since this GitHub account won't be used by a human, it's called a machine user. 就當成是是一般的 user 來用，但就無法像 deploy key 一樣限制其 write access (只有 organization 可以)。
      - 好處是 Multiple keys are not needed; one per server is adequate.
      - 主要的問題跟 deploy key 一樣，Machine user keys, like deploy keys, are usually not protected by a passphrase. 是因為 CI 通常不支援受密碼保護的 key??
  - [Creating a personal access token for the command line \- User Documentation](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)
      - You can create a personal access token and use it IN PLACE OF A PASSWORD when performing Git operations over HTTPS with Git on the command line or the API. 取代走 HTTPS 時會用到的 password，所以也要像密碼一樣小心保存。
      - 提到啟用 2FA 時一定要用 personal access token；但這跟 SSH 無關，因為 SSH 是走 SSH key 而非密碼，這呼應了下面 "Personal access tokens can only be used for HTTPS Git operations. If your repository uses an SSH remote URL, you will need to switch the remote from SSH to HTTPS." 的說法。
      - Personal access token 在 Settings > Developer settings > Personal access tokens 下設定，比較特別的是 Select scopes 可以控制到很細，除了 repo (Full control of private repositories) 外，還有其他 admin 的控制；應該是因為 personal access token 也用在 GitHub API 的關係，不像 deploy key 是針對 repo 內容的讀寫。

## Two-Factor Authentication (2FA) ??

  - [Securing your account with two\-factor authentication \(2FA\) \- User Documentation](https://help.github.com/articles/securing-your-account-with-two-factor-authentication-2fa/) #ril
  - [About Two\-Factor Authentication \- User Documentation](https://help.github.com/articles/about-two-factor-authentication/)
      - 2FA 是指除了 password 之外，還要提供另一項資訊；2FA 可以用在 GitHub website、GitHub API 與 GitHub Desktop；跟 SSH key 存取 repo 無關
      - 就 GitHub 而言，另一項資訊可以是由手機上的 app 產生，也可以是透過 SMS 收到。
  - [When you'll be asked for your SSH key passphrase as a password - Providing your 2FA authentication code \- User Documentation](https://help.github.com/articles/providing-your-2fa-authentication-code/#when-youll-be-asked-for-your-ssh-key-passphrase-as-a-password) 透過 SSH URL 存取 repo 時，要輸入的是 SSH key passphrase 而非 2FA code (跟 2FA 無關)；若是走 HTTPS URL 的話，就要輸入 personal access token。
  - [Providing your 2FA authentication code \- User Documentation](https://help.github.com/articles/providing-your-2fa-authentication-code/) #ril
      - 啟用 2FA 後，存取 GitHub 除了要提供 password，還會被問 2FA authentication code -- 依設定不同，authentication code 可能由手機上的 app 產生，也可能由 SMS 傳送過來。
      - 如果 authentication code 多次驗證失敗，有可能是手機的時間不對。
  - [Requiring two\-factor authentication in your organization \- User Documentation](https://help.github.com/articles/requiring-two-factor-authentication-in-your-organization/) 從 organization 的層級要求 2FA，沒有啟用 2FA 的人會從 organization 被移除，要啟用 2FA 並重新接受 invitation 才能回到 organization #ril
  - 啟用 2FA 時，要選 Set up using an app 或 Set up using SMS。
      - 按下 Set up using an app 後會提示 16 組 recovery code -- 收不到 authentication code 時可以用，建議存到 password manager (例如 Lastpass、1Password、Keeper 等)。
      - 安裝 Google Authenticator，掃描條碼就可以新增一個帳戶並取得 authentication code，輸入後即可完成 2FA 啟用。
  - [Configuring two\-factor authentication via a TOTP mobile app \- User Documentation](https://help.github.com/articles/configuring-two-factor-authentication-via-a-totp-mobile-app/) SMS 在美國以外可能收不到 #ril

## Search ??

  - [Searching code \- User Documentation](https://help.github.com/articles/searching-code/) #ril
