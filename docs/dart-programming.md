---
title: Dart / Programming
---
# [Dart](dart.md) / Programming

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

## 新手上路 ?? {: #getting-started }

## Style, Lint ??

  - [Effective Dart: Style \| Dart](https://www.dartlang.org/guides/language/effective-dart/style)
      - A surprisingly important part of good code is GOOD STYLE. Consistent naming, ordering, and formatting helps CODE THAT IS THE SAME LOOK THE SAME. It takes advantage of the powerful pattern-matching hardware most of us have in our ocular systems. If we use a consistent style across the entire Dart ecosystem, it makes it easier for all of us to LEARN FROM AND CONTRIBUTE TO each others’ code.
      - 每個 style 都帶有 "Linter rule: xxx" 的連結往 [Linter for Dart](https://dart-lang.github.io/linter/)。
      - 分為 Identifiers、Ordering、Formatting 三塊，其中 ordering 主要跟 import/export 有關。

  - [Formatting Rules · dart\-lang/dart\_style Wiki](https://github.com/dart-lang/dart_style/wiki/Formatting-Rules)
      - The canonical source of truth for the logic dartfmt applies is in the code. ... But if you want an approximate list of the main HIGH-LEVEL WHITESPACE RULES the formatter applies, these are them:
      - 最後一段文字是 Your goal is to BALANCE using indentation to show expression structure while not wanting to indent large swathes (塊) of code unnecessarily. 這裡講的 balance，指的是 readable + consistent。

    Spaces, not tabs.

      - Using spaces for formatting ensures the code LOOKS THE SAME IN EVERYONE'S EDITOR. It also makes sure it looks the same when posted to blogs, or on code sites like GitHub.

        通常內縮 2 格。

      - Modern editors emulate the behavior of tabs while inserting spaces, giving you the easy editing of tabs and the consistency of spaces.

    One or two newlines after each statement or declaration.

        main() {
          first(statement);
          second(statement);

          third(statement);
        }

        anotherDeclaration() { ... }

    No space between the declared name of a method, operator, or setter and its parameter list. 也就是 `(...)` 前不會有空白，所以 `==(other)` 不會寫成 `== (other)`。

        log(arg) { ... }
        bool operator ==(other) => ...
        set contents(value) { ... }

    Space after the `operator` keyword.

        bool operator ==(other) => ...

    Spaces around binary and ternary operators.

      - Note that `<` and `>` are considered binary operators when used as expressions, but not for specifying generic types. Both `is` and `is!` are considered single binary operators. However, the `.` used to access members is not and should not have spaces around it.

            average = (a + b) / 2;
            largest = a > b ? a : b;
            if (obj is! SomeType) print('not SomeType');

    Spaces after `,` and `:` when used in a map or named parameter.

        function(a, b, named: c)
        [some, list, literal]
        {map: literal}

    No spaces around unary operators.

        !condition
        index++

    Spaces around `in`, and after each `;` in a loop.

        for (var i = 0; i < 100; i++) { ... }

        for (final item in collection) { ... }

    Space after flow-control keywords.

      - This is UNLIKE FUNCTION AND METHOD CALLS, which do not have a space between the name and the opening parenthesis.

            while (foo) { ... }

            try {
              // ...
            } catch (e) {
              // ...
            }

    No space after `(`, `[`, and `{`, or before `)`, `]`, and `}`.

      - Also, do not use a space when using `<` and `>` for generic types.

            var numbers = <int>[1, 2, (3 + 4)];

    Space before `{` in function and method bodies.

      - When a `{` is used after a parameter list in a function or method, there should be a space between it and the `)` ending the parameters.

            getEmptyFn(a) {
              return () {};
            }

    Place the opening curly brace (`{`) on the same line as what it follows. 還好官方有定義這個，否則有人喜歡把 `{` 擺在下一行，看起來實在不舒服!

        class Foo {
          method() {
            if (someCondition) {
              // ...
            } else {
              // ...
            }
          }
        }

    Place binary operators on the preceding line in a MULTI-LINE EXPRESSION.

      - There are valid arguments for both styles but most of our code seems to go this way, and CONSISTENCY MATTERS MOST.

            var bobLikesIt = isDeepFried ||
                (hasPieCrust && !vegan) ||
                containsBacon;

            bobLikes() =>
                isDeepFried || (hasPieCrust && !vegan) || containsBacon;

        斷行時內縮 4 格。

    Place ternary operators on the next line in a multi-line expression.

      - Also, if you break the line before one of the operators, BREAK AROUND BOTH. 要斷就全斷!

            return someCondition
                ? whenTrue
                : whenFalse;

    Place the `.` on the next line in a multi-line expression.

            someVeryLongVariableName.withAVeryLongPropertyName
                .aReallyLongMethodName(args);

    Format constructor initialization lists with each field on its own line.

        MyClass()
            : firstField = 'some value',
              secondField = 'another',
              thirdField = 'last' {
          // ...
        }

      - Note that the `:` should be wrapped to the next line and indented FOUR SPACES. Fields should all LINE UP (so all but the first field end up indented SIX SPACES).

    Split EVERY element in a collection IF IT DOES NOT FIT ON ONE LINE. 要斷就全斷!

      - This means after the opening bracket, before the closing one, and after the `,` for each element.

            mapInsideList([
              {
                'a': 'b',
                'c': 'd'
              },
              {
                'a': 'b',
                'c': 'd'
              },
            ]);

        注意 `([ ...])` 與 `{ ... }` 用法上的差別。

    Indent block and collection bodies TWO SPACES.

        if (condition) {
          print('hi');
        }

        var compoundsWithLongNames = [
          buckminsterfullerene,
          dodecahedrane,
          olympiadane
        ];

    Indent switch cases two spaces and case bodies four spaces.

        switch (fruit) {
          case 'apple':
            print('delish');
            break;

          case 'durian':
            print('stinky');
            break;
        }

    Indent multi-line method cascades TWO SPACES. 這與上面 multi-line expression 折行內縮 4 格的做法不同，可能是 `  ..` 視覺上已經也是內縮 4 格的關係。

        buffer
          ..write('Hello, ')
          ..write(name)
          ..write('!');

    Indent CONTINUED LINES with AT LEAST FOUR SPACES.

        someVeryLongVariableName.aReallyLongMethodName(
            arg, anotherArg, wrappedToNextLine);

      - This includes `=>` as well:

            bobLikes() =>
                isDeepFried || (hasPieCrust && !vegan) || containsBacon;

      - There are exceptions to this when the expression contains multi-line function or collection literals.

            new Future.delayed(const Duration(seconds: 1), () {
              print('I am a callback');
            });

            args.addAll([ // 符合上面 "Split every element..." 內容 2 格的做法
              '--mode',
              'release',
              '--checked'
            ]);

  - [Formatting - Effective Dart: Style \| Dart](https://www.dartlang.org/guides/language/effective-dart/style#formatting) #ril

  - [dart\-lang/linter: Linter for Dart\.](https://github.com/dart-lang/linter) #ril
  - [Effective Dart: Design \| Dart](https://www.dartlang.org/guides/language/effective-dart/design) #ril

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

  - [Linter for Dart](https://dart-lang.github.io/linter/)

手冊：

  - [Lint Rules](http://dart-lang.github.io/linter/lints/)
