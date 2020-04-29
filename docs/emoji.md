# Emoji

## Unicode ??

  - 第一次在 `mkdocs.yml` 用 `site_name: "在電梯裡遇見雙胞胎 🚀"` 會噴錯 `unacceptable character #x1f680: special characters are not allowed
      in "/workspace/mkdocs.yml`，但改用 escape sequence `site_name: "在電梯裡遇見雙胞胎 \U0001F680"` 就可以了。
  - [Crashes on encountering emojis · Issue \#48 · adrienverge/yamllint](https://github.com/adrienverge/yamllint/issues/48)
      - adrienverge: (owner) 跟 [pyyaml does not support literals in unicode over codepoint 0xffff · Issue \#25 · yaml/pyyaml](https://github.com/yaml/pyyaml/issues/25) 有關
      - jayvdb: (contributor) 這問題在 PyYAML 已經被 merge 了，但一直沒 release，要不要改用 [`ruamel.yaml`](https://pypi.org/project/ruamel.yaml/)?
  - [Support for UTF\-16 surrogate pair encoded emojis · Issue \#279 · go\-yaml/yaml](https://github.com/go-yaml/yaml/issues/279) Go 也有類似的問題? #ril
  - [python \- Loading special characters with PyYaml \- Stack Overflow](https://stackoverflow.com/questions/44875403/loading-special-characters-with-pyyaml/44875714) Anthony Sottile: 似乎是 PyYAML 的 bug，改用 escape sequence 即可 #ril

## 工具 {: #tools }

  - [carpedm20/emoji: emoji terminal output for Python](https://github.com/carpedm20/emoji/) 在 unicode 與 emoji code 間互轉 #ril

## 參考資料 {: #reference }

工具：

  - [Emoji Finder](https://emojifinder.com/) (無廣告)

手冊：

  - [Emoji Cheat Sheet - Emoji.codes](https://emoji.codes/)
  - [Emoji cheat sheet for GitHub, Basecamp and other services](https://www.webfx.com/tools/emoji-cheat-sheet/)
  - [Full Emoji List - Unicode.org](http://www.unicode.org/emoji/charts/full-emoji-list.html)
  - [Emojipedia](https://emojipedia.org/) 對照同一個 emoji 在不同平台上的表現

