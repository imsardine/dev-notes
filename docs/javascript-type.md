---
title: JavaScript / Data Type
---
# [JavaScript](javascript.md) / Data Type

  - [Data structures and types - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Data_structures_and_types)

    Data types

      - The latest ECMAScript standard defines eight DATA TYPES:

        Seven data types that are PRIMITIVEs:

          - Boolean. `true` and `false`.
          - null. A special keyword denoting a null value. Because JavaScript is case-sensitive, `null` is not the same as `Null`, `NULL`, or any other variant.
          - undefined. A top-level property whose value is not defined.
          - Number. An integer or floating point number. For example: `42` or `3.14159`.
          - BigInt. An integer with arbitrary precision. For example: `9007199254740992n`.
          - String. A sequence of characters that represent a text value. For example: `"Howdy"`
          - Symbol (new in ECMAScript 2015). A data type whose instances are UNIQUE AND IMMUTABLE. #ril

        and Object

      - Although these data types are relatively few, they enable you to perform useful functions with your applications. Objects and functions are the other fundamental elements in the language. You can think of objects as named containers for values, and functions as procedures that your application can perform.

        雖然 function 沒列在上面，但 function 也是個 type (`Function`)。

    Data type conversion

      - JavaScript is a DYNAMICALLY TYPED language. That means you don't have to specify the data type of a variable when you declare it, and data types are converted automatically as needed during script execution. So, for example, you could define a variable as follows:

            var answer = 42;

        And later, you could assign the same variable a string value, for example:

            answer = 'Thanks for all the fish...';

        Because JavaScript is dynamically typed, this assignment does not cause an error message.

      - In expressions involving numeric and string values with the `+` operator, JavaScript converts numeric values to strings. For example, consider the following statements:

            x = 'The answer is ' + 42 // "The answer is 42"
            y = 42 + ' is the answer' // "42 is the answer"

      - In statements involving other operators, JavaScript does not convert numeric values to strings. For example:

            '37' - 7 // 30
            '37' + 7 // "377"

        反而將字串轉為數字。

    Converting strings to numbers

      - In the case that a value representing a number is in memory as a string, there are methods for conversion.

            parseInt()
            parseFloat()

        點擊上面的連結會被帶到 JavaScript Reference > Global Objects 下的文件，確實 `parseInt` 跟 `parseFloat` 都在 global scope 裡可以直接調用，但為什麼說是 global objects 呢? 不要跟 global object (單數) 搞混，這裡的 global objects 是 "objects in the global scope" 的意思，也就是會有 `window.parseInt` 與 `window.parseFloat`。

        另外一開始介紹 data type 時只有 number 一種 (integer or floating point)，為什麼 `parseInt` 跟 `parseFloat` 要分開? 原來 `parseInt(string, radix)` 比 `parseFloat(string)` 多了個 `radix` 參數可以指定要以幾進位來解讀字串，例如 `parseInt('ff', 16)` 會得到 255。

      - `parseInt` only returns whole numbers, so its use is diminished for decimals. Additionally, a best practice for `parseInt` is to ALWAYS include the `radix` parameter. The `radix` parameter is used to specify which NUMERICAL SYSTEM is to be used.

            parseInt('101', 2) // 5

        [parseInt\(\) \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/parseInt) 提到 Be careful — this does not default to 10. 雖然 `parseInt('101')` 會得到 101，感覺會因平台而異?

        [JavaScript parseInt\(\) Function](https://www.w3schools.com/jsref/jsref_parseint.asp):

        > Older browsers will result `parseInt("010")` as 8, because older versions of ECMAScript, (older than ECMAScript 5, uses the octal radix (8) as default when the string BEGINS WITH "0". As of ECMAScript 5, the default is the decimal radix (10).

        原來是跟 ECMAScript 的版本有關係，最好的方法就是明確給 `radix` 的參數。

      - An alternative method of retrieving a number from a string is with the `+` (unary plus) operator:

            '1.1' + '1.1' // '1.11.1'
            (+'1.1') + (+'1.1') // 2.2
            // Note: the parentheses are added for clarity, not required.

        這太奇怪了

## Boolean

  - [Boolean literals - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Boolean_literals)

      - The Boolean type has two literal values: `true` and `false`.

      - Do not confuse the PRIMITIVE Boolean values `true` and `false` with the true and false values of the `Boolean` object. The `Boolean` object is a WRAPPER around the primitive Boolean data type. See `Boolean` for more information.

        這一點跟 Java 好像，除了 primitive 外還有個 wrapper；意思是用 literal 寫 `true`/`false`，並不會生成 `Boolean` object。

  - [Boolean \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean) #ril

## Number

  - [Numeric literals - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Numeric_literals)

      - `Number` and `BigInt` types can be expressed in decimal (base 10), hexadecimal (base 16), octal (base 8) and binary (base 2).

          - A decimal numeric literal consists of a sequence of digits WITHOUT A LEADING 0 (zero).
          - A leading 0 (zero) on a numeric literal, or a leading `0o` (or `0O`) indicates it is in octal. Octal numerics can include only the digits 0-7.
          - A leading `0x` (or `0X`) indicates a hexadecimal numeric type. Hexadecimal numerics can include digits (0-9) and the letters a-f and A-F. (The case of a character does not change its value, e.g. 0xa = 0xA = 10 and 0xf = 0xF = 15.)
          - A leading `0b` (or `0B`) indicates a binary numeric literal. Binary numerics can only include the digits 0 and 1.

        這裡 `Number` 跟 `BigInt` 都用等寬字顯示，但這裡講的應該是 primitive ??

      - Some examples of numeric literals are:

            0, 117, -345, 123456789123456789n             (decimal, base 10)
            015, 0001, -0o77, 0o777777777777n             (octal, base 8) 
            0x1123, 0x00111, -0xF1A7, 0x123456789ABCDEFn  (hexadecimal, "hex" or base 16)
            0b11, 0b0011, -0b11, 0b11101001010101010101n  (binary, base 2)

    Floating-point literals

      - A floating-point literal can have the following parts:

          - A decimal integer which can be signed (preceded by "+" or "-"),
          - A decimal point ("."),
          - A fraction (another decimal number),
          - An exponent.

        The exponent part is an "e" or "E" followed by an integer, which can be signed (preceded by "+" or "-"). A floating-point literal must have at least one digit and either a decimal point or "e" (or "E").

      - More succinctly, the syntax is:

            [(+|-)][digits].[digits][(E|e)[(+|-)]digits]

        For example:

            3.1415926
            -.123456789
            -3.1E+12
            .1e-23

  - [Floating-point literals - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#Floating-point_literals) #ril

