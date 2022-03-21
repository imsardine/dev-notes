---
title: GnuCash / API
---
# [GnuCash](gnucash.md) / API

## CSV Import

  - [6\.16\. Importing Transactions from Files](https://www.gnucash.org/docs/v4/C/gnucash-help/trans-import.html#trans-import-csv)

      - Imported transactions will generally be to a specific account in your account tree. In the following this will be referred to as the IMPORT or BASE ACCOUNT.

        It may or may not be specified in the data being imported depending on the import format. It is usually the FIRST SPLIT of a transaction being imported.

      - All transactions will also need to have a DESTINATION ACCOUNT for any OTHER SPLITS ASSOCIATED with the tansaction.

        These may or may not be supplied in the imported data, depending upon the data source and the format of the data. If it is not, GnuCash may be able to assign an account on the basis of the previous import history by matching infomation in the imported data to data associated with previous account assignments in the importer.

        The user may always OVER-RIDE THIS AUTOMATIC ASSIGNMENT or where no assignment can be made automatically assign an account manually.

      - MULTI-SPLIT data exported from GnuCash in CSV format will normally have both the import and destination accountsfor transaction splits specified in the data file.

        可以用 Export 的功能來學習 CSV 要怎麼編寫。

    ---

    Import CSV

      - Clicking on File->Import->Import Transactions from CSV will bring up the CSV Transaction Import Assistant dialog illustrated below.

        The CSV Transaction import Assistant is largely self explanatory with information panes which describe the functionality.

    CSV Import Process Steps. ... The steps in the CSV import process are:

      - Transaction Import Assistant: Introductory information panel. Click Next to continue;
      - Select File for Import: Display the File selection dialog. Navigate to the file you wish to import then click the Next button;
      - Import Preview: The Import Preview pane controls set options for the import of CSV data and provides a preview of the data to be imported.

## Python Binding

  - [Chapter 17\. Python Bindings](https://www.gnucash.org/docs/v4/C/gnucash-guide/ch_python_bindings.html)

      - GnuCash historically has always been a traditional application in the sense that you open it, use it to manipulate your financial data via the windows it presents, save your data and close the windows again. This has the inherent limitation that you can only do whatever the windows, menus and toolbars allow you to do.

        Sometimes you might need a little more flexibility. For example, you need a report with just a little different information than what the built-in reports provide, or you want to AUTOMATE a frequently recurring action. Such custom manipulations are ideal candidates to write in one or the other SCRIPTING language.

      - Starting with GnuCash version 2.4 you can write Python scripts to manipulate your financial data.

        IMPORTANT: The Python EXTENSIONS are an optional feature which creates additional dependencies. To be able to use Python scripts, GnuCash must have been built with the `cmake -DWITH_PYTHON=ON …` option enabled, otherwise all what follows won’t work.

        At present this option is NOT ENABLED BY DEFAULT, so if you need this, you may have to compile GnuCash from source yourself. But some distributions offer it also as a separate package with a name like `python[version]-GnuCash`

        The Python extensions come with a couple of ready to use scripts. This chapter will show you how to use some of them.

  - [Python Bindings \- GnuCash](https://wiki.gnucash.org/wiki/Python_Bindings)

      - Python in gnucash has two main aspects:

          - Python bindings
          - Python shell

      - Python bindings provide SWIG WRAPPER functions for some of gnucashs C/C++ parts. They can be used to write standalone scripts to work with the gnucash financial data. In the source tree they are located at `bindings/python`.

      - The python shell opens at gnucash startup and provides a python environment to use WITH THE RUNNING GNUCASH INSTANCE. In the source tree it is located at `gnucash/python`.

        You USE THE PYTHON BINDINGS IN THIS SHELL. Be careful: gnucash is not designed to have multiple instances changing the data at the same time, reading should be secure.

      - Note, that there is also a pure python client, piecash, to read and manipulate GnuCash books if saved in of the three SQL backends (sqlite, MySQL, Postgres).

        Currently (Oct 2020), piecash supports files created up to GnuCash 4.2.

        2021-12-05 GnuCash 版本來到 4.8，但 [piecash 只支援到 4.1](https://piecash.readthedocs.io/en/master/news.html#version-1-1-0-2020-10-20)，看來還是用內建的 Python binding 比較妥當。

    General notice

      - Python bindings have been added to gnucash in 2008 or earlier. There is still VERY LITTLE DOCUMENTATION and probably few people would know how to use it. While not a manual, this page was created in the hope to provide information for those interested in gnucash and python.

    Setting things up

      - Gnucash 4.x requires Python 3.6.
      - GnuCash's Python bindings has been known to work with CPython version 3.2 or later as of GnuCash 3.0.

