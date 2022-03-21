---
title: Google Workspace / Directory
---
# [Google Workspace](gws.md) / Directory

## Building, Floor, Floor Section

  - Building 的管理在 Directory > Buildings and resources > Manage resources 裡，但要進一步切換 Bulidings；在那裡可以找到 Buidling ID。

---

參考資料：

  - [Create buildings, features & Calendar resources \- Google Workspace Admin Help](https://support.google.com/a/answer/1033925?hl=en)

    Format for bulk updates

      - Building Id* - This Building ID must match exactly the Building ID defined for the building. Example: `SF-MAIN`

  - [Update a user profile - Add information to a user’s Directory profile \- Google Workspace Admin Help](https://support.google.com/a/answer/6191788?hl=en#individual)

    Click any of the following sections to edit the user's profile information:

    Employee information—ID, job title, employee type, manager email, department, cost center, building ID, floor name, and floor section

## Group Label

  - [Provide more secure access to data & resources \- Google Workspace Admin Help](https://support.google.com/a/answer/10607394/?hl=en)

      - As an administrator, you can use SECURITY GROUPS to grant access to sensitive information and resources.

        You can only NEST a security group inside another security group. This nesting limitation guarantees that only authorized people and groups can access sensitive information or resources. You can effectively turn any group into a security group.

        標上 Security 這個 group label，就可以讓一般的 group 變成 security group；這個轉變會影響什麼設定? 又使用上有什麼差別? 就不能拿一般 group 來設定 Drive 權限??

        目前 group label 無法自訂，只有 Mailing (傳統的 email-list group)、Security 跟 Dynamic groups 可選。

    Change a group into a security group

      - After you add a SECURITY LABEL to a group, it takes on the qualities of a security group. This process adds security features to any type of group and LOCKS DOWN MEMBERSHIP PERMISSIONS??, but it doesn’t remove any other features of the original group.

        這裡 lock down membership permissions 除了不能加入一般 group 外，還有什麼細微的差異??

         1. Sign in to your Google Admin console.

            Sign in using an administrator account, not your current account imsardine@gmail.com

         2. On the Admin console Home page, go to Groups.

         3. Click on the name of a group > Group Information > Labels.

         4. Check the Security box.

            Click Save.

            This action is PERMANENT. 確認後就回不去了

            The group now has a security label in the groups list.

    Automate security policies using dynamic security groups

      - You can enforce policies using dynamic groups by first adding a security label to them. ??

      - For example, you might set policies for everyone at your company who works in a specific geographic location.

         1. Create a dynamic group of everyone with that location in their user profiles.

            As employees move and change their location in their profile, the system automatically adds or removes them from the dynamic group.

            若使用者自己可以藉由調整 profile 來加入某個 security & dynamic group，是不是不妥??

         2. Add a security label to the dynamic group.

            Doing so allows you to apply policies to dynamic groups.

         3. Create a policy and choose which policies take precedence by following the steps in Customize service settings with configuration groups.

  - [Google Workspace Updates: Security groups help manage groups used for security and access control](https://workspaceupdates.googleblog.com/2020/09/security-groups-beta.html) (2020-09-03)

    What’s changing

      - We’re making security groups available in beta. Security groups help you easily regulate, audit, and monitor groups used for PERMISSION AND ACCESS CONTROL PURPOSES. They enable admins to:

          - Apply a label to any existing Google Group to distinguish it from EMAIL-LIST groups.

          - Provide strong guarantees that:

              - External groups (owned outside your organization) and non-security groups cannot be added as a member of a security group.
              - Security labels, once assigned to a group, cannot be removed.

      - Soon, you’ll be able to use more GRANULAR ADMIN ROLES to separate administration of security and non-security groups. Keep an eye on the G Suite Updates blog for an announcement when that rolls out.

    Who’s impacted

      - Admins and developers

    Why you’d use it

      - Groups are used in a variety of ways. This can include groups that help teams communicate and collaborate, as well as groups that control access to important apps and resources.

        Security groups can help customers manage these categories of groups differently to increase their overall security posture.

      - For example, if you have compliance or regulatory requirements for managing access control, you may have set up NAMING CONVENTIONS to keep track of which groups were used for this purpose. With security groups, you can now assign a security label to these groups and more easily manage them without having to use workarounds like naming conventions.
