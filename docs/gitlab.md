# GitLab

  - [GitLab \- Wikipedia](https://en.wikipedia.org/wiki/GitLab) #ril

  - [GitLab Pricing \| GitLab](https://about.gitlab.com/pricing/#gitlab-com) #ril
      - 可以用 Google、Twitter、GitHub、Bitbucket 帳戶登入。
      - Free plan 只限制每個 group 每月只能用 2000 CI pipeline minutes (執行在 shared runner 上)，可以有不限數量的 private project 跟 collaborator；一個人可以有多個 group??

## Notification

  - [GitLab Notification Emails \| GitLab](https://docs.gitlab.com/ee/user/profile/notifications.html)

      - GitLab Notifications allow you to stay informed about what’s happening in GitLab. With notifications enabled, you can receive updates about activity in issues, merge requests, and epics. Notifications are sent via email.

    Receiving notifications

      - You will receive notifications for one of the following reasons:

          - You participate in an issue, merge request, or epic. In this context, PARTICIPATE means comment, or edit.

            被 mention 到也算；下面 Issue / Epics / Merge request events 對 participant 有更精確的定義。

          - You enable notifications in an issue, merge request, or epic. To enable notifications, click the Notifications toggle in the sidebar to on.

      - While notifications are enabled, you will receive notification of actions occurring in that issue, merge request, or epic.

        這是預設的情況，因為 notification level 可以調成 On mention，只有明確明確被提及時才會收到通知。

    Tuning your notifications

      - The quantity of notifications can be OVERWHELMING. GitLab allows you to tune the notifications you receive. For example, you may want to be notified about all activity in a specific project, but for others, only be notified when you are mentioned by name.

        可以依 group/project 分開設定。

      - You can tune the notifications you receive by COMBINING your notification settings:

          - Global notification settings
          - Notification scope
          - Notification levels

    Editing notification settings

      - To edit your notification settings:

          - Click on your profile picture and select Settings.
          - Click Notifications in the left sidebar.
          - Edit the desired notification settings. Edited settings are automatically saved and enabled.
          - These notification settings apply only to you. They do not affect the notifications received by anyone else in the same project or group.

        這就是 Global notification settings。

    Global notification settings

      - Your Global notification settings are the default settings unless you select different values for a project or a group.

          - Notification email

            This is the email address your notifications will be sent to.

          - Global notification level

            This is the default notification level which applies to all your notifications.

          - Receive notifications about your own activity.

            Check this checkbox if you want to receive notification about your own activity. Default: Not checked.

    Notification scope

      - You can tune the scope of your notifications by selecting different notification levels for each project and group.

      - Notification scope is applied in order of precedence (highest to lowest):

          - Project

            For each project, you can select a notification level. Your project setting overrides the group setting.

          - Group

            For each group, you can select a notification level. Your group setting overrides your default setting.

          - Global (default)

            Your global, or default, notification level applies if you have not selected a notification level for the project or group in which the activity occurred.

    Group notification email address

      - You can select an email address to receive notifications for each group you belong to. This could be useful, for example, if you work freelance, and want to keep email about CLIENTS’ PROJECTS separate.

        Introduced in GitLab 12.0

        這情況在 GitLab.com 上才會有需要。

    Notification levels

      - For each project and group you can select one of the following levels:

          - Global: Your global settings apply.
          - Watch: Receive notifications for any activity.
          - On mention: Receive notifications when `@mentioned` in comments.

          - Participate: Receive notifications for THREADS you have participated in.

            這裡的 thread 指的是 comment thread ??

          - Disabled: Turns off notifications.
          - Custom: Receive notifications for custom selected events.

    Issue / Epics / Merge request events

      - In most of the below cases, the notification will be sent to:

          - PARTICIPANTS:

              - the author and assignee of the issue/merge request

                包含 author 不一定合適，因為可能幫別人回報問題；可以在 description 裡另外安排 Reporter。

              - authors of comments on the issue/merge request

                講過話，就算加入了。

              - anyone mentioned by `@username` in the TITLE OR DESCRIPTION of the issue, merge request or epic

                出現在 title/description 就是必然的 stakeholder。

              - anyone with notification level “Participating” or higher that is mentioned by `@username` in any of the comments on the issue, merge request, or epic ??

          - Watchers: users with notification level “Watch”

          - Subscribers: anyone who MANUALLY subscribed to the issue, merge request, or epic

            明確啟用 issue 的 notification??

          - Custom: Users with notification level “custom” who turned on notifications for any of the events present in the table below

      - In addition, if the TITLE OR DESCRIPTION of an Issue or Merge Request is changed, notifications will be sent to any NEW MENTIONS by `@username` AS IF they had been mentioned in the original text.

        這個設計很棒，如果後來才發現某個人一開始就該知道這整件事，加個 mention 就可以了；不過修改 comment 補上 mention 並沒有這樣的效果。

      - You won’t receive notifications for Issues, Merge Requests or Milestones created by yourself (except when an issue is due). You will only receive automatic notifications when somebody else comments or adds changes to the ones that you’ve created or mentions you.

      - If an open merge request becomes unmergeable due to conflict, its author will be notified about the cause. If a user has also set the merge request to AUTOMATICALLY MERGE?? once pipeline succeeds, then that user will also be notified.

## 安裝設置 {: #setup }

### 如何安裝 GitLab CE?

  - Installation methods for GitLab | GitLab https://about.gitlab.com/installation/ 推薦用 Omnibus package?? 除 Ubuntu、Debian、CentOS 6/7 還有 Respberry Pi 2、Docker #ril

### 如何在 Ubunut 上安裝 GitLab CE?

```
$ sudo apt-get install ca-certificates curl openssh-server # postfix 不一定要裝?
$ cd /tmp && curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh
$ sudo bash /tmp/script.deb.sh # 主要是設定 GitLab 的 repository
$ sudo apt-get install gitlab-ce
... GitLab was unable to detect a valid hostname for your instance...
$ # 手動修改 `/etc/gitlab/gitlab.rb` 裡的 `external_url` (先改成 IP)
$ sudo gitlab-ctl reconfigure # 完成初始化
```

一開始存取時，會出現 "Please create a password for your new account" 的提示，其實是要修改 `root` 的密碼。

或許是因為沒安裝 postfix 的關係，新增使用者也無法自訂密碼 (無法寄出信件)，等同於無法新增使用者。

參考資料：

  - How To Install and Configure GitLab on Ubuntu 16.04 | DigitalOcean (2016-10-14) https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-gitlab-on-ubuntu-16-04 安裝步驟可行，只是少了調整 `external_url` 的動作。
  - Installation methods for GitLab | GitLab https://about.gitlab.com/installation/#ubuntu 針對 GitLab EE，安裝 `gitlab-ee` 時會先設定 `EXTERNAL_URL`。

## 如何匯入 GitHub 的專案?

  - 將 GitHub 專案 clone 到本地端。
  - 增加一個 remote 後直接推上去
      - `git remote add gitlab git@gitlab.example.com:group/project.git`
      - `git push gitlab master`

參考資料：

  - New Project 會有 Import project from ... 的提示，支援 GitHub、Bitbucket 等。
  - 之前匯入 GitHub 專案的印象，提供 Personal Access Token 可以列出自己的 project，但匯入時 username/project 會直接對應到 GitLab 裡，如果要去掉 username/org 那一層，可能得要自己先 clone 再 push。

## Quick Action ??

  - [GitLab quick actions \| GitLab](https://docs.gitlab.com/ee/user/project/quick_actions.html) #ril
  - 雖然不會被存起來，但可以養成為變更留下 comment 說明 "為什麼"，而不只記錄什麼時候誰做了這個變更，但事後又想不起來為什麼。
  - [GitLab quick actions \- GitLab Documentation](https://docs.gitlab.com/ee/user/project/quick_actions.html) 可以用在 issue 或 merge request 的 comment 裡，但要自成一行才有作用。由於是 textual shortcut，所以並不會真的被存起來。
  - [Description templates \- GitLab Documentation](http://docs.gitlab.com/ce/user/project/description_templates.html) 可以用在 issue templae 裡，官方的說明也出現 `/cc` 的用法。
  - [Add a \`/cc\` quick action \(\#24615\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/24615) `/cc` 的用法只是一種習慣，並沒有實質作用 #ril

## GitLab 在 CI/CD 這一塊的定位是什麼?

參考資料：

  - GitLab Jenkins Integration | GitLab https://about.gitlab.com/features/jenkins/
  - Jenkins CI service - GitLab Documentation https://docs.gitlab.com/ee/integration/jenkins.html #ril
  - GitLab Continuous Integration & Deployment | GitLab https://about.gitlab.com/features/gitlab-ci-cd/ #ril
  - 在 GitLab 的 UI 左側看到 CI/CD，展開有 Pipelines、Jobs、Schedules、Environments、Charts，其中 pipeline 跟 job 跟 CI 是什麼關係?

## 如何用一個 Jenkins job 測試不同的 merge request 並回報測試結果？

  - GitLab plugin 似乎會將 webhook payload 的一些 attribute 轉成 `gitlabSourceBrance`、`gitlabTargetBranch` 等不同的環境變數，若要同時應付 push event 與 merge request event 的狀況。
  - jenkinsci/gitlab-plugin: A Jenkins plugin for interfacing with GitLab https://github.com/jenkinsci/gitlab-plugin 提到 branch specifier 可以填入 `origin/${gitlabSourceBranch}`。
  - Setup Example · jenkinsci/gitlab-plugin Wiki https://github.com/jenkinsci/gitlab-plugin/wiki/Setup-Example 也是提到 `origin/${gitlabSourceBranch}` 的用法，但最後提到 Jenkins 跟 GitLab 綁得太緊，若不是由 GitLab 觸發，並不會有 `origin/${gitLabSourceBranch}`。

```
  - Webhook1 (Merge Request Events) -> build-xxx (checkout refs/heads/master + Accepted Merge Request Events, only for master branch) -> deploy-xxx-prod

  - Webhook2 (Merge Request Events) -> build-xxx-dev (checkout refs/heads/dev + Accepted Merge Request Events, only for dev branch) -> deploy-xxx-staging

  - Webhook3 (Merge Request + Push Events) -> build-xxx-pr (checkout refs/heads/${gitlabSourceBranch} + Opened Merge Request Events + Rebuild open Merge Requests on push to source branch, for all branches)
```

## 如何利用 Deploy Key 從 Jenkins 拿到 source code?

  - SSH - GitLab Documentation https://docs.gitlab.com/ce/ssh/README.html#deploy-keys
      - 透過 deploy key (就是 SSH key pair) 可以取得多個 project 的 read-only 或 read-write access，不需要為了 CI 建立 dummy user account。
      - Project owner/master 可以在 Settings > Repository 建立 deploy key (pair) - 貼上 public key，之後用對應的 private key 連線時，就有存取該 project 的權限。
      - 同一個 public key 只能建立一個 deploy key，但一個 project 可以讓多個 deploy key 存取；畫面下方有 "Enabled deploy keys for this project" (可以存取這個 project 的 deploy keys，按 Disable 可以取消)、"Deploy keys from projects you have access to" (來自有權存取的專案的 deploy keys) 與 "Public deploy keys available to any project" (怎麼來的?)
  - Continuous Integration with Jenkins and GitLab – Tom Kent – Medium https://medium.com/@teeks99/continuous-integration-with-jenkins-and-gitlab-fa770c62e88a Deploy key 在 Jenkins 端是走 SSH Username with private key 的 credential? username 用 `git`；大概是因為 repository URL 用 `git@...` 的關係?

## 什麼是 pipeline??

  - [Introduction to pipelines and jobs \- GitLab Documentation](https://docs.gitlab.com/ce/ci/pipelines.html) #ril

## 參考資料 {: #reference }

  - [GitLab](https://gitlab.com/)

社群：

  - [GitLab (@gitlab) - Twitter](https://twitter.com/gitlab)

更多：

  - [Issue](gitlab-issue.md)
  - [Wiki](gitlab-wiki.md)
  - [CI/CD](gitlab-ci.md)
  - [Plugin](gitlab-plugin.md)
  - [OAuth](gitlab-oauth.md)

手冊：

  - [EmojiCopy](https://www.emojicopy.com/) ([GitLab 文件推薦的查詢界面](https://docs.gitlab.com/ee/user/markdown.html#emoji))
  - [GitLab quick actions - GitLab Documentation](https://docs.gitlab.com/ee/user/project/quick_actions.html)
  - [GitLab releases](https://about.gitlab.com/releases/)
  - [Permissions](https://docs.gitlab.com/ee/user/permissions.html#project-members-permissions)
  - [GitLab FOSS Changelog](https://gitlab.com/gitlab-org/gitlab-foss/blob/master/CHANGELOG.md)
