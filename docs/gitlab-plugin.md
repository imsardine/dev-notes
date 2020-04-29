---
title: GitLab / Plugin
---
# [GitLab](gitlab.md) / Plugin

  - [System hooks \| GitLab](https://docs.gitlab.com/ee/system_hooks/system_hooks.html) #ril

    系統發生一些 event 時，可以對外送出 HTTP POST；類 web hook 的機制。

  - [Administrator Docs \| GitLab](https://docs.gitlab.com/ee/administration/#configuring-gitlab)

      - System hooks: Notifications when users, projects and keys are changed.
      - Plugins: With custom plugins, GitLab administrators can introduce custom integrations without modifying GitLab’s source code.

  - [CHANGELOG\.md · master · GitLab\.org / GitLab FOSS · GitLab](https://gitlab.com/gitlab-org/gitlab-foss/blob/master/CHANGELOG.md)

    12.7.0

      - RENAME GitLab Plugins feature to GitLab File Hooks. !22979

    10.6.0 (2018-03-22)

      - Add ability to use external plugins as an ALTERNATIVE to system hooks. !17003
      - Add plugins list to the system hooks page. !17518

    若 plugin 只是 system hook 的替代方案，改名為 File Hook 就可以理解，因為 plugin 可以做的事要更多才對；目前兩者都可以回應 event，只是 system hook 在 remote，而 plugin 在 GitLab local 而已。

  - [Plugins \(\#40812\) · Issues · GitLab\.org / GitLab FOSS · GitLab](https://gitlab.com/gitlab-org/gitlab-foss/-/issues/40812)

      - This issue evolved, latest state is in https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/17003 #ril

      - Sid Sijbrandij (Owner): Companies want to add their own features to GitLab without sharing the code with others by contributing it to the main repository (for security reasons, to iterate quickly, to have something specific to them, or to do something that doesn't meet our definition of done). Right now they have to RUN ON A FORK, that makes GitLab hard to keep up to date and we see that they tend not to upgrade.

        The proposal is to:

          - Rename PROJECT SERVICES to plugins (to make it clear that we have plugins and because project services never was a good name)
          - Allow LOCAL plugins by loading them automatically if they are in a directory that is not under version control in `/var/opt/gitlab/gitlab-rails/plugins`

        不過今天 (2020-03-21) gitlab.com 上 Settings > Integrations 的表格欄位還是 Service, Description -- 留有 "project service" 這說法的痕跡。

      - Mark Pundsack (Developer):

         1. Isn't this the same thing we bash against Jenkins for? 好像是 XD!
         2. Can all integrations be relegated to single files? I would imagine that would limit the kinds of things that can be done with this plugin architecture. e.g. modifying code diff displays to show inline static analysis results. Maybe we don't have any plugins like that today, but people will want them.
         3. There's value in third-party contributions. There's value in curating them and protecting users from the downside of UNMANAGED THIRD-PARTY CONTRIBUTIONS. Yet there's also value in allowing companies do have private integrations. Perhaps we could make it such that local plugins are only used for private company-specific integrations while public third-party integrations use a different (curated) mechanism.

      - Marin Jankovski (Owner): For security reasons we can't have the plugins inside of `/etc/gitlab` directory. This directory contains secrets, individual files and directory permissions are security tightened. We could find a better place, maybe `/var/opt/gitlab/gitlab-rails/plugins`. The holding directory is already accessible to unicorn and has the necessary permissions.

        I wonder whether we can avoid doing it this way tough. If we depend on user adding the file, bunch of things can go wrong (think of permissions, ownership, syntax errors and so on) and we have no way of verifying that those things are correct. It is even possible that the app could crash (in some cases).

        Is it possible if we can add a PLUGIN UPLOADER from within the application itself? This way we can ensure the correctness of the file and inform the user. We also remove the dependency on the FILESYSTEM MANUAL EDIT and with move with gitaly, this is becoming more important.

      - Sid Sijbrandij (Owner): These will execute as GitLab and can cause performance degradations. But this is the only way to CHANGE THINGS LIKE THE UI I think. We already have webhooks and custom git hooks https://docs.gitlab.com/ee/administration/custom_hooks.html (現在名為 server hook)

        最初希望 plugin 連 UI 都可以自訂，但後來 12.7.0 更名為 File Hook，是否宣告著 plugin 沒有這方面的規劃??

      - James Ramsay (Developer): am I correct to think this would require the plugin to be enabled for each project in the GitLab instance?

        A customer for which this is an important feature, wants plugins to be able to respond to system hooks like projects being created to check they already exist in an external system, and create a corresponding project in the external system if not. Additionally it would be preferable if instance pre-recieve hooks could also be managed from within the plugin. This would allow the customer to manage their various hooks in a single location, removing the need to have multiple individual scripts and a separate application listening for system hooks.

        Dmytro Zaporozhets: yes it will behave exactly like project service (project settings -> integrations page). But I still think about it. There is an alternative approach I currently consider which is having plugins STATELESS and execute for every project (or event like system hook) WITHOUT a possibility to configure anything in the UI.

      - Dmytro Zaporozhets (Owner): I made a different POC https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/17003 as alternative to https://gitlab.com/gitlab-org/gitlab-ee/merge_requests/3687.

        The new POC executes plugins same as SYSTEM HOOKS. So everything you can do with system hook you can do with a plugin. The implementation advantage is it does not affect GitLab database so plugins can be added and removed with fewer efforts.

        所以 plugin 是比 system hook 更好的選擇?

      - Dmytro Zaporozhets (Owner): I thought about plugins few times during the weekend and decided on next things:

          - Plugins should not depend on GitLab source code. That means plugin class should not inherit from existing PROJECT SERVICE.
          - In the first iteration, plugins should be STATELESS. No DB records on plugins. This way plugins can be managed simply by adding or removing files
          - Plugins should be triggered by same events as SYSTEM HOOKS as it allows different use cases like https://gitlab.com/gitlab-org/gitlab-ce/issues/40812#note_58074487 #ril
          - Plugins should be represented on PROJECT INTEGRATIONS PAGE and somewhere in admin area.

      - Dmytro Zaporozhets (Owner): ping @JobV to decide on the feature being CE or EE

        Job van der Voort: I think it's reasonable if this is CE, it will stimulate the use of it and it's something that will be used by opinionated teams, INDEPENDENT OF THEIR SIZE.

        Dmytro Zaporozhets: thanks. I completely agree with you.

      - Dmytro Zaporozhets (Owner): https://gitlab.com/gitlab-org/gitlab-ce/merge_requests/17003 is merged which means we have external plugin support as part of 10.6.

        TODO: Decide if we want any UI representation of the feature. For example, render read-only list of plugins at Admin -> System Hooks and Project -> Integrations pages.

  - [File hooks \| GitLab](https://docs.gitlab.com/ee/administration/file_hooks.html) #ril

      - With custom file hooks, GitLab administrators can introduce custom integrations without modifying GitLab’s source code.

        Introduced in GitLab 10.6. Until 12.8 the feature name was Plugins.

        若更名為 File Hook，跟 System Hook 就更難區分了?

      - Note: File hooks must be configured on the FILESYSTEM of the GitLab server. Only GitLab server administrators will be able to complete these tasks. Explore system hooks or webhooks as an option if you do not have filesystem access.

        反而 system hook 是不需要碰到 filesystem 的??

      - A file hook will run on each event so it’s up to you to filter events or projects within a file hook code. You can have as many file hooks as you want. Each file hook will be triggered by GitLab asynchronously in case of an event.

        For a list of events see the system hooks documentation.

        雖然與 system hook 不同，但能回應的事件是一樣的。

  - [Server hooks \| GitLab](https://docs.gitlab.com/ee/administration/server_hooks.html) #ril

## 參考資料 {: #reference }

文件：

  - [File hooks | GitLab](https://docs.gitlab.com/ee/administration/file_hooks.html)
