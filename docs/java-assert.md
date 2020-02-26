---
title: Java / Assertion
---
# [Java](java.md) / Assertion

  - [Programming With Assertions](https://docs.oracle.com/javase/8/docs/technotes/guides/language/assert.html) #ril

## Invariant

  - [Internal Invariants - Programming With Assertions](https://docs.oracle.com/javase/7/docs/technotes/guides/language/assert.html#usage-invariants)

      - Before assertions were available, many programmers used COMMENTS to indicate their ASSUMPTIONS concerning a program's behavior. For example, you might have written something like this to EXPLAIN your assumption about an `else` clause in a multiway if-statement:

            if (i % 3 == 0) {
                ...
            } else if (i % 3 == 1) {
                ...
            } else { // We know (i % 3 == 2)
                ...
            }

        You should now use an assertion whenever you would have WRITTEN A COMMENT THAT ASSERTS AN INVARIANT. For example, you should rewrite the previous if-statement like this:

            if (i % 3 == 0) {
               ...
            } else if (i % 3 == 1) {
                ...
            } else {
                assert i % 3 == 2 : i;
                ...
            }

        Note, incidentally, that the assertion in the above example may fail if `i` is negative, as the `%` operator is not a true modulus operator, but computes the remainder, which may be negative.

      - Another good candidate for an assertion is a `switch` statement with no `default` case. The absence of a `default` case typically indicates that a programmer BELIEVES that one of the cases will always be executed. The ASSUMPTION that a particular variable will have one of a small number of values is AN INVARIANT THAT SHOULD BE CHECKED WITH AN ASSERTION.

        For example, suppose the following `switch` statement appears in a program that handles playing cards:

            switch(suit) {
              case Suit.CLUBS:
                ...
              break;

              case Suit.DIAMONDS:
                ...
              break;

              case Suit.HEARTS:
                ...
                break;

              case Suit.SPADES:
                  ...
            }

        It probably indicates an assumption that the `suit` variable will have one of only four values. To test this assumption, you should add the following default case:

            default:
                assert false : suit;

        If the `suit` variable takes on another value AND assertions are enabled, the `assert` will fail and an `AssertionError` will be thrown.

      - An acceptable alternative is:

            default:
                throw new AssertionError(suit);

        This alternative offers protection EVEN IF ASSERTIONS ARE DISABLED, but the extra protection adds no cost: the `throw` statement won't execute unless the program has failed. Moreover, the alternative is legal under some circumstances where the `assert` statement is not.

        If the enclosing method returns a value, each case in the `switch` statement contains a `return` statement, and no `return` statement follows the `switch` statement, then it would cause a syntax error to add a default case with an assertion. (The method would return without a value if no case matched and assertions were disabled.)

## 參考資料 {: #reference }

手冊：

  - [Class `java.lang.AssertionError`](https://docs.oracle.com/javase/8/docs/api/java/lang/AssertionError.html)
