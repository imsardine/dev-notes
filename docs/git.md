# Git

## 新手上路 {: #getting-started }

  - [Git \- About Version Control](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control) #ril
  - [A Visual Git Reference](https://marklodato.github.io/visual-git-guide/index-en.html#rebase) #ril

## Diff ??

  - 搭配 `git config --global alias.vimdiff "difftool --tool=vimdiff --no-prompt"`，就可以視情況選用 `gif diff [--cached]` 或 `git vimdiff [--cached]`；後者會調用 Vim 的 diff mode，處理複雜的 diff 時很方便。

## Patching ??

  - `git format-patch` 只接受 commit，但它會完整保留 commit 的 meta-data 與 binary data，對方用 `git am` 套用；適合交換 commit(s)。
  - `git diff [--binary] [--cached]` 單純看兩個 tree 的 diff，不含 meta-data，預設不含 binary data，對方用 `git apply` 套用；適合單純交換 diff，無關 commit。

參考資料：

  - [version control \- How do I send a patch to another developer and avoid merge conflicts? \- Stack Overflow](https://stackoverflow.com/questions/293768/) Spoike: `git-diff` 可以產生兩個 commit 的差異 (`git diff fa1afe1 deadbeef > patch.diff`)，另一方用 `git apply` 套用即可 (`git apply patch.diff`)。
  - [What is the difference between 'git format\-patch and 'git diff'? \- Stack Overflow](https://stackoverflow.com/questions/4624127/) 最大的差別在 meta-data 與預設是否含 binary data
      - Rafid: `git format-patch` 只接受 commit，所以在 index 裡的 change 就只能用 `git diff --cached > index.patch`
      - Sylvain Defresne: A patch created with `git format-patch` will also include some META-INFORMATION about the commit (committer, date, commit message, ...) and will contains diff of BINARY DATA. Everything will be formatted as a mail, so that it can be easily sent. The person that receive it can then recreate the corresponding commit with `git am` and all meta-data will be intact. It can also be applied with `git apply` as it is a super-set of a SIMPLE DIFF.

        A patch crated with `git diff` will be a simple diff with context (think `diff -u`). It can also be applied with `git apply` but the META-DATA WILL NOT BE RECREATED (as they are not present). In summary, `git format-patch` is useful to transmit a COMMIT, while `git diff` is useful to get a DIFF BETWEEN TWO TREES.

  - [11\. Understanding Patches \- Git Pocket Guide \[Book\]](https://www.oreilly.com/library/view/git-pocket-guide/9781449327507/ch11.html) #ril
      - Instead of using `git-cherry-pick` we will create a patch file containing the changes and then IMPORT it. Git will REPLAY the commit and add the changes to the repository as a NEW COMMIT. 除了有機會把 patch file 交換到其他地方，`git-cherry-pick` 跟 `git-format-patch` 有什麼差別?? 因為 `git-cherry-pick` 也會產生新的 commit。
      - `git-format-patch` exports the commits as patch files, which can then be applied to another branch or cloned repository. The patch files represent a SINGLE COMMIT and Git replays that commit when you IMPORT the patch file. 按照官方文件的說法，確實是一個 commit 一個 patch file。
      - The old style process, when Git was used locally only without a remote repository, was to EMAIL THE PATCHEs to each other. This is handy if you only need to get someone a single commit without the need to merge branches and the overhead that goes with that.
  - [Creating and Applying Patch Files in Git \- Mijingo](https://mijingo.com/blog/creating-and-applying-patch-files-in-git) #ril
  - [Back to the future with Git’s diff and apply commands \| Oliver Davies \- Full Stack Web Developer (Drupal, Symfony, Laravel, Linux)](https://www.oliverdavies.uk/blog/back-to-the-future-git-diff-apply/) (2018-04-23) #ril
  - [Creating and Applying Git Patch Files](http://nithinbekal.com/posts/git-patch/) (2017-02-12) #ril
  - [Git \- git\-apply Documentation](https://git-scm.com/docs/git-apply) Apply a patch to files and/or to the index #ril
  - [Generating patches with -p - Git \- git\-diff Documentation](https://git-scm.com/docs/git-diff#_generating_patches_with_p) #ril
      - When ... "`git diff`" without the `--raw` option, or "`git log`" with the "`-p`" option, they do not produce the output described above; instead they produce a PATCH FILE. What the `-p` option produces is slightly different from the traditional diff format: 所以不能用 `patch` 套用??
  - [Git \- git\-format\-patch Documentation](https://git-scm.com/docs/git-format-patch) Prepare patches for e-mail submission #ril
      - Prepare EACH COMMIT WITH ITS PATCH IN ONE FILE per commit, formatted to resemble UNIX mailbox format. The output of this command is convenient for e-mail submission or for use with `git am`.
  - [Git \- git\-am Documentation](https://git-scm.com/docs/git-am) Apply a series of patches from a mailbox #ril

## Cherry Pick ??

  - Cherry pick 怎麼用 => `git cherry-pick <REVISION>` 就像 merge 一樣；SourceTree 先切到目標 branch，再從 Hisotry 選一或多個 commit，按右鍵選 Cherry Pick 即可 (但沒有加 `-x` 產生 `cherry picked from commit ...`)

---

參考資料：

  - [Git \- git\-cherry\-pick Documentation](https://git-scm.com/docs/git-cherry-pick) #ril

      - `git-cherry-pick` - Apply the changes introduced by some EXISTING COMMITS

            git cherry-pick [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
                              [-S[<keyid>]] <commit>…
            git cherry-pick --continue
            git cherry-pick --quit
            git cherry-pick --abort

    Description

      - Given ONE OR MORE existing commits, apply the change each one introduces, RECORDING A NEW COMMIT FOR EACH. This requires your working tree to be clean (no modifications from the `HEAD` commit).

        在 HEAD 上逐一套用多個 commit 所做的變更，感覺跟 rebase 很像 ??

      - When it is not obvious how to apply a change, the following happens: (發生衝突時)

          - The current branch and `HEAD` pointer stay at the last commit successfully made.
          - The `CHERRY_PICK_HEAD` ref is set to point at the commit that introduced the change that is difficult to apply.
          - Paths in which the change applied cleanly are updated both in the index file and in your working tree.

          - For conflicting paths, the index file records up to three versions, as described in the "TRUE MERGE" section of `git-merge`.

            The working tree files will include a description of the conflict bracketed by the usual conflict markers `<<<<<<<` and `>>>>>>>`.

            手動解完衝突後執行 `git cherry-pick --continue` 繼續。

          - No other modifications are made.

  - [Cherry\-Picking Explained // Think Like (a) Git](http://think-like-a-git.net/sections/rebase-from-the-ground-up/cherry-picking-explained.html)

      - Git's own online help has a perfectly accurate, if characteristically terse, description of what the command does:

        > Given one or more existing commits, apply the change each one introduces, recording a new commit for each.

      - I've already mentioned (back on the page about Garbage Collection) that a Git commit's ID is a hash of both its contents AND ITS HISTORY. So, even if you have two commits that introduce the exact same change, if they POINT TO DIFFERENT PARENT COMMITS, they'll have different IDs.

        What `git cherry-pick` does, basically, is take a commit from somewhere else, and "play it back" wherever you are right now. Because this introduces the SAME CHANGE WITH A DIFFERENT PARENT, Git builds a new commit with a different ID.

      - Let's go back to this example from the Reachability section:

        ![](http://think-like-a-git.net/assets/images2/reachability-example.png)

        If you were at node H in this graph, and you typed `git cherry-pick E` (yes, you'd actually type part or all of the SHA for the commit, but for simplicity's sake, I'll just use the labels that are already here), you'd wind up with a copy of commit E—let's call it "E prime" or E'—that pointed to H as its parent, like so:

        ![](http://think-like-a-git.net/assets/images2/cherry-pick-example-1.png)

      - Or, if you typed something like i`git cherry-pick C D E`, you'd wind up with this when you were done:

        ![](http://think-like-a-git.net/assets/images2/cherry-pick-example-2.png)

      - The important thing to notice here is that Git has copied changes made in one place, and REPLAYED them somewhere else.

  - [Using 'git cherry\-pick' to Simulate 'git rebase' // Think Like (a) Git](http://think-like-a-git.net/sections/rebase-from-the-ground-up/using-git-cherry-pick-to-simulate-git-rebase.html) #ril

      - Once you have `git cherry-pick` down, you can start off by thinking of `git rebase` as being a faster way to cherry-pick all of the commits in a given branch at once, rather than having to type out their IDs separately.

      - Let's go back to our trusty example, but this time add some branches...

        ![](http://think-like-a-git.net/assets/images2/before-rebase.png)

        Now, I could type this sequence of commands:

            git checkout foo
            git checkout -b newbar
            git cherry-pick C D E

        ![](http://think-like-a-git.net/assets/images2/cherry-pick-qua-rebase-example-midpoint.png)

        Then, I could type this:

            git checkout bar
            git reset --hard newbar # 讓目前 branch 的 HEAD 指向另一個 commit
            git branch -d newbar

        And leave my repository looking like this (note that the original D and E nodes are NO LONGER REACHABLE, because NO BRANCH POINTS TO THEM):

        ![](http://think-like-a-git.net/assets/images2/cherry-pick-qua-rebase-example-endpoint.png)

      - Or, I could have accomplished all that by typing this instead:

            git rebase foo bar

        In other words, `git rebase` (in this form) is a shortcut that lets you pick up entire sections of a repository and move them somewhere else.

        `git rebase foo bar` 可以讀做，將 bar 有但 foo 沒有的變更，以 foo 為基礎重做。這呼應了 [`git-rebase`](https://git-scm.com/docs/git-rebase) 中 `git rebase ... <upstream> <branch>` 說法：

        > If `<branch>` is specified, `git rebase` will perform an automatic `git checkout <branch>` before doing anything else. Otherwise it remains on the current branch.
        >
        > All changes made by commits IN THE CURRENT BRANCH BUT THAT ARE NOT IN `<upstream>` are saved to a temporary area.
        >
        > The current branch is reset to `<upstream>`, ... The commits that were previously saved into the temporary area are then reapplied to the current branch, one by one, in order.

  - [Cherry\-Picking specific commits from another branch \| ariejan de vroom](https://www.devroom.io/2010/06/10/cherry-picking-specific-commits-from-another-branch/) (2010-06-10) #ril

      - 將特定 commit 併進現在的 branch，這裡簡單用 master 跟 feature branch 做說明，在 feature branch 裡有個 commit 很重要，必須要先回 master (或其他 branch 需要用到)，怎麼做 => `git checkout master && git cherry-pick 62ecb3`
      - 做完 `git cherry-pick` 就會在 master 產生一個 "新的 commit"，就像 merge 一樣，如果有衝突的話要先 resolve。
      - Cherry pick 適用於單一個 commit，如果是連續的幾個 commit，要用 rebase !! 以 `76cada - 62ecb3 - b886a0` 這個 feature branch 為例，若只想要 `76cada - 62ecb3` (不要 `b886a0`) 的話，先建一個新的 branch: `git checkout -b newbranch 62ecb3` (從終點開始??)，然後再執行 `git rebase --onto master 76cada^`，就會讓 `76cada - 62ecb3` 進到 master ??

  - [Git \- git\-cherry Documentation](https://git-scm.com/docs/git-cherry) #ril

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

  - [Commit Message](git-message.md)
  - [Commit History](git-history.md)
  - [Rebasing](git-rebase.md)
  - [Hook](git-hook.md)
  - [Submodule](git-submodule.md)

手冊：

  - [Git Reference](https://git-scm.com/docs)
