---
title: Hexo / NexT Theme
---
# [Hexo](hexo.md) / NexT Theme

## 新手上路 {: #getting-started }

  - [Getting Started \| NexT](https://theme-next.org/docs/getting-started/) #ril

## 顯示作者 ?? {: #author }

  - [怎么在每篇文章下面都增加作者功能？ · Issue \#1767 · iissnan/hexo\-theme\-next](https://github.com/iissnan/hexo-theme-next/issues/1767) #ril

## 如何調整字體 ?? {: #font }

在 `themes/next/source/css/_variables/custom.styl` 裡增加：

```
$font-family-headings = Georgia, sans
$font-family-base = "Microsoft YaHei", Verdana, sans-serif
$code-font-family = "Input Mono", "PT Mono", Consolas, Monaco, Menlo, monospace
$font-size-base = 16px
$code-font-size = 13px
```

參考資料：

  - 如何修改全局字体大小 · Issue #400 · iissnan/hexo-theme-next https://github.com/iissnan/hexo-theme-next/issues/400 在 `source/css/_variables/custom.styl` 加 `$font-size-base = 16px`? 試了沒有作用
  - font 修改 · Issue #111 · iissnan/hexo-theme-next https://github.com/iissnan/hexo-theme-next/issues/111 在 `source/css/_custom/variables.styl` 自訂字體，也試不出來
  - 如何更改字体？ http://theme-next.iissnan.com/faqs.html#custom-font 官方文件，原來是要改 theme 下面的 `source/css/_variables/custom.styl`，`$font-size-base` 與 `$code-font-size = 13px` 分別調整本文與代碼的字體大小；不過選單字體沒跟著放大好像也怪怪的?

## 安裝設置 {: #setup }

```
$ git submodule add https://github.com/theme-next/hexo-theme-next.git themes/next
$ git submodule init
$ cd themes/next && git checkout v7.1.2 && cd ../..
$ git add themes/next
```

---

參考資料：

  - [Installation - Getting Started \| NexT](https://theme-next.org/docs/getting-started/index.html#NexT-Installation) #ril

      - It's easy to install Hexo theme: you can just download the NexT theme, copy the theme folder to the `themes` directory under site root directory and specify in site config file your THEME ROOT DIRECTORY. The detailed steps are as follows:

        原來 config 裡 `theme:` 給的是 theme 的資料夾名稱。

    Downloading NexT > Newest Version

      - If you know about Git, you can clone the whole repository and update it in any time with `git pull` command instead of downloading archive manually.

        Open your Terminal, change to Hexo site root directory and clone latest master branch of NexT theme:

            $ cd hexo
            $ git clone https://github.com/theme-next/hexo-theme-next themes/next

    Downloading NexT > Stable Version

      - Go to NexT version Release Page.
      - Choose the version you need and download the Source Code (zip) in the Download section. For example v6.0.0.
      - Extract the zip file to site's themes directory and rename the extracted folder (`hexo-theme-next-6.0.0`) to `next`.

    Enabling NexT

      - Like all Hexo themes, after you download it, open site config file, find `theme` section, and change its value to `next` (or another theme DIRECTORY NAME).

        `hexo/_config.yml`

            theme: next

      - Now you have installed NexT theme, next we will verify whether it is enabled correctly. Between changing the theme and verifying it, we'd better use `hexo clean` to clean Hexo's cache.

  - [Installation \| NexT](https://theme-next.org/docs/getting-started/installation) #ril

  - [Installation - iissnan/hexo\-theme\-next: Elegant theme for Hexo\.](https://github.com/iissnan/hexo-theme-next#installation) (v5)

     1. Change dir to hexo root directory. There must be `node_modules`, `source`, `themes` and other directories:

            $ cd hexo
            $ ls
            _config.yml  node_modules  package.json  public  scaffolds  source  themes

     2. Get theme from GitHub. There are several variants to do it:

        At most cases stable. Recommended for most users.

            $ mkdir themes/next
            $ curl -s https://api.github.com/repos/iissnan/hexo-theme-next/releases/latest | grep tarball_url | cut -d '"' -f 4 | wget -i - -O- | tar -zx -C themes/next --strip-components=1

        也就是下載最新的 tarball 解開到 `themes/next`。

     3. Set theme in main hexo root config `_config.yml` file:

            theme: next

  - [Update from Version 5 \| NexT](https://theme-next.org/docs/getting-started/update-from-v5.html)

    There are no hard breaking changes between 5.1.x and 6.0.x versions. It's change major version to 6 because:

      - Main repositorie was rebased from iissnan's profile to theme-next organization.

        無論如何，移出個人 profile 是好事，有利專案未來的發展。

      - Most libraries under the `next/source/lib` directory was moved out to external repositories under NexT organization.
      - 3rd-party plugin `hexo-wordcount` was replaced by `hexo-symbols-count-time` because `hexo-symbols-count-time` no have any external nodejs dependencies, no have language filter which causes better performance on speed at site generation.

    So, NexT suggest to update from version 5 to version 6 in this way:

      - You don't touch old `next` dir and just do some COPIES of NexT files:

          - `config.yml` or `next.yml` (if you used data-files).
          - Custom CSS styles what placed in `next/source/css/_custom/*` and `next/source/css/_variables/*` directories.
          - Custom layout styles what placed in `next/layout/_custom/*`.
          - Any another possible custom additions which can be finded by compare tools between repositories.

        保留舊版使有機會退回舊版，不過把原來的目錄更名不是更好? 例如 `next-v5`

      - Clone new v6.x repositorie to any another directory instead of `next`. For example, in `next-reloaded` directory: `git clone https://github.com/theme-next/hexo-theme-next themes/next-reloaded`. So, you don't touch your old NexT 5.1.x directory and can work with new `next-reloaded` dir.

        至少要 `git clone --bare` 吧? 用 Git submodule 應該是更好的選擇?

      - Go to Hexo main config and set `theme` parameter: `theme: next-reloaded`. So, your `next-reloaded` directory must loading with your generation. If you may see any bugs or you simply not like this version, in anytime you can switch for 5.1.x version back.

      - And how to enable 3rd-party libraries see [here](https://theme-next.org/docs/getting-started/update-from-v5). 為什麼有 "hook up NexT plugins" 的說法 ??

## 參考資料 {: #reference }

  - [theme-next/hexo-theme-next - GitHub](https://github.com/theme-next/hexo-theme-next) (v6+)
  - [iissnan/hexo-theme-next - GitHub](https://github.com/iissnan/hexo-theme-next) (v5)
