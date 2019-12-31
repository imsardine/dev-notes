# AWS CLI

  - [AWS Command Line Interface Documentation](https://docs.aws.amazon.com/cli/) #ril

    The AWS Command Line Interface (AWS CLI) is a unified tool that provides a consistent interface for interacting with all parts of AWS. AWS CLI commands for different services are covered in the accompanying user guide, including descriptions, syntax, and usage examples.

  - [What Is the AWS Command Line Interface? \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) 基於 AWS SDK for Python (Boto) 建構出來的 CLI。除了 low level, API equivalent commands 外，也為複雜的 API 提供了一些 high level commands (customization)，例如 high-level `aws s3` 之於 low-level `aws s3api`，其中 low level commands (直接對應 public API)，可以用來學習 API 的用法，之後可以應用在 AWS SDK 上。

### 可以取代 AWS Management Console??

  - [What Is the AWS Command Line Interface? \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) 提到 "all of the functionality provided by the AWS Management Console"

### 學習 AWS SDK??

  - [What Is the AWS Command Line Interface? \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) 提到 "take what you've learned to develop programs in other languages with the AWS SDK"
  - [Generate CLI Skeleton and CLI Input JSON Parameters \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/generate-cli-skeleton.html) 似乎可以產生寫程式會用到的 JSON 設定?? #ril

### aws-shell??

  - [aws-shell (Developer Preview) - AWS Command Line Interface](https://aws.amazon.com/cli/#aws-shell_(Developer_Preview)) #ril
  - [Super\-Charge Your AWS Command\-Line Experience with aws\-shell \| AWS Developer Blog](https://aws.amazon.com/blogs/developer/super-charge-your-aws-command-line-experience-with-aws-shell/) (2015-12-15) #ril

## 基礎

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

### 多個 Named Profile，對應不同的 IAM user?

  - 組態時用 `aws configure --profile PROFILE`，使用時用 `--profile PROFILE` 或 `AWS_PROFILE` 環境變數指定。
  - 目前好像只能用 `grep '\[profile' ~/.aws/config` 找出所有 profile?

參考資料：

  - [Configuring the AWS CLI \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) 鼓勵用 IAM user 來控制可以存取哪些 service 與 resource。
  - [Named Profiles \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html) 除了 `--profile`，也可以用 `AWS_PROFILE` 環境變數指定 #ril
  - `aws configure list help` 得知 `list` subcommand 不是列出所有的 named profile，而是列出特定 profile 的 configuration data。

## S3

### s3 sync

```
aws s3 sync SRC DEST --dryrun [OPTION]...
```

參考資料：

  - [sync — AWS CLI 1\.16\.20 Command Reference](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html) #ril

## 安裝設定

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

  - [GitLab CI: Deployment & Environments \| GitLab](https://about.gitlab.com/2016/08/26/ci-deployment-and-environments/) 利用 `python:latest` + `pip install awscli` 安裝。

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

  - [Configuring the AWS CLI \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) `aws configure` 設定某個 IAM user (access key ID + secret access key)、default region 及 default output format。可以用 `--profile` 設定不同的 IAM user (沒有指定，就視為 default profile)。
  - [Configuration Settings and Precedence - Configuring the AWS CLI \- AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#config-settings-and-precedence) CLI 會優先採用 command line options、環境變數 (`AWS_ACCESS_KEY_ID`、`AWS_SECRET_ACCESS_KEY`)，然後才是 `~/.aws/credentials` 與 ` ~/.aws/config` #ril

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
