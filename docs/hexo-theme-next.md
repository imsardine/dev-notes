# Hexo > NexT Theme

## 基礎

### 顯示作者 ??

  - [怎么在每篇文章下面都增加作者功能？ · Issue \#1767 · iissnan/hexo\-theme\-next](https://github.com/iissnan/hexo-theme-next/issues/1767) #ril

### 如何調整字體??

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

## 參考資料

  - [iissnan/hexo-theme-next - GitHub](https://github.com/iissnan/hexo-theme-next)
