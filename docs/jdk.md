# JDK (Java Development Kit)

## Class Path

  - [Setting the Class Path](https://docs.oracle.com/javase/8/docs/technotes/tools/unix/classpath.html) #ril

    Synopsis

      - The CLASS SEARCH PATH (CLASS PATH) can be set using either the `-classpath` option when calling a JDK tool (the preferred method) or by setting the `CLASSPATH` environment variable.

        The `-classpath` option is PREFERRED because you can set it individually for each application WITHOUT AFFECTING other applications and without other applications modifying its value.

            sdkTool -classpath classpath1:classpath2...

            setenv CLASSPATH classpath1:classpath2...

      - `sdkTool`

        A command-line tool, such as `java`, `javac`, `javadoc`, or `apt`. For a listing, see JDK Tools and Utilities at http://docs.oracle.com/javase/8/docs/technotes/tools/index.html

        原來 JDK 所有工具都支援 class path 的設定!

      - `classpath1:classpath2`

        Class paths to the JAR, zip or class files. Each class path should end with a file name or directory depending on what you are setting the class path to, as follows:

          - For a JAR or zip file that contains class files, the class path ends with the name of the zip or JAR file.
          - For class files in an UNNAMED PACKAGE, the class path ends with the directory that contains the class files.

          - For class files in a NAMED PACKAGE, the class path ends with the directory that contains the ROOT PACKAGE, which is the first package in the full package name.

            這裡 named & unnamed package 的 directory，差別在於前者只會有子資料夾 (對應 root package)，後者只含 class file，不會有子資料夾。

        Multiple path entries are separated by semicolons with no spaces around the equals sign (`=`) in Windows and colons in Oracle Solaris. 等號會用在哪裡??

      - The default class path is the CURRENT DIRECTORY. Setting the `CLASSPATH` variable or using the `-classpath` command-line option OVERRIDES that default, so if you want to include the current directory in the search path, then you must include a dot (`.`) in the new settings.

        Class path entries that are neither directories nor archives (`.zip` or JAR files) nor the asterisk (`*`) wildcard character are ignored.

## 參考資料 {: #reference }

手冊：

  - [JDK Development Tools](https://docs.oracle.com/javase/8/docs/technotes/tools/) #ril
