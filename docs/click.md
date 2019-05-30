# Click

  - [Welcome to Click — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/)

      - Click is a Python package for creating beautiful command line interfaces in a COMPOSABLE way with as little code as necessary. It’s the “Command Line Interface Creation Kit”. It’s HIGHLY CONFIGURABLE but comes with SENSIBLE DEFAULTS out of the box.

        按 [Composability \- Wikipedia](https://en.wikipedia.org/wiki/Composability) 的說法 -- "A highly composable system provides components that can be selected and ASSEMBLED IN VARIOUS COMBINATIONS to satisfy specific user requirements."，就是可以任意組合的設計，猜想文件一直提到的 composable/composibility 指的就是 "subcommand/option/argument 編輯的自由度"?

        不過其中的 highly configurable，不包含 help message/page，下面會說明。

      - It aims to make the process of writing command line tools quick and fun while also preventing any frustration caused by the INABILITY to implement an intended CLI API.

      - Click in three points:

          - arbitrary nesting of commands 也就是 subcommand
          - automatic help page generation 下面 `$ python hello.py --help` 輸出還滿像樣的，沒有像 [Python Fire](python-fire.md) help message 很鳥的問題。
          - supports lazy loading of subcommands at runtime 如果 subcommand 的實作很大，但一般情況沒什麼差。

  - [Why Click? — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/why/)

      - There are so many libraries out there for writing command line utilities; why does Click exist? This question is easy to answer: because there is not a single command line utility for Python out there which ticks the following boxes:

          - is LAZILY COMPOSABLE without restrictions
          - supports implementation of Unix/POSIX command line CONVENTIONS 符合使用慣例很重要，CLI 該有的樣子
          - supports loading values from ENVIRONMENT VARIABLES out of the box 可惜環境變數不會出現在 help message 裡；可以自行補充嗎??
          - supports for prompting of custom values 尤其需要輸入密碼時
          - is fully nestable and composable
          - works the same in Python 2 and 3
          - supports file handling out of the box ??
          - comes with useful common HELPERS (getting terminal dimensions, ANSI colors, fetching direct keyboard input, screen clearing, finding config paths, launching apps and editors, etc.) 省掉很多事

      - There are many alternatives to Click and you can have a look at them if you enjoy them better. The obvious ones are `optparse` and `argparse` from the standard library. 雖然 Click 是基於 `optparse`，但根本不能比吧?

      - Click actually implements ITS OWN PARSING of arguments and does not use `optparse` or `argparse` following the `optparse` parsing behavior. The reason it’s not based on `argparse` is that `argparse` does not allow proper NESTING OF COMMANDS by design and has some deficiencies when it comes to POSIX COMPLIANT ARGUMENT HANDLING.

        這跟下面 "internally based on `optparse`" 的說法衝突，不過 argument handling 不足的地方是指??

      - Click is designed to be fun to work with and at the same time not stand in your way. It’s not OVERLY FLEXIBLE either. Currently, for instance, it does not allow you to customize the help pages too much. This is intentional because Click is designed to allow you to NEST command line utilities. The idea is that you can have a system that works together with another system by tacking two Click instances together and they will continue working as they should. 不懂為何 nest command (也就是 subcommand) 的支援跟 "works together with another system" 有關?? 又自訂 help page 跟 nesting 有什麼關係??

        Too much customizability would break this promise. 所幸 help page 看起來還不錯，不太需要自訂。

      - Click was written to support the Flask microframework ecosystem because no tool could provide it with the functionality it needed.

        所以 [Flask CLI](http://flask.pocoo.org/docs/1.0/cli/) 的那一塊是其他 library 不支援的??

      - To get an understanding of what Click is all about, I strongly recommend looking at the Complex Applications chapter to see what it’s useful for. 複雜的應用才能看出 Click 的能耐

    Why not Argparse?

      - Click is internally based on `optparse` instead of `argparse`. This however is an implementation detail that a user does not have to be concerned with. The reason however Click is not using `argparse` is that it has some problematic behaviors that make handling arbitrary command line interfaces hard:

          - `argparse` has built-in magic behavior to GUESS if something is an ARGUMENT or an OPTION. This becomes a problem when dealing with INCOMPLETE command lines as it’s not possible to know without having a full understanding of the command line how the parser is going to behave. This goes against Click’s ambitions of dispatching to SUBPARSERS. 若 subcommand 的用法不完整，也要能由 subcommand 指出錯誤的意思??
          - `argparse` currently does not support disabling of interspersed (散置的) arguments. Without this feature it’s not possible to safely implement Click’s NESTED PARSING nature.

    Why not Docopt etc.?

      - Docopt and many tools like it are cool in how they work, but very few of these tools deal with nesting of commands and composability in a way like Click. To the best of the developer’s knowledge, Click is the first Python library that aims to create a level of COMPOSABILITY of applications that goes beyond what the system itself supports. 超越 OS 對 CLI 的支持??

      - Docopt, for instance, acts by PARSING YOUR HELP PAGES and then parsing according to those rules. The side effect of this is that docopt is quite rigid (死板的) in how it handles the command line interface. The upside of docopt is that it gives you STRONG CONTROL OVER YOUR HELP PAGE; the downside is that due to this it cannot REWRAP your output for the current terminal width and it makes translations hard. On top of that docopt is restricted to basic parsing. It does not handle ARGUMENT DISPATCHING and callback invocation or TYPES. This means there is a lot of code that needs to be written in addition to the basic help page to handle the parsing results.

        為了美美的 help page 導致許多雜事都要自己來，好像不怎麼划算? 畢竟 CLI 的重點是 command line 的 UX。

      - Most of all, however, it makes composability hard. While docopt does support dispatching to subcommands, it for instance does not directly support any kind of AUTOMATIC SUBCOMMAND ENUMERATION?? based on what’s available or it does not enforce subcommands to work in a consistent way.

      - This is fine, but it’s different from how Click wants to work. Click aims to support fully composable command line user interfaces by doing the following:

          - Click does not just parse, it also DISPATCHES to the appropriate code. 從首頁的範例就可以看出，直接對應到 function。
          - Click has a strong concept of an INVOCATION CONTEXT?? that allows subcommands to respond to DATA FROM THE PARENT COMMAND. 什麼情況下需要拿 parent data??
          - Click has strong information available for all parameters and commands so that it can generate UNIFIED help pages for the full CLI and to assist the user in converting the input data as necessary.
          - Click has a strong understanding of what types are and can give the user CONSISTENT ERROR MESSAGES if something goes wrong. (也要符合慣例) A subcommand written by a different developer will not suddenly die with a different error message because it’s manually handled.
          - Click has enough META INFORMATION available for its whole program that it can evolve over time to improve the user experience without forcing developers to adjust their programs. For instance, if Click decides to change how help pages are formatted, all Click programs will automatically benefit from this.

      - The aim of Click is to make COMPOSABLE systems, whereas the aim of docopt is to build the most BEAUTIFUL and hand-crafted command line interfaces. (針對 help page，但重點還是 elegant UX) These two goals conflict with one another in subtle ways. Click actively prevents people from implementing certain patterns in order to achieve UNIFIED command line interfaces. You have very little input on reformatting your help pages for instance.

    Why Hardcoded Behaviors?

      - The other question is why Click goes away from `optparse` and hardcodes certain behaviors instead of staying configurable. There are multiple reasons for this. The biggest one is that too much configurability makes it hard to achieve a CONSISTENT COMMAND LINE EXPERIENCE.
      - The best example for this is `optparse`’s callback functionality for accepting an arbitrary number of arguments. Due to syntactical ambiguities on the command line, there is no way to implement fully variadic?? arguments. There are always tradeoffs that need to be made and in case of `argparse` these tradeoffs have been critical enough, that a system like Click cannot even be implemented on top of it. 採用 `argparse` 會失去某些彈性?
      - In this particular case, Click attempts to stay with A HANDFUL OF ACCEPTED PARADIGMS for building command line interfaces that can be well documented and tested.

    Why No Auto Correction?

      - The question came up why Click does not auto correct parameters given that even `optparse` and `argparse` support automatic expansion?? of long arguments. The reason for this is that it’s a liability (不利條件) for backwards compatibility. If people start relying on automatically modified parameters and someone adds a new parameter in the future, the script might stop working. These kinds of problems are hard to find so Click does not attempt to be magical about this. 聽起來 "auto correction" 有點危險??
      - This sort of behavior however can be implemented on a higher level to support things such as explicit ALIASES. For more information see Command Aliases. #ril

## 新手上路 {: #getting-started }

  - [Welcome to Click — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/)
      - What does it look like? Here is an example of a simple Click program:

            import click

            @click.command() <-- 大量的 decorator
            @click.option('--count', default=1, help='Number of greetings.')
            @click.option('--name', prompt='Your name',
                          help='The person to greet.')
            def hello(count, name): <-- 把 function 直接當 command 用，這點跟 Python Fire 很像
                """Simple program that greets NAME for a total of COUNT times."""
                for x in range(count):
                    click.echo('Hello %s!' % name)

            if __name__ == '__main__':
                hello() <-- 雖然 hello() 要兩個參數，但呼叫的對像是 decorator 包裝過的版本

        And what it looks like when run:

            $ python hello.py --count=3
            Your name: John <-- prompt 參數在作用
            Hello John!
            Hello John!
            Hello John!

        It automatically generates nicely formatted help pages: 看起來滿像樣的!!

            $ python hello.py --help
            Usage: hello.py [OPTIONS]

              Simple program that greets NAME for a total of COUNT times.

            Options:
              --count INTEGER  Number of greetings.
              --name TEXT      The person to greet.
              --help           Show this message and exit.

  - [Complex Applications — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/complex/) #ril

## Validation ??

  - [click/examples/validation at master · pallets/click](https://github.com/pallets/click/tree/master/examples/validation) #ril
  - [Callbacks for Validation - Options — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/options/?highlight=validation#callbacks-for-validation) #ril

  - [Version 2.0 - Click Changelog — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/changelog/?highlight=validation#version-2-0) #ril

      - introduced `BadParameter` which can be used to easily perform CUSTOM VALIDATION with the SAME ERROR MESSAGES as in the type system.

  - [`click.BadParameter` - API — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/api/?highlight=validation#click.BadParameter)

      - An exception that formats out a STANDARDIZED ERROR MESSAGE for a bad parameter. This is useful when thrown from a callback or type as Click will attach CONTEXTUAL INFORMATION to it (for instance, which parameter it is).

        New in version 2.0.

    Parameters

      - `param` – the parameter object that caused this error. This CAN BE LEFT OUT, and Click will attach this info itself if possible.

      - `param_hint` – a string that shows up as PARAMETER NAME.

        This can be used as alternative to `param` in cases where custom validation should happen. If it is a string it’s used as such, if it’s a LIST then each item is quoted and separated.

        聽起來 callback 可以一次驗多個 param ??

## Nesting Commands ??

  - [Commands and Groups — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/commands/) #ril

      - The most important feature of Click is the concept of ARBITRARILY NESTING command line utilities. This is implemented through the `Command` and `Group` (actually `MultiCommand`).

    Callback Invocation

      - For a regular command, the callback is executed WHENEVER THE COMMAND RUNS. If the script is the only command, it will always fire (unless a parameter callback prevents it. This for instance happens if someone passes `--help` to the script).

        所謂 script 就是使用者在 command line 一長串最原始的輸入；不過都加 `--help` 了，為什麼要執行??

      - For groups and multi commands, the situation looks different. In this case, the callback fires whenever a subcommand fires (unless this behavior is changed). What this means in practice is that AN OUTER COMMAND RUNS WHEN AN INNER COMMAND RUNS:

            @click.group()
            @click.option('--debug/--no-debug', default=False)
            def cli(debug):
                click.echo('Debug mode is %s' % ('on' if debug else 'off'))

            @cli.command()  # @cli, not @click!
            def sync():
                click.echo('Syncing')

        這個特性可以讓 parent command 將 option 先記錄下來。不過除了 `sync --help` 看不到 `--debug` 的說明之外，`sync` subcomand 如何拿到 `debug` 的值也是個問題？下面示範了透過 `Context.obj` 在 command/subommand 間交換資料的做法。

        其實更大的問題是 `--debug` 只能寫在 `sync` subcommand 前，否則會出現 `no such option: ...` 的錯誤，因為那個 option 是宣告在 parent command：

            $ python sync.py --no-debug sync
            Debug mode is off
            Syncing

            $ python sync.py sync --no-debug
            Debug mode is off
            Usage: sync.py sync [OPTIONS]
            Try "sync.py sync --help" for help.

            Error: no such option: --no-debug

      - Here is what this looks like:

            $ tool.py
            Usage: tool.py [OPTIONS] COMMAND [ARGS]...

            Options:
              --debug / --no-debug
              --help                Show this message and exit.

            Commands:
              sync

            $ tool.py --debug sync
            Debug mode is on
            Syncing

        這裡避開了 `sync` subcommand 如何拿到 `debug` 的問題 ...

    Nested Handling and Contexts

      - As you can see from the earlier example, the basic command group accepts a `debug` argument which is passed to its callback, but not to the `sync` command itself. The `sync` command only accepts its own arguments.

            @click.group()
            @click.option('--debug/--no-debug', default=False)
            def cli(debug):
                click.echo('Debug mode is %s' % ('on' if debug else 'off'))

            @cli.command()  # @cli, not @click!
            def sync():
                click.echo('Syncing')

      - This allows tools to act COMPLETELY INDEPENDENT of each other, but how does one command talk to a nested one? The answer to this is the `Context`.

        Each time a command is invoked, a new context is created and linked with the PARENT CONTEXT. Normally, you can’t see these contexts, but they are there. Contexts are passed to parameter callbacks together with the value automatically. Commands can also ask for the context to be passed by marking themselves with the `pass_context()` decorator. In that case, the context is passed as FIRST ARGUMENT.

        Command/subcommand 之間可以透過 context 交換資料，但這裡卻完全沒提到 `Context.meta`?? 從 "created and linked with the parent context" 看來，每一層 command 都有自己的 context (透過 `context.parent` 取得 parent context)，雖然最後提到不一定要走 context，因為 Python 的 global/module 就可以當做媒介。

      - The context can also carry a PROGRAM SPECIFIED OBJECT that can be used for the program’s purposes. What this means is that you can build a script like this:

            @click.group()
            @click.option('--debug/--no-debug', default=False)
            @click.pass_context
            def cli(ctx, debug):
                # ensure that ctx.obj exists and is a dict (in case `cli()` is called
                # by means other than the `if` block below
                ctx.ensure_object(dict)

                ctx.obj['DEBUG'] = debug

            @cli.command()
            @click.pass_context <-- 注意這裡又用回 @click 了
            def sync(ctx):
                click.echo('Debug is %s' % (ctx.obj['DEBUG'] and 'on' or 'off'))

            if __name__ == '__main__':
                cli(obj={})

        If the object is provided, EACH CONTEXT will PASS the object onwards to its CHILDREN, but at any level a context’s object can be overridden. To reach to a parent, `context.parent` can be used.

        若將其初始化為 dict，用起來就跟 `Context.meta` 一樣了，似乎沒什麼意思?

        In addition to that, instead of passing an object down, nothing stops the application from modifying GLOBAL STATE. For instance, you could just flip a global `DEBUG` variable and be done with it.

  - [`Context.meta` - API — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/api/#click.Context.meta)
      - This is a dictionary which is SHARED with all the contexts that are nested. It exists so that CLICK UTILITIES can store some state here if they need to. It is however the responsibility of that code to manage this dictionary well.
      - The keys are supposed to be UNIQUE DOTTED STRINGS. For instance MODULE PATHS are a good choice for it. What is stored in there is irrelevant for the operation of click. However what is important is that code that places data here adheres to the general semantics of the system.

            LANG_KEY = __name__ + '.lang'

            def set_language(value):
                ctx = get_current_context()
                ctx.meta[LANG_KEY] = value

            def get_language():
                return get_current_context().meta.get(LANG_KEY, 'en_US')

        意思是 Click 自己也會用，命名上採 module name 為 prefix 可以避免衝突? 難怪範例會用 `__name__` 做為 prefix。

  - [python \- Click group with options and commands at the same time \- Stack Overflow](https://stackoverflow.com/questions/54896044/) `@click.group(invoke_without_command=True)` 搭配 `@cmd.command(default_command=True)` 就可以省略 subcommand #ril
  - [Python Click \- only execute subcommand if parent command executed successfully \- Stack Overflow](https://stackoverflow.com/questions/51847639/) 出現 `ctx.obj['xxx']` 的用法 #ril
  - [In Python Click how do I see \-\-help for Subcommands whose parents have required arguments? \- Stack Overflow](https://stackoverflow.com/questions/47437472/) #ril

## Help Page ??

  - [Documenting Scripts — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/documentation/) #ril

      - Click makes it very easy to document your command line tools. First of all, it automatically generates help pages for you. While these are currently NOT CUSTOMIZABLE IN TERMS OF THEIR LAYOUT, all of the text can be changed.

    Help Texts

      - Commands and options accept `help` arguments. In the case of commands, the DOCSTRING of the function is automatically used if provided.

        Simple example:

            @click.command()
            @click.option('--count', default=1, help='number of greetings')
            @click.argument('name')
            def hello(count, name):
                """This script prints hello NAME COUNT times."""
                for x in range(count):
                    click.echo('Hello %s!' % name)

        And what it looks like:

            $ hello --help
            Usage: hello [OPTIONS] NAME

              This script prints hello NAME COUNT times.

            Options:
              --count INTEGER  number of greetings
              --help           Show this message and exit.

      - Arguments cannot be documented this way. This is to follow the GENERAL CONVENTION of Unix tools of using arguments for only the most necessary things and to DOCUMENT THEM IN THE INTRODUCTION text by referring to them by name.

        [add help to click argument · Issue \#587 · pallets/click](https://github.com/pallets/click/issues/587) davidism: (member) As the docs quoted earlier say, Click INTENTIONALLY does not implement this.

## 在 Parent/Sub Command 間共用 Option {: #share-options }

以 `docker` 的 `--debug` 為例，不能放在 subcommand 後面，而且 subcommand 的 help page 也看不到 `--debug` 的說明。

    $ docker ps --debug
    unknown flag: --debug
    See 'docker ps --help'.

雖然有點違反直覺 (見仁見智?)，`cmd [OPTIONS] subcmd subsubcmd [OPTIONS]` 這樣的安排還可以，但中間再插個 `subcmd [OPTIONS]` 就太多了? 也就是說 option 可以初現在開頭或結尾，遇到這種狀況時，將通用的 option 在 subsubcmd 重新宣告一次即可，至於實作細節如何共用邏輯，在 [#108 Support for shared arguments?](https://github.com/pallets/click/issues/108#issuecomment-194465429) 的討論裡，mikenerone 提出的做法很實用：

    _global_test_options = [
        click.option('--verbose', '-v', 'verbosity', flag_value=2, default=1, help='Verbose output'),
        click.option('--quiet', '-q', 'verbosity', flag_value=0, help='Minimal output'),
        click.option('--fail-fast', '--failfast', '-f', 'fail_fast', is_flag=True, default=False, help='Stop on failure'),
    ]

    def global_test_options(func):
        for option in reversed(_global_test_options):
            func = option(func)
        return func

    @click.command()
    @global_test_options
    @click.option('--start-directory', '-s', default='test', help='Directory (or module path) to start discovery ("test" default)')
    def test(verbosity, fail_fast, start_directory):
        # Run tests here

    @click.command()
    @click.option(
        '--format', '-f', type=click.Choice(['html', 'xml', 'text']), default='html', show_default=True,
        help='Coverage report output format',
    )
    @global_test_options
    @click.pass_context
    def cover(ctx, format, verbosity, fail_fast):
        # Setup coverage, ctx.invoke() the test command above, generate report

---

參考資料：

  - [Support for shared arguments? · Issue \#108 · pallets/click](https://github.com/pallets/click/issues/108)
      - mahmoudimus: A very simple and trivial example is the verbose example. Assume you have more than one subcommand in a CLI app. An ideal user experience on the CLI would be:

            python script.py subcmd -vvv

        However, this wouldn't be the case with click, SINCE `subcmd` DOESN'T DEFINE A `verbose` OPTION. You'd have to invoke it as follows:

            python script.py -vvv subcmd

        This example is very simple, but when there are many subcommands, sometimes a root support option would go a long way to make something simple and EASY TO USE. Let me know if you'd like further clarification.

      - mitsuhiko (member): This is already really simple to implement through decorators. As an example:

            import click

            class State(object):

                def __init__(self):
                    self.verbosity = 0
                    self.debug = False

            pass_state = click.make_pass_decorator(State, ensure=True) # 用 global 來存狀態

            def verbosity_option(f):
                def callback(ctx, param, value):
                    state = ctx.ensure_object(State)
                    state.verbosity = value
                    return value
                return click.option('-v', '--verbose', count=True,
                                    expose_value=False,
                                    help='Enables verbosity.',
                                    callback=callback)(f) # 用 parameter callback 存進 global state

            def debug_option(f):
                def callback(ctx, param, value):
                    state = ctx.ensure_object(State)
                    state.debug = value
                    return value
                return click.option('--debug/--no-debug',
                                    expose_value=False,
                                    help='Enables or disables debug mode.',
                                    callback=callback)(f)

            def common_options(f): # 通用的 options
                f = verbosity_option(f)
                f = debug_option(f)
                return f

            @click.group()
            def cli():
                pass

            @cli.command()
            @common_options
            @pass_state
            def cmd1(state):
                click.echo('Verbosity: %s' % state.verbosity)
                click.echo('Debug: %s' % state.debug)

      - mahmoudimus: From your example, is the intention that users build their own common options and annotate all relevant commands? Maybe a better user experience is to register these COMMON OPTIONS to the group and have the group TRANSITIVELY PROPAGATE THEM TO ITS SUBCOMMANDS? I could see arguments for either or.

        mitsuhiko (member): If the option is available on all commands it really does not belong to the option but instead to the group that encloses it. It makes no sense that an option conceptually belongs to the group but is attached to an option in my mind. ??

      - mahmoudimus: Right, and I'm on board with your logic. However, this translates to position dependence for options which causes COGNITIVE LOAD on the user of the cli app, unless the approach above is used to get, what I would consider, the desirable and expected UX. 確實，是 UX 的問題!!

        That's why I'm wondering if it makes sense to have a parameter on the group class which propagates options down to commands to get the desired behavior WITHOUT SURPRISING THE USER.

        If my use case is the outlier (門外漢) in terms of what is desired and expected, then I guess the option of using a similar idiom to what you've demonstrated above is the right way to go.

      - mitsuhiko: Doing this by magic will not happen, that stands against one of the core principles of Click which is to NEVER BREAK BACKWARDS COMPATIBILITY with scripts by adding new parameters/options later. The correct solution is to use a CUSTOM DECORATOR for this. :)

        untitaker (member): How about adding such a decorator to click or a `click-contrib` package? 團隊內部有不同的看法 ...

      - Stiivi: I'm giving my vote for this feature, as it makes the CLI EXPERIENCE LESS COMPLEX. Even though technically `cmd -a subcmd -b subsubcmd -c` is correct, `cmd subcmd subsubcmd -a -b -c` is analogous to have `cmd_subcmd_subsubcmd -a -b -c`.
      - mikenerone: I think this can be done even more trivially than the given example. Here's a snippet from a helper command I have for running unit tests and/or coverage. Note that several of the options are SHARED between the `test` and `cover` subcommands:

            _global_test_options = [
                click.option('--verbose', '-v', 'verbosity', flag_value=2, default=1, help='Verbose output'),
                click.option('--quiet', '-q', 'verbosity', flag_value=0, help='Minimal output'),
                click.option('--fail-fast', '--failfast', '-f', 'fail_fast', is_flag=True, default=False, help='Stop on failure'),
            ]

            def global_test_options(func):
                for option in reversed(_global_test_options):
                    func = option(func)
                return func

            @click.command()
            @global_test_options
            @click.option('--start-directory', '-s', default='test', help='Directory (or module path) to start discovery ("test" default)')
            def test(verbosity, fail_fast, start_directory):
                # Run tests here

            @click.command()
            @click.option(
                '--format', '-f', type=click.Choice(['html', 'xml', 'text']), default='html', show_default=True,
                help='Coverage report output format',
            )
            @global_test_options
            @click.pass_context
            def cover(ctx, format, verbosity, fail_fast):
                # Setup coverage, ctx.invoke() the test command above, generate report

        這用起來會更直覺，有趣的是 `--verbose` 跟 `--quiet` 共用一個參數 `verbosity`，跟 `fail_fast` 一起出現在參數裡，很直覺!!

  - [What is the most elegant way of accepting an option on both the group and subcommands? · Issue \#1034 · pallets/click](https://github.com/pallets/click/issues/1034) #ril

## 用 Class 來實作 Subcommand ?? {: #}

  - [use click\.command in a class · Issue \#601 · pallets/click](https://github.com/pallets/click/issues/601) #ril
      - davidism (member): Closing as I don't think this is an INTENDED USE CASE. If you want to build a cli in a class, you should probably do that in `__init__` by calling `cli.add_command()` so that the methods are bound. 開發團隊沒有預期這種用法
  - [python \- Using click\.MultiCommand with classmethods \- Stack Overflow](https://stackoverflow.com/questions/55213253/) `class ConversionCLI(click.MultiCommand)` 實作了 `list_commands()` 與 `get_command()`，好像就可以用 class 來寫 subcommand 了? #ril

## Testing ??

  - [Testing Click Applications — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/testing/) #ril
      - For basic testing, Click provides the `click.testing` module which provides test functionality that helps you INVOKE command line applications and check their BEHAVIOR.
      - These tools should really only be used for testing as they change the entire INTERPRETER STATE?? for simplicity and are NOT in any way thread-safe!

    Basic Testing

      - The basic functionality for testing Click applications is the `CliRunner` which can invoke commands as command line scripts. The `CliRunner.invoke()` method runs the command line script IN ISOLATION and CAPTURES THE OUTPUT as both bytes and binary data. The return value is a `Result` object, which has the captured output data, exit code, and optional exception attached.

            import click
            from click.testing import CliRunner

            def test_hello_world():
                @click.command()
                @click.argument('name')
                def hello(name):
                    click.echo('Hello %s!' % name)

                runner = CliRunner()
                result = runner.invoke(hello, ['Peter']) # 為什麼 invoke 的對象是 command，而非使用者在 command line 最原始的輸入??
                assert result.exit_code == 0
                assert result.output == 'Hello Peter!\n'

  - [Testing - API — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/api/#testing) #ril

## Slack Slash Command ??

  - 若想在同一個 (Python) process 裡做事 (不想調用外部 CLI)，可能會卡在 CLI framework 設計上的限制，例如要攔截 `SystemExit`、將 STDOUT/STDERR 轉向等。
  - 若調用外部 CLI，上面的問題就沒了，只要把 STDOUT/STDERR 包裝成 Slack message 回傳給使用者即可；多人同時執行也沒問題，只要把 working directory 拆開。
  - 讓 Slack Slash Command 做為 CLI 的 thin wrapper 有幾個好處 -- 在本地端開發時也好測試，除了 Slash command，使用者也可以直接用 CLI，而且這方法也適用於非 Python-based 的 CLI。
  - 但 CLI 與 Slack Slash Command 的 UI (指 command line parsing) 也可能有些微的差異，例如 pipeline、本地檔案操作、密碼輸入提示等，或許應該拉出一層 facade 讓多種 UI 共用?

---

參考資料：

  - [Testing Click Applications — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/testing/)

      - These tools should really only be used for testing as they CHANGE THE ENTIRE INTERPRETER STATE for simplicity and are NOT in any way thread-safe!

        看起來很適合用來實作 Slack Slash Command，但上面又說不該用在 testing 以外的地方? 只要 worker 不走 thread 就沒有問題??

        若是把 Slash Command 視為 CLI 的另一層包裝? 也就是 CLI 可以在本地端使用，也可以透過 Slash Command 調用 CLI 外部程式，事情會單純一點?

  - [`CliRunnter.invoke()` - click/testing\.py at master · pallets/click](https://github.com/pallets/click/blob/7.0/click/testing.py#L280) #ril

        def invoke(self, cli, args=None, input=None, env=None,
                   catch_exceptions=True, color=False, mix_stderr=False, **extra):

            exc_info = None
            with self.isolation(input=input, env=env, color=color) as outstreams: # (1)
                exception = None
                exit_code = 0

                if isinstance(args, string_types):
                    args = shlex.split(args)

                try:
                    prog_name = extra.pop("prog_name")
                except KeyError:
                    prog_name = self.get_default_prog_name(cli)

                try:
                    cli.main(args=args or (), prog_name=prog_name, **extra) # (2)
                except SystemExit as e:
                    exc_info = sys.exc_info()
                    exit_code = e.code
                    if exit_code is None:
                        exit_code = 0

                    if exit_code != 0:
                        exception = e

                    if not isinstance(exit_code, int):
                        sys.stdout.write(str(exit_code))
                        sys.stdout.write('\n')
                        exit_code = 1

                except Exception as e:
                    if not catch_exceptions:
                        raise
                    exception = e
                    exit_code = 1
                    exc_info = sys.exc_info()
                finally:
                    sys.stdout.flush()
                    stdout = outstreams[0].getvalue()
                    stderr = outstreams[1] and outstreams[1].getvalue()

            return Result(runner=self,
                          stdout_bytes=stdout,
                          stderr_bytes=stderr,
                          exit_code=exit_code,
                          exception=exception,
                          exc_info=exc_info)

            try:
                cli.main(args=args or (), prog_name=prog_name, **extra)
            except SystemExit as e:
                exc_info = sys.exc_info()
                exit_code = e.code

     1. [`isolation()`](https://github.com/pallets/click/blob/7.0/click/testing.py#L163) 會暫時將 STDIN, STDOUT, STDERR 換掉。

        不過這會影響到同一個 process 的其他輸出入，例如 logging 在 STDERR 的輸出。

        或許更不具侵入性的做法是自訂 `echo()` 內部再轉呼叫 `click.echo()` ?? 在真正的 CLI 下就送 STDERR/STDOUT，在 Slash Command 下則改送 Slack message。

     2. 只是呼叫 `BaseCommand.main()`? 從 [`click.core.main()`](https://github.com/pallets/click/blob/master/click/core.py#L658) 的原始碼看來，背後也是調用 `BaseCommand.invoke()`：

            with self.make_context(prog_name, args, **extra) as ctx:
                rv = self.invoke(ctx)

  - [`BaseCommand.main()` - API — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/api/#click.BaseCommand.main) #ril

      - `main(args=None, prog_name=None, complete_var=None, standalone_mode=True, **extra)`

      - This is the way to invoke a script with all the bells and whistles as a command line application. This will always terminate the application after a call. If this is not wanted, `SystemExit` needs to be caught.

        明確指出可以攔截 `SystemExit`，沒有問題。

      - This method is also available by directly calling the instance of a `Command`.
      - New in version 3.0: Added the `standalone_mode` flag to control the standalone mode??.

    Parameters

      - `args` – the arguments that should be used for parsing. If not provided, `sys.argv[1:]` is used. (不含 program name 本身)
      - `prog_name` – the program name that should be used. By default the program name is constructed by taking the file name from `sys.argv[0]`.
      - `complete_var` – the environment variable that controls the bash completion support. The default is "`_<prog_name>_COMPLETE`" with `prog_name` in uppercase.
      - `standalone_mode` – the default behavior is to invoke the script in STANDALONE MODE. Click will then handle exceptions and convert them into error messages and the function will never return but SHUT DOWN the interpreter. (也就是會丟出 `SystemExit`) If this is set to `False` they will be propagated to the caller and the return value of this function is the return value of `invoke()`.
      - `extra` – extra keyword arguments are forwarded to the context constructor. See `Context` for more information.

  - [Context API — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/api/#context) #ril

    `invoke(**kwargs)`

      - Invokes a command callback in exactly the way it expects. There are two ways to invoke this method:
          - the first argument can be a CALLBACK and all other arguments and keyword arguments are forwarded directly to the function.
          - the first argument is a click COMMAND OBJECT. In that case all arguments are forwarded as well but proper click parameters (options and click arguments) must be keyword arguments and Click will fill in defaults.

## 安裝設定 {: #installation }

  - [Welcome to Click — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/) You can get the library directly from PyPI: `pip install click`
  - [virtualenv - Quickstart — Click Documentation \(7\.x\)](https://click.palletsprojects.com/en/7.x/quickstart/#virtualenv) #ril

## 參考資料 {: #reference }

  - [Click](https://click.palletsprojects.com/)
  - [pallets/click - GitHub](https://github.com/pallets/click/)
  - [click - PyPI](https://pypi.org/project/click/)

社群：

  - ['python-click' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/python-click)

手冊：

  - [API Documentation](https://click.palletsprojects.com/en/7.x/api/)
  - [`click.Parameter`](https://click.palletsprojects.com/en/7.x/api/#click.Parameter)
  - [`click.Option`](https://click.palletsprojects.com/en/7.x/api/#click.Option)
