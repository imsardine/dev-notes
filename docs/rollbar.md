# Rollbar

  - [Rollbar \- Error Tracking Software for Ruby, Python, JavaScript, and more](https://rollbar.com/)

      - Deploy with confidence, MORE OFTEN

        Spend less time worrying and more time on improving code. With Rollbar, you can FEEL SAFE knowing every error is reported in real-time.

        Rollbar 切入的角度：測試當然重要，但儘早推到 production 驗證會更為踏實；就算發生錯誤，當下許多重要的細節也會被記錄下來，可以幫助快速定位問題。

      - Dev Automation is Here

        Rollbar automates the grunt-work of development so software teams can deploy more often

        除了 error tracking 還有其他功能 ?? 否則為何稱 Dev Automation? (這段後來被拿掉了)

      - Ops automation is 80% solved Dev automation is just beginning

        It’s pointless to deploy faster, if you don’t deploy often. We help companies increase their deployment frequency by 9x.

      - Rollbar automates ERROR MONITORING and TRIAGING, so developers can fix errors that matter within minutes, and build software quickly and painlessly.

        Where is your software delivery process stuck?

    Get tests from red to green faster

      - Diagnose and fix BROKEN TESTS faster

      - Get real-time results and stack traces with LOCAL VARIABLES

        因為測試過程中噴錯，rollbar 就會蒐集重要資訊，可以加速修正問題。

      - Fix broken tests before the build finishes

    Get through QA faster

      - Never wonder how to repro a bug again
      - Reduce the back and forth between dev and QA
      - Dedupe bug reports and prioritize bugs affecting many test cases

    Iterate in production faster

      - Monitor errors in real-time

      - Only fix WHAT MATTERS

        應該是從量級來看，如果錯誤不常發生就不急。

      - See exactly how and where the error occurred, and resolve within minutes

  - [Overview](https://docs.rollbar.com/docs)

    Rollbar provides real-time exception reporting and CONTINUOUS DEPLOYMENT MONITORING for developers. These docs will help you get up and running with Rollbar quickly and discover how Rollbar can help your team throughout your development process.

    跟 CD 什麼關係 ??

## 新手上路 {: #getting-started }

  - [Rollbar Terminology](https://docs.rollbar.com/docs/rollbar-terminology) #ril
  - [Users, Teams, and Accounts](https://docs.rollbar.com/docs/users-teams-accounts) #ril

## Project

  - [Projects - Tips for organizing your services and apps into Rollbar projects](https://docs.rollbar.com/docs/projects)

      - Data in your Rollbar account is organized into projects. A project represents a single deployable / release-able service or app, and has its own settings for notifications, [custom fingerprinting](https://docs.rollbar.com/docs/custom-grouping), user access, and more. #ril

        注意 account 與 user 的差異，user 是登入的使用者，但 (organization) account 是多個 project 的集合。

      - When first setting up a Rollbar account, a common question is "How should I set up my Rollbar projects?". Here are some recommendations:

        Rules of thumb for creating Rollbar projects

          - 1 deployable/releasable app or SERVICE ~ 1 Rollbar project
          - 1 git repo ~ 1 Rollbar project

        Other considerations for Rollbar projects

          - One rollbar project can contain errors FROM MULTIPLE LANGUAGES AND FRAMEWORKS. This is useful if, for instance, you have a web app with Javascript on the front-end and Rails on the back-end. If the front-end and back end are DEPLOYED TOGETHER and/or live in the same repo, then you can track them in a single Rollbar project.

            這呼應了前面 "1 deployable/releasable app or SERVICE" 的說法，代表同一 service 的多個 component 可以放在同一個 Rollbar project 下；畢竟 service 是個整體，錯誤之間也會有些關聯，例如界面上可以看 Co-Occurring Items。

          - Are you maintaining SHARED LIBRARIES that are used across multiple apps/services? If yes, and these libraries have their own git repositories, then you should set up a dedicated Rollbar project FOR EACH LIBRARY so that the MAINTAINERS will get notified when an error occurs in a dependent app/service.

            聽起來怪怪的? 執行期是跟著 application 一起，如何將 library 與 application 的錯誤分開回報??

    Create a Rollbar project

      - You must be a member of the OWNERS TEAM for an account to create projects within it.

      - There are two ways that an owner can create a new project:

          - Select + create new project from the dropdown list in the upper left of the Rollbar app.
          - Go to Account Settings → Projects. The url here should be: `https://www.rollbar.com/settings/accounts/{account_name}/projects`.

    Control Access to a Project.

      - Access to Rollbar projects is managed through teams.

        To assign a team to a project, go to Account Settings → Teams → {Team Name} → Add to Project.

        user 被加進 team，而 team 可以存取 project。

## Environment

  - 假設一個 project 有多個 cron job 要跑，拆不同 Rollbar project 設定上有重工，但共用一個 rollbar project 下，如何區分錯誤是來自哪個 cron job，尤其錯誤是發生在共用的程式時：

      - 按照 "1 deployable/releasable app or service ~ 1 Rollbar project" 的說法，共用一個 Rollbar project 是比較好的，畢竟 service 是個整體。
      - 若從 `environment` 的 prefix/suffix 下手 (例如 `prod-job1`)，之後若要看某個 env 的錯誤，要選很多 enviroment；有點在惡搞 environment。
      - 若共用 Rollbar project，如何區分錯誤來自哪裡? 或許可以考慮從 `host` property 下手? 假設不同 cron job 都在不同的 host 執行，例如 `host:job1`?
      - 有沒有 custom data 可以帶?? 例如 `report_exc_info(..., extra_data=None)`，但會不會之後查詢很困難?

    後來有個全新的想法 -- 為不同 (deployment) environment 建立不同的 Rollbar project，裡面的 (Rollbar) environment 用來區分 component。這麼做的好處有：

      - 將不同 environment 的數據完全隔開；但最上層的 Dashboard 下拉 Environment 時會看到所有專案全然不同的 component。
      - 不同 environment 下可以看個別 component 的問題，也可以一次看所有 component 的問題；但不同 component 的問題無法合併。

---

參考資料：

  - [Environments](https://docs.rollbar.com/docs/environments)

      - How to use `environment` and `host` properties when you deploy to multiple environments
      - Rollbar requires the `environment` property on all errors to indicate where they occurred (production, staging , qa , etc.).

      - The choice of which `environment` values to use is very important due to the following considerations:

          - Items cannot be MERGED if they are in different environments

          - The Dashboard, Items, and Deploys views can only show information from a SINGLE environment or ALL environments.

            Single/All 二擇一，中間沒有模糊地帶!!

            這裡的限制專指畫面左上方有選定特定 project 時 (才會有 RQL 可以用)，否則 Dashboard 跟 Items 都可以自由選擇 project 與 environment 的搭配，並沒有這樣的限制。

    Handling multiple production systems

      - Many of our customers deploy their apps to MULTIPLE PRODUCTION SYSTEMS, e.g. multiple zones in Amazon Web Services, Google Cloud Platform, Azure, etc.

        In this case, you might want to see all the items and deploys to any of your production environments at once, but also be able to track which system a particular error occurred in. You probably will want to merge items that occurred in different production environments if they have the same root cause.

    Recommended usage

      - Use the `environment` value `production` for all errors from and deploys to any production environment, even if you have multiple production environments.

      - Use the `host` property in your error payloads to include the 'FULL PATH' of the server where an error occurred, including the name of the region/zone, e.g. `us-east-1-web02` for the server `web-02` that is hosted in the `us-east-1` region.

      - If you follow this approach, you can then merge any items that occur in a production environment, regardless of which region/host it occured in.

        To find the items that are only occurring in a particular region, you can use the host advanced search option, which supports PREFIX SEARCH:

            host:us-east-1

        To find items that occurred on a specific server within the region, you can enter the fully-qualified host name:

            host:us-east-1-web02

    Access tokens & rate limits

      - It's likely that you care more about errors coming from your production environment than from non-production environments, and that you don't want a non-production error to consume too many Rollbar events.

      - In order to ensure that you can use Rollbar in all your environments but limit event consumption in non-production environments, we recommend the following:

          - Create a set of access tokens for your non-production environments, and apply a rate limit that makes sense for you.

          - Create a set of access tokens for your production environments, and DON'T apply rate limits, unless you can accept losing some error data from production.

            這建議完全沒有參考價值!! 況且界面並沒有 "no rate limit" 的選項??

## 參考資料 {: #reference }

  - [Rollbar](https://rollbar.com/)

文件：

  - [Rollbar Docs](https://docs.rollbar.com/)

更多：

  - [Python SDK](pyrollbar.md)
