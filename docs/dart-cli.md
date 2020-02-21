---
title: Dart / CLI
---
# [Dart](dart.md) / CLI

  - [Running an app with the standalone Dart VM - Write command\-line apps \| Dart](https://dart.dev/tutorials/server/cmdline#running-an-app-with-the-standalone-dart-vm)

      - To run a command-line app, you need the Dart VM (`dart`), which comes when you install the Dart SDK.

        Important: The location of the SDK installation directory (we’ll call it `<sdk-install-dir>`) depends on your platform and how you installed the SDK. You can find `dart` in `<sdk-install-dir>/bin`. By putting this directory in your `PATH` you can refer to the `dart` command and other commands, such as `dartanalyzer`, by name.

      - Let’s run a small program.

        Create a file called `helloworld.dart` that contains this code:

            void main() {
              print('Hello, World!');
            }

        In the directory that contains the file you just created, run the program:

            $ dart helloworld.dart
            Hello, World!

        The Dart VM supports many options. Use `dart --help` to see COMMONLY USED options. Use `dart --verbose` to see ALL options.

  - [Command\-line & server apps \| Dart](https://dart.dev/server) #ril

## 安裝設置 {: #setup }

  - [Install Dart \| Dart](https://www.dartlang.org/install)
      - Although DartPad is a great way to learn how to write a simple app, once you’re ready to develop REAL apps, you need an SDK. Install the SDK for your platform.

        To develop xxx apps, get the Dart SDK. 唯獨 mobile 比較特別稱做 Flutter SDK，其他 web/command-line/server-side apps 都稱做 Dart SDK，雖然 web 與 command-line/server-side 的 SDK 並不相同。

### Mac

用 Homebrew 從 [`dart-lang/dart`](https://github.com/dart-lang/homebrew-dart) 安裝 `dart` 套件：

```
$ brew tap dart-lang/dart
$ brew install dart
```

---

參考資料：

  - [Mac - Dart SDK \| Dart](https://www.dartlang.org/tools/sdk#tab-sdk-install-mac)
      - Install homebrew, and then run:

            $ brew tap dart-lang/dart
            $ brew install dart

        `dart` 套件的內容：

            $ brew info dart
            dart-lang/dart/dart: stable 2.1.0, devel 2.1.1-dev.3.2
            The Dart SDK
            https://www.dartlang.org/
            Not installed
            From: https://github.com/dart-lang/homebrew-dart/blob/master/dart.rb
            ==> Options
            --devel
                Install development version 2.1.1-dev.3.2
            ==> Caveats
            Please note the path to the Dart SDK:
              /usr/local/opt/dart/libexec

      - To upgrade when a new release of Dart is available run:

            $ brew upgrade dart

### Linux

```
$ vagrant init ubuntu/bionic64
$ vagrant up
$ vagrant ssh

vagrant$ curl -O https://storage.googleapis.com/dart-archive/channels/stable/release/latest/linux_packages/dart_2.1.0-1_amd64.deb
vagrant$ sudo dpkg -i dart_2.1.0-1_amd64.deb
Selecting previously unselected package dart.
(Reading database ... 59746 files and directories currently installed.)
Preparing to unpack dart_2.1.0-1_amd64.deb ...
Unpacking dart (2.1.0-1) ...
Setting up dart (2.1.0-1) ...

vagrant$ which dart
/usr/bin/dart

vagrant$ which pub # not found?
vagrant$ ls -l /usr/bin | grep dart
lrwxrwxrwx 1 root   root          20 Nov 13 18:25 dart -> ../lib/dart/bin/dart

vagrant$ export PATH=$PATH:/usr/lib/dart/bin
vagrant$ which pub
/usr/lib/dart/bin/pub
```

---

參考資料：

  - [Linux - Dart SDK \| Dart](https://www.dartlang.org/tools/sdk#tab-sdk-install-mac)
      - If you’re using Debian/Ubuntu on AMD64 (64-bit Intel), you can choose one of the following options, both of which can update the SDK automatically when new versions are released.

    Install a Debian package

      - Alternatively, download Dart SDK as Debian package in the `.deb` package format.
      - After installing the SDK, add its `bin` directory to your `PATH`. For example, use the following command to change `PATH` in your active terminal session: `$ export PATH="$PATH:/usr/lib/dart/bin"`

        因為 `/usr/bin` 下只有 `dart`，連常用的 `pub` 都沒有。

### Docker

```
$ docker run --rm -it google/dart:2.1.0 dart --version
Dart VM version: 2.1.0 (Unknown timestamp) on "linux_x64"
```

---

參考資料：

  - [google/dart \- Docker Hub](https://hub.docker.com/r/google/dart/)

      - `google/dart` is a docker base image that bundles the latest version of the Dart SDK installed from dartlang.org. It serves as a base for the [`google/dart-runtime`](https://hub.docker.com/r/google/dart-runtime) image.

      - If you have an APPLICATION DIRECTORY with a `pubspec.yaml` file and the main aplication entry point in `main.dart` you can create a `Dockerfile` in the application directory with the following content:

            FROM google/dart

            WORKDIR /app

            ADD pubspec.* /app/
            RUN pub get
            ADD . /app
            RUN pub get --offline

            CMD []
            ENTRYPOINT ["/usr/bin/dart", "main.dart"]

      - However, if you application directory has a layout like this and potentially is exposing a server at port 8080 you should consider using the base image `google/dart-runtime` instead. 即 server-side Dart 的應用。

        呼應 `google/dart-runtime` 的說法 -- `google/dart-runtime` is a docker base image that makes it easy to DOCKERIZE A STANDARD DART APPLICATION.

  - `google/dart` 沒有設定 `ENTRYPOINT`，只有 `CMD`：

        $ docker inspect google/dart:2.1.0 | jq '.[0]["Config"]["Entryoint"]'
        null

        $ docker inspect google/dart:2.1.0 | jq '.[0]["Config"]["Cmd"]'
        [
          "/bin/sh",
          "-c",
          "/bin/bash"
        ]

## 參考資料 {: #reference }

相關：

  - [VM](dart-vm.md)
