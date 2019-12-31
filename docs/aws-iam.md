---
title: AWS / IAM (Identity and Access Management)
---
# [AWS](aws.md) / IAM (Identity and Access Management)

## IAM Role

  - [IAM Roles \- AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) #ril

      - An IAM role is an IAM identity that you can create in your account that has specific permissions. An IAM role is similar to an IAM user, in that it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS.

        However, instead of being uniquely associated with one person, a role is intended to be ASSUMABLE BY ANYONE WHO NEEDS IT. Also, a role does not have standard long-term credentials such as a password or access keys associated with it. Instead, when you assume a role, it provides you with TEMPORARY security credentials for your role SESSION ??.

        根據下面 "switch to (or assume)" 的說法，這裡的 assume 可以解釋成 "假裝成 ... 的樣子"。但 temporary credentials 是多久?

        從 AWS Console > IAM > Roles > Maximum CLI/API session duration > Custom Duration 的提示看來：

        > The custom duration must be between 3,600 (1 hour) and 43,200 (12 hours)

        一定要介於 1 ~ 12 hours 之間。

      - You can use roles to delegate access to users, APPLICATIONS, or SERVICES that don't normally have access to your AWS resources. For example, you might want to grant users in your AWS account access to resources they don't usually have, or grant users in one AWS account access to resources in another account.

        Or you might want to allow a mobile app to use AWS resources, but not want to embed AWS keys within the app (where they can be difficult to ROTATE and where users can potentially extract them). Sometimes you want to give AWS access to users who already have identities defined outside of AWS, such as in your corporate directory. Or, you might want to grant access to your account to third parties so that they can perform an audit on your resources.

        不過終究是要有個 key，只是 key 是暫時的，所以才會提到 rotate。

      - For these scenarios, you can delegate access to AWS resources using an IAM role. This section introduces roles and the different ways you can use them, when and how to choose among approaches, and how to create, manage, switch to (or assume), and delete roles.

  - [Using an IAM Role to Grant Permissions to Applications Running on Amazon EC2 Instances \- AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html) #ril

      - Applications that run on an EC2 instance must include AWS credentials in their AWS API requests. You could have your developers store AWS credentials directly within the EC2 instance and allow applications in that instance to use those credentials. But developers would then have to manage the credentials and ensure that they securely pass the credentials to each instance and update each EC2 instance when it's time to ROTATE the credentials. That's a lot of additional work.

      - Instead, you can and SHOULD use an IAM role to manage TEMPORARY credentials for applications that run on an EC2 instance. When you use a role, you don't have to distribute long-term credentials (such as a user name and password or access keys) to an EC2 instance. Instead, the role supplies temporary permissions that applications can use when they make calls to other AWS resources.

        When you launch an EC2 instance, you specify an IAM role to associate with the instance. Applications that run on the instance can then use the ROLE-SUPPLIED TEMPORARY CREDENTIALS to sign API requests.

      - Using roles to grant permissions to applications that run on EC2 instances requires a bit of extra configuration. An application running on an EC2 instance is abstracted from AWS by the virtualized operating system. Because of this extra separation, an additional step is needed to assign an AWS role and its associated permissions to an EC2 instance and make them available to its applications.

        This extra step is the creation of an INSTANCE PROFILE ?? that is attached to the instance. The instance profile contains the role and can provide the role's temporary credentials to an application that runs on the instance. Those temporary credentials can then be used in the application's API calls to access resources and to limit access to only those resources that the role specifies.

      - Note that only one role can be assigned to an EC2 instance at a time, and all applications on the instance SHARE THE SAME ROLE and permissions.

        注意這裡講的是 share the same ROLE 而非 credentials，所以 application 跟 AWS CLI 拿到的 credentials 會不一樣 (畢竟是不同的 application)；實驗發現，自己用 Java SDK 寫的 application 重複啟動，跟 AWS CLI (`aws configure list`) 的行為很不一樣 -- max session duration 設 1 hr 時，自己的 application 會在 1 hr 左右換成新的 credential，但 AWS CLI 更換的頻率更高?

        雖然沒有解釋 application 最終是如何拿到 (temporary) credentials，但至少可以確認同一 EC2 instance 上 AWS CLI 跟 application 會拿到相同的 credential??

      - Using roles in this way has several benefits. Because role credentials are TEMPORARY and ROTATED AUTOMATICALLY, you don't have to manage credentials, and you don't have to worry about LONG-TERM SECURITY RISKS. In addition, if you use a single role for multiple instances, you can make a change to that one role and the change is propagated automatically to all the instances.

      - Note: Although a role is usually assigned to an EC2 instance when you launch it, a role can also be attached to an EC2 instance that is ALREADY RUNNING. To learn how to attach a role to a running instance, see IAM Roles for Amazon EC2.

  - [Using IAM Roles to Grant Access to AWS Resources on Amazon EC2 \- AWS SDK for Java](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/java-dg-roles.html) #ril

      - All requests to Amazon Web Services (AWS) must be cryptographically signed using credentials issued by AWS. You can use IAM roles to conveniently grant secure access to AWS resources from your Amazon EC2 instances.

        This topic provides information about how to use IAM roles with Java SDK applications running on Amazon EC2. For more information about IAM instances, see IAM Roles for Amazon EC2 in the Amazon EC2 User Guide for Linux Instances.

    The default provider chain and EC2 instance profiles

      - If your application creates an AWS client using the default constructor, then the client will search for credentials using the default credentials provider chain, in the following order:

          - In system environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
          - In the Java system properties: `aws.accessKeyId` and `aws.secretKey`.
          - In the default credentials file (the location of this file varies by platform).
          - In the instance profile credentials, which exist within the INSTANCE METADATA associated with the IAM role for the EC2 instance.

        The final step in the default provider chain is available only when running your application on an Amazon EC2 instance, but provides the greatest ease of use and BEST SECURITY when working with Amazon EC2 instances.

      - You can also pass an `InstanceProfileCredentialsProvider` instance directly to the client constructor to get instance profile credentials without proceeding through the entire default provider chain.

        不過這會綁定 application 一定是佈署在 EC2 上。

        For example:

            AmazonS3 s3 = AmazonS3ClientBuilder.standard()
                          .withCredentials(new InstanceProfileCredentialsProvider(false))
                          .build();

      - When using this approach, the SDK retrieves temporary AWS credentials that have the same permissions as those associated with the IAM role associated with the Amazon EC2 instance in its instance profile. Although these credentials are temporary and would EVENTUALLY EXPIRE, `InstanceProfileCredentialsProvider` PERIODICALLY REFRESHES THEM FOR YOU so that the obtained credentials continue to allow access to AWS.

        Important: The automatic credentials refresh happens only when you use the default client constructor, which creates its own `InstanceProfileCredentialsProvider` as part of the default provider chain, or when you pass an `InstanceProfileCredentialsProvider` instance directly to the client constructor. If you use another method to obtain or pass instance profile credentials, you are responsible for checking for and refreshing expired credentials. ??

        [InstanceProfileCredentialsProvider \(AWS SDK for Java \- 1\.11\.698\)](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/auth/InstanceProfileCredentialsProvider.html#InstanceProfileCredentialsProvider-boolean-)

        > Spins up a new thread to refresh the credentials asynchronously if `refreshCredentialsAsync` is set to `true`, otherwise the credentials will be refreshed from the instance metadata service SYNCHRONOUSLY,
        >
        > It is strongly recommended to reuse instances of this credentials provider, especially when async refreshing is used since a background thread is created.

        聽起來都會 refresh，只是 asynchronously 跟 synchronously 的差別，但 synchronously 會發生在什麼時候??

      - If the client constructor can’t find credentials using the credentials provider chain, it will throw an `AmazonClientException`.

  - [Using Temporary Credentials With AWS Resources \- AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html) #ril

      - You must make sure that you get a new set of credentials before the old ones expire. In some SDKs, you can use a provider that manages the process of refreshing credentials for you; check the documentation for the SDK you're using.

  - [IAM Roles for Amazon EC2 \- Amazon Elastic Compute Cloud](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html) #ril

  - [Hands\-On Lab: Using EC2 Roles and Instance Profiles \| Linux Academy](https://linuxacademy.com/hands-on-lab/5ca8172c-cb8e-4c98-a6bb-46d3e1e97511/) #ril

      - 提到 `aws sts get-caller-identity` 可以查看目前的身份。

## 參考資料 {: #reference }

文件：

  - [AWS Identity and Access Management Documentation](https://docs.aws.amazon.com/iam/index.html)

手冊：

  - [Class `com.amazonaws.auth.DefaultAWSCredentialsProviderChain`](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/auth/DefaultAWSCredentialsProviderChain.html)
  - [Interface `com.amazonaws.auth.AWSCredentialsProvider`](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/auth/AWSCredentialsProvider.html)
  - [Interface `com.amazonaws.auth.AWSCredentials`](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/auth/AWSCredentials.html)
  - [Class `com.amazonaws.auth.InstanceProfileCredentialsProvider`](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/index.html?com/amazonaws/auth/InstanceProfileCredentialsProvider.html)
