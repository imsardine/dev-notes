---
title: Google Sheets / Function
---
# [Google Sheets](google-sheets.md) / Function

## Error Handling

  - [ISERROR \- Docs Editors Help](https://support.google.com/docs/answer/3093349)
  - [ERROR\.TYPE \- Docs Editors Help](https://support.google.com/docs/answer/3238305)

## Date/Time {: #datetime }

### `DATEDIF`

  - [DATEDIF \- Docs Editors Help](https://support.google.com/docs/answer/6055612)

      - Calculates the number of days, months, or years between two dates.

    Sample Usage

      - `DATEDIF(DATE(1969, 7, 16), DATE(1969, 7, 24), "D")`

        日期反過來時 (`=DATEDIF(DATE(1969, 7, 24), DATE(1969, 7, 16), "D")`)，會出現 Function DATEDIF parameter 1 (7/24/1969) should be on or before Function DATEDIF parameter 2 (7/16/1969)

      - `DATEDIF(A1, A2, "YM")`
      - `DATEDIF("7/16/1969", "7/24/1969", "Y")`

## 參考資料 {: #reference }

手冊：

  - [Google Sheets function list](https://support.google.com/docs/table/25273?hl=en)
