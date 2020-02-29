# reveal-md

   - [webpro/reveal\-md: reveal\.js on steroids\! Get beautiful reveal\.js presentations from any Markdown file](https://github.com/webpro/reveal-md) #ril

      - reveal.js on steroids! (類固醇) Get beautiful reveal.js presentations from Markdown files.

## Hello, World! {: #hello }

`hello.md`:

```
# Hello, World!

---

## Hello, reveal-md!
```

這裡用 Docker 示範：

```
$ alias reveal-md="docker run --rm -v \${PWD}:/slides webpronl/reveal-md:latest"
$ reveal-md /slides/hello.md --static /slides/_static
❏ node_modules/reveal.js/css → /slides/_static/css
❏ node_modules/reveal.js/js → /slides/_static/js
❏ node_modules/reveal.js/plugin → /slides/_static/plugin
❏ node_modules/reveal.js/lib → /slides/_static/lib
❏ node_modules/highlight.js/styles/zenburn.css → /slides/_static/css/highlight/zenburn.css
★ /slides/_static/hello.html
∞ /slides/_static/hello.html → /slides/_static/index.html
Wrote static site to /slides/_static

$ ls -l _static/
total 8
drwxr-xr-x   8 jeremykao  wheel   256 Feb 29 14:48 css
-rw-r--r--@  1 jeremykao  wheel  2309 Feb 29 14:48 hello.html
lrwxrwxrwx   1 jeremykao  wheel    26 Feb 29 14:48 index.html -> /slides/_static/hello.html
drwxr-xr-x   3 jeremykao  wheel    96 Feb 29 14:48 js
drwxr-xr-x   5 jeremykao  wheel   160 Feb 29 14:48 lib
drwxr-xr-x  11 jeremykao  wheel   352 Feb 29 14:48 plugin

$ open _static/hello.html
```

## 新手上路 {: #getting-started }

## 安裝設置 {: #setup }

  - [Installation - webpro/reveal\-md: reveal\.js on steroids\! Get beautiful reveal\.js presentations from any Markdown file](https://github.com/webpro/reveal-md#installation)

        npm install -g reveal-md

## Generate

  - [Static Website - webpro/reveal\-md: reveal\.js on steroids\! Get beautiful reveal\.js presentations from any Markdown file](https://github.com/webpro/reveal-md#static-website) #ril

      - This will export the provided Markdown file into a STAND-ALONE HTML website including scripts and stylesheets. The files are saved to the directory passed to the `--static` parameter (default: `./_static`):

            reveal-md slides.md --static _site

      - This should copy images along with the slides. Use --static-dirs to copy directories with other static assets to the target directory. Use a comma-separated list to copy multiple directories.

reveal-md slides.md --static --static-dirs=assets
Providing a directory will result in a stand-alone overview page with links to the presentations (similar to a directory listing):

reveal-md dir/ --static
Additional --absolute-url and --featured-slide parameters could be used to generate OpenGraph metadata enabling more attractive rendering for slide deck links when shared in some social sites.

reveal-md slides.md --static _site --absolute-url https://example.com --featured-slide 5

## `reveal-md` CLI {: #cli }

```
$ reveal-md --help
Usage: cli <slides.md> [options]

See https://github.com/webpro/reveal-md for more details.

Options:
  -V, --version                               output the version number
      --title <title>                         Title of the presentation
  -s, --separator <separator>                 Slide separator [default: 3 dashes (---) surrounded by two blank lines]
  -S, --vertical-separator <separator>        Vertical slide separator [default: 4 dashes (----) surrounded by two blank lines]
  -t, --theme <theme>                         Theme [default: black]
      --highlight-theme <theme>               Highlight theme [default: zenburn]
      --css <files>                           CSS files to inject into the page
      --scripts <files>                       Scripts to inject into the page
      --assets-dir <dirname>                  Defines assets directory name [default: _assets]
      --preprocessor <script>                 Markdown preprocessor script
      --template <filename>                   Template file for reveal.js
      --listing-template <filename>           Template file for listing
      --print [filename]                      Print to PDF file
      --static [dir]                          Export static html to directory [_static]. Incompatible with --print.
      --static-dirs <dirs>                    Extra directories to copy into static directory. Only used in conjunction with --static.
  -w, --watch                                 Watch for changes in markdown file and livereload presentation
      --disable-auto-open                     Disable auto-opening your web browser
      --host <host>                           Host [default: localhost]
      --port <port>                           Port [default: 1948]
      --featured-slide <num>                  Capture snapshot from this slide (numbering starts from 1) and use it as og:image for static build. Defaults to first slide. Only used with --static.
      --absolute-url <url>                    Define url used for hosting static build. This is included in OpenGraph metadata. Only used with --static.
      --print-size                            Paper size to use in exported PDF files
      --puppeteer-launch-args <args>          Customize how Puppeteer launches Chromium. The arguments are specified as a space separated list (for example --puppeteer-launch-args="--no-sandbox --disable-dev-shm-usage"). Needed for some CI setups.
      --puppeteer-chromium-executable <path>  Customize which Chromium executable puppeteer will launch. Allows to use a globally installed version of Chromium.
  -h, --help                                  output usage information
```

### Docker

```
$ alias reveal-md="docker run --rm -v \${PWD}:/slides webpronl/reveal-md:latest"
```

參考資料：

  - [Docker - webpro/reveal\-md: reveal\.js on steroids\! Get beautiful reveal\.js presentations from any Markdown file](https://github.com/webpro/reveal-md#docker)

    You can use Docker to run this tool without needing Node.js installed on your machine. Run the public Docker image, providing your markdown slides as a volume. A few examples:

        docker run --rm -p 1948:1948 -v <path-to-your-slides>:/slides webpronl/reveal-md:latest
        docker run --rm -p 1948:1948 -v <path-to-your-slides>:/slides webpronl/reveal-md:latest --help

    The service is now running at http://localhost:1948.

  - [reveal\-md/Dockerfile at master · webpro/reveal\-md](https://github.com/webpro/reveal-md/blob/master/Dockerfile)

        WORKDIR /app
        ...
        ENTRYPOINT [ "node", "bin/reveal-md.js" ]
        CMD [ "/slides" ]

    預設參數為 `/slides` 但 CWD 卻在 `/app` 的安排很特別，會造成幾個問題：

        $ docker run ... -v <path-to-your-slides>:/slides webpronl/reveal-md:latest slides.md --static _site

      - 在 `/app` 下找不到 `slides.md`。
      - Static website 產生在 `/app/_site`，但掛進去的 volume 是在 `/slides` 對不起來。

    暫時可以寫明路徑來避開：

        $ docker run ... -v <path-to-your-slides>:/slides webpronl/reveal-md:latest /slides/slides.md --static slides/_site

  - [webpronl/reveal\-md \- Docker Hub](https://hub.docker.com/r/webpronl/reveal-md) #ril

## 參考資料 {: #reference }

  - [webpro/reveal-md - GitHub](https://github.com/webpro/reveal-md)

相關：

  - [reveal.js](revealjs.md)

手冊：

  - [`reveal-md` CLI Usage](#cli)
