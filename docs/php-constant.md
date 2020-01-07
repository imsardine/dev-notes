---
title: PHP Programming / Constant
---
# [PHP Programming](php-prog.md) / Constant

  - [PHP: Constants \- Manual](https://www.php.net/manual/en/language.constants.php)

      - A constant is an identifier (name) for a simple value. As the name suggests, that value cannot change during the execution of the script (except for magic constants, which aren't actually constants).

        A constant is CASE-SENSITIVE by default. By convention, constant identifiers are always uppercase.

        感覺 case-sensitive 與否可以調整??

      - The name of a constant follows the same rules as any LABEL in PHP. A valid constant name starts with a letter or underscore, followed by any number of letters, numbers, or underscores. As a regular expression, it would be expressed thusly: `^[a-zA-Z_\x80-\xff][a-zA-Z0-9_\x80-\xff]*$`

        TIP: See also the [Userland Naming Guide](https://www.php.net/manual/en/userlandnaming.php). #ril

      - It is possible to `define()` constants with reserved or even invalid names, whose value can (only) be retrieved with `constant()`. However, doing so is not recommended.

        難道 constant 可以透過 `define()` 外的方法定義??

      - Example #1 Valid and invalid constant names

            <?php

            // Valid constant names
            define("FOO",     "something");
            define("FOO2",    "something else");
            define("FOO_BAR", "something more");

            // Invalid constant names
            define("2FOO",    "something");

            // This is valid, but should be avoided:
            // PHP may one day provide a magical constant
            // that will break your script
            define("__FOO__", "something");

            ?>

        Note: For our purposes here, a letter is a-z, A-Z, and the ASCII characters from 128 through 255 (0x80-0xff).

      - Like [superglobals](https://www.php.net/manual/en/language.variables.predefined.php), the scope of a constant is GLOBAL. You can access constants anywhere in your script without regard to scope. For more information on scope, read the manual section on [variable scope](https://www.php.net/manual/en/language.variables.scope.php). #ril

  - [PHP: Syntax \- Manual](https://www.php.net/manual/en/language.constants.syntax.php) #ril

      - You can define a constant by using the `define()`-function or by using the `const` keyword OUTSIDE A CLASS DEFINITION as of PHP 5.3.0.

        While `define()` allows a constant to be defined to an arbitrary expression, the `const` keyword has RESTRICTIONS as outlined in the next paragraph. Once a constant is defined, it can never be changed or UNDEFINED.

      - When using the `const` keyword, only SCALAR DATA (boolean, integer, float and string) can be contained in constants prior to PHP 5.6. From PHP 5.6 onwards, it is possible to define a constant as a SCALAR EXPRESSION, and it is also possible to define an array constant.

        It is possible to define constants as a resource, but it should be avoided, as it can cause unexpected results. ??

      - You can get the value of a constant by simply specifying its name. Unlike with variables, you should NOT prepend a constant with a `$`. You can also use the function `constant()` to read a constant's value if you wish to obtain the constant's name DYNAMICALLY.

        Use `get_defined_constants()` to get a list of all defined constants.

      - Note: Constants and (global) variables are in a DIFFERENT NAMESPACE. This implies that for example `TRUE` and `$TRUE` are generally different.

      - If you use an undefined constant, PHP assumes that you MEAN THE NAME OF THE CONSTANT ITSELF, just as if you called it as a string (`CONSTANT` vs `"CONSTANT"`). This FALLBACK is deprecated as of PHP 7.2.0, and an error of level `E_WARNING` is issued when it happens (previously, an error of level `E_NOTICE` has been issued instead.)

        See also the manual entry on why `$foo[bar]` is wrong (unless you first `define()` `bar` as a constant). This does not apply to (fully) QUALIFIED constants, which will raise a fatal error if undefined. If you simply want to check if a constant is set, use the `defined()` function. ??

## Magic Constant {: #magic }

  - [PHP: Magic constants \- Manual](https://www.php.net/manual/en/language.constants.predefined.php)

      - PHP provides a large number of PREDEFINED CONSTANTS to any script which it runs. Many of these constants, however, are created by various EXTENSIONS, and will only be present when those extensions are available, either via dynamic loading or because they have been compiled in.

      - There are nine MAGICAL CONSTANTS that CHANGE depending on WHERE THEY ARE USED.

        For example, the value of `__LINE__` depends on the line that it's used on in your script. All these "magical" constants are resolved AT COMPILE TIME, unlike REGULAR CONSTANTS, which are resolved at RUNTIME.

        說法好像相反了? 不過仔細想想，若 magic constant 跟 "where the are used" 有關，確實在 compile time 就會知道。這呼應了 [PHP: include \- Manual](https://www.php.net/manual/en/function.include.php) 的說法：

        > An exception to this rule are magic constants which are EVALUATED BY THE PARSER BEFORE THE INCLUDE OCCURS.

        所以 compile time 似乎是指 parsing 的階段 ??

        These special constants are CASE-INSENSITIVE and are as follows:

        為何 magic constant 不跟 regular constant 一樣採 case-sensitive? 猜想是因為這些 magic constant 某種程度上像是 reserved word，以任何大小寫存在，都不被允許。這並不影響 global variable，因為跟 constant 位處不同的 namespace。

    A few "magical" PHP constants

      - `__LINE__`

        The current line number of the file.

      - `__FILE__`

        The FULL path and filename of the file with SYMLINKS RESOLVED. If used inside an include, the name of the INCLUDED FILE is returned.

      - `__DIR__`

        The directory of the file. If used inside an include, the directory of the INCLUDED FILE is returned.

        This is equivalent to `dirname(__FILE__)`. This directory name does NOT HAVE A TRAILING SLASH unless it is the root directory.

      - `__FUNCTION__`

        The function name, or {closure} for anonymous functions. ??

      - `__CLASS__`

        The class name. The class name includes the NAMESPACE it was declared in (e.g. `Foo\Bar`).

        Note that as of PHP 5.4 `__CLASS__` works also in TRAITS ??. When used in a trait method, `__CLASS__` is the name of the class the trait is used in.

      - `__TRAIT__`

        The trait name. The trait name includes the namespace it was declared in (e.g. `Foo\Bar`).

      - `__METHOD__`

        The class method name.

      - `__NAMESPACE__`

        The name of the current namespace.

      - `ClassName::class`

        The FULLY QUALIFIED class name. See also [`::class`](https://www.php.net/manual/en/language.oop5.basic.php#language.oop5.basic.class.class). #ril

    See also `get_class()`, `get_object_vars()`, `file_exists()` and `function_exists()`.

    Changelog

      - 5.5.0

        Added `::class` magic constant

      - 5.4.0

        Added `__TRAIT__` constant

      - 5.3.0

        Added `__DIR__` and `__NAMESPACE__` constants

## 參考資料 {: #reference }

  - [Predefined Constants](https://www.php.net/manual/en/reserved.constants.php)
  - [`define()`](https://www.php.net/manual/en/function.define.php)
  - [`constant()`](https://www.php.net/manual/en/function.constant.php)
  - [`defined()`](https://www.php.net/manual/en/function.defined.php)
  - [`get_defined_constants()`](https://www.php.net/manual/en/function.get-defined-constants.php)
