---
title: PHP / String
---
# [PHP](php.md) / String

  - [PHP: Strings \- Manual](https://www.php.net/manual/en/language.types.string.php) #ril

## Heredoc

  - [PHP: Strings \- Manual](https://www.php.net/manual/en/language.types.string.php#language.types.string.syntax.heredoc) #ril

## Nowdoc

  - [PHP: Strings \- Manual](https://www.php.net/manual/en/language.types.string.php#language.types.string.syntax.nowdoc) #ril

## Variable Parsing

  - [Variable parsing - PHP: Strings \- Manual](https://www.php.net/manual/en/language.types.string.php#language.types.string.parsing)

      - When a string is specified in DOUBLE QUOTES or with HEREDOC, variables are parsed within it.

        There are two types of syntax: a simple one and a complex one. The simple syntax is the most common and convenient. It provides a way to EMBED a variable, an array value, or an object property in a string with a minimum of effort.

        The complex syntax can be recognised by the curly braces surrounding the expression.

    Simple syntax

      - If a dollar sign (`$`) is encountered, the parser will GREEDILY take as many tokens as possible to form a valid variable name. Enclose the variable name in curly braces to explicitly specify the end of the name.

            <?php
            $juice = "apple";

            echo "He drank some $juice juice.".PHP_EOL;
            // Invalid. "s" is a valid character for a variable name, but the variable is $juice.
            echo "He drank some juice made of $juices.";
            // Valid. Explicitly specify the end of the variable name by enclosing it in braces:
            echo "He drank some juice made of ${juice}s.";
            ?>

        The above example will output:

            He drank some apple juice.
            He drank some juice made of .
            He drank some juice made of apples.

        注意 `$juices` 雖然沒被定義，但也不會引發錯誤，就默默被置換成空字串了。

      - Similarly, an array index or an object property can be parsed. With array indices, the closing square bracket (`]`) marks the end of the index. The same rules apply to object properties as to simple variables.

      - Example #10 Simple syntax example

            <?php
            $juices = array("apple", "orange", "koolaid1" => "purple");

            echo "He drank some $juices[0] juice.".PHP_EOL;
            echo "He drank some $juices[1] juice.".PHP_EOL;
            echo "He drank some $juices[koolaid1] juice.".PHP_EOL;

            class people {
                public $john = "John Smith";
                public $jane = "Jane Smith";
                public $robert = "Robert Paulsen";

                public $smith = "Smith";
            }

            $people = new people();

            echo "$people->john drank some $juices[0] juice.".PHP_EOL;
            echo "$people->john then said hello to $people->jane.".PHP_EOL;
            echo "$people->john's wife greeted $people->robert.".PHP_EOL;
            echo "$people->robert greeted the two $people->smiths."; // Won't work
            ?>

        The above example will output:

            He drank some apple juice.
            He drank some orange juice.
            He drank some purple juice.
            John Smith drank some apple juice.
            John Smith then said hello to Jane Smith.
            John Smith's wife greeted Robert Paulsen.
            Robert Paulsen greeted the two .

        As of PHP 7.1.0 also negative numeric indices are supported.

      - Example #11 Negative numeric indices

            <?php
            $string = 'string';
            echo "The character at index -2 is $string[-2].", PHP_EOL;
            $string[-3] = 'o';
            echo "Changing the character at index -3 to o gives $string.", PHP_EOL;
            ?>

        The above example will output:

            The character at index -2 is n.
            Changing the character at index -3 to o gives strong.

        For anything more complex, you should use the complex syntax.

    Complex (curly) syntax

      - This isn't called complex because the syntax is complex, but because it allows for the use of COMPLEX EXPRESSIONS.

      - Any scalar variable, array element or object property with a string representation can be included via this syntax. Simply write the expression the same way as it would appear outside the string, and then wrap it in `{` and `}`.

        Since `{` can not be escaped, this syntax will only be recognised when the `$` immediately follows the `{`. Use `{\$` to get a literal `{$`. Some examples to make it clear:

            <?php
            // Show all errors
            error_reporting(E_ALL);

            $great = 'fantastic';

            // Won't work, outputs: This is { fantastic}
            echo "This is { $great}";

            // Works, outputs: This is fantastic
            echo "This is {$great}";

            // Works
            echo "This square is {$square->width}00 centimeters broad.";


            // Works, quoted keys only work using the curly brace syntax
            echo "This works: {$arr['key']}";


            // Works
            echo "This works: {$arr[4][3]}";

            // This is wrong for the same reason as $foo[bar] is wrong  outside a string.
            // In other words, it will still work, but only because PHP first looks for a
            // constant named foo; an error of level E_NOTICE (undefined constant) will be
            // thrown.
            echo "This is wrong: {$arr[foo][3]}";

            // Works. When using multi-dimensional arrays, always use braces around arrays
            // when inside of strings
            echo "This works: {$arr['foo'][3]}";

            // Works.
            echo "This works: " . $arr['foo'][3];

            echo "This works too: {$obj->values[3]->name}";

            echo "This is the value of the var named $name: {${$name}}";

            echo "This is the value of the var named by the return value of getName(): {${getName()}}";

            echo "This is the value of the var named by the return value of \$object->getName(): {${$object->getName()}}";

            // Won't work, outputs: This is the return value of getName(): {getName()}
            echo "This is the return value of getName(): {getName()}";
            ?>

      - It is also possible to access class properties using variables within strings using this syntax.

            <?php
            class foo {
                var $bar = 'I am bar.';
            }

            $foo = new foo();
            $bar = 'bar';
            $baz = array('foo', 'bar', 'baz', 'quux');
            echo "{$foo->$bar}\n";
            echo "{$foo->{$baz[1]}}\n";
            ?>

        The above example will output:

            I am bar.
            I am bar.

      - Note: Functions, method calls, static class variables, and class constants inside `{$}` work since PHP 5. However, the value accessed will be interpreted as the name of a variable IN THE SCOPE IN WHICH THE STRING IS DEFINED.

        Using single curly braces (`{}`) will not work for accessing the return values of functions or methods or the values of class constants or static class variables.

            <?php
            // Show all errors.
            error_reporting(E_ALL);

            class beers {
                const softdrink = 'rootbeer';
                public static $ale = 'ipa';
            }

            $rootbeer = 'A & W';
            $ipa = 'Alexander Keith\'s';

            // This works; outputs: I'd like an A & W
            echo "I'd like an {${beers::softdrink}}\n";

            // This works too; outputs: I'd like an Alexander Keith's
            echo "I'd like an {${beers::$ale}}\n";
            ?>

