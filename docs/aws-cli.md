# AWS CLI

  - [AWS Command Line Interface Documentation](https://docs.aws.amazon.com/cli/) #ril

    The AWS Command Line Interface (AWS CLI) is a unified tool that provides a consistent interface for interacting with all parts of AWS. AWS CLI commands for different services are covered in the accompanying user guide, including descriptions, syntax, and usage examples.

  - [What is the AWS Command Line Interface? \- AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)

    基於 AWS SDK for Python (Boto) 建構出來的 CLI。除了 low level, API equivalent commands 外，也為複雜的 API 提供了一些 high level commands (customization)，例如 high-level `aws s3` 之於 low-level `aws s3api`，其中 low level commands (直接對應 public API)，可以用來學習 API 的用法，之後可以應用在 AWS SDK 上。

      - The AWS Command Line Interface (AWS CLI) is an open source tool that enables you to interact with AWS services using commands in your command-line shell. With minimal configuration, the AWS CLI enables you to start running commands that implement functionality equivalent to that provided by the browser-based AWS Management Console from the command prompt in your terminal program:

          - Linux shells – Use common shell programs such as bash, zsh, and tcsh to run commands in Linux or macOS.
          - Windows command line – On Windows, run commands at the Windows command prompt or in PowerShell.

          - Remotely – Run commands on Amazon Elastic Compute Cloud (Amazon EC2) instances through a remote terminal program such as PuTTY or SSH, or with AWS Systems Manager.

            SSH 跟 AWS CLI 的關係??

      - All IaaS (infrastructure as a service) AWS administration, management, and access functions in the AWS Management Console are available in the AWS API and AWS CLI.

        New AWS IaaS features and services provide full AWS Management Console functionality through the API and CLI at launch or within 180 days of launch.

      - The AWS CLI provides direct access to the public APIs of AWS services. You can explore a service's capabilities with the AWS CLI, and develop shell scripts to manage your resources.

        In addition to the LOW-LEVEL, API-EQUIVALENT commands, several AWS services provide customizations for the AWS CLI. Customizations can include HIGHER-LEVEL commands that simplify using a service with a complex API.

  - [About the AWS CLI versions \- AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/welcome-versions.html)

      - The AWS CLI is available in two versions and information in this guide applies to both versions unless stated otherwise. To check which version you may have currently installed, run the `aws --version` command in your shell. The returned value provides the current version you have installed. The following example shows that the version running is 2.1.29.

            $ aws --version
            aws-cli/2.1.29 Python/3.7.4 Linux/4.14.133-113.105.amzn2.x86_64 botocore/2.0.0

    AWS CLI version 2

      - The AWS CLI version 2 is the most recent major version of the AWS CLI and supports all of the latest features. Some features introduced in version 2 are not backported to version 1 and you must upgrade to access those features.

        There are some "breaking" changes from version 1 that might require you to change your scripts. For a list of breaking changes in version 2, see [Breaking changes – Migrating from AWS CLI version 1 to version 2](https://docs.aws.amazon.com/cli/latest/userguide/cliv2-migration.html). #ril

      - The AWS CLI version 2 is available to install only as a BUNDLED INSTALLER. While you may find it in package managers, these are unsupported and unofficial packages that are not produced or managed by AWS. We recommend that you install the AWS CLI from only the official AWS distribution points, as documented in this guide.

## 新手上路 {: #getting-started }

### Hello, World! ??

  - 用 AWS Lambda 來試? 但 S3 可能更為簡單...

### 新手上路 ??

  - 安裝 AWS CLI，並完成組態 (`aws configure`)。
  - 知道 `aws` 基本用法 (`aws [OPTIONS] COMMAND SUBCOMMAND [PARAMETERS]`) 及如何查詢某個 (sub)command 的用法 (`aws COMMAND [SUBCOMMAND] help`)。
  - 知道什麼是 named profile，如何組態、指定。
  - 知道 low/high-level commands 的差別 (例如 `aws s3api` 與 `aws s3`)。

參考資料：

  - [User Guide - AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) 說明 low/high-level commands 的差別。
  - [Using the AWS Command Line Interface \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-using.html) 感覺開始用 CLI 後，這裡的技巧會很有幫助 #ril
  - [Working with Amazon Web Services \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/chap-working-with-services.html) 幾個 AWS service 的操作範例 #ril

### 基本用法??

```
aws COMMAND [SUBCOMMAND] help
aws [OPTIONS] COMMAND SUBCOMMAND [PARAMETERS]
```

例如：

```
$ aws s3 help
$ aws s3 cp help
...

$ aws --profile s3-backup cp myfolder s3://mybucket/myfolder --recursive
```

參考資料：

  - [Usage - AWS Command Line Interface](https://aws.amazon.com/cli/#Usage) #ril
  - [aws — AWS CLI 1\.14\.14 Command Reference](http://docs.aws.amazon.com/cli/latest/reference/) #ril

### 可以取代 AWS Management Console??

  - [What Is the AWS Command Line Interface? \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) 提到 "all of the functionality provided by the AWS Management Console"

### 學習 AWS SDK??

  - [What Is the AWS Command Line Interface? \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) 提到 "take what you've learned to develop programs in other languages with the AWS SDK"
  - [Generate CLI Skeleton and CLI Input JSON Parameters \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/generate-cli-skeleton.html) 似乎可以產生寫程式會用到的 JSON 設定?? #ril

### aws-shell??

  - [aws-shell (Developer Preview) - AWS Command Line Interface](https://aws.amazon.com/cli/#aws-shell_(Developer_Preview)) #ril
  - [Super\-Charge Your AWS Command\-Line Experience with aws\-shell \| AWS Developer Blog](https://aws.amazon.com/blogs/developer/super-charge-your-aws-command-line-experience-with-aws-shell/) (2015-12-15) #ril

## S3

### s3 sync

```
aws s3 sync SRC DEST --dryrun [OPTION]...
```

參考資料：

  - [sync — AWS CLI 1\.16\.20 Command Reference](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html) #ril

## 安裝設置 {: #setup }

### 在 Unix-like 上安裝 AWS CLI

  - 用 `virtualenv awscli` 建立一個虛擬環境，然後在環境內安裝 `awcli` 套件，再用 symbolic link 將環境內 `bin/aws` 引出來即可。
  - 之後昇級只要進到該 virtualenv 執行 `pip install -U awscli` 即可。

參考資料：

  - [AWS Command Line Interface](https://aws.amazon.com/cli/) Python 2.6.5+ 上用 `pip` 安裝 `awscli` 套件即可。
  - [Installing the AWS Command Line Interface \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html) Linux、Windows、macOS 全平台都用 `pip` 安裝，支持 Python 2.6.5+ / 3.3+，用 `pip install awscli --upgrade --user` 安裝 (其中 `--user` 會安裝到家目錄底下)，最後用 `asw --version` 確認。

### 用 Docker 執行 AWS CLI??

```
docker run --rm python bash

```

參考資料：

  - [GitLab CI: Deployment & Environments \| GitLab](https://about.gitlab.com/2016/08/26/ci-deployment-and-environments/) 利用 `python:latest` + `pip install awscli` 安裝。
  - [Using the official AWS CLI version 2 Docker image \- AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html) #ril

### 與 AWS account 連結

```
aws configure [--profile PROFILE]
```

設定 _PROFILE_ 的 IAM user (access key ID + secret access key)，預設是 `default` profile。例如：

```
$ aws configure --profile s3-backup
AWS Access Key ID [None]: YOURKEYID
AWS Secret Access Key [None]: YOURSECRET
Default region name [None]:
Default output format [None]: json
```

其中 default region 預設是距離最新的，而 output format 預設是 `json`，也可以是 `text` 或 `table`。這些資訊會分別存在 `~/.aws/` 下的 `credentials` 與 `config` (權限是 600)。

```
$ ls -l ~/.aws/
total 16
-rw-------  1 jeremykao  staff   41 Dec 21 23:52 config
-rw-------  1 jeremykao  staff  125 Dec 21 23:52 credentials

$ cat ~/.aws/credentials
[s3-backup]
aws_access_key_id = YOURKEYID
aws_secret_access_key = YOURSECRET

$ cat ~/.aws/config
[profile s3-backup]
output = json
```

參考資料：

  - [Configuration basics \- AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) #ril

      - This section explains how to quickly configure basic settings that the AWS Command Line Interface (AWS CLI) uses to interact with AWS. These include your security credentials, the default output format, and the default AWS Region.
      - AWS requires that all incoming requests are cryptographically signed. The AWS CLI does this for you. The "signature" includes a date/time stamp. Therefore, you must ensure that your computer's date and time are set correctly. If you don't, and the date/time in the signature is too far off of the date/time recognized by the AWS service, AWS rejects the request.

    Quick configuration with `aws configure`

      - For general use, the `aws configure` command is the fastest way to set up your AWS CLI installation. When you enter this command, the AWS CLI prompts you for four pieces of information:

          - Access key ID
          - Secret access key
          - AWS Region
          - Output format

      - The AWS CLI stores this information in a PROFILE (a collection of settings) named `default` in the `credentials` file. By default, the information in this profile is used when you run an AWS CLI command that doesn't explicitly specify a profile to use. For more information on the credentials file, see Configuration and credential file settings

      - The following example shows sample values. Replace them with your own values as described in the following sections.

            $ aws configure
            AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
            AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
            Default region name [None]: us-west-2
            Default output format [None]: json

    Access key ID and secret access key

      - Access keys consist of an access key ID and secret access key, which are used to sign programmatic requests that you make to AWS. If you don't have access keys, you can create them from the AWS Management Console.

        As a best practice, do not use the AWS account root user access keys for any task where it's not required. Instead, create a new administrator IAM user with access keys for yourself.

        建立 IAM user 時，access type 可複選 Programmatic access 與 AWS Management Console access，前者會產生 access key ID 跟 secret access key，後者則會產生 (或可自訂) 登入 AWS Management Console 的 password。

        這意謂著 root user 的帳密也不能當做這裡的 access key ID 跟 secret access key 使用??

      - The only time that you can view or download the secret access key is when you create the keys. You cannot recover them later. However, you can create new access keys at any time. You must also have permissions to perform the required IAM actions.

  - [Configuring the AWS CLI \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) `aws configure` 設定某個 IAM user (access key ID + secret access key)、default region 及 default output format。可以用 `--profile` 設定不同的 IAM user (沒有指定，就視為 default profile)。
  - [Configuration Settings and Precedence - Configuring the AWS CLI \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#config-settings-and-precedence) CLI 會優先採用 command line options、環境變數 (`AWS_ACCESS_KEY_ID`、`AWS_SECRET_ACCESS_KEY`)，然後才是 `~/.aws/credentials` 與 ` ~/.aws/config` #ril

### 多個 Named Profile，對應不同的 IAM user?

  - 組態時用 `aws configure --profile PROFILE`，使用時用 `--profile PROFILE` 或 `AWS_PROFILE` 環境變數指定。
  - 目前好像只能用 `grep '\[profile' ~/.aws/config` 找出所有 profile?

參考資料：

  - [Configuring the AWS CLI \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) 鼓勵用 IAM user 來控制可以存取哪些 service 與 resource。
  - [Named Profiles \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html) 除了 `--profile`，也可以用 `AWS_PROFILE` 環境變數指定 #ril
  - `aws configure list help` 得知 `list` subcommand 不是列出所有的 named profile，而是列出特定 profile 的 configuration data。

## 參考資料 {: #reference }

  - [AWS Command Line Interface](https://aws.amazon.com/cli/)
  - [aws/aws-cli - GitHub](https://github.com/aws/aws-cli)
  - [awslabs/aws-shell - GitHub](https://github.com/awslabs/aws-shell)

社群：

  - [AWS Developer Forums: AWS Command Line Interface](https://forums.aws.amazon.com/forum.jspa?forumID=150)

手冊：

  - [User Guide - AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
  - [AWS CLI Command Reference](http://docs.aws.amazon.com/cli/latest/reference/)
  - [Environment Variables - AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-environment.html)
  - [Changelog](https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst)
