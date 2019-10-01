---
title: Python / Warning
---
# [Python](python.md) / Warning

  - [When to use logging - Logging HOWTO — Python 3\.7\.4 documentation](https://docs.python.org/3/howto/logging.html#when-to-use-logging)

      - `warnings.warn()` in library code if the issue is AVOIDABLE and the client application should be modified to eliminate the warning
      - `logging.warning()` if there is NOTHING THE CLIENT APPLICATION CAN DO about the situation, but the event should still be noted

    都是 warning，若 client application 可以避開的 warning 用 `warnings.warn()`，若 client application 什麼也不能做則用 `logging.warn()`。

  - [warnings — Warning control — Python 3\.7\.4 documentation](https://docs.python.org/3/library/warnings.html) #ril

      - Warning messages are typically issued in situations where it is useful to alert the user of some condition in a program, where that condition (normally) DOESN’T WARRANT RAISING AN EXCEPTION AND TERMINATING THE PROGRAM. For example, one might want to issue a warning when a program uses an obsolete module.

      - Python programmers issue warnings by calling the `warn()` function defined in this module. (C programmers use `PyErr_WarnEx()`; see Exception Handling for details).

      - Warning messages are normally written to `sys.stderr`, but their disposition can be changed flexibly, from IGNORING ALL WARNINGS to TURNING THEM INTO EXCEPTIONS.

        The disposition of warnings can vary based on the WARNING CATEGORY (see below), the text of the warning message, and the source location where it is issued. REPETITIONS of a particular warning for the same source location are TYPICALLY SUPPRESSED.

      - There are two STAGES in WARNING CONTROL: first, each time a warning is issued, a determination is made whether a message should be ISSUED OR NOT; next, if a message is to be issued, it is formatted and printed using a USER-SETTABLE HOOK.

        The determination whether to issue a warning message is controlled by the WARNING FILTER, which is a sequence of matching rules and actions. Rules can be added to the filter by calling `filterwarnings()` and reset to its default state by calling `resetwarnings()`.

        The printing of warning messages is done by calling `showwarning()`, which may be overridden; the default implementation of this function formats the message by calling `formatwarning()`, which is also available for use by custom implementations.

      - See also `logging.captureWarnings()` allows you to handle all warnings with the standard logging infrastructure.

  - [Integration with the warnings module - logging — Logging facility for Python — Python 3\.7\.4 documentation](https://docs.python.org/3/library/logging.html#integration-with-the-warnings-module)

      - The `captureWarnings()` function can be used to integrate logging with the `warnings` module.

    `logging.captureWarnings(capture)`

      - This function is used to turn the capture of warnings by logging on and off.

      - If `capture` is `True`, warnings issued by the `warnings` module will be REDIRECTED TO THE LOGGING SYSTEM. Specifically, a warning will be formatted using `warnings.formatwarning()` and the resulting string logged to a logger named `py.warnings` with a severity of `WARNING`.

      - If capture is `False`, the redirection of warnings to the logging system will stop, and warnings will be redirected to their original destinations (i.e. those in effect before `captureWarnings(True)` was called).

        也就是預設並不會導向 logging system。
