# PDF (Portable Document Format)

## 不能複製文字 ?? {: #copy-text }

  - [Can’t Copy Text from a PDF File?](https://helpdeskgeek.com/help-desk/cant-copy-text-from-a-pdf-file/)
      - You can quickly check to see if a PDF file is secured in Adobe Reader by looking up in the title bar and looking for the word SECURED.
      - You can see specific permissions by clicking on Edit and then clicking on Protection and then Security Properties.
      - As you can see below, content copying is not allowed and the security is PROTECTED BY A PASSWORD. If you know the password, then you could remove the security and copy all you want.
      - Unless you’re a hacker, breaking the password is not an option. So the only other thing you can do is take a screenshot of the text and then run it through an OCR program. Sounds like too much work, but it really is not. You can take a screenshot on a Mac or PC without additional software.

工具：

  - [Free Online OCR \- Convert JPEG, PNG, GIF, BMP, TIFF, PDF, DjVu to Text](https://www.newocr.com/) 上傳 PDF 後，切換不同的頁次 (甚至選取範圍)，就可以得到該頁 OCR 的結果。

## Text Extraction ??

  - [Xpdf](xpdf.md)
  - [PDFMiner](pdfminer.md)

參考資料：

  - [Related Projects - PDFMiner](https://euske.github.io/pdfminer/#related)

      - "PDFMiner is about 20 times slower than other C/C++-based counterparts such as XPdf."，所以 XPdf 是更好的選擇?
      - 其他相關的專案還有 [pyPdf](http://pybrary.net/pyPdf/) (停止維護)、[PDFBox](http://www.pdfbox.org/) (現在的 [Apache PDFBox](https://pdfbox.apache.org/)?)、[MuPDF](https://mupdf.com/)。

