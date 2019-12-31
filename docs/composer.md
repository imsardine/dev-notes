# Composer

  - [Introduction \- Composer](https://getcomposer.org/doc/00-intro.md)

      - Composer is a tool for dependency management in PHP. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.

    Dependency management

      - Composer is NOT a package manager in the same sense as Yum or Apt are. Yes, it deals with "packages" or libraries, but it manages them on a PER-PROJECT BASIS, installing them in a directory (e.g. `vendor`) inside your project. By default it does not install anything globally. Thus, it is a DEPENDENCY MANAGER.

        It does however support a "global" project for convenience via the `global` command.

      - This idea is not new and Composer is strongly inspired by node's npm and ruby's bundler.

        Suppose:

          - You have a project that depends on a number of libraries.
          - Some of those libraries depend on other libraries.

        Composer:

          - Enables you to declare the libraries you depend on.
          - Finds out which versions of which packages can and need to be installed, and installs them (meaning it downloads them into your project).
          - See the Basic usage chapter for more details on declaring dependencies.

    System Requirements

      - Composer requires PHP 5.3.2+ to run. A few sensitive php settings and COMPILE FLAGS are also required, but when using the installer you will be warned about any incompatibilities.
      - To install packages from sources instead of simple ZIP ARCHIVES, you will need git, svn, fossil or hg depending on how the package is version-controlled.
      - Composer is multi-platform and we strive to make it run equally well on Windows, Linux and macOS.

## 新手上路 {: #getting-started }

  - [Basic usage \- Composer](https://getcomposer.org/doc/01-basic-usage.md) #ril

      - For our basic usage introduction, we will be installing `monolog/monolog`, a logging library. If you have not yet installed Composer, refer to the Intro chapter.

        PHP 沒有內建 logging 嗎 ??

        Note: for the sake of simplicity, this introduction will assume you have performed a local install of Composer.

## 安裝設置 {: #setup }

```
$ php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
$ php composer-setup.php --install-dir=/usr/local/bin --filename=composer
```

---

參考資料：

  - [Installation - Linux / Unix / macOS - Introduction \- Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos)

      - Composer offers a convenient installer that you can execute directly from the command line. Feel free to download this file or review it on GitHub if you wish to know more about the inner workings of the installer. The source is plain PHP.

        [`installer`](https://github.com/composer/getcomposer.org/blob/master/web/installer) 是個 PHP script。

        There are in short, two ways to install Composer. Locally as part of your project, or globally as a system wide executable.

    Locally

      - To install Composer locally, run the installer in your project directory. See the Download page for instructions.

            php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
            php composer-setup.php
            php -r "unlink('composer-setup.php');"

        完全不用 shell command 來做事，大概是基於跨平台的考量。

            $ php composer-setup.php
            All settings correct for using Composer
            Downloading...

            Composer (version 1.9.0) successfully installed to: //composer.phar
            Use it: php composer.phar

        The installer will check a few PHP settings and then download `composer.phar` to your working directory. This file is the Composer BINARY. It is a PHAR (PHP archive), which is an archive format for PHP which CAN BE RUN ON THE COMMAND LINE, amongst other things.

        Now run `php composer.phar` in order to run Composer.

      - You can install Composer to a specific directory by using the `--install-dir` option and additionally (re)name it as well using the `--filename` option. When running the installer when following the Download page instructions add the following parameters:

            php composer-setup.php --install-dir=bin --filename=composer

        注意是 `php composer-setup.php` 而非 `php composer.phar`!!

            # php composer-setup.php --install-dir=/usr/local/bin --filename=composer
            All settings correct for using Composer
            Downloading...

            Composer (version 1.9.0) successfully installed to: /usr/local/bin/composer
            Use it: php /usr/local/bin/composer

            # composer --version
            Do not run Composer as root/super user! See https://getcomposer.org/root for details
            Composer version 1.9.0 2019-08-02 20:55:32

        "Do not run Composer as root/super user!" 這點還滿煩的，就算在 Docker 裡也是一直出現這樣的警告，建立另一個身份??

        Now run `php bin/composer` in order to run Composer.

    Globally

      - You can place the Composer PHAR anywhere you wish. If you put it in a directory that is part of your `PATH`, you can access it globally. On Unix systems you can even make it executable and invoke it without directly using the `php` interpreter.

      - After running the installer following the Download page instructions you can run this to move `composer.phar` to a directory that is in your path:

            mv composer.phar /usr/local/bin/composer

        放 `/usr/local/bin` 可以，但執行時不要用 root 的身份即可。

        If you like to install it only for your user and avoid requiring root permissions, you can use `~/.local/bin` instead which is available by default on some Linux distributions.

      - Note: If the above fails due to permissions, you may need to run it again with `sudo`.

        Note: On some versions of macOS the `/usr` directory does not exist by default. If you receive the error `"/usr/local/bin/composer: No such file or directory"` then you must create the directory manually before proceeding: `mkdir -p /usr/local/bin`.

        Note: For information on changing your `PATH`, please read the Wikipedia article and/or use Google.

        Now run `composer` in order to run Composer instead of `php composer.phar`.

  - [How do I install untrusted packages safely? Is it safe to run Composer as superuser or root? \- Composer](https://getcomposer.org/doc/faqs/how-to-install-untrusted-packages-safely.md)

      - Certain Composer commands, including `exec`, `install`, and `update` allow third party code to execute on your system. This is from its "plugins" and "scripts" features. Plugins and scripts have full access to the user account which runs Composer. For this reason, it is strongly advised to avoid running Composer as super-user/root.

        這麼說來，像 Python 把 Pip 裝到系統也有累似的問題?

      - You can disable plugins and scripts during package installation or updates with the following syntax so only Composer's code, and no third party code, will execute:

            composer install --no-plugins --no-scripts ...
            composer update --no-plugins --no-scripts ...

        每次都要加 `--no-plugins --no-scripts` 有點麻煩? 若擔心 plugin/script 有問題，就算是用一般的身份執行也不太好吧?

        The `exec` command will ALWAYS run third party code as the user which runs composer.

      - In some cases, like in CI systems or such where you want to install UNTRUSTED DEPENDENCIES, the safest way to do it is to run the above command.

  - [Composer](https://getcomposer.org/download/) #ril

### Docker

  - [composer \- Docker Hub](https://hub.docker.com/_/composer) #ril

    PHP version & extensions

      - Our image is aimed at quickly running Composer without the need for having a PHP runtime installed on your host. You SHOULD NOT rely on the PHP version in our container. We do not provide a Composer image for each supported PHP version because we do not want to encourage using Composer as a base image or a production image.

      - We try to deliver an image that is as lean as possible, built for running Composer ONLY. Sometimes dependencies or Composer scripts require the availability of certain PHP extensions.

        Suggestions:

          - (optimal) create your own build image and install Composer inside it.

            Note: Docker 17.05 introduced multi-stage builds, simplifying this enormously:

                COPY --from=composer /usr/bin/composer /usr/bin/composer

            這想法不錯；雖然 `composer` 只是個 PHAR，不用擔心 link 的問題，不過 PHP 環境要保持一致，畢竟 installer 一開始會檢查一些 PHP 設定。

          - (alternatively) specify the target platform / extension(s) in your `composer.json`:

                {
                 "config": {
                   "platform": {
                     "php": "MAJOR.MINOR.PATCH",
                     "ext-something": "1"
                   }
                 }
                }

            這好像不能解決問題? 不過 `composer install` 時 (不加 `--ignore-platform-reqs`) 就會擋下來。

          - (discouraged) pass the `--ignore-platform-reqs` and / or `--no-scripts` flags to install or update:

                $ docker run --rm --interactive --tty \
                 --volume $PWD:/app \
                 composer install --ignore-platform-reqs --no-scripts

## 參考資料 {: #reference }

  - [Composer](https://getcomposer.org/)
  - [composer/composer - GitHub](https://github.com/composer/composer)
  - [Packagist - The PHP Package Repository](https://packagist.org/)

文件：

  - [Composer Documentation](https://getcomposer.org/doc/)

手冊：

  - [Command-line Interface](https://getcomposer.org/doc/03-cli.md)
