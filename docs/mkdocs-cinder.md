---
title: MkDocs / Cinder Theme
---
# [MkDocs](mkdocs.md) / Cinder Theme

  - [https://sourcefoundry\.org/cinder/](https://sourcefoundry.org/cinder/) #ril
      - Cinder is a CLEAN, RESPONSIVE theme for static documentation sites that are generated with MkDocs. It's built on the [Bootstrap 3 framework](https://getbootstrap.com/docs/3.3/) and includes pre-packaged: `highlight.js` (syntax highlighting)、`FontAwesome` (icon)、smashingly legible type scheme (字體易讀)
      - 文件的 TOC 一樣在左側，但有支援 L3；字體在桌機、手機上的表現都不錯。

## Style ??

  - [Specimen \- Cinder](https://sourcefoundry.org/cinder/specimen/) #ril
  - 這份文件在展示不同 HTML element 搭配 Cinder stylesheets 的表現，但沒有說要如何產生這樣的 HTML。以 Blockquotes 為例，其原始碼為：

        <blockquote>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
          <footer>Someone famous in <cite title="Source Title">Source Title</cite></footer>
        </blockquote>

     但要如何產生 `<footer>...<cite>` 的組合卻沒說??

## 安裝設定 {: #installation }

  - [Install the Cinder Theme - Home \- Cinder](https://sourcefoundry.org/cinder/#install-the-cinder-theme) 安裝 `mkdocs-cinder` 套件，在 `mkdocs.yml` 宣告 `theme: cinder` 即可。

## Snippets

`docs/cinder_extra.css`:

```css
@media (min-width: 992px) {
  .bs-sidebar.affix {
    overflow: auto;   // TOC 過長時看不到後面的項目
  }
}
.bs-sidenav {
  font-size: inherit; // TOC 原先固定 12px 太小
}

/* 減少內縮，清單的內層項目才有顯示空間 */
div.container {
  padding-left: 5px;
  padding-right: 5px;
}

div[role="main"] {
  padding: 0;
}

div[role="main"] > ul {
  list-style-type: square;
  padding-left: 1.5em;
}

div[role="main"] > ul ul {
  border-left: 2px dashed grey;
  list-style-type: square;
  padding-left: 1.5em;
}

/* 原引用字體放大覺得不必要，左側色條也太窄 */
blockquote {
  border-color: grey;
  border-left-width: 5px;
}

blockquote p {
  font: inherit;
  line-height: inherit;
}
```

`mkdocs.yml`:

```yaml
theme: cinder
extra_css: ['cinder_extra.css']
markdown_extensions:
  - toc:
      permalink: ' #'
  - codehilite:
      guess_lang: false
```

## 參考資料 {: #reference }

  - [Cinder](https://sourcefoundry.org/cinder/)
  - [chrissimpkins/cinder - GitHub](https://github.com/chrissimpkins/cinder)
