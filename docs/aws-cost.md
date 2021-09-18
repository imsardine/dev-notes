---
title: AWS / Cost
---
# [AWS](aws.md) / Cost

  - [The Ultimate Guide To Reserved Instance And AWS Savings Plan \| by Totalcloud\.io \| Medium](https://medium.com/@Totalcloudio/cf2b3c27bdc6) (2020-04-15)

      - AWS launched Elastic Cloud Compute in August 2006, back then there was only one pricing model. Aiming for flexibility, the pay-per-use model that we come to now call, “ON-DEMAND” was the sole way to purchase the various resources AWS offered. Back then there was only one region and one size but as the instance families and the available regions grew, Amazon rolled out a new pricing model in 2009. RESERVED iNSTANCES.

      - RIs saved users billions of dollars with its 1-YEAR OR 3-YEAR COMMITMENT plans. However, while it did save money, the very concept of RIs was at odds with many of the ideas associated with AWS services. The core promise given to AWS users was flexibility and elasticity of resources.

        Limiting yourself to a fixed price resource over time takes away the capacity to utilize any number of services with the possibility of ELASTIC ADJUSTMENTS.

        這裡的 fixed price resource 是指 size 跟 region 都不能換??

      - Amazon went through hoops by bringing up new features like SELLING UNWANTED RIs and purchasing CONVERTIBLE RIs to fix the lack of freedom its customers have. But such roundabout strategies came with purchase complexities and management complications. Despite all this, RIs were still successful as users were attracted to their discounted pricing.

        With the cloud market filled with cloud management tools, many enterprises found the management of RIs, Spot?? and On-Demand services easier to handle. Some organizations paid little heed to the benefits of adjusting specifications strictly for organizational needs.

    Introducing AWS Savings Plan

      - Addressing all of these constraints, AWS announced on the November of 2019, an entirely new discount program that maintains the flexibility and elasticity of its resources but also guarantees lower pricing and longer user commitments, On paper, AWS savings plan is a great introduction, but the two main challenges it faces come from its consumers being unaware of how to take advantage of it or being at odds because they already use Reserved Instances.

        注意 "Savings" 後面有跟著 s"。

      - Hopefully, by the end of this guide, you’d not only have the full picture on how AWS savings plans work but also what your next would be if you already have other cost-saving plans in hand.

    What is the AWS Savings plan?

      - With AWS Savings plan, users commit to spending A SPECIFIC PRICE PER HOUR OVER A FIXED PERIOD OF TIME. In return, AWS offers substantial discounts against On-Demand rates for EC2 instances and the Fargate container service. Any consumption above the committed amount is charged at On-Demand rates.

      - The purchasing process is far simpler when it comes to AWS Savings plan because of how it allows users to be MORE FLEXIBLE WITH THE RESOURCE SPECIFICATIONS. Purchasing a RI requires about 8 components to be determined whereas you only need 5 for a Savings Plan.

        AWS Savings Plan:

          - The type of savings plan -- EC2 Insntace Savings Plan or Compute Savings Plan
          - The commitment duration -- one year or three year
          - Payment -- all upfront, partial upfront, or no upfront
          - The region (Exclusive to EC2 instance plan)
          - The instance family (Exclusive to EC2 instance plan)

        Resreved Instance: (多了 size, OS, tenancy 要固定下來)

          - The type of reserved instance -- Standard or Convertible
          - The commitment duration -- one year or three year
          - Payment -- all upfront, partial upfront, or no upfront
          - Region
          - Instance family
          - Size
          - Operating system
          - Tenancy??

      - The longer the commitment, the higher the discount. And for customers that choose to pay all upfront will have the benefit of further discounts. Customers can choose the payment commitment such as a minimum of $0.001 per hour per year and then LAYER MULTIPLE SAVINGS PLANS TOGETHER.

        So for example, a customer can follow up on an instance that is about to have its discount expired with more Savings plans or you can split your savings plans according to which instance requires more utilization. ??

      - As mentioned earlier, there are two types of Savings Plan you can choose from. AWS EC2 Instance Savings plan or Compute Savings plan. The two plans, similar to RI and convertible RIs differentiate themselves by offering MORE DISCOUNTS FOR LESS FLEXIBILITY.

    What is the EC2 Instance Savings Plan?

      - EC2 Instance Savings plan can offer discounts up to 72% as that of the On-Demand rate depending on the term of commitment, the payment option used, and the instance family has chosen. The restriction is that you can only use the plan on specific EC2 instances, family and region. You can, however, change the size, OS, and tenancies without losing the plan.

    Standard RIs vs EC2 Instance Savings Plan

      - Both Standard RIs and EC2 Instance Savings Plan are the more restricted options within their respective discount programs. They aim to offer more discounts for fewer liberties.

        EC2 Instance Savings Plan:

          - Fixed factors: Family and Region-specific
          - Flexible factors: Can change OS, Size, and Tenancy
          - Capacity Reservation: Cannot reserve capacity (You can apply a workaround where you set On-Demand Capacity Reservations and apply a Savings Plan discount on it to gain its benefits.)

        Standard RIs:

          - Fixed factors: Family and Region-specific
          - Flexible factors: Will need to purchase additional RIs for making adjustments
          - Capacity Reservation: Can assign RIs to specific Availability Zones in order to resrve capacity

    What is the AWS Compute Savings Plan?

      - For a smaller discount of up to 66%, Compute Savings plan offers more freedom of choice than its counterpart. With the most obvious feature being the plan extension across EC2 and Fargate services. Along with that, you are given freedom of region, instance family and migrated services (for example, if a container service is moved to Fargate).

    Convertible RIs vs Compute Savings Plan

      - Compute Savings plan is a better option than Convertible RIs because of less purchase complexity and improved flexibility which is the main selling point of convertible RIs.

        Compute Savins Plan:

          - Flexibility: Can change specifications
          - Discount allocation: Automatic discount across all components
          - Capacity Reservation: Cannot reserve capacity (You can apply a workaround where you set On-Demand Capacity Reservations and apply a Savings Plan discount on it to gain its benefits.)
          - Service support: Fargate supported

        Convertable RIs:

          - Flexibility: Can change specifications
          - Discount allocation: Manual adjustments
          - Capacity Reservation: Can assign RIs to specific Availablity Zones in order to reserve capacity
          - Service support: Elasticache, RDS and Redshift supported

        在這之前都在講 EC2，為何突然冒出 Elasticache, RDS 等，這些沒有 RI 嗎??

    The drawbacks of Savings Plan

      - You can’t purchase any savings plan for ECS, RDS, Redshift and other services.
      - There are no options to resell underutilized Savings Plans so your purchases must be careful.
      - Once you are past your Savings Plan limits, you will be charged On-Demand prices.
      - No capacity reservations

      - The discounts aren’t actually better than Reserved Instances, most of the time, they are the same and sometimes, they are lower.

        這裡是在比較??

    When to choose between Savings Plan and Reserved instances

      - The best way to choose between these two options is to answer two questions. How PREDICTABLE are your resources? And how many varieties of services are you using?
      - If your resources are not going to be changing its region, size, etc at all then you DON’T NECESSARILY need a savings plan. This doesn’t mean you can’t benefit from one but that is under certain circumstances.

      - If you have an EC2 instance that is predictable,

          - You will need reserved instances if its capacities will be reserved
          - You will need Savings Plan if it will be RUNNING CONTINUOUSLY WITH HEAVY UTILIZATION

      - Similarly, you can choose a Compute Savings plan instead of Convertible RIs to reduce the management overhead of the resources.
      - If you are running all your projects on Fargate, then Savings Plan is your DEFINITIVE choice. However, for customers with Elasticache, RDS, Redshift or container services, you can’t really benefit from the Savings Plan. So all these additional services still require RIs for lower prices.

## Reserved Instance

  - [Amazon EC2 Reserved Instances](https://aws.amazon.com/ec2/pricing/reserved-instances/) #ril

## Savings Plan

  - [What is a Savings Plan? \- Savings Plans](https://docs.aws.amazon.com/savingsplans/latest/userguide/what-is-savings-plans.html) #ril
  - [How to Purchase a Savings Plan- A 5-step Guide - The Ultimate Guide To Reserved Instance And AWS Savings Plan \| by Totalcloud\.io \| Medium](https://medium.com/@Totalcloudio/cf2b3c27bdc6#b376) #ril
