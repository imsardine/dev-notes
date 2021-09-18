---
title: Azure / Cost & Billing
---
# [Azure](azure.md) / Cost & Billing

## PAL (Partner Admin Link) {: #pal }

  - [Link a partner ID for Azure performance \- PAL or DPOR](https://support.microsoft.com/en-us/topic/link-a-partner-id-for-azure-performance-pal-or-dpor-a8eed43b-82a8-f017-3b1a-f9c8aa385d32) ([中文](https://support.microsoft.com/zh-tw/topic/a8eed43b-82a8-f017-3b1a-f9c8aa385d32)) #ril

    Why link a Partner ID

      - Customers link to a Partner ID so the Partner can help them and Partners benefit by qualifying for incentives and contributing towards their Azure performance competency or Advanced Specialization development through the Microsoft Partner Network.

      - Microsoft partners provide services that help customers achieve business and mission objectives using Microsoft products. When ACTING ON BEHALF OF THE CUSTOMER managing, configuring, and supporting Azure services, the partner users will need access to the customer’s environment.

        要從客戶這端設定與哪個 partner 連結，這樣 partner 才能存取客戶的環境，進而提供協助。

    You can link to a Partner ID in 2 ways

      - Partner Admin Link (PAL) – use for the Modern Commerce platform (Azure plan) subscriptions

        Partner Admin Link (PAL), enables Microsoft to identify and recognize partners who drive Azure customer success. Microsoft can attribute influence and Azure consumed revenue to your organization based on the account's permissions (Azure role) and scope (subscription, resource group, resource).

        Note: If the subscription moved from Enterprise Agreement (EA) to Modern Commerce platform the Partner ID is not transferred.

      - Digital Partner of Record (DPOR) – use for Enterprise Agreement (EA) subscriptions

        Digital Partner of Record associates servicing partners to a Microsoft cloud subscription. It is an online capability to attach a partner to a customer’s Microsoft online subscription. DPOR benefits the customer, the partner, and Microsoft. Partners can qualify for competencies and incentives by being the DPOR and enables them to help customers optimize their usage for desired business outcomes.

    Link to a partner ID with Partner Admin Link (PAL)

      - Use for the Modern Commerce (Azure plan) platform subscriptions

      - When you have access to the customer's resources, use the Azure portal, PowerShell, or the Azure CLI to link your Microsoft Partner Network ID (MPN ID) to your user ID or service principal. Link the partner ID in each customer tenant.

        不是有了連結才能存取客戶的環境，為什麼會有 partner 進去幫 customer 設定 PAL 的情境?

    Use the Azure portal to link to a new partner ID

     1. Go to [Link to a partner ID](https://portal.azure.com/#blade/Microsoft_Azure_Billing/managementpartnerblade) in the Azure portal.

        畫面提示 Partners help to deploy, optimize and manage services. In the section below, a partner can link their user account to their Microsoft partner ID. If you're a partner working with this customer, enter your Microsoft partner ID to link to your user account. You'll then be able to track your aggregate contributions to this customer.

        這份文件好像是寫給 partner 看的，而非 customer? 單位是 subscription?? 為什麼不用選 subscription?

     2. Sign in to the Azure portal.
     3. Enter the Microsoft partner ID. The partner ID is the Microsoft Partner Network ID for your organization. Be sure to use the Associated MPN ID shown on your partner profile.
     4. To link a partner ID for another customer, switch the directory. Under Switch directory, select your directory.

  - [Link an Azure account to a partner ID \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/link-partner-id) (2020-10-05) #ril

## 參考資料 {: #reference }

  - [Azure Cost Management + Billing | Microsoft Docs](https://docs.microsoft.com/en-us/azure/cost-management-billing/)
