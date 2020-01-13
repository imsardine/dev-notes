---
title: AWS SDK for PHP
---
# [AWS SDK](aws-sdk.md) / for PHP

## 新手上路 {: #getting-started }

  - [`version` - Configuration for the AWS SDK for PHP Version 3 \- AWS SDK for PHP](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/guide_configuration.html#cfg-version) #ril

      - Type: `string`, Required: true

      - The version of the web service to use (e.g., 2006-03-01).

      - A “version” configuration value is required. Specifying a VERSION CONSTRAINT ensures that your code will not be affected by a breaking change made to the service.

        Java SDK 有這種東西嗎?? 好像跟 server-side 用的 API model 有關??

        For example, when using Amazon S3, you can lock your API version to 2006-03-01.

            $s3 = new Aws\S3\S3Client([
                'version' => '2006-03-01',
                'region'  => 'us-east-1'
            ]);

      - A list of available API versions can be found on each client’s API documentation page. If you are unable to load a specific API version, you might need to UPDATE YOUR COPY of the SDK.

      - You can provide the string `latest` to the “version” configuration value to use the most recent available API version that YOUR CLIENT’S API PROVIDER CAN FIND (the `default api_provider` scans the `src/data` directory of the SDK for API MODELS).

            // Use the latest version available
            $s3 = new Aws\S3\S3Client([
                'version' => 'latest',
                'region'  => 'us-east-1'
            ]);

        Warning: We do not recommend Using `latest` in a production application because pulling in a new minor version of the SDK that includes an API update could break your production application.

        若將 SDK 的版本固定，用 `latest` 也不好嗎??

## 參考資料 {: #reference }

  - [AWS SDK for PHP](https://aws.amazon.com/sdk-for-php/)

文件：

  - [AWS SDK for PHP Documentation](https://docs.aws.amazon.com/sdk-for-php/index.html)

手冊：

  - [API Reference 3.x](https://docs.aws.amazon.com/aws-sdk-php/v3/api/)
