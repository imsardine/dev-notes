# Conda

  - [Conda \(package manager\) \- Wikipedia](https://en.wikipedia.org/wiki/Conda_(package_manager)) #ril

## 跟 Pip 的關係 ??

  - [python \- What is the difference between pip and conda? \- Stack Overflow](https://stackoverflow.com/questions/20994716/) 看到 IPython 用 conda 安裝，如果有 pip 為什要有 conda 做為另一個 package manager? #ril
      - Martijn Pieters: 引述 Conda blog 的說法 -- 他們當然知道 pip、easy_install、virtualenv，但這些工具都無法滿足特殊的需求；主要的問題是這些工具都專注在 Python，忽略了 non-Python library dependencies，例如 HDF5、MKL、LLVM 等。
      - Conda 比 pip 做得多一些，也把 Python packages 以外的 dependencies 考量進來，而 Conda 也支援 virtual environment。事實上，Conda 應該拿來跟 Buildout 比，另一個同時處理 Python 跟 non-Python dependencies 的工具。 由於 Conda 用了不同的 packaging format，所以不能跟 pip 交互使用。
      - sancho.s：引述了 Conda: Myths and Misconceptions 的說法 Myth #3: Conda and pip are direct competitors，大概是在說兩者目的不同，只在 "installing Python packages in isolated environments" 這塊重疊。如果只裝 Python package 其實兩者沒有差別，但 "pip installs python packages within any environment" 與 "conda installs any package within conda environments" 明顯說明兩者的差異，舉例說明 work with the many Python packages which rely on external dependencies (例如 NumPy、SciPy、Matplotlib 等)，pip 就會略顯不足。
  - [Conda: Myths and Misconceptions \| Pythonic Perambulations](https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/) (2016-08-25) #ril

## 參考資料 {: #reference }

  - [Conda](https://conda.io)
  - [conda/conda - GitHub](https://github.com/conda/conda)

相關：

  - [Anaconda](anaconda.md) 是基於 Conda 的一種 Python distribution。

手冊：

  - [Conda Documentation](https://conda.io/docs/)
