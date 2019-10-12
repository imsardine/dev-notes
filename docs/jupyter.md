# Jupyter

  - 從 IPython 4.0 開始，把語言無關 (language-agnostic) 的部份 - 包括 notebook、qtconsole 等，都抽出到另一個 Jupyter 專案，之後 IPython 將專注在 INTERACTIVE Python，也為 Jupyter 提供 Python kernel -- 眾多支援的 computational kernel 中的一種。
  - 專注在 interactive computing 的發展，但不限定程式語言。

參考資料：

  - [Project Jupyter \| Home](https://jupyter.org/)

      - Project Jupyter exists to develop open-source software, open-standards, and services for INTERACTIVE COMPUTING across dozens of PROGRAMMING LANGUAGES.

        專注在 interactive computing 的發展，但不限定程式語言。

  - [Project Jupyter \| About Us](https://jupyter.org/about)

      - Project Jupyter is a non-profit, open-source project, BORN OUT OF THE IPYTHON PROJECT in 2014 as it evolved to support INTERACTIVE DATA SCIENCE and SCIENTIFIC COMPUTING across all programming languages. Jupyter will always be 100% open-source software, free for all to use and released under the liberal terms of the modified BSD license.

      - [Jupyter and the future of IPython - Jupyter and the future of IPython — IPython](https://ipython.org/#jupyter-and-the-future-of-ipython)

        IPython is a growing project, with increasingly LANGUAGE-AGNOSTIC COMPONENTS. IPython 3.x was the last MONOLITHIC release of IPython, containing the notebook server, qtconsole, etc.

        As of IPython 4.0, the language-agnostic parts of the project: the notebook format, message protocol, qtconsole, notebook web application, etc. have moved to new projects under the name Jupyter. IPython itself is focused on interactive Python, PART of which is providing a PYTHON KERNEL FOR Jupyter.

        跟語言無關的部份抽出到 Jupyter，剛好成就了 Jupyter 橫跨多種語言的特性；IPython 會繼續在 Interactive Python 發展，定位上與 Jupyter 的 Interactive Computing 不同，但 Jupyter 的 Python kernel (對 Python 的支援) 是來自 IPython 沒錯。

  - [Open Standards for Interactive Computing - Project Jupyter \| Home](https://jupyter.org/#architecture)

      - The Jupyter Notebook is based on a set of open standards for interactive computing. Think HTML and CSS for interactive computing on the web. These open standards can be leveraged by third party developers to build customized applications with embedded interactive computing.

    The Notebook Document Format

      - Jupyter Notebooks are an OPEN DOCUMENT FORMAT based on JSON. They contain a complete record of the USER'S SESSIONS and include code, NARRATIVE TEXT, equations and rich output.

        在文件裡混雜這些東西沒什麼，但可以直接執行程式，跟文件搭配後的實用性就很高。

    Interactive Computing Protocol

      - The Notebook communicates with COMPUTATIONAL KERNELS using the Interactive Computing Protocol, an open network protocol based on JSON data over [ZMQ](http://zeromq.org/) (ZeroMQ) and WebSockets.

        Notebook 只是個 presentation，真正的運算發生在不同的 computational kernel，而 notebook 跟 kernel 的溝通就是走 Interactive Computing Protocol。

    Kernels

      - Kernels are processes that run interactive code in a particular programming language and return output to the user. Kernels also respond to TAB COMPLETION and INTROSPECTION requests.

        跟語言相關的部份都在不同的 kernel 裡。

## 新手上路 {: #getting-started }

  - [Try Jupyter — Jupyter Documentation 4\.1\.1 alpha documentation](https://jupyter.readthedocs.io/en/latest/tryjupyter.html) #ril
  - [Running the Notebook — Jupyter Documentation 4\.1\.1 alpha documentation](https://jupyter.readthedocs.io/en/latest/running.html) #ril

## Jupyter Notebook -> JupyterLab ?? {: #notebook }

  - [The Jupyter Notebook - Project Jupyter \| Home](https://jupyter.org/#about-notebook)

      - The Jupyter Notebook is an open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text.

        Uses include: data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more. 但巨量的資料要怎麼拿到? 似乎就得走 JupyterHub 了??

        Language of choice

          - The Notebook has support for over 40 programming languages, including Python, R, Julia, and Scala.

        Share notebooks

          - Notebooks can be SHARED with others using email, Dropbox, GitHub and the Jupyter Notebook Viewer.

            因為 notebook 是採基於 JSON 的 Notebook Document Format，對方只要有 viewer 就可以看，但執行環境若需要某些特殊的套件呢??

            Jupyter Notebook Viewer 的命名會讓人誤以為它的功能就是個 viewer，但忽略了 "線上分享"，因為在本地若要看 notebook 要安裝的是 Jupyter Notebook。

        Interactive output

          - Your code can produce rich, interactive output: HTML, images, videos, LaTeX, and custom MIME types.

        Big data integration

          - Leverage big data tools, such as Apache Spark, from Python, R and Scala. Explore that same data with pandas, [scikit-learn](https://scikit-learn.org/), [ggplot2](https://ggplot2.tidyverse.org/), TensorFlow.

            要如何提供這樣的執行環境??

  - [jupyterlab/jupyterlab: JupyterLab computational environment\.](https://github.com/jupyterlab/jupyterlab) JupyterLab 做為 Project Jupyter 下一代的 UI，達 1.0 版時就會取代 Jupyter Notebook。

## JupyterHub

  - [JupyterHub - Project Jupyter \| Home](https://jupyter.org/#jupyterhub)

      - A MULTI-USER version of the notebook designed for companies, classrooms and research labs

        Google 的 [Colaboratory](https://colab.research.google.com/) 就是 JupyterHub 的實例??

    Pluggable authentication

      - Manage users and authentication with PAM, OAuth or integrate with your own directory service system.

    Centralized deployment

      - Deploy the Jupyter Notebook to thousands of users in your organization on centralized infrastructure on- or off-site.

    Container friendly

      - Use Docker and Kubernetes to scale your deployment, ISOLATE USER PROCESSES, and simplify software installation.

    Code meets data

      - Deploy the Notebook NEXT TO YOUR DATA to provide unified software management and data access within your organization.

  - [jupyterhub/jupyterhub: Multi\-user server for Jupyter notebooks](https://github.com/jupyterhub/jupyterhub) #ril

## 安裝設置 {: #setup }

  - 安裝內含 Jupyter 的 [Anaconda](anaconda.md#installation)，執行 `jupyter notebook` 就可以啟動 Notebook Server。

---

參考資料：

  - [Project Jupyter \| Installing the Jupyter Notebook](https://jupyter.org/install.html)

      - Get up and running with the Jupyter Notebook on your computer within minutes!

    Prerequisite: Python

      - While Jupyter runs code in many programming languages, Python is a requirement (Python 3.3 or greater, or Python 2.7) for installing the Jupyter Notebook itself.

        有趣的關係，Jupyter 要有 Python kernel 以執行 Python code，但同時間自己也是用 Python 寫的。

    Installing Jupyter using Anaconda

      - We strongly recommend installing Python and Jupyter using the Anaconda Distribution, which includes Python, the Jupyter Notebook, and other commonly used packages for SCIENTIFIC COMPUTING and DATA SCIENCE.

      - First, download Anaconda. We recommend downloading Anaconda’s latest Python 3 version.

        Second, install the version of Anaconda which you downloaded, following the instructions on the download page.

        Congratulations, you have installed Jupyter Notebook! To run the notebook, run the following command at the Terminal (Mac/Linux) or Command Prompt (Windows): `jupyter notebook`

        See Running the Notebook for more details.

    Installing Jupyter with pip

      - As an existing or experienced Python user, you may wish to install Jupyter using Python’s package manager, pip, instead of Anaconda.

      - If you have Python 3 installed (which is recommended):

            python3 -m pip install --upgrade pip
            python3 -m pip install jupyter

      - If you have Python 2 installed:

            python -m pip install --upgrade pip
            python -m pip install jupyter

      - Congratulations, you have installed Jupyter Notebook! To run the notebook, run the following command at the Terminal (Mac/Linux) or Command Prompt (Windows): `jupyter notebook`

  - [Optional: Installing Kernels — Jupyter Documentation 4\.1\.1 alpha documentation](https://jupyter.readthedocs.io/en/latest/install-kernel.html) #ril

## 參考資料 {: #reference }

  - [Projec Jupyter](http://jupyter.org/)
  - [Jupyter Blog](https://blog.jupyter.org/)
  - [jupyter/notebook - GitHub](https://github.com/jupyter/notebook)
  - [NBViewer (Jupyter Notebook Viewer)](https://nbviewer.jupyter.org/)
  - [jupyterhub/jupyterhub - GitHub](https://github.com/jupyterhub/jupyterhub) #ril

社群：

  - [Project Jupyter | Community](https://jupyter.org/community)
  - ['jupyter' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/jupyter)

文件：

  - [Jupyter Documentation](https://jupyter.readthedocs.io/en/latest/index.html)

相關：

  - 最早從 [IPython](ipython.md) 分出來。

手冊：

  - [Jupyter Notebook Documentation](https://jupyter-notebook.readthedocs.io/en/stable/)
  - [JupyterHub Documentation](https://jupyterhub.readthedocs.io/en/latest/)
  - [JupyterLab Documentation](http://jupyterlab.readthedocs.io/en/stable/)
