# Dart

  - [Dart programming language \| Dart](https://www.dartlang.org/)

    Dart helps you craft beautiful, high-quality experiences ACROSS ALL SCREENS, with: 至少跨及 web 與 mobile

      - A client-optimized language -- Dart started out being optimized for web apps, and is evolving to provide great support for mobile apps. Dart also runs on the command line and server-side.

        為什麼 client-optimized 會是一項優勢? 但或許這也是為何 Dart 能從 web 一路發展到 mobile 的原因，也支援 ARM CPU。

      - Rich, powerful FRAMEWORKS -- For mobile apps, we recommend Flutter. For desktop apps, AngularDart.

        對 Dart 而言，web、mobile 等不同的 platform，只是不同的 framework。其中 AngularDart 是個 web app framework 而非 desktop?

      - Delightful, flexible tooling -- These range from general-purpose tools to FRAMEWORK-SPECIFIC ones like the `flutter` tool.

    Why Dart?

      - Developers at Google and elsewhere use Dart to create high-quality, mission-critical apps for iOS, Android, and the web. With features aimed at CLIENT-SIDE DEVELOPMENT, Dart is a great fit for both mobile and web apps.
      - Productive - Dart’s syntax is clear and concise, its tooling simple yet powerful. SOUND TYPING?? helps you to identify subtle errors early. Dart has battle-hardened CORE LIBRARIES and an ecosystem of thousands of packages.
      - Fast - Dart provides optimizing AHEAD-OF-TIME COMPILATION to get predictably high performance and fast startup across mobile devices and the web.
      - Portable -- Dart compiles to ARM and x86 code, so that Dart mobile apps can run NATIVELY ON IOS, ANDROID, and beyond. For web apps, Dart transpiles to JavaScript.

        就 iOS/Android 而言，並非轉譯成其他語言再編譯，而是直接編譯成 native code，但為何 Flutter 有 Dart VM Observatory 可以用??

      - Approachable - Dart is familiar to many existing developers, thanks to its unsurprising object orientation and syntax. If you already know C++, C#, or Java, you can be productive with Dart in just a few days.
      - Reactive?? -- Dart is well-suited to [REACTIVE PROGRAMMING](https://en.wikipedia.org/wiki/Reactive_programming), with support for managing short-lived objects—such as UI widgets—through Dart’s fast object allocation and generational garbage collector. Dart supports asynchronous programming through language features and APIs that use `Future` and `Stream` objects.

  - [Platforms \| Dart](https://www.dartlang.org/guides/platforms)
      - Dart is a SCALABLE language that you can use to write simple scripts or full featured apps. Whether you’re creating a mobile app, web app, command-line script, or server-side app, there’s a Dart solution for that.

        分為 Flutter、Web 跟 Server，其中 Flutter 跟 Web 都有獨立的網站，只有 Server 則在 www.dartlang.org 站內；Web 的全名是 Dart for the web，而 Server 的全名則是 Server-side Dart。

  - [Announcing Dart 2: Optimized for Client\-Side Development](https://medium.com/dartlang/announcing-dart-2-80ba01f43b6) (2018-02-23) #ril
  - [Why Flutter Uses Dart – Hacker Noon](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf) (2018-02-26) #ril

## 應用實例 {: #powered-by }

  - [Flutter](flutter.md)
  - [Who Uses Dart \| Dart](https://www.dartlang.org/community/who-uses-dart)

## 新手上路 ?? {: #getting-started }

  - [Get Started \| Dart](https://www.dartlang.org/guides/get-started)

        void main() {
          for (int i = 0; i < 5; i++) {
            print('hello ${i + 1}');
          }
        }

      會依序印出 `hello 1` ~ `hello 5`，這正是 DartPad 下 Hello World 的範例。

      - DartPad is a quick and easy way to become familiar with Dart language features.
      - Note that DartPad supports only a few core libraries. If you want to use other libraries, such as `dart:io` or libraries from packages, you’ll need to download platform-specific tools.
      - Learn about the Dart language and core libraries on this site. Once you have a use case in mind, go to the “get started” instructions for the appropriate Dart platform: 先弄懂 Dart 的基礎 (lang + core lib) 再往不同的 platform 移動。

  - [DartPad \| Dart](https://www.dartlang.org/tools/dartpad)
      - DartPad supports `dart:*` libraries that work with WEB APPS; it doesn’t support `dart:io` or libraries from packages. If you want to use `dart:io`, use the Dart SDK instead. If you want to use a package, get the SDK for a platform that THE PACKAGE SUPPORTS.

        難怪 [Dart Packages](https://pub.dartlang.org/) 套件會標示 `FLUTTER`、`WEB`、`OTHER` 等。

      - The language features and APIs that DartPad supports depend on the Dart SDK version that DartPad is based on. You can find the SDK version at the bottom right of DartPad.

        這裡的 Dark SDK 指的正是 Dart for the web。

    Open DartPad, and run some samples

      - A sample appears on the left and the output appears on the right. 右上角 Samples 下拉提供的範例並不多。
      - Choose an HTML sample like Sunflower, using the Samples list at the upper right. Again, the output appears to the right. By default, you see the HTML output—what you’d see in a browser.
      - Click CONSOLE to view the sample’s console output. On the left, click the HTML tab to view the sample’s HTML markup.

    Create a command-line app

      - Click the New Pad button, and confirm that you want to discard changes to the current pad.
      - Clear the SHOW WEB CONTENT checkbox, at the bottom right of DartPad. The HTML and CSS tabs disappear.

        原來不顯示 web content 就是 command-line app，不過 console 在 web app 下也會有。

      - Change the code. For example, change the `main()` function to contain this code:

            for (var char in 'hello'.split('')) {
              print(char);
            }

      - Click the Format button. DartPad uses the Dart formatter to ensure that your code has proper indentation, white space, and line wrapping.
      - If you didn’t happen to have any bugs while you were entering the code, try INTRODUCING A BUG.

        For example, if you change `split` to `spit`, you get warnings at the bottom of the window and in the Run button. If you run the app, you’ll see output from an UNCAUGHT EXCEPTION.

            Error compiling to JavaScript: <-- 印證了 SDK 是 Dart for the web 的說法
            main.dart:2:28:
            Error: The method 'spit' isn't defined for the class 'dart.core::String'.
              for (var char in 'hello'.spit('')) {
                                       ^^^^
            Error: Compilation failed.

  - [Sample Code \| Dart](https://www.dartlang.org/samples) #ril

## Language ??

  - [Language Tour \| Dart](https://www.dartlang.org/guides/language/language-tour) #ril
  - [Dart Language \| Dart](https://www.dartlang.org/guides/language) #ril
  - [Dart's Type System \| Dart](https://www.dartlang.org/guides/language/sound-dart) #ril
  - [Effective Dart \| Dart](https://www.dartlang.org/guides/language/effective-dart) #ril
  - [Dart Language Specification \| Dart](https://www.dartlang.org/guides/language/spec) #ril

## Core Library ??

  - [Library Tour \| Dart](https://www.dartlang.org/guides/libraries/library-tour) #ril

## 安裝設定 {: #installation }

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

  - [Dart programming language](https://www.dartlang.org/)
  - [Dart - GitHub](https://github.com/dart-lang)
  - [Dart Packages](https://pub.dartlang.org/)

社群：

  - [Google's Dart Team (@dart_lang) | Twitter](https://twitter.com/dart_lang)
  - ['dart' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/dart)

學習資源：

  - [Dart News & Updates](https://news.dartlang.org/)

工具：

  - [DartPad](https://dartpad.dartlang.org/)
  - [Observatory](dart-observatory.md)

更多：

  - [Programming](dart-programming.md)
  - [Package](dart-package.md)
  - [Testing](dart-testing.md)
  - [Library](dart-library.md)

相關：

  - Dart 在 mobile 上的方案就是 [Flutter](flutter.md)。

手冊：

  - [Dart API Docs](https://api.dartlang.org/stable/)
