---
title: Azure / Active Directory (AD)
---
# [Azure](azure.md) / Active Directory (AD)

## Enterprise Application

  - [What is application management? \- Azure AD \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/what-is-application-management)

      - Application management in Azure Active Directory (Azure AD) is the process of creating, configuring, managing, and monitoring applications in the CLOUD. When an application is REGISTERED in an Azure AD tenant, users who have been ASSIGNED to it can securely access it.

        Many TYPES of applications can be registered in Azure AD. For more information, see Application types for the Microsoft Identity Platform.

      - In this article, you learn these important aspects of managing the LIFECYCLE of an application:

          - Develop, add, or connect – You take different paths depending on whether you are developing your own application, using a PRE-INTEGRATED application, or connecting to an ON-PREMISES application.

            其中 on-premises application 就是 ZTNA 的應用??

          - Manage access – Access can be managed by using single sign-on (SSO), ASSIGNING RESOURCES??, defining the WAY?? access is granted and consented to, and using AUTOMATED PROVISIONING??.

          - Configure properties – Configure the requirements for signing into the application and how the application is represented in USER PORTALS.

            其中 "requirements for signing into ..." 指的就是 Enabled for users to sign-in? (能不能用?) 與 Assignment required? (誰能用?)

          - Secure the application – Manage configuration of permissions, multifactor authentication (MFA), CONDITIONAL ACCESS??, tokens, and certificates.
          - Govern and monitor – Manage interaction and review activity using ENTITLEMENT MANAGEMENT?? and reporting and monitoring resources.
          - Clean up – When your application is no longer needed, clean up your tenant by removing access to it and deleting it.

    Develop, add, or connect

      - There are several ways that you might manage applications in Azure AD. The easiest way to start managing an application is to use a pre-integrated application from the Azure AD gallery. Developing your own application and registering it Azure AD is an option, or you can continue to use an on-premises application.

        ![](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/media/what-is-application-management/app-management-overview.png)

      - The following image shows how these applications interact with Azure AD.

        Azure AD 跟 Windows Server AD 間有 Azure AD Connect 串聯，應用程式則可以接 cloud applications 與 your own business applications (指 on-premises)

    Pre-integrated applications

      - Many applications are already pre-integrated (shown as “Cloud applications” in the image above) and can be set up with minimal effort. Each application in the Azure AD gallery has an article available that shows you the steps required to configure the application.

        For a simple example of how an application can be added to your Azure AD tenant from the gallery, see Quickstart: Add an enterprise application.

## Application Proxy

  - [Publish on\-premises apps with Azure AD Application Proxy \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/what-is-application-proxy) (2019-05-31) #ril

## Domain Service

  - [Overview of Azure Active Directory Domain Services \| Microsoft Docs](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/overview)

      - Azure Active Directory Domain Services (Azure AD DS) provides managed DOMAIN SERVICES such as DOMAIN JOIN, group policy, lightweight directory access protocol (LDAP), and Kerberos/NTLM authentication. You use these domain services without the need to deploy, manage, and patch domain controllers (DCs) in the cloud.
      - An Azure AD DS managed domain lets you RUN LEGACY APPLICATIONS IN THE CLOUD that can't use modern authentication methods, or where you don't want directory lookups to always go back to an ON-PREMISES AD DS environment. You can LIFT AND SHIFT those legacy applications from your on-premises environment into a managed domain, without needing to manage the AD DS environment in the cloud.
      - Azure AD DS integrates with your existing Azure AD tenant. This integration lets users sign in to services and applications connected to the managed domain using their existing credentials. You can also use existing groups and user accounts to secure access to resources. These features provide a SMOOTHER LIFT-AND-SHIFT of on-premises resources to Azure.

    How does Azure AD DS work?

      - When you create an Azure AD DS managed domain, you define a UNIQUE NAMESPACE. This namespace is the domain name, such as `aaddscontoso.com`. TWO Windows Server domain controllers (DCs) are then deployed into your selected Azure region. This deployment of DCs is known as a REPLICA SET.

        下面特別強調 "The managed domain is a stand-alone domain. It isn't an extension of an on-premises domain"，所以 AAD DS 的 domain 與 on-prem AD DS 的 domain 必然不同。

        AAD DS 的 domain 與 on-prem AD DS 的 domain 不同??

        You don't need to manage, configure, or update these DCs. The Azure platform handles the DCs as part of the managed domain, including backups and encryption at rest using Azure Disk Encryption.

      - A managed domain is configured to perform a ONE-WAY SYNCHRONIZATION from Azure AD to provide access to a central set of users, groups, and credentials. You can create resources directly in the managed domain, but they AREN'T synchronized back to Azure AD.

        Applications, services, and VMs in Azure that connect to the managed domain can then use common AD DS features such as domain join, group policy, LDAP, and Kerberos/NTLM authentication.

      - In a HYBRID environment with an on-premises AD DS environment, Azure AD Connect synchronizes identity information with Azure AD, which is then synchronized to the managed domain.

        ![](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/media/active-directory-domain-services-design-guide/sync-topology.png)

        注意圖上的箭頭，Azure AD 與 On-prem AD 間的同步是雙向的，但 Azure AD --> Azure AD DS 的同步則是單向的。

        Azure AD DS replicates identity information from Azure AD, so it works with Azure AD tenants that are cloud-only, or synchronized with an on-premises AD DS environment. The same set of Azure AD DS features exists for both environments.

        指不管 Azure AD 背後有沒有 On-prem AD (背後沒有 On-prem AD 時，稱做 cloud-only)，Azure AD DS 的功能沒有差別。

          - If you have an existing on-premises AD DS environment, you can synchronize user account information to provide a CONSISTENT IDENTITY for users. To learn more, see How objects and credentials are synchronized in a managed domain.
          - For cloud-only environments, you don't need a traditional on-premises AD DS environment to use the centralized identity services of Azure AD DS.

      - You can expand a managed domain to have more than one replica set per Azure AD tenant. Replica sets can be added to any PEERED VIRTUAL NETWORK in any Azure region that supports Azure AD DS. Additional replica sets in different Azure regions provide GEOGRAPHICAL DISASTER RECOVERY for legacy applications if an Azure region goes offline. For more information, see Replica sets concepts and features for managed domains.

      - Take a look at this video about how Azure AD DS integrates with your applications and workloads to provide identity services in the cloud:

        [What’s new in Azure Active Directory Domain Services \- BRK3295 \- YouTube](https://www.youtube.com/watch?v=T1Nd9APNceQ)

        To see Azure AD DS deployment scenarios in action, you can explore the following examples:

          - Azure AD DS for hybrid organizations
          - Azure AD DS for cloud-only organizations

    Azure AD DS features and benefits

      - To provide identity services to applications and VMs in the cloud, Azure AD DS is fully compatible with a traditional AD DS environment for operations such as domain-join, secure LDAP (LDAPS), Group Policy, DNS management, and LDAP bind and read support.

        LDAP write support is available for objects created in the managed domain, but not resources synchronized from Azure AD.

        To learn more about your identity options, compare Azure AD DS with Azure AD, AD DS on Azure VMs, and AD DS on-premises.

      - The following features of Azure AD DS simplify deployment and management operations:

          - Simplified deployment experience: Azure AD DS is enabled for your Azure AD tenant using a single wizard in the Azure portal.

          - Integrated with Azure AD: User accounts, group memberships, and credentials are automatically available from your Azure AD tenant. New users, groups, or changes to attributes from your Azure AD tenant or your on-premises AD DS environment are automatically synchronized to Azure AD DS.

            Accounts in EXTERNAL DIRECTORIES?? linked to your Azure AD aren't available in Azure AD DS. Credentials aren't available for those external directories, so can't be synchronized into a managed domain.

          - Use your corporate credentials/passwords: Passwords for users in Azure AD DS are the same as in your Azure AD tenant. Users can use their corporate credentials to domain-join machines, sign in interactively or over remote desktop, and authenticate against the managed domain.
          - NTLM and Kerberos authentication: With support for NTLM and Kerberos authentication, you can deploy applications that rely on WINDOWS-INTEGRATED AUTHENTICATION.

          - High availability: Azure AD DS includes multiple domain controllers, which provide high availability for your managed domain. This high availability guarantees service uptime and resilience to failures.

            In regions that support Azure Availability Zones, these domain controllers are also distributed across zones for additional resiliency.

            Replica sets can also be used to provide geographical disaster recovery for legacy applications if an Azure region goes offline.

      - Some key aspects of a managed domain include the following:

          - The managed domain is a STAND-ALONE DOMAIN. It ISN'T AN EXTENSION of an on-premises domain.

            If needed, you can create ONE-WAY OUTBOUND FOREST TRUSTS?? from Azure AD DS to an on-premises AD DS environment. For more information, see Resource forest concepts and features for Azure AD DS.

          - Your IT team doesn't need to manage, patch, or monitor domain controllers for this managed domain.

        For hybrid environments that run AD DS on-premises, you don't need to manage AD replication to the managed domain. User accounts, group memberships, and credentials from your on-premises directory are synchronized to Azure AD via Azure AD Connect. These user accounts, group memberships, and credentials are automatically available within the managed domain.
