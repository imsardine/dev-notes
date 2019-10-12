# terminaltables

  - [terminaltables 3\.1\.0 — terminaltables](https://robpol86.github.io/terminaltables/) #ril

      - Easily draw tables in terminal/console applications from A LIST OF LISTS OF STRINGS. As easy as:

            >>> from terminaltables import AsciiTable
            >>> table_data = [
            ... ['Heading1', 'Heading2'], <-- 結構上很直覺，預設第 1 行是 heading
            ... ['row1 column1', 'row1 column2'],
            ... ['row2 column1', 'row2 column2'],
            ... ['row3 column1', 'row3 column2'],
            ... ]
            >>> table = AsciiTable(table_data)
            >>> print table.table
            +--------------+--------------+
            | Heading1     | Heading2     |
            +--------------+--------------+
            | row1 column1 | row1 column2 |
            | row2 column1 | row2 column2 |
            | row3 column1 | row3 column2 |
            +--------------+--------------+

        ![](https://robpol86.github.io/terminaltables/_images/examples.png)

      - Windows 10, Windows XP, and OS X are also supported.

    Features

      - Multi-line rows: add newlines to table cells and terminatables will handle the rest.
      - Table titles: show a title embedded in the TOP BORDER of the table. 雖然這位置有點奇特
      - POSIX: Python 2.6, 2.7, PyPy, PyPy3, 3.3, 3.4, and 3.5 supported on Linux and OS X.
      - Windows: Python 2.7, 3.3, 3.4, and 3.5 supported on Windows XP through 10.

      - CJK: Wide Chinese/Japanese/Korean characters displayed correctly.

        這點很重要，否則資料摻雜中文，線條就對不起來了

      - RTL: Arabic and Hebrew characters aligned correctly.
      - Alignment/Justification: Align individual columns left, center, or right.
      - Colored text: colorclass, colorama, termcolor, or just plain ANSI escape codes. 能搭配其他 package 產生顏色 #ril

## 新手上路 {: #getting-started }

  - [Quickstart — terminaltables](https://robpol86.github.io/terminaltables/quickstart.html) #ril

    Table with Default Settings

      - Let’s begin by importing `AsciiTable`, which just uses `+`, `-`, and `|` characters.

            >>> from terminaltables import AsciiTable

      - Now let’s define the table data in a variable called `data`. We’ll do it the long way by creating an empty list representing the entire table. Then we’ll add rows one by one. EACH ROW IS A LIST REPRESENTING TABLE CELLS.

            >>> data = []
            >>> data.append(['Row one column one', 'Row one column two'])
            >>> data.append(['Row two column one', 'Row two column two'])
            >>> data.append(['Row three column one', 'Row three column two'])

      - Next we can use `AsciiTable` to format the table properly and then we can just print it. `table.table` gives you just one long string WITH NEWLINE characters so you can easily print it.

            >>> table = AsciiTable(data)
            >>> print table.table
            +----------------------+----------------------+
            | Row one column one   | Row one column two   |
            +----------------------+----------------------+
            | Row two column one   | Row two column two   |
            | Row three column one | Row three column two |
            +----------------------+----------------------+

      - By default the FIRST ROW of the table is considered the HEADING. This can be turned off.

        [`Table.inner_heading_row_border` - Settings — terminaltables](https://robpol86.github.io/terminaltables/settings.html#Table.inner_heading_row_border)

        > Show a horizontal dividing border after the first row. If `False` this removes the border so THE FIRST ROW IS NO LONGER CONSIDERED A HEADER ROW. It’ll look just like any other row.

## 安裝設置 {: #setup }

  - [Installation — terminaltables](https://robpol86.github.io/terminaltables/install.html) `pip install terminaltables`

## 參考資料 {: #reference }

  - [terminaltables - PyPI](https://pypi.org/project/terminaltables/)
  - [Robpol86/terminaltables - GitHub](https://github.com/Robpol86/terminaltables)

文件：

  - [terminaltables Documentation - Read the Docs](https://robpol86.github.io/terminaltables/)
