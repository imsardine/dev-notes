# Reproducible/Deterministic Build

  - [mkdocs/pages\.py at 1\.0\.4 · mkdocs/mkdocs](https://github.com/mkdocs/mkdocs/blob/1.0.4/mkdocs/structure/pages.py#L39) 由 `SOURCE_DATE_EPOCH` 決定，或是取當下系統時間；也就是重新產生就更新，或許可以把最後一個 commit 的時間寫進 `SOURCE_DATE_EPOCH`，就能達成 reproducible build 的效果。

        # Support SOURCE_DATE_EPOCH environment variable for "reproducible" builds.
        # See https://reproducible-builds.org/specs/source-date-epoch/
        if 'SOURCE_DATE_EPOCH' in os.environ:
            self.update_date = datetime.datetime.utcfromtimestamp(
                int(os.environ['SOURCE_DATE_EPOCH'])
            ).strftime("%Y-%m-%d")
        else:
            self.update_date = datetime.datetime.now().strftime("%Y-%m-%d")

## 參考資料

  - [reproducible-builds.org](https://reproducible-builds.org/)
