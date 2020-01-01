---
title: Docker / buildpack-deps
---
# [Docker](docker.md) / buildpack-deps

  - [library/buildpack\-deps \- Docker Hub](https://hub.docker.com/_/buildpack-deps/)

      - A collection of common build dependencies used for installing various modules, e.g., gems.
      - `buildpack-deps` 跟 Heroku 的 stack images 很像? 預裝了許多 Ruby Gems、PyPI modules 等需要用到的 development header 套件。
      - This stack is designed to be the foundation of a language-stack image. 也難怪 [`node`](https://hub.docker.com/_/node/) 跟 [`python`](https://hub.docker.com/_/python/) 預設都是基於 `buildpack-deps`。
      - The main tags of this image are the FULL BATTERIES-INCLUDED approach. With them, a majority of arbitrary `gem install` / `npm install` / `pip install` should be successful without additional header/development packages. 聽起來很適合用來開發。
      - 比較 `bionic`、`bionic-curl`、`bionic-scm` 的 `Dockerfile` 後才發現，原來其間的關係是 `bionic-curl` <-- (FROM) -- `bionic-scm` <-- (FROM) -- `bionic`，也就是說 `bionic` 是裝最多東西的 -- 這應該就是上面講的 "the main tags"，呼應 "For some language stacks, that doesn't make sense ... where these other smaller variants can come in handy" 帶出了 2 個 variants -- `curl` 與 `scm`。

## 參考資料 {: #reference }

  - [library/buildpack-deps - Docker Hub](https://hub.docker.com/_/buildpack-deps/)
  - [docker-library/buildpack-deps](https://github.com/docker-library/buildpack-deps)

