# Alpine Linux

  - [index \| Alpine Linux](https://alpinelinux.org/) 強調 Small & Secure & Secure，基於 [musl libc](https://www.musl-libc.org/) 與 [busybox](busybox.md)。
  - [about \| Alpine Linux](https://alpinelinux.org/about/) 相較一般 GNU/Linux 更為 resource efficient，有完整的 Linux 環境，repository 裡也有一堆 package 可供安裝 (使用 apk 這個 package manager)。"Binary packages are thinned out and split" 與 "crystal-clear Linux environment without all the noise" 指預裝的 package 不多，需要的時候才裝，呼應了 "try to stay out of your way" 的說法。

## 跟 Docker 的關係??

  - [library/docker \- Docker Hub](https://hub.docker.com/_/docker/) Docker in Docker! 用了 `FROM alpine:3.6` #ril
  - [Dockerfile Alpine Linux Cheat Sheet \- Logical Solutions](https://spock.rocks/tech/2016/03/30/docker-alpine-cheat-sheet.html) (2016-03-30) #ril

## apk??

  - [Alpine Linux package management \- Alpine Linux](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management) "designed to run from RAM" 與 "on a running system" 的說法好特別 #ril

## 安裝設定 {: #installation }

### Docker

```
docker run --rm -it alpine
```

例如：

```
$ docker run --rm -it alpine
/ # apk add --no-cache make
fetch http://dl-cdn.alpinelinux.org/alpine/v3.7/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.7/community/x86_64/APKINDEX.tar.gz
(1/1) Installing make (4.2.1-r0)
Executing busybox-1.27.2-r6.trigger
OK: 4 MiB in 12 packages
/ #
```

參考資料：

  - [library/alpine \- Docker Hub](https://hub.docker.com/_/alpine/) 以自製 image 為例 `FROM alpine:3.5` 跟 `FROM ubuntu:16.04` 差了快 150 MB。因為 `CMD ["/bin/sh"]` 的關係，直接執行就可用。

## 參考資料 {: #reference }

  - [Alpine Linux](https://alpinelinux.org/)

手冊：

  - [Alpine packages](https://pkgs.alpinelinux.org/packages)
