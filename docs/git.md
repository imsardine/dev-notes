# Git

## 新手上路 {: #getting-started }

  - [Git \- About Version Control](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control) #ril
  - [A Visual Git Reference](https://marklodato.github.io/visual-git-guide/index-en.html#rebase) #ril

## 工具 {: #tools }

  - [jonas/tig: Text\-mode interface for git](https://github.com/jonas/tig) #ril
  - [jesseduffield/lazygit: simple terminal UI for git commands](https://github.com/jesseduffield/lazygit) #ril
  - [tj/git\-extras: GIT utilities \-\- repo summary, repl, changelog population, author commit percentages and more](https://github.com/tj/git-extras) #ril

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
  - [Back to the future with Git’s diff and apply commands \| Oliver Davies \- Full Stack Web Developer \(Drupal, Symfony, Laravel, Linux\)](https://www.oliverdavies.uk/blog/back-to-the-future-git-diff-apply/) (2018-04-23) #ril
  - [Creating and Applying Git Patch Files](http://nithinbekal.com/posts/git-patch/) (2017-02-12) #ril
  - [Git \- git\-apply Documentation](https://git-scm.com/docs/git-apply) Apply a patch to files and/or to the index #ril
  - [Generating patches with -p - Git \- git\-diff Documentation](https://git-scm.com/docs/git-diff#_generating_patches_with_p) #ril
      - When ... "`git diff`" without the `--raw` option, or "`git log`" with the "`-p`" option, they do not produce the output described above; instead they produce a PATCH FILE. What the `-p` option produces is slightly different from the traditional diff format: 所以不能用 `patch` 套用??
  - [Git \- git\-format\-patch Documentation](https://git-scm.com/docs/git-format-patch) Prepare patches for e-mail submission #ril
      - Prepare EACH COMMIT WITH ITS PATCH IN ONE FILE per commit, formatted to resemble UNIX mailbox format. The output of this command is convenient for e-mail submission or for use with `git am`.
  - [Git \- git\-am Documentation](https://git-scm.com/docs/git-am) Apply a series of patches from a mailbox #ril

## 參考資料 {: #reference }

  - [git/git - GitHub](https://github.com/git/git)

社群：

  - ['git-rebase' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/git-rebase)

更多：

  - [Commit Message](git-message.md)
  - [Commit History](git-history.md)
  - [Rebasing](git-rebase.md)
  - [Hook](git-hook.md)

手冊：

  - [Git Reference](https://git-scm.com/docs)
