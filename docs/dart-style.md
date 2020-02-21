---
title: Dart / Coding Style
---
# [Dart](dart.md) / Coding Style

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

## 參考資料 {: #reference }

  - [Linter for Dart](https://dart-lang.github.io/linter/)

手冊：

  - [Lint Rules](http://dart-lang.github.io/linter/lints/)

