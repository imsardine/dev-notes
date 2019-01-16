# Cookiecutter

  - Cookiecutter 的存在，提供了一個可供參考的標準；隨著時間過去，不同類型專案的 cookiecutter 會被不斷地改善 (透過 code review)，之後要新起一個專案時，就不會搞不清楚要參考哪一個專案。

---

參考資料：

  - [audreyr/cookiecutter: A command\-line utility that creates projects from cookiecutters \(project templates\)\. E\.g\. Python package projects, jQuery plugin projects\.](https://github.com/audreyr/cookiecutter)
      - 從 project template (稱做 cookiecutter) 快速建立專案的 command-line 工具 -- 一個 project/template 裡可以混用多種程式語言 (也不一定要是程式語言)；雖然本身是用 Python 寫的 (支持 Python 2.7+ 及 3.4+)，但不需要會寫 Python
      - Templating 是用 Jinja2 做，所以要會一點點 Jinja2，甚至支援 directory/file names，例如 `{{cookiecutter.repo_name}}/{{cookiecutter.repo_name}}/{{cookiecutter.repo_name}}.py`。
      - 最後 Similar projects 整理了一些類似的專案，有些只用來產生特定的專案，除了 Yeoman 有 830 個星星外 (但專用於 web apps?)，其他星星都少得可憐。
  - [Learn the Basics of Cookiecutter by Creating a Cookiecutter — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/first_steps.html) 有兩句話很貼切
      - With Cookiecutter, you can easily bootstrap a new project from a standard form, which means you skip all the usual mistakes when starting a new project.
      - Now if you ever find yourself duplicating effort when starting new projects, you’ll know how to eliminate that duplication using cookiecutter.
  - [Cookiecutter: Project Templates Made Easy](https://www.pydanny.com/cookie-project-templates-made-easy.html) (2013-08-17) 實作最難 Creating reusable Python packages has always been annoying. There are no defined/maintained best practices (especially for setup.py), so you end up cutting and pasting hacky, poorly understood, often legacy code from one project to the other. 確實是如此!! 但也不僅止於 Python packages 這類型的專案。
  - [New context format by hackebrot · Pull Request \#848 · audreyr/cookiecutter](https://github.com/audreyr/cookiecutter/pull/848) Cookiecutter 要做很多改變，但為何沒有 sponsorship 事情就卡在那裡? #ril

## 新手上路 {: #getting-started }

  - 先試用過 `cookiecutter gh:audreyr/cookiecutter-pypackage`，發現有 choice 可以產生不同的檔案、有 y/n 的選項可以決定要不要產生哪些檔案或設定，彈性很大!

---

參考資料：

  - [audreyr/cookiecutter: A command\-line utility that creates projects from cookiecutters \(project templates\)\. E\.g\. Python package projects, jQuery plugin projects\.](https://github.com/audreyr/cookiecutter)
      - 要從 https://github.com/audreyr/cookiecutter-pypackage 快速建立一個 Python package，執行 `cookiecutter gh:audreyr/cookiecutter-pypackage` (其中 `gh` 是 GitHub 的意思)，會被要求輸入一些值 (template variables)，之後 Cookiecutter 就可以根據那些值在 CWD 建立專案。
      - 也可以用 local template，用 `cookiecutter path/to/cookiecutter-pypackage/` 即可，其中 `cookiecutter-pypackage` 下就是 project template 的結構。
      - Template variables 以 key-value pairs 的型式定義在 `cookiecutter.json` 裡，除非搭配 `--no-input` 使用，否則會被依序提示要提供 `cookiecutter.json` 裡不同 key 的值 (value 做為預設值)。
      - 使用過的 remote cookiecutter (不含 local cookiecutter)，都會儲存一份在 cookiecutters dir 裡 (預設是 `~/.cookiecutters/`)，之後就可以直接用 directory name，例如 `cookiecutter cookiecutter-pypackage` 會去找 `~/.cookiecutters/cookiecutter-pypackage/`。
      - Cookiecutter 自己的設定可以寫在 `~/.cookiecutterrc` (YAML)，裡面可以設定 default context (自訂 key/value pair，覆寫 template 裡的預設值)、cookiecutters dir。
      - 除了 `~/.cookiecutterrc` 裡用 `default_context:` 自訂 key-value pair 之外，也可以從 command line 覆寫 (相對於 default context，稱做 extra context)，例如 `cookiecutter --no-input gh:msabramo/cookiecutter-supervisor program_name=foobar startsecs=10`。
      - 支援 pre-/post-generate hooks -- 在產生專案前後呼叫外部 Python/shell script；用 Python script 才能跨平台，能跑 Cookiecutter 一定有 Python。
      - "Use it from Python" 可以包裝進自己的工具；[這裡](https://cookiecutter.readthedocs.io/en/latest/advanced/calling_from_python.html) 以 web framework 為例，若需要提供快速產生 project 的工具 (例如 Django 的 `django-admin.py startproject` 或 `npm init`)。

  - [Overview — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/overview.html) 簡單介紹 Cookiecutter 運作的原理 -- Input & Output

        cookiecutter-something/
        ├── {{ cookiecutter.project_name }}/  <--------- Project template
        │   └── ...
        ├── blah.txt                      <--------- Non-templated files/dirs
        │                                            go outside
        │
        └── cookiecutter.json             <--------- Prompts & default values

      - Template 在 `{{cookiecutter.xxx}}` 底下 (其中 `xxx` 通常是 `project_name`)，外面的檔案除了 `cookiecutter.json` 宣告 template variables (與預設值) 外，都與 template 無關。
      - 產生 project 時並不是在 CWD 直接放 project template 內的檔案，而是會產生一個 subdir，而 subdir 的名字就是 `{{cookiecutter.xxx}}` 的運算結果。

  - [Getting to Know Cookiecutter — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/tutorial1.html) 詳細介紹 Cookiecutter 的運作原理
      - 一樣以 `cookiecutter https://github.com/audreyr/cookiecutter-pypackage.git` 為例，會先 clone 進 `~/.cookiecutters/`，再 "fill in the blanks for your project"，重點會在 Step 3: Observe How It Was Generated，對照 template 與最後的產出。
      - This happens in `find.py`, where the `find_template()` method looks for the first jinja-like directory name that starts with cookiecutter. 這裡講的是 Cookiecutter 的內部實作 -- Determine which child directory of repo_dir is the project template. 根據 [source code](https://github.com/audreyr/cookiecutter/blob/master/cookiecutter/find.py#L25) `if 'cookiecutter' in item and '{{' in item and '}}' in item:` 會找有 `cookiecutter`、`{{` 與 `}}` 的目錄，不一定要以 `{{cookiecutter.` 開頭。

  - [Additional Tutorials — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/tutorials.html)

## Local/Remote Template/Cookiecutter ??

  - 雖然 cookiecutter 是專案名稱，但也習慣將 project template 稱做 cookiecutter，也之所以 local/remote template 的另一種說法是 local/remote cookiecutter。

---

參考資料：

  - [Getting to Know Cookiecutter — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/tutorial1.html) 一開頭就說 Cookiecutter is a tool for creating projects from cookiecutters (project templates).

  - [audreyr/cookiecutter: A command\-line utility that creates projects from cookiecutters \(project templates\)\. E\.g\. Python package projects, jQuery plugin projects\.](https://github.com/audreyr/cookiecutter) 簡介就提到 cookiecutter 就是 project template 的意思，而這個 template 可以來自本地或遠端，所以有 local/remote cookiecutter 的說法。

  - [Works directly with git and hg (mercurial) repos too & Works with private repos - Usage — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/usage.html#works-directly-with-git-and-hg-mercurial-repos-too)
      - 支援直接從遠端的 Git/Mercurial repository 直接建立專案，以 https://github.com/audreyr/cookiecutter-pypackage 為例，下面 4 種寫法都可以：

            $ cookiecutter https://github.com/audreyr/cookiecutter-pypackage.git # 走帳密
            $ cookiecutter git@github.com:audreyr/cookiecutter-pypackage.git # 走 SSH key
            $ cookiecutter https://github.com/audreyr/cookiecutter-pypackage # 試過這也可以!
            $ cookiecutter gh:audreyr/cookiecutter-pypackage # 除了 gh: (GitHub)，也支援 bb: (Bitbucket) 與 gl: (GitLab.com)

      - 有趣的是可以搭配 `--checkout <BRANCH>` 指定採用哪個 branch 的 template；擔心 repository 太多?
      - Works with private repos 提到在 repo URL 前加上 `ht+` 或 `git+` 提示 type of repo (例如 `hg+https://example.com/repo`)，但實驗發現不加也可以。
      - 不知道 Works with Zip files 會是什麼情境，竟然還有密碼保護的狀況 XD

  - [Keeping your cookiecutters organized - Usage — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/usage.html) Cookiecutter 0.7.0 後，用過的 cookiecutter 都會存一份在 `~/.cookiecutters/`；實驗確認，local cookiecutter 不會另存一份在 `~/.cookiecutters/`。

## Template Variables, Context ??

  - 實驗發現 `cookiecutter.json` 裡的 default value 都必須是字串，寫數字在執行期會出現 `TypeError: must be str, not int` 的錯誤。
  - [audreyr/cookiecutter: A command\-line utility that creates projects from cookiecutters \(project templates\)\. E\.g\. Python package projects, jQuery plugin projects\.](https://github.com/audreyr/cookiecutter) 提到 template variables、default context、extra context 等，指的都是相同的東西 -- key-value pair，只是由 template 自己提供時習慣稱做 template variable，由 `~/.cookiecutterrc` 提供時稱 default context，由 command line 額外覆寫時稱做 extra context。
  - [cookiecutter\-pypackage/cookiecutter\.json at master · audreyr/cookiecutter\-pypackage](https://github.com/audreyr/cookiecutter-pypackage/blob/master/cookiecutter.json) 原來 key-value pair 因為 Jinja2 的關係，可以有一些運算在裡面 (例如 `project_slug` 就是從 `project_name` 轉換出來的)，或許 context 的說法會比 variable 更為精確。
  - [Template Designer Documentation — Jinja2 Documentation \(2\.10\)](http://jinja.pocoo.org/docs/2.10/templates/) Template variables are defined by the context dictionary passed to the template. 原來 context 的說法是來自 Jinja。
  - [Choice Variables \(1\.1\+\) — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/choice_variables.html) #ril
  - [Dictionary Variables \(1\.5\+\) — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/dict_variables.html) 套用時是如何提示預設值的? #ril

## 自製 Cookiecutter ?? {: #create-your-own-cookiecutter }

  - Local cookiecutter 在開發自己的 cookiecutter 時很方便。
  - 將一個現成可運作的專案 "參數化"，是比較有效的做法。

---

參考資料：

  - [Learn the Basics of Cookiecutter by Creating a Cookiecutter — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/first_steps.html)
      - 瞭解 Cookiecutter 最簡單的方法是建立一個簡單的 (local) template，看它如何運作 -- 簡單來說：複製 source directory tree，並將 templating tags (`{{...}}`) 取代成 `cookiecutter.json` 裡定義的值。
      - 這裡用一個名叫 `HelloCookieCutter1` 的 (local) template 說明 -- 會產生一個 `.py` 檔，執行時會印 `Hello, xxx!`，會詢問 `.py` 的檔名，以及 `xxx` 的值。

            HelloCookieCutter/
            |- {{cookiecutter.directory_name}}/
            |  |- {{cookiecutter.file_name}}.py # 內容 print("Hello, {{cookiecutter.greeting_recipient}}!")
            |- cookiecutter.json

        `cookiecutter.json`:

            {
                "directory_name": "Hello",
                "file_name": "Howdy",
                "greeting_recipient": "Julie"
            }

      - Template tagging 裡的東西可以有 namespace，例如 `cookiecutter.directory_name` 是指 `cookiecutter` 這個 namespace 上的 `directory_name`，而 `cookiecutter` namespace 下的 variable，主要是來自 `cookiecutter.json`。

  - [Create a Cookiecutter From Scratch — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/tutorial2.html) 這份 tutorial 沒寫完，採用 `{{cookiecutter.project_slug}}` 做為目錄名稱。

  - [A Pantry Full of Cookiecutters - audreyr/cookiecutter](https://github.com/audreyr/cookiecutter#a-pantry-full-of-cookiecutters) 社群提供的 remote cookiecutters，通常命名 `cookiecutter-*`。

  - [Replay Project Generation — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/replay.html) replay 在製作 template 好像很方便? #ril

  - [Create your own Cookiecutter template](https://raphael.codes/blog/create-your-own-cookiecutter-template/) (2015-01-07) #ril
      - Are you doing the same steps over and over again every time you start a new programming project? It prompts users for input and uses the given information to RENDER templates.
      - 這裡以 Android 上的 Kivy app 為例，教大家先做一個 [cookiedozer](https://github.com/hackebrot/cookiedozer) (Cookiecutter for i18n Kivy Apps)。
      - 雖然 Kivy 本身跨平台，但建立 APK 的工具 Buildozr 並不是 (目前 2018-08-11 支援 Linux 與 macOS)，若目的是 debugging 則可以用 Kivy Launcher (Google Play Store)
      - 接下來的內容，對 Kivy 要有一些瞭解比較好 ...

  - [Extending our Cookiecutter template](https://raphael.codes/blog/extending-our-cookiecutter-template/) (2015-01-18) #ril

  - [Wrapping up our Cookiecutter template](https://raphael.codes/blog/wrapping-up-our-cookiecutter-template/) (2015-02-02) #ril

## Templating ??

  - 應該需要 Jinja 的快速入門，因為在這裡會用到 Jinja 的進階語法 ??
  - [I’m having trouble generating Jinja templates from Jinja templates - Troubleshooting — cookiecutter 1\.6\.0 documentation](http://cookiecutter.readthedocs.io/en/latest/troubleshooting.html#i-m-having-trouble-generating-jinja-templates-from-jinja-templates) #ril
  - [Templates in Context Values — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/templates_in_context.html) 出現 `"project_slug": "{{ cookiecutter.project_name|lower|replace(' ', '-') }}"` 與 `"pkg_name": "{{ cookiecutter.project_slug|replace('-', '') }}"` 的用法。
  - [Template Extensions — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/template_extensions.html) #ril

## Copy without Render ??

  - [Copy without Render — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/copy_without_render.html) #ril

## Pre-/Post-generate Hooks ??

  - [Using Pre/Post\-Generate Hooks \(0\.7\.0\+\) — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/hooks.html) #ril
  - [cookiecutter\-django/post\_gen\_project\.py at master · pydanny/cookiecutter\-django](https://github.com/pydanny/cookiecutter-django/blob/master/hooks/post_gen_project.py) #ril

## Conditional Files / Directories ??

  - [python \- Can I make a file optional based on a variable's value in cookiecutter\.json \- Stack Overflow](https://stackoverflow.com/questions/35005098/) #ril
  - [Conditional files / directories · Issue \#127 · audreyr/cookiecutter](https://github.com/audreyr/cookiecutter/issues/127) #ril
      - mgaitan: 提議檔名為空時，就不產生檔案，例如 `/{% if cookiecutter.some_var %}{{ cookiecutter.another }}.txt{% endif %}`
      - pydanny (collaborator): 因為 `%` 在 Windows 下不能做為檔名的關係，建議用 post-generate 來做這件事。

## Conditional Follow-up Questions ??

  - [Conditional follow\-up questions based on prior answers · Issue \#913 · audreyr/cookiecutter](https://github.com/audreyr/cookiecutter/issues/913)
      - pydanny: 想加這個功能，但還要考量所有的 platform。目前只能透過 post hook 來做，像 Cookiecutter Django 就是這麼做的。
  - 感覺可以在 variable 名稱後面加上 `_if_xxx` 來識別，例如 `pytest_version_if_use_pytest`；使用者看到 `if_xxx` 不成立時，就可以按 Enter 跳過 (採用預設值)。

## User Configuration ??

  - [User Config \(0\.7\.0\+\) — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/user_config.html) #ril
      - 檔名 `my-custom-config.yaml` 首度提到 YAML。
  - [cookiecutter package — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/cookiecutter.html?#cookiecutter.exceptions.InvalidConfiguration) exception `cookiecutter.exceptions.InvalidConfiguration` 提到若 configuration 不是個合法的 YAML，就會丟出錯誤。

## 同一個 Repo 提供多個 Cookiecutter ??

  - [Works directly with git and hg (mercurial) repos too & Works with private repos - Usage — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/usage.html#works-directly-with-git-and-hg-mercurial-repos-too) 可以搭配 `--checkout <BRANCH>` 指定採用哪個 branch 的 template；可以減少 repository 的數量
  - 把所有的 cookiecutter 放在同一個 repo 下的不同資料夾，先 clone 到本地端，就可以透過路徑指定不同的 cookiecutter?

## Python Integration ??

  - [Calling Cookiecutter Functions From Python — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/calling_from_python.html) #ril
  - [Suppressing Command\-Line Prompts — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/advanced/suppressing_prompts.html) #ril
  - [cookiecutter package — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/cookiecutter.html) #ril

## 安裝設定 {: #installation }

```
$ python3 -m venv ~/dev/cookiecutter
$ ~/dev/cookiecutter/bin/pip install cookiecutter
$ ln -s ~/dev/cookiecutter/bin/cookiecutter ~/bin
$ cookiecutter --version
...
```

參考資料：

  - [Install cookiecutter - Installation — cookiecutter 1\.6\.0 documentation](https://cookiecutter.readthedocs.io/en/latest/installation.html#install-cookiecutter) 用 pip 安裝 `cookiecutter` 套件。

## 參考資料 {: #reference }

  - [audreyr/cookiecutter - GitHub](https://github.com/audreyr/cookiecutter)
  - [A Pantry Full of Cookiecutters - audreyr/cookiecutter](https://github.com/audreyr/cookiecutter#a-pantry-full-of-cookiecutters) 社群提供的 remote cookiecutters。

文件：

  - [Cookiecutter - Read the Docs](https://cookiecutter.readthedocs.io/en/latest/)

社群：

  - [audreyr/cookiecutter - Gitter](https://gitter.im/audreyr/cookiecutter)
  - ['cookiecutter' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/cookiecutter)

手冊：

  - [Command Line Options](https://cookiecutter.readthedocs.io/en/latest/advanced/cli_options.html)

