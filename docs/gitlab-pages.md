---
title: GitLab / Pages
---
# [GitLab](gitlab.md) / Pages

  - [Websites for your GitLab projects, user account or group \| GitLab](https://about.gitlab.com/product/pages/) #ril
      - Websites for your GitLab projects, groups, or user account. 都忘了 pages 可以用在 project 以外的地方，一樣支援各式 static website generator。
      - Connect your custom domain(s) and TLS certificates. 就算在公司內，好像也有這個需求?

## Hello, World!

  - [GitLab Pages examples / gitbook · GitLab](https://gitlab.com/pages/gitbook) #ril

## Getting Started

  - [Step 1 ~ 5 - Websites for your GitLab projects, user account or group \| GitLab](https://about.gitlab.com/features/pages/#step-1)
      - 從 [GitLab Pages examples · GitLab](https://gitlab.com/pages) 開始 -- 為許多 static website generator 提供不同的 example repo，但沒有 MkDocs 的；以 [GitBook](https://gitlab.com/pages/gitbook/blob/master/.gitlab-ci.yml) 為例，也是走 `artifacts:paths` 的設定，沒什麼特別? => 關鍵是 `pages` 這個 job name -- "the 'pages' job will deploy and build your site to the 'public' path"，會將 artifacts 發佈成網站。但搭配 `expire_in:` 是怎麼回事??
      - Step 3: 網站預設會在 https://username.gitlab.io/projectname 看到，這就是所謂的 project page；若將 project name 改成 `username.gitlab.io`，就會出現在 `https://username.gitlab.io`，這就是所謂的 user page；若 GitLab 是自家代管，其中 `gitlab.io` 要跟著換成對應的 pages servers。
  - [Getting Started - GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/#getting-started) #ril
      - How it works 提到 GitLab will always deploy your website from a very specific folder called `public` in your repository. 但還是得透過 CI/CD (`.gitlab-ci.yml`) 發佈，不論 project 本身是 public/internal/private。
      - 3. Visit your project's Settings > Pages to see your website link 像是 Congratulations! Your pages are served under: ... 這項資訊是成功發佈 GitLab pages 才會有的。
  - [GitLab Pages requirements - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#gitlab-pages-requirements) #ril
  - [Projects for GitLab Pages and URL structure \| GitLab](https://docs.gitlab.com/ee/user/project/pages/getting_started_part_two.html) #ril
  - [Creating and Tweaking GitLab CI/CD for GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/getting_started_part_four.html) #ril

## .gitlab-ci.yml

  - [pages - Configuration of your jobs with \.gitlab\-ci\.yml \| GitLab](https://docs.gitlab.com/ee/ci/yaml/README.html#pages) #ril
    - `pages` is a special job that is used to upload static content to GitLab that can be used to serve your website. It has a special syntax, so the two requirements below must be met: 1) Any static content must be placed under a `public/` directory 2) artifacts with a path to the `public/` directory must be defined。
    - 除了 job name 一定要取做 `pages` 外，網站內容除了要在 artifacts 裡，也只看 `public/` 的內容。從範例看來，`artifacts` 不支援檔案進 artifacts 時更名，要自己做 rename；實驗發現，若 artifacts 裡找不到 `public/`，`pages` job 自動帶出的 `pages:deploy` job 就會失敗 -- `pages failed to extract`
  - [The public directory - Creating and Tweaking GitLab CI/CD for GitLab Pages \| GitLab](https://docs.gitlab.com/ce/user/project/pages/getting_started_part_four.html#the-public-directory) #ril
  - `pages` job 特別的地方在於 artifacts 會被視為 GitLab pages 的內容，當然可以把產生 documentation 的工作拆出去 做為 build stage，但併入 `pages` job 並做為 deploy stage 的一部份，似乎比較直覺，況且 `pages` job 若沒有 `script:`，會遇到 `jobs:pages script can't be blank` 的錯誤。

參考資料：

  - [Explore the contents of .gitlab-ci.yml - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#explore-the-contents-of-gitlab-ci-yml) #ril

## Project Structure

  - 如何維持多個版本的文件??
  - [How to set up GitLab Pages in a repository where there's also actual code - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#how-to-set-up-gitlab-pages-in-a-repository-where-there-s-also-actual-code) #ril

## Project Pages

  - [Project Pages - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#project-pages) #ril
  - [Project Websites - Static sites and GitLab Pages domains \| GitLab](https://docs.gitlab.com/ee/user/project/pages/getting_started_part_one.html#project-websites) #ril

## User/Group Pages

  - [User or group pages - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#user-or-group-pages) #ril
  - [User and Group Websites - Static sites and GitLab Pages domains \| GitLab](https://docs.gitlab.com/ee/user/project/pages/getting_started_part_one.html#user-and-group-websites) #ril

## Reporting

  - [`artifacts:reports:junit` - Configuration of your jobs with \.gitlab\-ci\.yml \| GitLab](https://docs.gitlab.com/ee/ci/yaml/README.html#artifacts-reports-junit) #ril
  - [Publish code coverage report with GitLab Pages \| GitLab](https://about.gitlab.com/2016/11/03/publish-code-coverage-report-with-gitlab-pages/) (2016-11-03) #ril
  - [JUnit test reports \| GitLab](https://docs.gitlab.com/ee/ci/junit_test_reports.html) #ril

## 403, 404 Error

  - [Custom error codes pages - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#custom-error-codes-pages) #ril

## Compressed Assets

  - [Serving compressed assets - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#serving-compressed-assets) #ril

## Redirection

  - [Redirects in GitLab Pages - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#redirects-in-gitlab-pages) #ril

## Custom Domain

  - [GitLab Pages domain - Static sites and GitLab Pages domains \| GitLab](https://docs.gitlab.com/ee/user/project/pages/getting_started_part_one.html#gitlab-pages-domain) #ril
      - 最後 General example: 提到 On your GitLab instance, replace `gitlab.io` above with your Pages server domain. Ask your sysadmin for this information.
  - [GitLab Pages custom domains and SSL/TLS Certificates \| GitLab](https://docs.gitlab.com/ee/user/project/pages/getting_started_part_three.html) #ril
  - [Add a custom domain to your Pages website - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#add-a-custom-domain-to-your-pages-website) #ril
  - [Getting started with GitLab Pages domains - Exploring GitLab Pages \| GitLab](https://docs.gitlab.com/ee/user/project/pages/introduction.html#getting-started-with-gitlab-pages-domains) #ril

## Access Control

  - [GitLab Pages access control \| GitLab](https://docs.gitlab.com/ee/user/project/pages/pages_access_control.html)

      - You can enable Pages access control on your project if your administrator has enabled the access control feature on your GitLab instance. When enabled, only members of your project (at least Guest) can access your website:

         1. Navigate to your project’s Settings > General and expand Visibility, project features, permissions.

         2. Toggle the Pages button to enable the access control. If you don’t see the toggle button, that means it isn’t enabled. Ask your administrator to enable it.

         3. The Pages access control dropdown allows you to set who can view pages hosted with GitLab Pages, depending on your project’s visibility:

            If your project is private:

              - Only project members: Only project members are able to browse the website.

              - Everyone: Everyone, both logged into and logged out of GitLab, is able to browse the website, no matter their project membership.

            If your project is internal:

              - Only project members: Only project members are able to browse the website.
              - Everyone with access: Everyone logged into GitLab is able to browse the website, no matter their project membership.
              - Everyone: Everyone, both logged into and logged out of GitLab, is able to browse the website, no matter their project membership.

            If your project is public:

              - Only project members: Only project members are able to browse the website.
              - Everyone with access: Everyone, both logged into and logged out of GitLab, is able to browse the website, no matter their project membership.

        注意 "Everyone with access" 在 public & internal project 下有不同的解釋，前者不用登入，後者至少要登入；但為何 private project 少了 "Everyone with access" 這層控制，直接跳到 "Everyone" 全開? 搭配 [Disable public access to all Pages sites](https://docs.gitlab.com/ee/administration/pages/index.html#disable-public-access-to-all-pages-sites) 似乎可以做到只公開給登入使用者的效果?

        Click Save changes. Note that your changes may not take effect immediately. GitLab Pages uses a caching mechanism for efficiency. Your changes may not take effect until that cache is invalidated, which usually takes less than a minute.

    Terminating a Pages session

      - To sign out of your GitLab Pages website, revoke the application access token for GitLab Pages:

         1. In the top menu, select your profile, and then select ~~Settings~~ Preferences.
         2. On the left sidebar, select Applications.
         3. Scroll to the Authorized applications section, find the GitLab Pages entry, and select its Revoke button.

  - [Access Control - GitLab Pages administration \| GitLab](https://docs.gitlab.com/ee/administration/pages/index.html#access-control) #ril

    Access Control

      - Introduced in GitLab 11.5.
      - GitLab Pages access control can be configured PER-PROJECT, and allows access to a Pages site to be controlled based on a user’s membership to that project.

      - Access control works by registering the PAGES DAEMON AS AN OAUTH APPLICATION with GitLab. Whenever a request to access a private Pages site is made by an unauthenticated user, the Pages daemon redirects the user to GitLab.

        If authentication is successful, the user is redirected back to Pages with a token, which is persisted in a cookie. The cookies are signed with a secret key, so tampering can be detected.

      - Each request to view a resource in a private site is authenticated by Pages using that token. FOR EACH REQUEST it receives, it makes a request to the GitLab API to check that the user is authorized to read that site.

      - Pages access control is disabled by default. To enable it:

         1. Enable it in `/etc/gitlab/gitlab.rb`:

            gitlab_pages['access_control'] = true

         2. Reconfigure GitLab.

         3. Users can now configure it in their projects’ settings.

        For this setting to be effective with MULTI-NODE SETUPS, it has to be applied to all the App nodes and Sidekiq nodes.

    Using Pages with reduced authentication scope

      - Introduced in GitLab 13.10.

      - By default, the Pages daemon uses the `api` scope to authenticate. You can configure this. For example, this reduces the scope to read_api in `/etc/gitlab/gitlab.rb`:

            gitlab_pages['auth_scope'] = 'read_api'

        什麼情況下要改 scope??

      - The scope to use for authentication must match the GitLab Pages OAuth application settings. Users of pre-existing applications must modify the GitLab Pages OAuth application. Follow these steps to do this:

         1. Enable access control.
         2. On the top bar, select Menu > Admin.
         3. On the left sidebar, select Settings > Applications.
         4. Expand GitLab Pages.
         5. Clear the `api` scope’s checkbox and select the desired scope’s checkbox (for example, `read_api`).
         6. Select Save changes.

        為什麼 Admin > Applications 下會有 GitLab Pages??

    Disable public access to all Pages sites

      - Introduced in GitLab 12.7.
      - You can ENFORCE Access Control for all GitLab Pages websites hosted on your GitLab instance. By doing so, ONLY LOGGED-IN USERS have access to them. This setting OVERRIDES Access Control set by users in individual projects.

      - This can be useful to preserve information published with Pages websites to the users of your instance only. To do that:

          - On the top bar, select Menu > Admin.
          - On the left sidebar, select Settings > Preferences.
          - Expand Pages.
          - Select the Disable public access to Pages sites checkbox.
          - Select Save changes.

        For self-managed installations, all public websites remain private until they are redeployed. Resolve this issue by sourcing domain configuration from the GitLab API.

  - [Pages Access Control \- YouTube](https://www.youtube.com/watch?v=tSPAr5mQYc8) #ril

## 參考資料 {: #reference }

  - [GitLab Pages](https://about.gitlab.com/features/pages/)

文件：

  - [GitLab Pages | GitLab](https://docs.gitlab.com/ee/user/project/pages/)
