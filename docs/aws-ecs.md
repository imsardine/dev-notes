# Amazon ECS (Elastic Container Service)

  - [Amazon ECS \- run containerized applications in production](https://aws.amazon.com/ecs/)
      - Run containerized applications in production
      - Amazon Elastic Container Service (Amazon ECS) is a highly scalable, high-performance CONTAINER ORCHESTRATION service that supports Docker containers and allows you to easily run and scale containerized applications on AWS.
      - CONTAINERS WITHOUT SERVERS - Amazon ECS features AWS Fargate, so you can deploy and manage containers without having to provision or manage servers. ... Fargate enables you to focus on building and running applications, not the underlying infrastructure.
      - CONTAINERIZE EVERYTHING - Amazon ECS lets you easily build all types of containerized applications, 跟 build image 有什麼關係??
      - SECURE - Amazon ECS launches your containers in your own Amazon VPC (Virtual Private Cloud), allowing you to use your VPC security groups and network ACLs. No compute resources are shared with other customers. 其中 network ACL 跟 inbound (internet) traffic 有關 #ril
      - How Amazon ECS works 先定義 application 用什麼 image、需要的 resource，執行環境則有 EC2 跟 Fargate 可以選。
  - [Amazon ECS Pricing \- run containers in production](https://aws.amazon.com/ecs/pricing/) 計費方式分 Fargate 跟 EC2 兩種 Launch Type Model #ril
  - [What is Amazon Elastic Container Service? \- Amazon Elastic Container Service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)

## 新手上路 {: #getting-started }

  - [ECS Console Workthrough](https://console.aws.amazon.com/ecs/home?region=us-east-1#/firstRun) #ril
      - Diagram of ECS objects and how they relate 揭露了 cluster > service > task (definition) > container (definition) 的包覆關係
      - Container definition 可以選 `httpd:2.4`、`nginx:latest`、`tomcat` 等 (都是 web server) 開始；最後一種是 custom 自訂 image，應該也要選 web 應用。
      - Task definition - A task definition is a BLUEPRINT FOR YOUR APPLICATION, and describes one or more containers through attributes. Some attributes are configured at the task level but the MAJORITY of attributes are configured per container. 為什麼大部份的設定會在最末端的 container??

        預設值 Task definition name: `first-run-task-definition`、Network mode: `awsvpc`、Task execution role: `Create new` (IAM role)、Compatibilities: `FARGATE` (launch type)、Task memory: `0.5GB (512)`、Task CPU: `0.25 vCPU (256)` 為什麼 task memory/CPU 是整個 task (多個 container) 在看??

      - Define your service - A service allows you to run and maintain a specified number (the "desired count") of simultaneous instances of a task definition in an ECS cluster.

        預設值 Service name: `nginx-service`、Number of desired tasks: `1`、Security group: `Automatically create new`、Load balancer type: `None` / `Application Load Balancer` (選後者)

        其中 Security group 的說明：A security group is created to ALLOW ALL PUBLIC TRAFFIC TO YOUR SERVICE ONLY ON THE CONTAINER PORT SPECIFIED. You can further configure security groups and network access outside of this wizard. 預設就開通了 inbound internet traffic，所謂 container port specified 是 image 自己明確 expose 的 port 嗎?? 如何改變 port mapping??

        最後一項 Load balancer type 要選 Appication Load Balancer 才會出現 Load balancer listener port: `80`、Load balancer listener protocol: `HTTP` 的項目；否則事後要 Update Service 時，Load balancing 會提示 "Elastic load balancing not configured. Load balancing settings CAN ONLY BE SET ON SERVICE CREATION."

      - Configure your cluster - The infrastructure in a Fargate CLUSTER is fully managed by AWS. Your containers run without you managing and configuring individual Amazon EC2 instances.

        預設值 Cluster name: `default` (Cluster names are unique per account per region ??)、VPC ID: `Automatically create new`、Subnets: `Automatically create new`

      - 最後按下 Create，會看到 Launch Status - We are creating resources for your service. This may take up to 10 minutes. When we're complete, you can view your service. 下面持續更新：

            Preparing service : 7 of 10 complete
            ECS resource creation pending
            Cluster hello-ecs complete
            Task definition first-run-task-definition:2 complete
            Service pending
            Additional AWS service integrations pending
            Log group /ecs/first-run-task-definition complete
            CloudFormation stack pending
            VPC pending
            Subnet 1 pending
            Subnet 2 pending
            Security group pending
            Load balancer pending

      - 最後 View Service，找到 Loader Balancer 可以看到 DNS name；但 load balancer 是 EC2 的東西??

  - [Getting Started with Amazon ECS \- run containers in production](https://aws.amazon.com/ecs/getting-started/) #ril
  - [Getting Started with Amazon ECS using Fargate \- Amazon Elastic Container Service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_GetStarted.html) #ril
  - [How to Deploy Docker Containers – AWS](https://aws.amazon.com/getting-started/tutorials/deploy-docker-containers/) behind a load balancer ... 最後會過程中建立的 resource -- ECS cluster、EC2 instance、load balanacer 全部刪掉，避免被收費 #ril

## Service, Task, Task Definition, Revision ??

  - 可以把 service 想像成 `docker-compose.yml` 的角色，裡面的內容由 task definition 定義 (每次修改都會產生新的 revision)，而 container definitions 則對應 `service:` 底下不同的 service。
      - ENVIRONMENT 的 Command 提示 `comma delimited: echo,hello world`，所以 `--provider local --basedir /tmp/` 要寫成 `--provider,local,--basedir,/tmp/`。
      - 採用 Forgate launch type 時，network mode 只能選 `awsvpc`，連帶地 port mapping 就只能宣告 container port，不能自訂 host port。

參考資料：

  - [Creating a Task Definition \- Amazon Elastic Container Service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-task-definition.html) #ril

## 參考資料

  - [Amazon ECS](https://aws.amazon.com/ecs/)

文件：

  - [Developer Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/)

手冊：

  - [API Reference](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/)
  - [AWS CLI Reference](https://docs.aws.amazon.com/cli/latest/reference/ecs/index.html)
  - [ECS CLI Reference](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI.html)
