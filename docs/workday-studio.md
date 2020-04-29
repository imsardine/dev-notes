---
title: Workday / Studio
---
# [Workday](workday.md) / Studio

  - [Workday Studio \| Workday Community](https://community.workday.com/studio)

      - As part of our Integration Cloud Platform ??, Workday offers a set of easy-to-use integration tools designed to solve many of the common integration use cases faced today.

        Workday Studio is a powerful development tool enabling customers and partners to build SOPHISTICATED integrations to and from Workday. These integrations are deployed and run on your behalf on integration servers in WORKDAY’S DATA CENTER.

        ![](https://community.workday.com/sites/default/files/image/studio/integration-cloud-platform.png)

        這張圖看不太懂??

      - Aimed at SKILLED DEVELOPERS and offered as a set of plug-ins to the Eclipse IDE, Workday Studio offers a rich, graphical development environment in which a user can drag and drop a variety of reusable components that handle the “PLUMBING” aspects of integration building, freeing you to focus on the critical BUSINESS LOGIC.

        Workday has been using this valuable tool for years to deliver all of our PACKAGED INTEGRATIONS and connectors as well as the EIB.

        意指 connector, EIB 等也都是用 Workday Studio 開發出來的??

      - Use Workday Studio to unlock the power of Workday’s INTEGRATION INFRASTRUCTURE:

          - Run your Workday Studio integrations like any other Workday integration - configure, launch, schedule, monitor, and even audit your integrations.
          - Use powerful and productive development tools optimized for interacting with your Workday tenant.
          - Build sophisticated and HIGHLY CUSTOMIZABLE integrations without the need to own or manage any on-premise integration middleware or servers.

  - [Workday Studio Tips and Tricks Guide \| Workday Community](https://community.workday.com/articles/109698) #ril

## 新手上路 {: #getting-started }

  - [Getting Started \| Workday Community](https://community.workday.com/studio-start) #ril

## 安裝設置 {: #setup }

  - [Download and Install Workday Studio \| Workday Community](https://community.workday.com/studio-download)

      - You can download and install Workday Studio in 4 steps. Please note that Workday Studio is a set of plug-ins for Eclipse, an open source, integrated development environment (IDE), and a development tool intended for use by technical users and integration developers.

        意指可以在原有 Eclipse 下安裝必要的 plug-in，就可以從事 Workday 的開發工作。

    Step 1: Download Java Development Kit (JDK)

      - Install the Java™ Standard Edition Development Kit (JDK) for Java 8. You can download this from Oracle or you can choose the free open-source implementation, OpenJDK .

          - Oracle: Requires a commercial license. Download the Oracle JDK installer for your operating system here (select update 1.8.0_151 or higher).
          - OpenJDK: Does not require a commercial license. OpenJDK is available from many sources (including the Zulu OpenJDK installer located here). You must select an OpenJDK version that's compatible with Java 8.

    Step 2: Edit the Java Security File

      - If you're using version jdk-8u161 or later, skip this step and go directly to Step 3. If you are using versions jdk-8u151 or jdk-8u152, you must:

          - Locate the `java.security` file in the `jre/lib/security` directory of your java installation. Ensure you have permission to edit the file. You may need to contact your system administrator.
          - Open the `java.security` file in a text editor. Find the line `#crypto.policy=unlimited` and remove the comment symbol (`#`) .
          - Save the file.

    Step 3: Download Workday Studio

      - Ensure you download the correct file for your operating system. Select the installation file for your platform from the Download column.

        除 Windows 是 Self-Extracting Installation File，Linux 跟 macOS 都是 Executable Jar File；這檔案其實是 installer，不是直接拿來用的。

    Step 4: Install Workday Studio

      - To install Workday Studio, double-click the workday-studio INSTALLATION FILE to launch the installation. Click Next to continue.

          - Note: The Workday Studio installer ALSO SUPPORTS spaces in the installation path.

            On Windows, if you intend to install Workday Studio within the `C:\Program Files` folder, you must run the Workday Studio executable (`workday-studio-x86_64.exe` or `workday-studio-x86.exe`) as an administrator. To do so, right-click the `.exe` file, then select Run as Administrator. After you install Studio to `C:\Program Files`, to launch Studio, right-click the `C:\Program Files\WD\studio\eclipse.exe` file, then select Run as Administrator.

          - Note: Ensure the Studio end-user has WRITE ACCESS to the directory in which Studio is installed. If the user does not have write access to the installation directory, future application updates will fail.

            安裝在 `C:\Program Files` 且資料也寫在同一個目錄，難怪需要 admin 權限。

      - Read the license agreement, then select the check box to accept the terms of the license agreement. Click Next.

      - Browse to the location of your JDK installation. Click Next.

        要 JDK 才行，JRE 不夠；通常就是 `$JAVA_HOME` 的位置。

      - If the JVM details are correct, click Confirm; otherwise, click Back to edit the location and version of the JDK settings.

      - Enter a path or browse to the directory where you wish to install Studio. Click Next.

        macOS 下會預設裝在 `/Applications/WorkdayStudio/`，由於最後會安裝在 `/Applications/WorkdayStudio/Eclipse.app`，所以在 Launcher 裡用 Eclipse 才找得到，用 Workday 反而會找不到；實驗確認，直接更名為 `Workday Studio.app` 是沒有問題的。

      - Customize the Start menu folder as required, or leave the default. Click Install. The installer copies the Studio files to the destination folder.
      - When the Installation Complete message is displayed, click Next.
      - Click Finish to complete the installation.

## 參考資料 {: #reference }

  - [Workday Studio](https://community.workday.com/studio)

文件：

  - [Knowledge Base](https://community.workday.com/studio-kb)

相關：

  - [Integration](workday-intsys.md)
