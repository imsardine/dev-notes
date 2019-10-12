# PDFMiner

  - [PDFMiner](https://euske.github.io/pdfminer/) #ril

      - Python PDF parser and analyzer 其中 analyzer 跟 parser 有何不同??
      - PDFMiner is a tool for extracting information from PDF documents. Unlike other PDF-related tools, it focuses entirely on getting and analyzing text data. PDFMiner allows one to obtain the EXACT LOCATION of text in a page, as well as other information such as fonts or lines. It includes a PDF converter that can transform PDF files into other text formats (such as HTML). It has an extensible PDF parser that can be used for other purposes than TEXT ANALYSIS.

    Features

      - Written entirely in Python. (for version 2.4 or newer) 可惜不前仍不相容於 Python 3
      - Parse, analyze, and convert PDF documents.
      - PDF-1.7 specification support. (well, almost)
      - CJK languages and vertical writing scripts support.
      - Various font types (Type1, TrueType, Type3, and CID) support.
      - Basic encryption (RC4) support. 解有密碼保護的文件??
      - PDF to HTML conversion (with a sample converter web app).
      - Outline (TOC) extraction.
      - Tagged contents extraction. ??
      - Reconstruct the original layout by grouping text chunks.
      - PDFMiner is about 20 TIMES SLOWER than other C/C++-based counterparts such as XPdf.

  - [Commits · euske/pdfminer](https://github.com/euske/pdfminer/commits/master) 最後一個 commit 在 2016-09-26，似乎已停止維護?

## 新手上路 {: #getting-started }

  - [Programming with PDFMiner](https://euske.github.io/pdfminer/programming.html) #ril

## 安裝設置 {: #setup }

  - [How to install - PDFMiner](https://euske.github.io/pdfminer/#install) #ril

     1. Install Python 2.4 or newer. (Python 3 is not supported.)
     2. Download the PDFMiner source.
     3. Unpack it.

     4. Run `setup.py` to install:

            python setup.py install

     5. Do the following test:

            $ pdf2txt.py samples/simple1.pdf
            Hello

            World

            Hello

            World

            H e l l o

            W o r l d

            H e l l o

            W o r l d

## 參考資料 {: #reference }

  - [PDFMiner](https://euske.github.io/pdfminer/)
  - [euske/pdfminer - GitHub](https://github.com/euske/pdfminer)

相關：

  - [PDF / Text Extraction](pdf.md#text-extraction)
  - [pdfminer/pdfminer.six - GitHub](https://github.com/pdfminer/pdfminer.six) - 支援 Python 3 的版本
