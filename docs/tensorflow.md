# TensorFlow

  - [TensorFlow](https://www.tensorflow.org/)

      - An END-TO-END open source machine learning platform

        這裡的 end-to-end 指的是從頭到尾完成一個 task，因為 training、deploy 都只是其中一環。

      - The core open source library to help you develop and train ML models. Get started quickly by running [Colab notebooks](https://colab.research.google.com/) directly in your browser.

      - For JavaScript -- TensorFlow.js is a JavaScript library for training and deploying models in the browser and on Node.js. #ril

        Deploying model 還可以理解，但在 browser 裡做 traning !??

      - For Mobile & IoT -- TensorFlow Lite is a lightweight library for deploying models on mobile and embedded devices.
      - For production -- TensorFlow Extended is an end-to-end platform for preparing data, training, validating, and deploying models in large production environments. #ril

    Why TensorFlow

      - TensorFlow is an end-to-end open source platform for machine learning. It has a comprehensive, flexible ecosystem of tools, libraries and community resources that lets researchers push the state-of-the-art in ML and developers easily build and deploy ML powered applications.
      - Easy model building -- Build and train ML models easily using intuitive high-level APIs like Keras with eager execution, which makes for immediate model iteration and easy debugging.

      - Robust ML production anywhere -- Easily train and deploy models in the cloud, on-prem, in the browser, or on-device no matter what language you use.

        產出 model 後，要能夠用 model 做些事才是關鍵，能 deploy 到各式各樣的環境很重要。

      - Powerful experimentation for research -- A simple and flexible architecture to take new ideas from concept to code, to state-of-the-art models, and to publication faster.

        這一點 Colab 扮演了很重要的角色。

  - [Why TensorFlow](https://www.tensorflow.org/about/) #ril

  - [透過 Google Colaboratory 學習使用 Python 做機器學習等科學計算 – Eric ShangKuan – Medium](https://medium.com/@ericsk/9f92c7bb1f50) (2018-10-08) #ril

## 新手上路 {: #getting-started }

  - [Get Started with TensorFlow](https://www.tensorflow.org/tutorials/) #ril
  - [TensorFlow Core  \|  TensorFlow](https://www.tensorflow.org/overview/) #ril
  - [Introduction to TensorFlow](https://www.tensorflow.org/learn) #ril
  - [Tools - TensorFlow](https://www.tensorflow.org/resources/tools) 提到 TensorBoard、TensorFlow Playground #ril

## 安裝設定 {: #installation }

  - [Install TensorFlow](https://www.tensorflow.org/install)

      - TensorFlow is tested and supported on the following 64-bit systems:

          - Ubuntu 16.04 or later
          - Windows 7 or later
          - macOS 10.12.6 (Sierra) or later (no GPU support)
          - Raspbian 9.0 or later

        好奇 RasPi 的運算能力夠嗎?? 可惜 macOS 不支援 GPU

    Download a package

      - Install TensorFlow with Python's pip package manager.

        Official packages available for Ubuntu, Windows, macOS, and the Raspberry Pi.

            # Current stable release for CPU-only
            pip install tensorflow

            # Preview nightly build for CPU-only (unstable)
            pip install tf-nightly

            # Install TensorFlow 2.0 Alpha
            pip install tensorflow==2.0.0-alpha0

        See the GPU guide for CUDA®-enabled cards.

        執行 `pip install tensorflow` 時會看到下載平台專屬的套件，例如 `tensorflow-1.13.1-cp37-cp37m-macosx_10_11_x86_64.whl`；很意外地，過程中不用編譯其他原生套件。

  - [Install TensorFlow with pip  \|  TensorFlow](https://www.tensorflow.org/install/pip)

    Available packages

      - `tensorflow` — Latest stable release for CPU-only (Ubuntu and Windows)

      - `tensorflow-gpu` — Latest stable release with GPU support (Ubuntu and Windows)

        GPU 只有 Ubuntu 跟 Windows 支援，macOS 跟 RasPi 不支援。

      - `tf-nightly` — Preview nightly build for CPU-only (unstable)
      - `tf-nightly-gpu` — Preview nightly build with GPU support (unstable, Ubuntu and Windows)

    System requirements

      - Ubuntu 16.04 or later (64-bit)
      - macOS 10.12.6 (Sierra) or later (64-bit) (no GPU support)

      - Windows 7 or later (64-bit) (Python 3 only)

        為何只有 Windows 特別要求 Python 3 ?? 其他 Python 2/3 都可以。

      - Raspbian 9.0 or later

    Hardware requirements

      - Starting with TensorFlow 1.6, binaries use AVX instructions which may not run on older CPUs.

        [Operating system support - Advanced Vector Extensions \- Wikipedia](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions#Operating_system_support) 各平台支援的時間點不同，macOS 從 10.6.8 (2011-06-23) 開始，Linux 則從 kernel 2.6.30 (2009-06-09) 開始。

      - Read the GPU support guide to set up a CUDA®-enabled GPU card on Ubuntu or Windows.

    Create a virtual environment (recommended)

      - Create a new virtual environment by choosing a Python interpreter and making a `./venv` directory to hold it:

            virtualenv --system-site-packages -p python3 ./venv

        為什麼要有 `--system-site-packages` (Give the virtual environment access to the global site-packages) ??

      - Activate the virtual environment using a shell-specific command:

            source ./venv/bin/activate  # sh, bash, ksh, or zsh

      - Install packages within a virtual environment without affecting the host system setup. Start by upgrading pip:

            pip install --upgrade pip

    Install the TensorFlow pip package

      - Choose one of the following TensorFlow packages to install from PyPI

          - `tensorflow` — Latest stable release for CPU-only (recommended for beginners)
          - `tensorflow-gpu` — Latest stable release with GPU support (Ubuntu and Windows)
          - `tf-nightly` — Preview nightly build for CPU-only (unstable)
          - `tf-nightly-gpu` — Preview nightly build with GPU support (unstable, Ubuntu and Windows)
          - `tensorflow==2.0.0-alpha0` — Preview TF 2.0 Alpha build for CPU-only (unstable)
          - `tensorflow-gpu==2.0.0-alpha0` — Preview TF 2.0 Alpha build with GPU support (unstable, Ubuntu and Windows)

      - Verify the install:

            $ pip install --upgrade tensorflow
            $ python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"

            2019-04-21 10:46:10.007608: I tensorflow/core/platform/cpu_feature_guard.cc:141] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA <-- 怎麼回事??
            tf.Tensor(-1940.5941, shape=(), dtype=float32)

  - [GPU support  \|  TensorFlow](https://www.tensorflow.org/install/gpu) #ril

### Docker ??

  - [Docker  \|  TensorFlow](https://www.tensorflow.org/install/docker) #ril

### Source ??

  - [Build from source  \|  TensorFlow](https://www.tensorflow.org/install/source) #ril
  - [x86 \- How to compile Tensorflow with SSE4\.2 and AVX instructions? \- Stack Overflow](https://stackoverflow.com/questions/41293077/) #ril
  - [lakshayg/tensorflow\-build: TensorFlow binaries supporting AVX, FMA, SSE](https://github.com/lakshayg/tensorflow-build) #ril

## 疑難排解 {: #troubleshooting }

### Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA

在 macOS 上安裝完 `tensorflow` 套件，簡單測試會被提示：

```
$ python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"

2019-04-21 10:46:10.007608: I tensorflow/core/platform/cpu_feature_guard.cc:141] Your CPU supports instructions that this TensorFlow binary was not compiled to use: AVX2 FMA <-- 怎麼回事??
tf.Tensor(-1940.5941, shape=(), dtype=float32)
```

這不是錯誤訊息，只是說明了在這台機器上，重新編譯並啟用 AVX2 會更快。

---

參考資料：

  - [error: this TensorFlow binary was not compiled to use: AVX2 FMA · Issue \#2 · bitbionic/keras\-to\-tensorflow](https://github.com/bitbionic/keras-to-tensorflow/issues/2)

      - archcra (ower): That should be a warning, NOT AN ERROR. It's a pretty standard warning in TF from a GENERIC TF compiled binary. You can get rid of that warning if you build TF yourself and supply the `AVX2` flag.

        See [tensorflow/tensorflow#8037](https://github.com/tensorflow/tensorflow/issues/8037) for a similar discussion on the TF GitHub. Good luck and thanks for checking out the tutorial.

  - [How to compile tensorflow using SSE4\.1, SSE4\.2, and AVX\. · Issue \#8037 · tensorflow/tensorflow](https://github.com/tensorflow/tensorflow/issues/8037)

      - Carmezim (contributor): This isn't an error, just warnings saying if you build TensorFlow from source IT CAN BE FASTER ON YOUR MACHINE.

        SO question about this: http://stackoverflow.com/questions/41293077/how-to-compile-tensorflow-with-sse4-2-and-avx-instructions

        TensorFlow guide to build from source: https://www.tensorflow.org/install/install_sources

      - gunan (member): Just as @Carmezim stated these are simply warning messages.

        For each of your programs, you will only see them ONCE. And just like the warnings say, you should only compile TF with these flags if you need to make TF faster.

        You can follow our guide to install TensorFlow from sources to compile TF with support for SIMD instruction sets.

      - Carmezim (contributor): @CGTheLegend @ocampesato you can use TF environment variable `TF_CPP_MIN_LOG_LEVEL` and it works as follows:

          - It defaults to 0, displaying all logs
          - To filter out INFO logs set it to 1
          - WARNINGS additionally, 2
          - and to additionally filter out ERROR logs set it to 3

        基本上就是調整 logging level，原先設定 0 可能就是 INFO，所以調成 1 才會去除 INFO；如果預設值是 INFO，好像也滿合理的。

        So you can do the following to silence the warnings:

            import os
            os.environ['TF_CPP_MIN_LOG_LEVEL']='2'
            import tensorflow as tf

        @gunan @mrry I've seen many folks interested in silencing the warnings, would there be interest in adding this kind of info to the docs?

## 參考資料 {: #reference }

  - [TensorFlow](https://www.tensorflow.org/)
  - [tensorflow - GitHub](https://github.com/tensorflow)

社群：

  - ['tensorflow' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/tensorflow)
  - [#poweredbytf - Twitter](https://twitter.com/hashtag/poweredbytf)

更多：

  - [TensorFlow Lite](tensorflow-lite.md)

相關：

  - 是一個 [Machine Learning](machine-learning.md) 平台
  - [Colab](google-colab.md) 提供了學習 TensorFlow 的環境
  - [Keras](keras.md)

手冊：

  - [Python Module: `tf` - TensorFlow API](https://www.tensorflow.org/api_docs/python/tf)
