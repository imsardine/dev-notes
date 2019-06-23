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

        實驗發現，即便只是讀取，用 Read Only 的 API token 會遇到 `{"message":"Forbidden","code":"Forbidden"}` 的錯誤，改用 Full Access 即可。

    Parameters

      - `org_name` - The organization’s name

    Responses

        [AppResponse {
          id*: string($uuid) // The unique ID (UUID) of the app
          description: string // The description of the app
          display_name*: string // The display name of the app
          release_type: string // A one-word descriptive release-type value that starts with a capital letter but is otherwise lowercase
          icon_url: string // The string representation of the URL pointing to the app’s icon
          icon_source: string // The string representation of the source of the app’s icon
          name*: string // The name of the app used in URLs
          os*: string // The OS the app will be running on (1)
          owner*: Owner { // The information about the app’s owner
            id*: string($uuid) // The unique id (UUID) of the owner
            avatar_url: string // The avatar URL of the owner
            display_name*: string // The owner’s display name
            email: string // The owner’s email address
            name*: string // The unique name that used to identify the owner
            type*: string // The owner type. Can either be ‘org’ or ‘user’
          }
          app_secret*: string // A unique and secret key used to identify the app in communication with the ingestion endpoint for crash reporting and analytics
          azure_subscription: AzureSubscriptionResponse { ... }
          platform*: string // The platform of the app (2)
          origin*: string // The creation origin of this app (3)
          created_at: string // The created date of this app
          updated_at: string // The last updated date of this app
          member_permissions: [ // The permissions of the calling user (string) (4)
          ]

     1. `os` 的值可以是 `[Android, iOS, macOS, Tizen, tvOS, Windows, Linux, Custom]`
     2. `platform` 的值可以是 `[Java, Objective-C-Swift, UWP, Cordova, React-Native, Unity, Electron, Xamarin, Unknown]`
     3. `origin` 的值可以是 `[appcenter, hockeyapp, codepush]`
     4. `member_permissions` 的內容可以是 `[manager, developer, viewer, tester]`

## Versions

  - 跟 version 列表相關的 endpoint 有：

      - Distribute `GET /v0.1/apps/{owner_name}/{app_name}/releases`

        Return basic information about releases.

      - Analytics `GET /v0.1/apps/{owner_name}/{app_name}/analytics/versions`

        Count of active versions IN THE TIME RANGE ordered by version.

    後者是用來取各版本的使用量，所以只能針對某個日期區間查詢，前者傳回的資料跟 App Center 介面 Distribute > Releases 的資料很像，可以用來列舉所有的 version。

---

參考資料：

  - [Distribute `GET /v0.1/apps/{owner_name}/{app_name}/releases` - App Center API](https://openapi.appcenter.ms/#operations-distribute-releases_list)

      - Return basic information about releases.

    Parameters

      - `published_only`: `boolean` (query)

        When `true`, filters out releases that were uploaded but were never distributed. Releases that under deleted distribution groups will not be filtered out.

        雖然型態是 `boolean`，其實就是要求字串 `true`/`false`；什麼是 distributed ??

      - `scope`: `string` (query)

        When the scope is `tester`, only includes releases that have been distributed to groups that the user belongs to.

      - `owner_name`: `string` (path, required)

        The name of the owner

      - `app_name`: `string` (path, required)

        The name of the application

    Responses

        [{
          id: integer, // ID identifying this unique release.
          version: string, // The release’s version.             (1)
          short_version: string, // The release’s short version. (1)
          enabled: bolean, // This value determines the whether a release currently is enabled or disabled. (2)
          uploaded_at: string, // UTC time in ISO 8601 format of the uploaded time.
          destination_type: string, // OBSOLETE. Will be removed in next version. The destination type. (3)
          distribution_groups: [{...}], // OBSOLETE. Will be removed in next version. A list of distribution groups that are associated with this release.
          distribution_stores: [{...}], // OBSOLETE. Will be removed in next version. A list of distribution stores that are associated with this release.
          destinations: [{...}], // A list of distribution groups or stores.
          build: {
            branch: string, // The branch name of the build producing the release
            commit_hash: string, // The commit hash of the build producing the release
            commit_message: string, // The commit message of the build producing the release
          }
        }]

     1. `version` 跟 `short_version` 分別來自各平台提供的 metadata：

        `version`: For iOS: `CFBundleVersion` from `info.plist`. For Android: `android:versionCode` from `AppManifest.xml`.

        `short_version`: For iOS: `CFBundleShortVersionString` from `info.plist`. For Android: `android:versionName` from `AppManifest.xml`.

        有趣的是，就 Android 而言 `version` 指的是 version code，而 `short_version` 才是比較長的 version name。

     2. `enabled` 的說明 "whether a release currently is enabled or disabled" 從字面上看不出指的是什麼，因為 HockeyApp 的管理介面有 2 個可能相關的選項：

          - Status: This value should be identical to the app's approval or release status.
          - Crash Reports: This option enables that the server accepts crash reports for this version.

        猜想跟 Crash Reports 的開關比較像 ??

     3. `destination_type` 的值可以是 `group` 或 `store`

        `group`: The release distributed to internal groups and distribution_groups details will be returned.

        `store`: The release distributed to external stores and distribution_stores details will be returned.

  - [Analytics `GET /v0.1/apps/{owner_name}/{app_name}/analytics/versions` - App Center API](https://openapi.appcenter.ms/#operations-analytics-Analytics_Versions)

      - COUNT of ACTIVE versions in the TIME RANGE ordered by version.

        其中 count 感覺像是安裝數或 active user，但使用者若沒發生 crash，App Center 怎麼會知道 ??

    Parameters

      - `start`: `string($date-time)` (query, required)

        Start date time in data in ISO 8601 date time format

        離今天超過 90 天，會丟出 `From query parameter has to be less than 90 days old.` 的錯誤，不適合用來取得所有的 version ??

      - `end`: `string($date-time)` (query)

        Last date time in data in ISO 8601 date time format

      - `$top`: `integer($int64)` (query)

        The maximum number of results to return. (0 will fetch all results) Default value : 30

        參數名稱真有前置的 `$`，2019-06-03 實驗發現給 `0` 時反而拿不到結果，而且預設值是 10 而非 30。

      - `versions`: `array[string]` (query)

        實驗發現是只傳回指定 version 的數據。

      - `owner_name`: `string` (path, required)

        The name of the owner

      - `app_name`: `string` (path, required)

        The name of the application

  - [Crash `GET /v0.1/apps/{owner_name}/{app_name}/versions` - App Center API](https://openapi.appcenter.ms/#operations-crash-crashes_getAppVersions)

      - Gets a list of application versions. AVAILABLE FOR UWP APPS ONLY. (Deprecated)

        不像 `GET /v0.1/apps/{owner_name}/{app_name}/analytics/versions` 需要提供時段，跟 [HockeyApp `GET /api/2/apps/APP_ID/app_versions`](https://support.hockeyapp.net/kb/api/api-versions#-u-get-api-2-apps-app_id-app_versions-u-) 的用法比較像。

    Parameters

      - `owner_name`: `string` (path, required)

        The name of the owner

      - `app_name`: `string` (path, required)

        The name of the application

## Crash ??

  - [Errors `GET /v0.1/apps/{owner_name}/{app_name}/errors/errorGroups` - App Center API](https://openapi.appcenter.ms/#operations-errors-Errors_GroupList)

      - List of error groups

    Parameters

      - `version`: `string($string)` (query)

        預設會傳回所有 version 的資料，提供 `version` 時才會只傳回該 version 的資料。

      - `groupState`: `string($string)` (query)

      - `start`: `string($date-time)` (query, required)

        Start date time in data in ISO 8601 date time format

        開始時間一定要給，跟 Analytics `GET /v0.1/apps/{owner_name}/{app_name}/analytics/versions` 一樣，超過 90 天會丟 `From query parameter has to be less than 90 days old.` 的錯誤。

      - `end`: `string($date-time)` (query)

        Last date time in data in ISO 8601 date time format

      - `$orderby`: `string` (query)

        controls the sorting order and sorting based on which column. Default value : `count desc`

      - `$top`: `integer($int64)` (query)

        The maximum number of results to return. (0 will fetch all results till the max number.) Default value : 30

      - `errorType`: `string` (query)

        Type of error (handled vs unhandled), including All

        Available values : `all`, `unhandledError`, `handledError`

      - `owner_name`: `string` (path, required)

        The name of the owner

      - `app_name`: `string` (path, required)

        The name of the application

    Responses

        {
          nextLink: string, // (1)
          errorGroups: [{
            state*: string, // open, closed, ignored (2)
            annotation: string,
            errorGroupId*: string,
            appVersion*: string, (3)
            appBuild: string,
            count*: integer($int64), // (4)
            deviceCount*: integer($int64),
            firstOccurrence*: string($date-time),
            lastOccurrence*: string($date-time),
            exceptionType: string,
            exceptionMessage: string,
            exceptionClassName: string,
            exceptionClassMethod: boolean,
            exceptionMethod: string,
            exceptionAppCode: boolean,
            exceptionFile: string,
            exceptionLine: string,
            codeRaw: string,
            reasonFrames: [{...}],
            }]
          }]
        }

     1. `nextLink` 似乎跟分頁有關?? 會多一個 `$token` 參數
     2. 發現線上 API 會回傳 `Open` 而非 `open`，導致 Swagger Codegen 產生的程式在檢查結果時會出錯 XD

     3. 觀察 `appVersion` 的值不論是 Android 或 iOS 都固定是 `GET /v0.1/apps/{owner_name}/{app_name}/releases` 的 `short_version` 而非 `version`。

        也因此，查詢時若要限定 version，傳入的也是 `short_version`。

     4. `count` 是指該 error group 從 `start` 到 `end` (或現在) 發生的次數，若一個版本存在久一點，數字不一定會一直往上長 ??

  - [Errors `/v0.1/apps/{owner_name}/{app_name}/errors/errorCountsPerDay` - App Center API](https://openapi.appcenter.ms/#operations-errors-Errors_CountsPerDay)

      - Count of crashes or errors by day in the time range based the SELECTED VERSIONS. If `SingleErrorTypeParameter` is not provided, defaults to `handlederror`.

        文件怎麼可以錯成這樣 XD ... 是 `errorType`，預設是 `handledError`。

    Parameter

      - `version`: `string($string)` (query)

      - `start`: `string($date-time)` (query, required)

        Start date time in data in ISO 8601 date time format

      - `end`: `string($date-time)` (query)

        Last date time in data in ISO 8601 date time format

      - `errorType`: `string` (query)

        Type of error (handled vs unhandled), excluding All. Available values : `unhandledError`, `handledError`

        為什麼跟 `GET /v0.1/apps/{owner_name}/{app_name}/errors/errorGroups` 有 including/excluding All 的差別 ??

      - `owner_name`: `string` (path, required)

        The name of the owner

      - `app_name`: `string` (path, required)

        The name of the application

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
