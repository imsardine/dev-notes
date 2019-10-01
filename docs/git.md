# Git

## 新手上路 {: #getting-started }

  - [Git \- About Version Control](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control) #ril
  - [A Visual Git Reference](https://marklodato.github.io/visual-git-guide/index-en.html#rebase) #ril

## Revision, Reachable ??

  - [Git \- Revision Selection](https://git-scm.com/book/en/v2/Git-Tools-Revision-Selection) #il

      - By now, you’ve learned most of the day-to-day commands and workflows that you need to manage or maintain a Git repository for your source code control. You’ve accomplished the basic tasks of tracking and committing files, and you’ve harnessed the power of the staging area and lightweight topic branching and merging.

        Now you’ll explore a number of very powerful things that Git can do that you may not necessarily use on a day-to-day basis but that you may need at some point.

      - Revision Selection -- Git allows you to refer to a SINGLE commit, SET of commits, or RANGE of commits in a number of ways. They aren’t necessarily obvious but are helpful to know.

    Single Revisions

      - You can obviously refer to any single commit by its FULL, 40-character SHA-1 hash, but there are more human-friendly ways to refer to commits as well. This section outlines the various ways you can refer to any commit.

    Single Revisions > Short SHA-1

      - Git is smart enough to figure out what commit you’re referring to if you provide the FIRST FEW CHARACTERS of the SHA-1 hash, as long as that partial hash is AT LEAST FOUR CHARACTERS long and unambiguous; that is, no other object in the object database can have a hash that begins with the same prefix.

        For example, to examine a specific commit where you know you added certain functionality, you might first run the `git log` command to locate the commit:

            $ git log
            ...
            commit 1c002dd4b536e7479fe34593e72e6c6c1819e53b
            Author: Scott Chacon <schacon@gmail.com>
            Date:   Thu Dec 11 14:58:32 2008 -0800

                added some blame and merge stuff

        In this case, say you’re interested in the commit whose hash begins with `1c002dd...`. You can inspect that commit with any of the following variations of `git show` (assuming the shorter versions are unambiguous):

            $ git show 1c002dd4b536e7479fe34593e72e6c6c1819e53b
            $ git show 1c002dd4b536e7479f
            $ git show 1c002d

        Git can figure out a short, unique abbreviation for your SHA-1 values. If you pass `--abbrev-commit` to the `git log` command, the output will use shorter values but keep them unique; it defaults to using SEVEN characters but makes them longer if necessary to keep the SHA-1 unambiguous:

            $ git log --abbrev-commit --pretty=oneline
            ca82a6d changed the version number
            085bb3b removed unnecessary test code
            a11bef0 first commit

      - Generally, EIGHT TO TEN characters are more than enough to be unique within a project. For example, as of February 2019, the Linux kernel (which is a fairly sizable project) has over 875,000 commits and almost seven million objects in its object database, with no two objects whose SHA-1s are identical in the first 12 characters.

        就算是 Linux kernel 這麼大的專案，前 12 個字元就足以識別單一 commit，幾乎沒機會用到 40 個字元。

    Single Revisions > Branch References

      - One straightforward way to refer to a particular commit is if it’s the commit at the TIP OF A BRANCH; in that case, you can simply use the branch name in any Git command that expects a reference to a commit. For instance, if you want to examine the last commit object on a branch, the following commands are equivalent, assuming that the `topic1` branch points to commit `ca82a6d...`:

            $ git show ca82a6dff817ec66f44342007202690a93763949
            $ git show topic1

      - If you want to see which specific SHA-1 a branch points to, or if you want to see what any of these examples BOILS DOWN TO in terms of SHA-1s, you can use a Git plumbing tool called `rev-parse`. You can see Git Internals for more information about plumbing tools; basically, `rev-parse` exists for lower-level operations and isn’t designed to be used in day-to-day operations. However, it can be helpful sometimes when you need to see what’s really going on. Here you can run `rev-parse` on your branch.

            $ git rev-parse topic1
            ca82a6dff817ec66f44342007202690a93763949

    Single Revisions > RefLog Shortnames

      - One of the things Git does in the background while you’re working away is keep a “reflog” — a log of where your HEAD and branch references have been FOR THE LAST FEW MONTHS.

        You can see your reflog by using `git reflog`:

            $ git reflog
            734713b HEAD@{0}: commit: fixed refs handling, added gc auto, updated
            d921970 HEAD@{1}: merge phedders/rdocs: Merge made by the 'recursive' strategy.
            1c002dd HEAD@{2}: commit: added some blame and merge stuff
            1c36188 HEAD@{3}: rebase -i (squash): updating HEAD
            95df984 HEAD@{4}: commit: # This is a combination of two commits.
            1c36188 HEAD@{5}: rebase -i (squash): updating HEAD
            7e05da5 HEAD@{6}: rebase -i (pick): updating HEAD

        Every time your BRANCH TIP is updated for any reason, Git stores that information for you in this TEMPORARY HISTORY. You can use your reflog data to refer to older commits as well. For example, if you want to see the fifth prior value of the HEAD of your repository, you can use the `@{5}` reference that you see in the reflog output:

            $ git show HEAD@{5}

        發現 `git reflog` 在本地做 code review 時很方便，因為 `git pull --rebase` 造成的 HEAD 改變，都會初記錄下來，例如：

            $ git reflog
            c5c0828 (HEAD -> init, origin/init) HEAD@{0}: rebase finished: returning to refs/heads/init
            c5c0828 (HEAD -> init, origin/init) HEAD@{1}: pull --rebase: checkout c5c082895d626c0f61c197f99b3eacff42c228ae
            5f9837a HEAD@{2}: rebase finished: returning to refs/heads/init
            5f9837a HEAD@{3}: pull --rebase: checkout 5f9837ae0acdc29eb0a36c48dc540af4969e8342

            $ git diff HEAD@{2}.. # 寫成 head@{2} 也可以

        可以看出使用者從我們上次 pull (上次最新的 code) 到這次又改了什麼。

      - You can also use this syntax to see where a branch was some specific amount of time ago. For instance, to see where your `master` branch was yesterday, you can type

            $ git show master@{yesterday}

      - That would show you where tip of your `master` branch was yesterday. This technique only works for data that’s still in your reflog, so you can’t use it to look for commits older than a few months.

      - To see reflog information formatted like the `git log` output, you can run `git log -g`:

            $ git log -g master
            commit 734713bc047d87bf7eac9674765ae793478c50d3
            Reflog: master@{0} (Scott Chacon <schacon@gmail.com>)
            Reflog message: commit: fixed refs handling, added gc auto, updated
            Author: Scott Chacon <schacon@gmail.com>
            Date:   Fri Jan 2 18:32:33 2009 -0800

                fixed refs handling, added gc auto, updated tests

            commit d921970aadf03b3cf0e71becdaab3147ba71cdef
            Reflog: master@{1} (Scott Chacon <schacon@gmail.com>)
            Reflog message: merge phedders/rdocs: Merge made by recursive.
            Author: Scott Chacon <schacon@gmail.com>
            Date:   Thu Dec 11 15:08:43 2008 -0800

                Merge commit 'phedders/rdocs'

        雖然揭露了時間，但如果有用 `git commit --amend` 修改現有的 commit，該 commit 的時間點並不會變。

      - It’s important to note that reflog information is STRICTLY LOCAL — it’s a log only of what you’ve done in your repository. The references won’t be the same on someone else’s copy of the repository; also, right after you INITIALLY CLONE a repository, you’ll have an EMPTY reflog, as no ACTIVITY has occurred yet in your repository.

        Running `git show HEAD@{2.months.ago}` will show you the matching commit only if you cloned the project at least two months ago — if you cloned it any more recently than that, you’ll see only your first local commit.

        要大家都一樣，要改用下面 ancestry reference 的表示法。

      - Tip: Think of the reflog as Git’s version of shell history

        If you have a UNIX or Linux background, you can think of the reflog as GIT’S VERSION OF SHELL HISTORY, which emphasizes that what’s there is clearly relevant only for you AND YOUR “SESSION”, and has nothing to do with anyone else who might be working on the same machine.

    Single Revisions > Ancestry References

      - The other main way to specify a commit is via its ancestry. If you place a `^` (caret) at the end of a reference, Git resolves it to mean the PARENT OF THAT COMMIT. Suppose you look at the history of your project:

            $ git log --pretty=format:'%h %s' --graph
            * 734713b fixed refs handling, added gc auto, updated tests
            *   d921970 Merge commit 'phedders/rdocs'
            |\
            | * 35cfb2b Some rdoc changes
            * | 1c002dd added some blame and merge stuff
            |/
            * 1c36188 ignore *.gem
            * 9b29157 add open3_detach to gemspec file list

        Then, you can see the previous commit by specifying `HEAD^`, which means “the parent of HEAD”:

            $ git show HEAD^
            commit d921970aadf03b3cf0e71becdaab3147ba71cdef
            Merge: 1c002dd... 35cfb2b...
            Author: Scott Chacon <schacon@gmail.com>
            Date:   Thu Dec 11 15:08:43 2008 -0800

                Merge commit 'phedders/rdocs'

      - Note: Escaping the caret on Windows

        On Windows in `cmd.exe`, `^` is a special character and needs to be treated differently. You can either double it or put the commit reference in quotes:

            $ git show HEAD^     # will NOT work on Windows
            $ git show HEAD^^    # OK
            $ git show "HEAD^"   # OK

      - You can also specify a number after the `^` to identify which parent you want; for example, `d921970^2` means “the second parent of d921970.” This syntax is useful only for MERGE COMMITS, which HAVE MORE THAN ONE PARENT — the first parent of a merge commit is from the branch you were on when you merged (frequently `master`), while the second parent of a merge commit is from the branch that was merged (say, topic):

            $ git show d921970^
            commit 1c002dd4b536e7479fe34593e72e6c6c1819e53b
            Author: Scott Chacon <schacon@gmail.com>
            Date:   Thu Dec 11 14:58:32 2008 -0800

                added some blame and merge stuff

            $ git show d921970^2
            commit 35cfb2b795a55793d7cc56a6cc2060b4bb732548
            Author: Paul Hedderly <paul+git@mjr.org>
            Date:   Wed Dec 10 22:22:03 2008 +0000

                Some rdoc changes

        在 merge 之後，如何分辨誰是第一個 parent ??

      - The other main ancestry specification is the `~` (tilde). This also refers to the FIRST PARENT, so `HEAD~` and `HEAD^` are equivalent. The difference becomes apparent when you specify a number. `HEAD~2` means “the first parent of the first parent,” or “the grandparent” — it traverses the first parents the number of times you specify. For example, in the history listed earlier, `HEAD~3` would be

            $ git show HEAD~3
            commit 1c3618887afb5fbcbea25b7c013f4e2114448b8d
            Author: Tom Preston-Werner <tom@mojombo.com>
            Date:   Fri Nov 7 13:47:59 2008 -0500

                ignore *.gem

        This can also be written `HEAD~~~`, which again is the first parent of the first parent of the first parent:

            $ git show HEAD~~~
            commit 1c3618887afb5fbcbea25b7c013f4e2114448b8d
            Author: Tom Preston-Werner <tom@mojombo.com>
            Date:   Fri Nov 7 13:47:59 2008 -0500

                ignore *.gem

        很明顯地，實務上 `~` 會比 `^` 來得常用。

      - You can also combine these syntaxes — you can get the second parent of the previous reference (assuming it was a merge commit) by using `HEAD~3^2`, and so on.

        不過 `^` 後面接的數字最大也只是 2，應該不會有更多 parent ??

    Commit Ranges

      - Now that you can specify individual commits, let’s see how to specify ranges of commits. This is particularly useful for managing your branches — if you have a lot of branches, you can use range specifications to answer questions such as, “What work is on this branch that I HAVEN’T YET MERGED into my main branch?”

        這裡 haven't yet merged 暗示著，已經 cherry-pick 過的 change/commit 就會被濾除。

    Commit Ranges > Double Dot

      - The MOST COMMON range specification is the double-dot syntax. This basically asks Git to resolve a range of commits that are REACHABLE from one commit but aren’t reachable from another. For example, say you have a commit history that looks like Example history for range selection..

        ![Figure 137. Example history for range selection.](https://git-scm.com/book/en/v2/images/double-dot.png)

        Say you want to see what is in your `experiment` branch that hasn’t yet been merged into your `master` branch. You can ask Git to show you a log of just those commits with `master..experiment` — that means “all commits reachable from experiment that aren’t reachable from master.” For the sake of brevity and clarity in these examples, the letters of the commit objects from the diagram are used in place of the actual log output in the order that they would display:

            $ git log master..experiment
            D
            C

      - If, on the other hand, you want to see the opposite — all commits in master that aren’t in experiment — you can reverse the branch names. `experiment..master` shows you everything in `master` not reachable from `experiment`:

            $ git log experiment..master
            F
            E

        This is useful if you want to keep the `experiment` branch up to date and preview what you’re about to merge.

        用 `git log <FROM>..<TO>` 來看就會很直覺，預設採 `HEAD` (不含 `FROM` 本身)，常見的用法有：

          - 目前 topic branch 相較 master 多出什麼 -- `git log master..`
          - 目前 topic branch 相較 master 少了什麼，要 porting 過來 -- `git log ..master`

      - Another frequent use of this syntax is to see what you’re about to push to a remote:

            $ git log origin/master..HEAD

        This command shows you any commits in your current branch that aren’t in the `master` branch on your origin remote. If you run a `git push` and your current branch is tracking `origin/master`, the commits listed by `git log origin/master..HEAD` are the commits that will be transferred to the server.

      - You can also leave off one side of the syntax to have Git assume `HEAD`. For example, you can get the same results as in the previous example by typing `git log origin/master..` — Git substitutes `HEAD` if one side is missing.

  - [Git \- gitrevisions Documentation](https://git-scm.com/docs/gitrevisions) #ril

## Shallow Clone, Clone Depth ??

  - Shallow clone 最明顯的特徵是 `git log` 只會看到一筆記錄。

---

參考資料：

  - [How to make shallow git submodules? \- Stack Overflow](https://stackoverflow.com/questions/2144406/) #ril

      - Mauricio Scheffer: Is it possible to have shallow submodules? I have a superproject with several submodules, each with a long history, so it gets unnecessarily big dragging all that history.

      - VonC: New in the upcoming git1.8.4 (July 2013):

        > "git submodule update" can optionally clone the submodule repositories shallowly.

        See [commit 275cd184d52b5b81cb89e4ec33e540fb2ae61c1f](https://github.com/git/git/commit/275cd184d52b5b81cb89e4ec33e540fb2ae61c1f):

        > Add the `--depth` option to the `add` and `update` commands of "`git submodule`", which is then passed on to the `clone` command. This is useful when the submodule(s) are huge and you're not really interested in anything but the latest commit.

        因為參數是交給 `clone` 的關係，所以 `--depth` 只作用在個別的 `add`/`update`，並沒有記錄下來。

        With Git 2.10 (Q3 2016), you will be able to do

            git config -f .gitmodules submodule.<name>.shallow true

        其實就在 `.gitmodules` 裡為指定的 submodule 加上 `shallow = true` 的宣告。

## 工具 {: #tools }

  - [jonas/tig: Text\-mode interface for git](https://github.com/jonas/tig) #ril
  - [jesseduffield/lazygit: simple terminal UI for git commands](https://github.com/jesseduffield/lazygit) #ril
  - [tj/git\-extras: GIT utilities \-\- repo summary, repl, changelog population, author commit percentages and more](https://github.com/tj/git-extras) #ril

## 參考資料 {: #reference }

  - [git/git - GitHub](https://github.com/git/git)

社群：

  - ['git-rebase' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/git-rebase)

更多：

  - [Commit History](git-history.md)
  - [Diff & Patch](git-diff-pactch.md)
  - [Commit Message](git-message.md)
  - [Rebasing](git-rebase.md)
  - [Hook](git-hook.md)
  - [Submodule](git-submodule.md)

手冊：

  - [Git Reference](https://git-scm.com/docs)
