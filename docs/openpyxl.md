# OpenPyXL

  - [openpyxl: my python xlsx library \| Eric Gazoni's Blog](https://ericgazoni.wordpress.com/2010/04/10/openpyxl-python-xlsx/) (2010-04-10) #ril

  - [openpyxl \- A Python library to read/write Excel 2010 xlsx/xlsm files — openpyxl 2\.6\.2 documentation](https://openpyxl.readthedocs.io/en/stable/) #ril

    雖然文件內都用 openpyxl，但左上方的 logo 明確寫著 OpenPyXL，揭露了正確的大小寫。

    Introduction

      - openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm/xltx/xltm files.

        It was born from lack of existing library to read/write NATIVELY from Python the Office Open XML format.

        All kudos to the PHPExcel team as openpyxl was initially based on PHPExcel.

        竟然 PHP 比 Python 早有可以好好處理 Excel 的套件。

    Security

      - By default openpyxl does not guard against quadratic blowup or billion laughs xml attacks. ?? To guard against these attacks install [defusedxml](https://github.com/tiran/defusedxml). #ril

## Defined Name

  - [Defined Names — openpyxl 2\.6\.2 documentation](https://openpyxl.readthedocs.io/en/stable/defined_names.html)

      - The specification has the following to say about defined names:

        “Defined names are descriptive text that is used to represents a cell, range of cells, formula, or constant value.”

      - This means they are very LOOSELY DEFINED. They might contain a constant, a formula, a single cell reference, a range of cells or multiple ranges of cells across different worksheets. Or all of the above. They are defined GLOBALLY for a workbook and accessed from there `defined_names` attribue.

    Sample use for ranges

      - Accessing a range called “`my_range`”:

            my_range = wb.defined_names['my_range']
            # if this contains a range of cells then the destinations attribute is not None
            dests = my_range.destinations # returns a generator of (worksheet title, cell range) tuples

            cells = []
            for title, coord in dests:
                ws = wb[title]
                cells.append(ws[coord])



## 新手上路 {: #getting-started }

  - [Tutorial — openpyxl 2\.6\.2 documentation](https://openpyxl.readthedocs.io/en/stable/tutorial.html) #ril

  - [Working with Excel sheets in Python using openpyxl \- Aubergine Solutions \- Medium](https://medium.com/aubergine-solutions/working-with-excel-sheets-in-python-using-openpyxl-4f9fd32de87f) (2018-05-30) #ril

## Properties, Custom Properties {: #properties }

  - [feature: add custom properties support · Issue \#91 · python\-openxml/python\-docx](https://github.com/python-openxml/python-docx/issues/91) 尚不支援，未來可能從 `custom_properties` 拿到 #ril
  - [Extract xlsx workbook file metadata/properties in python 3\.6 \- Stack Overflow](https://stackoverflow.com/questions/53930645/) #ril

## 安裝設置 {: #setup }

  - 安裝 `openpyxl` 套件即可，若需要寫出大檔，搭配 lxml 可以提昇效能。
  - 需要在檔案裡安插圖片，要再加裝 `pillow` 套件。

參考資料：

  - [Installation - openpyxl \- A Python library to read/write Excel 2010 xlsx/xlsm files — openpyxl 2\.6\.2 documentation](https://openpyxl.readthedocs.io/en/stable/#installation)

      - Install openpyxl using pip. It is advisable to do this in a Python virtualenv without system packages:

            $ pip install openpyxl

        Note: There is support for the popular lxml library which will be USED IF IT IS INSTALLED. This is particular useful when creating LARGE FILES.

        [Reading and Writing Excel workbooks - Tools for Working with Excel and Python \| PyXLL](https://www.pyxll.com/blog/tools-for-working-with-excel-and-python/#read-write) 提到 OpenPyXL 寫出大檔案時會有偏慢的問題，看來可以搭配 lxml 解掉。

      - Warning: To be able to include images (jpeg, png, bmp,…) into an openpyxl file, you will also need the “pillow” library that can be installed with:

            $ pip install pillow

## 參考資料 {: #reference }

  - [OpenPyXL](http://openpyxl.readthedocs.io/)
  - [openpyxl/openpyxl - Bitbucket](https://bitbucket.org/openpyxl/openpyxl/src/default/)
  - [openpyxl -  PyPI](https://pypi.org/project/openpyxl/)

社群：

  - ['openpyxl' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/openpyxl)

手冊：

  - [API Reference](https://openpyxl.readthedocs.io/en/stable/api/openpyxl.html)
