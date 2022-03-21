---
title: AWS / Billing
---
# [AWS](aws.md) / Billing

  - [Set Up Consolidated Billing -- Link New Account to Payer Account - AMS Advanced Onboarding Guide](https://docs.aws.amazon.com/managedservices/latest/onboardingguide/set-up-consolidated-billing.html)

      - If you'd like your new AMS-managed?? AWS account bill to be ROLLED INTO a payment for an existing AWS ORGANIZATIONS MANAGEMENT ACCOUNT, you need to set up CONSOLIDATED BILLING and LINK THE ACCOUNTS.

        在 AWS Organizations 裡，被指定為 payer account 的 AWS account 會被標示為 management account。

        For details on Consolidated Billing read Paying Bills for Multiple Accounts Using Consolidated Billing and AWS Multi Account Billing Strategy.

      - These are the basic steps to DESIGNATE AN EXISTING ACCOUNT AS A PAYER ACCOUNT and add existing accounts to it for consolidated billing:

         1. Sign up for consolidated billing in the https://console.aws.amazon.com/billing/, and designate one of your existing accounts as a payer account. If you already have an account designated as a payer account, open the settings for that account and do the following:

         2. Add LINKED ACCOUNTS (up to 20) to your consolidated billing account family:

             a. In the Billing and Cost Management console -> Consolidated Billing (left nav pane), Manage Requests and Accounts page, choose Send a Request.

                The Send a Consolidated Billing Request page opens.

             b. Enter email addresses for the accounts that you would like to link to your payer account. If you choose, you can add notes that will be added to the email body. Click Send.

                The linked account OWNER receives a hyperlink in the email, and uses it to log in to the AWS website, and accepts or denies the request to link that account to the payer account.

        For details, see Creating and Editing Consolidated Billing Account Families.
