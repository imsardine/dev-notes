---
title: Workday / Integration / Import External Payslips
---
# [Workday / Integration](workday-intsys.md) / Import External Payslips

  - [Steps: Set Up Import External Payslips Integration • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/67pT7WIK_69cX3MztvC9mA) #ril

    Prerequisites

      - Set up an external FTP server that is accessible by Workday and the external payroll system.

    Context

      - The external payroll endpoint loads the external payslip files on the FTP server. You can set up an Import External Payslips integration to retrieve external payslip files for selected pay groups and import the files into Workday.

  - [Reference: Import External Payslips Files • Integrations • Reader • Administrator Guide](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/sFNboMRVofF~aC0CMmzg~A)

    File Descriptions

      - CSV or XML files containing employee payslip data are called MANIFEST FILES. PDF files, each containing an IMAGE of a payslip, are called ARCHIVE FILES. PDF files are placed in a ZIP file, which is called a COMPRESSED archive file.

        每次 integration run 都面對 manifest file (`.csv`/`.xml`) x 1 + compressed archive file (`.zip`) x 1；不過若是 Document Retrieval 拿到多個 manifest file 跟 ZIP files，會發生什麼事?? 又 manifest file 與 ZIP 間是如何對應的??

        一個 manifest file 裡，有多個 manifest record，都用 `File_Name` 對應一支在 ZIP 裡的 payslip archive file (`.pdf`)，而且 `File_Name` 的值在 manifest 裡要是唯一的 (沒道理跟其他 worker 拿到同一份 payslip)。

        就一個 tenant 而言 (跨越所有 integration run)，`Worker` + `Pay_Group` + `Pay_Period_End_Date` + `Payment_Date` + `Check_Number` 的組合必須是唯一值；如果要達成員工在同一天有多個 payslip，只能從 `Check_Number` 動手腳??

    CSV File Format

      - For manifest data in CSV format, ensure your external payroll endpoint generates a CSV file with these values:

          - `Worker`

            Worker identifier.

            在 Workday 這邊的編號，表示外部系統若採用不同的編號，要有能力自行轉換。

          - `Pay_Group`

            Either the Workday REFERENCE ID for the Pay Group or the EXTERNAL Pay Group CODE. If you use the external Pay Group code, you configure the integration to MAP the external Pay Group code to a Workday Pay Group.

          - `Pay_Period_End_Date`

            End date of the Pay Period.

            若 Pay Period 是 "薪資週期" 的週期的意思，為什麼沒有 start date ??

          - `Payment_Date`

            Date of the payment.

          - `Net_Amount`

            Net pay amount.

          - `Gross_Amount`

            Gross pay amount.

          - `Currency`

            Currency code for the pay amounts. Example: USD.

          - `Check_Number`

            Number of the check.

            若不是給支票，這要給什麼值?? 下面提到，除 `Display_Date` 之後，其餘都不能是空白。

          - `Display_Date`

            Display date for the payslip. This date is displayed when viewing the payslip details in Workday.

          - `File_Name`

            Filename of the payslip PDF archive file.

            也就是在 ZIP 裡的 PDF 檔名。

        Note: If the integration attribute CSV Contains Header is enabled, ensure the column names in the CSV header row match the column names in the preceding table.

    Manifest File Validation

      - Ensure your manifest file is valid:

          - Only `Display_Date` can be empty.

            空白時會根據 `Payment_Date` 做為顯示??

          - Date fields require time zones. Example time zones: -03:00, Z. Example date with time zone: 2014-11-25-03:00.
          - `Pay_Group` is a valid active Payroll Interface Pay Group.

          - `File_Name` is unique in the manifest file FOR EACH INTEGRATION RUN.

             A manifest RECORD is considered invalid from the first manifest record with the same filename.

          - `File_Name` specifies an archive file (a PDF file with the extension `.pdf`) that exists in the compressed archive file (the ZIP file).

          - Any archive file not referenced by a manifest record is SENT TO the invalid archive file.
          - Any archive file referenced by a manifest record that failed a VALIDATION TEST is sent to the invalid archive file.

          - CSV files have the extension `.csv`. The integration only reads `.csv` manifest files when you configure the integration to read CSV files.

            由於 integration attributes 裡沒有任何跟 `.csv`/`.xml` 或 `.zip` 相關的 filename pattern 可以設定，猜想每次 integration run 會把所有 `.zip` 都解開，把所有 `.csv`/`.xml` 視為一個 manifest file ??

          - When using CSV files, and the integration attribute CSV Contains Header is enabled, ensure the column names in the CSV header row are correct.

            The column names are `Worker`, `Pay_Group`, `Pay_Period_End_Date`, `Payment_Date`, `Net_Amount`, `Gross_Amount`, `Currency`, `Check_Number`, `Display_Date`, and `File_Name`.

          - XML files have the extension `.xml`. The integration only reads `.xml` manifest files when you configure the integration to read XML files.
          - Compressed archive files are ZIP files and have the extension `.zip`. The integration only reads `.zip` files for the compressed archive files.

          - Manifest files must be located outside of ZIP files.
          - PDF files have the extension `.pdf`, and are placed in a compressed archive file.
          - PDF file size is below the limit for each payslip. ??

          - Combination of `Worker`, `Pay_Group`, `Pay_Period_End_Date`, `Payment_Date`, and `Check_Number` UNIQUELY identify an external payslip.

            The combination is unique for all manifest records for each integration run, and are UNIQUE FOR ALL EXTERNAL PAYSLIPS PER TENANT. A manifest record is considered invalid from the first manifest record having the same combination.

          - Worker is valid and has a position currently assigned to the specified Payroll Interface Pay Group.

          - `Pay_Period_End_Date` is within 1 YEAR OF THE CURRENT YEAR. Example: For 2014, a pay period end date of 2012 or earlier is invalid.

          - `Pay_Period_End_Date` is valid for the Pay Group.

      - The integration generates a DATA AUDIT file, which contains details for the import. Invalid manifest records and invalid archive records files are generated to help you correct failed record imports.

      - After 5 unsuccessful attempts to import a manifest file, ALL RECORDS in that file are considered invalid and are written to the invalid manifest file. The data audit file differentiates records that have errors from records that exceeded the maximum number of import attempts.

## 參考資料 {: #reference }

  - [Import External Payslips Files](https://doc.workday.com/reader/wsiU0cnNjCc_k7shLNxLEA/sFNboMRVofF~aC0CMmzg~A) -- 規範 manifest file (CSV/XML) 的格式，以及對 archive files (ZIP) 內容的要求
