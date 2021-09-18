# Nomad

  - [Nomad by HashiCorp](https://www.nomadproject.io/)

      - Workload Orchestration Made Easy -- A simple and flexible workload orchestrator to deploy and manage CONTAINERS AND NON-CONTAINERIZED applications across ON-PREM AND CLOUDS at scale.

    Why Nomad?

      - Simple and Lightweight -- Single 35MB binary that integrates into existing infrastructure. Easy to operate on-prem or in the cloud with minimal overhead.
      - Flexible Workload Support -- Orchestrate applications of any type - not just containers. First class support for Docker, Windows, Java, VMs, and more.

      - Modernize Legacy Applications without Rewrite -- Bring orchestration benefits to existing services. Achieve zero downtime deployments, improved resilience, higher resource utilization, and more without containerization.

        最佳解是容器化，但不代表舊的應用就沒機會參與 orchestration。

      - Easy Federation at Scale -- Single command for multi-region, multi-cloud federation. Deploy applications globally to any region using Nomad as a single unified control plane.
      - Multi-Cloud with Ease -- One single unified workflow for deploying to bare metal or cloud environments. Enable multi-cloud applications with ease.

      - Native Integrations with Terraform, Consul, and Vault -- Nomad integrates seamlessly with Terraform, Consul and Vault for provisioning, service networking, and secrets management.

        Nomad 的重點是 workload orchestration，但 provisioning, networking, secrets 則分別由 Terraform、Consul, Vault 處理。

    Why Nomad? (舊的說法)

      - Easily Deploy Applications at Any Scale

        當提到 scale 時，就會有 monitoring，而這裡的 application 除了傳統的 standalone application，也可以是 virtualized/containerized applications。

      - A SINGLE BINARY that schedules applications and services on Linux, Windows, and Mac. It is an open source SCHEDULER that uses a DECLARATIVE JOB FILE for scheduling virtualized, containerized, and standalone applications.

        好特別的思維，只是 scheduler 就可以把 scale 做到這麼大，關鍵應該就在 declarative。

      - DECLARE JOBS: Users compose and SUBMIT HIGH-LEVEL job files. Nomad handles the scheduling and UPGRADING of the applications over time.
      - PLAN CHANGES: With built-in DRY-RUN EXECUTION, Nomad shows what scheduling decisions it will take before it takes them. Operators can approve or deny these changes to create a safe and REPRODUCIBLE WORKFLOW.

      - RUN APPLICATIONS: Nomad runs applications and ensures they KEEP RUNNING in failure scenarios. In addition to long-running services, Nomad can schedule batch jobs, distributed CRON JOBS, and parameterized jobs.

        其中 batch job 跟 cron job 有何不同?? 又 cron job 也可以是 distributed??

      - MONITOR PROGRESS: Stream logs, send signals, and interact with the file system of scheduled applications. These operator-friendly commands bring the familiar debugging tools to a SCHEDULED WORLD.

## 新手上路 {: #getting-started }

  - 雖然下載 [precompiled binary](https://www.nomadproject.io/downloads) 就可以，但搭配 Vagrant 營造一個 Nomad cluster 才不用擔心弄髒自己的機器。

---

參考資料：

  - [Manual Installation - Getting Started: Install Nomad \| Nomad \- HashiCorp Learn](https://learn.hashicorp.com/tutorials/nomad/get-started-install)

      - To simplify the getting started experience, you can download a [precompiled binary](https://www.nomadproject.io/downloads) and run it on your machine locally.

        After downloading Nomad, unzip the package. Make sure that the `nomad` binary is available on your `PATH`, before continuing with the other guides.

    Vagrant Setup (Optional)

      - Alternatively, you can use a Vagrant to set up a DEVELOPMENT ENVIRONMENT for Nomad. Vagrant is a tool for building and managing virtual machine environments.

      - You can download a `Vagrantfile` which will start a small Nomad CLUSTER. First create a new directory for your Vagrant environment.

            $ curl -O https://raw.githubusercontent.com/hashicorp/nomad/master/demo/vagrant/Vagrantfile

        Now that you have created a new directory and downloaded the Vagrantfile you must create the virtual machine with the `vagrant up` command.

            $ vagrant up

        This will take a few minutes as the base Ubuntu box must be downloaded and provisioned with both DOCKER and Nomad. Once this completes, you should see this output.

            Bringing machine 'default' up with 'virtualbox' provider...
            ==> default: Importing base box 'bento/ubuntu-18.04'...
            ...
            ==> default: Running provisioner: docker...

        At this point the Vagrant box is running and ready to go.

  - [Getting Started: Start a Nomad Agent \| Nomad \- HashiCorp Learn](https://learn.hashicorp.com/tutorials/nomad/get-started-run)

      - Nomad relies on a LONG RUNNING AGENT on every machine in the cluster.

        The agent can run either in SERVER or CLIENT MODE. The cluster servers are responsible for managing the cluster. All other agents in the cluster should be in client mode.

        A Nomad client is a very lightweight process that REGISTERS the host machine, performs HEARTBEATING, and runs the tasks that are assigned to it by the servers. The agent must be run on every NODE that is part of the cluster so that the servers can assign work to those machines.

      - In this guide, you will start the Nomad agent in DEVELOPMENT MODE. This mode is used to quickly start an agent that is acting as a client AND server to test job configurations or prototype?? interactions.

        You will also use the `nomad` command line tool to discover the status and SERVER MEMBERSHIP for your agent. Finally, you will stop the agent.

      - Warning: A single server deployment is highly discouraged as data loss is inevitable in a failure scenario. Each REGION must have at least one server, though a cluster of 3 OR 5 servers is recommended for production.

        上面 "The cluster servers are responsible for managing the cluster. All other agents in the cluster should be in client mode." 即暗示著 server 會有多台，後面 Getting Started: Clustering 也明確提到 "... for production is to run more than one server"，

        其中 cluster 跟 region 的關係是??

    Start the agent

      - Start a single Nomad agent in development mode with the `nomad agent` command. Note, this command should not be used in production as it DOES NOT PERSIST STATE.

            $ sudo nomad agent -dev

        其中 `nomad agent` 單純啟動 Nomad agent，加上 `-dev` 才會是 development mode。

        The output indicates the agent has started in both server and client mode. Wait to continue to the next section until you see the agent has ACQUIRED LEADERSHIP.

            ==> No configuration files loaded
            ==> Starting Nomad agent...
            ==> Nomad agent configuration:

                   Advertise Addrs: HTTP: 127.0.0.1:4646; RPC: 127.0.0.1:4647; Serf: 127.0.0.1:4648
                        Bind Addrs: HTTP: 127.0.0.1:4646; RPC: 127.0.0.1:4647; Serf: 127.0.0.1:4648
                            Client: true
                         Log Level: DEBUG
                            Region: global (DC: dc1)  <-- 有 region 的概念，也就是 data center
                            Server: true              <-- Client 跟 Server 同時為 true
                           Version: 0.10.4

            ==> Nomad agent started! Log data will stream in below: <-- log 直接寫在 terminal

              [DEBUG] agent.plugin_loader.docker: using client connection initialized from environment: plugin_dir=
              [DEBUG] agent.plugin_loader.docker: using client connection initialized from environment: plugin_dir=
              [INFO]  agent: detected plugin: name=raw_exec type=driver plugin_version=0.1.0
              [INFO]  agent: detected plugin: name=exec type=driver plugin_version=0.1.0
              [INFO]  agent: detected plugin: name=qemu type=driver plugin_version=0.1.0
              [INFO]  agent: detected plugin: name=java type=driver plugin_version=0.1.0
              [INFO]  agent: detected plugin: name=docker type=driver plugin_version=0.1.0
              [INFO]  nomad: raft: Initial configuration (index=1): [{Suffrage:Voter ID:127.0.0.1:4647 Address:127.0.0.1:4647}]
              [INFO]  nomad: raft: Node at 127.0.0.1:4647 [Follower] entering Follower state (Leader: "")
              [INFO]  nomad: serf: EventMemberJoin: Kaitlins-MBP.global 127.0.0.1
              [INFO]  nomad: starting scheduling worker(s): num_workers=8 schedulers=[service, batch, system, _core]    2020-03-21T12:37:19.707-0500 [INFO]  client: node registration complete
              [INFO]  nomad: adding server: server="Kaitlins-MBP.global (Addr: 127.0.0.1:4647) (DC: dc1)"
              [DEBUG] nomad: lost contact with Nomad quorum, falling back to Consul for server list
              [INFO]  client: using state directory: state_dir=/private/var/folders/92/ctgjkbzx3718ws9q0vmp3v700000gp/T/NomadClient596211523
              [ERROR] nomad: error looking up Nomad servers in Consul: error="server.nomad: unable to query Consul datacenters: Get http://127.0.0.1:8500/v1/catalog/datacenters: dial tcp 127.0.0.1:8500: connect: connection refused"
              [INFO]  client: using alloc directory: alloc_dir=/private/var/folders/92/ctgjkbzx3718ws9q0vmp3v700000gp/T/NomadClient805410758
              ...
              [WARN]  nomad: raft: Heartbeat timeout from "" reached, starting election
              [INFO]  nomad: raft: Node at 127.0.0.1:4647 [Candidate] entering Candidate state in term 2
              [DEBUG] nomad: raft: Votes needed: 1
              [DEBUG] nomad: raft: Vote granted from 127.0.0.1:4647 in term 2. Tally: 1
              [INFO]  nomad: raft: Election won. Tally: 1
              [INFO]  nomad: raft: Node at 127.0.0.1:4647 [Leader] entering Leader state
              [INFO]  nomad: cluster leadership acquired

      - The Consul datacenter error is expected on Nomad agents that do not have a local Consul agent. The development Nomad agent will be able to operate without Consul and will not impact your progress through the Getting Started guides.

        一台電腦上也太多 agent! Puppet, Nomad, Consul ...

      - Note: Typically any agent in client mode must be started with root level privilege. Nomad makes use of operating system primitives for RESOURCE ISOLATION which require elevated permissions.

        The agent will function as non-root, but certain TASK DRIVERS?? will not be available. (下一個章節就要用 root 啟動)

    Discover agent information

      - In another terminal, use `nomad node status` to view the registered nodes of the Nomad cluster.

            $ nomad node status

        與其說要看 agent information，倒不如說是 node information。Agent 只是在 cluster 中不同 node 間可以溝通的手段 (the agent must be run on every node)，但 `nomad agent` 專用於啟動 Nomad agent，所以這裡的 subcommand 是 `node` 而非 `agent`。

      - Since you only have one local agent, your output should only include one node.

            ID        DC   Name          Class   Drain  Eligibility  Status
            3f12597f  dc1  Kaitlins-MBP  <none>  false  eligible     ready

        The output shows your Node ID, its datacenter, node name, node class, DRAIN MODE?? and current status. The Node ID is a randomly generated UUID. (加 `-verbose` 可以看到完整的 UUID)

        Notice that your node is in the ready state and TASK DRAINING?? is currently off.

      - The agent is also in server mode, which means it is part of the [gossip protocol](https://www.nomadproject.io/docs/internals/gossip) used to connect all the server instances together. #ril

        You can view the members of the gossip ring using the `server members` command.

            $ nomad server members

        Since you only have one local agent, your output should only include one node.

            Name                 Address    Port  Status  Leader  Protocol  Build   Datacenter  Region
            Kaitlins-MBP.global  127.0.0.1  4648  alive   true    2         0.10.4  dc1         global

        The output shows your agent, the address it is running on, its health state, some version information, and the datacenter and region. Additional metadata can be viewed by providing the `-detailed` flag. (參數有點亂，不同於 `nomad node status` 的 `-verbose`)

    Stop the agent

      - You can use Ctrl-C, the interrupt signal, to stop the agent. By default, all signals will cause the agent to FORCEFULLY SHUTDOWN. The agent can be configured to GRACEFULLY LEAVE on either the interrupt or terminate signals.

        After interrupting the agent, the logs will show the cluster shutting down:

            ^C==> Caught signal: interrupt
              [DEBUG] http: shutting down http server
              [INFO]  agent: requesting shutdown
              [INFO]  client: shutting down
              [INFO]  client.plugin: shutting down plugin manager: plugin-type=device
              [INFO]  client.plugin: plugin manager finished: plugin-type=device
              [INFO]  client.plugin: shutting down plugin manager: plugin-type=driver
              [INFO]  client.plugin: plugin manager finished: plugin-type=driver
              [DEBUG] client.server_mgr: shutting down
              [INFO]  nomad: shutting down server
              [WARN]  nomad: serf: Shutdown without a Leave
              [INFO]  agent: shutdown complete

      - By gracefully leaving, Nomad servers notify their PEERS they intend to leave. When a server leaves, replication to that server stops.

        Nomad clients update their status to prevent further tasks from being scheduled and to start MIGRATING?? any tasks that are already assigned.

      - Start the agent again with the `sudo nomad agent -dev` command before continuing to the next section.

  - [Getting Started: Jobs \| Nomad \- HashiCorp Learn](https://learn.hashicorp.com/tutorials/nomad/get-started-jobs)

      - Jobs are the primary configuration that users interact with when using Nomad. A job is a DECLARATIVE specification of tasks that Nomad should run. Jobs have a GLOBALLY UNIQUE name, one or many task groups, which are themselves collections of one or many tasks.

        看似 task 是 job 的 runtime? 但根據下面 `example.nomad` 的結構 `job "example" { group "cache" { task "redis" { ... } } }` 來看 job -> (task) group -> task 間是階層關係。

        The format of the jobs is documented in the [JOB SPECIFICATION](https://www.nomadproject.io/docs/job-specification). They can either be specified in [HashiCorp Configuration Language](https://github.com/hashicorp/hcl) or JSON, however we recommend only using JSON when the configuration is generated by a machine.

        實務上比較常用 HCL 或 JSON?? 下面 `nomad job init` 產生的是 HCL 的寫法?

      - Note: The job created by running `nomad job init` uses the Docker task driver. To run it, you will need a Nomad client available with Docker installed. This is also true when running Nomad as a dev agent using the `-dev` flag. ??

    Running a Job

      - To get started, use the `job init` command which generates a skeleton job file:

            $ nomad job init
            Example job file written to example.nomad

        You can view the contents of this file by running `cat example.nomad`. This example job file declares a single task named `redis`, which uses the Docker driver to run the a Redis container.

            $ cat example.nomad
            job "example" {
              datacenters = ["dc1"]
              type = "service"
              ...
              group "cache" {
                task "redis" {
                  driver = "docker"
                  config {
                    image = "redis:3.2"

                    port_map {
                      db = 6379
                    }
                  }

      - The primary way you interact with Nomad is with the `job run` command. The `run` command takes a job file and registers it with Nomad. This is used both to register new jobs and to UPDATE existing jobs.

        You can register the example job now:

            $ nomad job run example.nomad
            ==> Monitoring evaluation "13ebb66d"
                Evaluation triggered by job "example"
                Allocation "883269bf" created: node "e42d6f19", group "cache"
                Evaluation within deployment: "b0a84e74"
                Evaluation status changed: "pending" -> "complete"
            ==> Evaluation "13ebb66d" finished with status "complete"

      - If the output of the `nomad job run example.nomad` command contains the following message, verify that Docker is installed on your Nomad client nodes or `-dev` agent node.

            Task Group "cache" (failed to place 1 allocation):
              * Constraint "missing drivers": 1 nodes excluded by filter

        This message indicates that there are no Nomad clients available running the Docker task driver. This is usually because Docker is stopped or not installed.

      - Anytime a job is updated, Nomad creates an EVALUATION to determine what actions need to take place. In this case, because this is a new job, Nomad has determined that an ALLOCATION should be created and has scheduled it on your local agent.

      - To inspect the status of your job you use the `status` command:

            $ nomad status example
            ID            = example
            Name          = example
            Submit Date   = 08/31/19 22:58:40 UTC
            Type          = service
            Priority      = 50
            Datacenters   = dc1
            Status        = running
            Periodic      = false
            Parameterized = false

            Summary
            Task Group  Queued  Starting  Running  Failed  Complete  Lost
            cache       0       0         1        0       0         0

            Latest Deployment
            ID          = b0a84e74
            Status      = successful
            Description = Deployment completed successfully

            Deployed
            Task Group  Desired  Placed  Healthy  Unhealthy
            cache       1        1       1        0

            Allocations
            ID        Node ID   Task Group  Version  Desired  Status   Created  Modified
            8ba85cef  171a583b  cache       0        run      running  5m ago   5m ago

        Here, the output indicates that the result of your evaluation was the creation of an allocation that is now running on the local node.

        按 [`status` 的用法](https://www.nomadproject.io/docs/commands/status) `nomad status [options] <identifier>`

        > The `status` command accepts any Nomad identifier or identifier prefix as its sole argument??. The command detects the type of the identifier and ROUTES TO the appropriate `status` command to display more detailed output.

        會自動偵測 identifier 的型態，轉呼叫對應的 subcommand，以這裡 `nomad status example` 為例，因為 `example` 是 job ID，所以結果跟 `nomad job status example` 一樣。

      - An allocation represents AN INSTANCE OF TASK GROUP PLACED ON A NODE. To inspect an allocation, use the `alloc status` command:

            $ nomad alloc status 8ba85cef
            ID                  = 8ba85cef
            Eval ID             = 13ebb66d
            Name                = example.cache[0]
            Node ID             = e42d6f19
            Job ID              = example
            Job Version         = 0
            Client Status       = running
            Client Description  = <none>
            Desired Status      = run
            Desired Description = <none>
            Created             = 5m ago
            Modified            = 5m ago
            Deployment ID       = fa882a5b
            Deployment Health   = healthy

            Task "redis" is "running"
            Task Resources
            CPU        Memory           Disk     IOPS  Addresses
            8/500 MHz  6.3 MiB/256 MiB  300 MiB  0     db: 127.0.0.1:22672

            Task Events:
            Started At     = 08/31/19 22:58:49 UTC
            Finished At    = N/A
            Total Restarts = 0
            Last Restart   = N/A

            Recent Events:
            Time                   Type        Description
            08/31/19 22:58:49 UTC  Started     Task started by client
            08/31/19 22:58:40 UTC  Driver      Downloading image redis:3.2
            08/31/19 22:58:40 UTC  Task Setup  Building Task Directory
            08/31/19 22:58:40 UTC  Received    Task received by client

        You can see that Nomad reports the state of the allocation as well as its current RESOURCE USAGE. By supplying the `-stats` flag, more detailed resource usage statistics will be reported.

        雖然 `nomad status <allocation_id>` 會轉向 `nomad alloc status <allocation_id`>，但實驗發現加上 `-stats` 這個 `alloc status` 特有的 option 後 `status` 會認不得 `-stats` 而丟出 `Error parsing arguments: "flag provided but not defined: -stats"` 的錯誤。

      - To see the logs of a task, use the `alloc logs` command:

            $ nomad alloc logs 8ba85cef redis
                             _._
                        _.-``__ ''-._
                   _.-``    `.  `_.  ''-._           Redis 3.2.1 (00000000/0) 64 bit
               .-`` .-```.  ```\/    _.,_ ''-._
              (    '      ,       .-`  | `,    )     Running in standalone mode
              |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
              |    `-._   `._    /     _.-'    |     PID: 1
               `-._    `-._  `-./  _.-'    _.-'
              |`-._`-._    `-.__.-'    _.-'_.-'|
              |    `-._`-._        _.-'_.-'    |           http://redis.io
               `-._    `-._`-.__.-'_.-'    _.-'
              |`-._`-._    `-.__.-'    _.-'_.-'|
              |    `-._`-._        _.-'_.-'    |
               `-._    `-._`-.__.-'_.-'    _.-'
                   `-._    `-.__.-'    _.-'
                       `-._        _.-'
                           `-.__.-'
            ...

        根據 `alloc logs [options] <allocation> <task>` 的用法，`alloc logs` 是查看 allocation (an instance of task group placed on a node) 下的某個 task。

    Modifying a Job

      - The definition of a job is NOT STATIC, and is meant to be updated over time. You may update a job to change the docker container, to update the application version, or to change the count of a task group to SCALE WITH LOAD.

        For now, edit the `example.nomad` file to update the `count` and set it to 3. This line is in the `cache` section around line 145.

            # The "count" parameter specifies the number of the task groups that should
            # be running under this group. This value must be non-negative and defaults
            # to 1.
            count = 3

        After modifying the job specification, use the `job plan` command to invoke a DRY-RUN of the scheduler to see what would happen if you ran the updated job:

            $ nomad job plan example.nomad
            +/- Job: "example"
            +/- Task Group: "cache" (2 create, 1 in-place update)
              +/- Count: "1" => "3" (forces create)
                  Task: "redis"

            Scheduler dry-run:
            - All tasks successfully allocated.

            Job Modify Index: 7
            To submit the job with version verification run:

            nomad job run -check-index 7 example.nomad

            When running the job with the check-index flag, the job will only be run if the
            job modify index given matches the server-side version. If the index has
            changed, another user has modified the job and the plan's results are
            potentially invalid.

      - You can see that the scheduler detected the change in count and informs us that it will cause 2 new instances to be created. The IN-PLACE UPDATE that will occur is to PUSH the updated job specification to the existing allocation and will NOT CAUSE ANY SERVICE INTERRUPTION. You can then run the job with the run command the `plan` emitted.

        By running with the `-check-index` flag, Nomad checks that the job has not been modified since the plan was run. This is useful if multiple people are interacting with the job at the same time to ensure the job hasn’t changed before you apply your modifications.

            $ nomad job run -check-index 7 example.nomad
            ==> Monitoring evaluation "93d16471"
                Evaluation triggered by job "example"
                Evaluation within deployment: "0d06e1b6"
                Allocation "3249e320" created: node "e42d6f19", group "cache"
                Allocation "453b210f" created: node "e42d6f19", group "cache"
                Allocation "883269bf" modified: node "e42d6f19", group "cache"
                Evaluation status changed: "pending" -> "complete"
            ==> Evaluation "93d16471" finished with status "complete"

        其中 Allocation "xxx" created x 2 + Allocation "xxx" modified x 1 呼應 `job plan` 講的 "2 create, 1 in-place update"。

        Because you set the count of the task group to three, Nomad created two additional allocations to GET TO THE DESIRED STATE. it is IDEMPOTENT to run the same job specification again and no new allocations will be created.

      - Now, change the job to do an application update. In this case, you will change the version of Redis you want to run. Edit the `example.nomad` file and change the Docker image from `redis:3.2` to `redis:4.0`. This is located around line 261.

            # Configure Docker driver with the image
            config {
                image = "redis:4.0"
            }

      - When running Nomad without Consul

        Because the sample job contains a Consul health check, Nomad’s deployment watcher will wait for the check to pass by default. This will cause your deployment to stall after the first allocation updates. Resolve this by adding the following attribute inside of the `update` stanza.

            health_check = "task_states"

        為什麼沒做這個調整，也沒有遇到問題? 在 development mode 下應該沒事

      - You can run `plan` again to see what will happen if you SUBMIT this change:

            $ nomad job plan example.nomad
            +/- Job: "example"
            +/- Task Group: "cache" (1 create/destroy update, 2 ignore)
              +/- Task: "redis" (forces create/destroy update)
                +/- Config {
                  +/- image:           "redis:3.2" => "redis:4.0"
                      port_map[0][db]: "6379"
                    }

            Scheduler dry-run:
            - All tasks successfully allocated.

            Job Modify Index: 1127
            To submit the job with version verification run:

            nomad job run -check-index 1127 example.nomad

            When running the job with the check-index flag, the job will only be run if the
            job modify index given matches the server-side version. If the index has
            changed, another user has modified the job and the plan's results are
            potentially invalid.

        The plan output shows us that one allocation will be updated and that the other two will be ignored. This is due to the `max_parallel` setting in the `update` stanza, which is set to `1` to instruct Nomad to perform only a single change at a time.

        Once ready, use `run` to PUSH the updated specification:

            $ nomad job run example.nomad
            ==> Monitoring evaluation "293b313a"
                Evaluation triggered by job "example"
                Evaluation within deployment: "f4047b3a"
                Allocation "27bd4a41" created: node "e42d6f19", group "cache"
                Evaluation status changed: "pending" -> "complete"
            ==> Evaluation "293b313a" finished with status "complete"

        After running, the ROLLING UPGRADE can be followed by running `nomad status` example and watching Allocations section at the bottom. A successful deployment will show an updated version number for Version, a Desired value of `run`, and a Status of `running`.

            $ nomad status example
            ID            = example
            Name          = example
            Submit Date   = 2019-10-23T18:46:04Z
            Type          = service
            Priority      = 50
            Datacenters   = dc1
            Status        = running
            Periodic      = false
            Parameterized = false

            Summary
            Task Group  Queued  Starting  Running  Failed  Complete  Lost
            cache       0       0         3        0       0         0

            Latest Deployment
            ID          = b94865ff
            Status      = running
            Description = Deployment is running

            Deployed
            Task Group  Desired  Placed  Healthy  Unhealthy  Progress Deadline
            cache       3        1       0        0          2019-10-23T18:56:04Z

            Allocations
            ID        Node ID   Task Group  Version  Desired  Status   Created    Modified
            fb621b7f  b750b455  cache       2        run      running  1s ago     1s ago
            f3fbf5a8  b750b455  cache       1        run      running  58s ago    47s ago
            77549295  b750b455  cache       1        run      running  1m43s ago  48s ago

        You can see that Nomad handled the update in three phases, only updating a single allocation in each phase and waiting for it to be healthy for `min_healthy_time` of 10 seconds before moving on to the next. The update strategy can be configured, but rolling updates makes it less complex to upgrade an application at large scale.

    Stopping a Job

      - So far you’ve created, run and modified a job. The final step in a job LIFECYCLE is stopping the job. This is done with the `job stop` command:

            $ nomad job stop example
            ==> Monitoring evaluation "6d4cd6ca"
                Evaluation triggered by job "example"
                Evaluation within deployment: "f4047b3a"
                Evaluation status changed: "pending" -> "complete"
            ==> Evaluation "6d4cd6ca" finished with status "complete"

      - When you stop a job, it creates an evaluation which is used to stop all the existing allocations. If you now query the job status, you can see it is now marked as dead (stopped), indicating that the job has been stopped and Nomad is no longer running it:

            $ nomad status example
            ID            = example
            Name          = example
            Submit Date   = 08/31/19 17:30:40 UTC
            Type          = service
            Priority      = 50
            Datacenters   = dc1
            Status        = dead (stopped)
            Periodic      = false
            Parameterized = false

            Summary
            Task Group  Queued  Starting  Running  Failed  Complete  Lost
            cache       0       0         0        0       6         0

            Latest Deployment
            ID          = f4047b3a
            Status      = successful
            Description = Deployment completed successfully

            Deployed
            Task Group  Desired  Placed  Healthy  Unhealthy
            cache       3        3       3        0

            Allocations
            ID        Node ID   Task Group  Version  Desired  Status    Created    Modified
            8ace140d  2cfe061e  cache       2        stop     complete  5m ago     5m ago
            8af5330a  2cfe061e  cache       2        stop     complete  6m ago     6m ago
            df50c3ae  2cfe061e  cache       2        stop     complete  6m ago     6m ago

        If you wanted to start the job again, you can `run` it again.

      - Stop the Nomad agent with Ctrl-C before moving on to the next section.

        接下來不會用 developement mode，因為它是同時做為 client 與 server。按 Ctrl-C 後，發現原來 `nodmad status` 背後會跟 server 溝通：

            $ nomad status
            Error querying jobs: Get "http://127.0.0.1:4646/v1/jobs": dial tcp 127.0.0.1:4646: connect: connection refused

  - [Getting Started: Clustering \| Nomad \- HashiCorp Learn](https://learn.hashicorp.com/tutorials/nomad/get-started-cluster)

      - You have started your first agent and run a job against it in development mode. This demonstrates the ease of use and the workflow of Nomad, but did not show how this could be extended to a scalable, PRODUCTION-GRADE configuration. In this step, you will create your first real cluster with MULTIPLE NODES.

        多個 node 才算 cluster，那上面將 `count` 調為 3 的動作算什麼? 不也跟 scale 有關??

    Starting the Server

      - The first step is to create the configuration file FOR THE SERVER. Either download the [file from the repository](https://raw.githubusercontent.com/hashicorp/nomad/master/demo/vagrant/server.hcl), or paste this into a file called `server.hcl`:

            # Increase log verbosity
            log_level = "DEBUG"

            # Setup data dir
            data_dir = "/tmp/server1"

            # Enable the server
            server {
                enabled = true

                # SELF-ELECT, should be 3 or 5 for production
                bootstrap_expect = 1 <-- 直接要求自己要當 leader
            }

        This is a fairly minimal server configuration file, but it is enough to start an agent in SERVER ONLY MODE and have it elected as a leader. The major change that should be made for production is to run MORE THAN ONE SERVER, and to change the corresponding `bootstrap_expect` value.

        這裡 "server only mode" 的說法，跟 agent 可以同時做為 client 跟 server 有關，例如 development mode。

      - Once the file is created, start the agent in a new tab:

            $ nomad agent -config server.hcl
            ==> WARNING: Bootstrap mode enabled! Potentially unsafe operation.
            ==> Starting Nomad agent...
            ==> Nomad agent configuration:

                            Client: false
                         Log Level: DEBUG
                            Region: global (DC: dc1)
                            Server: true
                           Version: 0.9.6

            ==> Nomad agent started! Log data will stream in below:

                [INFO] serf: EventMemberJoin: nomad.global 127.0.0.1
                [INFO] nomad: starting 4 scheduling worker(s) for [service batch _core]
                [INFO] raft: Node at 127.0.0.1:4647 [Follower] entering Follower state
                [INFO] nomad: adding server nomad.global (Addr: 127.0.0.1:4647) (DC: dc1)
                [WARN] raft: Heartbeat timeout reached, starting election
                [INFO] raft: Node at 127.0.0.1:4647 [Candidate] entering Candidate state
                [DEBUG] raft: Votes needed: 1
                [DEBUG] raft: Vote granted. Tally: 1
                [INFO] raft: Election won. Tally: 1
                [INFO] raft: Node at 127.0.0.1:4647 [Leader] entering Leader state
                [INFO] nomad: cluster leadership acquired
                [INFO] raft: Disabling EnableSingleNode (bootstrap)
                [DEBUG] raft: Node 127.0.0.1:4647 updated peer set (2): [127.0.0.1:4647]

        The output above indicates that CLIENT MODE IS DISABLED, and that this node is ONLY RUNNING AS A SERVER. This means that this server will manage state and make scheduling decisions but WILL NOT RUN ANY TASKS. Now you need some agents to run tasks.

        注意這裡 server mode 的 `nomad agent` 沒有搭配 `sudo`，但下面 client mode 就有，猜想是因為 server 單純只做 scheduling decisions，跟 resource isolation 無關，所以不需要 root level privilege。

    Starting the Clients

      - Similar to the server, you must first configure the clients. Either download the configuration for `client1` and `client2` from the [repository here](https://github.com/hashicorp/nomad/tree/master/demo/vagrant), or paste the following into `client1.hcl`:

            # Increase log verbosity
            log_level = "DEBUG"

            # Setup data dir
            data_dir = "/tmp/client1"

            # Give the agent a unique name. Defaults to hostname
            name = "client1"

            # Enable the client
            client {
                enabled = true

                # For demo assume we are talking to server1. For production,
                # this should be like "nomad.service.consul:4647" and a system
                # like Consul used for SERVICE DISCOVERY.
                servers = ["127.0.0.1:4647"] <-- 把 server 寫死了，搭配 Consul 才能做到動態
            }

            # Modify our port to avoid a collision with server1 <-- Server 只有一台為何會衝突??
            ports {
                http = 5656
            }

      - Copy the file you just created to create another one similar to it called `client2.hcl`. Change the `data_dir` to be `/tmp/client2`, the `name` to `client2`, and the `http` port to `5657`. Once you have created both `client1.hcl` and `client2.hcl`, open a tab for each and start the agents (the process for the first agent is shown below but be sure to do the same for the second agent):

            $ sudo nomad agent -config client1.hcl
            ==> Starting Nomad agent...
            ==> Nomad agent configuration:

                            Client: true
                         Log Level: DEBUG
                            Region: global (DC: dc1)
                            Server: false
                           Version: 0.9.6

            ==> Nomad agent started! Log data will stream in below:

                [DEBUG] client: applied fingerprints [host memory storage arch cpu]
                [DEBUG] client: available drivers [docker exec]
                [DEBUG] client: node registration complete
                ...

        This output indicates the agent is running in CLIENT MODE ONLY. This agent will be available to run tasks but will not participate in managing the cluster or making SCHEDULING DECISIONS.

      - The `node status` command should indicate that both nodes are in the `ready` state:

            $ nomad node status
            ID        DC   Name     Class   Drain  Eligibility  Status
            fca62612  dc1  client1  <none>  false  eligible     ready
            c887deef  dc1  client2  <none>  false  eligible     ready

        You now have a simple three node cluster running. The main differences between this demo and full production cluster is that you are running all of the nodes on ONE PIECE OF HARDWARE and that you are running a single server instead of three or five.

        邏輯上的 node 是不同的 agent process，只是實務上這些 process 會執行在不同的機器上。

        雖然這個 cluster 有 3 個 node，但因為 `node status` 只會列出 client node，所以才會只有 2 個 node。

    Submit a Job

      - Now that you have a simple cluster, you can use it to schedule a job. You should still have the `example.nomad` job file from before, but verify that the `count` is still set to 3.

        Then, use the `job run` command to submit the job:

            $ nomad job run example.nomad
            ==> Monitoring evaluation "8e0a7cf9"
                Evaluation triggered by job "example"
                Evaluation within deployment: "0917b771"
                Allocation "501154ac" created: node "c887deef", group "cache"
                Allocation "7e2b3900" created: node "fca62612", group "cache"
                Allocation "9c66fcaf" created: node "c887deef", group "cache"
                Evaluation status changed: "pending" -> "complete"
            ==> Evaluation "8e0a7cf9" finished with status "complete"

        The sample output above shows that the scheduler assigned two of the tasks for one of the client nodes and the remaining task to the second client. Compare this to your output, you should observe a similar split.

        這某種程度上解釋了 "an allocation represents an instance of task group placed on a node." 的設計。Task group 下不同的 task 一定會被安排在同一個 allocation 裡，而不同的 allocation 可能落在 cluster 不同的 client node。

      - You can again use the `status` command to verify:

            $ nomad status example
            ID          = example
            Name        = example
            Submit Date   = 07/26/19 16:34:58 UTC
            Type        = service
            Priority    = 50
            Datacenters = dc1
            Status      = running
            Periodic    = false
            Parameterized = false

            Summary
            Task Group  Queued  Starting  Running  Failed  Complete  Lost
            cache       0       0         3        0       0         0

            Latest Deployment
            ID          = fc49bd6c
            Status      = running
            Description = Deployment is running

            Deployed
            Task Group  Desired  Placed  Healthy  Unhealthy
            cache       3        3       0        0

            Allocations
            ID        Eval ID   Node ID   Task Group  Desired  Status   Created At
            501154ac  8e0a7cf9  c887deef  cache       run      running  08/08/19 21:03:19 CDT
            7e2b3900  8e0a7cf9  fca62612  cache       run      running  08/08/19 21:03:19 CDT
            9c66fcaf  8e0a7cf9  c887deef  cache       run      running  08/08/19 21:03:19 CDT

        The output shows that all of the tasks have been allocated and are running. Once you are satisfied that our job is happily running, you can stop all of the instances with `nomad job stop`.

      - Nomad is now up and running. The cluster can be entirely managed from the command line, but Nomad also comes with a web interface that is hosted alongside the HTTP API. Next, you'll visit the UI in the browser.

        Re-run the example job if you stopped it previously before heading to the next section.

  - [Getting Started: Web UI \| Nomad \- HashiCorp Learn](https://learn.hashicorp.com/tutorials/nomad/get-started-ui)

      - At this point you have a fully functioning cluster with a job running in it. You have learned how to inspect a job using `nomad status`, next you'll learn how to inspect a job in the web client.

    Opening the Web UI

      - As long as Nomad is running, the Nomad UI is also running. It is hosted at the same address and port as the Nomad HTTP API under the `/ui` namespace.

        With Nomad running, visit http://localhost:4646 to open the Nomad UI.

        If you’re using vagrant and can’t connect, it’s possible that Vagrant was unable to properly map the port from your host to the VM. Your vagrant up output will contain the new port mapping:

            ==> default: Fixed port collision for 4646 => 4646. Now on port 2200.

        In the case above you would connect to http://localhost:2200 instead.

    Inspecting a Job

      - You should be automatically redirected to `/ui/jobs` upon visiting the UI in your browser. This pages lists all jobs known to Nomad, regardless of status. Click the `example` job to inspect it.

        The job detail page shows pertinent information about the job, including overall status as well as allocation statuses broken down by task group. It is similar to the nomad status CLI command.

        Note: You may see a different number of allocations on your node next to Allocation Status depending on how many times you have stopped and restarted jobs.

      - Click on the cache task group to DRILL INTO the task group detail page. This page lists each allocation for the task group.

        Click on the allocation in the allocations table. This page lists all tasks for an allocation as well as the recent events for each task. It is similar to the `nomad alloc status` command.

  - [Getting Started: Learn More \| Nomad \- HashiCorp Learn](https://learn.hashicorp.com/tutorials/nomad/get-started-learn-more)

      - You've covered the basics of all the core features of Nomad in this guide. We recommend exploring the following resources as next steps.

        There are many more Learn Tutorials to provide best practices and guidance for using and operating Nomad in a real-world production setting. Some places you might like to start are:

          - [Deploy and Manage Nomad Jobs](https://learn.hashicorp.com/nomad?track=managing-jobs#getting-started) - More information about how to run your own workload in Nomad. #ril
          - [Operating Nomad Clusters](https://learn.hashicorp.com/nomad?track=operating-nomad#operations-and-development) - Nomad features that operators need to understand to build and maintain Nomad clusters. #ril

      - Some of the tutorials require a Nomad cluster. You can create a cluster in AWS using our example [Terraform configuration](https://github.com/hashicorp/nomad/tree/master/terraform). #ril

## Job Specification

  - [Job Specification \| Nomad by HashiCorp](https://www.nomadproject.io/docs/job-specification) #ril

## HTTP API {: #api }

  - [HTTP API \| Nomad by HashiCorp](https://www.nomadproject.io/api-docs)

## 安裝設置 {: #setup }

  - [Getting Started: Install Nomad \| Nomad \- HashiCorp Learn](https://learn.hashicorp.com/tutorials/nomad/get-started-install) #ril

## 參考資料 {: #reference }

  - [Nomad](https://www.nomadproject.io/)
  - [hashicorp/nomad - GitHub](https://github.com/hashicorp/nomad)

文件：

  - [Nomad Documentation](https://www.nomadproject.io/docs)

手冊：

  - [Nomad Commands (CLI)](https://www.nomadproject.io/docs/commands)
