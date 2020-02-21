---
title: Dart / Programming
---
# [Dart](dart.md) / Programming

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

  - [Language tour \| Dart](https://dart.dev/guides/language/language-tour) #ril

      - This page shows you how to use each major Dart feature, from variables and operators to classes and libraries, with the assumption that you already know how to program in another language. For a briefer, less complete introduction to the language, see the [language samples page](https://dart.dev/samples). #ril

        To learn more about Dart’s core libraries, see the library tour. Whenever you want more details about a language feature, consult the Dart language specification.

        Note: You can play with most of Dart’s language features using DartPad (learn more). Open DartPad

  - [A basic Dart program - Language Tour \| Dart](https://www.dartlang.org/guides/language/language-tour#a-basic-dart-program)

        // Define a function.
        printInteger(int aNumber) {
          print('The number is $aNumber.'); // Print to console.
        }

        // This is where the app starts executing.
        main() {
          var number = 42; // Declare and initialize a variable.
          printInteger(number); // Call a function.
        }

      - `// This is a comment.` -- A single-line comment. Dart also supports multi-line and DOCUMENT COMMENTS (產生 API Docs).
      - `int` -- A type. Some of the other built-in types are `String`, `List`, and `bool`.

         感覺基本的型態都用小寫? 不過不像 Java 有 primitive type!!

      - `42` -- A number literal. Number literals are a kind of COMPILE-TIME CONSTANT.
      - `print()` -- A handy way to display output.
      - `'...'` (or `"..."`) -- A string literal.
      - `$variableName` (or `${expression}`) -- String interpolation: including a variable or expression’s string equivalent inside of a string literal.
      - `main()` -- The special, required, TOP-LEVEL FUNCTION where app execution starts.
      - `var` -- A way to declare a variable WITHOUT SPECIFYING ITS TYPE. 不同於 `dynamic`。

  - [Important concepts - Language Tour \| Dart](https://www.dartlang.org/guides/language/language-tour#important-concepts)
      - Everything you can place in a variable is an object, and every object is an instance of a class. Even numbers, functions, and `null` are objects. All objects inherit from the `Object` class.
      - Although Dart is strongly typed, TYPE ANNOTATIONS are optional because Dart can INFER types. In the code above, `number` is inferred to be of type `int`. When you want to explicitly say that NO TYPE IS EXPECTED, use the special type `dynamic`.

        沒有宣告 type 並不表示沒有限定 type，而是交給工具推斷，有別於什麼都能放的 `dynamic`；因為 type 不一定要寫明，所以才有 type "annotation" (註釋) 的說法。

      - Dart supports generic types, like `List<int>` (a list of integers) or `List<dynamic>` (a list of objects of ANY TYPE).
      - Dart supports top-level functions (such as `main()`), as well as functions TIED TO A CLASS OR OBJECT (static and instance methods, respectively). You can also create functions within functions (nested or local functions).
      - Similarly, Dart supports TOP-LEVEL VARIABLES, as well as variables tied to a class or object (static and instance variables). Instance variables are sometimes known as fields or properties.
      - Unlike Java, Dart doesn’t have the keywords `public`, `protected`, and `private`. If an identifier starts with an underscore (`_`), it’s PRIVATE TO ITS LIBRARY. for details, see Libraries and visibility.

        如何達到 private to a class 的效果?? 還是這一層的保護是不需要的?

      - Identifiers can start with a letter or underscore (`_`), followed by any combination of those characters plus digits.

      - Dart has both EXPRESSIONS (which have RUNTIME VALUES) and STATEMENTS (which don’t). For example, the conditional expression `condition ? expr1 : expr2` has a value of `expr1` or `expr2`. Compare that to an if-else statement, which has no value. A statement often contains one or more expressions, but an expression can’t directly contain a statement.
      - Dart tools can report two kinds of problems: warnings and errors. Warnings are just indications that your code might not work, but they don’t prevent your program from executing. Errors can be either compile-time or run-time. A compile-time error prevents the code from executing at all; a run-time error results in an EXCEPTION being raised while the code executes.

  - [Effective Dart \| Dart](https://dart.dev/guides/language/effective-dart) #ril

## Identifier

  - [Keywords - Language Tour \| Dart](https://www.dartlang.org/guides/language/language-tour#keywords)
      - Avoid using these words as identifiers. However, IF NECESSARY, the keywords marked with superscripts can be identifiers:

        保留字只在某些地方不能用，是其他語言沒見過的；不過數量真的不少!

          - Words with the superscript 1 are CONTEXTUAL keywords, which have meaning only in specific places. They’re valid identifiers everywhere.
          - Words with the superscript 2 are BUILT-IN identifiers. To simplify the task of porting JavaScript code to Dart, these keywords are valid identifiers in most places, but they can’t be used as class or type names, or as import prefixes.

            若連 Dart 轉換的標的也要考量進來，保留字更多了? 不過若限定在 class/type name、import prefix 影響就不大，畢竟 class/type name 通常會以大寫開頭，而 import prefix 通常會簡寫。

          - Words with the superscript 3 are NEWER (相對於 Dart 1.0), LIMITED RESERVED WORDS related to the asynchrony support that was added after Dart’s 1.0 release. You can’t use `await` or `yield` as an identifier in any function body marked with `async`, `async*`, or `sync*`. 跟標示有 "superscript 1" 的狀況類似，其他地方都可以用。

      - All other words in the table are RESERVED WORDS, which can’t be identifiers.

  - [Identifiers - Effective Dart: Style \| Dart](https://www.dartlang.org/guides/language/effective-dart/style#identifiers)

    Identifiers come in three flavors in Dart. 都會用到，只是各有場合不同。

      - `UpperCamelCase` names capitalize the first letter of each word, including the first.
      - `lowerCamelCase` names capitalize the first letter of each word, except the first which is always lowercase, even if it’s an acronym.
      - `lowercase_with_underscores` use only lowercase letters, even for acronyms, and separate words with `_`.

    DO name types using `UpperCamelCase`.

      - Classes, enums, typedefs, and type parameters should capitalize the first letter of each word (including the first word), and use no separators. 不過 type parameter 通常只有一個大寫字母。

            class SliderMenu { ... }

            class HttpRequest { ... }

            typedef Predicate<T> = bool Function(T value);

      - This even includes CLASSES intended to be used in METADATA ANNOTATIONS.

            class Foo {
              const Foo([arg]);
            }

            @Foo(anArg)
            class A { ... }

            @Foo()
            class B { ... }

        If the annotation class’s constructor takes no parameters, you might want to create a separate `lowerCamelCase` constant for it.

            const foo = Foo();

            @foo
            class C { ... }

        `@deprecated` 跟 `@override` 應該就是這種狀況，否則就是例外了。

    DO name libraries, packages, directories, and source files using `lowercase_with_underscores`.

      - Some file systems are not case-sensitive, so many projects require FILENAMES TO BE ALL LOWERCASE. Using a separating character allows names to still be readable in that form. Using underscores as the separator ensures that the name is STILL A VALID DART IDENTIFIER, which may be helpful if the language later supports SYMBOLIC IMPORTS. 原來是 FS 不一定區分大小寫的考量!

            library peg_parser.source_scanner;

            import 'file_system.dart';
            import 'slider_menu.dart';

      - This guideline specifies how to name a library if you choose to name it. It is fine to omit the `library` directive in a file if you want. ??

    DO name import prefixes using `lowercase_with_underscores`.

        import 'dart:math' as math;
        import 'package:angular_components/angular_components'
            as angular_components;
        import 'package:js/js.dart' as js;

    DO name OTHER IDENTIFIERS using `lowerCamelCase`.

      - Class members, top-level definitions, variables, parameters, and named parameters should capitalize the first letter of each word except the first word, and use no separators.

            var item;

            HttpRequest httpRequest;

            void align(bool clearItems) {
              // ...
            }

    PREFER using `lowerCamelCase` for constant names.

      - In NEW CODE, use `lowerCamelCase` for constant variables, INCLUDING ENUM VALUES.

            const pi = 3.14;
            const defaultTimeout = 1000;
            final urlScheme = RegExp('^([a-z]+):');

            class Dice {
              static final numberGenerator = Random();
            }

      - You may use `SCREAMING_CAPS` for consistency with existing code, as in the following cases:
          - When adding code to a file or library that already uses `SCREAMING_CAPS`.
          - When generating Dart code that’s parallel to Java code — for example, in enumerated types generated from [protobufs](https://pub.dartlang.org/packages/protobuf).

      - Note: We initially used Java’s `SCREAMING_CAPS` style for constants. We changed for a few reasons:
          - `SCREAMING_CAPS` looks bad for many cases, particularly enum values for things like CSS colors.
          - Constants are often changed to final non-const variables, which would necessitate a name change.
          - The `values` property automatically defined on an enum type is const and lowercase.

        有點難被說服，難怪這個 rule 是 PREFER 而非 DO ...

    DO capitalize acronyms and abbreviations longer than two letters like words.

      - Capitalized acronyms can be hard to read, and MULTIPLE ADJACENT ACRONYMS can lead to ambiguous names. For example, given a name that starts with HTTPSFTP, there’s no way to tell if it’s referring to HTTPS FTP or HTTP SFTP.
      - To avoid this, acronyms and abbreviations are capitalized like REGULAR WORDS, except for two-letter acronyms. (Two-letter abbreviations like ID and Mr. are still capitalized like words.)

            HttpConnectionInfo <-- 做為 type 時，採 UpperCamelCase，HTTP 視為一般單字
            uiHandler          <-- 做為其他 identifier 時，採 lowerCamelCase，且 UI 比較短所以一起變小寫
            IOStream           <-- 做為 type 時，採 UpperCamelCase，但 IO 比較短所以一起變大寫
            HttpRequest
            Id
            DB

        最後 `Id` 跟 `DB` 的例子很難懂? 因為 ID 是 abbreviation 而 DB 是 acronym 的關係?? 有趣的是，這個 style 沒有對應的 linter rule。

    DON’T use prefix letters.

      - [Hungarian notation](https://en.wikipedia.org/wiki/Hungarian_notation) and other schemes arose in the time of [BCPL](https://en.wikipedia.org/wiki/BCPL), when the compiler didn’t do much to help you understand your code. Because Dart can tell you the type, scope, mutability, and other properties of your declarations, there’s NO REASON TO ENCODE THOSE PROPERTIES IN IDENTIFIER NAMES.

        例如 `defaultTimeout` 不要寫成 `iDefaultTimeout`；不過當初加前綴的想法是增加 source code 自身的可讀性，跟 compiler 沒什麼關係不是?

## Comment ??

  - [Comments - Language Tour \| Dart](https://www.dartlang.org/guides/language/language-tour#comments) #ril

## Variable ??

  - [Variables, Default value - Language Tour \| Dart](https://www.dartlang.org/guides/language/language-tour#variables) #ril
  - [Final and const - Language Tour \| Dart](https://www.dartlang.org/guides/language/language-tour#final-and-const) #ril

## 參考資料 {: #reference }

  - [DartPad](https://dartpad.dev/)

更多：

  - [Data Type](dart-type.md)
  - [Concurrency](dart-concurrency.md)

手冊：

  - [Language Specification](https://dart.dev/guides/language/spec)
