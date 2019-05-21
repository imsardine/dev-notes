---
title: Docker / Swarm
---
# [Docker](docker.md) / Swarm

  - [Swarm mode overview \| Docker Documentation](https://docs.docker.com/engine/swarm/)

      - Current versions of Docker include SWARM MODE for natively managing a CLUSTER OF DOCKER ENGINES called a SWARM.

        Use the Docker CLI to create a swarm, deploy application services to a swarm, and manage swarm behavior.

        為什麼會有 mode 的說法，感覺 Docker 原本處在另一個 mode ?? 為什麼 deploy 的單位是 application services，不應該是 application stack (也就是 Compose 的 project) -- 由多個 service 組成 ??

    Feature highlights

      - Cluster management integrated with Docker Engine: Use the Docker Engine CLI to create a swarm of Docker Engines where you can deploy application services. You don’t need additional orchestration software to create or manage a swarm.

            $ docker --help | grep -i swarm
              node        Manage Swarm nodes
              swarm       Manage Swarm

      - Decentralized design: Instead of handling differentiation between NODE roles at deployment time, the Docker Engine handles any specialization at runtime. You can deploy both kinds of nodes, MANAGERs and WORKERs, using the Docker Engine. This means you can build an entire swarm from a SINGLE DISK IMAGE.

        Swarm/Cluster 裡的每個 node 雖然角色上有分 manager 跟 worker，但用的是同一套程式；這裡 disk image 是指 ??

      - Declarative service model: Docker Engine uses a DECLARATIVE approach to let you define the desired state of the various services in your APPLICATION STACK. For example, you might describe an application comprised of a web front end service with message queueing services and a database backend.

        由於 swarm 由多個 Docker Engine 組成，理論上可以佈署多個獨立的 application stack，就像 [Running Compose on a Swarm cluster](https://docs.docker.com/compose/production/#running-compose-on-a-swarm-cluster) 講的：

        > Docker Swarm, a Docker-native clustering system, exposes the same API as a single Docker host, which means you can use Compose against a Swarm instance and run your apps across multiple hosts.

        也就是一個 Swarm 從外面看來就像單一個 Docker host，一樣可以佈署多個獨立的 Compose project (由多個 service 組成)，但背後會自動在多個 Docker Engine 間調度。

      - Scaling: For each service, you can declare the number of tasks you want to run. When you scale up or down, the swarm manager automatically adapts by adding or removing tasks to maintain the desired state.

        這裡 service 跟 task 是什麼關係 ??

      - Desired state reconciliation: The swarm manager node constantly monitors the cluster state and reconciles any differences between the actual state and your expressed DESIRED STATE.

        For example, if you set up a service to run 10 REPLICAS of a container, and a worker machine hosting two of those replicas crashes, the manager creates two new replicas to replace the replicas that crashed. The swarm manager assigns the new replicas to workers that are running and available.

      - Multi-host networking: You can specify an OVERLAY NETWORK for your services. The swarm manager automatically assigns addresses to the containers on the overlay network when it initializes or updates the application. ??

      - Service discovery: Swarm manager nodes assign each service in the swarm a unique DNS name and LOAD BALANCES running containers. You can query every container running in the swarm through a DNS server embedded in the swarm.

        有時候搞不清楚，這裡的 service 指的是 application stack，還是 application stack 裡的 services ??

      - Load balancing: You can expose the ports for services to an EXTERNAL LOAD BALANCER. Internally, the swarm lets you specify how to distribute service containers between nodes. ??

      - Secure by default: Each node in the swarm enforces TLS mutual authentication and encryption to secure communications between itself and all other nodes. You have the option to use self-signed root certificates or certificates from a custom root CA.

        內部走 TLS 會不會多耗效能 ??

      - Rolling updates: At ROLLOUT TIME you can apply service updates to nodes INCREMENTALLY.

        The swarm manager lets you control the DELAY between service deployment to different sets of nodes. If anything goes wrong, you can ROLL-BACK a task to a previous version of the service.

  - [Swarm mode key concepts \| Docker Documentation](https://docs.docker.com/engine/swarm/key-concepts/) #ril

    Services and tasks

      - A SERVICE IS THE DEFINITION OF THE TASKS TO EXECUTE on the manager or worker nodes. It is the central structure of the swarm system and the primary root of user interaction with the swarm.

        When you create a service, you specify which container image to use and which commands to execute inside running containers.

      - In the REPLICATED SERVICES MODEL, the swarm manager distributes a specific number of replica tasks among the nodes based upon the scale you set in the desired state.

        For GLOBAL SERVICES, the swarm runs one task for the service on EVERY AVAILABLE NODE in the cluster.

      - A task carries a Docker container and the commands to run inside the container. It is the ATOMIC SCHEDULING UNIT of swarm.

        Manager nodes assign tasks to worker nodes according to the number of replicas set in the service scale. Once a task is assigned to a node, it cannot move to another node. It can only run on the assigned node or fail.

  - [Deploy services to a swarm \| Docker Documentation](https://docs.docker.com/engine/swarm/services/) #ril

## 新手上路 {: #getting-started }

  - [Get Started, Part 3: Services \| Docker Documentation](https://docs.docker.com/get-started/part3/) #ril
  - [Get Started, Part 4: Swarms \| Docker Documentation](https://docs.docker.com/get-started/part4/) #ril
  - [Getting started with swarm mode \| Docker Documentation](https://docs.docker.com/engine/swarm/swarm-tutorial/) #ril
