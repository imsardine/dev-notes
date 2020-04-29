# Terraform

  - [Terraform vs\. Chef, Puppet, etc\. \- Terraform by HashiCorp](https://www.terraform.io/intro/vs/chef-puppet.html)

      - Configuration management tools install and manage software on a machine that ALREADY EXISTS. Terraform is NOT a configuration management tool, and it allows existing tooling to focus on their strengths: BOOTSTRAPPING and INITIALIZING RESOURCES.

        Terraform 處理掉 Infra as Code 「雞生蛋蛋生雞」的問題。

      - Using PROVISIONERS, Terraform enables ANY configuration management tool to be used to setup a resource once it has been created.

        Terraform focuses on the HIGHER-LEVEL ABSTRACTION of the datacenter and associated services, without sacrificing the ability to use configuration management tools to do what they do best. It also embraces the same codification that is responsible for the success of those tools, making entire infrastructure deployments easy and reliable. ??

  - [Terraform by HashiCorp](https://www.terraform.io/)

      - Use Infrastructure as Code to PROVISION and manage ANY cloud, infrastructure, or service

        這呼應了 [How Terraform Works](https://www.terraform.io/#how-terraform-works) 中 "Extensible providers allow Terraform to manage a broad range of resources, including hardware, IaaS, PaaS, and SaaS services." 的說法 -- 專注在 provisioning，軟硬通吃!!

    DELIVER infrastructure as code with Terraform

      - Write declarative configuration files

          - Collaborate and share configurations
          - Evolve and version your infrastructure
          - Automate provisioning

        Define infrastructure as code to manage the FULL LIFECYCLE — create new resources, manage existing ones, and destroy those no longer needed.

      - Plan and predict changes

          - Clearly mapped resource dependencies

          - Separation of PLAN and APPLY

            呼應 [How Terraform Works](https://www.terraform.io/#how-terraform-works) 中 "Terraform CLI reads configuration files and provides an EXECUTION PLAN OF CHANGES, which can be reviewed for safety and then applied and provisioned." 的說法。

          - Consistent, repeatable WORKFLOW

        Terraform provides an elegant user experience for operators to safely and predictably make changes to infrastructure.

      - Create REPRODUCIBLE INFRASTRUCTURE

          - Reproducible production, staging, and development environments
          - Shared modules for common INFRASTRUCTURE PATTERNS
          - Combine multiple providers ?? consistently

        Terraform makes it easy to re-use configurations for similar infrastructure, helping you avoid mistakes and save time.

    Enhanced Workflow for Teams with Terraform Cloud #ril

    Terraform for Every Team

      - Organizations looking for enhanced DIVISION OF RESPONSIBILITIES or automatic POLICY ENFORCEMENT can purchase the Team and Governance upgrades for Terraform Cloud. Start for free and upgrade to suit the needs of your team as you grow.

      - Free

        Automation and collaboration features to empower individuals and small teams, including VCS integration, remote operations, and state management ??. Teams on the free plan can have up to 5 users.

        5 人的上限是來自哪裡??

  - [How Terraform Works - Terraform by HashiCorp](https://www.terraform.io/#how-terraform-works) #ril

    CLI

      - Terraform allows infrastructure to be expressed as code in a simple, human readable language called HCL (HashiCorp Configuration Language).

        Terraform CLI reads configuration files and provides an EXECUTION PLAN OF CHANGES, which can be reviewed for safety and then applied and provisioned.

      - Extensible providers allow Terraform to manage a broad range of resources, including hardware, IaaS, PaaS, and SaaS services.

          - Infrastructure as Code
          - 200+ available providers
          - Provision any infrastructure

  - [Terraform: chicken/egg problem \- Maciej Matecki \- Medium](https://medium.com/@maciejmatecki/terraform-chicken-egg-problem-7504f8ddf2fc) (2020-01-03) #ril

  - [Terraform vs CloudFormation \- Alexander Savchuk \- Medium](https://medium.com/@endofcake/terraform-vs-cloudformation-1d9716122623) (2018-07-18) #ril

## 安裝設置 {: #setup }

  - [Download Terraform \- Terraform by HashiCorp](https://www.terraform.io/downloads.html) #ril

## 參考資料 {: #reference }

  - [Terraform](https://www.terraform.io/)

文件：

  - [Terraform Documentation](https://www.terraform.io/docs/cli-index.html)
