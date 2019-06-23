---
title: GitLab / Wiki
---
# [GitLab](gitlab.md) / Wiki

  - [Creating a new wiki page - Wiki \| GitLab](https://docs.gitlab.com/ee/user/project/wiki/#creating-a-new-wiki-page) GitLab wikis support Markdown, RDoc and AsciiDoc. 確實在編修頁面時，可以選擇這 3 種 format。

## Markdown ??

  - [Transitioning to CommonMark - Markdown \| GitLab](https://docs.gitlab.com/ee/user/markdown.html) #ril
      - GitLab uses “GitLab Flavored Markdown” (GFM). It extends the CommonMark specification (which is based on standard Markdown) in a few significant ways to ADD some useful functionality. It was inspired by GitHub Flavored Markdown. 注意 GFM (GitLab) 與 GFM (GitHub) 不一樣，GitLab GFM 是基於 CommonMark，而 CommonMark 又基於標準的 Markdown，所以是相對嚴格的，沒有 GitHub GFM 那些彈性，但加了一些 GitLab 自己的東西。
      - For the best result, we encourage you to check this document out as rendered by GitLab itself: [markdown.md](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md) 比較保險的寫法都在裡面 #ril
      - GitLab uses (as of 11.1) the [CommonMark Ruby Library](https://github.com/gjtorikian/commonmarker) for Markdown processing of all new issues, merge requests, comments, and other Markdown content in the GitLab system. As of 11.3, wiki pages and Markdown files (`.md`) in the repositories are also processed with CommonMark. Older content in issues/comments are still processed using the [Redcarpet Ruby library](https://github.com/vmg/redcarpet). 看來都往 CommonMark 靠攏了。
      - Since CommonMark uses a slightly stricter syntax, these documents may now display a little strangely since we’ve transitioned to CommonMark. Numbered lists with NESTED LISTS in particular can be displayed incorrectly. 如果暫時要看舊寫法的文件，URL 後面加 `?legacy_render=1` 參數即可。如果有許多檔案要調整的話，可以用 [diff_redcarpet_cmark](https://gitlab.com/digitalmoksha/diff_redcarpet_cmark) 找出需要修改的檔案。

## 頁面如何命名?

  - 正確的說法是 page slug，而非 page name。
  - 建議全部小寫，單字間用 `-` 分隔，例如 `quick-start` 而非 `quick_start` 或 `QuickStart`。

參考資料：

  - 在 web editor 新增頁面時，出現 Page slug 的提示 - `how-to-setup`。
  - 用 `how-to-setup` 與 `how_to_setup` 的結果不同，前者在 TOC 裡會表現為 `How to setup`，但後者則會表現為 `How_to_setup`，顯然在 GitLab 內部 `-` 與單字間的空白是有對應關係的。

## 指向 header 的連結 ??

  - Header ID 從 header 的內容自動產生，無法自訂，但中文產生的 URL 有點醜。
  - 若手動宣告 `<a id="custom-id" />`，雖然可行，但使用者無法在閱讀文件時直接拿到，反而造成混淆?

參考資料：

  - Markdown - GitLab Documentation https://docs.gitlab.com/ee/user/markdown.html#header-ids-and-links GitLab 會自動從 header 內容產生 header ID。
  - Github Markdown Heading Anchors https://gist.github.com/asabaylus/3071099 GitHub 也是用類似的方式產生。
  - 不知道從哪個版本之後，anchor 都變成 `<a id="user-content-header" href="#header" ...></a>`，感覺 URL 都要加上 `user-content-` 的 prefix，但 `#header` 似乎又還能作用? 觀察 `[[_TOC_]]` 產生的連結，其實也沒加 `user-content-` prefix，而且也可以作用，不知道是怎麼回事?
  - [User\-generated content and DOM clobbering \- Brandon Keepers](https://opensoul.org/2014/09/05/dom-clobbering/#-the-solution) 感覺是 JavaScript 的 `hashchange` 在作用，當 URL 變成 `#header` 時，會自動往 `#user-content-header` 捲動。

## TOC (Table Of Contents)

在需要有 TOC 的地方放 `[[_TOC_]]` 即可。

參考資料：

  - [Table Of Contents (TOC) in Markdown (Wiki and general) \- General \- GitLab Community Forum](https://forum.gitlab.com/t/table-of-contents-toc-in-markdown-wiki-and-general/9394) 有人發現在 #2494 提到支援 `[[_TOC_]]` 的用法。
  - [Add ability to generate Table of Contents fro Wikis (\#2494) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/2494) (2015-09-10) v8.6 加入了 `[[_TOC_]]，其間有人提到 `<!-- NOTOC -->` 可以把某個 entry 排除在 TOC 之外，不過好像沒被採納。
  - [Home · gollum/gollum Wiki](https://github.com/gollum/gollum/wiki#table-of-contents-toc-tag) 支援 `[[_TOC_]]` 或 `[[_TOC_|levels = 3]]` 的用法，不過在 GitLab Wiki (10.4.1) 上後者沒有作用。
  - [Markdown \- GitLab Documentation](https://docs.gitlab.com/ee/user/markdown.html) 這裡竟完全沒提到 TOC。

  - [Make markdown TOC always follow links in the same current navigator tab \(\#56495\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/56495) #ril

      - Mathieu Rossignol: Using `[[TOC]]` in MD wiki pages is a great feature. However if you click on a FIRST LEVEL link in the TOC it opens in a NEW TAB whereas a click on a second level link in the TOC leads you to the section using the same current tab. This is not an homogeneous behaviour.

        Also, the first expectation I think is generally always to move in the same tab. If you want to open a link in a new tab you traditionally can DECIDE IT BY YOURSELF by clicking on the link with the middle mouse button.

        I am even not sure this is not a bug! SOME second level links use same tabs, some other second level links open in new tabs. Tested on both firefox and chrome.

      - Mathieu Rossignol: OK I succeeded in reproducing the problem with a public page. On [this page](https://gitlab.com/mathieu.rossignol/sandbox/wikis/home), If you click for instance on the very first and very last links of the toc, they open in a new tab on my navigator whereas some others don't. For instance the links 'Liste des flux Nifi' or 'Hive' behave correctly and are followed in the current tab. Can you reproduce on your side?

      - Mark Fletche (member): You're right certain TOC items have `target="_blank"` and others do not.

      - Nick Thomas (member): Thanks for reporting @mathieu.rossignol ! I would DEFINITELY EXPECT only links that go to a new page would open in a new tab. Navigating within a page, the default - it seems to me - would be to jump around the existing page.

        I believe this is generated from https://gitlab.com/gitlab-org/gitlab-ce/blob/master/lib/banzai/filter/table_of_contents_filter.rb

        I don't immediately see how the `target="_blank"` gets added, though 🤔 - maybe a later filter kicks in on some criterion? The obvious possibility is `ExternalLinkFilter`.

## Math

官方只說用 LaTeX 寫，要怎麼寫 LaTeX 要另外學。

---

參考資料：

  - [Math - GitLab Markdown \| GitLab](https://docs.gitlab.com/ee/user/markdown.html#math)
      - It is possible to have math written with the LaTeX syntax rendered using KaTeX. Math written inside ```$``$``` will be rendered inline with the text.

            This math is inline $`a^2+b^2=c^2`$.

      - Math written inside triple back quotes, with the language declared as `math`, will be rendered on a separate line.

            This is on a separate line
            ```math
            a^2+b^2=c^2
            ```

      - Be advised that KaTeX only supports a subset of LaTeX. 如果只拿來寫數學運算式，應該沒什麼問題吧?

## 如何要求提供有意義的 Commit Message?

  - 預設的 commit message 是 "Update <page-title>"，填空白也可以 (GitLab CE 10.4.0 上觀察到)，這會讓 page history 變得沒有意義。
  - 有些人建議 commit message 應該預設要留白且設為必填，否則很常忘記改讓 page history 沒有太大的用處，但不知為何 GitLab 開發團隊就是不予採納。目前只好用工具檢查 commit message 為 "Update <page-title>" 時，跟使用者提示為什麼這樣做不好。

參考資料：

  - [Wiki \-\- Provide meaningful commit message (\#27279) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/27279) (2017-01-16) 早先預設會採用上一個 commit 的 messag，建議明確要求輪入有意義的 commit message。2017-04-22 v9.1 已經改成 "Create <page-title-here>" 或 "Update <page-title-here>" (說是 UX team 的建議)。
  - [Arbitrary commit message when editing wiki page (\#20389) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/20389) (2016-07-28) Daniel Kasza: 想邀大家一起來用 wiki，但現在 page history 是沒有用的，怎麼會有預設為上個 commit message 的設計? Gareth Somerville: 建議留白，要求使用者明確寫上 commit message；Alper Ortac 也同意，常常忘了改 commit message，而讓 page history 充滿了錯誤的資訊。不知道為什麼 Taurie Davis 會說 The commit message should mimic what we do for editing files. "Update [wiki-page-name]" 完全沒把 Gareth Somerville 的建議聽進去?
  - [Wiki placeholder commit messages for Web UI could be better (\#30104) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/30104) (2017-03-27) Alper Ortac 又跳出來說 default message 應該留空，而且必填。
  - [Commit message of new wiki page doesn't get stored (\#37087) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/37087) (2017-08-27) 新 wiki page 的 commit message 無法自訂 (未解)。

## 圖片存放的位置 ??

  - 把圖片拖拉進 editor 就會上傳並填上 `![{filename}](/uploads/{hash}/{filename})`，很方便但會導致在 local 無法預覽圖片；它不在 wiki repo 裡，在 Settings > Export project 裡有提到 "Project uploads"。
  - 若把圖放在 project repo 呢? 有 web UI 可以上傳檔案、取得 URL，只是在 wiki repo 裡引用時要寫完整的 URL，例如 `![Text](http://gitlab.example.com/group/project/.../image.png)` (之後換位置可以大量取代，問題不大)；雖然離線時會看不到圖，但有網路時只要能預覽的 editor 都沒問題，就像把圖放在 imgur 一樣，好處是能造訪 project repo 與 wiki repo 的人有一樣的限制。
  - 使用 web editor 編輯時，把本地端的檔案直接拖拉進編輯區就會自動上傳並插入圖片 (或是直接把系統剪貼簿的圖片直接貼上)，雖然檔案不會出現在 wiki repo 裡，但這會大大降低進入的門檻，提高大家用 wiki 撰寫文件的意願，對於非技術人員也比較友善。
  - 把圖放 wiki repo 也是一個方式，不過這對非技術人員的門檻太高。

參考資料：

  - [Wiki \| GitLab](https://docs.gitlab.com/ee/user/project/wiki/) #ril
      - Starting with GitLab 11.3, any file that is uploaded to the wiki via GitLab's interface will be stored in the wiki Git repository, and it will be available if you clone the wiki repository locally. 實驗發現圖檔會放 wiki repo 的 `uploads/{hash}/{filename}` 下。
      - All uploaded files prior to GitLab 11.3 are stored in GitLab itself. If you want them to be part of the wiki's Git repository, you will have to upload them again. 當然連結也要跟著改。
  - [Links - Markdown \| GitLab](https://docs.gitlab.com/ee/user/markdown.html#links) project repo 與 wiki repo 間的 relative link 無法相互參照。
  - [Where can I manage files uploaded to wiki of a Gitlab\.com project? \- Stack Overflow](https://stackoverflow.com/questions/38228508/) 透過 wiki editor 圖片會上傳到 `/uploads` (GitLab 8.9.0 後無法管理?)，建議 clone 出 wiki repo 放進圖片。
  - [Cloning Wiki doesn't include uploads (\#1423) · Issues · GitLab\.com / GitLab\.com Support Tracker · GitLab](https://gitlab.com/gitlab-com/support-forum/issues/1423) 上傳的圖不在 repo 裡，要在本地端寫 wiki 還真不方便
  - [Uploads to a wiki should be stored inside the wiki git repository (\#33475) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/33475) #ril
      - 跟 Gollum 的 `--allow-uploads dir` 與 `--allow-uploads page` 對不起來?

## 如何建立文件階層?

  - GitLab 確實支持文件階層結構，但為了方便 page 之間相互引用，建議不要有階層，把全部的 page 都放在同一層。
  - 另一個考量是，將來 page 重新命名，可以大量取代 `[Text](page-old)` 為 `[Text](page-new)`，不用考量相對位置的變動。
  - 這會衍生出一個問題，該如何解決命名衝突? 可以從 `prefix-` 或 `-suffix` 兩方面來著手，例如 `versioning`、`jenkins`、`jenkins-setup`。
  - 這中間涉及文件的演進，可能一開始 Jenkins 的 setup 寫在 `jenkins#setup` (其中一節)，但之後可能拉出來成為獨立的 page，這時候只要大量將 `jenkins#setup` 取代為 `jenkins-setup` 即可。

參考資料：

  - Wiki - Hierarchical link - Markdown - GitLab Documentation https://docs.gitlab.com/ee/user/markdown.html#wiki-hierarchical-link GitLab 確實支援 relative link (用 `./page` 或 `../page` 表示)。

## 如何比對不同版本的差異?

參考資料：

  - Cannot diff changes in wiki history (#17906) · Issues · GitLab.org / GitLab Community Edition · GitLab https://gitlab.com/gitlab-org/gitlab-ce/issues/17906 有 PR 在處理 diff 的需求。

## 如何將 Wiki 的異動通知到 Slack?

  - 最根本的問題是 Wiki Page event 裡不帶 commit，只好求助 custom hook 或是定期 pull 並找出新的 commit。
  - Custom hook 在 CE 裡只能透過 admin 把 hook file 擺到適當的位置，若 project 數量多的話，要一直請 admin 幫忙也很麻煩，所以後者 "定期 pull 並找出新的 commit" 似乎比較可行。

參考資料：

  - 方向上是整合 Wiki Event 與 Slack 沒錯，但目前往 Slack 的訊息是整份 wiki 文件內容，看不出改了什麼?
  - 若能在 Slack 訊息裡提供 diff，或者附上 Gitweb 連結，方便查看任意兩個版本間的差異... 因為目前 GitLab Wiki 還不提供這項功能。前者 diff 可能相對單純，但後者若需要做權限控制就會比較麻煩，而且也涉及要同步兩個 repo。
  - Custom Git Hooks - GitLab Documentation https://docs.gitlab.com/ee/administration/custom_hooks.html Hook 設定在 filesystem，要 GitLab server 管理者才能做，也只有 GitLab Enterprise Edition 才有 UI 供一般使用者設定 #ril
  - Webhooks - GitLab Documentation https://docs.gitlab.com/ce/user/project/integrations/webhooks.html#wiki-page-events Wiki Page events 並不帶有 commit，只能從 `object_attributes.slug` 取得最新的 commit? 若一個 commit 修改多個 wiki page 會觸發多個 event?
  - 若是將 Wiki Event 往 Jenkins 打，由 Jenkins 搭配 [Slack Notification](https://plugins.jenkins.io/slack) plugin 送出 diff 呢?
  - Jenkins 裝了 GitLab Plugin 之後，發現 Enabled GitLab triggers 裡並不支援 Wiki Page event
  - Jenkins Plugins https://plugins.jenkins.io/generic-webhook-trigger 可以用來接 Wiki Page event? 似乎所有的 job 都共用 `http://JENKINS_URL/generic-webhook-trigger/invoke`? 何不用 GitLab CI 自己來接?
  - nazrhyn/gitlab-slack: A service that receives hook notifications from GitLab and posts information to an incoming webhook on Slack. https://github.com/nazrhyn/gitlab-slack Wiki page 只會通知有異動，還是沒有 diff。
  - How can you track or be notified of changes to GitHub wikis? - Stack Overflow https://stackoverflow.com/questions/8407917/ 分為 Push approach 與 JSON-based pull approach；或許定時處理也是個方式?
  - 確定 `git@.../wiki.git` 可以透過 deploy key 拿到 source code；走 Build Triggers > Trigger builds remotely 就可以觸發 (要啟用 Global Security 才看得到這個選項)
  - 如果用 `ansi2html` 轉換成 HTML，並存成 Jenkins 的 artifact 供其他人開啟瀏覽? 或許直接用 nginx 的 upload module 也不錯?

## 如何用文字來表現不同的圖形?

  - PlantUML & GitLab - GitLab Documentation https://docs.gitlab.com/ee/administration/integration/plantuml.html #ril

## Wiki Link

  - 明確前置 `./`、`../` 或 `/` 的寫法很明確是相對於 current wiki page 或是從 wiki root 起算，這時候寫與不寫 wiki page 的副檔名，結果並無差別。
  - 否則會因有沒有副檔名而有不同的解讀 -- 無副檔名時視為相對於 wiki root，有副檔名時則是相對於 current wiki page。

---

參考資料：

  - [Wiki-specific Markdown - GitLab Markdown \| GitLab](https://docs.gitlab.com/ee/user/markdown.html#wiki-specific-markdown)
      - A link which just includes the slug for a page will point to that page (沒有副檔名而言), at the BASE LEVEL of the wiki. This snippet would link to a `documentation` page at the ROOT of your wiki:

            [Link to Documentation](documentation)

      - Links with a FILE EXTENSION point to that file, RELATIVE to the CURRENT PAGE. If this snippet was placed on a page at `<your_wiki>/documentation/related`, it would link to `<your_wiki>/documentation/file.md`:

            [Link to File](file.md)

      - A link can be constructed RELATIVE to the CURRENT WIKI PAGE using `./<page>`, `../<page>`, etc.
          - If this snippet was placed on a page at `<your_wiki>/documentation/main`, it would link to `<your_wiki>/documentation/related`: `[Link to Related Page](./related)`
          - If this snippet was placed on a page at `<your_wiki>/documentation/related/content`, it would link to `<your_wiki>/documentation/main`: `[Link to Related Page](../main)`
          - If this snippet was placed on a page at `<your_wiki>/documentation/main`, it would link to `<your_wiki>/documentation/related.md`: `[Link to Related Page](./related.md)` 看似跟第一個例子沒有差別? 其實是有副檔名的狀況，也間接說明了要連到其他 wiki page，副檔名可以省略。
          - If this snippet was placed on a page at `<your_wiki>/documentation/related/content`, it would link to `<your_wiki>/documentation/main.md`: `[Link to Related Page](../main.md)`

      - A link starting with a `/` is RELATIVE to the WIKI ROOT.
          - This snippet links to `<wiki_root>/documentation`: `[Link to Related Page](/documentation)` 搭配上面 "A link which just includes the slug for a page" 的說法，在沒有副檔名的情況下，前面的 `/` 其實是可以省略的。
          - This snippet links to `<wiki_root>/miscellaneous.md`: `[Link to Related Page](/miscellaneous.md)`

## 自訂 Sidebar {: #customizing-sidebar }

  - 預設的 sidebar 會無腦地列出所有的 wiki page，它的的存在會讓人忽視頁面間連結的重要性。
  - 用 `/_sidebar.md` 可以自訂 sidebar，但原本 sidebar 下方 More Pages 的按鈕/連結還是會在。

參考資料：

  - [Customizing sidebar - Wiki \| GitLab](https://docs.gitlab.com/ee/user/project/wiki/#customizing-sidebar)
      - By default, the wiki would render a sidebar which lists ALL THE PAGES for the wiki. You could as well provide a `_sidebar` page to replace this default sidebar. When this customized sidebar page is provided, the default sidebar would not be rendered, but the customized one.

        不過下方的 More Pages 還是會在。

      - [GitLab releases \| GitLab](https://about.gitlab.com/releases/#gitlab-112) GitLab 11.2 (2018-08-22) Custom Wiki sidebar

  - [Introduce sidebar support for Wikis (\#14995) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/14995)
      - When commiting a `_Sidebar.md` file to a gitlab wiki, it is now showing up. Are sidebars supported in gitlab?
      - [Implement customized sidebar (\!17940) · Merge Requests · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/17940) 在 2018-07-17 進到 master，當時的 milestone 是 11.2；這個 MR 的前身是 jsooter 送出來的 [Added support for custom wiki sidebar using \_sidebar\.md in the wiki root\. If… (\!16241) · Merge Requests · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/16241)
      - jsooter: On a very large wiki the existing TOC and "More pages" view do not do a very good job of organizing all of the pages in a way that makes them easy to navigate. Granted, you can search for wiki content but often times that returns too many results without a way of ordering or grouping the results. 

        Because of this I have created a `_sidebar.md` with a wiki TOC ORGANIZED BY APPLICATION MODULE; like a FILE TREE VIEW. I then made a script to patch GitLab with the update from !16241 (closed).

        I should mention that the `_sidebar.md` I use is AUTO-GENERATED because it's too large to update manually.

        With extremely large wikis I prefer to have complete control over the sidebar content.

  - [Wiki: Remove sidebar and add table of content instead · Issue \#217 · SonarOpenCommunity/sonar\-cxx](https://github.com/SonarOpenCommunity/sonar-cxx/issues/217) GitHub Wiki 也有同樣的問題
      - guwirth: Would like to remove the side bar in the wiki. USING TOO MUCH SPACE and hides especially table content. Suggestion is to add a table of content (ToC) at the beginning of each page instead. 下面一堆人響應
      - wenns: Should be a win (as the tables are HARDLY READABLE currently)
      - christocracy: +1 Tables are useless. I need that HORIZONTAL SPACE consumed by the sidebar.
      - guwirth: (collaboator) Not possible 然後就把 issue 關了 XD

## 參考資料 {: #reference }

文件：

  - [GitLab Markdown | GitLab](https://docs.gitlab.com/ee/user/markdown.html)

相關：

  - 數學等式的語法採 [LaTeX](latex.md)，透過 [KaTeX](katex.md) 在前端表現出來。
