# Anaconda

  - [Home \- Anaconda](https://www.anaconda.com/)

    The Enterprise Data Science Platform for…

      - Data Scientists -- Connect to a range of sources, collaborate with other users, and deploy projects ?? with the single click of a button

      - IT Professionals -- Safely scale and deploy from individual laptops to collaborative teams, from a single server to thousands of nodes

        指 Anaconda Enterprise

      - Business Leaders -- Harness the power of DATA SCIENCE, MACHINE LEARNING, and AI at the pace demanded by today’s digital interactions

        通吃當今最火紅的 data science、ML 跟 AI。

    Anaconda Offerings

      - Anaconda Distribution -- The World’s Most Popular Python Data Science Distribution
      - Anaconda Enterprise -- The AI Enablement Platform for Teams at Scale
      - Training -- Anaconda Data Science Education
      - Professional Services -- Tailored Data Science Solutions from the Anaconda Experts

  - [Why Anaconda \- Anaconda](https://www.anaconda.com/why-anaconda/) #ril

  - [Anaconda (Python distribution) \- Wikipedia](https://en.wikipedia.org/wiki/Anaconda_(Python_distribution)) #ril

      - Anaconda is a free and open-source DISTRIBUTION of the Python and R programming languages for SCIENTIFIC COMPUTING (data science, machine learning applications, large-scale data processing, predictive analytics, etc.), that aims to simplify package management and deployment.

      - Package versions are managed by the package management system conda.

        若 Conda 只是個 package manager，為什麼 Anaconda 的 logo 要跟 Conda 長得一樣??

      - The Anaconda distribution is used by over 13 million users and includes more than 1400 popular data-science packages suitable for Windows, Linux, and MacOS.

        哪來這麼這麼多使用者?

    Overview

      - Anaconda distribution comes with more than 1,400 packages as well as the Conda package and VIRTUAL ENVIRONMENT MANAGER, called Anaconda Navigator, so it eliminates the need to learn to install each library independently.

        注意 Conda 不只是 package manager，也是個 environment manager，所以可以管理多個獨立的環境。

      - The open source packages can be individually installed from the Anaconda repository with the `conda install` command or using the `pip install` command that is installed with Anaconda. Pip packages provide many of the features of conda packages and in most cases they can WORK TOGETHER.

        在 Anaconda 裡，Conda 跟 Pip 的關係是什麼? 為什麼 `conda build` 出來的東西也可以送到 PyPI ??

      - Custom packages can be made using the `conda build` command, and can be shared with others by uploading them to Anaconda Cloud, PyPI or other repositories.

      - The default installation of Anaconda2 includes Python 2.7 and Anaconda3 includes Python 3.7. However, you can CREATE NEW ENVIRONMENTS that include any version of Python packaged with conda.

        看似 Anaconda 透過 Conda 安裝了 Python 及 Pip，選擇 Anaconda2 或 Anaconda3 的差別只在於安裝程式用 Conda 裝了 Python 2/3 而已 ??

## 安裝設置 {: #setup }

  - [Anaconda Python/R Distribution \- Anaconda](https://www.anaconda.com/distribution/) #ril

  - Anaconda3 安裝程式 (macOS)，Read Me 內容：

      - Anaconda is the most popular Python data science platform.  See https://www.anaconda.com/downloads/.

      - By default, this installer modifies your BASH PROFILE to activate the BASE ENVIRONMENT of Anaconda3 when your shell starts up. 在 Anaconda Navigator 

        To disable this, choose "Customize" at the "Installation Type" phase, and disable the "Modify PATH" option. If you decline this option, the executables installed by this installer will not be available on `PATH`. You will need to use the full executable path to run commands, or otherwise initialize the base environment of Anaconda3 on your own.

        畫面上關於 Modify PATH 的說明：Whether to modify the bash profile file to append Anaconda3 to the `PATH` variable. If you do not do this, you will need to add `~/anaconda3/bin` to your PATH manually to run the commands, or run all Anaconda3 commands explicitly from that path.

        但觀察 bash profile 在安裝 Anaconda3 2019.03 後的變化不只如此：

            # added by Anaconda3 2019.03 installer
            # >>> conda init >>>
            # !! Contents within this block are managed by 'conda init' !!
            __conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
            if [ $? -eq 0 ]; then
                \eval "$__conda_setup"
            else
                if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
                    . "/anaconda3/etc/profile.d/conda.sh"
                    CONDA_CHANGEPS1=false conda activate base <-- 啟用 base 環境
                else
                    \export PATH="/anaconda3/bin:$PATH"
                fi
            fi
            unset __conda_setup
            # <<< conda init <<<

      - To install to a different location, select "Change Install Location..." at the "Installation Type" phase, then choose "Install on a specific disk...", choose the disk you wish to install on, and click "Choose Folder...".

        The "Install for me only" option will install Anaconda3 to the default location, `~/anaconda3`.

      - The packages included in this installation are:

          - alabaster 0.7.12
          - anaconda 2019.03
          - anaconda-client 1.7.2
          - anaconda-navigator 1.9.7 <-- 在 Launchpad 可以找到
          - anaconda-project 0.8.2
          - ...
          - conda 4.6.11
          - conda-build 3.17.8
          - conda-env 2.6.0
          - conda-verify 3.1.1
          - contextlib2 0.5.5
          - ...
          - jupyter 1.0.0
          - jupyter_client 5.2.4
          - jupyter_console 6.0.0
          - jupyter_core 4.4.0
          - jupyterlab 0.35.4
          - jupyterlab_server 0.2.0
          - ...

        Tensorflow、Keras、OpenCV 等都要事後再安裝，但為何找不到 PyTorch ??

### Docker ??

  - [ContinuumIO/docker\-images: Repository of Docker images created by Continuum Analytics](https://github.com/ContinuumIO/docker-images) #ril

## 參考資料 {: #reference }

  - [Anaconda](https://www.anaconda.com/)
  - [Anaconda, Inc. (formerly Continuum Analytics, Inc.) - GitHub](https://github.com/ContinuumIO)

社群：

  - ['anaconda' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/anaconda)
  - [Anaconda (@anacondainc) | Twitter](https://twitter.com/anacondainc)

文件：

  - [Anaconda Documentation](https://docs.anaconda.com/)

相關：

  - 
  - Anaconda 用 [Conda](conda.md) 來管理套件跟環境
