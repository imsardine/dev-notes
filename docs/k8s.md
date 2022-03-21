# Kubernetes (K8s)

  - [Kubernetes](https://kubernetes.io/)

      - Production-Grade Container Orchestration -- Automated container deployment, scaling, and management.
      - Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.

      - It GROUPS containers that make up an application into LOGICAL UNITS for easy management and DISCOVERY.

        Kubernetes builds upon 15 years of experience of running PRODUCTION WORKLOADS at Google, combined with best-of-breed ideas and practices from the community.

      - Planet Scale -- Designed on the same principles that allows Google to run billions of containers a week, Kubernetes can scale without increasing your ops team.
      - Never Outgrow (長大了便不再適用) -- Whether testing locally or running a global enterprise, Kubernetes flexibility grows with you to deliver your applications consistently and easily no matter how complex your need is.
      - Run K8s Anywhere -- Kubernetes is open source giving you the freedom to take advantage of on-premises, hybrid, or public cloud infrastructure, letting you effortlessly MOVE WORKLOADS TO WHERE IT MATTERS TO YOU.

    Kubernetes Features

      - Automated rollouts and rollbacks

        Kubernetes PROGRESSIVELY ROLLS OUT changes to your application or its configuration, while monitoring application health to ensure it DOESN’T KILL ALL YOUR INSTANCES AT THE SAME TIME.

        If something goes wrong, Kubernetes will rollback the change for you. Take advantage of a growing ecosystem of deployment solutions.

      - Service discovery and load balancing

        No need to modify your application to use an unfamiliar SERVICE DISCOVERY MECHANISM. Kubernetes gives Pods their own IP addresses and a single DNS name for a set of Pods, and can load-balance across them.

        以前這段文字裡的 Pod 是 "container"，那 container 跟 Pod 是什麼關係??

        類 Docker Compose 裡 `docker-compose scale` 在做的事，當同一個 servcie 有多個 container 時，透過 service name 會自動分配到其中一個 container，自動做 load-balance。

      - Storage orchestration

        Automatically mount the storage system of your choice, whether from local storage, a public cloud provider such as GCP or AWS, or a network storage system such as NFS, iSCSI, Gluster, Ceph, Cinder, or Flocker.

      - Secret and configuration management

        Deploy and update secrets and application configuration without rebuilding your image and without exposing secrets in your STACK CONFIGURATION.

        本來 secrets/configuration 就不該寫在 image 裡；感覺 secret 與 configuration 的處理方式很不一樣?? secret 平常是存放在哪?

      - Automatic bin packing

        Automatically places containers based on their resource requirements and other constraints, while not sacrificing availability. Mix critical and best-effort workloads in order to drive up utilization and save even more resources.

        可以參考 [Bin packing problem \- Wikipedia](https://en.wikipedia.org/wiki/Bin_packing_problem) 瞭解 bin packing (如何把大箱子塞滿滿) 的概念

      - Batch execution

        In addition to services, Kubernetes can manage your batch and CI workloads, replacing containers that fail, if desired.

      - IPv4/IPv6 dual-stack

        Allocation of IPv4 and IPv6 addresses to Pods and Services.

        Pod 跟 service 又有什麼不同??

      - Horizontal scaling

        Scale your application up and down with a simple command, with a UI, or automatically based on CPU usage.

        Kubernetes 有 UI??

      - Self-healing

        Restarts containers that fail, replaces and reschedules containers when nodes die, kills containers that don’t respond to your USER-DEFINED HEALTH CHECK, and doesn’t ADVERTISE them to clients until they are READY TO SERVE.

        啟動完成，確定 ready to serve 後才開始接 request。

      - Designed for extensibility

        Add features to your Kubernetes cluster without changing upstream source code.

  - [What is Kubernetes? \| Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)

      - Kubernetes is a portable, extensible, open-source platform for managing CONTAINERIZED WORKLOADS and services, that facilitates both DECLARATIVE CONFIGURATION and automation. It has a large, rapidly growing ecosystem. Kubernetes services, support, and tools are widely available.

        整份文件都沒提到 Docker，兩者是什麼關係? Kubernetes 面對的是不同的 container runtime (pull & run container images)，而 Docker 是個 development toolset，背後用的 container runtime 是 containerd，眾多支援的 container runtime 之一。

      - The name Kubernetes originates from Greek, meaning helmsman (舵手) or pilot. K8s as an abbreviation results from counting the eight letters between the "K" and the "s".

        Google open-sourced the Kubernetes project in 2014. Kubernetes combines over 15 years of Google's experience running production workloads at scale with best-of-breed ideas and practices from the community.

    Going back in time

      - Let's take a look at why Kubernetes is so useful by going back in time.

        ![](https://d33wubrfki0l68.cloudfront.net/26a177ede4d7b032362289c6fccd448fc4a91174/eb693/images/docs/container_evolution.svg)

      - Traditional deployment era:

        Early on, organizations ran applications on physical servers. There was no way to define RESOURCE BOUNDARIES for applications in a physical server, and this caused resource allocation issues. For example, if multiple applications run on a physical server, there can be instances where one application would take up most of the resources, and as a result, the other applications would underperform.

        A solution for this would be to run each application on a different physical server. But this did not scale as resources were underutilized, and it was expensive for organizations to maintain many physical servers.

      - Virtualized deployment era:

        As a solution, virtualization was introduced. It allows you to run multiple Virtual Machines (VMs) on a single physical server's CPU. Virtualization allows applications to be isolated between VMs and provides a level of security as the information of one application cannot be freely accessed by another application.

        Virtualization allows better utilization of resources in a physical server and allows better scalability because an application can be added or updated easily, reduces hardware costs, and much more. With virtualization you can present a set of physical resources as a CLUSTER OF DISPOSABLE VIRTUAL MACHINES.

        Each VM is a FULL MACHINE running all the components, including its own operating system, on top of the virtualized hardware.

        VM 裡的 OS，除了有 security patch 的問題，也會讓程式可能跟 infra 產生相依。

      - Container deployment era: Containers are similar to VMs, but they have RELAXED ISOLATION PROPERTIES to share the Operating System (OS) among the applications. Therefore, containers are considered LIGHTWEIGHT.

        Similar to a VM, a container has its own filesystem, share of CPU, memory, process space, and more. As they are decoupled from the underlying infrastructure, they are PORTABLE across clouds and OS distributions.

      - Containers have become popular because they provide extra benefits, such as:

          - Agile application creation and deployment: increased ease and efficiency of container image creation compared to VM image use.
          - Continuous development, integration, and deployment: provides for reliable and frequent container image build and deployment with quick and efficient rollbacks (due to IMAGE IMMUTABILITY).

          - DEV AND OPS SEPARATION OF CONCERNS: create application container images at build/release time RATHER THAN DEPLOYMENT TIME, thereby decoupling applications from infrastructure.

            因此 CI/CD 設計上，build image 的動作應該要與 deployment 分開；為 image 標上 tag 時才觸發 deployment 是個不錯的方式。

            若開發時期仍用 Docker，其實開發人員不需要懂 Kubernetes?? 但為何 Docker 會有 [Build Docker Kubernetes\-ready Applications on your Desktop \| Docker](https://www.docker.com/products/kubernetes) 的說法?

          - Observability: not only surfaces OS-level information and metrics, but also application health and other signals.

          - Environmental consistency across development, testing, and production: Runs the same on a laptop as it does in the cloud.

            避開 "it works on my machines" 的問題。

          - Cloud and OS distribution portability: Runs on Ubuntu, RHEL, CoreOS, on-premises, on major public clouds, and anywhere else.
          - APPLICATION-CENTRIC management: Raises the level of ABSTRACTION from running an OS on virtual hardware to running an application on an OS using logical resources.
          - Loosely coupled, distributed, elastic, liberated micro-services: applications are broken into smaller, independent pieces and can be deployed and managed dynamically – not a monolithic stack running on one big SINGLE-PURPOSE MACHINE.
          - Resource isolation: PREDICTABLE application performance.
          - Resource utilization: high efficiency and density.

    Why you need Kubernetes and what it can do

      - Containers are a good way to bundle and run your applications. In a production environment, you need to manage the containers that run the applications and ensure that there is no downtime. For example, if a container goes down, another container needs to start. Wouldn't it be easier if this behavior was handled by a system?

      - That's how Kubernetes comes to the rescue! Kubernetes provides you with a framework to run distributed systems resiliently.

        It takes care of scaling and failover for your application, provides DEPLOYMENT PATTERNS, and more. For example, Kubernetes can easily manage a CANARY DEPLOYMENT for your system.

        要實現 canary deployment，service 設計上要做什麼調整?? 否則同時間有多個版本在服務。

      - Kubernetes provides you with:

          - Service discovery and load balancing

            Kubernetes can expose a container using the DNS name or using their own IP address. If traffic to a container is high, Kubernetes is able to load balance and distribute the network traffic so that the deployment is stable.

          - Storage orchestration

            Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.

          - Automated rollouts and rollbacks

            You can describe the DESIRED STATE for your deployed containers using Kubernetes, and it can change the ACTUAL STATE to the desired state at a CONTROLLED RATE.

            For example, you can automate Kubernetes to create new containers for your deployment, remove existing containers and adopt all their resources to the new container.

          - Automatic bin packing

            You provide Kubernetes with a cluster of NODES that it can use to run containerized tasks. You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.

          - Self-healing

            Kubernetes restarts containers that fail, replaces containers, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.

          - Secret and configuration management

            Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, and SSH keys. You can deploy and update secrets and application configuration without rebuilding your container images, and without exposing secrets in your stack configuration.

    What Kubernetes is not

      - Kubernetes is not a traditional, all-inclusive PaaS (Platform as a Service) system. Since Kubernetes OPERATES AT THE CONTAINER LEVEL rather than at the hardware level, it provides some generally applicable features common to PaaS offerings, such as deployment, scaling, load balancing, and lets users integrate their logging, monitoring, and alerting solutions.

        However, Kubernetes is not monolithic, and these DEFAULT SOLUTIONS ARE OPTIONAL AND PLUGGABLE. Kubernetes provides the building blocks for building developer platforms, but preserves user choice and flexibility where it is important.

      - Kubernetes:

          - Does not limit the types of applications supported. Kubernetes aims to support an extremely diverse variety of workloads, including stateless, stateful, and data-processing workloads. If an application can run in a container, it should run great on Kubernetes.

            stateless, stateful, and data-processing workloads 處理上有什麼差別??

          - Does not deploy source code and does not build your application. Continuous Integration, Delivery, and Deployment (CI/CD) workflows are determined by organization cultures and preferences as well as technical requirements.

          - Does not provide application-level services, such as middleware (for example, message buses), data-processing frameworks (for example, Spark), databases (for example, MySQL), caches, nor cluster storage systems (for example, Ceph??) as built-in services.

            Such components can run on Kubernetes, and/or can be accessed by applications running on Kubernetes through portable mechanisms, such as the Open Service Broker??.

          - Does not dictate logging, monitoring, or alerting solutions. It provides some integrations as PROOF OF CONCEPT, and mechanisms to collect and export METRICS.
          - Does not provide nor mandate a configuration language/system (for example, Jsonnet??). It provides a declarative API that may be TARGETED by arbitrary forms of declarative specifications. ??

          - Does not provide nor adopt any comprehensive MACHINE configuration, maintenance, management, or self-healing systems.

            強調 Kubernetes 運作在 container/application level 而非 hardware/OS level，不會管 machine 層級的事??

          - Additionally, Kubernetes is not a mere orchestration system. In fact, it eliminates the need for orchestration.

            The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C. In contrast, Kubernetes comprises a set of independent, composable control processes that continuously DRIVE THE CURRENT STATE TOWARDS THE PROVIDED DESIRED STATE.

            It shouldn't matter how you get from A to C. Centralized control is also not required. This results in a system that is easier to use and more powerful, robust, resilient, and extensible.

  - [Kubernetes \- Wikipedia](https://en.wikipedia.org/wiki/Kubernetes)

## 跟 Docker 的關係? {: #docker }

  - [Don't Panic: Kubernetes and Docker \| Kubernetes](https://kubernetes.io/blog/2020/12/02/dont-panic-kubernetes-and-docker/) (2020-12-02)

      - Kubernetes is deprecating Docker as a CONTAINER RUNTIME after v1.20.

        > Docker support in the kubelet is now deprecated and will be removed in a future release. The kubelet uses a module called "dockershim" which implements CRI support for Docker and it has seen maintenance issues in the Kubernetes community. We encourage you to evaluate moving to a container runtime that is a full-fledged implementation of CRI (v1alpha1 or v1 compliant) as they become available. (#94624, @dims) [SIG Node]
        >
        > -- [Deprecation - kubernetes/CHANGELOG\-1\.20\.md at master · kubernetes/kubernetes](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md#deprecation)

      - You do not need to panic. It’s not as dramatic as it sounds.

        TL;DR Docker as an underlying runtime is being deprecated in favor of runtimes that use the Container Runtime Interface (CRI) created for Kubernetes. Docker-produced images will continue to work in your cluster with ALL RUNTIMES, as they always have.

        聽起來早期 Kubernetes 只支援 Docker (daemon) 做為 container runtime，後來拉出一層 CRI，符合 CRI 要求的 container runtime 都支援。

      - If you’re an end-user of Kubernetes, not a whole lot will be changing for you. This doesn’t mean the death of Docker, and it doesn’t mean you can’t, or shouldn’t, use Docker as a DEVELOPMENT TOOL anymore. Docker is still a useful tool for building containers, and the images that result from running `docker build` can still run in your Kubernetes cluster.

        其他 container runtime 支援 Docker 以外的 development tools??

      - If you’re using a MANAGED Kubernetes service like GKE, EKS, or AKS (which defaults to containerd) you will need to make sure your WORKER NODES are using a supported container runtime before Docker support is removed in a future version of Kubernetes.

        > ContainerD is now Generally Available (GA) and the default container runtime for cluster created or upgraded to kubernetes v1.19+. See more here.
        >
        > -- [Release Release 2020\-11\-16 · Azure/AKS](https://github.com/Azure/AKS/releases/tag/2020-11-16)

        If you have node customizations you may need to update them based on your environment and runtime requirements. Please work with your service provider to ensure proper upgrade testing and planning.

      - If you’re rolling your own clusters, you will also need to make changes to avoid your clusters breaking. At v1.20, you will get a deprecation warning for Docker.

        When Docker runtime support is removed in a future release (currently planned for the 1.22 release in late 2021) of Kubernetes it will no longer be supported and you will need to switch to one of the other compliant container runtimes, like containerd or CRI-O.

        Just make sure that the runtime you choose supports the DOCKER DAEMON configurations you currently use (e.g. logging).

        聽起來 Docker daemon 沒打算實作 CRI??

    So why the confusion and what is everyone freaking out about?

      - We’re talking about TWO DIFFERENT ENVIRONMENTS here, and that’s creating confusion. Inside of your Kubernetes cluster, there’s a thing called a container runtime that’s responsible for PULLING AND RUNNING YOUR CONTAINER IMAGES.

        Docker is a popular choice for that runtime (other common options include containerd and CRI-O), but Docker was not designed to be EMBEDDED inside Kubernetes, and that causes a problem.

      - You see, the thing we call “Docker” ISN’T ACTUALLY ONE THING—it’s an entire TECH STACK, and one part of it is a thing called “containerd,” which is a high-level container runtime by itself.

        Docker is cool and useful because it has a lot of UX enhancements that make it really easy for humans to interact with WHILE WE’RE DOING DEVELOPMENT WORK, but those UX enhancements aren’t necessary for Kubernetes, because it isn’t a human.

        原來 Docker 重新包裝過的 toolset，從開發人員的 UX 出發，docker daemon 背後真正的 container runtime 是 containerd，`docker build` 的產出嚴格來說不叫 Docker image，而是 OCI-compliant image。

        > The Docker daemon relies on a OCI compliant runtime (invoked via the `containerd` daemon) as its interface to the Linux kernel namespaces, cgroups, and SELinux.
        >
        > By default, the Docker daemon automatically starts `containerd`
        >
        > -- [Docker runtime execution options - dockerd \| Docker Documentation](https://docs.docker.com/engine/reference/commandline/dockerd/#docker-runtime-execution-options)

      - As a result of this HUMAN-FRIENDLY ABSTRACTION LAYER, your Kubernetes cluster has to use another tool called Dockershim to get at what it really needs, which is containerd.

        That’s not great, because it gives us another thing that has to be maintained and can possibly break. What’s actually happening here is that Dockershim is being removed from Kubelet as early as v1.23 release, which REMOVES SUPPORT FOR DOCKER AS A CONTAINER RUNTIME as a result.

        You might be thinking to yourself, but if containerd is included in the Docker stack, why does Kubernetes need the Dockershim?

      - Docker isn’t compliant with CRI, the Container Runtime Interface. If it were, we wouldn’t need the SHIM (填隙用木片), and this wouldn’t be a thing. But it’s not the end of the world, and you don’t need to panic—you just need to change your container runtime from Docker to another supported container runtime.

      - One thing to note: If you are relying on the underlying docker socket (`/var/run/docker.sock`) as part of a workflow within your cluster today, moving to a different runtime will break your ability to use it.

        This pattern is often called Docker in Docker. There are lots of options out there for this specific use case including things like kaniko, img, and buildah.

        若只在開發階段用到 dind，為什麼要有kaniko, img, buildah 這些替代方案?? 在 build time 也利用 Kubernetes cluster 的話 ...

    What does this change mean for developers, though? Do we still write Dockerfiles? Do we still build things with Docker?

      - This change addresses a different environment than most folks use to interact with Docker. The Docker installation you’re using in development is UNRELATED to the Docker runtime inside your Kubernetes cluster.

        若 Docker daemon 背後是用 containerd，為何會有 "unrelated to the Docker runtime inside your Kubernetes cluster" 的說法??

      - It’s confusing, we understand. As a developer, Docker is still useful to you in all the ways it was before this change was announced. The image that Docker produces ISN’T REALLY A DOCKER-SPECIFIC IMAGE—it’s an OCI (Open Container Initiative) image.

        Any OCI-COMPLIANT IMAGE, regardless of the tool you use to build it, will look the same to Kubernetes. Both containerd and CRI-O know how to pull those images and run them. This is why we have a standard for what containers should look like.

        但不只 OCI，Kubernetes 透過 CRI 支援 OCI-compliant 與 CoreOS Rkt 等不同的 conainer runtime。

      - So, this change is coming. It’s going to cause issues for some, but it isn’t catastrophic, and generally it’s a good thing. Depending on how you interact with Kubernetes, this could mean nothing to you, or it could mean a bit of work.

        In the long run, it’s going to MAKE THINGS EASIER. If this is still confusing for you, that’s okay—there’s a lot going on here; Kubernetes has a lot of moving parts, and nobody is an expert in 100% of it. We encourage any and all questions regardless of experience level or complexity!

        Our goal is to make sure everyone is educated as much as possible on the upcoming changes. We hope this has answered most of your questions and soothed some anxieties!

  - [Kubernetes is deprecating Docker: what you need to know \- A Cloud Guru](https://acloudguru.com/blog/engineering/kubernetes-is-deprecating-docker-what-you-need-to-know) (2021-02-11)

## Hello, World!

  - [Create a Minikube cluster - Hello Minikube \| Kubernetes](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/#create-a-minikube-cluster) #ril
      - 把 Hello World (Node.js) 轉成 Docker image 並執行在 Minikube 上；Minikube 讓你可以在本機上執行 Kubernetes -- 建立 local cluster。
      - 假設用 OS X，必須先有 Homebrew (裝 `xhyve` driver)、Node.js、Docker
      - 用 curl 下載 `minikube` 並移動到 `/usr/local/bin`。
      - 安裝 `xhyve` driver 並修改權限。
      - 用 Homebrew 安裝 `kubectl` 可以跟 Kubernetes cluster 互動。
      - 用 `minikube start --vm-driver=xhyve` 啟動 Minikube cluster，其中 `--vm-driver=xhyve` 是指 VM driver 採用 Docker for Mac，而非預設的 VirtualBox。

    ```
$ minikube start --vm-driver=xhyve
Starting local Kubernetes v1.9.4 cluster...
Starting VM...
Downloading Minikube ISO
...
Getting VM IP address...
Moving files into cluster...
Downloading localkube binary
...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.
    ```

      - `kubectl config use-context minikube` 指定 context，也就是 `kubectrl` 要操作的 cluster；在 `~/.kube/config` 可以找到所有的 context。
      - 用 `kubectl cluster-info` 驗證 `kubectl` 可以跟 cluster 溝通：

```
$ kubectl cluster-info
Kubernetes master is running at https://192.168.64.2:8443

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

      - 用 `minikube dashboard` 開啟 Dashboard。

  - [Create a Docker container image - Hello Minikube \| Kubernetes](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/#create-a-docker-container-image)
      - 先設定好 Minikube cluster -- `kubectl` 可以跟該 cluster 互動，可以看到 dashboard。
      - 確認 Node.js 的 Hello World 執行沒問題，接著打包 Docker image。因為這裡用 Minikube 所以不用把 image 推到另一個 Docker registry，但為什麼要用 `eval $(minikube docker-env)` 來強制採用 Minikube Docker daemon? 這不是同一個嗎??
      - 用 `docker build -t hello-node:v1 .` 產生 image，接著 Minikube VM 就可以執行該 image 了。
  - [Create a Deployment - Hello Minikube \| Kubernetes](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/#create-a-deployment) 這裡開始才跟 Kubernetes 比較有關... #ril

## 新手上路 {: #getting-started }

  - [Getting started \| Kubernetes](https://kubernetes.io/docs/setup/)

      - This section lists the different ways to set up and run Kubernetes. When you install Kubernetes, choose an installation type based on: ease of maintenance, security, control, available resources, and expertise required to operate and manage a cluster.

      - You can download Kubernetes to deploy a Kubernetes cluster on a local machine, into the cloud, or for your own datacenter.

      - If you don't want to manage a Kubernetes cluster yourself, you could pick a managed service, including certified platforms. There are also other standardized and custom solutions across a wide range of cloud and bare metal environments.

    Learning environment

      - If you're learning Kubernetes, use the tools supported by the Kubernetes community, or tools in the ecosystem to set up a Kubernetes cluster on a local machine. See Install tools.

    Production environment

      - When evaluating a solution for a production environment, consider which aspects of operating a Kubernetes cluster (or abstractions) you want to manage yourself and which you prefer to hand off to a provider.
      - For a cluster you're managing yourself, the officially supported tool for deploying Kubernetes is kubeadm.

    What's next

      - Kubernetes is designed for its CONTROL PLANE?? to run on Linux. Within your cluster you can run applications on Linux or other operating systems, including Windows.

  - [Learn Kubernetes Basics \- Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/)

      - This tutorial provides a walkthrough of the basics of the Kubernetes CLUSTER ORCHESTRATION SYSTEM. Each module (課程單元) contains some background information on major Kubernetes features and concepts, and includes an INTERACTIVE online tutorial. These interactive tutorials let you manage a simple cluster and its containerized applications for yourself.

      - Using the interactive tutorials, you can learn to:

          - Deploy a containerized application on a cluster
          - Scale the deployment
          - Update the containerized application with a new software version 指 image 的版本 ??
          - Debug the containerized application

      - The tutorials use [Katacoda](https://www.katacoda.com/) to run a VIRTUAL TERMINAL in your web browser that runs Minikube, a SMALL-SCALE LOCAL DEPLOYMENT of Kubernetes that can run anywhere. There's no need to install any software or configure anything; each interactive tutorial runs directly out of your web browser itself.

    What can Kubernetes do for you?

      - With modern web services, users expect applications to be available 24/7, and developers expect to deploy new versions of those applications SEVERAL TIMES A DAY. Containerization helps package software to serve these goals, enabling applications to be released and updated in an easy and fast way WITHOUT DOWNTIME.

      - Kubernetes helps you make sure those containerized applications run where and when you want, and helps them FIND THE RESOURCES AND TOOLS THEY NEED TO WORK.

        也就是 service discovery。

      - Kubernetes is a production-ready, open source platform designed with Google's accumulated experience in container orchestration, combined with best-of-breed ideas from the community.

  - [Kubernetes Components \| Kubernetes](https://kubernetes.io/docs/concepts/overview/components/)

  - [Using Minikube to Create a Cluster \- Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/)

    Kubernetes Clusters

      - Kubernetes coordinates a highly available cluster of computers that are connected to work as a single unit. The abstractions in Kubernetes allow you to deploy containerized applications to a cluster without tying them specifically to individual machines.

        跟 Docker Swarm 的概念一樣。

      - To make use of this new model of deployment, applications need to be packaged in a way that DECOUPLES THEM FROM INDIVIDUAL HOSTS: they need to be CONTAINERIZED. Containerized applications are more flexible and available than in past deployment models, where applications were installed directly onto specific machines as PACKAGES DEEPLY INTEGRATED INTO THE HOST.

        Kubernetes automates the distribution and scheduling of application containers across a cluster in a more efficient way. Kubernetes is an open-source platform and is production-ready.

      - A Kubernetes cluster consists of two types of resources:

          - The MASTER coordinates the cluster
          - NODEs are the WORKERS that run applications

    Cluster Diagram

      - The Master is responsible for managing the cluster. The master coordinates all activities in your cluster, such as scheduling applications, maintaining applications' desired state, scaling applications, and rolling out new updates.

      - A node is a VM or a physical computer that serves as a worker machine in a Kubernetes cluster. Each node has a KUBELET, which is an AGENT for managing the node and communicating with the Kubernetes master.

        用 VM 來當 node 的效果會不好 ??

      - The node should also have tools for handling CONTAINER OPERATIONS, such as Docker or [rkt](https://coreos.com/rkt/). A Kubernetes cluster that handles production traffic should have a MINIMUM OF THREE NODES.

        Masters manage the cluster and the nodes are used to host the running applications.

      - When you deploy applications on Kubernetes, you tell the master to start the application containers. The master schedules the containers to run on the cluster's nodes. The nodes communicate with the master using the Kubernetes API, which the master exposes.

        End users can also use the Kubernetes API directly to interact with the cluster.

      - A Kubernetes cluster can be deployed on either physical or virtual machines. To get started with Kubernetes development, you can use Minikube.

        Minikube is a lightweight Kubernetes implementation that creates a VM on your local machine and deploys a simple cluster containing ONLY ONE NODE.

        Minikube is available for Linux, macOS, and Windows systems. The Minikube CLI provides basic bootstrapping operations for working with your cluster, including start, stop, status, and delete. For this tutorial, however, you'll use a provided online terminal with Minikube pre-installed.

  - [Interactive Tutorial \- Creating a Cluster \- Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-interactive/)

      - The goal of this interactive scenario is to deploy a local development Kubernetes cluster using minikube

        The online terminal is a pre-configured Linux environment that can be used as a regular console (you can type commands). Clicking on the blocks of code followed by the ENTER sign will execute that command in the terminal.

        按 Start Scenario 開始，例如在右側看到 `minikube version` 時，按下去就會在右側的 terminal 執行。

    Cluster up and running

      - We already installed minikube for you. Check that it is properly installed, by running the `minikube version` command:

            $ minikube version
            minikube version: v0.34.1

        OK, we can see that minikube is in place.

      - Start the cluster, by running the `minikube start` command:

            $ minikube start
            o   minikube v0.34.1 on linux (amd64)
            >   Configuring local host environment ...
            >   Creating none VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
            -   "minikube" IP address is 172.17.0.32
            -   Configuring Docker as the container runtime ...
            -   Preparing Kubernetes environment ...
            @   Downloading kubeadm v1.13.3
            @   Downloading kubelet v1.13.3
            -   Pulling images required by Kubernetes v1.13.3 ...
            -   Launching Kubernetes v1.13.3 using kubeadm ...
            -   Configuring cluster permissions ...
            -   Verifying component health .....
            +   kubectl is now configured to use "minikube"
            =   Done! Thank you for using minikube!

        Great! You now have a running Kubernetes cluster in your online terminal. Minikube started a virtual machine for you, and a Kubernetes cluster is now running in that VM.

        從 "Configuring Docker as the container runtime" 看來，Docker 對 Kubernetes 而言就只是一種 container runtime。

    Cluster version

      - To interact with Kubernetes during this bootcamp we’ll use the command line interface, `kubectl`. We’ll explain `kubectl` in detail in the next modules, but for now, we’re just going to look at some cluster information. To check if `kubectl` is installed you can run the `kubectl version` command:

            $ kubectl version
            Client Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:08:12Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
            Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:00:57Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}

        OK, `kubectl` is configured and we can see both the version of the CLIENT and as well as the SERVER. The client version is the `kubectl` version; the server version is the Kubernetes version installed on the master. You can also see details about the build.

        這裡的 client/server 是就 Kubernetes API，所以 client 是 `kubectl`，而 server 是 Minikube -- 對外揭露了 Kubernetes API。

    Cluster details

      - Let’s view the cluster details. We’ll do that by running `kubectl cluster-info`:

            $ kubectl cluster-info
            Kubernetes master is running at https://172.17.0.32:8443
            KubeDNS is running at https://172.17.0.32:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

            To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

      - We have a running master and a DASHBOARD. The Kubernetes dashboard allows you to view your applications in a UI. During this tutorial, we’ll be focusing on the command line for deploying and exploring our application. To view the nodes in the cluster, run the `kubectl get nodes` command:

            $ kubectl get nodes
            NAME       STATUS   ROLES    AGE    VERSION
            minikube   Ready    master   8m5s   v1.13.3

        看起來 dashboard 一樣由 master 提供。

        This command shows all nodes that can be used to host our applications. Now we have only one node, and we can see that its status is ready (it is ready to ACCEPT APPLICATIONS FOR DEPLOYMENT).

  - [Play with Kubernetes](https://labs.play-with-k8s.com/)

      - Play with Kubernetes is a labs site provided by Docker and created by Tutorius. Play with Kubernetes is a playground which allows users to run K8s clusters in a matter of seconds.

        It gives the experience of having a free Alpine Linux Virtual Machine in browser. Under the hood Docker-in-Docker (DinD) is used to give the effect of multiple VMs/PCs.

        為什麼 Kubernetes 會扯到 DinD??

      - If you want to learn more about Kubernetes, consider the Play with Kubernetes Classroom which provides more directed learning using an integrated Play with Kubernetes commandline.

    ---

      - 從 Add New Instance 開始，按 Alt-Enter 把 terminal 放到最大

        ```
                          WARNING!!!!

 This is a sandbox environment. Using personal credentials
 is HIGHLY! discouraged. Any consequences of doing so, are
 completely the user's responsibilites.

 You can bootstrap a cluster as follows:

 1. Initializes cluster master node:

 kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16

 2. Initialize cluster networking:

kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml

 3. (Optional) Create an nginx deployment:

 kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/nginx-app.yaml

                          The PWK team.

[node1 ~]$
        ```

      - 按照 terminal 裡的文字操作 ... 還是要有 Kubernetes 的基礎知識才知道要做什麼、在做什麼

  - [Using kubectl to Create a Deployment \- Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/) #ril

  - [Learn the Kubernetes Key Concepts \| IT with Passion](http://omerio.com/2015/12/18/learn-the-kubernetes-key-concepts-in-10-minutes/) (2015-12-18) #ril
  - [五分鐘 Kubernetes 有感 – Michael Hsu – Medium](https://medium.com/@evenchange4/%E4%BA%94%E5%88%86%E9%90%98-kubernetes-%E6%9C%89%E6%84%9F-e51f093cb10b) (2017-09-25) #ril
  - [GKE 系列文章\(一\) – 為什麼使用 Kubernetes \| GCP專門家](https://blog.gcp.expert/kubernetes-gke-introduction/) #ril
  - [Kubernetes Service 概念詳解 \| Kubernetes](https://tachingchen.com/tw/blog/kubernetes-service/) (2017-03-26) #ril

## Minikube ??

  - [kubernetes/minikube: Run Kubernetes locally](https://github.com/kubernetes/minikube) Minikube 在 VM 裡裡跑一個 single-node Kubernetes cluster
  - [Hello Minikube \| Kubernetes](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/) 可以在本機執行 Kubernetes，文中提到 Minikube VM ??

## Container Runtime

  - [Container runtimes \| Kubernetes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
  - [Introducing Container Runtime Interface \(CRI\) in Kubernetes \| Kubernetes](https://kubernetes.io/blog/2016/12/container-runtime-interface-cri-in-kubernetes/) (2016-12-19)
  - [An overview of the Kubernetes Container Runtime Interface \(CRI\) – IBM Developer](https://developer.ibm.com/blogs/kube-cri-overview/)

## 跟 Nomad 的差別 ?? {: #nomad }

  - [Nomad vs\. Kubernetes \- Nomad by HashiCorp](https://www.nomadproject.io/intro/vs/kubernetes.html) Kubernetes 專注在 Docker，但 Nomad 的應用更為廣泛 #ril

## 安裝設置 {: #setup }

  - [Download Kubernetes \| Kubernetes](https://kubernetes.io/releases/download/)

    Core Kubernetes components

      - Find links to download Kubernetes components (and their checksums) in the CHANGELOG files.

        Alternately, use downloadkubernetes.com to filter by version and architecture.

    kubectl

      - The Kubernetes command-line tool, `kubectl`, allows you to run commands against Kubernetes clusters.

      - You can use `kubectl` to deploy applications, inspect and manage cluster resources, and view logs. For more information including a complete list of `kubectl` operations, see the `kubectl` reference documentation.

      - `kubectl` is installable on a variety of Linux platforms, macOS and Windows. Find your preferred operating system below.

## 參考資料 {: #reference }

  - [Kubernetes](https://kubernetes.io/)
  - [kubernetes/kubernetes - GitHub](https://github.com/kubernetes/kubernetes)
  - [Kubernetes Blog](https://kubernetes.io/blog/)
  - [Download Kubernetes](https://www.downloadkubernetes.com/)

社群：

  - ['kubernetes' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/kubernetes)
  - [Kubernetes - YouTube](https://www.youtube.com/kubernetescommunity)
  - [@kubernetesio - Twitter](https://twitter.com/kubernetesio)

文件：

  - [Kubernetes Documentation](https://kubernetes.io/docs/home/)

相關：

  - [Docker](docker-k8s.md)

手冊：

  - [kubectl](https://kubernetes.io/docs/reference/kubectl/)
