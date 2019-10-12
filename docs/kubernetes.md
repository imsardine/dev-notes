# Kubernetes (K8s)

  - [Kubernetes \| Production\-Grade Container Orchestration](https://kubernetes.io/)

      - Kubernetes (K8s) is an open-source system for automating deployment, scaling, and management of containerized applications.

      - It GROUPS containers that make up an application into LOGICAL UNITS for easy management and DISCOVERY.

        Kubernetes builds upon 15 years of experience of running production workloads at Google, combined with best-of-breed ideas and practices from the community.

      - Planet Scale -- Designed on the same principles that allows Google to run billions of containers a week, Kubernetes can scale without increasing your ops team.
      - Never Outgrow -- Whether testing locally or running a global enterprise, Kubernetes flexibility grows with you to deliver your applications consistently and easily no matter how complex your need is.
      - Run Anywhere -- Kubernetes is open source giving you the freedom to take advantage of on-premises, hybrid, or public cloud infrastructure, letting you effortlessly MOVE WORKLOADS TO WHERE IT MATTERS TO YOU.

    Kubernetes Features

      - Service discovery and load balancing

        No need to modify your application to use an unfamiliar SERVICE DISCOVERY MECHANISM. Kubernetes gives containers their own IP addresses and a single DNS name for a set of containers, and can load-balance across them.

        類 Docker Compose 裡 `docker-compose scale` 在做的事，當同一個 servcie 有多個 container 時，透過 service name 會自動分配到其中一個 container，自動做 load-balance。

    Automatic bin packing

      - Automatically places containers based on their resource requirements and other constraints, while not sacrificing availability. Mix critical and best-effort workloads in order to drive up utilization and save even more resources.

        可以參考 [Bin packing problem \- Wikipedia](https://en.wikipedia.org/wiki/Bin_packing_problem) 瞭解 bin packing 的概念。

    Storage orchestration

      - Automatically mount the storage system of your choice, whether from local storage, a public cloud provider such as GCP or AWS, or a network storage system such as NFS, iSCSI, Gluster, Ceph, Cinder, or Flocker.

    Self-healing

      - Restarts containers that fail, replaces and reschedules containers when nodes die, kills containers that don’t respond to your USER-DEFINED HEALTH CHECK, and doesn’t ADVERTISE them to clients until they are READY TO SERVE.

        啟動完成，確定 ready to serve 後才開始接 request。

    Automated rollouts and rollbacks

      - Kubernetes PROGRESSIVELY ROLLS OUT changes to your application or its configuration, while monitoring application health to ensure it DOESN’T KILL ALL YOUR INSTANCES AT THE SAME TIME.

        If something goes wrong, Kubernetes will rollback the change for you. Take advantage of a growing ecosystem of deployment solutions.

    Secret and configuration management

      - Deploy and update secrets and application configuration without rebuilding your image and without exposing secrets in your stack configuration.

        本來 secrets/configuration 就不該寫在 image 裡；感覺 secret 與 configuration 的處理方式很不一樣 ??

    Batch execution

      - In addition to services, Kubernetes can manage your batch and CI workloads, replacing containers that fail, if desired.

    Horizontal scaling

      - Scale your application up and down with a simple command, with a UI, or automatically based on CPU usage.

  - [What is Kubernetes \- Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/) #ril

  - [Kubernetes \- Wikipedia](https://en.wikipedia.org/wiki/Kubernetes) #ril

## 跟 Docker 的關係 ?? {: #docker }

  - [Kubernetes \| Docker](https://www.docker.com/kubernetes) Docker 已支援 K8s - 用 Docker 開發的 app 可以佈署到 Docker Swarm 或 Kubernetes，兩者都是基於 Moby 專案的開發成果，其中之一就是 containerd #ril
  - [Docker And Kubernetes: Friends Or Foes?](https://www.forbes.com/sites/mikekavis/2017/04/28/docker-and-kubernetes-friends-or-foes/) (2017-04-28) #ril

## 跟 Nomad 的差別 ?? {: #nomad }

  - [Nomad vs\. Kubernetes \- Nomad by HashiCorp](https://www.nomadproject.io/intro/vs/kubernetes.html) Kubernetes 專注在 Docker，但 Nomad 的應用更為廣泛 #ril

## Hello, World! ??

  - [Create a Docker container image - Hello Minikube \| Kubernetes](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/#create-a-docker-container-image)
      - 先設定好 Minikube cluster -- `kubectl` 可以跟該 cluster 互動，可以看到 dashboard。
      - 確認 Node.js 的 Hello World 執行沒問題，接著打包 Docker image。因為這裡用 Minikube 所以不用把 image 推到另一個 Docker registry，但為什麼要用 `eval $(minikube docker-env)` 來強制採用 Minikube Docker daemon? 這不是同一個嗎??
      - 用 `docker build -t hello-node:v1 .` 產生 image，接著 Minikube VM 就可以執行該 image 了。
  - [Create a Deployment - Hello Minikube \| Kubernetes](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/#create-a-deployment) 這裡開始才跟 Kubernetes 比較有關... #ril

## 新手上路 {: #getting-started }

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

  - [Interactive Tutorial \- Creating a Cluster \- Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-interactive/) #ril

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

  - [Using kubectl to Create a Deployment \- Kubernetes](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/) #ril

  - [Learn the Kubernetes Key Concepts \| IT with Passion](http://omerio.com/2015/12/18/learn-the-kubernetes-key-concepts-in-10-minutes/) (2015-12-18) #ril
  - [五分鐘 Kubernetes 有感 – Michael Hsu – Medium](https://medium.com/@evenchange4/%E4%BA%94%E5%88%86%E9%90%98-kubernetes-%E6%9C%89%E6%84%9F-e51f093cb10b) (2017-09-25) #ril
  - [GKE 系列文章\(一\) – 為什麼使用 Kubernetes \| GCP專門家](https://blog.gcp.expert/kubernetes-gke-introduction/) #ril
  - [Kubernetes Service 概念詳解 \| Kubernetes](https://tachingchen.com/tw/blog/kubernetes-service/) (2017-03-26) #ril

## Minikube ??

  - [kubernetes/minikube: Run Kubernetes locally](https://github.com/kubernetes/minikube) Minikube 在 VM 裡裡跑一個 single-node Kubernetes cluster
  - [Hello Minikube \| Kubernetes](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/) 可以在本機執行 Kubernetes，文中提到 Minikube VM ??

## 安裝設置 {: #setup }

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

## 參考資料 {: #reference }

  - [Kubernetes](https://kubernetes.io/)
