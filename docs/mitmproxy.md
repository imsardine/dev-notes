# mitmproxy

  - [mitmproxy \- an interactive HTTPS proxy](https://mitmproxy.org/)

      - mitmproxy is a free and open source INTERACTIVE HTTPS PROXY.
      - mitmproxy is your swiss-army knife for debugging, testing, privacy measurements, and penetration (滲透) testing. It can be used to intercept, inspect, MODIFY and REPLAY web traffic such as HTTP/1, HTTP/2, WebSockets, or any other SSL/TLS-protected protocols.

      - You can PRETTIFY and DECODE a variety of message types ranging from HTML to Protobuf, intercept specific messages on-the-fly, modify them before they reach their destination, and replay them to a client or server later on.

        透過 add-on 也可以自訂 decoder。

    Web Interface

      - Use mitmproxy's main features in a graphical interface with `mitmweb`. Do you like Chrome's DevTools? `mitmweb` gives you a similar experience for any other application or device, plus additional features such as request interception and replay.

    Python API

      - Write powerful ADDONS and script mitmproxy with `mitmdump`. The scripting API offers full control over mitmproxy and makes it possible to automatically modify messages, redirect traffic, visualize messages, or implement custom commands.

    Powerful Ecosystem

      - Mitmproxy powers a number of notable open-source projects:

          - pathod, mitmproxy's sister project to craft MALFORMED HTTP/1, HTTP/2 and WebSocket requests.
          - netograph, a privacy analysis and measurement service.
          - tamper, a Chrome extension that lets you edit remote files locally.
          - bdfproxy, a BackDoorFactory integration to patch binaries with shell code on the fly.
          - mastermind, a project from ustwo that offers an easy way to MOCK an API or a website

  - [Introduction - mitmproxy Docs](https://docs.mitmproxy.org/stable/)

      - The mitmproxy project’s tools are a set of FRONT-ENDS that expose common underlying functionality.

          - mitmproxy is an INTERACTIVE man-in-the-middle proxy for HTTP and HTTPS with a CONSOLE INTERFACE.
          - mitmdump is the COMMAND-LINE VERSION of mitmproxy. Think tcpdump for HTTP.
          - mitmweb is a WEB-BASED INTERFACE for mitmproxy.

        `mitmproxy` (man-in-the-middle proxy) 提供 console interface (也就是 TUI)，`mitmdump` 才是 CLI，而 `mitmweb` 則提供 web UI。

    Features

      - Intercept HTTP & HTTPS requests and responses and modify them on the fly
      - Save complete HTTP conversations for later replay and analysis
      - Replay the client-side of an HTTP conversations
      - Replay HTTP responses of a previously recorded server
      - REVERSE PROXY MODE to forward traffic to a specified server
      - TRANSPARENT PROXY MODE on OSX and Linux 跟 reverse proxy 有什麼不同?? 應用情境?
      - Make scripted changes to HTTP traffic using Python
      - SSL/TLS certificates for interception are generated on the fly

  - [Mitmproxy 3](https://mitmproxy.org/posts/releases/mitmproxy3/) #ril

## 原理，如何防止 MITM 介入 ?? {: #how-it-works }

  - [Features - Introduction - mitmproxy Docs](https://docs.mitmproxy.org/stable/#features)

      - SSL/TLS certificates for interception are GENERATED ON THE FLY

  - [Certificates - mitmproxy Docs](https://docs.mitmproxy.org/stable/concepts-certificates/)

      - Mitmproxy can decrypt encrypted traffic on the fly, AS LONG AS THE CLIENT TRUSTS ITS BUILT-IN CERTIFICATE AUTHORITY. Usually this means that the mitmproxy CA certificates have to be installed on the client device.

    The mitmproxy certificate authority

      - The first time `mitmproxy` or `mitmdump` is run, the mitmproxy Certificate Authority (CA) is created in the CONFIG DIRECTORY (`~/.mitmproxy` by default). This CA is used for on-the-fly generation of dummy certificates FOR EACH OF THE SSL SITES that your client visits.

      - Since your browser won’t trust the mitmproxy CA out of the box, you will see an SSL certificate warning every time you visit a new SSL domain through mitmproxy.

        When you are testing a single site through a browser, just accepting the bogus SSL cert manually is not too much trouble, but there are a many circumstances where you will want to configure your testing system or browser to trust the mitmproxy CA as a signing root authority. For security reasons, the mitmproxy CA is generated UNIQUELY ON THE FIRST START and is NOT SHARED between mitmproxy installations on different devices.

        如果不想重啟 mitmproxy 後又要再信任一次 CA，建議把 `~/.mitmproxy` 下的 certificate 存起來。

    Certificate Pinning

      - Some applications employ CERTIFICATE PINNING to prevent man-in-the-middle attacks. This means that mitmproxy and mitmdump’s certificates will not be accepted by these applications without modifying them.

        It is recommended to use the PASSTHROUGH FEATURE in order to prevent mitmproxy and mitmdump from intercepting traffic to these specific domains. If you want to intercept the pinned connections, you need to PATCH THE APPLICATION MANUALLY. For Android and (jailbroken) iOS devices, various tools exist to accomplish this.

    CA and cert files

      - The files created by mitmproxy in the `.mitmproxy` directory are as follows:

          - `mitmproxy-ca.pem` -- The certificate and the private key in PEM format.
          - `mitmproxy-ca-cert.pem` -- The certificate in PEM format. Use this to distribute on most non-Windows platforms.
          - `mitmproxy-ca-cert.p12` -- The certificate in PKCS12 format. For use on Windows.
          - `mitmproxy-ca-cert.cer` -- Same file as `.pem`, but with an extension expected by some Android devices.

        都是同一個 certificate，只是格式不同而已。

  - [\[Mitmproxy\] Android Apps \- help \- mitmproxy](https://discourse.mitmproxy.org/t/mitmproxy-android-apps/740) (2017-11-29) certificate pinning，比對之前保留的 server certificate #ril
  - [Man\-in\-the\-middle attack \- Wikipedia](https://en.wikipedia.org/wiki/Man-in-the-middle_attack) #ril

## Onboarding App ??

  - [mitmproxy\(1\) — mitmproxy — Debian stretch — Debian Manpages](https://manpages.debian.org/stretch/mitmproxy/mitmproxy.1.en.html#Onboarding_App:) 原來 onboarding app 就是 `http://mitm.it`，也是可以調整的。
  - [Addons](https://docs.mitmproxy.org/stable/addons-overview/) 提到 onboarding webapp 也是 addon。
  - [mitmproxy/onboarding\.py at master · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/blob/master/mitmproxy/addons/onboarding.py) 確實是 `mitmproxy/addons/` 的一員。
  - [Available Options - Options](https://docs.mitmproxy.org/stable/concepts-options/#available-options) 當然也有些 options (`onboarding*`) 可以調整。

## mitmproxy

  - mitmproxy 一開始，畫面左上角就寫著 Flows，按任一個 request 就會切換到 Flow Details。
  - 按 `?` 可以顯示按鍵說明，上下鍵可以選定一個 entry (request + response)
  - 按 `-` 可以快速切換 layout，同時看見 flows 跟 event logs 還滿方便的。
  - 如何查詢 request 跟 response 的細節?
      - 選定後按 Enter 即可進入，用 Tab 可以在 Request/Response/Detail 間切換。
      - 按 `b` 可以另存檔案 (看當時在那個 tab)

## mitmdump ??

  - [mitmdump - mitmproxy Docs](https://docs.mitmproxy.org/stable/tools-mitmdump/) #ril

      - mitmdump is the COMMAND-LINE COMPANION to mitmproxy. It provides tcpdump-like functionality to let you view, record, and programmatically transform HTTP traffic. See the `--help` flag output for complete documentation.

        `mitmproxy` 是個 TUI，真正的 CLI 是 `mitmdump`。

## mitmweb ??

  - [Web Interface - mitmproxy \- an interactive HTTPS proxy](https://mitmproxy.org/#mitmweb) 在 https://8081 也有個 web interface #ril

## Option ??

  - [Options](https://docs.mitmproxy.org/stable/concepts-options/) #ril
      - Option 機制跟 mitmproxy 執行期的行為有關，許多 command-line flag 會對應到底層的 option，在 interactive tool (mitmproxy/mitmweb) 下調整設定也是改變 option 的值。
      - 不同的 mitmproxy 工具共用一個 (central) configuration file (`~/.mitmproxy/config.yaml`)，可以設定不同 option 的初始值。
      - 要取得 option 的手冊，只要執行 mitmproxy tool 時加上 `--options`，就會傾印 annotated YAML configuration -- 每個 option 都有註解說明 (標示 type)，也明確帶有預設值。例如 `mitmdump --options`
      - Option 機制是可被擴充的，3rd-party addon 可以定義自己的 option，使用上就跟 mitmproxy 自己的 option 沒有兩樣。這意謂著，addon 可以透過 configuration file 組態，它所提供的 option 也會出現 interactive tool 的 option editor 裡。

## API Mocking ??

  - [How to easily mock up new backend systems \| ustwo](https://www.ustwo.com/blog/how-to-easily-mock-up-new-backend-systems/) (2016-05-03) #ril
  - [meituan/lyrebird: Lyrebird 是一个基于拦截以及模拟HTTP/HTTPS网络请求的面向移动应用的插件化测试平台](https://github.com/meituan/lyrebird) 基於 mitmproxy #ril

## 安裝設置 {: #setup }

### macOS

用 Homebrew 安裝/升級 `mitmproxy` 套件：

```
brew install mitmproxy
brew upgrade mitmproxy
```

參考資料：

  - [macOS - Installation](https://docs.mitmproxy.org/stable/overview-installation/#macos) 建議用 Homebrew 安裝 `mitmproxy` 套件。
  - 觀察 `brew install mitmproxy` 的輸出，有點複雜!! (相依 OpenSSH、Python 3 等) 感覺用 Docker 安裝會單純一些? 也不會弄髒系統。

### Docker

  - [Docker Images - Installation](https://docs.mitmproxy.org/stable/overview-installation/#docker-images) 官方提供有 Docker image。

  - [mitmproxy/mitmproxy \- Docker Hub](https://hub.docker.com/r/mitmproxy/mitmproxy/)

      - Containerized version of mitmproxy, an interactive SSL-capable intercepting HTTP proxy.

    Usage

        $ docker run --rm -it [-v ~/.mitmproxy:/home/mitmproxy/.mitmproxy] -p 8080:8080 mitmproxy/mitmproxy

      - The volume mount is optional: It's to store the generated CA certificates.

        要透過 http://mitm.it 安裝 certificate 的話，存起來會比較方便。

      - Once started, mitmproxy listens as a HTTP proxy on localhost:8080:

            $ http_proxy=http://localhost:8080/ curl http://example.com/
            $ https_proxy=http://localhost:8080/ curl -k https://example.com/

        接下來試 `https_proxy=http://localhost:8080/ curl -k https://example.com/`；若少了 `-k` (`--insecure`)，curl 會丟出 `curl: (60) SSL certificate problem: self signed certificate in certificate chain` 的錯誤。

      - You can also start mitmdump by just adding that to the end of the command-line:

            $ docker run --rm -it -p 8080:8080 mitmproxy/mitmproxy mitmdump

      - For mitmweb, you also need to expose port 8081:

            # this makes :8081 accessible to the local machine only
            $ docker run --rm -it -p 8080:8080 -p 127.0.0.1:8081:8081 mitmproxy/mitmproxy mitmweb --web-iface 0.0.0.0

        看起來 web UI 同時也把 proxy 執行起來了，所以 port mapping 才要分開做，8080 是給 proxy，而 8081 則是給 web UI

      - You can also pass options directly via the CLI:

            $ docker run --rm -it -p 8080:8080 mitmproxy/mitmproxy mitmdump --set ssl_insecure=true

  - [mitmproxy/Dockerfile at master · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/blob/master/release/docker/Dockerfile)

      - `ENTRYPOINT` 是 `docker-entrypoint.sh`，而 `CMD` 是 `mitmproxy`。
      - `VOLUME /home/mitmproxy/.mitmproxy` 會有一些資料寫在這裡；不過 anonymous volume 似乎在 container 結束後就消失了??
      - 從 [`docker-entrypoint.sh`](https://github.com/mitmproxy/mitmproxy/blob/master/release/docker/docker-entrypoint.sh) 看來，可以接受 `mitmproxy`、`mitmdump` 及 `mitmweb`。

  - [mitmproxy/release/docker at master · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/tree/master/release/docker)

### Android

  - [Quick Setup - Certificates](https://docs.mitmproxy.org/stable/concepts-certificates/#quick-setup) #ril
      - By far the easiest way to install the mitmproxy certificates is to use the built-in certificate INSTALLATION APP. 什麼 app??
      - 但接著又說把 proxy 指向它，瀏覽 mitm.it (magic domain) 就可以下載 certificate；用 Docker 執行，每次執行的 certificate 都不同?
  - [mitmproxy does not see traffic from Android app · Issue \#2054 · mitmproxy/mitmproxy](https://github.com/mitmproxy/mitmproxy/issues/2054) 好像從 Android 7 (Nougat) 開始有問題? #ril
  - [Intercepting HTTPS traffic of Android Nougat Applications – serializethoughts](https://serializethoughts.com/2016/09/10/905/) (2016-09-10) #ril
  - [Android 7 Nougat and certificate authorities \| The JeroenHD blog](https://blog.jeroenhd.nl/article/android-7-nougat-and-certificate-authorities) (2016-08-24) #ril
  - [Can't mitmproxy with Android Nougat 7\.1\.1 \- help \- mitmproxy](https://discourse.mitmproxy.org/t/cant-mitmproxy-with-android-nougat-7-1-1/267/2) #ril
      - tomaspinho: 把 APK 解開，放入 XML 即可；用舊版的 Android 也可以。

### iOS

  - [Certificates](https://docs.mitmproxy.org/stable/concepts-certificates/)
      - Quick Setup 說一樣透過 magic domain `mitm.it` 下載 certificate。
      - 不過 Installing the mitmproxy CA certificate manually 額外提到 iOS 10.3+ 後還要對 mitmproxy root certificate 額外啟用 full trust；到 Settings > General > About > Certificate Trust Settings > 在 Enable full trust for root certificates (啟用根憑證的完整信任) 下啟用 mitmproxy certifcate 的 trust 即可。

## 參考資料 {: #reference }

  - [mitmproxy](https://mitmproxy.org/)
  - [mitmproxy/mitmproxy - GitHub](https://github.com/mitmproxy/mitmproxy)
  - [mitmproxy - PyPI](https://pypi.org/project/mitmproxy/)
  - [mitmproxy/mitmproxy - Docker Hub](https://hub.docker.com/r/mitmproxy/mitmproxy/)
  - [mitmproxy Blog](https://mitmproxy.org/posts/)

社群：

  - [mitmproxy - Discourse](https://discourse.mitmproxy.org/)
  - [mitmproxy Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/mitmproxy)
  - [mitmproxy (@mitmproxy) | Twitter](https://twitter.com/mitmproxy)

文件：

  - [mitmproxy Docs](https://docs.mitmproxy.org/stable/)
  - [Publications](https://mitmproxy.org/publications/) - 匯集了許多 talk、research

更多：

  - [Addon](mitmproxy-addon.md)
  - [Pathology](mitmproxy-pathology.md)

手冊：

  - [mitmproxy(1) - Debian Manpages](https://manpages.debian.org/stretch/mitmproxy/mitmproxy.1.en.html)
