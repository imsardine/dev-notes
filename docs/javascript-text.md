---
title: JavaScript / Text Processing
---
# [JavaScript](javascript.md) / Text Processing

## String

  - [String literals - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_Types#String_literals)

      - A string literal is zero or more characters enclosed in double (`"`) OR single (`'`) quotation marks. A string must be delimited by quotation marks of the same type; that is, either both single quotation marks or both double quotation marks. The following are examples of string literals:

            'foo'
            "bar"
            '1234'
            'one line \n another line'
            "John's cat"

      - You can call any of the methods of the `String` object on a string literal value—JavaScript automatically converts the string literal to a temporary `String` object, calls the method, then discards the temporary `String` object. You can also use the `String.length` property with a string literal:

            console.log("John's cat".length)
            // Will print the number of symbols in the string including whitespace.
            // In this case, 10.

      - In ES2015, TEMPLATE LITERALS are also available. Template literals are enclosed by the back-tick (\` \`) (grave accent) character instead of double or single quotes. Template strings provide syntactic sugar for constructing strings. This is similar to STRING INTERPOLATION features in Perl, Python and more.

            // Basic literal string creation
            `In JavaScript '\n' is a line-feed.`

            // Multiline strings
            `In JavaScript template strings can run
             over multiple lines, but double and single
             quoted strings cannot.`

            // String interpolation
            var name = 'Bob', time = 'today';
            `Hello ${name}, how are you ${time}?`

        Multiline 的用法是 template literal 特有的，雖然單雙引號搭配 escaped line break 也可以辦到，但就是沒那麼方便。

      - Optionally, a TAG can be added to allow the string construction to be customized, avoiding INJECTION ATTACKS or constructing higher level data structures from string contents. ??

            // Construct an HTTP request prefix used to interpret the replacements and construction
            POST`http://foo.org/bar?a=${a}&b=${b}
                 Content-Type: application/json
                 X-Credentials: ${credentials}
                 { "foo": ${foo},
                   "bar": ${bar}}`(myOnReadyStateChangeHandler);

      - You should use string literals unless you specifically need to use a `String` object.

        應該是考量到可讀性，string literal 就會自動生成 `String` object，不用特別用 `String(literal)`。

    Using special characters in strings

      - In addition to ordinary characters, you can also include special characters in strings, as shown in the following example.

            'one line \n another line'

      - The following table lists the special characters that you can use in JavaScript strings.

          - `\0` - Null Byte
          - `\b` - Backspace
          - `\f` - Form feed
          - `\n` - New line
          - `\r` - Carriage return
          - `\t` - Tab
          - `\v` - Vertical tab
          - `\'` - Apostrophe or single quote
          - `\"` - Double quote
          - `\\` - Backslash character

          - `\XXX`

            The character with the Latin-1 encoding specified by up to three OCTAL digits XXX between 0 and 377. For example, `\251` is the octal sequence for the copyright symbol.

          - `\xXX`

            The character with the Latin-1 encoding specified by the two HEXADECIMAL digits XX between 00 and FF. For example, `\xA9` is the hexadecimal sequence for the copyright symbol.

          - `\uXXXX`

            The Unicode character specified by the four hexadecimal digits XXXX. For example, `\u00A9` is the Unicode sequence for the copyright symbol. See Unicode escape sequences.

          - `\u{XXXXX}`

            Unicode code POINT ESCAPES. For example, \u{2F804} is the same as the simple Unicode escapes `\uD87E\uDC04`.

            這跟 `\uXXXX` 的用法有何不同 ??

    Escaping characters

      - For characters not listed in the table, a preceding backslash is IGNORED, but this usage is DEPRECATED and should be avoided.

      - You can insert a quotation mark inside a string by preceding it with a backslash. This is known as escaping the quotation mark. For example:

            var quote = "He read \"The Cremation of Sam McGee\" by R.W. Service.";
            console.log(quote);

        The result of this would be:

            He read "The Cremation of Sam McGee" by R.W. Service.

        To include a literal backslash inside a string, you must escape the backslash character. For example, to assign the file path `c:\temp` to a string, use the following:

            var home = 'c:\\temp';

        You can also ESCAPE LINE BREAKS by preceding them with backslash. The backslash and line break are both removed from the value of the string.

            var str = 'this string \
            is broken \
            across multiple \
            lines.'
            console.log(str);   // this string is broken across multiple lines.

      - Although JavaScript does not have "HEREDOC" syntax, you can get close by adding a line break escape and an escaped line break at the end of each line:

            var poem =
            'Roses are red,\n\
            Violets are blue.\n\
            Sugar is sweet,\n\
            and so is foo.'

        ECMAScript 2015 introduces a new type of literal, namely template literals. This allows for many new features including multiline strings!

            var poem = 
            `Roses are red, 
            Violets are blue. 
            Sugar is sweet, 
            and so is foo.`

  - [String \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) #ril

## String Interpolation ??

  - [String literals - Grammar and types \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Grammar_and_types#Literals#String_literals) #ril
  - [Template literals (Template strings) \- JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals) #ril

## Multiline String ??

  - [Creating multiline strings in JavaScript \- Stack Overflow](https://stackoverflow.com/questions/805107/) #ril
      - Anonymous: ES6 有 template literal，除了可以做 variable interpolation，另一個特性是 multiline。

## 參考資料 {: #reference }

手冊：

  - [String - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String)
