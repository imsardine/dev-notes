---
title: Git / Commit History
---
# [Git](git.md) / Commit History

  - [Git \- Viewing the Commit History](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History) #ril

    Viewing the Commit History

      - After you have created several commits, or if you have cloned a repository with an existing commit history, you’ll probably want to look back to see what has happened. The most basic and powerful tool to do this is the `git log` command.

        These examples use a very simple project called “simplegit”. To get the project, run

            $ git clone https://github.com/schacon/simplegit-progit

        When you run `git log` in this project, you should get output that looks something like this:

            $ git log
            commit ca82a6dff817ec66f44342007202690a93763949
            Author: Scott Chacon <schacon@gee-mail.com>
            Date:   Mon Mar 17 21:52:11 2008 -0700

                changed the version number

            commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
            ...

      - By default, with no arguments, `git log` lists the commits made in that repository in reverse chronological order; that is, the most recent commits show up first. As you can see, this command lists each commit with its SHA-1 checksum, the author’s name and email, the date written, and the commit message.

        A HUGE NUMBER and variety of options to the `git log` command are available to show you exactly what you’re looking for. Here, we’ll show you some of the most popular.

      - One of the more helpful options is `-p` or `--patch`, which shows the difference (the patch output) introduced in each commit. You can also limit the number of log entries displayed, such as using `-2` to show only the last two entries.

            $ git log -p -2
            commit ca82a6dff817ec66f44342007202690a93763949
            Author: Scott Chacon <schacon@gee-mail.com>
            Date:   Mon Mar 17 21:52:11 2008 -0700

                changed the version number

            diff --git a/Rakefile b/Rakefile
            index a874b73..8f94139 100644
            --- a/Rakefile
            +++ b/Rakefile
            @@ -5,7 +5,7 @@ require 'rake/gempackagetask'
             spec = Gem::Specification.new do |s|
                 s.platform  =   Gem::Platform::RUBY
                 s.name      =   "simplegit"
            -    s.version   =   "0.1.0"
            +    s.version   =   "0.1.1"
                 s.author    =   "Scott Chacon"
                 s.email     =   "schacon@gee-mail.com"
                 s.summary   =   "A simple gem for using Git in Ruby code."

            commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
            ...

        This option displays the same information but with a diff directly following each entry. This is very helpful for CODE REVIEW or to quickly browse what happened during a series of commits that a collaborator has added.

        就 code review 而言，也要 commit 本身不會太複雜才行；有沒有 TUI 工具可以幫忙 ??

      - You can also use a series of SUMMARIZING OPTIONS with `git log`. For example, if you want to see some abbreviated stats for each commit, you can use the `--stat` option:

            $ git log --stat
            commit ca82a6dff817ec66f44342007202690a93763949
            Author: Scott Chacon <schacon@gee-mail.com>
            Date:   Mon Mar 17 21:52:11 2008 -0700

                changed the version number

             Rakefile | 2 +-
             1 file changed, 1 insertion(+), 1 deletion(-)

            commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7

        As you can see, the `--stat` option prints below each commit entry a list of modified files, how many files were changed, and how many lines in those files were added and removed. It also puts a summary of the information at the end.

        只有搬移檔案時，也會出現 `dir/file => newdir/file | 1 +` 的表示法；若單純搬移檔案沒有變更內容，則會是 `dir/file => newdir/file | 0`。

      - Another really useful option is `--pretty`. This option changes the log output to formats other than the default. A few prebuilt options are available for you to use. The `oneline` option prints each commit on a single line, which is useful if you’re looking at A LOT OF COMMITS. In addition, the `short`, `full`, and `fuller` options show the output in roughly the same format but with less or more information, respectively:

            $ git log --pretty=oneline
            ca82a6dff817ec66f44342007202690a93763949 changed the version number
            085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7 removed unnecessary test
            a11bef06a3f659402fe7563abf99ad00de2209e6 first commit

      - The most interesting option is `format`, which allows you to specify YOUR OWN log output format. This is especially useful when you’re GENERATING OUTPUT FOR MACHINE PARSING — because you specify the format explicitly, you know it won’t change with updates to Git:

            $ git log --pretty=format:"%h - %an, %ar : %s"
            ca82a6d - Scott Chacon, 6 years ago : changed the version number
            085bb3b - Scott Chacon, 6 years ago : removed unnecessary test
            a11bef0 - Scott Chacon, 6 years ago : first commit

        Useful options for `git log --pretty=format` lists some of the more useful options that format takes.

## 參考資料 {: #reference }

手冊：

  - [Useful options for `git log --pretty=format`](https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History#pretty_format)
  - [`git-log`](https://git-scm.com/docs/git-log)
