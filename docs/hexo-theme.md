---
title: Hexo / Theme
---
# [Hexo](hexo.md) / Theme

參考資料：

  - [Extensions - Configuration \| Hexo](https://hexo.io/docs/configuration#Extensions)
      - `theme_config` -- theme configuration，用來覆寫 theme defaults。
      - `theme` -- theme name，設定為 `false` 表示停用 theming。
  - [Overriding Theme Config - Configuration \| Hexo](https://hexo.io/docs/configuration#Overriding-Theme-Config) Hexo theme 是獨立的專案，有自己的 `_config.yml`，不過要調整它的設定，並不用 fork 才能維護自己的 settings，而是從 site’s primary configuration file 就能設定；例如 `_config.yml` 裡的 `theme_config: bio: "My awesome bio"`，就可以覆寫 `themes/my-theme/_config.ym` 裡 `bio: "Some generic bio"` 的設定。
  - [Themes \| Hexo](https://hexo.io/docs/themes) 如何自製 theme? #ril
  - [Templates \| Hexo](https://hexo.io/docs/templates) 每一種 page 有不同的 template #ril
  - [Variables \| Hexo](https://hexo.io/docs/variables) #ril

  - 覺得 theme 的用法，clone 到自家後，應該自己宣告 submodule 吧? 又如果有修改，可能就要 fork?
      - 但這也滿怪的，因為一個 repo 只能 fork 一次，如果 NexT 要用在許多網站怎麼辦?
      - 或許可以另外維護自訂的版本，待 checkout 出來後，再覆蓋上去? 目前在 hexo folder 加一個 `_config_{theme}.yml`，而 `themes/{theme}/_config.yml` 則只是個 symbolic link
      - 為什麼一開始的 `Submodule 'themes/landscape' (https://github.com/hexojs/hexo-theme-landscape.git) registered for path 'themes/landscape'` 沒有產生 `.gitmodules`? 或許這才是正確的用法?
      - 在 `.gitmodules` 加上 `ignore = dirty` 即可。

### Theme, Template, Layout ??

  - [Configuration \| Hexo](https://hexo.io/docs/configuration) `default_layout` - Default layout，預設是 `post`。
  - [Layout - Themes \| Hexo](https://hexo.io/docs/themes#layout) Layout folder. This folder contains the THEME’S TEMPLATE FILES, which define the appearance of your website.
  - [Layouts - Templates \| Hexo](https://hexo.io/docs/templates#Layouts) #ril
      - When pages share a similar structure - for instance, when two templates have both a header and a footer - you can consider using a layout to declare these structural similarities. Every layout file should contain a body variable to display the contents of the template in question.
  - [Layout - Writing \| Hexo](https://hexo.io/docs/writing#Layout) #ril
      - 用 `hexo new [<layout>] <title>` 建立 page/post，其中 `layout` 預設是 `post` (可以用 `default_layout` 自訂)
      - Hexo 有 3 個 default layouts -- `post`、`page` 及 `draft`，分別存放 `soruce/` 下不同的地方，`page` 直接放 `source/` 下，`post` 與 `draft` 則分別放 `source/_posts/` 與 `source/_drafts/`。

## 參考資料 {: #reference }

