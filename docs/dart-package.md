---
title: Dart / Package
---
# [Dart](dart.md) / Package

  - [Libraries \| Dart](https://www.dartlang.org/guides/libraries)
      - You can get additional libraries by importing them FROM PACKAGES. 從 package 裡才能引用 library??

  - [Create Library Packages \| Dart](https://www.dartlang.org/guides/libraries/create-library-packages)
      - In the Dart ecosystem, libraries are created and DISTRIBUTED AS PACKAGES. Dart has two kinds of packages: APPLICATION PACKAGES, which may include LOCAL LIBRARIES, and LIBRARY PACKAGES.

        顯然 package 跟 distribution 有關，所以 library 不一定要是 package，也可以是 local library。

  - [Glossary of Pub Terms \| Dart](https://www.dartlang.org/tools/pub/glossary)

    Application pacakge

      - A package that is not intended to be used as a library. Application packages may have DEPENDENCIES ON OTHER PACKAGES, but are never depended on themselves. They are usually meant to be RUN DIRECTLY, either on the command line or in a browser. The opposite of an application package is a library package.

        對照 library package 中 "other packages will depend on" 的說法，這裡 "other packages" 一定是 library package。

      - Application packages SHOULD check their lockfiles into source control, so that everyone working on the application and every location the application is deployed has a consistent set of dependencies. Because their dependencies are constrained by the lockfile, application packages usually specify `any` for their dependencies’ version constraints. 應該會指定版本，怎會是 `any`??

    Library package

      - A package that other packages will depend on. Library packages may have dependencies on other packages and may be dependencies themselves. They may also include SCRIPTS that will be run directly. The opposite of a library package is an application package.
      - Library packages SHOULD NOT check their lockfile into source control, since they should support A RANGE OF DEPENDENCY VERSIONS. Their IMMEDIATE dependencies’ version constraints should be AS WIDE AS POSSIBLE while still ensuring that the dependencies will be compatible with the versions that were TESTED AGAINST.

        最後一句 "compatible with the versions that were tested against" 很有意思 -- 雖然測試只挑最小支援版本，但相容的版本也含括在內了。

      - Since SEMANTIC VERSIONING requires that libraries increment their major version numbers for any backwards incompatible changes, library packages will usually require their dependencies’ versions to be greater than or equal to the versions that were TESTED and less than the next major version. So if your library depended on the (fictional) `transmogrify` package and you tested it at version 1.2.1, your version constraint would be `^1.2.1`.

        其中 `^1.2.1` 讀做 1.2.1 ~ 2.0.0 但不含 2.0.0。

  - [Install Shared Packages \| Dart](https://www.dartlang.org/tutorials/libraries/shared-pkgs) #ril

## 參考資料 {: #reference }

  - [Dart Packages](https://pub.dartlang.org/)
  - [Pub Package Manager](https://www.dartlang.org/tools/pub)

手冊：

  - [Glossary of Pub Terms | Dart](https://www.dartlang.org/tools/pub/glossary)
