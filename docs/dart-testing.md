---
title: Dart / Testing
---
# [Dart](dart.md) / Testing

  - [Dart Testing \| Dart](https://www.dartlang.org/guides/testing)
      - This Dart testing guide outlines several types of testing, and points you to where you can learn how to test your mobile, web, and server-side apps and scripts.

        因為其他 platform 的測試也是基於 `package:test`，`flutter_test` 的第一句 "Testing library for flutter, built on top of `package:test`." 可以證實這樣的說法。

      - Terminology: widget vs. component -- Flutter, an SDK for building apps for iOS and Android, defines its GUI elements as WIDGETS. AngularDart, a web app framework, defines its GUI elements as COMPONENTS. This doc uses component (except when explicitly discussing Flutter), but both terms refer to THE SAME CONCEPT.

    Kinds of testing

    The Dart testing docs focus on three kinds of testing, out of the many kinds of testing that you may be familiar with: unit, component, and end-to-end (a form of integration testing). Testing terminology varies, but these are the terms and concepts that you are likely to encounter when using Dart technologies:

      - Unit tests focus on verifying the smallest piece of testable software, such as a function, method, or class. Your test suites should have MORE UNIT TESTS than other kinds of tests.
      - Component tests verify that a component (which usually consists of MULTIPLE CLASSES) behaves as expected. A component test often requires the use of MOCK OBJECTS that can mimic user actions, events, perform layout, and instantiate child components. 更需要的是 runtime environment 吧?? 因為 unit test 也可能用到 mock object。
      - Integration and end-to-end tests verify the behavior of an ENTIRE APP, or a large chunk of an app. An integration test generally runs on a real device or OS simulator (for mobile) or on a browser (for the web) and consists of TWO PIECES: the app itself, and the TEST APP THAT PUTS THE APP THROUGH ITS PACES.

        An integration test often measures PERFORMANCE, so the test app generally runs on a DIFFERENT DEVICE OR OS than the app being tested.

       有趣的觀點，雖然遠端操蹤 AUT 的效能比較差，但重點是 AUT 本身的 performace 不會受到其他因素干擾；像下面的 [`flutter_driver`](https://docs.flutter.io/flutter/flutter_driver/flutter_driver-library.html) 就強調 "in a separate process"。

    Generally useful libraries

    Although your tests PARTLY DEPEND ON THE PLATFORM your code is intended for—Flutter, the web, or server-side, for example—the following packages are useful ACROSS Dart platforms:

      - `package:test` -- Provides a STANDARD WAY of writing tests in Dart. You can use the test package to:

          - Write single tests, or groups of tests.
          - Use the `@TestOn` annotation to restrict tests to RUN ON SPECIFIC ENVIRONMENTS.
          - Write ASYNCHRONOUS TESTS just as you would write synchronous tests.
          - Tag tests using the `@Tag` annotation. For example, define a tag to create a CUSTOM CONFIGURATION for some tests, or to identify some tests as needing more time to complete. 也就是在做 test filtering，其中 custom configuration 跟下面的 `dart_test.yaml` 有關??
          - Create a `dart_test.yaml` file to CONFIGURE tagged tests across multiple files or an entire package. 可以設定什麼??

      - `package:mockito` -- Provides a way to create mock objects, easily configured for use in FIXED SCENARIOS, and to verify that the system under test INTERACTS WITH THE MOCK OBJECT IN EXPECTED WAYS. For an example that uses both `package:test` and `package:mockito`, see the [International Space Station API library and its unit tests](https://github.com/dart-lang/mockito/tree/master/test/example/iss) in the mockito package.

        上面 ISS library 是 `package:mockito` 的範例，提到 "The unit tests for this library use `package:mockito` to generate PRESET VALUES for the space station's location, and `package:test` to create REPRODUCIBLE SCENARIOS to verify the expected outcome."

## 新手上路 {: #getting-started }

  - [Writing Tests - test \| Dart Package](https://pub.dartlang.org/packages/test#writing-tests)
      - Tests are specified using the top-level `test()` function, and test assertions are made using `expect()`:

            import "package:test/test.dart";

            void main() {
              test("String.split() splits the string on the delimiter", () {
                var string = "foo,bar,baz";
                expect(string.split(","), equals(["foo", "bar", "baz"]));
              });

              test("String.trim() removes surrounding whitespace", () {
                var string = "  foo ";
                expect(string.trim(), equals("foo"));
              });
            }

        注意 assertion 不是用 `assert` 而是用 `expect()`，搭配不同的 matcher 驗證 -- 不意外地 [matcher 的概念源自 Hamcrest](https://pub.dartlang.org/documentation/matcher/latest/)。

        `test(dynamic description, dynamic body(), ...)` 的用法，第一個參數說明測的目的 (其實就是 "name of the test"，也就是 `-n, --name` 過濾的對象)，第二個參數由 (anonymous) function 提供 test code。

        ---

        存成 `test/string_test.dart`，執行 `pub run test` 會丟出下面的錯誤：

            $ pub run test
            Could not find a file named "pubspec.yaml" in "/private/tmp/dart_testing".

        簡單寫個 `pubspec.yaml` 就可以動了：

            $ cat pubspec.yaml
            name: dart_testing
            dev_dependencies:
              test: 1.5.3

            $ pub run test
            No pubspec.lock file found, please run "pub get" first.

            $ pub get
            Resolving dependencies... (11.1s)
            + analyzer 0.35.0
            ...
            Changed 52 dependencies!
            Precompiling executables... (25.2s)
            Precompiled test:test.

            $ pub run test # 預設用 compact reporter
            00:01 +2: All tests passed!

            $ pub run test --reporter expanded # 改用 expanded reporter 可以看到過程
            00:00 +0: test/string_test.dart: String.split() splits the string on the delimiter
            00:00 +1: test/string_test.dart: String.trim() removes surrounding whitespace
            00:00 +2: All tests passed!

        過程中發生錯誤會像是： (有很清楚的 diff)

            $ pub run test
            00:01 +0 -1: test/string_test.dart: String.split() splits the string on the delimiter [E]
              Expected: ['foo', 'bar', 'baz']
                Actual: ['foo', 'bar', 'ba']
                 Which: was 'ba' instead of 'baz' at location [2]

              package:test_api           expect
              test/string_test.dart 6:5  main.<fn>

            00:01 +1 -1: Some tests failed.

      - Tests can be grouped together using the `group()` function. Each group's description is added to the beginning of its test's descriptions.

        按照下面 Timeouts 中 "this can be configured on a per-test, -group, or -suite basis." 的說法，group 跟 suite 是不同的概念，suite 指的是整個 test file (`_test.dart`)

            import "package:test/test.dart";

            void main() {
              group("String", () {
                test(".split() splits the string on the delimiter", () {
                  var string = "foo,bar,baz";
                  expect(string.split(","), equals(["foo", "bar", "baz"]));
                });

                test(".trim() removes surrounding whitespace", () {
                  var string = "  foo ";
                  expect(string.trim(), equals("foo"));
                });
              });

              group("int", () {
                test(".remainder() returns the remainder of division", () {
                  expect(11.remainder(3), equals(2));
                });

                test(".toRadixString() returns a hex string", () {
                  expect(11.toRadixString(16), equals("b"));
                });
              });
            }

      - Any matchers from the `matcher` package can be used with `expect()` to do complex validations:

            import "package:test/test.dart";

            void main() {
              test(".split() splits the string on the delimiter", () {
                expect("foo,bar,baz", allOf([
                  contains("foo"),
                  isNot(startsWith("bar")),
                  endsWith("baz")
                ]));
              });
            }

      - You can use the `setUp()` and `tearDown()` functions to share code between tests. The `setUp()` callback will run before every test in a group or test suite, and `tearDown()` will run after. `tearDown()` will run EVEN IF A TEST FAILS, to ensure that it has a chance to CLEAN UP after itself.

            import "package:test/test.dart";

            void main() {
              HttpServer server; // 用 local variable 保存 setUp/tearDown 安排的 fixture
              Uri url;
              setUp(() async {
                server = await HttpServer.bind('localhost', 0);
                url = Uri.parse("http://${server.address.host}:${server.port}");
              });

              tearDown(() async {
                await server.close(force: true);
                server = null;
                url = null;
              });

              // ...
            }

        看似 `test` package 不支援 per-group 或 per-suite 的 setup/teardown?

  - [Running Tests - test \| Dart Package](https://pub.dartlang.org/packages/test#running-tests)
      - A single TEST FILE can be run just using `pub run test path/to/test.dart`.
      - Many tests can be run at a time using `pub run test path/to/dir`.
      - It's also possible to run a test on the Dart VM only by invoking it using `dart path/to/test.dart`, but this doesn't load the full TEST RUNNER and will be missing some features.

        大概是因為每個 test file 都有 `main()` 的關係，所以可以直接用 `dart` 執行。

            $ dart test/string_test.dart
            00:00 +0: String .split() splits the string on the delimiter
            00:00 +1: String .trim() removes surrounding whitespace
            00:00 +2: int .remainder() returns the remainder of division
            00:00 +3: int .toRadixString() returns a hex string
            00:00 +4: All tests passed!

        但 `dart` 如何知道 dependices 從哪裡來? 實驗發現是 `.package/`，裡頭記錄了 `pub get` 快取的位置：

            $ head -2 .packages
            # Generated by pub on 2019-02-07 04:58:13.535613.
            analyzer:file:///Users/jeremykao/.pub-cache/hosted/pub.dartlang.org/analyzer-0.35.0/lib/
            ...

      - The test runner considers any file that ends with `_test.dart` to be a test file. If you don't pass any paths, it will run all the test files in your `test/` directory, making it easy to test your entire application at once. 與一般的習慣 -- `test_*.dart` 與 `tests/` 不同。
      - You can select specific tests cases to run BY NAME using `pub run test -n "test name"`. The string is interpreted as a REGULAR EXPRESSION, and only tests whose DESCRIPTION (INCLUDING ANY GROUP DESCRIPTIONS) match that regular expression will be run. You can also use the `-N` flag to run tests whose names contain a PLAIN-TEXT STRING.
      - By default, tests are run in the Dart VM, but you can run them in the browser as well by passing `pub run test -p chrome path/to/test.dart`. `test` will take care of starting the browser and loading the tests, and all the results will be reported on the command line just like for VM tests. In fact, you can even run tests on both platforms with a single command: `pub run test -p "chrome,vm" path/to/test.dart`.

        Dart VM 該不會只會出現在 server-side Dart? Dart VM 只是其中一個 platform 而已??

  - [Tests and benchmarks - Pub Package Layout Conventions \| Dart](https://www.dartlang.org/tools/pub/package-layout#tests-and-benchmarks)

        enchilada/
        ...
          benchmark/
            make_lunch.dart
          lib/
            enchilada.dart
            tortilla.dart
            guacamole.css
            src/
              beans.dart
              queso.dart
          test/
            enchilada_test.dart
            tortilla_test.dart

      - Every package should have tests. With pub, the convention is that these go in a `test` directory (or some directory inside it if you like) and have `_test` at the end of their file names. Typically, these use the `test` package.
      - Packages that have performance critical code may also include benchmarks. These test the API NOT FOR CORRECTNESS BUT FOR SPEED (or memory use, or maybe other empirical metrics).

## 參考資料 {: #reference }

  - [Dart Testing](https://www.dartlang.org/guides/testing)
  - [dart-lang/test - GitHub](https://github.com/dart-lang/test)
  - [dart-lang/mockito - GitHub](https://github.com/dart-lang/mockito)

手冊：

  - [`package:test`](https://pub.dartlang.org/documentation/test/latest/)
  - [`package:mockito`](https://pub.dartlang.org/documentation/mockito/latest/)