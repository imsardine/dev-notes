---
title: Workday / FIN
---
# [Workday](workday.md) / FIN

  - [Steps: Configure Transaction Tax Rules • Financial Management • Reader • Administrator Guide](https://doc.workday.com/reader/dHvoVCr~P~0GOgQgE5Ot4A/7HGL3H0DmrEc4WNIOY2Jqw) #ril

    Prerequisites

      - Security: These domains in the Common Financial Management functional area:

          - Set Up: Company General
          - Set Up: Tax

        修改權限分別落在 Company Administrator 與 Finance Administrator。

    Context

      - When you configure transaction tax rules, Workday automatically populates the appropriate tax code and TAX APPLICABILITY when you enter TAXABLE DOCUMENTS.

        所謂 taxable document 是因為財會都是依據單據做事，而 tax applicability 是指適用哪種稅率?? 那 tax code 又是什麼??

    Steps

     1. Access the Maintain Transaction Tax Item Groups task.

        Create groups to:

          - Organize purchase, expense, and sales items.
          - Use as DIMENSIONS in transaction tax rules for ITEMS.

        When you assign items to a group, you can include only items of the selected type. In transaction tax rules for items, you can use:

          - Sales item groups for revenue rules.
          - Purchase item and expense item groups for spend rules.

     2. Access the Assign Items to Transaction Tax Item Group task.

        到這一步，只是把 item 加入不同的 transaction tax item group；接下來設定 transation tax rule 會用到。

     3. [Configure Transaction Tax Rules for Items](https://doc.workday.com/reader/dHvoVCr~P~0GOgQgE5Ot4A/3a2Bp9v4U6E5SM~E1bfbCA). #ril

     4. Access the Maintain VAT or GST Groups task.

        Create groups to:

          - Organize companies that share the same Value Added Tax (VAT) or Goods and Services Tax (GST) requirements.
          - Use as DIMENSIONS in transaction tax rules for COUNTRIES.

     5. Access the Assign Companies to VAT or GST Group task.

        Add 2 or more companies to a group. Use effective dates to track changes to the group over time.

     6. Access the Maintain Transaction Tax Statuses task.

        Create transaction tax statuses for a country, such as `EU Company VAT Registered` or `EU Company Exempt`. You can associate these tax statuses with companies, customers, and suppliers. You can then use them as a DIMENSION in transaction tax rules for COUNTRIES.

        只要輸入 name 跟 description，本質上也只是個 group??

     7. Access the Edit Company Tax Details task.

        Configure transaction tax statuses by company to use as matching criteria in transaction tax rules for countries.

        As you complete the Tax Statuses tab, consider:

          - Country: Select a country to associate with a specific tax status for the company. You can only select 1 transaction tax status per country.
          - Transaction Tax Status: Select the appropriate tax status that applies to the company.

     8. Create Suppliers.

        You can assign Tax Statuses by country to a supplier for tax defaulting.

     9. Create Customer.

        You can assign Tax Statuses by country to a customer for tax defaulting.

    10. Access the Maintain Tax Rule Exception Groups task.

        Create a group to enable exceptions for a SHIP-TO COUNTRY with tax rules different from the SHIPPING COUNTRY. You can use these exception groups to create tax rules for a country and tax rule exceptions for ship-to countries.

        只是建立 group 而已，單純提供 group name。

    11. Configure Transaction Tax Rules for Countries.

    12. Configure Transaction Tax Rule Exceptions.

    Result

      - Workday evaluates transaction tax rules in this order:

          - Transaction tax rules for countries based on VAT or GST groups. Only when it's a direct intercompany transaction and both companies are in the same VAT or GST group.
          - Transaction tax rules for countries based on exception groups.
          - General transaction tax rules for countries.
          - Transaction tax rules for items.

## 參考資料 {: #reference }

Workday Objects:

  - Edit Company Tax Details - 修改某個公司的稅務設定
