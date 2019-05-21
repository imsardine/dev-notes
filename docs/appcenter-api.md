---
title: App Center / API
---
# [App Center](app-center.md) / API

## HockeyApp Transition ??

  - [HockeyApp Transition \- Visual Studio App Center \| Microsoft Docs](https://docs.microsoft.com/en-us/appcenter/transition/index) #ril

## Authentication & Authorization {: #auth }

  - 每一個 API request 都必須帶有 `X-API-Token` header，可以從 Account Settings > API Tokens 產生 -- 可輸入 description 識別，但 token 之後就看不到了。

---

參考資料：

  - [Acquiring an App Center API token - App Center API Documentation \- Visual Studio App Center \| Microsoft Docs](https://docs.microsoft.com/en-us/appcenter/api-docs/#acquiring-an-app-center-api-token)

    Acquiring an App Center API token

      - Each API request must include an API token from your App Center account; to obtain a token:

          - Account Settings > API Tokens. In the text field, enter a DESCRIPTIVE NAME for your token.

          - Full Access: A full access API token has all the permissions that the associated user has FOR THAT APP. For example, if the user does not have manager or developer permissions for an app, the user cannot run a test (which requires developer or manager permissions) even though the user is using a full access API token.

            這裡 "for that app" 的說法有點怪，因為畫面上也無法選擇特定的 app。

          - Read Only: A read only API token has viewer access permissions. For example, with a read only API token, the user can perform actions such as reading data from crashes, analytics, and getting basic app information. Users cannot perform actions such as changing the app settings, triggering a build, creating an export configuration etc.
          - For security reasons, you will not be able to see or generate the same token again after you click the Close button.

    Using an API Token in an API request

      - When sending API requests to App Center from an application, you must include the API token in the HEADER of every request sent to App Center. Pass the API token in the request's `X-API-Token` header property.

    Using an API Token with the App Center Swagger

      - The App Center Swagger handles API authentication for you, so you don't have to worry about pasting the API token into all of your requests.

        On the upper right corner, click on the Authorize button. Under the APIToken section, paste the API token value that you just copied into the text field titled Value and click Authorize.

        If it shows "Authorized" and a Logout-Button, authorization was successful. 但外面的按鈕還是會寫 Autorize，只是右邊的鎖頭變成鎖起來的狀態。

    Find your App Center app name and owner name

      - Some of App Center's API and CLI require an APP NAME and OWNER NAME as parameters. An example is the API call to remove the user from the app, `DELETE /v0.1/apps/{owner_name}/{app_name}/users/{user_email}`.

        You can find the app name and owner name from your App Center app URL, or using the App Center CLI.

        URL 帶 owner/app name 而非 ID 的設計還滿妙的!!

      - When you look at your app's URL, it is in the format `https://appcenter.ms/users/{owner-name}/apps/{app-name}`. OWNER CAN BE A USER OR AN ORGANIZATION. For example,

          - User `https://appcenter.ms/users/joedeveloper/apps/DiceOut-01` --> `joedeveloper` / `DiceOut-01`
          - Org  `https://appcenter.ms/orgs/CrystalGeyser/apps/MacOS-app` --> `CrystalGeyser` / `MacOS-app`

        注意 owner 會因 user 或 org 不同，而有 `users/{owner_name}` 與 `orgs/{owner_name}` 的差異。

      - Execute the following command: `appcenter apps list` App Center displays a list of apps with the format `{owner-name}/{app-name}`.

        從 `owner-name` 無法直接分辦 owner 是 user 還是 organization，除非命名上有特別提示。

## Apps ??

  - [`GET /v0.1/orgs/{org_name}/apps` - App Center API](https://openapi.appcenter.ms/#operations-account-apps_listForOrg)

      - Returns a list of apps for the organization

    Parameters

      - `org_name` - The organization’s name

    實驗發現，即便只是讀取，用 Read Only 的 API token 會遇到 `{"message":"Forbidden","code":"Forbidden"}` 的錯誤，改用 Full Access 即可。

    Response Model (`[AppResponse ...]`) 比較重要的 attribute 有：

      - `id*`: `string($uuid)` -- The unique ID (UUID) of the app
      - `descriptios`: `string` -- The description of the app
      - `display_name*`: `string` -- The display name of the app
      - `name*`: `string` -- The name of the app used in URLs

      - `os*`: `string` -- The OS the app will be running on

        Enum: [ Android, iOS, macOS, Tizen, tvOS, Windows, Linux, Custom ]

      - `origin*`: `string` -- The creation origin of this app

        Enum: [ appcenter, hockeyapp, codepush ]

## CLI

  - [App Center Command Line Interface \(CLI\) \- Visual Studio App Center \| Microsoft Docs](https://docs.microsoft.com/en-us/appcenter/cli/)

      - App Center command line interface is a unified tool for running App Center services from the command line. Our aim is to offer a concise and powerful tool for our developers to use App Center services and easily SCRIPT A SEQUENCE OF COMMANDS that they'd like to execute. You can currently LOGIN and view/configure all the apps that you have access to in App Center.
      - Although our current feature set is minimal, all the existing App Center services will be added going forward. Note that the App Center CLI is currently in PUBLIC PREVIEW.
      - To get more information on CLI installation and currently supported commands, please refer to [App Center CLI GitHub repo](https://github.com/Microsoft/mobile-center-cli).

    Getting Started

      - App Center CLI requires Node.js version 8 or better.
      - Open a terminal/command prompt, and run `npm install -g appcenter-cli`.

      - Run `appcenter login`. This will open a BROWSER and generate a new API token. Copy the API token from the browser, and paste this into the command window.

        自動產生的 token 也可以在 Account Settings > API Tokens 看到，description 是電腦名稱，access 固定是 Full Access。這個 token 會被存在 `~/.appcenter-cli/profile.json`。

            $ cat ~/.appcenter-cli/profile.json | jq .
            {
              "userId": "1234-abcd-5678",
              "userName": "imsardine",
              "displayName": "Jeremy Kao",
              "email": "imsardine@gmail.com",
              "tokenSuppliedByUser": false
            }

      - There are two ways to use App Center CLI commands without running appcenter login prior:

          - Using the `--token` parameter: Create a Full Access API token (See steps 1-5). Open a terminal/command window. Add the `--token` switch to the CLI command you are running. For example, run `appcenter apps list --token {API-token}` to get a list of your configured applications.

          - Using the `APPCENTER_ACCESS_TOKEN` environment variable: You can set the `APPCENTER_ACCESS_TOKEN` environment variable with your API token. This will work without having to append the `--token` switch to each CLI command.

      - Running your first CLI command: Open a terminal/command window. Run `appcenter` to see a list of CLI commands. Run `appcenter profile list` to get the information about logged in user.

        For more details on a list of CLI commands, please refer to App Center CLI GitHub repo.

## Client Library ??

由於 API 用 OpenAPI Specification 定義，可以用 Swagger Codegen 產生 client library，以 Python 為例：

```
$ swagger-codegen generate -l python -DpackageName= -o /local/out \
    -i https://api.appcenter.ms/preview/swagger.json
```

## Diagnostics API ??

  - [Using the Diagnostics API \- Visual Studio App Center \| Microsoft Docs](https://docs.microsoft.com/en-us/appcenter/diagnostics/using-the-diagnostics-api)

    Transitioning to the new APIs

      - With our [App Center Diagnostics General Availability announcement](https://devblogs.microsoft.com/appcenter/announcing-the-general-availability-of-app-center-diagnostics/), we made some changes in our APIs to enable an improved BACKEND PIPELINE to process your crashes and errors. Depending on which APIs you use, there might be some action required on your end to ensure a smooth transition.

        按 "crashes and errors"，這兩種是不同的東西? 不過從 Old CrashesAPIs --> New Crashes APIs 的對照表看來，只是將 crash 更名為 error 而已；另外 crash reason 也更名為 error group。

        There are three types of crashes APIs:

          - Crashes APIs that map to new APIs after GA
          - Crashes APIs that no longer exist after GA
          - Crashes APIs that remain unaltered

    Crashes APIs that map to new APIs

      - Old APIs that now map to new APIs will be DEPRECATED NO LATER THAN JANUARY 2019. The old APIs will continue to work until then but you will need to use the new diagnostics APIs as listed in the table below before January 2019.

        Old crashes APIs marked as deprecated will still be available past January 2019 for UWP apps.

        也就是依平台要分別往不同的 API endpoint 取資料，不過 App Center 前台看 UWP app 時會被提示 "Crashes for this app can’t be forwarded from HockeyApp yet but we are working hard so that you can see all your data in one place."

    Crashes APIs that no longer exist

      - There are few crashes APIs that are deprecated due to changes in our backend pipeline. App Center is also now FORWARDING crashes from HockeyApp to App Center and these APIs are NO LONGER NEEDED. Read the HockeyApp migration documentation to learn more about the transition.

    Unaltered Crashes APIs

      - There are some crashes APIs that remain the same in the new pipeline. The following APIs will continue to work as expected and there is no action needed AT THIS TIME.

        只是暫時不會動到。

  - [`/apps/.../analytics/versions` - App Center API](https://openapi.appcenter.ms/#/analytics/Analytics_Versions) #ril

      - Count of ACTIVE?? versions in the time range ordered by version.

    Parameters

      - `start` (required) - Start date time in data in ISO 8601 date time format

        只能是 90 天內的日期，否則會遇到下面的錯誤：

            {
              "error": {
                "code": "InvalidInput",
                "message": "From query parameter has to be less than 90 days old."
              }
            }

      - `end` - Last date time in data in ISO 8601 date time format
      - `$top` - The maximum number of results to return. (0 will fetch all results)
      - `versions` - ? 要取 version 為什麼又給 version?
      - `owner_name` (required) - The name of the owner
      - `app_name` (required) - The name of the application

    Responses

      - Example Value

            {
              "versions": [
                {
                  "version": "string",
                  "count": 0,
                  "previous_count": 0
                }
              ],
              "total": 0
            }

      - Model

            Versions {
              versions [
                list of version count

                Version{
                  version - string - version
                  count - integer($int64) - version count
                  previous_count - integer($int64) - the count of previous time range of the version
              }]
              total - integer($int64) - the total count of versions
            }

        資料明顯比 HockeyApp 的 [`/apps/.../app_versions`](https://support.hockeyapp.net/kb/api/api-versions) 少很多。什麼是 version code?? 看似某個版本的安裝數量?

  - [`/apps/.../releases` - App Center API](https://openapi.appcenter.ms/#/distribute/releases_list) #ril

    Return basic information about releases.

    跟前端 Distribute > Releases 顯示的內容一致，只是畫面上的 Unique、Totoal (xxx downloads) 在 response 裡看不到?

    Parameters

      - `published_only` (boolean) - When `true`, filters out releases that were uploaded but were never DISTRIBUTED. Releases that under DELETED DISTRIBUTION GROUPS will not be filtered out. 預設是 `false`。
      - `scope` (string) - When the scope is `tester`, only includes releases that have been distributed to groups that THE USER BELONGS TO.
      - `owner_name` (path) - The name of the owner
      - `app_name` (path) - The name of the application

    Responses

      - Example Value

            [
              {
                "id": 0,
                "version": "string",
                "short_version": "string",
                "enabled": true,
                "uploaded_at": "string",
                "destination_type": "group",
                "distribution_groups": [
                  {
                    "name": "string",
                    "id": "string",
                    "is_latest": true
                  }
                ],
                "distribution_stores": [
                  {
                    "name": "string",
                    "id": "string",
                    "is_latest": true,
                    "type": "intune",
                    "publishing_status": "string"
                  }
                ],
                "destinations": [
                  {
                    "name": "string",
                    "id": "string",
                    "is_latest": true,
                    "type": "intune",
                    "publishing_status": "string",
                    "destination_type": "group"
                  }
                ],
                "build": {
                  "branch": "string",
                  "commit_hash": "string",
                  "commit_message": "string"
                }
              }
            ]

      - Model

        展開很細!!

  - [Announcing the General Availability of App Center Diagnostics](https://devblogs.microsoft.com/appcenter/announcing-the-general-availability-of-app-center-diagnostics/) (2018-11-15) #ril

## 參考資料 {: #reference }

  - [Microsoft/appcenter-cli - GitHub](https://github.com/Microsoft/appcenter-cli)

手冊：

  - [App Center API](https://openapi.appcenter.ms/)
  - [Commands - Microsoft/appcenter-cli - GitHub](https://github.com/microsoft/appcenter-cli#commands)
