# Maven

  - [Maven – Welcome to Apache Maven](https://maven.apache.org/)

    Apache Maven is a software PROJECT MANAGEMENT and COMPREHENSION tool. Based on the concept of a PROJECT OBJECT MODEL (POM), Maven can manage a project's build, reporting and documentation from a central piece of information.

  - [Maven – Introduction](https://maven.apache.org/what-is-maven.html) #ril

  - [Maven – Maven Features](https://maven.apache.org/maven-features.html) #ril

## 新手上路 {: #getting-started }

  - [Maven – Maven in 5 Minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html) #ril

    Creating a Project

      - You will need somewhere for your project to reside, create a directory somewhere and start a shell in that directory. On your command line, execute the following Maven GOAL:

            mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false

      - If you have just installed Maven, it may take a while on the first run. This is because Maven is downloading the most recent ARTIFACTS (PLUGIN jars and other files) into your LOCAL REPOSITORY.

        You may also need to execute the command a couple of times before it succeeds. This is because the remote server may time out before your downloads are complete. Don't worry, there are ways to fix that.

      - You will notice that the `generate` goal created a directory with the same name given as the `artifactId`. Change into that directory.

            cd my-app

        Under this directory you will notice the following standard project structure.

            my-app
            |-- pom.xml
            `-- src
                |-- main
                |   `-- java
                |       `-- com
                |           `-- mycompany
                |               `-- app
                |                   `-- App.java
                `-- test
                    `-- java
                        `-- com
                            `-- mycompany
                                `-- app
                                    `-- AppTest.java

        The `src/main/java` directory contains the project source code, the `src/test/java` directory contains the test source, and the `pom.xml` file is the project's Project Object Model, or POM.

    The POM

      - The `pom.xml` file is the core of a project's configuration in Maven. It is a SINGLE CONFIGURATION FILE that contains the majority of information required to build a project in just the way you want. The POM is huge and can be daunting in its complexity, but it is not necessary to understand all of the intricacies just yet to use it effectively. This project's POM is:

            <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
              <modelVersion>4.0.0</modelVersion>

              <groupId>com.mycompany.app</groupId>
              <artifactId>my-app</artifactId>
              <version>1.0-SNAPSHOT</version>

              <properties>
                <maven.compiler.source>1.7</maven.compiler.source>
                <maven.compiler.target>1.7</maven.compiler.target>
              </properties>

              <dependencies>
                <dependency>
                  <groupId>junit</groupId>
                  <artifactId>junit</artifactId>
                  <version>4.12</version>
                  <scope>test</scope>
                </dependency>
              </dependencies>
            </project>

    What did I just do?

      - You executed the Maven goal `archetype:generate`, and passed in various parameters to that goal. The prefix `archetype` is the plugin that provides the goal. If you are familiar with Ant, you may conceive of this as similar to a task.

        This `archetype:generate` goal created a simple project based upon a `maven-archetype-quickstart` archetype. Suffice it to say for now that a plugin is a COLLECTION OF GOALS WITH A GENERAL COMMON PURPOSE. For example the `jboss-maven-plugin`, whose purpose is "deal with various jboss items".

    Build the Project

      - `mvn package`

        The command line will print out various actions, and end with the following:

             ...
            [INFO] ------------------------------------------------------------------------
            [INFO] BUILD SUCCESS
            [INFO] ------------------------------------------------------------------------
            [INFO] Total time:  2.953 s
            [INFO] Finished at: 2019-11-24T13:05:10+01:00
            [INFO] ------------------------------------------------------------------------

      - Unlike the first command executed (`archetype:generate`) you may notice the second is simply a single word - `package`. Rather than a goal, this is a PHASE. A phase is a step in the BUILD LIFECYCLE, which is an ORDERED SEQUENCE OF PHASES. When a phase is given, Maven will execute every phase in the sequence up to and including the one defined. For example, if we execute the `compile` phase, the phases that actually get executed are:

          - `validate`
          - `generate-sources`
          - `process-sources`
          - `generate-resources`
          - `process-resources`
          - `compile`

        按照 [Maven – Running Apache Maven](https://maven.apache.org/run.html) 的說法，`validate` 跟 `generate-sources` 間還有個 `initialize`。

      - You may test the newly compiled and packaged JAR with the following command:

            java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App

        Which will print the quintessential:

            Hello World!

## `mvn` CLI { #mvn-cli }

  - [Maven – Running Apache Maven](https://maven.apache.org/run.html)

      - The syntax for running Maven is as follows:

            mvn [options] [<goal(s)>] [<phase(s)>]

        All available options are documented in the built in help that you can access with

            mvn -h

      - The typical invocation for building a Maven project uses a Maven LIFE CYCLE PHASE. E.g.

            mvn package

        The built in LIFE CYCLES and their PHASES are IN ORDER are:

          - clean - pre-clean, clean, post-clean

          - default - validate, initialize, generate-sources, process-sources, generate-resources, process-resources, compile, process-classes, generate-test-sources, process-test-sources, generate-test-resources, process-test-resources, test-compile, process-test-classes, test, prepare-package, package, pre-integration-test, integration-test, post-integration-test, verify, install, deploy

          - site - pre-site, site, post-site, site-deploy

        Life cycle 跟 phase 是什麼關係 ??

      - A fresh build of a project generating all packaged outputs and the documentation site and deploying it to a repository manager could be done with

            mvn clean deploy site-deploy

        Just creating the package and installing it in the LOCAL REPOSITORY for re-use from other projects can be done with

            mvn verify

        This is the most common build invocation for a Maven project.

        從 `mvn clean deploy site-deploy` 的用法看來，life cycle 是獨立的，但若某個 phase 有被提及，同一 life cycle 前面的 phase 都會被走過。因此 `mvn verify` 只會走 `default` life cycle 的 `validate` ~ `verify`，跟 `clean` & `site` life cycle 無關。

        這呼應了 `mvn [options] [<goal(s)>] [<phase(s)>]` 的用法，`mvn` 後面只會接 phase 或 goal，但不會是 life cycle。因此 `mvn clean` 會走過 `clean` life cycle 的 `pre-clean` ~ `clean`，但 `post-clean` 就永遠走不到，是不是哪裡怪怪的 ??

      - When NOT WORKING WITH A PROJECT, and in some other use cases, you might want to invoke a specific TASK implemented by a part of Maven - this is called a GOAL of a PLUGIN. E.g.:

            mvn archetype:generate

        or

            mvn checkstyle:check

        There are many different plugins available and they all implement different goals.

## 安裝設置 {: #setup }

  - [Maven – Download Apache Maven](https://maven.apache.org/download.cgi)

    System Requirements

      - Java Development Kit (JDK)

        Maven 3.3+ require JDK 1.7 or above to execute - they still allow you to build against 1.3 and other JDK versions [by Using Toolchains](https://maven.apache.org/guides/mini/guide-using-toolchains.html) #ril

      - Memory

        No minimum requirement

      - Disk

        Approximately 10MB is required for the Maven installation itself. In addition to that, additional disk space will be used for your LOCAL MAVEN REPOSITORY. The size of your local repository will vary depending on usage but expect at least 500MB.

      - Operating System

        No minimum requirement. Start up scripts are included as shell scripts and Windows batch files.

    Files

      - Maven is distributed in several formats for your convenience. Simply pick a ready-made binary distribution archive and follow the installation instructions. Use a source archive if you intend to build Maven yourself.

          - Binary tar.gz archive -- `apache-maven-3.6.3-bin.tar.gz`
          - Binary zip archive -- `apache-maven-3.6.3-bin.zip`

  - [Maven – Installing Apache Maven](https://maven.apache.org/install.html)

      - The installation of Apache Maven is a simple process of extracting the archive and adding the `bin` folder with the `mvn` command to the `PATH`.

      - Confirm with `mvn -v` in a new shell. The result should look similar to

            Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
            Maven home: /opt/apache-maven-3.6.3
            Java version: 1.8.0_45, vendor: Oracle Corporation
            Java home: /Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/jre
            Default locale: en_US, platform encoding: UTF-8
            OS name: "mac os x", version: "10.8.5", arch: "x86_64", family: "mac"

## 參考資料 {: #reference }

  - [Maven](https://maven.apache.org/)
  - [The Central Repository](https://search.maven.org/) ([repo](https://repo.maven.apache.org/maven2/))

更多：

  - [Repository](maven-repo.md)
  - [Archetype](maven-archetype.md)
  - [Plugin](maven-plugin.md)

手冊：

  - [Release Notes](https://maven.apache.org/docs/history.html)
  - [POM Reference](https://maven.apache.org/pom.html)
  - [Lifecycles Reference](http://maven.apache.org/ref/3.6.3/maven-core/lifecycles.html)
