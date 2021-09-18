---
title: GitLab / Issue Management
---
# [GitLab](gitlab.md) / Issue

  - [Issues \- GitLab Documentation](https://docs.gitlab.com/ce/user/project/issues/) #ril

  - [Always start with an issue \| GitLab](https://about.gitlab.com/2016/03/03/start-with-an-issue/) (2016-03-03)

      - “Always start with an issue” says Job, VP of Product here at GitLab. Before you begin anything else, summarize your ideas in an issue and share it. IT’S SUCH A SIMPLE RULE, BUT THE IMPACT IS HUGE.

      - In this post we'll focus on issues for feature proposals specifically, but the rule applies in any case, no matter what kind of project you're working on. We say “start” with an issue and not “create” an issue, because ONE MIGHT ALREADY EXIST. Make sure to search in All issues (open and closed) to see if your idea has been proposed already.

    GitLab is a discussion about software

      - The benefits of collaboration start at the point of making an issue. By making an issue, you GET YOUR IDEAS OUT THERE, and this allows your collaborators to HAVE THEIR SAY EARLY in the process.
      - Non-programmers think that programmers are constantly tapping away at their keyboards on code. In fact software development is MORE LIKE A DISCUSSION, and it’s a more collaborative experience than it is a solitary one.
      - The tools GitLab provides make it easier to manage that discussion, and keep the FLOW OF CONVERSATION moving.

    An example of SOFTWARE AS A DISCUSSION

      - Let’s look at an example discussion as it took place around a specific feature proposal. Of course NOT EVERY ASPECT of collaboration is recorded on GitLab. We also use TEXT CHAT and we pop open a quick VIDEO CHAT sometimes. However, the issue tracker does give us INSIGHT into the collaborative experience.

        Text/video chat 本身不是問題，重點是要將結論寫回 issue。

      - In his recent [blog post about the Todo feature](https://about.gitlab.com/2016/03/02/gitlab-todos-feature-highlight/), GitLab developer Douglas told the story of how the Todo feature came to be in GitLab 8.5. #ril

        The [original issue](https://gitlab.com/gitlab-org/gitlab-ce/issues/2425) was posted 6 MONTHS BEFORE CODING BEGAN. The targeted milestone was moved from 8.4 to 8.5 during that time. The discussion continued for four months until the description was simplified. One of our designers, Andriy, came up with a second design reflecting the major decisions. The title changed seven times until finally it’s renamed Todos. There were 30 participants marked in the issue, but some may have just been watching, or may have taken other actions such as adding a label. In total, 13 people added to the discussion.

        At one point early on, Job summarized the NEXT ACTIONS to take and assigned them:

          - formal proposal (Job / Darby / other people)
          - mockups (Job)
          - design (Andriy)
          - implementation (any dev) (which turned out to be Douglas)
          - Implementation is a final step.

      - Let's consider the lifetime of this issue which started 174 days before the final release.

        The task was assigned to Douglas only on Feb 2nd, with 20 days left to that milestone. Douglas spent 11% of lifetime of this issue on implementation. He didn't create the merge request until 7 days before the release. That means over the course of the issue from start to close, only 4% of the lifetime of the issue was spent "coding". Douglas even spent the first week of implementation reading code and writing a proposal for how he would implement the feature.

        It’s in the merge request that Douglas and Douwe worked on refining edge cases. They worked out how it would get done according to the intention of the original issue. Each day, Douglas would make a number of commits, and then Douwe would give him feedback. Again, it's further evidence that the BULK OF WORK IS IN DISCUSSION AND COMMUNICATION.

        Of course, the Todo issue might be an extreme case, but it does highlight that software development is a discussion. Git commits themselves are JUST ONE ASPECT of the work software developers do. That is why tracking "commits" as evidence of productivity gives an INACCURATE METRIC of software development productivity.

    What happens if you don’t make an issue first?

      - There’s a danger with spending a lot of time WORKING ON YOUR OWN, BEFORE SHARING THE IDEA. As you develop it, and polish it, you run the risk of becoming too attached to it.

        When you present your polished prize, you risk spending more time justifying your decisions, such as why you didn’t do X or didn’t account for Y.

        By starting with an issue you also avert a number of risks which can introduce problems later on.

          - You may not know everything there is to consider.
          - There may be parts of the system you aren’t familiar with.
          - There may be limitations or possibilities you’re not aware of.
          - There may be factors for users you may not know.
          - There may be work going on in a parallel effort which relates your idea.

        The issue OPENS THE CONVERSATION, AND YOU GAIN THE BENEFITS OF COLLABORATION FROM THE START.

    What's contained in the initial issue for a feature proposal?

      - In the contribution guide, we call these "feature proposals" rather than "feature requests". This is a subtle but important nuance.

        A 'request' puts the onus on someone else to "fulfill" a request. Whereas a 'proposal' PUTS THE ONUS ON THE INITIAL PERSON WRITING THE ISSUE.

      - Please keep feature proposals as small and simple as possible, complex ones might be edited to make them small and simple. For changes in the interface, it can be helpful to create a mockup first. If you want to create something yourself, consider opening an issue first to discuss whether it is interesting to include this in GitLab.

        The Todo issue started with a long description which was later marked as "too complex". Thankfully it was kept and we can compare it.

    Are there times you don’t start with an issue?

      - Sure! When I’m working on something small, corrections or typo fixes, I don’t make an issue. Job said he also doesn't always make an issue. "For super small changes that don’t need to be discussed, for spontaneous outbursts of code or creativity or when you just can’t be bothered," Job said. We have to BE PRACTICAL, as with most rules, there are REASONABLE EXCEPTIONS.

      - The Merge Request (MR) has everything we need anyway. MRs have the SAME COLLABORATION TOOLS as issues.

          - Comments
          - Labels and Milestone
          - Notifications
          - References
          - Todo notifications

      - So this means I can still continue the conversation. Of course, I keep the MR in "WIP" MODE (work in progress) so it doesn't accidentally get merged. Then we're free to collaborate.

  - [4 ways to use GitLab Issue Boards \| GitLab](https://about.gitlab.com/blog/2018/08/02/4-ways-to-use-gitlab-issue-boards/) (2018-08-02) #ril

  - [Confidential issues \| GitLab](https://docs.gitlab.com/ee/user/project/issues/confidential_issues.html) #ril
  - [Due dates \| GitLab](https://docs.gitlab.com/ee/user/project/issues/due_dates.html) #ril

## Project Management

  - 在 Group level 定義通用的 labels，優先處理 bug、request 等；To Do 跟 Doing 也可以嗎?
  - 善用 group 的 milestone，建立 sprint 將要處理的 issue 拉進 milestone 裡。
  - 可惜 Issue > Board 不能跨 project 使用?

## Label

  - [Labels \| GitLab](https://docs.gitlab.com/ee/user/project/labels.html) #ril

## Priority

  - [Label priority - Labels \| GitLab](https://docs.gitlab.com/ee/user/project/labels.html#label-priority) #ril

## Milestone

  - [Milestones \| GitLab](https://docs.gitlab.com/ee/user/project/milestones/)

## Board

  - [Issue Boards \| GitLab](https://docs.gitlab.com/ee/user/project/issue_board.html) #ril
  - [One group level issue board in CE \(\#38337\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/38337) EE 已經支援，但 CE 還沒有? #ril


## My Board

  - [Overview of Issue Boards Across ALL projects \(\#15757\) · Issues · GitLab\.org / GitLab · GitLab](https://gitlab.com/gitlab-org/gitlab/-/issues/15757) #ril

## Crosslinking

  - [Linked issues \| GitLab](https://docs.gitlab.com/ee/user/project/issues/related_issues.html)

      - The simple “relates to” relationship moved to GitLab Free in 13.4.

        其他 relationsip (blocks, is blocked by) 目前還是只有 Premium 有。

      - Linked issues are a BI-DIRECTIONAL relationship between any two issues and appear in a block below the issue description. Issues can be ACROSS GROUPS AND PROJECTS.

        The relationship only shows up in the UI if the user can see BOTH ISSUES. When you try to close an issue that has open BLOCKERS, a warning is displayed.

        兩邊都能看才會出現也合理，否則看了不能點、或是 issue 抬頭揭露了敏感資訊也麻煩。

        所謂 blocker (擋路之人) 就是 blocks 或 is blocked by 的主詞，blocker 沒有關閉之前，被 block 的 issue 不能關。

    Add a linked issue

     1. Link one issue to another by selecting the add linked issue button (+) in the Linked issues section of an issue.

     2. Select the RELATIONSHIP the between the two issues. Either:

          - relates to
          - blocks
          - is blocked by

     3. Input the issue number or paste in the full URL of the issue.

        可以貼 full URL 的設計還滿貼心的，會自動轉換成簡短的表示法。

        Valid references are added to a temporary list that you can review.

     4. When you have added all the linked issues, select Add.

        When you have finished adding all linked issues, you can see them CATEGORIZED so their relationships can be better understood visually.

    Remove a linked issue

      - In the Linked issues section of an issue, click the remove button () on the right-side of each issue token to remove.

        Due to the bi-directional relationship, the relationship no longer appears in either issue.

  - [Crosslinking issues \| GitLab](https://docs.gitlab.com/ee/user/project/issues/crosslinking_issues.html) #ril

## Sub-issue

參考資料：

  - [Task Lists - Markdown \- GitLab Documentation](https://docs.gitlab.com/ee/user/markdown.html#task-lists) 本身就是用來做 task，若是同一個 list 條列其他 issue，不就是 sub-issue 了嗎，完成還會被劃上一條線!
  - [User should be able to create sub\-issue of an issue\. \(\#4182\) · Issues · GitLab\.org / GitLab Community Edition · GitLab](https://gitlab.com/gitlab-org/gitlab-ce/issues/4182) #ril

## Template

  - 每個專案都要設定一次有點麻煩? 或許可以共用一個 template project 做為起點? 最簡單的方法就是用 wiki 建立一個 template，複製貼上即可。
  - [Description templates \| GitLab](https://docs.gitlab.com/ee/user/project/description_templates.html) 用 `.gitlab` 下的 `.md` 來實現，可以內含 quick action 還不錯 #ril
  - [Merge Request Checklist \- GitLab Documentation](https://docs.gitlab.com/ce/development/database_merge_request_checklist.html) 用 merge request 的 template 實作 checklist 還滿不錯的!

  - [Link to new issue with a preselected template \(\#26595\) · Issues · GitLab\.org / GitLab FOSS · GitLab](https://gitlab.com/gitlab-org/gitlab-foss/-/issues/26595)

      - Templates in new issues are a useful tool to pre-fill information as part of a workflow. This requires a manual action, and unfortunately this is a bit tedious when an external application (or a README or something) points to a GitLab project's New Issue page from a link un a context that knows which kind of template should be set.
      - Allow the URL to contain the template to be set, so as to reach the New Issue page with a pre-selected template and pre-filled issue with the provided template.
      - benjamin melançon: Just noting that the precise key is `issuable_template`: http://localhost:3000/gitlab-org/gitlab-ce/issues/new?issuable_template=Bug

## 參考資料 {: #reference }

文件：

  - [Issues | GitLab](https://docs.gitlab.com/ee/user/project/issues/)

手冊：

  - [Project Members Permissions](https://docs.gitlab.com/ee/user/permissions.html#project-members-permissions)
