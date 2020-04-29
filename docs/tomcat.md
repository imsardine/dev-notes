# Tomcat

  - [Apache Tomcat® \- Welcome\!](http://tomcat.apache.org/)

      - The Apache Tomcat software is an open source implementation of the Java Servlet, JavaServer Pages, [Java Expression Language](https://jcp.org/en/jsr/detail?id=341) and [Java WebSocket](https://jcp.org/en/jsr/detail?id=356) technologies. #ril

      - Apache Tomcat software powers numerous LARGE-SCALE, mission-critical web applications across a diverse range of industries and organizations. Some of these users and their stories are listed on the [PoweredBy](https://cwiki.apache.org/confluence/display/TOMCAT/PoweredBy) wiki page. #ril

  - [Apache Tomcat® \- Which Version Do I Want?](https://tomcat.apache.org/whichversion.html)

      - Apache Tomcat is an open source software implementation of a SUBSET of the Jakarta EE (formally Java EE) technologies. Different versions of Apache Tomcat are available for different versions of the specifications. The mapping between the specifications and the respective Apache Tomcat versions is:

        不同版本的文件，也分別提供有不同版本 Spec 的 Javadoc API 文件。例如 Tomcat 9 實作 Servlet 4.0，就會有 [Servlet 4.0](https://tomcat.apache.org/tomcat-9.0-doc/) 的 Javadoc。

      - Each version of Tomcat is supported for any stable Java release that meets the requirements of the final column in the table above.

## 新手上路 {: #getting-started }

 1. 啟動 Tomcat

        $CATALINA_BASE/bin/startup.sh

 2. 下載 Sample Application

        $ curl -O https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war

 3. 將 `.war` 複製到 `CATALINA_BASE/webapps`，即可完成佈署：

        $ mv sample.war $CATALINA_BASE/webapps/
        $ curl http://localhost:8080/sample/ 2>/dev/null | grep -i title
        <title>Sample "Hello, World" Application</title>

---

參考資料：

  - [Apache Tomcat 9 \(9\.0\.33\) \- Introduction](https://tomcat.apache.org/tomcat-9.0-doc/introduction.html) #ril

  - [Sample Application](https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/)

      - The example app has been packaged as a war file and can be downloaded [here](https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war) (Note: make sure your browser doesn't change file extension or append a new one).

      - The easiest way to run this application is simply to move the war file to your `CATALINA_BASE/webapps` directory. A default Tomcat install will automatically EXPAND AND DEPLOY the application for you. You can view it with the following URL (assuming that you're running tomcat on port 8080 which is the default):

            http://localhost:8080/sample

        Note: `CATALINA_BASE` is usually the directory in which you unpacked the Tomcat distribution. For more information on `CATALINA_HOME`, `CATALINA_BASE` and the difference between them see `RUNNING.txt` in the directory you unpacked your Tomcat distribution.

        通常 `CATALINA_BASE` 跟 `CATALINA_HOME` 是一樣的，有什麼差別? 為什麼這裡傾向用 `CATALINA_BASE` ??

            $ grep CATALINA_HOME bin/*.sh | grep CATALINA_BASE
            bin/catalina.sh:# Copy CATALINA_BASE from CATALINA_HOME if not already set
            bin/catalina.sh:[ -z "$CATALINA_BASE" ] && CATALINA_BASE="$CATALINA_HOME"
            bin/catalina.sh:# Ensure that neither CATALINA_HOME nor CATALINA_BASE contains a colon
            bin/daemon.sh:test ".$CATALINA_BASE" = . && CATALINA_BASE="$CATALINA_HOME"
            bin/daemon.sh:# If not explicitly set, look for jsvc in CATALINA_BASE first then CATALINA_HOME

      - If you just want to browse the contents, you can unpack the war file with the jar command.

            jar -xvf sample.war

  - [Application Developer's Guide \(9\.0\.33\) \- Table of Contents](https://tomcat.apache.org/tomcat-9.0-doc/appdev/index.html) #ril

## Catalina

  - [An introduction to Tomcat Catalina \| MuleSoft](https://www.mulesoft.com/tcat/tomcat-catalina) #ril

## 安裝設置 {: #setup }

### Unix-like

下載 Core binary distribution 後解壓縮即可：

    $ curl -O http://ftp.mirror.tw/pub/apache/tomcat/tomcat-9/v9.0.33/bin/apache-tomcat-9.0.33.tar.gz
    $ tar xf apache-tomcat-9.0.33.tar.gz

    $ cd apache-tomcat-9.0.33/
    $ ls bin/*.sh
    bin/catalina.sh     bin/daemon.sh       bin/setclasspath.sh bin/tool-wrapper.sh
    bin/ciphers.sh      bin/digest.sh       bin/shutdown.sh     bin/version.sh
    bin/configtest.sh   bin/makebase.sh     bin/startup.sh

多數的 script 都間接呼叫了 `catalina.sh`：

    $ grep catalina.sh bin/*.sh
    bin/catalina.sh:# For supported commands call "catalina.sh help" or see the usage section at
    bin/catalina.sh:  echo "Usage: catalina.sh ( commands ... )"
    bin/configtest.sh:EXECUTABLE=catalina.sh
    bin/makebase.sh:echo "    \$CATALINA_HOME/bin/catalina.sh run"
    bin/shutdown.sh:EXECUTABLE=catalina.sh
    bin/startup.sh:EXECUTABLE=catalina.sh
    bin/version.sh:EXECUTABLE=catalina.sh

啟動 & 停止 Tomcat：

    $ bin/startup.sh
    Using CATALINA_BASE:   /Users/jeremykao/dev/tomcat
    Using CATALINA_HOME:   /Users/jeremykao/dev/tomcat
    Using CATALINA_TMPDIR: /Users/jeremykao/dev/tomcat/temp
    Using JRE_HOME:        /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
    Using CLASSPATH:       /Users/jeremykao/dev/tomcat/bin/bootstrap.jar:/Users/jeremykao/dev/tomcat/bin/tomcat-juli.jar
    Tomcat started.

    $ bin/shutdown.sh
    Using CATALINA_BASE:   /Users/jeremykao/dev/tomcat
    Using CATALINA_HOME:   /Users/jeremykao/dev/tomcat
    Using CATALINA_TMPDIR: /Users/jeremykao/dev/tomcat/temp
    Using JRE_HOME:        /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
    Using CLASSPATH:       /Users/jeremykao/dev/tomcat/bin/bootstrap.jar:/Users/jeremykao/dev/tomcat/bin/tomcat-juli.jar

---

參考資料：

  - [Apache Tomcat® \- Apache Tomcat 9 Software Downloads](https://tomcat.apache.org/download-90.cgi)

    Please see the README file for packaging information. It explains what every distribution contains.

    Binary Distributions 分得很細，包括 Core、Full documentation、Deployer 與 Embedded。

  - [Apache Tomcat 9\.0\.33](http://ftp.mirror.tw/pub/apache/tomcat/tomcat-9/v9.0.33/README.html)

      - Useful references:

          - [Release notes](http://ftp.mirror.tw/pub/apache/tomcat/tomcat-9/v9.0.33/RELEASE-NOTES), with important information about known issues
          - [Changelog](https://tomcat.apache.org/tomcat-9.0-doc/changelog.html) #ril

      - Tomcat 9.0 requires Java 8 or later. Read the RELEASE-NOTES and the RUNNING.txt file in the distribution for more details.

      - Packaging Details (or "What Should I Download?")

        `bin/`

          - `apache-tomcat-[version].zip` or `.tar.gz`

            Base distribution. These distributions do NOT include the WINDOWS service wrapper nor the compiled APR/native library for WINDOWS.

            少了一些 Windows 專用的東西。

          - `apache-tomcat-[version].exe`

            32-bit/64-bit Windows installer for Tomcat. Please note that while this distribution includes the vast majority of the base distribution, some of the command-line scripts for launching Tomcat are not included. This distribution is intended for those users planning to launch Tomcat through the Windows shortcuts or services.

            專為 Windows 桌面環境設計。

          - `apache-tomcat-[version]-windows-x86.zip`

            32-bit Windows specific distribution that includes the Windows service wrapper and the compiled APR/native library for use with 32-bit JVMs on both 32 and 64 bit Windows platforms.

          - `apache-tomcat-[version]-windows-x64.zip`

            64-bit Windows specific distribution that includes the Windows service wrapper and the compiled APR/native library for use with 64-bit JVMs on x64 Windows platforms.

          - `apache-tomcat-[version]-deployer.zip` or `.tar.gz`

            The standalone [Tomcat Web Application Deployer](https://tomcat.apache.org/tomcat-9.0-doc/deployer-howto.html). #ril

          - `apache-tomcat-[version]-fulldocs.tar.gz`

            The Tomcat documentation bundle, including complete javadocs.

            就只有文件，歸在 binary 有點怪。

        `src/`

          - `apache-tomcat-[version].zip` or `.tar.gz`

            The source code. See [building instructions](https://tomcat.apache.org/tomcat-9.0-doc/building.html). #ril

  - [Running With JRE 8 Or Later - Running The Apache Tomcat 9.0 Servlet/JSP Container (`RUNNING.txt`)](https://tomcat.apache.org/tomcat-9.0-doc/RUNNING.txt)

    Apache Tomcat 9.0 requires a Java Standard Edition Runtime Environment (JRE) version 8 or later.

     1. Download and Install a Java SE Runtime Environment (JRE)

     2. Download and Install Apache Tomcat

        Unpack the binary distribution so that it resides in its own directory (conventionally named `apache-tomcat-[version]`).

        For the purposes of the remainder of this document, the name `CATALINA_HOME` is used to refer to the full pathname of that directory.

        [An introduction to Tomcat Catalina \| MuleSoft](https://www.mulesoft.com/tcat/tomcat-catalina):

        > Tomcat is actually composed of a number of components, including a Tomcat JSP engine and a variety of different connectors, but its core component is called Catalina. Catalina provides Tomcat's actual implementation of the servlet specification; when you start up your Tomcat server, you're actually starting Catalina.

     3. Configure Environment Variables #ril

        Tomcat is a Java application and DOES NOT use environment variables DIRECTLY. Environment variables are used by the Tomcat STARTUP SCRIPTS. The scripts use the environment variables to prepare the command that starts Tomcat.

     4. Start Up Tomcat

        Tomcat can be started by executing one of the following commands:

        On Windows:

            %CATALINA_HOME%\bin\startup.bat

        or

            %CATALINA_HOME%\bin\catalina.bat start

        On *nix:

            $CATALINA_HOME/bin/startup.sh

        or

            $CATALINA_HOME/bin/catalina.sh start

        After startup, the default web applications included with Tomcat will be
      available by visiting:

            http://localhost:8080/

     5. Shut Down Tomcat

        Tomcat can be shut down by executing one of the following commands:

        On Windows:

            %CATALINA_HOME%\bin\shutdown.bat

        or

            %CATALINA_HOME%\bin\catalina.bat stop

        On *nix:

            $CATALINA_HOME/bin/shutdown.sh

        or

            $CATALINA_HOME/bin/catalina.sh stop

  - [Unix daemon - Apache Tomcat 9 \(9\.0\.33\) \- Tomcat Setup](https://tomcat.apache.org/tomcat-9.0-doc/setup.html) #ril

      - There are several ways to set up Tomcat for running on different platforms. The MAIN documentation for this is a file called `RUNNING.txt`. We encourage you to refer to that file if the information below does not answer some of your questions.

        `RUNNING.txt` 才是主要的文件 XD

      - Tomcat can be run as a DAEMON using the `jsvc` tool from the commons-daemon project. Source tarballs for jsvc are included with the Tomcat binaries, and NEED TO BE COMPILED. Building jsvc requires a C ANSI compiler (such as GCC), GNU Autoconf, and a JDK. #ril

### Maven

  - [Apache Tomcat® \- Tomcat Maven Plugin](http://tomcat.apache.org/maven-plugin.html) #ril

### Docker

  - [tomcat \- Docker Hub](https://hub.docker.com/_/tomcat) #ril
  - [Using Docker from Maven and Maven from Docker \- Container Hub \- Medium](https://medium.com/containers-101/using-docker-from-maven-and-maven-from-docker-1494238f1cf6) (2018-06-22) #ril

## 參考資料 {: #reference }

  - [Apache Tomcat](http://tomcat.apache.org/)
  - [Apache Tomcat Wiki](https://cwiki.apache.org/confluence/display/TOMCAT)

文件：

  - [Apache Tomcat 9 Documentation](http://tomcat.apache.org/tomcat-9.0-doc/index.html)

手冊：

  - [Apache Tomcat Versions](https://tomcat.apache.org/whichversion.html) -- 不同 Tomcat 版本實作的 Java EE Spec 版本
  - [Apache Tomcat 9 Configuration Reference](https://tomcat.apache.org/tomcat-9.0-doc/config/index.html)
  - [Apache Tomcat 9 API Documentation](https://tomcat.apache.org/tomcat-9.0-doc/api/index.html)
