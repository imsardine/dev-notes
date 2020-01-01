---
title: PHP / Including
---
# [PHP](php.md) / Including

  - [PHP: include \- Manual](https://www.php.net/manual/en/function.include.php) #ril

      - The `include` statement includes and evaluates the specified file.

        The documentation below also applies to `require`.

        `include` 與 `require` 兩者最大的差別在於過程中發生問題時，`include` 只會丟出 warning，但 `require` 會丟出 error。

      - Files are included based on the FILE PATH GIVEN or, if none is given, the `include_path` specified.

        If the file isn't found in the `include_path`, `include` will FINALLY check in the CALLING SCRIPT'S OWN DIRECTORY and the CURRENT WORKING DIRECTORY before failing.

        The `include` construct will emit a WARNING if it cannot find a file; this is different behavior from `require`, which will emit a FATAL ERROR.

        對照下面 "If a path is defined ... `include_path` will be ignored altogether" 的說法，"path is defined" 是指以 `/`、`./` 或 `../` 開頭者。

      - If a path is defined — whether absolute (starting with a drive letter or `\` on Windows, or `/` on Unix/Linux systems) or relative to the current directory (starting with `.` or `..`) — the `include_path` will be IGNORED ALTOGETHER.

        實驗確認，"path is defined` 專指是否以 `/`、`./` 或 `../` 開頭，跟是否含有 path 的成份無關。例如 `include ./file` 符合這裡說的 "path is defined"，但 `include file` 就不符合。

        For example, if a filename begins with `../`, the parser will look in the parent directory to find the requested file.

        實驗發現，走 "path is defined" 時，並不會像走 `include_path` 會 fallback 回 calling script 的位置。若要永遠相對於 calling script，可以利用 `__DIR__` magic constant (或 `dirname(__FILE__)`)，像是 [TCPDF 的用法](https://github.com/tecnickcom/TCPDF/blob/master/tcpdf.php#L111)：

            require_once(dirname(__FILE__).'/tcpdf_autoconfig.php');

      - For more information on how PHP handles including files and the include path, see the documentation for `include_path`.

      - When a file is included, the code it contains INHERITS THE VARIABLE SCOPE of the line on which the include occurs. Any variables available at that line in the calling file will be available within the called file, FROM THAT POINT FORWARD.

        However, all functions and classes defined in the included file have the GLOBAL SCOPE. ??

    Example #1 Basic `include` example

        vars.php
        <?php

        $color = 'green';
        $fruit = 'apple';

        ?>

        test.php
        <?php

        echo "A $color $fruit"; // A

        include 'vars.php';

        echo "A $color $fruit"; // A green apple

        ?>

      - If the include occurs inside a function within the calling file, then all of the code contained in the called file will behave as though it had been defined inside that function. So, it will follow the variable scope of that function. An exception to this rule are magic constants which are EVALUATED BY THE PARSER BEFORE THE INCLUDE OCCURS.

  - [PHP: include\_once \- Manual](https://www.php.net/manual/en/function.include-once.php) #ril
  - [PHP: require \- Manual](https://www.php.net/manual/en/function.require.php) #ril
  - [PHP: require\_once \- Manual](https://www.php.net/manual/en/function.require-once.php) #ril

  - [`include_path` - PHP: Description of core php\.ini directives \- Manual](https://www.php.net/manual/en/ini.core.php#ini.include-path)

      - Specifies a list of directories where the `require`, `include`, `fopen()`, `file()`, `readfile()` and `file_get_contents()` functions look for files. The format is like the system's `PATH` environment variable: a list of directories separated with a colon in Unix or semicolon in Windows.

        因為也會被用在 `fopen()` 等跟 including 無關的操作，難怪 `.` 會出現在 `include_path` 預設值的最前面。

      - PHP considers each entry in the include path separately when looking for files to include. It will check the first path, and if it doesn't find it, check the next path, until it either locates the included file or returns with a warning or an error.

      - You may modify or set your include path AT RUNTIME using `set_include_path()`.

        實務上常這麼做嗎?? 尤其在同一 web server 上有許多 site 會共用 `php.ini`。

      - Example #1 Unix `include_path`

            include_path=".:/php/includes"

        Example #2 Windows `include_path`

            include_path=".;c:\php\includes"

        什麼東西會安裝到 PHP 安裝目錄底下 ??

      - Using a `.` in the include path allows for RELATIVE INCLUDES as it means the current directory. However, it is MORE EFFICIENT to explicitly use `include './file'` than having PHP always check the current directory for every include.

        這裡的 current directory 也是 CWD。不過因為 `include_path` 總是預設以 CWD 開頭，這裡 more efficient 的講法說不過去??

      - Note: `ENV` variables are also accessible in `.ini` files. As such it is possible to reference the home directory using `${LOGIN}` and `${USER}`.

        Environment variables may vary between Server APIs as those environments may be different.

        Example #3 Unix `include_path` using `${USER}` env variable

            include_path = ".:${USER}/pear/php"

## 參考資料 {: #reference }

手冊：

  - [`include`](https://www.php.net/manual/en/function.include.php)
  - [`include_once`](https://www.php.net/manual/en/function.include-once.php)
  - [`require`](https://www.php.net/manual/en/function.require.php)
  - [`require_once`](https://www.php.net/manual/en/function.require-once.php)
  - [`set_include_path()`](https://www.php.net/manual/en/function.set-include-path.php)
