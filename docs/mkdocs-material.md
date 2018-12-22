# Material for MkDocs

## 新手上路 ?? {: #getting-started }

  - [Retrace \- Configurable retrying\.](http://d0ugal.github.io/retrace/) 套用 Materials 的效果不錯
      - [retrace/mkdocs\.yml at master · d0ugal/retrace](https://github.com/d0ugal/retrace/blob/master/mkdocs.yml) #ril
      - [retrace/index\.md at master · d0ugal/retrace](https://github.com/d0ugal/retrace/blob/master/docs/index.md) #ril

## 安裝設定 {: #installation }

平時寫作：

```
$ docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material
$ open http://localhost:8000
```

產生網站：

```
$ docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build
```

參考資料：

  - [squidfunk/mkdocs\-material \- Docker Hub](https://hub.docker.com/r/squidfunk/mkdocs-material/)
      - Mount the folder where your `mkdocs.yml` resides as a volume into `/docs`，把 `mkdocs.yml` 所在的目錄放進 `/docs`；由於 `mkdocs.yml` 所在的目錄底下也有 `/docs` (`docs_dir`)，注意別弄錯對象。
      - [squidfunk/mkdocs\-material \- Docker Hub](https://hub.docker.com/r/squidfunk/mkdocs-material/~/dockerfile/) 幾個關鍵的設定 `WORKDIR /docs`、`EXPOSE 8000`、`ENTRYPOINT ["mkdocs"]` 及 `CMD ["serve", "--dev-addr=0.0.0.0:8000"]`
      - 平常開發發用 `docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material`，產生網站則用 `docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build`。

## 參考資料 {: #reference }

  - [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
