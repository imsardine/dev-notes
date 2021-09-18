# EC2 (Elastic Compute Cloud)

  - [Amazon EC2](https://aws.amazon.com/ec2/) #ril

      - Secure and resizable compute capacity in the cloud. Launch applications when needed without upfront commitments.

      - Amazon Elastic Compute Cloud (Amazon EC2) is a web service that provides secure, resizable compute capacity in the cloud. It is designed to make WEB-SCALE cloud computing easier for developers.

      - Amazon EC2’s simple web service interface allows you to obtain and configure capacity with minimal friction. It provides you with COMPLETE CONTROL of your computing resources and lets you run on Amazon’s proven computing environment.

        Amazon EC2 reduces the time required to obtain and boot new server instances to minutes, allowing you to quickly scale capacity, both up and down, as your computing requirements change. Amazon EC2 changes the economics of computing by allowing you to pay only for capacity that you actually use.

      - Amazon EC2 provides developers the tools to build FAILURE RESILIENT applications and isolate them from common failure scenarios.

  - [What Is Amazon EC2? \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)

      - Amazon Elastic Compute Cloud (Amazon EC2) provides scalable computing capacity in the Amazon Web Services (AWS) cloud. Using Amazon EC2 eliminates your need to invest in hardware up front, so you can develop and deploy applications faster.

      - You can use Amazon EC2 to launch as many or as few virtual servers as you need, configure security and networking, and manage storage. Amazon EC2 enables you to scale up or down to handle changes in requirements or spikes in popularity, reducing your need to forecast traffic.

    Features of Amazon EC2

      - Amazon EC2 provides the following features:

          - Virtual computing environments, known as INSTANCES
          - Preconfigured TEMPLATES for your instances, known as Amazon Machine Images (AMIs), that package the bits you need for your server (including the operating system and additional software)
          - Various configurations of CPU, memory, storage, and networking capacity for your instances, known as INSTANCE TYPES
          - Secure login information for your instances using KEY PAIRS (AWS stores the public key, and you store the private key in a secure place)

          - Storage volumes for TEMPORARY data that's deleted when you STOP or TERMINATE your instance, known as INSTANCE STORE VOLUMES

            Stop 跟 Terminate 有什麼不同??

          - PERSISTENT storage volumes for your data using Amazon Elastic Block Store (Amazon EBS), known as Amazon EBS volumes
          - Multiple physical locations for your resources, such as instances and Amazon EBS volumes, known as REGIONS and AVAILABILITY ZONES
          - A firewall that enables you to specify the protocols, ports, and source IP ranges that can reach your instances using security groups
          - Static IPv4 addresses for dynamic cloud computing, known as Elastic IP addresses
          - Metadata, known as tags, that you can create and assign to your Amazon EC2 resources
          - Virtual networks you can create that are logically isolated from the rest of the AWS cloud, and that you can optionally connect to your own network, known as VIRTUAL PRIVATE CLOUDS (VPCs)

## 新手上路 {: #getting-started }

  - [Getting Started with Amazon EC2](https://aws.amazon.com/ec2/getting-started/)

      - Amazon Elastic Compute Cloud (Amazon EC2) is a web service that provides secure, resizable compute capacity in the cloud. EC2 offers many options that enable you to build and run virtually any application. With these possibilities, getting started with EC2 is quick and easy to do. This page provides you the resources to get you started with EC2 instances.

    Familiarize Yourself with EC2 Instances

      - Log Into Your AWS Account

        Log into the AWS Management Console and set up your root account. If you don’t already have an account, you will be prompted to create one.

        With the AWS free tier, you can get 750 hours/month of select EC2 instances for free.

      - Launch Your Instance

        Identify which instance type is best for your workload. For your first instance, we recommend a low cost, general purpose instance type: `t2.micro`, and Amazon Machine Image (AMI): Amazon Linux 2 AMI, which are both free-tier eligible.

        Open the Amazon EC2 dashboard and choose “Launch Instance” to create your virtual machine.

      - Configure Your Instance

        Here are some guidelines when setting up your first instance:

          - Security group: Create your own firewall rules or select the default VPC security group.
          - Storage: EC2 offers both magnetic disk and SSD storage. We recommend EBS gp2 volumes to start out with. ??
          - Choose "Launch Instances" to complete the set up.

        Note: We will use the key pair file (`.pem`) later.

      - Connect to Your Instance

        After launching your instance, you can connect to it and use it the way you'd use a computer sitting in front of you. There are several ways to connect to the console depending on the operating system. We recommend using EC2 Instance Connect, an easy to use BROWSER BASED client.

          - Select the EC2 instance you created and choose "Connect.“
          - Select “EC2 Instance Connect.”
          - Choose “Connect”. A window opens, and you are connected to your instance.

      - Terminate Your Instance

        Amazon EC2 is free to start (learn more), but it is important that you terminate your instances to prevent additional charges. The EC2 instance and the DATA ASSOCIATED WILL BE DELETED.

        Terminate 會清掉資料，要保留資料則要用 Stop。

        Select the EC2 instance, choose "Actions", select "Instance State", and "Terminate".

    Tutorials

      - Installing a LAMP Web Server on Amazon Linux

        Learn how to install the Apache web server with PHP and MySQL support on your Amazon Linux instance (sometimes called a LAMP web server or LAMP stack) with this step-by-step tutorial. You can use this server to host a static website or deploy a dynamic PHP application that reads and writes information to a database.

      - Hosting a WordPress Blog with Amazon Linux

        Learn how to install, configure, and secure a WordPress blog on your Amazon Linux instance with this step-by-step tutorial. Or get started in one click with a PRE-CONFIGURED Bitnami Wordpress image by Bitnami on the AWS Marketplace.

      - Explore more 10 minute tutorials

        Learn how to remotely run commands on an EC2 Instance, train a deep learning model, and more. These step-by-step tutorials teach you different ways to innovate with EC2.

    Amazon Lightsail

      - [Lightsail](https://aws.amazon.com/lightsail/) is an easy-to-use cloud platform ideal for simpler workloads, quick deployments, and getting started on AWS. #ril

        If you’re new to the cloud, Lightsail provides you everything you need to build an application or website, plus a cost-effective, monthly plan. Watch these hands-on Lightsail tutorials to quickly bring your projects to life, and ramp up to AWS infrastructure. To decide if Lightsail or EC2 is for you, take a look at [this side-by-side comparison](https://aws.amazon.com/free/compute/lightsail-vs-ec2/) of the cloud solutions.

  - [Set up to use Amazon EC2 \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html)

    Create a key pair

      - AWS uses public-key cryptography to secure the login information for your instance. A Linux instance HAS NO PASSWORD; you use a key pair to log in to your instance securely. You specify the name of the key pair WHEN YOU LAUNCH YOUR INSTANCE, then provide the private key when you log in using SSH.

        啟動時，動態把 public key 放進 `~/.ssh/authorized_keys`?

      - If you haven't created a key pair already, you can create one using the Amazon EC2 console. Note that if you plan to launch instances in multiple Regions, you'll need to create a key pair in EACH REGION.

    To create a key pair

     1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
     2. In the navigation pane, choose Key Pairs.
     3. Choose Create key pair.

     4. For Name, enter a descriptive name for the key pair. Amazon EC2 associates the public key with the name that you specify as the key name. A key name can include up to 255 ASCII characters. It can’t include leading or trailing spaces.

        這會成為 key file 的主檔名；既然 key pair 會依 region 不同，把 region 寫在 key name 裡是不錯的做法，例如 `aws-<account>-<region>`。

        各個 region 可以透過 Import Key Pair 採用相同的 key pair，各 region 採用不同的 key 是比較好的做法?

     5. For File format, choose the format in which to save the private key. To save the private key in a format that can be used with OpenSSH, choose pem. To save the private key in a format that can be used with PuTTY, choose ppk.

     6. Choose Create key pair.

     7. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is determined by the file format you chose. Save the private key file in a safe place.

        This is the only chance for you to save the private key file.

     8. If you will use an SSH client on a macOS or Linux computer to connect to your Linux instance, use the following command to set the permissions of your private key file so that only you can read it.

            chmod 400 my-key-pair.pem

        If you do not set these permissions, then you cannot connect to your instance using this key pair. For more information, see Error: Unprotected private key file.

    Create a security group

      - Security groups act as a FIREWALL for associated instances, controlling both inbound and outbound traffic at the INSTANCE LEVEL. You must add RULES to a security group that enable you to connect to your instance from your IP address using SSH. You can also add rules that allow inbound and outbound HTTP and HTTPS access from anywhere.

      - Note that if you plan to launch instances in multiple Regions, you'll need to create a security group in EACH REGION.

      - You'll need the public IPv4 address of your local computer. The security group editor in the Amazon EC2 console can automatically detect the public IPv4 address for you.

        Alternatively, you can use the search phrase "what is my IP address" in an Internet browser, or use the following service: [Check IP](http://checkip.amazonaws.com/). If you are connecting through an Internet service provider (ISP) or from behind a firewall without a static IP address, you need to find out the range of IP addresses used by client computers.

    Create a security group > To create a security group with least privilege

     1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
     2. From the navigation bar, select a Region for the security group. Security groups are specific to a Region, so you should select the same Region in which you created your key pair.
     3. In the navigation pane, choose Security Groups.
     4. Choose Create security group.

     5. In the Basic details section, do the following:

          - Enter a name for the new security group and a description. Use a name that is easy for you to remember, such as your user name, followed by `_SG_`, plus the region name. For example, `me_SG_uswest2`.

          - In the VPC list, select your default VPC for the region.

            VPC 跟 security group 的關係是??

     6. In the Inbound rules section, create the following rules (choose Add rule for each new rule):

          - Choose HTTP from the Type list, and make sure that Source is set to Anywhere (0.0.0.0/0).
          - Choose HTTPS from the Type list, and make sure that Source is set to Anywhere (0.0.0.0/0).

          - Choose SSH from the Type list. In the Source box, choose My IP to automatically populate the field with the public IPv4 address of your local computer.

            Alternatively, choose Custom and specify the public IPv4 address of your computer or network in CIDR notation. To specify an individual IP address in CIDR notation, add the routing suffix `/32`, for example, `203.0.113.25/32`.

            If your company allocates addresses from a range, specify the entire range, such as `203.0.113.0/24`.

            Warning: For security reasons, do not allow SSH access from all IPv4 addresses (0.0.0.0/0) to your instance, except for testing purposes and only for a short time.

     7. Choose Create security group.

  - [Tutorial: Get started with Amazon EC2 Linux instances \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html) #ril

    Overview

      - The instance is an Amazon EBS-backed instance (meaning that the ROOT VOLUME is an EBS volume).

      - You can either specify the Availability Zone in which your instance runs, or let Amazon EC2 select an Availability Zone for you.

        從下圖看來，availability zone 是 security group + EBS 邏輯上的組合??

      - When you launch your instance, you secure it by specifying a key pair and security group. When you connect to your instance, you must specify the private key of the key pair that you specified when launching your instance.

        ![](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/overview_getting_started.png)

    Step 1: Launch an instance

      - You can launch a Linux instance using the AWS Management Console as described in the following procedure. This tutorial is intended to help you launch your first instance quickly, so it doesn't cover all possible options. For more information about the advanced options, see Launch an instance using the Launch Instance Wizard. For information about other ways to launch your instance, see Launch your instance.

    Step 1: Launch an instance > To launch an instance

     1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
     2. From the console dashboard, choose Launch Instance.

     3. The Choose an Amazon Machine Image (AMI) page displays a list of basic configurations, called Amazon Machine Images (AMIs), that serve as TEMPLATES for your instance.

        Select an HVM version of Amazon Linux 2. Notice that these AMIs are marked "Free tier eligible."

        > HVM: This virtualization type provides the ability to run an operating system directly on top of a virtual machine without any modification, as if it were run on the bare-metal hardware.
        >
        > -- [Linux AMI virtualization types \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/virtualization_types.html)

     4. On the Choose an Instance Type page, you can select the hardware configuration of your instance.

        Select the `t2.micro` instance type, which is selected by default. The `t2.micro` instance type is eligible for the free tier. In Regions where `t2.micro` is unavailable, you can use a `t3.micro` instance under the free tier.

     5. On the Choose an Instance Type page, choose Review and Launch to let the wizard complete the other configuration settings for you.

     6. On the Review Instance Launch page, under Security Groups, you'll see that the wizard created and selected a security group for you. You can use this security group, or alternatively you can select the security group that you created when getting set up using the following steps:

          - Choose Edit security groups.
          - On the Configure Security Group page, ensure that Select an existing security group is selected.
          - Select your security group from the list of existing security groups, and then choose Review and Launch.

     7. On the Review Instance Launch page, choose Launch.

     8. When prompted for a key pair, select Choose an existing key pair, then select the key pair that you created when getting set up.

        Warning: Don't select Proceed without a key pair. If you launch your instance without a key pair, then you can't connect to it.

        When you are ready, select the acknowledgement check box, and then choose Launch Instances.

     9. A confirmation page lets you know that your instance is launching. Choose View Instances to close the confirmation page and return to the console.

    10. On the Instances screen, you can view the status of the launch. It takes a short time for an instance to launch. When you launch an instance, its initial state is pending.

        After the instance starts, its state changes to running and it receives a public DNS name. (If the Public IPv4 DNS column is hidden, choose the settings icon in the top-right corner, toggle on Public IPv4 DNS, and choose Confirm.

    11. It can take a few minutes for the instance to be ready so that you can connect to it. Check that your instance has passed its status checks; you can view this information in the Status check column.

    Step 2: Connect to your instance

      - There are several ways to connect to your Linux instance. For more information, see Connect to your Linux instance.

    Step 3: Clean up your instance

      - After you've finished with the instance that you created for this tutorial, you should clean up by TERMINATING the instance.

        Important: Terminating an instance effectively deletes it; you can't reconnect to an instance after you've terminated it.

      - If you launched an instance that is not within the AWS Free Tier, you'll stop incurring charges for that instance as soon as the instance status changes to shutting down or terminated.

        To keep your instance for later, but not incur charges, you can STOP the instance now and then start it again later. For more information, see Stop and start your instance.

      - Amazon EC2 shuts down and terminates your instance. After your instance is terminated, it remains visible on the console for a short while, and then the entry is automatically deleted. You cannot remove the terminated instance from the console display yourself.

  - [Tutorial: Install a LAMP web server on Amazon Linux 2 \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html) #ril
  - [Tutorial: Install a LAMP web server on the Amazon Linux AMI \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html) #ril

  - [Amazon EC2 key pairs and Linux instances \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) #ril

## AMI

  - [Linux AMI virtualization types \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/virtualization_types.html) #ril

## Instance

  - [Launch your instance \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html) #ril

  - [Launch an instance using the Launch Instance Wizard \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/launching-instance.html) #ril

      - You can launch an instance using the launch instance wizard. The launch instance wizard specifies all the LAUNCH PARAMETERS required for launching an instance. Where the launch instance wizard provides a default value, you can accept the default or specify your own value. At the very least, you need to select an AMI and a KEY PAIR to launch an instance.

    Initiate instance launch

     1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
     2. In the navigation bar at the top of the screen, the current Region is displayed (for example, US East (Ohio)). Select a Region for the instance that meets your needs. This choice is important because some Amazon EC2 resources can be shared between Regions, while others can't.
     3. From the Amazon EC2 console dashboard, choose Launch instance.

    Step 1: Choose an Amazon Machine Image (AMI)

      - When you launch an instance, you must select a CONFIGURATION, known as an Amazon Machine Image (AMI). An AMI contains the information required to create a new instance. For example, an AMI might contain the software required to act as a web server, such as Linux, Apache, and your website.
      - When you launch an instance, you can either select an AMI from the list, or you can select a Systems Manager parameter that points to an AMI ID. ??
      - On the Choose an Amazon Machine Image (AMI) page, use one of two options to choose an AMI. Either search the list of AMIs, or search by Systems Manager parameter. #ril

    Step 2: Choose an Instance Type

      - On the Choose an Instance Type page, select the HARDWARE CONFIGURATION AND SIZE of the instance to launch. Larger instance types have more CPU and memory.
      - To remain eligible for the free tier, choose the t2.micro instance type (or the t3.micro instance type in Regions where t2.micro is unavailable).
      - By default, the wizard displays current generation instance types, and selects the first available instance type based on the AMI that you selected. To view previous generation instance types, choose All generations from the filter list.
      - To set up an instance quickly for testing purposes, choose Review and Launch to accept the default configuration settings, and launch your instance. Otherwise, to configure your instance further, choose Next: Configure Instance Details.

    Step 3: Configure Instance Details

      - On the Configure Instance Details page, change the following settings as necessary (expand Advanced Details to see all the settings), and then choose Next: Add Storage:
      - Network: Select the VPC, or to create a new VPC, choose Create new VPC to go the Amazon VPC console. When you have finished, return to the wizard and choose Refresh to load your VPC in the list.
      - Auto-assign Public IP: Specify whether your instance receives a public IPv4 address. By default, instances in a default subnet receive a public IPv4 address and instances in a nondefault subnet do not. You can select Enable or Disable to override the subnet's default setting. For more information, see [Public IPv4 addresses and external DNS hostnames](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses). #ril

  - [Amazon EC2 Instance Types \- Amazon Web Services](https://aws.amazon.com/ec2/instance-types/) #ril

## Connect

  - [General prerequisites for connecting to your instance \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connection-prereqs.html) #ril

    Get the user name for your instance.

      - You can connect to your instance using the user name for your user account or the DEFAULT USER NAME for the AMI that you used to launch your instance.

      - Get the user name for your user account.

        For more information about how to create a user account, see Manage user accounts on your Amazon Linux instance.

      - Get the default user name for the AMI that you used to launch your instance:

          - For Amazon Linux 2 or the Amazon Linux AMI, the user name is `ec2-user`.
          - For a CentOS AMI, the user name is `centos`.
          - For a Debian AMI, the user name is `admin`.
          - For a Fedora AMI, the user name is `ec2-user` or `fedora`.
          - For a RHEL AMI, the user name is `ec2-user` or `root`.
          - For a SUSE AMI, the user name is `ec2-user` or `root`.
          - For an Ubuntu AMI, the user name is `ubuntu`.

        Otherwise, if `ec2-user` and `root` don't work, check with the AMI provider.

        這有點算是 AMI 的 convention，跟 Vagrant default user `vagrant` 的概念很像。

  - [Connect to your Linux instance using SSH \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html) #ril

      - Get the public DNS name and user name to connect to your instance

        To find the public DNS name or IP address of your instance and the user name that you should use to connect to your instance, see Prerequisites for connecting to your instance.

    To connect to your instance using SSH

      - In a terminal window, use the `ssh` command to connect to the instance. You specify the path and file name of the private key (`.pem`), the user name for your instance, and the public DNS name or IPv6 address for your instance.

      - (Public DNS) To connect using your instance's public DNS name, enter the following command.

            ssh -i /path/my-key-pair.pem my-instance-user-name@my-instance-public-dns-name

      - (IPv6) Alternatively, if your instance has an IPv6 address, to connect using your instance's IPv6 address, enter the following command.

            ssh -i /path/my-key-pair.pem my-instance-user-name@my-instance-IPv6-address

        有 Public IPv4 address 的話，用法也一樣。

  - [Manage user accounts on your Amazon Linux instance \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/managing-users.html) #ril
  - [Connect to your Linux instance \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstances.html) #ril
  - [Stop and start your instance \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html) #ril

## VM Import/Export {: #vm-import-export }

  - [VM Import/Export](https://aws.amazon.com/ec2/vm-import/)

      - VM Import/Export enables you to easily import virtual machine images from your existing environment to Amazon EC2 instances and export them back to your on-premises environment.

        This offering allows you to leverage your existing investments in the virtual machines that you have built to meet your IT security, configuration management, and compliance requirements by bringing those virtual machines into Amazon EC2 as ready-to-use instances. You can also export imported instances back to your on-premises virtualization infrastructure, allowing you to deploy workloads across your IT infrastructure.

      - VM Import/Export is available at NO ADDITIONAL CHARGE beyond standard usage charges for Amazon EC2 and Amazon S3.

        VM 要先放到 S3 才能匯入 (轉換成 AMI)，匯出也是到 S3。

      - To import your images, use the AWS CLI or other developer tools to import a virtual machine (VM) image from your VMware environment. If you use the VMware vSphere virtualization platform, you can also use the AWS Management Portal for vCenter to import your VM.

        As part of the import process, VM Import will convert your VM into an Amazon EC2 AMI, which you can use to run Amazon EC2 instances. Once your VM has been imported, you can take advantage of Amazon’s elasticity, scalability and monitoring via offerings like Auto Scaling, Elastic Load Balancing and CloudWatch to support your imported images.

      - You can export previously imported EC2 instances using the Amazon EC2 API tools. You simply specify the target instance, virtual machine file format and a destination S3 bucket, and VM Import/Export will automatically export the instance to the S3 bucket. You can then download and launch the exported VM within your on-premises virtualization infrastructure.

      - You can import Windows and Linux VMs that use VMware ESX or Workstation, Microsoft Hyper-V, and Citrix Xen virtualization formats. And you can export previously imported EC2 instances to VMware ESX, Microsoft Hyper-V or Citrix Xen formats.

        For a full list of supported operating systems, versions, and formats, please consult the VM Import section of the [Amazon EC2 User Guide](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html). We plan to add support for additional operating systems, versions and formats in the future.

    Using the Import/Export Tools

      - VM Import/Export offers several ways to import your virtual machine into Amazon EC2. The first method is to import your VM image using the AWS CLI tools. To get started, simply:

          - Download and install the AWS Command Line Interface.

          - Verify that your VM satisfies the [prerequisites for VM Import](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html), prepare it for import, and export it from its current environment as an OVA file (or VMDK, VHD, or RAW).

            其中 prerequisites for VM Import 對要匯入的 VM 本身並沒有什麼要求，只是匯出時要選對檔案格式而已。

          - Upload the VM image to S3 using the AWS CLI. Multi-part uploads will provide improved performance. As an alternative, you can also send the VM image to AWS using the [AWS Import](https://aws.amazon.com/ec2/vm-import/) service.

            AWS Import 的連結被導向 [AWS Snowball](https://aws.amazon.com/snowball/)?

          - Once the VM image is uploaded, import your VM using the `ec2 import-image` command. As part of this command, you can specify the LICENSING MODEL and other parameters for your imported image.
          - Use the `ec2 describe-import-image-tasks` command to monitor the import progress.
          - Once your import task is completed, you can use the `ec2 run-instances` command to create an Amazon EC2 instance from the AMI generated during the import process.

      - Alternatively, if you use the VMware vSphere virtualization platform, you can use the AWS Management Portal for vCenter, which provides you a simple graphical user interface to import your virtual machines. You can [learn more about the AWS Management Portal for vCenter here](http://aws.amazon.com/ec2/vcenter-portal/).

    Licensing Model

      - In general, when you import your Microsoft Windows VM images into Amazon EC2, AWS will PROVIDE the appropriate Microsoft Windows Server license key for your imported instance. Hourly EC2 instance charges cover the Microsoft Windows Server software and underlying hardware resources.

        Your on-premise Microsoft Windows Server license key will NOT be used by EC2 and you are free to reuse it for other Microsoft Windows VM images within your on-premise environment. You are responsible for complying with the terms of your agreement(s) with Microsoft.

        好特別的模式，EC2 上的授權會另外給，原本地端的授權可以挪做他用 (或是 export 回本地端時可用)

      - If you export an Amazon EC2 instance, access to the Microsoft Windows Server license key for that instance is no longer available through AWS. You will need to reactivate and specify a new license key for the exported VM image after it is launched in your on-premise virtualization platform.

      - When you import Red Hat Enterprise Linux (RHEL) VM images, you can use LICENSE PORTABILITY for your RHEL instances. With license portability, you are responsible for maintaining the RHEL licenses for imported instances, which you can do using Red Hat Cloud Access. More information about Cloud Access subscriptions for Red Hat Enterprise Linux is available from Red Hat. Please contact Red Hat to verify your eligibility.

  - [Importing a VM as an image using VM Import/Export \- VM Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html)

    Export your VM from its virtualization environment

      - After you have prepared your VM for export, you can export it from your virtualization environment. When importing a VM as an image, you can import disks in the following formats: Open Virtualization Archive (OVA), Virtual Machine Disk (VMDK), Virtual Hard Disk (VHD/VHDX), and raw.

        注意 "importing a VM as an image, you can import disks" 中 VM、image、disk 的關係，image 指的是 AMI (Amazon Machine Image)，而 disk 指的是本地端 VM 匯出的結果，以某種檔案格式存在。

        With some virtualization environments, you would export to Open Virtualization Format (OVF), which typically includes one or more VMDK, VHD, or VHDX files, and then package the files into an OVA file.

        VirtualBox 6.1 支援 OVF 0.9, 1.0, 2.0。

    Import your VM as an image

      - After exporting your VM from your virtualization environment, you can import it to Amazon EC2. The import process is the same regardless of the origin of the VM.

    Import your VM as an image > Prerequisites

      - Create an Amazon S3 bucket for storing the exported images or choose an existing bucket. The bucket must be in the Region where you want to import your VMs.

      - Create an IAM role named `vmimport`. For more information, see [Required service role](https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role).

        若沒建立這個 role，執行 `ec2 import-image` 時，會出現下面的錯誤：

            An error occurred (InvalidParameter) when calling the ImportImage operation: The service role vmimport provided does not exist or does not have sufficient permissions

    Import your VM as an image > Upload the image to Amazon S3

      - Upload your VM image file to your Amazon S3 bucket using the upload tool of your choice.

    Import your VM as an image > Import the VM

      - After you upload your VM image file to Amazon S3, you can use the AWS CLI to import the image. These tools accept either the Amazon S3 bucket and path to the file or a URL for a public Amazon S3 file. Private Amazon S3 files require a presigned URL.

      - Example 1: Import an image with a single disk

        Use the following command to import an image with a single disk.

            aws ec2 import-image --description "My server VM" --disk-containers "file://C:\import\containers.json"

        注意輸出的 `ImportTaskId`，查看 import 的進度會用到。

        The following is an example `containers.json` file.

            [
              {
                "Description": "My Server OVA",
                "Format": "ova",
                "UserBucket": {
                    "S3Bucket": "my-import-bucket",
                    "S3Key": "vms/my-server-vm.ova"
                }
            }]

    Monitor an import image task

      - Use the `describe-import-image-tasks` command to return the status of an import task.

            aws ec2 describe-import-image-tasks --import-task-ids import-ami-1234567890abcdef0

      - After the import image task is completed, the output includes the ID of the AMI. The following is example output that includes `ImageId`.

            {
                "ImportImageTasks": [
                    {
                        "ImportTaskId": "import-ami-01234567890abcdef",
                        "ImageId": "ami-1234567890EXAMPLE",
                        "SnapshotDetails": [
                            {
                                "DiskImageSize": 705638400.0,
                                "Format": "ova",
                                "SnapshotId": "snap-111222333444aaabb"
                                "Status": "completed",
                                "UserBucket": {
                                    "S3Bucket": "my-import-bucket",
                                    "S3Key": "vms/my-server-vm.ova"
                                }
                            }
                        ],
                        "Status": "completed"
                    }
                ]
            }

    Cancel an import image task

      - If you need to cancel an active import task, use the `cancel-import-task` command.

            aws ec2 cancel-import-task --import-task-id import-ami-123

  - [Importing a VM as an instance using VM Import/Export \- VM Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-instance-import.html)

      - Important: We strongly recommend that you import VMs as Amazon Machine Images (AMI) instead of instances.

      - You can use VM Import/Export to import virtual machine (VM) images from your virtualization environment to Amazon EC2 as instances. Subsequently, you can export the VM images from the instance back to your virtualization environment. This enables you to leverage your investments in the VMs that you have built to meet your IT security, configuration management, and compliance requirements by bringing them into Amazon EC2.

        跳過 AMI 的階段，直接變成 EC2 instance?

  - [Importing a disk as a snapshot using VM Import/Export \- VM Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-import-snapshot.html)

      - VM Import/Export enables you to import your disks as Amazon EBS snapshots. After the snapshot is created, you can create an EBS volume from the snapshot, and then attach the volume to an EC2 instance.

        這裡的 snapshot 跟 VM 的 snapshot 無關??

        An imported snapshot has an arbitrary volume ID that should not be used for any purpose.

  - [VM Migration on AWS\. Uploading a VirtualBox VM to an Amazon… \| by Rupesh Deshmukh \| Petabytz \| Medium](https://medium.com/petabytz/vm-migration-on-aws-d596cec31539) (2019-07-17)

  - [What is VM Import/Export? \- VM Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/what-is-vmimport.html)

    ![AWS Region > VPC > Imported Instance](https://miro.medium.com/max/1022/0*PCapAdhHAxO9FM95.png)

  - [VM Import/Export Requirements \- VM Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html)

    Required service role

      - VM Import/Export requires a role to perform certain operations on your behalf. You must create a service role named `vmimport` with a trust relationship policy document that allows VM Import/Export to ASSUME THE ROLE, and you must attach an IAM policy to the role.

      - You must enable AWS Security Token Service (AWS STS) in any Region where you plan to use VM Import/Export. For more information, see [Activating and deactivating AWS STS in an AWS Region](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html#sts-regions-activate-deactivate).

        IAM > Account Settings > Security Token Service (STS)

    Required service role > To create the service role

     1. Create a file named `trust-policy.json` on your computer. Add the following policy to the file:

            {
               "Version": "2012-10-17",
               "Statement": [
                  {
                     "Effect": "Allow",
                     "Principal": { "Service": "vmie.amazonaws.com" },
                     "Action": "sts:AssumeRole",
                     "Condition": {
                        "StringEquals":{
                           "sts:Externalid": "vmimport"
                        }
                     }
                  }
               ]
            }

     2. Use the `create-role` command to create a role named `vmimport` and grant VM Import/Export access to it. Ensure that you specify the full path to the location of the `trust-policy.json` file that you created in the previous step, and that you include the `file://` prefix as shown the following example:

            aws iam create-role --role-name vmimport --assume-role-policy-document "file://C:\import\trust-policy.json"

     3. Create a file named `role-policy.json` with the following policy, where `disk-image-file-bucket` is the bucket for DISK IMAGES and `export-bucket` is the bucket for exported images:

            {
               "Version":"2012-10-17",
               "Statement":[
                  {
                     "Effect": "Allow",
                     "Action": [
                        "s3:GetBucketLocation",
                        "s3:GetObject",
                        "s3:ListBucket" 
                     ],
                     "Resource": [
                        "arn:aws:s3:::disk-image-file-bucket",
                        "arn:aws:s3:::disk-image-file-bucket/*"
                     ]
                  },
                  {
                     "Effect": "Allow",
                     "Action": [
                        "s3:GetBucketLocation",
                        "s3:GetObject",
                        "s3:ListBucket",
                        "s3:PutObject",
                        "s3:GetBucketAcl"
                     ],
                     "Resource": [
                        "arn:aws:s3:::export-bucket",
                        "arn:aws:s3:::export-bucket/*"
                     ]
                  },
                  {
                     "Effect": "Allow",
                     "Action": [
                        "ec2:ModifySnapshotAttribute",
                        "ec2:CopySnapshot",
                        "ec2:RegisterImage",
                        "ec2:Describe*"
                     ],
                     "Resource": "*"
                  }
               ]
            }

     4. (Optional) To import resources encrypted using an AWS KMS key from AWS Key Management Service, add the following permissions to the `role-policy.json` file.

            {
              "Effect": "Allow",
              "Action": [
                "kms:CreateGrant",
                "kms:Decrypt",
                "kms:DescribeKey",
                "kms:Encrypt",
                "kms:GenerateDataKey*",
                "kms:ReEncrypt*"
              ],
              "Resource": "*"
            }

        If you use a KMS key other than the default provided by Amazon EBS, you must grant VM Import/Export permission to the KMS key if you enable Amazon EBS encryption by default or enable encryption on an import operation. You can specify the Amazon Resource Name (ARN) of the KMS key as the resource instead of `*`.

     5. (Optional) To attach license configurations to an AMI, add the following License Manager permissions to the `role-policy.json` file.

            {
              "Effect": "Allow",
              "Action": [
                "license-manager:GetLicenseConfiguration",
                "license-manager:UpdateLicenseSpecificationsForResource",
                "license-manager:ListLicenseSpecificationsForResource"
              ],
              "Resource": "*"
            }

     6. Use the following `put-role-policy` command to attach the policy to the role created above. Ensure that you specify the full path to the location of the `role-policy.json` file.

            aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document "file://C:\import\role-policy.json"

## IP Addressing

  - [Amazon EC2 instance IP addressing \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html) #ril

      - Amazon EC2 and Amazon VPC support both the IPv4 and IPv6 addressing protocols. By default, Amazon EC2 and Amazon VPC use the IPv4 addressing protocol; you can't disable this behavior. When you create a VPC, you must specify an IPv4 CIDR block (a range of private IPv4 addresses). You can optionally assign an IPv6 CIDR block to your VPC and subnets, and assign IPv6 addresses from that block to instances in your subnet.

        IPv6 addresses are REACHABLE OVER THE INTERNET. For more information about IPv6, see IP Addressing in Your VPC in the Amazon VPC User Guide.

## 參考資料 {: #reference }

  - [Amazon EC2](https://aws.amazon.com/ec2/)

文件：

  - [EC2 Documentation](https://docs.aws.amazon.com/ec2/)
