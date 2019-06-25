# Sentry

  - [Sentry \| Error Tracking Software — JavaScript, Python, PHP, Ruby, more](https://sentry.io/welcome/) #ril

      - STOP HOPING your users will report errors

        Open-source ERROR TRACKING that helps developers monitor and fix crashes in real time. Iterate continuously. Boost efficiency. Improve user experience.

      - Users and LOGS provide clues Sentry provides answers

        這裡的 log 應該只是 exception，沒有一般的 log ??

      - Find out about exceptions right away

        Set up Sentry in minutes with just a few lines of code. Get notifications via email, SMS, or chat as part of an existing workflow when errors occur or RESURFACE.

      - Quickly find and fix production errors

        Triage, reproduce, and resolve errors with max efficiency and visibility. Exception handling with Sentry helps developers build better apps and iterate faster.

      - Error tracking built for community

        Sentry started as and remains a 100% open-source project, now delivered as a hosted service. Development aligns to security, observability, and production at scale.

        其中 hosted service 才是需要收費，但 Developer 方案不用錢 #ril

      - Is your data secure?  You better believe it.

        Just look at all the high-quality security features all accounts get, regardless of plan.

        Security:

          - Two-Factor Auth
          - Single Sign On support
          - Organization audit log

        Privacy:

          - Privacy Shield certified
          - PII data scrubbing ??
          - SSL encryption

      - Sentry tracks errors in all major languages and frameworks.

        泛稱為 platform，也包含 Cocoa (Objective-C、Swift) 及 Andorid、Kotlin 等；支援的平台比 HockeyApp / App Center 多很多。

      - It also integrates with your favorite apps and services

        整合 Slack 送通知可以理解，整合 GitHub、Jira、Trello 等是要做什麼 ??

  - [Platforms](https://sentry.io/platforms/) #ril
  - [Integrations](https://sentry.io/integrations/) #ril

## 新手上路 {: #getting-started }

  - [Sign up for Sentry - Get Started](https://sentry.io/signup/)

      - 提供 Sign up with GitHub 與 Sign up with Azure DevOps，在 Sign up 的過程中 New Identity 那一頁提到：

        If your Sentry organization already uses GitHub for Single Sign-On, click here.

      - 接著輸入 Name、Email 及 Organization Name，其中 Organization Name 一定要給。

        If you're signing up for a personal account, try using your own name.

    Configure your application > Configure Python (假設入門平台選 Python)

      - Install our Python SDK using pip:

            $ pip install --upgrade sentry-sdk==0.9.1

      - Import and initialize the Sentry SDK EARLY in your application’s setup:

            import sentry_sdk
            sentry_sdk.init("https://...@sentry.io/...") # 之後還可以看到

        這樣就能設定 uncaught exception handler? 應該是透過 [`sys.exceptionhook(type, value, traceback)`](https://docs.python.org/3/library/sys.html#sys.excepthook) 辦到的 ??

      - You can cause a Python error by inserting a divide by zero expression into your application:

            division_by_zero = 1 / 0

    初步測試像是：

        $ cat test.py
        import sentry_sdk
        sentry_sdk.init("https://...@sentry.io/...")
        division_by_zero = 1 / 0

        $ python test.py
        Traceback (most recent call last):
          File "test.py", line 3, in <module>
            division_by_zero = 1 / 0
        ZeroDivisionError: integer division or modulo by zero
        Sentry is attempting to send 0 pending error messages
        Waiting up to 2.0 seconds
        Press Ctrl-C to quit

    從 "Sentry is attempting to send ... Waiting up to 2.0 seconds" 看來，exception 往 Sentry 送並不是即時的 ?? 然後就可以 Issues 看到 `ZeroDivisionError`。

  - [Getting Started \- Docs](https://docs.sentry.io/error-reporting/quickstart/?platform=python) (Python) #ril

## 參考資料 {: #reference }

  - [Sentry](https://sentry.io/)

文件：

  - [Sentry Documentation](https://docs.sentry.io/)
