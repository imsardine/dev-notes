---
title: Git / Submodule
---
# [Git](git.md) / Submodule

  - [Git \- Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) #ril
  - [Where does Git store the SHA1 of the commit for a submodule? \- Stack Overflow](https://stackoverflow.com/questions/5033441/) 用 `git ls-tree` 可以看到稱做 gitlink (16000) 的 tree object #ril

## 移除 Submodule {: #remove }

跟 submodule 移除相關的指令有 `git submodule deinit` 與 `git rm`，先做一些實驗：

  - 直接執行 `git rm -f SUBMODULE_PATH`，會將 `SUBMODULE_PATH` 與 `.gitmodules` 裡的設定刪除，但 `.git/config` 裡相關的設定還在。

    之後執行 `git submodule deinit -f SUBMODULE_PATH` 則會出現下面的錯誤：

        error: pathspec '...path/to/submodule' did not match any file(s) known to git

  - 直接執行 `git submodule deinit -f SUBMODULE_PATH`，會將 `SUBMODULE_PATH` 的內容清空 (資料夾留著)，`.git/config` 裡的設定也會清掉，但 `.gitmodules` 的設定還在。

    之後執行 `git rm SUBMODULE_PATH` 可以把 `.gitmodules` 的設定清除。

因此移除 submodule 的標準步驟是 deinit --> rm：

    $ git submodule deinit -f SUBMODULE_PATH && git rm SUBMODULE_PATH

---

參考資料：

  - [`deinit` - Git \- git\-submodule Documentation](https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-deinit-f--force--all--ltpathgt82308203) #ril

        deinit [-f|--force] (--all|[--] <path>…)

      - UNREGISTER the given submodules, i.e. remove the whole `submodule.$name` section from `.git/config` together with their WORK TREE. Further calls to `git submodule update`, `git submodule foreach` and `git submodule sync` will SKIP ANY UNREGISTERED SUBMODULES until they are INITIALIZED AGAIN, so use this command if you don’t want to have a local checkout of the submodule in your working tree anymore.

        實驗發現 `git submodule deinit` 只會將 submodule path 的內容清空，但資料夾本身會留著。

      - When the command is run without pathspec, it errors out, instead of deinit-ing everything, to prevent mistakes.
      - If `--force` is specified, the submodule’s working tree will be removed even if it contains local modifications.

      - If you really want to remove a submodule FROM THE REPOSITORY and commit that use `git-rm` instead. See gitsubmodules for removal options.

  - [FORMS - Git \- gitsubmodules Documentation](https://git-scm.com/docs/gitsubmodules#_forms) #ril

      - When deinitialized or deleted (see below), the submodule’s Git directory is automatically moved to `$GIT_DIR/modules/<name>/` of the SUPERPROJECT.

        跑去 superproject 好怪，大概是為了做為備份?

      - Deleted submodule: A submodule can be deleted by running `git rm <submodule path> && git commit`. This can be undone using `git revert`.

        The deletion removes the superproject’s TRACKING DATA, which are both the `gitlink entry` and the section in the `.gitmodules` file. The submodule’s working directory is removed from the file system, but the Git directory is kept around as it to make it possible to checkout past commits without requiring fetching from another repository.

        To completely remove a submodule, manually delete `$GIT_DIR/modules/<name>/`.

## 追蹤某個 Branch {: #track-branch }

  - [Getting git submodule to track a branch \| ActiveState](https://www.activestate.com/blog/2014/05/getting-git-submodule-track-branch) (2014-05-14)
      - Submodule 在 git 裡以 subdirectory 來表現，內容來自另一個 git repo，用 `git submodule` 來操控。
      - Git 1.8.2+ 後 submodule 可以追蹤特定 branch，以前只能參照特定 commit，之後要手動更新參照的 commit 才行。
      - `git submodule add -b master https://github.com/Komodo/trackchanges.git src/modules/trackchanges` 中的 `-b master` 表示要持續追蹤 (follow) trackchanges repo 的 master branch。
      - 第一次用 `git submodule update --init` 初始化 submodule，之後更新用 `git submodule update --remote` 會更新到最新版；試過單純用 `git submodule update` 無效。
      - EDITING 在講直接在 subdirectory 裡修改 submodule 的內容，但為什麼要這樣做?
      - 用 `--remote` 更新後若有新的異動，此時 `git status` 會看到 `modified:   submodule (new commits)` ... 這有點惱人；`git submodule add -b` 只是在 `gitmodules` 裡增加一行資訊，之後可以用 `--remote` 更新到最新的 commit 而已，但在 main repo 看來就是有異動? 為此增加 commit 會不會很怪? 把它加進 `.gitignore` 就沒這個問題，但有負作用嗎?

  - [`-b, --branch` - Git \- git\-submodule Documentation](https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt---branch)

      - Branch of repository to add as submodule. The name of the branch is recorded as `submodule.<name>.branch` in `.gitmodules` for `update --remote`.

        記錄在 `.gitmodules` 裡的 `branch = xxx` 就是要搭配 `update --remote` 用的。

      - A special value of `.` is used to indicate that the name of the branch in the submodule should be the same name as the current branch in the current repository.

        跟著 superproject 的 branch 走 ??

  - [`--remote` - Git \- git\-submodule Documentation](https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt---remote)

      - This option is only valid for the `update` command. Instead of using the superproject’s recorded SHA-1 to update the submodule, use the status of the submodule’s REMOTE-TRACKING BRANCH.

        The remote used is branch’s remote (`branch.<name>.remote`), defaulting to `origin`. The remote branch used defaults to `master`, but the branch name may be overridden by setting the `submodule.<name>.branch` option in either `.gitmodules` or `.git/config` (with `.git/config` taking precedence).

      - This works for any of the supported UPDATE PROCEDURES (`--checkout`, `--rebase`, etc.). The only change is the SOURCE OF THE TARGET SHA-1. For example, `submodule update --remote --merge` will merge upstream submodule changes into the submodules, while `submodule update --merge` will merge superproject GITLINK CHANGES into the submodules.

        原來每個 submodule 在 superproject 都有記錄 SHA-1 (稱做 gitlink)，但如果要追蹤某個 branch 最新的變化，就不能管這個 SHA-1，而要採用 remote-tracking branch 最新 revision 的 HEAD (預設會先 fetch，跟 remote 同步)。有沒有加 `--remote` 的差別在於 target SHA-1 是來自 superproject 記錄的 SHA-1，還是 remote 的 SHA-1。

      - In order to ensure a current tracking branch state, `update --remote` FETCHES the submodule’s remote repository before calculating the SHA-1. If you don’t want to fetch, you should use `submodule update --remote --no-fetch`.

        用了 `--remote` 就會拿 remote-tracking branch 的 HEAD，但加了 `--no-fetch` 就不會先 fetch，也就是 remote-tracking branch 的 HEAD 可能跟 remote 有差距。

      - Use this option to integrate changes from the upstream subproject with your submodule’s current HEAD. Alternatively, you can run `git pull` from the submodule, which is equivalent except for the remote branch name: `update --remote` uses the default upstream repository and `submodule.<name>.branch`, while `git pull` uses the submodule’s `branch.<name>.merge`.

        Prefer `submodule.<name>.branch` if you want to distribute the default upstream branch with the superproject and `branch.<name>.merge` if you want a more native feel while working in the submodule itself. ??

## 參考資料 {: #reference }

  - [`git-submodule`](https://git-scm.com/docs/git-submodule)
  - [`gitmodules`](https://git-scm.com/docs/gitmodules)
