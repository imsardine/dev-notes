# GitBook

## GitBook Legacy ??

  - [Important differences \- GitBook](https://docs.gitbook.com/v2-changes/important-differences) 初看覺得哀傷，也覺得 GitBook 玩完了?
      - We have MOVED AWAY FROM THE STATIC SITE GENERATOR MODEL, and no longer use the famous `gitbook` CLI to build documentation output. ... The main one being that you can no longer host a GitBook generated documentation yourself. 覺得哀傷
      - We are no longer versioning your books as a Git repository. With the new version, we have shifted to a GitBook specific versioning system. ... so it is never locked on our platform. If you need your documentation to be accessible as a Git repository, you can always use our GitHub integration. For now, we do not support other git hosting services, such as GitLab. 還是被綁架了? 不過之前也只支援 GitHub 不是?
      - The new version has dropped support for AsciiDoc, and now only support an extended Markdown syntax.
      - The new version of GitBook no longer supports exporting to PDF and other ebooks format.
      - The new version does not currently have a desktop editor app. Our efforts are concentrated on the web version so we can focus on quality and reliability first.
      - In general, the PLUGIN SYSTEM NO LONGER EXISTS.
      - The new GitBook editor does NOT OFFER A WAY TO EDIT THE MARKDOWN SOURCE of documents. We no longer store Markdown or HTML, instead we store rich JSON data structures. The reason for this change is that Markdown has limited features.
  - [關於 GitBook 平台的改版與 GitLab 替代的考量 \| Kenmingの鮮思維](https://www.kenming.idv.tw/about_gitbook-v2_and_gitlab_alternative/) (2018-09-27) 2018-04 V2 改版之大，以及其售價策略，肯定會引發開源用戶的出走潮，短期內的替代方案是 GitLab (背後金主 Google)，一樣[用 `gitbook` CLI 產生網頁](https://gitlab.com/pages/gitbook)。
  - [Is GitBook still alive? · Issue \#1808 · GitbookIO/gitbook](https://github.com/GitbookIO/gitbook/issues/1808) #ril
  - [Migrating from the legacy version \- GitBook](https://docs.gitbook.com/getting-started/migrating-from-the-previous-version) #ril

## 替代方案 {: #alternatives }

  - [GitBook Alternatives and Similar Software \- AlternativeTo\.net](https://alternativeto.net/software/gitbook/)

      - 依序是 Sphinx、Pandoc、Read The Docs、Daux.io ... MkDocs 等；直接表明跟 GitBook 一樣的只有 mdBook。
      - 其中 Pandoc 倒是滿常出現在製作 ePub 電子書。
      - Daux.io 對 code block 有 below/inline 兩種模式可切換，是其他工具沒看過的設計。

## 參考資料 {: #reference }

  - [GitBook](https://www.gitbook.com/) ([Legacy](https://legacy.gitbook.com/))
  - [GitbookIO/gitbook - GitHub](https://github.com/GitbookIO/gitbook)
