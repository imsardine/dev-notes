---
title: AWS / VPC (Virtual Private Cloud)
---
# [AWS](aws.md) / VPC (Virtual Private Cloud)

  - [Amazon Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/) #ril
      - Provision a LOGICALLY ISOLATED section of the Amazon Web Services (AWS) Cloud where you can launch AWS resources in a VIRTUAL NETWORK that you define

  - [What Is Amazon VPC? \- Amazon Virtual Private Cloud](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) #ril

## 新手上路 {: #getting-started }

  - [Create a Virtual Private Cloud (VPC) - Setting Up with Amazon EC2 \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html#create-a-vpc)

      - Amazon VPC enables you to launch AWS resources into a virtual network that you've defined, known as a virtual private cloud (VPC).

      - The NEWER EC2 instance types REQUIRE that you launch your instances in a VPC. If you have a DEFAULT VPC, you can skip this section and move to the next task, Create a Security Group.

        To determine whether you have a default VPC, open the Amazon EC2 console and look for Default VPC under Account Attributes on the dashboard. If you do not have a default VPC listed on the dashboard, you can create a nondefault VPC using the steps below.

        注意是 EC2 Console 而非 AWS Console。

    To create a nondefault VPC

     1. Open the Amazon VPC console at https://console.aws.amazon.com/vpc/.

     2. From the navigation bar, select a region for the VPC. VPCs are specific to a region, so you should select the same region in which you created your key pair.

     3. On the VPC dashboard, choose Launch VPC Wizard.

     4. On the Step 1: Select a VPC Configuration page, ensure that VPC with a Single Public Subnet ?? is selected, and choose Select.

     5. On the Step 2: VPC with a Single Public Subnet page, enter a friendly name for your VPC in the VPC name field. Leave the other default configuration settings, and choose Create VPC. On the confirmation page, choose OK.

## 參考資料 {: #reference }

 - [Amazon Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/)
