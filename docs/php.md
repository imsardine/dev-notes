# PHP

  - [PHP \- Wikipedia](https://en.wikipedia.org/wiki/PHP)

      - PHP: Hypertext Preprocessor (or simply PHP) is a general-purpose programming language originally designed for web development.

        PHP originally stood for Personal Home Page, but it now stands for the recursive initialism PHP: Hypertext Preprocessor.

      - It was originally created by Rasmus Lerdorf in 1994; the PHP reference implementation is now produced by The PHP Group.

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

## 新手上路 {: #getting-started }

## Coding Style {: #style }

  - [5 PHP Coding Standards You Will Love and How to Use them](https://blog.sideci.com/5-php-coding-standards-you-will-love-and-how-to-use-them-adf6a4855696) (2018-04-26) #ril

      - Setting a coding standard is very important in team development. Agreeing on one coding standard helps keep your code neat and easy to read and also makes it easy to see the difference in your code WHEN REVIEWING THEM.

      - Unfortunately, coding standards for PHP are different between frameworks and PHP versions. For example, method names are to be written in various styles, such as camelCase, snake_case and so on. Rules for naming namespaces and classes and how to use indents and spaces are also different. In this article, we will introduce several WELL-KNOWN PHP coding standards.

        隨著 framework 變還好，但會因 PHP version 而異就怪了?

## `php` CLI {: #php-cli }

  - [PHP: Interactive shell \- Manual](https://www.php.net/manual/en/features.commandline.interactive.php)

      - As of PHP 5.1.0, the CLI SAPI provides an interactive shell using the `-a` option if PHP is compiled with the `--with-readline` option. As of PHP 7.1.0 the interactive shell is also available on Windows, if the [readline extension](https://www.php.net/manual/en/book.readline.php) is enabled. #ril

        其中 SAPI = Server Application Programming Interface，用 CLI 時跟 server 有什麼關係 ??

        Using the interactive shell you are able to type PHP code and have it executed directly.

    Example #1 Executing code using the interactive shell

        $ php -a
        Interactive shell

        php > echo 5+8;
        13
        php > function addTwo($n)
        php > {
        php { return $n + 2;
        php { }
        php > var_dump(addtwo(2));
        int(4)
        php >

      - The interactive shell also features tab completion for functions, constants, class names, variables, static method calls and class constants.

    Example #2 Tab completion

      - Pressing the tab key TWICE when there are multiple possible completions will result in a list of these completions:

            php > strp[TAB][TAB]
            strpbrk   strpos    strptime
            php > strp

      - When there is only one possible completion, pressing tab ONCE will complete the rest on the same line:

            php > strpt[TAB]ime(

      - Completion will also work for names that have been defined during the current interactive shell SESSION:

            php > $fooThisIsAReallyLongVariableName = 42;
            php > $foo[TAB]ThisIsAReallyLongVariableName

        The interactive shell stores your history which can be accessed using the up and down keys. The history is saved in the `~/.php_history` file.

      - As of PHP 5.4.0, the CLI SAPI provides the `php.ini` settings `cli.pager` and `cli.prompt`. The `cli.pager` setting allows an external program (such as `less`) to act as a pager for the output instead of being displayed directly on the screen. The `cli.prompt` setting makes it possible to change the `php >` prompt.

        In PHP 5.4.0 it was also made possible to set `php.ini` settings in the interactive shell using a shorthand notation. (下面 example #3 就會講到)

    Example #3 Setting `php.ini` settings in the interactive shell

      - The `cli.prompt` setting:

            php > #cli.prompt=hello world :>
            hello world :>

      - Using backticks it is possible to have PHP code executed in the prompt:

            php > #cli.prompt=`echo date('H:i:s');` php >
            15:49:35 php > echo 'hi';
            hi
            15:49:43 php > sleep(2);
            15:49:45 php >

      - Setting the pager to `less`:

            php > #cli.pager=less
            php > phpinfo();
            (output displayed in less)
            php >

      - The `cli.prompt` setting supports a few escape sequences:

          - `\e` - Used for adding colors to the prompt. An example could be `\e[032m\v \e[031m\b \e[34m\> \e[0m`
          - `\v` - The PHP version.
          - `\b` - Indicates which block PHP is in. For instance `/*` to indicate being inside a multi-line comment. The outer scope is denoted by `php`.
          - `\>` - Indicates the prompt character. By default this is `>`, but changes when the shell is inside an unterminated block or string. Possible characters are: `' " { ( >`

      - Note: Files included through `auto_prepend_file` and `auto_append_file` are parsed in this mode but with some restrictions - e.g. functions have to be defined before called.

        Note: [Autoloading](https://www.php.net/manual/en/language.oop5.autoload.php) is not available if using PHP in CLI interactive mode. #ril

  - [PHP: Usage \- Manual](https://www.php.net/manual/en/features.commandline.usage.php)

      - There are three different ways of supplying the CLI SAPI with PHP code to be executed:

         1. Tell PHP to execute a certain file.

                $ php my_script.php
                $ php -f my_script.php

            Both ways (whether using the `-f` switch or not) execute the file `my_script.php`. Note that there is no restriction on which files can be executed; in particular, the filename is not required have a `.php` extension.

            Note: If arguments need to be passed to the script when using `-f`, the first argument must be `--`.

         2. Pass the PHP code to execute directly on the command line.

                $ php -r 'print_r(get_defined_constants());'

            Special care has to be taken with regard to shell variable substitution and usage of quotes.

            Note: Read the example carefully: there are NO BEGINNING OR ENDING TAGS! The `-r` switch simply does not need them, and using them will lead to a parse error.

         3. Provide the PHP code to execute via standard input (stdin).

            This gives the powerful ability to create PHP code dynamically and feed it to the binary, as shown in this (fictional) example:

                $ some_application | some_filter | php | sort -u > final_output.txt

        You cannot combine any of the three ways to execute code.

      - As with every shell application, the PHP BINARY accepts a number of arguments; however, the PHP SCRIPT can also receive further arguments. The number of arguments that can be passed TO YOUR SCRIPT is not limited by PHP (and although the shell has a limit to the number of characters which can be passed, this is not in general likely to be hit).

        注意 PHP binary 與 PHP script 的差別。

        The arguments passed to the script are available in the global array `$argv`. The first index (zero) always contains the name of the script as called from the command line. Note that, if the code is executed in-line using the command line switch `-r`, the value of `$argv[0]` will be just a dash (`-`). The same is true if the code is executed via a pipe from STDIN.

      - A second global variable, `$argc`, contains the number of elements in the `$argv` array (not the number of arguments passed to the script).

        比 arguments passed to the script 的數量多一個 -- `$argv[0]` (name of the script)。

      - As long as the arguments to be passed to the script do not start with the `-` character, there's nothing special to watch out for.

        Passing an argument to the script which starts with a `-` will cause trouble because the PHP interpreter thinks it has to handle it itself, even before executing the script. To prevent this, use the ARGUMENT LIST SEPARATOR `--`. After this separator has been parsed by PHP, every following argument is PASSED UNTOUCHED to the script.

            # This will not execute the given code but will show the PHP usage
            $ php -r 'var_dump($argv);' -h
            Usage: php [options] [-f] <file> [args...]
            [...]

            # This will pass the '-h' argument to the script and prevent PHP from showing its usage
            $ php -r 'var_dump($argv);' -- -h
            array(2) {
              [0]=>
              string(1) "-"
              [1]=>
              string(2) "-h"
            }

      - However, on Unix systems there's another way of using PHP for shell scripting: make the first line of the script start with `#!/usr/bin/php` (or whatever the path to your PHP CLI binary is if different). The rest of the file should contain normal PHP code within the usual PHP STARTING AND END TAGS.

        只有 `-r` 才不需要有 `<?php ... ?>`。

        Once the execution attributes of the file are set appropriately (e.g. `chmod +x test`), the script can be executed like any other shell or perl script:

    Example #1 Execute PHP script as shell script

        #!/usr/bin/php
        <?php
        var_dump($argv);
        ?>

      - Assuming this file is named `test` in the current directory, it is now possible to do the following:

            $ chmod +x test
            $ ./test -h -- foo
            array(4) {
              [0]=>
              string(6) "./test"
              [1]=>
              string(2) "-h"
              [2]=>
              string(2) "--"
              [3]=>
              string(3) "foo"
            }

        As can be seen, in this case no special care needs to be taken when passing parameters starting with `-`.

      - The PHP executable can be used to run PHP scripts absolutely independent of the web server. On Unix systems, the special `#!` (or "shebang") first line should be added to PHP scripts so that the system can automatically tell which program should run the script.

        On Windows platforms, it's possible to associate `php.exe` with the double click option of the `.php` extension, or a batch file can be created to run scripts through PHP. The special shebang first line for Unix does no harm on Windows (as it's formatted as a PHP comment), so CROSS PLATFORM programs can be written by including it. A simple example of writing a command line PHP program is shown below.

    Example #2 Script intended to be run from command line (`script.php`)

        #!/usr/bin/php
        <?php

        if ($argc != 2 || in_array($argv[1], array('--help', '-help', '-h', '-?'))) {
        ?>

        This is a command line PHP script with one option.

          Usage:
          <?php echo $argv[0]; ?> <option>

          <option> can be some word you would like
          to print out. With the --help, -help, -h,
          or -? options, you can get this help.

        <?php
        } else {
            echo $argv[1];
        }
        ?>

      - The script above includes the Unix shebang first line to indicate that this file should be run by PHP. We are working with a CLI version here, so no HTTP headers will be output.

        這一點在 [Differences to other SAPIs](https://www.php.net/manual/en/features.commandline.differences.php) 中有說明，一樣是把 `.php` 當成 template，在 `<?php ... ?>` 之外的都直接輸出。

      - The program first checks that there is the required one argument (in addition to the script name, which is also counted). If not, or if the argument was `--help` , `-help` , `-h` or `-?` , the help message is printed out, using `$argv[0]` to dynamically print the script name as typed on the command line. Otherwise, the argument is echoed out exactly as received.

      - To run the above script on Unix, it must be made executable, and called simply as `script.php echothis` or `script.php -h`. On Windows, a batch file similar to the following can be created for this task:

    Example #3 Batch file to run a command line PHP script (`script.bat`)

        @echo OFF
        "C:\php\php.exe" script.php %*

      - Assuming the above program is named `script.php`, and the CLI `php.exe` is in `C:\php\php.exe`, this batch file will run it, passing on all appended options: `script.bat echothis` or `script.bat -h`.

        See also the Readline extension documentation for more functions which can be used to enhance command line applications in PHP.

      - On Windows, PHP can be configured to run without the need to supply the `C:\php\php.exe` or the `.php` extension, as described in [Command Line PHP on Microsoft Windows](https://www.php.net/manual/en/install.windows.legacy.index.php#install.windows.legacy.commandline). #ril

## 安裝設置 {: #setup }

### Docker

  - [How to use this image - php \- Docker Hub](https://hub.docker.com/_/php) #ril

      - Create a `Dockerfile` in your PHP project

            FROM php:7.2-cli
            COPY . /usr/src/myapp
            WORKDIR /usr/src/myapp
            CMD [ "php", "./your-script.php" ]

        Then, run the commands to build and run the Docker image:

            $ docker build -t my-php-app .
            $ docker run -it --rm --name my-running-app my-php-app

      - Run a single PHP script

        For many simple, single file projects, you may find it inconvenient to write a complete `Dockerfile`. In such cases, you can run a PHP script by using the PHP Docker image directly:

            $ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp php:7.2-cli php

        從 [`php:7.2-cli` 的 `Dockerfile`](https://github.com/docker-library/php/blob/3a546766fdeb873090c7e87c4ec3491841bafb1c/7.2/buster/cli/Dockerfile) 可以看到 `ENTRYPOINT ["docker-php-entrypoint"]` 與 `CMD ["php", "-a"]`，因此 `docker run --rm -it php:7.2-cli` 就會進 interactive shell。

  - [Image Variants - php \- Docker Hub](https://hub.docker.com/_/php) #ril

      - The `php` images come in many flavors, each designed for a specific use case.

        Some of these tags may have names like buster or stretch in them. These are the suite code names for releases of Debian and indicate which release the image is based on. If your image needs to install any additional packages beyond what comes with the image, you'll likely want to specify one of these explicitly to MINIMIZE BREAKAGE when there are new releases of Debian.

    `php:<version>-cli`

      - This variant contains the PHP CLI tool with DEFAULT MODS. If you need a web server, this is probably not the image you are looking for. It is designed to be used both as a throw away container (mount your source code and start the container to start your app), as well as a base from which to build other images.

      - It also is the only variant which contains the (not recommended) `php-cgi` binary, which is likely necessary for some things like [PPM](https://github.com/php-pm/php-pm). #ril

      - Note that all variants of php contain the PHP CLI (`/usr/local/bin/php`).

  - [PHPDocker\.io \- PHP and Docker development environment generator](https://phpdocker.io/) #ril

## 參考資料 {: #reference }

  - [PHP: Hypertext Preprocessor](https://www.php.net/) (The PHP Group)

更多：

  - [Programming](php-programming.md)
  - [Logging](php-logging.md)

相關：

  - [Composer](composer.md) - PHP 的 dependency manager。
  - [PHP CS Fixer](php-cs-fixer.md) - 檢查 PHP coding style 的工具

手冊：

  - [`php` Command Line Options](https://www.php.net/manual/en/features.commandline.options.php)
  - [`php.ini` Directives](https://www.php.net/manual/en/ini.list.php)
