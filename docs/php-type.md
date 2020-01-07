---
title: PHP Programming / Data Type
---
# [PHP Programming](php-prog.md) / Data Type

  - [PHP: Introduction \- Manual](https://www.php.net/manual/en/language.types.intro.php)

      - PHP supports ten PRIMITIVE types.

        Four SCALAR types:

          - boolean
          - integer
          - float (floating-point number, aka double)
          - string

        Four COMPOUND types:

          - array
          - object
          - callable
          - iterable

        And finally two special types:

          - resource
          - `NULL`

      - This manual also introduces some [PSEUDO-TYPES](https://www.php.net/manual/en/language.pseudo-types.php) for readability reasons: #ril

          - mixed
          - number
          - callback (aka callable)
          - array|object
          - void

        And the pseudo-variable [`$...`](https://www.php.net/manual/en/language.pseudo-types.php#language.types.dotdotdot).

        可以解釋成 "and so on"，表示可以接受任意多個參數。

      - Some references to the type "double" may remain in the manual. Consider double the same as float; the two names exist only for historic reasons.

      - The type of a variable is not usually set by the programmer; rather, it is decided at runtime by PHP depending on the CONTEXT in which that variable is used.

      - Note: To check the TYPE AND VALUE of an expression, use the `var_dump()` function.

        To get a human-readable representation of a type FOR DEBUGGING, use the `gettype()` function.

        覺得 `var_dump()` 跟 `gettype()` 都可以用在 debugging，只是前者會印出內容，後者不會。

        To CHECK for a certain type, do not use `gettype()`, but rather the `is_type` functions. (指 `is_int()`、`is_string()` 等) Some examples:

            <?php
            $a_bool = TRUE;   // a boolean
            $a_str  = "foo";  // a string
            $a_str2 = 'foo';  // a string
            $an_int = 12;     // an integer

            echo gettype($a_bool); // prints out:  boolean
            echo gettype($a_str);  // prints out:  string

            // If this is an integer, increment it by four
            if (is_int($an_int)) {
                $an_int += 4;
            }

            // If $a_bool is a string, print it out
            // (does not print out anything)
            if (is_string($a_bool)) {
                echo "String: $a_bool";
            }
            ?>

      - To forcibly convert a variable to a certain type, either CAST the variable or use the `settype()` function on it.

      - Note that a variable may be evaluated with different values in certain situations, depending on what type it is at the time. For more information, see the section on TYPE JUGGLING.

        The type comparison tables may also be useful, as they show examples of various type-related comparisons.

## Type Juggling/Casting

  - [PHP: Type Juggling \- Manual](https://www.php.net/manual/en/language.types.type-juggling.php) #ril

## Boolean

  - [PHP: Booleans \- Manual](https://www.php.net/manual/en/language.types.boolean.php) #ril

      - This is the simplest type. A boolean expresses a truth value. It can be either `TRUE` or `FALSE`.

    Syntax

      - To specify a boolean literal, use the constants `TRUE` or `FALSE`. Both are CASE-INSENSITIVE.

            <?php
            $foo = True; // assign the value TRUE to $foo
            ?>

        PHP 有些地方是 case insensitive，這對於團隊合作是個缺點，只能靠工具來檢查，讓大家寫法一致 ??

      - Typically, the result of an operator which returns a boolean value is passed on to a control structure.

            <?php
            // == is an operator which tests
            // equality and returns a boolean
            if ($action == "show_version") {
                echo "The version is 1.23";
            }

            // this is not necessary...
            if ($show_separators == TRUE) {
                echo "<hr>\n";
            }

            // ...because this can be used with exactly the same meaning:
            if ($show_separators) {
                echo "<hr>\n";
            }
            ?>

    Converting to boolean

      - To explicitly convert a value to boolean, use the `(bool)` or `(boolean)` casts. However, in most cases the cast is unnecessary, since a value will be automatically converted if an operator, function or control structure requires a boolean argument.

      - When converting to boolean, the following values are considered `FALSE`:

          - the boolean `FALSE` itself
          - the integers 0 and -0 (zero)
          - the floats 0.0 and -0.0 (zero)

          - the empty string, and the STRING "0"

            `"0"` 也被認定為 false，感覺有點雷?

          - an array with zero elements
          - the special type `NULL` (including UNSET VARIABLES)
          - `SimpleXML` objects created from empty tags

        Every other value is considered `TRUE` (including any resource and `NAN`).

            <?php
            var_dump((bool) "");        // bool(false)
            var_dump((bool) 1);         // bool(true)
            var_dump((bool) -2);        // bool(true)
            var_dump((bool) "foo");     // bool(true)
            var_dump((bool) 2.3e5);     // bool(true)
            var_dump((bool) array(12)); // bool(true)
            var_dump((bool) array());   // bool(false)
            var_dump((bool) "false");   // bool(true)
            ?>

      - Warning: `-1` is considered `TRUE`, like any other non-zero (whether negative or positive) number!

## 參考資料 {: #reference }

更多：

  - [String](php-string.md)

手冊：

  - [Type Comparison Tables](https://www.php.net/manual/en/types.comparisons.php)
  - [`var_dump()`](https://www.php.net/manual/en/function.var-dump.php)
  - [`gettype()`](https://www.php.net/manual/en/function.gettype.php)
  - [`settype()`](https://www.php.net/manual/en/function.settype.php)
