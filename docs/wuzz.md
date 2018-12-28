# wuzz

  - [asciimoo/wuzz: Interactive cli tool for HTTP inspection](https://github.com/asciimoo/wuzz) #ril
      - Wuzz command line arguments are similar to cURL’s arguments, so it can be used to inspect/modify requests copied from the browser’s network inspector with the “copy as cURL” feature. 跟 Copy as cURL 的功能接軌，這點子真不錯!! 進到 wuzz TUI 後就可以調整 request 觀察變化。

## 新手上路 ?? {: #getting-started }

  - [asciimoo/wuzz: Interactive cli tool for HTTP inspection](https://github.com/asciimoo/wuzz#commands) #ril
      - 畫面上每個窗格都叫 view，可以用 Tab 切換 focus；在 URL view 按下 Enter 會送出 request，在其他 view 時也可以用 Ctrl-R 送出。
      - 預設的 keybinding 感覺比較像是 Windows 在用的? 例如 F1 (Help)、Ctrl-C (Quit) 等。
  - Ctrl-O 在文件中沒提到 -- Open Editor，可以用外部編輯器修改當前 view 的內容。

## Configuration ??

  - [Configuration - asciimoo/wuzz: Interactive cli tool for HTTP inspection](https://github.com/asciimoo/wuzz#configuration)
      - It is possible to override default settings in a configuration file. The default location is `$XDG_CONFIG_HOME/wuzz/config.toml` on linux and `~/.wuzz/config.toml` on other platforms. `-c`/`--config` switches can be used to load config file from custom location.
  - [wuzz/sample\-config\.toml at master · asciimoo/wuzz](https://github.com/asciimoo/wuzz/blob/master/sample-config.toml) keybinding 可以自訂 #ril

## 安裝設定 {: #installation }

  - [Installation and usage - asciimoo/wuzz: Interactive cli tool for HTTP inspection](https://github.com/asciimoo/wuzz#installation-and-usage)
      - 用 Go 1.10+ 安裝：

            $ go get github.com/asciimoo/wuzz
            $ "$GOPATH/bin/wuzz" --help

      - 或是[直接下載 binary](https://github.com/asciimoo/wuzz/releases)，但 macOS 上執行 binary 會出現 `permission denied:` 的錯誤??

## 參考資料 {: #reference }

  - [wuzz](https://asciimoo.github.io/wuzz/)
  - [asciimoo/wuzz - GitHub](https://github.com/asciimoo/wuzz)

相關：

  - [Postman](postman.md) - 可以做為 Postman 在 terminal 環境下的替代方案
