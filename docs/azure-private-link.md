看起來將 
title: Azure / Private Link
---
# [Azure](azure.md) / Private Link

  - [What is Azure Private Link? \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/private-link/private-link-overview)

      - Azure Private Link enables you to access Azure PaaS Services (for example, Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a [PRIVATE ENDPOINT](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview) in your virtual network. #ril

      - Traffic between your virtual network and the service travels the Microsoft BACKBONE NETWORK. EXPOSING YOUR SERVICE TO THE PUBLIC INTERNET IS NO LONGER NECESSARY. You can create your own [PRIVATE LINK SERVICE](https://docs.microsoft.com/en-us/azure/private-link/private-link-service-overview) in your virtual network and deliver it to your customers. Setup and consumption using Azure Private Link is consistent across Azure PaaS, customer-owned, and shared partner services. ?? #ril

      - Azure Private Link is now generally available. Both Private Endpoint and Private Link service (service behind standard load balancer) are generally available.

        Different Azure PaaS will onboard to Azure Private Link at different schedules. Check availability section below for accurate status of Azure PaaS on Private Link. For known limitations, see Private Endpoint and Private Link Service.

        ![](https://docs.microsoft.com/en-us/azure/private-link/media/private-link-overview/private-endpoint.png)

    Key benefits -- Azure Private Link provides the following benefits:

      - Privately access services on the Azure platform

        Connect your virtual network to services in Azure without a public IP address at the source or destination. Service providers can render their services in THEIR OWN virtual network and consumers can access those services in their local virtual network.

        The Private Link platform will handle the connectivity between the consumer and services over the Azure backbone network.

      - On-premises and peered networks

        Access services running in Azure from on-premises over ExpressRoute private peering??, VPN tunnels, and peered virtual networks using private endpoints.

        There's no need to set up public peering or traverse the internet to reach the service. Private Link provides a secure way to MIGRATE WORKLOADS TO AZURE.

      - Protection against data leakage

        A private endpoint is mapped to an instance of a PaaS resource instead of the entire service.

        Consumers can only connect to the specific resource. Access to any other resource in the service is blocked. This mechanism provides protection against data leakage risks.

      - Global reach

        Connect privately to services running in other regions. The consumer's virtual network could be in region A and it can connect to services behind Private Link in region B.

      - Extend to your own services

        Enable the same experience and functionality to render your service privately to consumers in Azure.

        By placing your service behind a standard Azure Load Balancer, you can enable it for Private Link. The consumer can then connect directly to your service using a private endpoint in THEIR OWN virtual network. You can manage the connection requests using an APPROVAL CALL FLOW??.

        Azure Private Link works for consumers and services belonging to different Azure Active Directory tenants. 跟 AD 什麼關係??

    Logging and monitoring

      - Azure Private Link has integration with Azure Monitor. This combination allows:

          - Archival of logs to a storage account.
          - Streaming of events to your Event Hub.
          - Azure Monitor logging.

      - You can access the following information on Azure Monitor:

        Private endpoint:

          - Data processed by the Private Endpoint  (IN/OUT)

        Private Link service:

          - Data processed by the Private Link service (IN/OUT)
          - NAT port availability

  - [Pricing \- Azure Private Link \| Microsoft Azure](https://azure.microsoft.com/en-us/pricing/details/private-link/)

    Pricing details

      - Private Link Service - No charge for private link service
      - Private Endpoint - NT$0.301 per hour --> 有被用到的時數??
      - Inbound Data Processed - NT$0.301 per GB
      - Outbound Data Processed - NT$0.301 per GB

    Data processed charges will be based on the DIRECTION OF TRAFFIC. e.g. if you are writing to a Storage account through Private Endpoint you will pay for Outbound Data Processed. Similarly, if you are reading from a Storage account through Private Endpoint you will pay for Inbound Data Processed.

    這裡的 inbound/outbound 是從 private endipoint 的角度來看，所以往 endpoint 讀資料是 outbound，反之則是 inbound。

    Please note that above price is PREMIUM for Azure Private Link. Data Transfer pricing still applies to data transfer.

    看起來將 Private Link 用於 SQL database 好像不怎麼合適，可能有速度的問題，又要多收錢??

  - [Azure Private Link frequently asked questions \(FAQ\) \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/private-link/private-link-faq) #ril
  - [Private Link limits - Azure subscription limits and quotas \- Azure Resource Manager \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#private-link-limits) #ril
