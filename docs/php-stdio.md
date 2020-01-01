---
title: PHP / Standard I/O
---
# [PHP](php.md) / Standard I/O

## `echo()` {: #echo }

  - [PHP: PHP tags \- Manual](https://www.php.net/manual/en/language.basic-syntax.phptags.php)

      - PHP includes a short echo tag `<?=` which is a short-hand to the more verbose `<?php echo`.
      - For outputting large blocks of text, dropping out of PHP PARSING MODE is generally more efficient than sending all of the text through `echo` or `print`.
      - Note: Starting with PHP 5.4, short echo tag `<?=` is always recognized and valid, regardless of the `short_open_tag` setting.

  - [PHP: echo \- Manual](https://www.php.net/manual/en/function.echo.php) #ril

## `print()` {: #print }

  - [PHP: print \- Manual](https://www.php.net/manual/en/function.print.php) #ril

## I/O Stream {: #io-stream }

  - [PHP: I/O streams \- Manual](https://www.php.net/manual/en/features.commandline.io-streams.php) #ril

## 參考資料 {: #reference }

相關：

  - [CLI SAPI](php-cli.md)

手冊：

  - [`echo()`](https://www.php.net/manual/en/function.echo.php)
  - [`print()`](https://www.php.net/manual/en/function.print.php)
