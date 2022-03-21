---
title: Docker / Kubernetes (K8s)
---
# [Docker](docker.md) / Kubernetes (K8s)

  - [Build Docker Kubernetes\-ready Applications on your Desktop \| Docker](https://www.docker.com/products/kubernetes)

    What is Kubernetes?

      - Kubernetes is an open source orchestration system for automating the management, placement, scaling and routing of containers that has become popular with developers and IT OPERATIONS teams in recent years.

        It was first developed by Google and contributed to Open Source in 2014, and is now maintained by the Cloud Native Computing Foundation (CNCF). There is an active Kubernetes community and ecosystem developing around Kubernetes with thousands of contributors and dozens of certified partners.

    Build KUBERNETES-READY applications on your desktop

      - Docker Desktop is an application for MacOS and Windows machines for the building and sharing of containerized applications and microservices.

      - Docker Desktop delivers the speed, choice, and security you need for designing and delivering these containerized applications on your desktop.

        Docker Desktop includes Docker App??, developer tools, Kubernetes, and version synchronization?? to production Docker Engines. Docker Desktop allows you to leverage certified images and templates and your choice of languages and tools.

        Docker Desktop 內建 Kubernetes，但這份文件並沒有提到 Kubernetes-ready application 跟一般的 Docker 開發有何不同??

      - Development workflows leverage Docker Hub to extend your development environment to a secure repository for rapid auto-building, continuous integration, and secure collaboration.

    Why use Kubernetes?

      - Kubernetes has become the standard orchestration platform for containers. All the major cloud providers support it, making it the logical choice for organizations looking to move more applications to the cloud.

      - Kubernetes provides a common framework to run distributed systems so development teams have consistent, immutable infrastructure FROM DEVELOPMENT TO PRODUCTION for every project. Kubernetes can manage scaling requirements, availability, failover, deployment patterns, and more.

      - Kubernetes’ capabilities include:

          - Service and process definition
          - Service discovery and load balancing
          - Storage orchestration
          - Container-level resource management
          - Automated deployment and rollback
          - Container health management
          - Secrets and configuration management

    What are the advantages of Kubernetes?

      - Kubernetes has many powerful and advanced capabilities. For teams that have the skills and knowledge to get the most of it, Kubernetes delivers:

          - Availability

            Kubernetes clustering has very high fault tolerance built-in, allowing for extremely large scale operations.

          - Auto-scaling

            Kubernetes can scale up and scale down based on traffic and server load automatically.

          - Extensive Ecosystem.

            Kubernetes has a strong ecosystem around Container Networking Interface (CNI) and Container Storage Interface (CSI) and inbuilt logging and monitoring tools.

      - However, Kubernetes’ complexity is overwhelming for a lot of people jumping in for the first time. The primary early adopters of Kubernetes have been sophisticated, tribal sets of developers from larger scale organizations with a do-it-yourself culture and strong independent developer teams with the skills to “roll their own” Kubernetes.

        As the mainstream begins to look at adopting Kubernetes INTERNALLY, this approach is often what is referenced in the broader community today. But this approach MAY NOT BE RIGHT for every organization.

      - While Kubernetes has advanced capabilities, all that power comes with a price; jumping into the cockpit of a state-of-the-art jet puts a lot of power under you, but how to actually fly the thing is not obvious.

## 新手上路 {: #getting-started }

  - [Orchestration \| Docker Documentation](https://docs.docker.com/get-started/orchestration/)

      - The portability and reproducibility of a containerized process provides an opportunity to move and scale our containerized applications across clouds and datacenters. Containers effectively guarantee that those applications RUN THE SAME WAY ANYWHERE, allowing us to quickly and easily take advantage of all these environments.

        Additionally, as we scale our applications up, we need some tooling to help automate the maintenance of those applications, enable the replacement of failed containers automatically, and manage the rollout of updates and reconfigurations of those containers during their LIFECYCLE.

      - Tools to manage, scale, and maintain containerized applications are called ORCHESTRATORS, and the most common examples of these are Kubernetes and Docker Swarm.

        Docker 做為開工具，並沒有被 Kubernetes 取代，但 Kubernetes 取代了 Docker Swarm。

        Development environment deployments of both of these orchestrators are provided by Docker Desktop, which we’ll use throughout this guide to create our first orchestrated, containerized application.

    Enable Kubernetes

      - In order to confirm that Kubernetes is up and running, create a text file called `pod.yaml` with the following content:

            apiVersion: v1
            kind: Pod
            metadata:
              name: demo
            spec:
              containers:
              - name: testpod
                image: alpine:3.5
                command: ["ping", "8.8.8.8"]

        This describes a pod with a single container, isolating a simple ping to 8.8.8.8.

      - In a terminal, navigate to where you created `pod.yaml` and create your pod:

            $ kubectl apply -f pod.yaml
            pod/demo created

      - Check that your pod is up and running:

            $ kubectl get pods
            NAME   READY   STATUS    RESTARTS   AGE
            demo   1/1     Running   0          18m

      - Check that you get the logs you’d expect for a ping process:

            $ kubectl logs demo
            PING 8.8.8.8 (8.8.8.8): 56 data bytes
            64 bytes from 8.8.8.8: seq=0 ttl=37 time=12.825 ms
            64 bytes from 8.8.8.8: seq=1 ttl=37 time=9.422 ms
            64 bytes from 8.8.8.8: seq=2 ttl=37 time=9.852 ms
            64 bytes from 8.8.8.8: seq=3 ttl=37 time=9.701 ms
            ...

      - Finally, tear down your test pod:

            $ kubectl delete -f pod.yaml
            pod "demo" deleted

## 疑難排解 {: #troubleshooting }

### SchemaError(io.k8s.apimachinery.pkg.apis.meta.v1.APIResourceList): invalid object doesn't have additional properties

跟著 [Enable Kubernetes - Orchestration \| Docker Documentation](https://docs.docker.com/get-started/orchestration/#enable-kubernetes) 執行 `kubectl apply -f pod.yaml` 時，出現下面的錯誤：

```
$ kubectl apply -f pod.yaml
error: SchemaError(io.k8s.apimachinery.pkg.apis.meta.v1.APIResourceList): invalid object doesn't have additional properties
```

可能是 Kubernetes client 與 server 兩邊版本不一致的關係：

```
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"10", GitVersion:"v1.10.0", GitCommit:"fc32d2f3698e36b93322a3465f63a14e9f0eaead", GitTreeState:"clean", BuildDate:"2018-03-27T00:13:02Z", GoVersion:"go1.9.4", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.3", GitCommit:"ca643a4d1f7bfe34773c74f79527be4afd95bf39", GitTreeState:"clean", BuildDate:"2021-07-15T20:59:07Z", GoVersion:"go1.16.6", Compiler:"gc", Platform:"linux/amd64"}

$ ls -l /usr/local/bin/kubectl*
lrwxr-xr-x  1 jeremykao  admin   43 Mar 31  2018 kubectl -> ../Cellar/kubernetes-cli/1.10.0/bin/kubectl
lrwxr-xr-x  1 jeremykao  staff   55 Dec  2  2018 kubectl.docker -> /Applications/Docker.app/Contents/Resources/bin/kubectl
```

看似 Enable Kubernetes 時，因為 `/usr/bin/local/kubectl` 已存在，所以 Docker Desktop 沒有直接 overwrite (但仍有 `kubectl.docker` 可以用)。

將 Homebrew `kubectl` 套件移除，再重新 Enable Kubernetes 即可：

```
$ brew uninstall kubectl
Uninstalling /usr/local/Cellar/kubernetes-cli/1.10.0... (178 files, 52.8MB)

$ ls -l /usr/local/bin/kubectl*
lrwxr-xr-x  1 root  admin  55 Sep 25 12:11 /usr/local/bin/kubectl -> /Applications/Docker.app/Contents/Resources/bin/kubectl
lrwxr-xr-x  1 root  admin  55 Sep 25 12:11 /usr/local/bin/kubectl.docker -> /Applications/Docker.app/Contents/Resources/bin/kubectl

$ kubectl apply -f pod.yaml
pod/demo created
```

參考資料：

  - [kubectl \- Kubernetes create deployment unexpected SchemaError \- Stack Overflow](https://stackoverflow.com/questions/55417410)

## 安裝設置 {: #setup }

  - [Deploy on Kubernetes \| Docker Documentation](https://docs.docker.com/desktop/kubernetes/)

      - Docker Desktop includes a standalone Kubernetes server and client, as well as Docker CLI integration that runs on your machine. The Kubernetes server runs locally within your Docker instance, is NOT CONFIGURABLE, and is a SINGLE-NODE CLUSTER.

        就是 minikube??

      - The Kubernetes server runs within a Docker container on your local system, and is only for local testing. Enabling Kubernetes allows you to DEPLOY YOUR WORKLOADS IN PARALLEL, on Kubernetes, Swarm, and as standalone containers. Enabling or disabling the Kubernetes server does not affect your other workloads.

        Docker 做為一個開發工具，額外支援了 Kubernetes，跟原有獨立的 container (包括 Docker Compose)、Swarm 並存。

    Prerequisites

      - The Kubernetes client command `kubectl` is included and configured to connect to the local Kubernetes server. If you have already installed `kubectl` and pointing to some other environment, such as `minikube` or a GKE cluster, ensure you change the CONTEXT so that `kubectl` is pointing to `docker-desktop`:

            kubectl config get-contexts
            kubectl config use-context docker-desktop

      - If you installed `kubectl` using Homebrew, or by some other method, and experience conflicts, remove `/usr/local/bin/kubectl`.

        在 Docker Desktop 啟用 Kubernetes 時，`kubectl` 也是安裝到 `/usr/local/bin/kubectl`。

    Enable Kubernetes

      - To enable Kubernetes support and install a standalone instance of Kubernetes running AS A DOCKER CONTAINER, go to Preferences > Kubernetes and then click Enable Kubernetes.

        第一之啟動時遇到錯誤 (Failed to start)，透過 Troubleshoot > Restart Docker Desktop 再重啟一次就好了。

            $ kubectl config get-contexts
            CURRENT   NAME             CLUSTER          AUTHINFO         NAMESPACE
                      docker-desktop   docker-desktop   docker-desktop
            *         minikube         minikube         minikube

            $ kubectl config use-context docker-desktop
            Switched to context "docker-desktop".

            $ kubectl config get-contexts
            CURRENT   NAME             CLUSTER          AUTHINFO         NAMESPACE
            *         docker-desktop   docker-desktop   docker-desktop
                      minikube         minikube         minikube

        By default, Kubernetes containers are HIDDEN FROM COMMANDS like `docker service ls`, because managing them manually is not supported. To see these INTERNAL CONTAINERS, select Show system containers (advanced). Most users do not need this option.

        這些 internal containers 多達 14 個!!

            $docker ps
            CONTAINER ID   IMAGE                    COMMAND                  CREATED         STATUS         PORTS     NAMES
            2d47a6863051   296a6d5035e2             "/coredns -conf /etc…"   7 minutes ago   Up 7 minutes             k8s_coredns_coredns-558bd4d5db-tbsv9_kube-system_41b00883-c153-4a6e-b2c3-dde9d43e20f5_0
            5996260ee791   adb2816ea823             "/usr/local/bin/kube…"   7 minutes ago   Up 7 minutes             k8s_kube-proxy_kube-proxy-6mr8m_kube-system_9fd20f7d-6927-4e41-ad94-03a91852632a_0
            ...
            77e79fd26f64   k8s.gcr.io/pause:3.4.1   "/pause"                 8 minutes ago   Up 8 minutes             k8s_POD_kube-apiserver-docker-desktop_kube-system_94a4e22e7ee9bc62400a41e70eee2896_0

      - Click Apply & Restart to save the settings and then click Install to confirm. This instantiates images required to run the Kubernetes server as containers, and installs the `/usr/local/bin/kubectl` command on your machine.

      - When Kubernetes is enabled and running, an additional status bar item displays at the bottom right of the Docker Desktop Settings dialog.

        Docker Desktop 3.6.0 是位在左下方，跟 Docker 的 status 並列。

        The status of Kubernetes shows in the Docker menu and the context points to `docker-desktop`.

        Context 也可以透過 Docker Desktop 的 menu 切換。

      - Upgrade Kubernetes: Docker Desktop DOES NOT upgrade your Kubernetes cluster automatically after a new update. To upgrade your Kubernetes cluster to the latest version, select Reset Kubernetes Cluster.

    Use the kubectl command

      - Kubernetes integration provides the Kubernetes CLI command at `/usr/local/bin/kubectl` on Mac and at `C:\>Program Files\Docker\Docker\Resources\bin\kubectl.exe` on Windows. This location may not be in your shell’s `PATH` variable, so you may need to type the full path of the command or add it to the `PATH`.

      - You can test the command by listing the available nodes:

            $ kubectl get nodes
            NAME             STATUS    ROLES                  AGE       VERSION
            docker-desktop   Ready     control-plane,master   21m       v1.21.3

## 參考資料 {: #reference }

  - [Kubernetes (K8s)](k8s.md)
