---
title: GitLab / Issue Management
---
# [GitLab](gitlab.md) / Issue

  - [Issues \- GitLab Documentation](https://docs.gitlab.com/ce/user/project/issues/) #ril
  - [Always start with an issue \| GitLab](https://about.gitlab.com/2016/03/03/start-with-an-issue/) (2016-03-03) #ril
  - [4 ways to use GitLab Issue Boards \| GitLab](https://about.gitlab.com/blog/2018/08/02/4-ways-to-use-gitlab-issue-boards/) (2018-08-02) #ril

  - [Confidential issues \| GitLab](https://docs.gitlab.com/ee/user/project/issues/confidential_issues.html) #ril
  - [Due dates \| GitLab](https://docs.gitlab.com/ee/user/project/issues/due_dates.html) #ril

## Project Management

  - 在 Group level 定義通用的 labels，優先處理 bug、request 等；To Do 跟 Doing 也可以嗎?
  - 善用 group 的 milestone，建立 sprint 將要處理的 issue 拉進 milestone 裡。
  - 可惜 Issue > Board 不能跨 project 使用?

## Label

  - [Labels \| GitLab](https://docs.gitlab.com/ee/user/project/labels.html) #ril

## Priority

  - [Label priority - Labels \| GitLab](https://docs.gitlab.com/ee/user/project/labels.html#label-priority) #ril

## Milestone

  - [Milestones \| GitLab](https://docs.gitlab.com/ee/user/project/milestones/)

## Board

  - [Issue Boards \| GitLab](https://docs.gitlab.com/ee/user/project/issue_board.html) #ril
  - [One group level issue board in CE \(\#38337\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/38337) EE 已經支援，但 CE 還沒有? #ril


## My Board

  - [Overview of Issue Boards Across ALL projects \(\#15757\) · Issues · GitLab\.org / GitLab · GitLab](https://gitlab.com/gitlab-org/gitlab/-/issues/15757) #ril

## Sub-issue

參考資料：

  - [Task Lists - Markdown \- GitLab Documentation](https://docs.gitlab.com/ee/user/markdown.html#task-lists) 本身就是用來做 task，若是同一個 list 條列其他 issue，不就是 sub-issue 了嗎，完成還會被劃上一條線!
  - [User should be able to create sub\-issue of an issue\. \(\#4182\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/4182) #ril

## Template

  - 每個專案都要設定一次有點麻煩? 或許可以共用一個 template project 做為起點? 最簡單的方法就是用 wiki 建立一個 template，複製貼上即可。
  - [Issue templates - Issues \- GitLab Documentation](https://docs.gitlab.com/ce/user/project/issues/#issue-templates) #ril
  - [Description templates \- GitLab Documentation](http://docs.gitlab.com/ce/user/project/description_templates.html) 用 `.gitlab` 下的 `.md` 來實現，可以內含 quick action 還不錯 #ril
  - [Merge Request Checklist \- GitLab Documentation](https://docs.gitlab.com/ce/development/database_merge_request_checklist.html) 用 merge request 的 template 實作 checklist 還滿不錯的!

## 參考資料 {: #reference }

文件：

  - [Issues | GitLab](https://docs.gitlab.com/ee/user/project/issues/)

手冊：

  - [Project Members Permissions](https://docs.gitlab.com/ee/user/permissions.html#project-members-permissions)
