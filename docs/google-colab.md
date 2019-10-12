# Google Colab

  - [Colaboratory - Project Jupyter \- Wikipedia](https://en.wikipedia.org/wiki/Project_Jupyter#Colaboratory)

      - Colaboratory (also known as Colab) is a free Jupyter notebook ENVIRONMENT that runs in the cloud and stores its notebooks on Google Drive.

        Colaboratory started as a part of Project Jupyter, but the development was eventually taken over by Google. As of September 2018, Colaboratory only supports the Python 2 and Python 3 kernels and DOES NOT support the other Jupyter kernels Julia and R.

        感覺 Colaboratory 是一種特化的 JupyterLab (執行在 Google Cloud 上)，多了 Google Drive 及其他工具的整合，但也少了其他語言的支持。

## 新手上路 {: #getting-started }

  - [Welcome To Colaboratory \- Colaboratory](https://colab.research.google.com/notebooks/welcome.ipynb)

      - Colaboratory is a free Jupyter notebook environment that requires no setup and runs entirely in the cloud.

      - With Colaboratory you can write and execute code, save and share your analyses, and access powerful computing resources, all for FREE from your browser.

        妙的是，程式執行在 Google Cloud 上，卻不用付費。

    Introducing Colaboratory

      - This 3-minute video gives an overview of the key features of Colaboratory:

        [Get started with Google Colaboratory \(Coding TensorFlow\) \- YouTube](https://www.youtube.com/watch?v=inN8seMm7UI)

    Getting Started

      - The document you are reading is a Jupyter notebook, hosted in Colaboratory. It is not a static page, but an INTERACTIVE ENVIRONMENT that lets you write and execute code in Python and other languages.

        事實上，目前僅支援 Python 2 跟 Python 3。

      - For example, here is a code cell with a short Python script that computes a value, stores it in a variable, and prints the result:

            seconds_in_a_day = 24 * 60 * 60
            seconds_in_a_day

        To execute the code in the above cell, select it with a click and then either press the ▷ button to the left of the code, or use the keyboard shortcut "⌘/Ctrl+Enter".

      - All cells modify the SAME GLOBAL STATE, so variables that you define by executing a cell can be used in other cells:

            seconds_in_a_week = 7 * seconds_in_a_day
            seconds_in_a_week

      - For more information about working with Colaboratory notebooks, see [Overview of Colaboratory](https://colab.research.google.com/notebooks/basic_features_overview.ipynb).

    More Resources

      - Learn how to make the most of Python, Jupyter, Colaboratory, and related tools with these resources:

        Working with Notebooks in Colaboratory

          - [Overview of Colaboratory](https://colab.research.google.com/notebooks/basic_features_overview.ipynb)
          - [Guide to Markdown](https://colab.research.google.com/notebooks/markdown_guide.ipynb) #ril
          - [Importing libraries and installing dependencies](https://colab.research.google.com/notebooks/snippets/importing_libraries.ipynb) #ril
          - [Saving and loading notebooks in GitHub](https://colab.research.google.com/github/googlecolab/colabtools/blob/master/notebooks/colab-github-demo.ipynb) #ril
          - [Interactive forms](https://colab.research.google.com/notebooks/forms.ipynb) #ril
          - [Interactive widgets](https://colab.research.google.com/notebooks/widgets.ipynb) #ril

        Working with Data

          - [Loading data: Drive, Sheets, and Google Cloud Storage](https://colab.research.google.com/notebooks/io.ipynb) #ril
          - [Charts: visualizing data](https://colab.research.google.com/notebooks/charts.ipynb) #ril
          - [Getting started with BigQuery](https://colab.research.google.com/notebooks/bigquery.ipynb) #ril

        Machine Learning Crash Course

          - These are a few of the notebooks from Google's online Machine Learning course. See the full course website for more.

          - [Intro to Pandas](https://colab.research.google.com/notebooks/mlcc/intro_to_pandas.ipynb) #ril
          - [Tensorflow concepts](https://colab.research.google.com/notebooks/mlcc/tensorflow_programming_concepts.ipynb) #ril
          - [First steps with TensorFlow](https://colab.research.google.com/notebooks/mlcc/first_steps_with_tensor_flow.ipynb) #ril
          - [Intro to neural nets](https://colab.research.google.com/notebooks/mlcc/intro_to_neural_nets.ipynb) #ril
          - [Intro to sparse data and embeddings](https://colab.research.google.com/notebooks/mlcc/intro_to_sparse_data_and_embeddings.ipynb) #ril

        Using Accelerated Hardware

          - [TensorFlow with GPUs](https://colab.research.google.com/notebooks/gpu.ipynb) #ril
          - [TensorFlow with TPUs](https://colab.research.google.com/notebooks/tpu.ipynb) #ril

  - [Get started with Google Colaboratory \(Coding TensorFlow\) \- YouTube](https://www.youtube.com/watch?v=inN8seMm7UI) (2019-01-30)

      - 00:14 Google Colab is an executable document that lets you write, run, and share code within Google Drive. If you're familiar with the popular Jupyter project, you can think of Colab as a JUPYTER NOTEBOOK STORED IN GOOGLE DRIVE.

      - 00:27 A notebook document is composed of CELLS, each of which can contain code, text, images, and more.

      - 00:34 Colab connects your notebook to a CLOUD-BASED RUNTIME, meaning you can execute Python code without any required setup on your own machine.

        執行 `print('Hello, World!')` 後，右上角會出現 RAM/Disk 的資訊，提示著 Connected to "Python 3 Google Compute Engine backend" RAM: 0.62 GB/12.72 GB Disk: 20.89 GB/48.97 GB，資源很充足，重點是免費的!!

        下拉預設是 Connect to hosted runtime，另一個選項 Connect to local runtime... 要裝哪些套件才會跟 Colab 提供的環境一樣 ??

      - 00:42 Additional CODE CELLS are executed using that same runtime, resulting in a rich, interactive coding experience in which you can use any of the functionality that Python offers.

        For example, here we define a variable containing a range of 10 numbers.  In the next cell, we loop through this range, printing the square of each number.

        For convenience, we use the Shift-Enter shortcut rather than the Play button to execute the cell.

        也就是多個 code cell 間是共用一個 runtime，因此可以分段執行。

      - 01:07 Cell outputs are not limited to simple text, however. They can contain any number of DYNAMIC, rich outputs. For example, we can search Colab's built-in library of CODE SNIPPETS and insert code to create an INTERACTIVE DATA VISUALIZATION.

        這裡搜尋 visualization 選 Visualization: Linked Brushing in Altair，插入成為 code cell 就可執行：

            # load an example dataset
            from vega_datasets import data # https://pypi.org/project/vega_datasets/
            cars = data.cars()

            import altair as alt # https://pypi.org/project/altair/

            interval = alt.selection_interval()

            base = alt.Chart(cars).mark_point().encode(
              y='Miles_per_Gallon',
              color=alt.condition(interval, 'Origin', alt.value('lightgray'))
            ).properties(
              selection=interval
            )

            base.encode(x='Acceleration') | base.encode(x='Horsepower')

        This particular visualization is created with Altair, one of several third-party visualization libraries that Colab supports.

      - 01:28 Colab notebooks can be shared like a Google Doc, and for this purpose it's useful to use TEXT CELLS to provide a NARRATIVE AROUND THE CODE you've executed.

        Text cells are formatted using Markdown, a plain text document format that's rendered on the page. Markdown format is simple and powerful, allowing you to add headings, paragraphs, lists and even MATHEMATICAL FORMULAE.

        可以寫數學方程式很重要，因為 machine learning 就是在建立數學模型。

      - 01:51 If you would like to share your notebooks with others, you can do so via Google Drive sharing or even by EXPORTING your notebook to GitHub.

        The notebook is stored in the standard Jupyter Notebook format, and so the notebooks you create can be viewed and executed in Jupyter Notebook, JupyterLab, and other compatible frameworks.

        要先安裝哪些套件也可以寫在 notebook 裡，方便直接執行安裝步驟 (shell script) ??

      - 02:10 The convenience of sharing notebooks means that you can find and explore many interesting notebooks around the web. One useful collection is the Seedbank project at research.google.com/seedbank.

        [Seedbank](https://research.google.com/seedbank/) 提供有 Run seed in Colab 直接在 Colab 開啟 notebook。

        For example, the [Neural Style Transfer](https://research.google.com/seedbank/seed/neural_style_transfer_with_tfkeras) seed shows how to use deep learning to transfer styles between images and includes a link to a Colab notebook where you can run and modify the code.

      - 02:34 To learn more about Colab, visit colab.research.google.com and find the Welcome notebook, where you will find links to tutorials and other info about Jupyter and Colab notebooks.

        You can also find the remaining videos in this series, which will explore Colab in more depth. In the next video, my colleague Lawrence will explore how to INSTALL TENSORFLOW using Colab and how to use DIFFERENT RUNTIMES to access things like the GPU. See you there.

        在 Colab 上為什麼還要安裝 TensorFlow，不是本來就有 ??

  - [Overview of Colaboratory Features \- Colaboratory](https://colab.research.google.com/notebooks/basic_features_overview.ipynb) #ril

## 參考資料 {: #reference }

  - [Google Colab](https://colab.research.google.com/)
  - [Seedbank - Collection of Interactive Machine Learning Examples](https://research.google.com/seedbank/)

相關：

  - 是一個特化過、執行在 Google Compute Engine 上的 [Jupyter Notebook](jupyter.md)。
  - 做為 [TensorFlow](tensorflow.md) 的學習環境，不用安裝設定。
