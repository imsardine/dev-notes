# PyPICloud

## Proxy / Fallback ??

  - [pypi.fallback - Configuration Options — pypicloud 1\.0\.8 documentation](https://pypicloud.readthedocs.io/en/latest/topics/configuration.html#pypi-fallback)

      - Argument: {`redirect`, `cache`, `none`}, optional
      - This option defines what the behavior is when a REQUESTED PACKAGE IS NOT FOUND in the database. (default `redirect`)
      - `redirect` - Return a 302 to the package at the `fallback_base_url`.

        `redirect` 會回 302 轉到 `fallback_base_url` 的位置 (預設是 `https://pypi.python.org`)，也難怪之前用 `pip install -i your_pypicloud_server` 就可以裝到 PyPI 上的套件，不必採用 `--extra-index-url`，還滿方便的。

      - `cache` - Download the package from `fallback_base_url`, store it in the backend, and serve it. User must have `cache_update` permissions.
      - `none` - Return a 404

  - [Fallbacks — pypicloud 1\.0\.11 documentation](https://pypicloud.readthedocs.io/en/latest/topics/fallback.html) 好複雜的 matrix! #ril

## 參考資料 {: #reference }

  - [stevearc/pypicloud - GitHub](https://github.com/stevearc/pypicloud)

文件：

  - [PyPICloud - Read the Docs](https://pypicloud.readthedocs.io/en/latest/index.html)

手冊：

  - [Configuration Options](https://pypicloud.readthedocs.io/en/latest/topics/configuration.html)
