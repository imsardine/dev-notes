---
title: Python / Context Manager
---
# [Python](python.md) / Context Manager

  - [3\. Data model — Python 2\.7\.15 documentation](https://docs.python.org/2.7/reference/datamodel.html#context-managers)

      - New in version 2.5. A context manager is an object that defines the RUNTIME CONTEXT to be established when executing a `with` statement.

        The context manager handles the entry into, and the exit from, the desired runtime context for the execution of the block of code.

      - Context managers are normally invoked using the `with` statement (described in section The `with` statement), but can also be used by DIRECTLY INVOKING their methods.

        呼叫 `__enter__()` 不會很怪嗎 ??

      - Typical uses of context managers include saving and restoring various kinds of global state, locking and unlocking resources, closing opened files, etc.

        其中 "global state" 的用法，很像是 mock 裡 [`with patch()`](https://docs.python.org/3/library/unittest.mock.html#unittest.mock.patch) 的用法。

    `object.__enter__(self)`

      - Enter the runtime context RELATED TO THIS OBJECT. The `with` statement will BIND this method’s return value to the TARGET(S) specified in the `as` clause of the statement, if any.

        注意 "target(s)" 的說法，若 `__enter__()` 回傳多個值，`as` 後面要怎麼寫 ??

    `object.__exit__(self, exc_type, exc_value, traceback)`

      - Exit the runtime context related to this object. The parameters describe the exception that caused the context to be exited. If the context was exited without an exception, all three arguments will be `None`.

        If an exception is supplied, and the method wishes to SUPPRESS THE EXCEPTION (i.e., prevent it from being propagated), it should return a TRUE VALUE. Otherwise, the exception will be processed normally upon exit from this method.

        意指 `with` code block 裡有任何 exception 拋出，從 `__exit__()` 都會先知道，傳回值會決定 exception 要不要繼續往外拋。

      - Note that `__exit__()` methods should not reraise the passed-in exception; this is the caller’s responsibility.

  - [28\.7\. contextlib — Utilities for with\-statement contexts — Python 2\.7\.16 documentation](https://docs.python.org/2/library/contextlib.html) #ril

      - This module provides utilities for common tasks involving the `with` statement. For more information see also Context Manager Types and With Statement Context Managers.

    `contextlib.contextmanager(func)`

      - This function is a DECORATOR that can be used to define a FACTORY FUNCTION for `with` statement context managers, without needing to create a class or separate `__enter__()` and `__exit__()` methods.

        While many objects natively support use in `with` statements, sometimes a resource needs to be managed that isn’t a context manager in its own right, and doesn’t implement a `close()` method for use with `contextlib.closing`

      - An abstract example would be the following to ensure correct resource management:

            from contextlib import contextmanager

            @contextmanager
            def managed_resource(*args, **kwds):
                # Code to acquire resource, e.g.:
                resource = acquire_resource(*args, **kwds)
                try:
                    yield resource
                finally:
                    # Code to release resource, e.g.:
                    release_resource(resource)

            >>> with managed_resource(timeout=3600) as resource:
            ...     # Resource is released at the end of this block,
            ...     # even if code in the block raises an exception

        The function being decorated must return a GENERATOR-ITERATOR when called. This iterator must YIELD EXACTLY ONE VALUE, which will be bound to the targets in the `with` statement’s `as` clause, if any.

      - At the point where the generator yields, the block nested in the `with` statement is executed. The generator is then resumed after the block is exited.

        If an unhandled exception occurs in the block, it is RERAISED INSIDE THE GENERATOR AT THE POINT WHERE THE YIELD OCCURRED. Thus, you can use a `try...except...finally` statement to trap the error (if any), or ENSURE THAT SOME CLEANUP TAKES PLACE.

        If an exception is trapped merely in order to log it or to perform some action (rather than to suppress it entirely), the generator must RERAISE that exception. Otherwise the generator context manager will indicate to the `with` statement that the exception has been handled, and execution will resume with the statement immediately following the `with` statement.

  - [7\. Compound statements — Python 2\.7\.16 documentation](https://docs.python.org/2.7/reference/compound_stmts.html#with) #ril
  - [Python with Context Managers](https://jeffknupp.com/blog/2016/03/07/python-with-context-managers/) (2016-03-07) #ril
      - Context manager 最常見且最重要的用途是管理 resource，這也就是為何用 context manager 來讀取檔案 (`with open('what_are_context_managers.txt', 'r') as infile`；讀取檔案會耗費一項資源 -- file descriptor，但這項資源是有限的。在 macOS 或 Linux 跑 `for x in range(100000): files.append(open('foo.txt', 'w'))` 可能會遇到 `OSError: [Errno 24] Too many open files: 'foo.txt'` 的錯誤 (但為什麼單純做 `open('foo.txt', 'w')` 不加入 list 不會有問題??)
      - 當你開啟一個檔案，OS 會配發一個 integer，做為存取的 handle，這就是 file descriptor。好處是可以在 process 間交換 reference to file，且 kernel 也可以居間要求 security。而 don't leak file descriptors! 中的 leak 指的是 not closing opened files，忘了做 `close()` 可能就會發現一個 process 的 file descriptor 數量是有限的 (`ulimit -n`)，所以只要把數字減個 5 (扣除 Python interpreter 一開始就會開啟的數量)，就能引發上面 Too many open files 的問題。
      - 實務上很難確保 `close()` 會被呼叫，尤其 function 可能會丟出 exception 或是有多個 return path 時。其他語言得用 `try...except...finally` 處理，所幸 Python 提供 context manager 可以確保 resource 有被 clean up，不管 code 成功 return 或是過程中有丟出 exception。
  - [26\. Context Managers — Python Tips 0\.1 documentation](http://book.pythontips.com/en/latest/context_managers.html) #ril
  - [Introduction to Context Managers in Python](http://eigenhombre.com/introduction-to-context-managers-in-python.html) #ril
  - [5.11. Context Manager Types - 5\. Built\-in Types — Python 2\.7\.14 documentation](https://docs.python.org/2/library/stdtypes.html#context-manager-types) #ril
  - [29\.6\. contextlib — Utilities for with\-statement contexts — Python 3\.6\.6rc1 documentation](https://docs.python.org/3/library/contextlib.html) #ril
  - [PEP 343 \-\- The "with" Statement \| Python\.org](https://www.python.org/dev/peps/pep-0343/) #ril

