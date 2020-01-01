# PHP

  - [PHP \- Wikipedia](https://en.wikipedia.org/wiki/PHP)

      - PHP: Hypertext Preprocessor (or simply PHP) is a general-purpose programming language originally designed for web development.

        PHP originally stood for Personal Home Page, but it now stands for the recursive initialism PHP: Hypertext Preprocessor.

      - It was originally created by Rasmus Lerdorf in 1994; the PHP REFERENCE IMPLEMENTATION is now produced by The PHP Group.

      - PHP code may be executed with a command line interface (CLI), embedded into HTML code, or used in combination with various web template systems, web content management systems, and web frameworks.

        PHP code is usually processed by a PHP interpreter implemented as a module in a web server or as a Common Gateway Interface (CGI) executable. The web server outputs the results of the interpreted and executed PHP code, which may be any type of data, such as generated HTML code or binary image data.

        習慣上不會再有一層 application server ??

      - PHP can be used for many programming tasks outside of the web context, such as standalone graphical applications and robotic drone control.

        但在非 web 的領域，有更好的選擇 ...

      - The standard PHP interpreter, powered by the Zend Engine, is free software released under the PHP License. PHP has been widely ported and can be deployed on most web servers on almost every operating system and platform, free of charge.

      - The PHP language evolved without a written formal specification or standard until 2014, with the original implementation acting as the de facto standard which other implementations aimed to follow. Since 2014, work has gone on to create a formal PHP specification.

        可以發展到現在，但 2014 開始才有正式的規格，這點滿驚人的!!

      - As of September 2019, over 60% of sites on the web using PHP are still on discontinued/"EOLed" version 5.6 or older; versions prior to 7.1 are no longer officially supported by The PHP Development Team, but security support is provided by third parties, such as Debian.

        昇級難度很高嗎 ??

## Coding Style {: #style }

  - [5 PHP Coding Standards You Will Love and How to Use them](https://blog.sideci.com/5-php-coding-standards-you-will-love-and-how-to-use-them-adf6a4855696) (2018-04-26) #ril

      - Setting a coding standard is very important in team development. Agreeing on one coding standard helps keep your code neat and easy to read and also makes it easy to see the difference in your code WHEN REVIEWING THEM.

      - Unfortunately, coding standards for PHP are different between frameworks and PHP versions. For example, method names are to be written in various styles, such as camelCase, snake_case and so on. Rules for naming namespaces and classes and how to use indents and spaces are also different. In this article, we will introduce several WELL-KNOWN PHP coding standards.

        隨著 framework 變還好，但會因 PHP version 而異就怪了?

## 安裝設置 {: #setup }

  - [PHP: General Installation Considerations \- Manual](https://www.php.net/manual/en/install.general.php)

      - Before starting the installation, first you need to know what do you want to use PHP for. There are three main fields you can use PHP, as described in the What can PHP do? section:

          - Websites and web applications (server-side scripting)
          - Command line scripting
          - Desktop (GUI) applications #ril

      - For the first and most common form, you need three things: PHP itself, a web server and a web browser. You probably already have a web browser, and depending on your operating system setup, you may also have a web server (e.g. Apache on Linux and macOS; IIS on Windows). You may also rent webspace at a company. This way, you don't need to set up anything on your own, only write your PHP scripts, upload it to the server you rent, and see the results in your browser.

      - In case of setting up the server and PHP on your own, you have two choices for the method of CONNECTING PHP TO THE SERVER.

        For many servers PHP has a DIRECT MODULE INTERFACE (also called SAPI). These servers include Apache, Microsoft Internet Information Server, Netscape and iPlanet servers. Many other servers have support for ISAPI, the Microsoft module interface (OmniHTTPd for example).

        If PHP has no MODULE SUPPORT for your web server, you can always use it as a CGI or FastCGI processor. This means you set up your server to use the CGI executable of PHP to process all PHP file requests on the server.

      - If you are also interested in using PHP for command line scripting (e.g. write scripts autogenerating some images for you offline, or processing text files depending on some arguments you pass to them), you always need the command line executable. For more information, read the section about writing command line PHP applications. In this case, you need no server and no browser.

      - With PHP you can also write desktop GUI applications using the PHP-GTK extension. This is a completely different approach than writing web pages, as you do not output any HTML, but manage windows and objects within them.

        For more information about PHP-GTK, please » [visit the site dedicated to this extension](http://gtk.php.net/). PHP-GTK is not included in the official PHP distribution.

        真的有人會用 PHP 來寫桌面應用?

      - From now on, this section deals with setting up PHP for web servers on Unix and Windows with server module interfaces and CGI executables. You will also find information on the command line executable in the following sections.

        PHP 主要還是以 web 應用為大宗，其次是 CLI，而 GUI 則相對少見。

      - PHP source code and binary distributions for Windows can be found at » https://www.php.net/downloads.php.

  - [How to Install Different PHP \(5\.6, 7\.0 and 7\.1\) Versions in Ubuntu](https://www.tecmint.com/install-different-php-versions-in-ubuntu/) (2019-05-08) #ril

## 參考資料 {: #reference }

  - [PHP: Hypertext Preprocessor](https://www.php.net/) (The PHP Group)
  - [php/php-src - GitHub](https://github.com/php/php-src)
  - [PHP: Downloads](https://www.php.net/downloads.php)

更多：

  - [Programming](php-programming.md)
  - [Testing](php-testing.md)
  - [Standard I/O](php-stdio.md)
  - [File I/O](php-file.md)
  - [Logging](php-logging.md)
  - [CLI SAPI](php-cli.md)
  - [Web Development](php-web.md)
  - [i18n](php-i18n.md)

相關：

  - [Composer](composer.md) - PHP 的 dependency manager。
  - [PHP CS Fixer](php-cs-fixer.md) - 檢查 PHP coding style 的工具

手冊：

  - [`php` Command Line Options](https://www.php.net/manual/en/features.commandline.options.php)
  - [`php.ini` Directives](https://www.php.net/manual/en/ini.list.php)
