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

          - Storage volumes for TEMPORARY data that's deleted when you stop or terminate your instance, known as INSTANCE STORE VOLUMES

            Stop 跟 Terminate 有什麼不同??

          - PERSISTENT storage volumes for your data using Amazon Elastic Block Store (Amazon EBS), known as Amazon EBS volumes
          - Multiple physical locations for your resources, such as instances and Amazon EBS volumes, known as REGIONS and AVAILABILITY ZONES
          - A firewall that enables you to specify the protocols, ports, and source IP ranges that can reach your instances using security groups
          - Static IPv4 addresses for dynamic cloud computing, known as Elastic IP addresses
          - Metadata, known as tags, that you can create and assign to your Amazon EC2 resources
          - Virtual networks you can create that are logically isolated from the rest of the AWS cloud, and that you can optionally connect to your own network, known as VIRTUAL PRIVATE CLOUDS (VPCs)

## 新手上路 {: #getting-started }

  - [Setting Up with Amazon EC2 \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html) #ril

## Key Pair

  - [Create a Key Pair - Setting Up with Amazon EC2 \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html#create-a-key-pair)

      - AWS uses public-key cryptography to secure the login information for your instance. A Linux instance has NO PASSWORD; you use a key pair to log in to your instance securely. You specify the name of the key pair WHEN YOU LAUNCH YOUR INSTANCE, then provide the private key when you log in using SSH.

        啟動時用的 key pair? 若啟動後要讓其他人登人，就跟 AWS Key Pairs 的設定無關??

      - If you haven't created a key pair already, you can create one using the Amazon EC2 console. Note that if you plan to launch instances in multiple regions, you'll need to create a key pair in EACH REGION. For more information about regions, see Regions and Availability Zones.

    To create a key pair

     1. Sign in to AWS using the URL that you created in the previous section.

     2. From the AWS dashboard, choose EC2 to open the Amazon EC2 console.

     3. From the navigation bar, select a region for the key pair. You can select any region that's available to you, regardless of your location. However, key pairs are SPECIFIC TO A REGION; for example, if you plan to launch an instance in the US East (Ohio) Region, you must create a key pair for the instance in the US East (Ohio) Region.

     4. In the navigation pane, under NETWORK & SECURITY, choose Key Pairs.

     5. Choose Create Key Pair.

     6. Enter a name for the new key pair in the Key pair name field of the Create Key Pair dialog box, and then choose Create. Use a name that is easy for you to remember, such as your IAM user name, followed by `-key-pair`, plus the region name. For example, `me-key-pair-useast2`.

        事實上 region name 並不必要，因為各個 region 可以透過 Import Key Pair 採用相同的 key pair。

     7. The private key file is automatically downloaded by your browser. The base file name is the name you specified as the name of your key pair, and the file name extension is `.pem`. Save the private key file in a safe place.

     8. If you will use an SSH client on a Mac or Linux computer to connect to your Linux instance, use the following command to set the permissions of your private key file so that only you can read it.

            chmod 400 your_user_name-key-pair-region_name.pem

        If you do not set these permissions, then you cannot connect to your instance using this key pair. For more information, see Error: Unprotected Private Key File.

    To connect to your instance using your key pair

      - To connect to your Linux instance from a computer running Mac or Linux, you'll specify the `.pem` file to your SSH client with the `-i` option and the path to your private key.

  - [Amazon EC2 Key Pairs \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) #ril

## 參考資料 {: #reference }

  - [Amazon EC2](https://aws.amazon.com/ec2/)

文件：

  - [EC2 Documentation](https://docs.aws.amazon.com/ec2/)
