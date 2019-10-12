# bumpversion

  - [Single\-sourcing the package version — Python Packaging User Guide](https://packaging.python.org/guides/single-sourcing-package-version/) 有外部 build tool 可以自動跳號 (改 source code、送 commit 等)，例如 bumpversion、changes、zest.releaser。
  - [bumpversion · PyPI](https://pypi.org/project/bumpversion/) A small command line tool to simplify releasing software by updating ALL VERSION STRINGS in your source code by the correct increment. Also creates COMMITS and TAGS: 面對 text file，所以跟程式語言無關；version format 可以組態。

## 應用實例 {: #powered-by }

  - [cookiecutter\-pypackage/setup\.cfg at master · audreyr/cookiecutter\-pypackage](https://github.com/audreyr/cookiecutter-pypackage/blob/master/setup.cfg) Cookiecutter 的 Python package template 採用 Bumpversion。
  - [Search · filename:\.bumpversion\.cfg](https://github.com/search?q=filename%3A.bumpversion.cfg)
  - [Search · filename:setup\.cfg bumpversion](https://github.com/search?q=filename%3Asetup.cfg+bumpversion) 將 bumpversion 設定寫在 `setup.py` 裡的用法也不少。

## 新手上路 ?? {: #getting-started }

  - [Bumpversion is automation for semantic versioning \- Atlassian Developers](https://developer.atlassian.com/blog/2016/02/bumpversion-is-automation-for-semantic-versioning/) (2016-02-10)
      - However, if you have already wired your build to use only 1 file, then you've already made semver easy. Don't add one more tool just on my say so. The more compelling usage is with a `.bumpversion.cfg` file in the repo. 如果專案版號只出現在一個檔案 (例如 `VERSION`)，就不需要動用 bumpversion。
      - 版號的源頭在 `.bumpversion.cfg`，變更版號透過 `bumpversion major|minor|patch`，就會一併調整 `[bumpversion:file:xxx]` 不同檔案內的版號：

        This file plays the same role as the previous `src/VERSION` file, in that it records what the current version is. But it also stores options for bumpversion that will PROPAGATE the version to other files.

            [bumpversion]
            current_version = 0.5.1

            [bumpversion:file:setup.py]
            [bumpversion:file:README.rst] # 不用自訂 pattern 也可以；事實上版號在檔案裡的識別度並不低

        實驗過，有路徑也沒問題，例如 `[bumpversion:file:app/v1/__init__.py]`；看來是相對於 `.bumpversion.cfg` 路徑表示法。

      - Bumpversion can do that with the `--commit` switch or the `commit = True` option in the `.bumpversion.cfg` file. you can save some time when trying out bumpversion by using the `--dry-run` option 當然事先要把 Git 的 configuration 做好 (author, email)；可以用 `git reset --hard HEAD~1` 回復
      - but there are options to account for alternate VERSIONING SCHEMES, or additions to standard semver, like alpha/beta builds or release candidates. 原來不只可以處理 semver。

  - [Usage - peritus/bumpversion: Version\-bump your software with a single command](https://github.com/peritus/bumpversion#usage) #ril

## `bumpversion` CLI ??

  - [Options - peritus/bumpversion: Version\-bump your software with a single command](https://github.com/peritus/bumpversion#options)
      - 大部份的 configuration 都可以從 CLI option 給，但 CLI 還額外提供了一些 options。
      - `--dry-run, -n` - Don't touch any files, just pretend. Best used with `--verbose`. 事實上，沒加 `--verbose` 看不到東西，working dir 有其他異動也會被擋下，所以通常會 `--dry-run --verbose --allow-dirty` 一起使用。
      - `--allow-dirty` - Normally, bumpversion will abort if the working directory is dirty to protect yourself from releasing unversioned files and/or overwriting unsaved changes. Use this option to override this check.
      - `--list` - List MACHINE READABLE information to stdout for consumption by other programs. 例如：

            current_version=0.0.18
            new_version=0.0.19

        不過跳版通常不會自動在 script 裡面做 (無法決定 major/minor/patch)，實際上的應用?

## Configuration ??

  - [Configuration - peritus/bumpversion: Version\-bump your software with a single command](https://github.com/peritus/bumpversion#configuration) #ril
  - [File specific configuration - peritus/bumpversion: Version\-bump your software with a single command](https://github.com/peritus/bumpversion#file-specific-configuration) 可以設定 `parse`/`serialize` 或 `search`/`replace`，給定不同的 pattern。

        [bumpversion]
        current_version = 1.5.6

        [bumpversion:file:requirements.txt]
        search = MyProject=={current_version}
        replace = MyProject=={new_version}

  - [Part specific configuration - peritus/bumpversion: Version\-bump your software with a single command](https://github.com/peritus/bumpversion#part-specific-configuration) 這裡的 part specific 跟 file specific 有什麼關係? #ril

## 安裝設置 {: #setup }

  - [Installation - peritus/bumpversion: Version\-bump your software with a single command](https://github.com/peritus/bumpversion#installation) 安裝 `bumpversion` 套件。

## Snippets

### `.bumpversion.cfg`

```
[bumpversion]
current_version = 1.0.0

[bumpversion:file:VERSION]

[bumpversion:file:myapp/__init__.py]
search = version = '{current_version}' # 可以省略
replace = version = '{new_version}'
```

### `Makefile`

```
# Parameters
BUMP =

# Internal variables
version = $(shell cat VERSION)

define docker_run
	docker run --rm --interactive --tty \
		--volume $(PWD):/workspace \
		$(docker_opts) \
		$(docker_image) $(1)
endef

bump-version: docker_opts += --volume ~/.gitconfig:/root/.gitconfig
bump-version:
ifeq ($(BUMP),)
	$(error BUMP=major|minor|patch make bumpversion)
endif
	$(call docker_run,bumpversion --commit $(BUMP))
```

用起來像是：

```
$ BUMP=patch make bump-version
$ git log -1 --pretty=oneline --abbrev-commit
8d129b1 (HEAD -> dev) Bump version: 1.0.0 → 1.0.1
```

## 參考資料 {: #reference }

  - [peritus/bumpversion - GitHub](https://github.com/peritus/bumpversion)
  - [bumpversion - PyPI](https://pypi.org/project/bumpversion/)

相關：

  - [Semantic Versioning](semver.md)

手冊：

  - [Configurations](https://github.com/peritus/bumpversion#configuration)
  - [CLI Options](https://github.com/peritus/bumpversion#options)
