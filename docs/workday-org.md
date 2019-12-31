---
title: Workday / Organization
---
# [Workday](workday.md) / Organization

  - [Steps: Assign Membership Rules in Custom Organizations • Manage Workday • Reader • Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/_s4oistoTPTTjwfs7rhlSA) #ril

    Prerequisites

      - On the Maintain Organization Types report for custom organizations, set:

          - Allow Reorganization Tasks to Yes.
          - Position Assignment Unique to No.

        為什為 Maintain Organization Types 是個 report ??

    Context

      - Instead of assigning workers individually, MEMBERSHIP RULES enable you to assign multiple workers to custom organizations based on defined criteria. Membership rule calculations include active and terminated workers.

      - Membership rules can be:

          - Static Rules: Calculate and explicitly assign membership at the time that you apply the rule to the custom organization. To remove workers later, you must explicitly remove them or apply another static rule.

          - Dynamic Rules: Calculate membership when you access a custom organization on a report. Note that using dynamic membership rules on custom organizations with large numbers of workers can cause performance problems.

            為什麼特別提及 report ??

          - Semidynamic Rules: Calculate membership EVERY 4 HOURS. Semidynamic rules start as dynamic rules.

      - Static and semidynamic rules perform faster than dynamic rules. Static rules run once, whereas semidynamic rules determine membership dynamically and add or remove workers every 4 hours. Changing membership rules from dynamic to semidynamic can improve performance.

## 參考資料 {: #reference }

  - [Organizations, Roles, and Hierarchies - Administrator Guide](https://doc.workday.com/reader/3DMnG~27o049IYFWETFtTQ/4JbFWZbU_uuaTXb2ML7C6g)
