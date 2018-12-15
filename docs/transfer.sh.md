# transfer.sh

  - [transfer\.sh \- Easy and fast file sharing from the command\-line\.](https://transfer.sh/)
      - Easy file sharing from the command line 簡單明瞭!

            # Upload using cURL
            $ curl --upload-file ./hello.txt https://transfer.sh/hello.txt
            https://transfer.sh/66nb8/hello.txt

            # Using the alias
            $ transfer hello.txt
            ##################################################### 100.0%
            https://transfer.sh/eibhM/hello.txt

            # Upload from web 有機會整合到自己的 UI 嗎??
            Drag your files here, or click to browse.

      - Share files with a URL. Preview your files in the browser! 將 URL 貼在 browser 會看到下載檔案的介面，有提供預覽，按 download 即可下載；但相同的 URL 直接 curl 會直接拿到檔案內容；實驗發現，後端會參照 `Accept` header 來決定回傳的內容。
      - Encrypt your files 有 public key 的人才能解密??
      - Sample use cases 有許多有趣的應用，可以一次上傳多個檔案、搭配其他工具在上傳前用密碼或 key 加密  #ril

## 新手上路 ?? {: #getting-started }

  - `curl --upload-file ./hello.txt https://transfer.sh/` 拿到的 URL，在 browser 裡會提供下載檔案的介面 (`type: text/plain; charset=utf-8` 正確)，按 download 即可下載 (但 URL 裡沒有安插 `get/`)。
  - `curl --upload-file ./long.png https://transfer.sh/` 拿到的 URL，在 browser 裡會提供下載檔案的介面 (`type: image/png` 正確)，按 download 即可下載 (但 URL 裡沒有安插 `get/`)；要如何在 browser 裡直接表現?? 因為 inline link 是無效的 (404)
  - [How to Share Files Online The Geeky Way \(Command Line\)](https://www.hongkiat.com/blog/file-sharing-command-line-transfer-sh/) (2017-11-26) #ril

## Download/Inline Link ??

  - [Link aliases - dutchcoders/transfer\.sh: Easy and fast file sharing from the command\-line\.](https://github.com/dutchcoders/transfer.sh/#link-aliases)
      - 一開始拿到的 URL  在 `https://transfer.sh/` 後面安插 `get/` 與 `inline/` 就可以區分 direct download link 與 inline file/link。
      - 實驗確認，direct download link 就不會看 `Accept` header，貼在 browser 會直接下載；但後者 inline link 都會遇到 404 Not Found。

## Docker ??

  - [dutchcoders/transfer\.sh: Easy and fast file sharing from the command\-line\.](https://github.com/dutchcoders/transfer.sh/#docker) 官方直接提供有 Docker image

        docker run --publish 8080:8080 dutchcoders/transfer.sh:latest --provider local --basedir /tmp/

## 參考資料

  - [transfer.sh](https://transfer.sh/)
  - [dutchcoders/transfer.sh - GitHub](https://github.com/dutchcoders/transfer.sh/)
  - [dutchcoders/transfer.sh - Docker Hub](https://hub.docker.com/r/dutchcoders/transfer.sh/)
