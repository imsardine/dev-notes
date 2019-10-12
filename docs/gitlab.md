# GitLab

  - [GitLab Pricing \| GitLab](https://about.gitlab.com/pricing/#gitlab-com) #ril
      - 可以用 Google、Twitter、GitHub、Bitbucket 帳戶登入。
      - Free plan 只限制每個 group 每月只能用 2000 CI pipeline minutes (執行在 shared runner 上)，可以有不限數量的 private project 跟 collaborator；一個人可以有多個 group??

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

## 什麼是 Issue??

  - [Issues \- GitLab Documentation](https://docs.gitlab.com/ce/user/project/issues/) #ril
  - [Always start with an issue \| GitLab](https://about.gitlab.com/2016/03/03/start-with-an-issue/) (2016-03-03) #ril

## 什麼是 Issue Board ??

  - [One group level issue board in CE \(\#38337\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/38337) EE 已經支援，但 CE 還沒有? #ril

## Quick Action ??

  - [GitLab quick actions \| GitLab](https://docs.gitlab.com/ee/user/project/quick_actions.html) #ril
  - 雖然不會被存起來，但可以養成為變更留下 comment 說明 "為什麼"，而不只記錄什麼時候誰做了這個變更，但事後又想不起來為什麼。
  - [GitLab quick actions \- GitLab Documentation](https://docs.gitlab.com/ee/user/project/quick_actions.html) 可以用在 issue 或 merge request 的 comment 裡，但要自成一行才有作用。由於是 textual shortcut，所以並不會真的被存起來。
  - [Description templates \- GitLab Documentation](http://docs.gitlab.com/ce/user/project/description_templates.html) 可以用在 issue templae 裡，官方的說明也出現 `/cc` 的用法。
  - [Add a \`/cc\` quick action \(\#24615\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/24615) `/cc` 的用法只是一種習慣，並沒有實質作用 #ril

## 如何實作 Sub-issue 或 task??

參考資料：

  - [Task Lists - Markdown \- GitLab Documentation](https://docs.gitlab.com/ee/user/markdown.html#task-lists) 本身就是用來做 task，若是同一個 list 條列其他 issue，不就是 sub-issue 了嗎，完成還會被劃上一條線!
  - [User should be able to create sub\-issue of an issue\. \(\#4182\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/4182) #ril

## 如何建立 Issue Tempalte??

  - 每個專案都要設定一次有點麻煩? 或許可以共用一個 template project 做為起點? 最簡單的方法就是用 wiki 建立一個 template，複製貼上即可。
  - [Issue templates - Issues \- GitLab Documentation](https://docs.gitlab.com/ce/user/project/issues/#issue-templates) #ril
  - [Description templates \- GitLab Documentation](http://docs.gitlab.com/ce/user/project/description_templates.html) 用 `.gitlab` 下的 `.md` 來實現，可以內含 quick action 還不錯 #ril
  - [Merge Request Checklist \- GitLab Documentation](https://docs.gitlab.com/ce/development/database_merge_request_checklist.html) 用 merge request 的 template 實作 checklist 還滿不錯的!

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

## 如何拿 Issues 來實現 task management，甚至取代 Trello?

  - 在 Group level 定義通用的 labels，優先處理 bug、request 等；To Do 跟 Doing 也可以嗎?
  - 善用 group 的 milestone，建立 sprint 將要處理的 issue 拉進 milestone 裡。
  - 可惜 Issue > Board 不能跨 project 使用?

## 參考資料 {: #reference }

更多：

  - [Wiki](gitlab-wiki.md)
  - [CI/CD](gitlab-ci.md)

手冊：

  - [EmojiCopy](https://www.emojicopy.com/) ([GitLab 文件推薦的查詢界面](https://docs.gitlab.com/ee/user/markdown.html#emoji))
  - [GitLab quick actions - GitLab Documentation](https://docs.gitlab.com/ee/user/project/quick_actions.html)
  - [GitLab releases](https://about.gitlab.com/releases/)
