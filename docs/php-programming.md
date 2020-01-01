---
title: PHP / Programming
---
# [PHP](php.md) / Programming

## 新手上路 {: #getting-started }

  - [PHP: PHP tags \- Manual](https://www.php.net/manual/en/language.basic-syntax.phptags.php)

      - When PHP parses a file, it looks for opening and closing tags, which are `<?php` and `?>` which tell PHP to start and stop interpreting the code between them.

        Parsing in this manner allows PHP to be EMBEDDED in all sorts of different documents, as everything outside of a pair of opening and closing tags is ignored by the PHP parser.

      - PHP includes a short echo tag `<?=` which is a short-hand to the more verbose `<?php echo`.

      - PHP also allows for short open tag `<?` (which is discouraged since it is only available if enabled using the `short_open_tag` `php.ini` configuration file directive, or if PHP was configured with the `--enable-short-tags` option).

      - If a file contains only PHP code, it is preferable to OMIT the PHP CLOSING tag at the end of the file.

        This prevents accidental whitespace or new lines being added after the PHP closing tag, which may cause unwanted effects because PHP will START OUTPUT BUFFERING ?? when there is no intention from the programmer to send any output at that point in the script.

            <?php
            echo "Hello world";

            // ... more code

            echo "Last statement";

            // the script ends here with no PHP closing tag

        原來沒有 closing tag 是比較好的寫法。

    Changelog

      - 7.0.0

        The ASP tags `<%`, `%>`, `<%=`, and the script tag `<script language="php">` are removed from PHP.

        正確的說法是 ASP-style，跟 ASP 沒什麼關係。

      - 5.4.0

        The tag `<?=` is always available regardless of the `short_open_tag` ini setting.

  - [PHP: Escaping from HTML \- Manual](https://www.php.net/manual/en/language.basic-syntax.phpmode.php)

      - Everything outside of a pair of opening and closing tags is ignored by the PHP parser which allows PHP files to have MIXED CONTENT. This allows PHP to be embedded in HTML documents, for example to create templates.

            <p>This is going to be ignored by PHP and displayed by the browser.</p>
            <?php echo 'While this is going to be parsed.'; ?>
            <p>This will also be ignored by PHP and displayed by the browser.</p>

      - This works as expected, because when the PHP interpreter hits the `?>` closing tags, it simply starts outputting whatever it finds (except for an immediately following newline - see instruction separation) until it hits another opening tag unless in the middle of a conditional statement in which case the interpreter will determine the outcome of the conditional before making a decision of what to skip over. See the next example.

    Using structures with conditions

      - Example #1 Advanced escaping using conditions

            <?php if ($expression == true): ?>
              This will show if the expression is true.
            <?php else: ?>
              Otherwise this will show.
            <?php endif; ?>

        In this example PHP will skip the blocks where the condition is not met, even though they are outside of the PHP open/close tags; PHP skips them according to the condition since the PHP interpreter will jump over blocks contained within a condition that is not met.

      - For outputting large blocks of text, dropping out of PHP PARSING MODE is generally more efficient than sending all of the text through `echo` or `print`.

      - In PHP 5, there are up to five different pairs of opening and closing tags available in PHP, depending on how PHP is configured.

        Two of these, `<?php ?>` and `<script language="php"> </script>`, are always available. There is also the short echo tag `<?= ?>`, which is always available in PHP 5.4.0 and later.

        這裡 always available 的說法只適用於 `<?php ?>` 與 `<?= ?>`，因為 `<script language="php"> </script>` 的寫法在 PHP 7 也不支援了。

        The other two are short tags and ASP style tags. As such, while some people find short tags and ASP style tags convenient, they are LESS PORTABLE, and generally not recommended.

      - Note: Also note that if you are embedding PHP within XML or XHTML you will need to use the `<?php ?>` tags to remain compliant with standards.

      - PHP 7 removes support for ASP tags and `<script language="php">` tags. As such, we recommend only using `<?php ?>` and `<?= ?>` when writing PHP code to maximise compatibility.

      - Example #2 PHP Opening and Closing Tags

            1.  <?php echo 'if you want to serve PHP code in XHTML or XML documents,
                            use these tags'; ?>

            2.  You can use the short echo tag to <?= 'print this string' ?>.
                It's always enabled in PHP 5.4.0 and later, and is equivalent to
                <?php echo 'print this string' ?>.

            3.  <? echo 'this code is within short tags, but will only work '.
                        'if short_open_tag is enabled'; ?>

            4.  <script language="php">
                    echo 'some editors (like FrontPage) don\'t
                          like processing instructions within these tags';
                </script>
                This syntax is removed in PHP 7.0.0.

            5.  <% echo 'You may optionally use ASP-style tags'; %>
                Code within these tags <%= $variable; %> is a shortcut for this code <% echo $variable; %>
                Both of these syntaxes are removed in PHP 7.0.0.

      - Short tags (example three) are only available when they are enabled via the `short_open_tag` `php.ini` configuration file directive, or if PHP was configured with the `--enable-short-tags` option.

      - ASP style tags (example five) are only available when they are enabled via the `asp_tags` `php.ini` configuration file directive, and have been removed in PHP 7.0.0.

      - Note: Using short tags should be avoided when developing applications or libraries that are meant for redistribution, or deployment on PHP servers which are NOT UNDER YOUR CONTROL, because short tags may not be supported on the target server. For portable, redistributable code, be sure not to use short tags.

        某種程度上，這不包含 `<?= ?>`。

      - Note: In PHP 5.2 and earlier, the parser does not allow the `<?php` opening tag to be the only thing in a file. This is allowed as of PHP 5.3 provided there are one or more whitespace characters after the opening tag.

        不是要講 closing tag 是 optional?

      - Note: Starting with PHP 5.4, short echo tag `<?=` is always recognized and valid, regardless of the `short_open_tag` setting.

  - [PHP: Instruction separation \- Manual](https://www.php.net/manual/en/language.basic-syntax.instruction-separation.php)

      - As in C or Perl, PHP requires instructions to be terminated with a SEMICOLON at the end of each statement.

        The closing tag of a block of PHP code automatically IMPLIES A SEMICOLON; you do not need to have a semicolon terminating the last line of a PHP block.

        The closing tag for the block will include the immediately trailing newline if one is present. ??

            <?php
                echo 'This is a test';
            ?>

            <?php echo 'This is a test' ?>

            <?php echo 'We omitted the last closing tag';

      - Note: The closing tag of a PHP block at the end of a file is optional, and in some cases omitting it is HELPFUL WHEN USING `include` OR `require`, so unwanted whitespace will not occur at the end of files, and you will still be able to ADD HEADERS TO THE RESPONSE LATER. ??

        不懂為什麼這對 `include`/`require` 有幫助 ??

        It is also handy if you use OUTPUT BUFFERING, and would not like to see added unwanted whitespace at the end of the parts generated by the included files.

## Comment

  - [PHP: Comments \- Manual](https://www.php.net/manual/en/language.basic-syntax.comments.php)

      - PHP supports 'C', 'C++' and Unix shell-style (Perl style) comments. For example:

            <?php
                echo 'This is a test'; // This is a one-line c++ style comment
                /* This is a multi line comment
                   yet another line of comment */
                echo 'This is yet another test';
                echo 'One Final Test'; # This is a one-line shell-style comment
            ?>

      - The "one-line" comment styles only comment to the end of the line or the current block of PHP code, whichever comes first. This means that HTML code after `// ... ?>` or `# ... ?>` WILL be printed: `?>` breaks out of PHP mode and returns to HTML mode, and `//` or `#` cannot influence that.

        If the `asp_tags` configuration directive is enabled, it behaves the same with `// %>` and `# %>`. However, the `</script>` tag doesn't break out of PHP mode in a one-line comment.

        注意這裡 PHP (PARSING) MODE 與 HTML MODE 的說法；事實上 [PHP: Escaping from HTML \- Manual](https://www.php.net/manual/en/language.basic-syntax.phpmode.php) 的 URL 裡也有 `phpmode` 的字眼出現。

            <h1>This is an <?php # echo 'simple';?> example</h1>
            <p>The header above will say 'This is an  example'.</p>

      - 'C' style comments end at the first `*/` encountered. Make sure you don't nest 'C' style comments. It is easy to make this mistake if you are trying to comment out a large block of code.

            <?php
             /*
                echo 'This is a test'; /* This comment will cause a problem */
             */
            ?>

## Variable

  - [PHP: Variables \- Manual](https://www.php.net/manual/en/language.variables.php) #ril
  - [PHP: Variable scope \- Manual](https://www.php.net/manual/en/language.variables.scope.php) #ril

## Constant

  - [PHP: Constants \- Manual](https://www.php.net/manual/en/language.constants.php) #ril
  - [PHP: define \- Manual](https://www.php.net/manual/en/function.define.php) #ril

  - [PHP: Magic constants \- Manual](https://www.php.net/manual/en/language.constants.predefined.php)

      - PHP provides a large number of PREDEFINED CONSTANTS to any script which it runs. Many of these constants, however, are created by various EXTENSIONS, and will only be present when those extensions are available, either via dynamic loading or because they have been compiled in.

      - There are nine MAGICAL CONSTANTS that CHANGE depending on WHERE THEY ARE USED.

        For example, the value of `__LINE__` depends on the line that it's used on in your script. All these "magical" constants are resolved AT COMPILE TIME, unlike REGULAR CONSTANTS, which are resolved at RUNTIME. These special constants are CASE-INSENSITIVE and are as follows:

        說法好像相反了? 不過仔細想想，若 magic constant 跟 "where the are used" 有關，確實在 compile time 就會知道。這呼應了 [PHP: include \- Manual](https://www.php.net/manual/en/function.include.php) 的說法：

        > An exception to this rule are magic constants which are EVALUATED BY THE PARSER BEFORE THE INCLUDE OCCURS.

        所以 compile time 似乎是指 parsing 的階段 ??

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

更多：

  - [Data Type](php-type.md)
  - [String](php-string.md)
  - [Including](php-including.md)

手冊：

  - [Core php.ini Directives](https://www.php.net/manual/en/ini.core.php)
  - [Language Reference](https://www.php.net/manual/en/langref.php)
  - [Function Reference](https://www.php.net/manual/en/funcref.php)
