# VS Code (Visual Studio Code)

  - [Visual Studio Code \- Code Editing\. Redefined](https://code.visualstudio.com/) #ril

      - Code editing. Redefined. Free. Open source. Runs everywhere.

## 新手上路 {: #getting-started }

  - [Getting Started - Documentation for Visual Studio Code](https://code.visualstudio.com/docs) #ril
  - [Next steps - Setting up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview#_next-steps) #ril

## 安裝設定 {: #installation }

  - [Setting up Visual Studio Code](https://code.visualstudio.com/docs/setup/setup-overview)

      - Getting up and running with Visual Studio Code is quick and easy. It is a SMALL DOWNLOAD so you can install in a matter of minutes and give VS Code a try.

        下面 Common questions 的 How big is VS Code? 回答到：VS Code is a small download (< 100 MB) and has a disk footprint of less than 200 MB, so you can quickly install VS Code and try it out.

      - VS Code is a free code editor which runs on the macOS, Linux and Windows operating systems.
      - VS Code is lightweight and should run on most available hardware and platform versions. You can review the System Requirements to check if your computer configuration is supported.

      - VS Code releases a new version EACH MONTH with new features and important bug fixes. Most platforms support auto updating and you will be prompted to install the new release when it becomes available. You can also manually check for updates by running Help > Check for Updates.

        Note: You can disable auto-update if you prefer to update VS Code on your own schedule.

    Additional components

      - VS Code is an editor, first and foremost, and prides itself on a SMALL FOOTPRINT. Unlike traditional IDEs which tend to include everything but the kitchen sink, you can tune your installation to the development technologies you care about. Be sure to read the Additional Components topic after reading the platform guides to learn about customizing your VS Code installation.

      - 這呼應了下面 Common questions 裡 How do I create and run a new project? 的回答

        VS Code DOESN'T include a traditional File > New Project dialog or pre-installed PROJECT TEMPLATES. You'll need to add additional components and scaffolders depending on your development interests.

        With scaffolding tools like Yeoman and the multitude of modules available through the npm package manager, you're sure to find appropriate templates and tools to create your projects.

        Marketplace 裡[有幾個 extension 整合了 Yoeman](https://marketplace.visualstudio.com/search?term=yeoman&target=VSCode)。

    Extensions

      - VS Code extensions let third parties add support for additional:

          - Languages - C++, C#, Go, Java, Python
          - Tools - ESLint, JSHint , PowerShell
          - Debuggers - Chrome, PHP XDebug.
          - Keymaps - Vim, Sublime Text, IntelliJ, Emacs, Atom, Visual Studio, Eclipse

      - Extensions integrate into VS Code's UI, commands, and task running systems so you'll find it easy to work with different technologies through VS Code's shared interface. Check out the VS Code extension Marketplace to see what's available.

### macOS

  - [Running Visual Studio Code on macOS](https://code.visualstudio.com/docs/setup/mac)

      - Drag Visual Studio Code.app to the Applications folder, making it available in the Launchpad.

    Launching from the command line

      - Launch VS Code. Open the View > Command Palette and type 'shell command' to find the Shell Command: Install 'code' command in PATH command.

        Restart the terminal for the new `$PATH` value to take effect. You'll be able to type `code .` in any folder to start editing files in that folder.

        在 VS Code 1.33.1 下試了，發現 `~/.bash_profile` 並沒有變動，而是多了 `/usr/local/bin/code`：

            $ ls -l /usr/local/bin/code
            lrwxr-xr-x  1 jeremykao  admin  68 May  1 11:42 /usr/local/bin/code -> /Applications/Visual Studio Code.app/Contents/Resources/app/bin/code

      - To manually add VS Code to your path, you can run the following commands:

            cat << EOF >> ~/.bash_profile
            # Add Visual Studio Code (code)
            export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
            EOF

    Mojave privacy protections

      - After upgrading to macOS Mojave version, you may see dialogs saying "Visual Studio Code would like to access your {calendar/contacts/photos}." This is due to the new privacy protections in Mojave and is not specific to VS Code. The same dialogs may be displayed when running other applications as well.

        The dialog is shown once for each type of personal data and it is fine to choose Don't Allow since VS Code does not need access to those folders.

        怪怪，Mojave 為什麼要問這些，還以為是 VS Code 要求的。

## 參考資料 {: #reference }

  - [Visual Studio Code](https://code.visualstudio.com/)
  - [Visual Studio Marketplace](https://marketplace.visualstudio.com/vscode)

