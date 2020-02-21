# Dart

  - [Dart programming language \| Dart](https://dart.dev/)

      - Paint your UI to life with Dart VM's instant HOT RELOAD.

      - Dart is a CLIENT-OPTIMIZED language for fast apps on any platform. Made by Google.

        Watch video 說明了 hot reload 及 one team 的概念；其中 web 的應用好像只在 frontend ??

      - Optimized for UI -- Develop with a programming language specialized around the needs of USER INTERFACE creation

          - Mature and complete ASYNC-AWAIT for user interfaces containing EVENT-DRIVEN code, paired with ISOLATE-BASED CONCURRENCY

                fetchTemperature() async {
                  // This call is non-blocking. The UI thread will continue to render with no locks
                  final response = await http.get('https://my/weather');

                  if (response.statusCode == 200) {
                    temp.setText(response.body);
                  } else {
                    temp.setText('Unknown temp.');
                  }

          - A programming language optimized for building user interfaces with features such as the SPREAD OPERATOR for expanding collections, and COLLECTION IF for customizing UI for each platform

                TabBar build(BuildContext context) {
                  return TabBar(tabs: [
                    Tab(text: 'Shoes'),
                    Tab(text: 'Pants'),
                    Tab(text: 'Shirts'),
                    if (promoActive) Tab (text: 'Outlet'),
                  ]);
                }

          - A programming language that is easy to learn, with a familiar syntax

            比較了 Dart、Kotlin、Swift 及 TypeScript 的寫法。

      - Productive development -- Make changes ITERATIVELY: use hot reload to see the result instantly in your running app

          - Make changes to your source code iteratively, using [hot reload](https://flutter.dev/docs/development/tools/hot-reload) to instantly see the effect in the running app

          - Write code using a flexible type system with rich static analysis and powerful, [configurable tooling](https://dart.dev/guides/language/analysis-options) #ril

          - Do [profiling](https://flutter.github.io/devtools/timeline), [logging](https://flutter.github.io/devtools/logging), and [debugging](https://flutter.github.io/devtools/debugger#getting-started) with your code editor of choice #ril

        Dart 跟 Flutter 的關係很特別 -- Flutter 內建 Dart SDK，而 Dart 許多文件直接指向 Flutter。

      - Fast on all platforms -- Compile to ARM & x64 machine code for mobile, desktop, and BACKEND. Or compile to JavaScript for the web

          - [AOT-compile](https://dart.dev/platforms) apps to NATIVE MACHINE CODE for instant startup #ril
          - Target the web with complete, mature, fast compilers for JavaScript
          - Run backend code supporting your app, written using a single programming language

        如果 Dart 連 backend 都吃的話，加上 mobile, desktop 及 web，真的就通吃了!!

  - [Dart programming language \| Dart](https://www.dartlang.org/) (舊版網站)

    Dart helps you craft beautiful, high-quality experiences ACROSS ALL SCREENS, with: 至少跨及 web 與 mobile

      - A client-optimized language -- Dart started out being optimized for WEB APPS, and is evolving to provide great support for mobile apps. Dart also runs on the command line and SERVER-SIDE.

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

      - Reactive?? -- Dart is well-suited to [REACTIVE PROGRAMMING](https://en.wikipedia.org/wiki/Reactive_programming), with support for managing short-lived objects—such as UI widgets—through Dart’s fast object allocation and generational garbage collector.

        Dart supports asynchronous programming through language features and APIs that use `Future` and `Stream` objects.

  - [Platforms \| Dart](https://www.dartlang.org/guides/platforms)

      - Dart is a SCALABLE language that you can use to write simple scripts or full featured apps. Whether you’re creating a mobile app, web app, command-line script, or server-side app, there’s a Dart solution for that.

        分為 Flutter、Web 跟 Server，其中 Flutter 跟 Web 都有獨立的網站，只有 Server 則在 www.dartlang.org 站內；Web 的全名是 Dart for the web，而 Server 的全名則是 Server-side Dart。

  - [Announcing Dart 2: Optimized for Client\-Side Development](https://medium.com/dartlang/announcing-dart-2-80ba01f43b6) (2018-02-23) #ril
  - [Why Flutter Uses Dart – Hacker Noon](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf) (2018-02-26) #ril

## 應用實例 {: #powered-by }

  - [Flutter](flutter.md)
  - [Who Uses Dart \| Dart](https://www.dartlang.org/community/who-uses-dart)

## 參考資料 {: #reference }

  - [Dart Programming Language](https://dart.dev/)
  - [Dart - GitHub](https://github.com/dart-lang)
  - [Dart Packages](https://pub.dev/)

社群：

  - [Google's Dart Team (@dart_lang) | Twitter](https://twitter.com/dart_lang)
  - ['dart' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/dart)

學習資源：

  - [Dart News & Updates](https://news.dartlang.org/)

工具：

  - [DartPad](https://dartpad.dartlang.org/)
  - [Observatory](dart-observatory.md)

更多：

  - [Programming](dart-prog.md)
  - [CLI](dart-cli.md)
  - [Library](dart-lib.md)
  - [Coding Style](dart-style.md)
  - [VM](dart-vm.md)
  - [Package](dart-package.md)
  - [Testing](dart-testing.md)

相關：

  - Dart 在 mobile 上的方案就是 [Flutter](flutter.md)。

手冊：

  - [Dart API Docs](https://api.dartlang.org/stable/)
