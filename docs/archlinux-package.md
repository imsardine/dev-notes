---
title: Arch Linux / Package Management
---
# [Arch Linux](archlinux.md) / Package Management

  - [Package Management in Arch Linux with Pacman - Linux Package Management](https://www.linode.com/docs/tools-reference/linux-package-management/#package-management-in-arch-linux-with-pacman) #ril

## Pacman ??

  - [Pacman Home Page](https://www.archlinux.org/pacman/)

      - pacman is a utility which manages software packages in Linux. It uses SIMPLE COMPRESSED FILES as a package format, and maintains a TEXT-BASED PACKAGE DATABASE (more of a hierarchy), just in case some hand tweaking is necessary.
      - pacman does not strive to "do everything." It will add, remove and upgrade packages in the system, and it will allow you to query the package database for INSTALLED PACKAGES, FILES AND OWNERS??. It also attempts to handle DEPENDENCIES automatically and can download packages FROM A REMOTE SERVER.

    History

      - Version 2.0 of pacman introduced the ability to SYNC packages (the `--sync` option) with a MASTER SERVER through the use of package databases. Prior to this, packages would have to be installed manually using the `--add` and `--upgrade` operations.

        從現在 Pacman 5.1.3 的說明看來，`--upgrade` 接受 URL 或 file path，但沒有 `--add`。

      - Version 3.0 was the switch to a TWO-PART pacman — a BACK-END named `libalpm` (library for Arch Linux Package Management) and the familiar `pacman` FRONT-END. Speed in many cases was improved, along with dependency and conflict resolution being able to handle a much wider variety of cases. The switch to a library-based program should also make it easier in the future to develop ALTERNATIVE FRONT ENDS.
      - Version 4.0 added package signing and verification capabilities to the entire `makepkg`/`repo-add`/`pacman` TOOLCHAIN via GnuPG and GPGME.

      - Version 5.0 added support for PRE/POST-TRANSACTION HOOKS and sync database file list operations.

        5.0 版在 2016-01-30 釋出。

  - [pacman\(8\)](https://www.archlinux.org/pacman/pacman.8.html) 先簡單聊解一下它的用法，因為 CLI 的體驗比較不同 #ril

      - `pacman <operation> [options] [targets]`
      - CLI 的體驗有點特別，因為現有的 `<operation>` 看起來像是 option (例如 `-Q, --query`)，而真正的 option 像是 `-s, --search <regexp>`，因此會有像是 `pacman -Ss keyword` (找 package database) 或 `pacman -Qs keyword` (找已安裝的套件) 的用法。

      - Man page 一開始有點難懂，關鍵在於識別出 "XXX Options (apply to -A, -B and -C)" 的區段，以上面 `-Ss` 與 `-Qs` 中的 `-s` 可以分別在 "Sync Options (apply to -S)" 與 "Query Options (apply to -Q)" 找到。

          - `-s, --search <regexp>` (`-S`) - This will search each package in the SYNC DATABASES for names or descriptions that match regexp.
          - `-s, --search <regexp>` (`-Q`)- Search each LOCALLY-INSTALLED PACKAGE for names or descriptions that match regexp.

      - 常用的操作還有 `-Si <package>` (查看套件說明)、`-Sg <group>` 查看 group 成員。

  - [pacman \- ArchWiki](https://wiki.archlinux.org/index.php/pacman) #ril

      - The pacman package manager is one of the major distinguishing features of Arch Linux. It combines a simple BINARY PACKAGE FORMAT with an easy-to-use build system. The goal of pacman is to make it possible to easily manage packages, whether they are from the official repositories or the USER'S OWN BUILDS.
      - Pacman keeps the system up to date by synchronizing package lists with the MASTER SERVER. This server/client model also allows the user to download/install packages with a simple command, complete with all required dependencies.
      - Pacman is written in the C programming language and uses the [bsdtar(1)](https://jlk.fjfi.cvut.cz/arch/manpages/man/bsdtar.1) TAR FORMAT for packaging.
      - Tip: The pacman package contains tools such as `makepkg` and `vercmp`. Other useful tools such as `pactree` and `checkupdates` are found in `pacman-contrib` (formerly part of pacman). Run `pacman -Ql pacman pacman-contrib | grep -E 'bin/.+'` to see the full list.

## 參考資料 {: #reference }

  - [pacman](https://www.archlinux.org/pacman/)

手冊：

  - [pacman(8)](https://www.archlinux.org/pacman/pacman.8.html)
