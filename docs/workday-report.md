---
title: Workday / Reporting
---
# [Workday](workday.md) / Reporting

## Custom Report

  - [Concept: Custom Reports • Reporting and Analytics • Reader • Administrator Guide](https://doc.workday.com/reader/HAJOEAaClxziA9ljvuBqZA/ebr1UA36DH04M_yZEEH1AA) #ril

      - You can create custom reports to serve your requirements beyond the Workday-delivered STANDARD reports.

      - As with standard reports, you can:

          - Access related actions on custom report results.
          - Download custom report output as a PDF or spreadsheet.
          - Enable a custom report as a WORKLET. ??
          - Translate a custom report to another LANGUAGE. ??

      - You can create a custom report in these ways:

          - Access the Create Custom Report task.
          - Copy a Workday-delivered standard report.
          - Copy an existing custom report.
          - Select Custom Report > Create from the related actions menu of a DATA SOURCE.

    Report Ownership

      - When you create a report, you OWN it and can perform these actions on it:

          - Edit
          - Delete
          - Run
          - Share
          - Test

      - You can also TRANSFER OWNERSHIP of a report to any user with access to the data source and data source FILTER. ?? When you transfer ownership of a report that's shared with other users, those users continue to have access to the transferred report.

    Custom Report Sharing

      - When you change a shared report, other users can see the results of your changes immediately.

      - When you copy a custom report, Workday sets the sharing option to Don't share report definition on the copy of the report. You can change the sharing options on the Share tab of your custom report.

    Report Performance

      - You can improve report performance by:

          - Filtering out instances of the PRIMARY business object or of RELATED business objects that you don't need. ??
          - Only using INDEXED data sources and indexed fields. ??
          - Minimizing the number of CALCULATED FIELDS.

    Report Filtering

      - You can filter your report by:

          - PROMPTING the user for filter values when running the report. ??
          - Setting up filters and SUBFILTERS in the report definition.
          - Setting up FACET filters so that the user can INTERACTIVELY filter report results. ??

      - The report first applies filters to instances of the primary business object that are in the data source or data source filter. The report then applies any sub filters to instances of related business objects. ??

## 參考資料 {: #reference }

  - [Reporting and Analytics • Reader • Administrator Guide](https://doc.workday.com/reader/HAJOEAaClxziA9ljvuBqZA/root)

Workday Objects:

  - Create Custom Report
  - Create Custom Report Transformation
  - All Custom Reports
