# NetBox

  - [NetBox](https://netbox.readthedocs.io/)

    What is NetBox?

      - NetBox is an infrastructure resource modeling (IRM) application designed to empower NETWORK AUTOMATION.

        Initially conceived by the network engineering team at DigitalOcean, NetBox was developed specifically to address the needs of network and infrastructure engineers. NetBox is made available as open source under the Apache 2 license.

      - It encompasses the following aspects of network management:

          - IP address management (IPAM) - IP networks and addresses, VRFs, and VLANs
          - Equipment racks - Organized by group and site
          - Devices - Types of devices and where they are installed
          - Connections - Network, console, and power connections among devices
          - Virtualization - Virtual machines and clusters
          - Data circuits (數據電路) - Long-haul communications circuits and providers

    What NetBox Is Not

      - While NetBox strives to cover many areas of network management, the scope of its feature set is necessarily limited. This ensures that development focuses on core functionality and that scope creep is reasonably contained. To that end, it might help to provide some examples of functionality that NetBox does not provide:

          - Network monitoring
          - DNS server
          - RADIUS server
          - Configuration management
          - Facilities management

        That said, NetBox can be used to great effect in POPULATING EXTERNAL TOOLS WITH THE DATA they need to perform these functions.

        NetBox 存放 master data，方便做進一步的應用，例如 network automation??

    Design Philosophy

      - NetBox was designed with the following tenets foremost in mind.

      - Replicate the Real World

        Careful consideration has been given to the DATA MODEL to ensure that it can accurately REFLECT A REAL-WORLD NETWORK. For instance, IP addresses are assigned not to devices, but to specific interfaces attached to a device, and an interface may have multiple IP addresses assigned to it.

      - Serve as a "Source of Truth"

        NetBox intends to represent the DESIRED STATE of a network versus its OPERATIONAL STATE. As such, AUTOMATED IMPORT of live network state is STRONGLY DISCOURAGED.

        All data created in NetBox should first be VETTED BY A HUMAN to ensure its integrity. NetBox can then be used to POPULATE monitoring and provisioning systems with a HIGH DEGREE OF CONFIDENCE.

      - Keep it Simple

        When given a choice between a relatively simple 80% solution and a much more complex complete solution, the former will typically be favored. This ensures a lean codebase with a low learning curve.

    Application Stack

      - NetBox is built on the Django Python framework and utilizes a PostgreSQL database. It runs as a WSGI service behind your choice of HTTP server.

          - HTTP service: nginx or Apache
          - WSGI service: gunicorn or uWSGI
          - Application: Django/Python
          - Database: PostgreSQL 10+
          - Task queuing: Redis/django-rq
          - Live device access: NAPALM ??

## Topology Visualization

  - [Best/Most efficient way to create all\-new network diagrams? : networking](https://www.reddit.com/r/networking/comments/lkwa7d/bestmost_efficient_way_to_create_allnew_network/)

      - da5idho: if they have zero documentation, what they need is actual documentation

        i recommend https://github.com/netbox-community/netbox because it does ipam as well as dcim

        and for visualizing (the physical layer) https://github.com/mattieserver/netbox-topology-views

      - StubArea51: I am such a huge fan of Netbox and the work that Stretch has done.

        Using netbox as a single source of truth in the Network to enable AUTOMATION AND VERIFICATION is just fantastic.

      - opseceu: Don't draw pictures UNTIL YOU HAVE WAYS TO UPDATE THEM, preferrably automatically. First find a way to DOCUMENT THE NETWORK, and only in the end draw pictures. Otherwise your time needed to update pictures because you found something will dominate any other work.

        Use netbox to document your network. https://github.com/netbox-community/netbox

  - [iDebugAll/nextbox\-ui\-plugin: A topology visualization plugin for Netbox powered by NextUI Toolkit](https://developer.cisco.com/codeexchange/github/repo/iDebugAll/nextbox-ui-plugin/)

  - [mattieserver/netbox\-topology\-views: A netbox plugin that draws topology views](https://github.com/mattieserver/netbox-topology-views)

## 參考資料 {: #reference }

  - [NetBox](https://netbox.readthedocs.io/)
  - [netbox-community/netbox - GitHub](https://github.com/netbox-community/netbox)

文件：

  - [NetBox Documentation](https://netbox.readthedocs.io/en/stable/)

