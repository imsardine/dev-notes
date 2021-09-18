# ACM (AWS Certificate Manager)

  - [AWS Certificate Manager \- Amazon Web Services \(AWS\)](https://aws.amazon.com/certificate-manager/) #ril

      - AWS Certificate Manager is a service that lets you easily provision, manage, and deploy public and private Secure Sockets Layer/Transport Layer Security (SSL/TLS) certificates for use with AWS services and your internal connected resources.

        其中 private certificate 跟 internal resource 的關係?? 又 private certificate 又如何做到讓 client 信任?

      - SSL/TLS certificates are used to secure network communications and establish the identity of websites over the Internet as well as resources on private networks. AWS Certificate Manager removes the TIME-CONSUMING MANUAL PROCESS of purchasing, uploading, and renewing SSL/TLS certificates.

      - With AWS Certificate Manager, you can quickly request a certificate, deploy it on ACM-integrated AWS resources, such as Elastic Load Balancers, Amazon CloudFront distributions, and APIs on API Gateway, and let AWS Certificate Manager handle certificate renewals.

        It also enables you to create private certificates for your internal resources and manage the certificate lifecycle centrally.

        所有 traffic 都先經過 AWS 服務 (ELB, CloudFront, API Gateway) 的意思。

      - Public and private certificates provisioned through AWS Certificate Manager for use with ACM-integrated services are FREE. You pay only for the AWS resources you create to run your application

        With AWS Certificate Manager Private Certificate Authority, you pay monthly for the operation of the private CA and for the private certificates you issue. ??

    Free public certificates for ACM-integrated services

      - With AWS Certificate Manager, there is no additional charge for provisioning public or private SSL/TLS certificates you use with ACM-integrated services, such as Elastic Load Balancing and API Gateway. You pay for the AWS resources you create to run your application.
      - For private certificates, ACM Private CA provides you the ability to pay monthly for the service and certificates you create. You pay less per certificate as you create more private certificates.

    Managed certificate renewal

      - AWS Certificate Manager manages the renewal process for the certificates managed in ACM and used with ACM-integrated services, such as Elastic Load Balancing and API Gateway. ACM can automate renewal and deployment of these certificates.
      - With ACM Private CA APIs, ACM enables you to automate creation and renewal of private certificates for on-premises resources, EC2 instances, and IoT devices.

    Get certificates easily

      - AWS Certificate Manager removes many of the time-consuming and error-prone steps to acquire an SSL/TLS certificate for your website or application. There is no need to generate a key pair or certificate signing request (CSR), submit a CSR to a Certificate Authority, or upload and install the certificate once received.
      - With a few clicks in the AWS Management Console, you can request a trusted SSL/TLS certificate from AWS. Once the certificate is created, AWS Certificate Manager takes care of deploying certificates to help you enable SSL/TLS for your website or application.

## Private CA

  - [Private Certificate Authority \- AWS Certificate Manager \- Amazon Web Services \(AWS\)](https://aws.amazon.com/certificate-manager/private-certificate-authority/) #ril

      - ACM Private CA provides you a highly-available private CA service without the upfront investment and ongoing maintenance costs of operating your own private CA.

        AWS Certificate Manager (ACM) Private Certificate Authority (CA) is a private CA service that extends ACM’s certificate management capabilities to BOTH public and private certificates.

      - ACM Private CA allows developers to be more agile by providing them APIs to create and deploy private certificates programmatically. You also have the flexibility to create private certificates for applications that require custom certificate lifetimes or resource names. ??

      - With ACM Private CA, you can create and manage private certificates for your connected resources in one place with a secure, pay as you go, managed private CA service.

  - [Is ACM the right service for me? - What Is AWS Certificate Manager? \- AWS Certificate Manager](https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html#service-options) #ril

      - ACM Private CA—This service is for enterprise customers building a public key infrastructure (PKI) inside the AWS cloud and intended for PRIVATE USE within an organization.

        With ACM Private CA, you can create your own certificate authority (CA) hierarchy and issue certificates with it for authenticating users, computers, applications, services, servers, and other devices.

      - Certificates issued by a private CA CANNOT BE USED ON THE INTERNET. For more information, see the ACM Private CA User Guide.

  - [What is ACM Private CA? \- AWS Certificate Manager Private Certificate Authority](https://docs.aws.amazon.com/acm-pca/latest/userguide/PcaWelcome.html) #ril

    Certificates issued by a private CA are trusted only within your organization, not on the internet.

## 參考資料 {: #reference }

  - [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/)
