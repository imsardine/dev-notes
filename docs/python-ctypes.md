---
title: Python / ctypes
---
# [Python](python.md) / ctypes

  - [ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html)
      - `ctypes` is a FOREIGN FUNCTION LIBRARY for Python. It provides C compatible data types, and allows calling functions in DLLs or SHARED LIBRARIES. It can be used to WRAP these libraries in pure Python. 屬 [Foreign Function Interface (FFI)](https://en.wikipedia.org/wiki/Foreign_function_interface) 機制，可以從 Python 調用 shared library 裡的 function；這個 module 無關 static library，本質上 CPython 調用 library 就是一種 dynamic linking。
  - [1\. Extending Python with C or C\+\+ — Python 3\.7\.1 documentation](https://docs.python.org/3/extending/extending.html)
      - 用 C 寫 extension module 可以擴充 built-in object type，而且可以調用 C library function 或 system call；Extension module 可以透過 Python API (`Python.h`) 存取 Python runtime system。
      - C extension interface 其實是 CPython 特有的，為了避免不相容於其他 Python impl.，若只是想調用 C library function 或 system call，應該考慮 `ctypes` module 或 [CFFI library](https://cffi.readthedocs.io/en/latest/) -- 可以從 Python code 直接調用 C library，不用寫 C code；例如 [Jython](http://www.jython.org/docs/library/cpython_only/ctypes-R.html) 也有提供 `ctypes`。
  - [Speed up your Python with C: a guide to Ctypes, Cython and CFFI \- Recast\.AI Blog](https://recast.ai/blog/how-to-speed-up-python-with-c/) (2018-04-12) #ril
  - [Author - ahupp/python\-magic: A python wrapper for libmagic](https://github.com/ahupp/python-magic#user-content-author) It originally used SWIG for the C library bindings, but switched to `ctypes` once that was part of the python standard library. 原來 SWIG 比 `ctypes` 更早出現。

## Hello, World!

`greeting.c`:

```
#include <stdio.h>

void greet(char *somebody) {
    printf("Hello, %s!\n", somebody);
}
```

`hello.py`:

```
import ctypes

lib = ctypes.CDLL('./greeting.so')
lib.greet(b'World'); # 等同 ctypes.c_char_p(b'World')，不用自己轉 NUL-terminated! Python 內部來就是 NUL-terminated??
```

```
$ gcc -fPIC -shared -o greeting.so greeting.c
$ nm -p greeting.so
0000000000000f60 T _greet
                 U _printf
                 U dyld_stub_binder

$ time python hello.py # 或 python3 也可
Hello, World!

real    0m0.053s
user    0m0.021s
sys 0m0.028s
```

## 新手上路 ?? {: #getting-started }

  - [Using C from Python: How to create a ctypes wrapper \- Scientific IT\-Systems](https://pgi-jcns.fz-juelich.de/portal/pages/using-c-from-python.html) 建立一個簡單的 shared library，然後透過 Python + `ctypes` 調用它 #ril
      - 建立一個 C library 可以計算多個數字的總和：

            int our_function(int num_numbers, int *numbers) { // 因為 array decaying 的關係，宣告 `int numbers[]` 易誤解
                int i;
                int sum = 0;
                for (i = 0; i < num_numbers; i++) {
                    sum += numbers[i];
                }
                return sum;
            }

      - 用 `cc -fPIC -shared -o libsum.so sum.c` 就可以產生 shared library `libsum.so`；其中 `-fPIC` 產生 Position Independent Code (PIC)，搭配 `-shared` 以產出 shared object (so)。
      - 在 Python 這邊包裝一個對應的 wrapper module `sum.py`：

            import ctypes

            _sum = ctypes.CDLL('libsum.so')
            _sum.our_function.argtypes = (ctypes.c_int, ctypes.POINTER(ctypes.c_int))

            def our_function(numbers):
                global _sum
                num_numbers = len(numbers)
                array_type = ctypes.c_int * num_numbers # 建立一個 array type
                result = _sum.our_function(ctypes.c_int(num_numbers), array_type(*numbers)) # 用 *numbers 展開初始化 elements
                return int(result) # 為什麼要轉型??

  - [Calling C functions from Python \- part 1 \- using ctypes \| yizhang82’s blog](http://yizhang82.me/python-interop-ctypes) (2018-01-08) #ril
  - [Tutorial - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#ctypes-tutorial) #ril
  - [Extending Python With C Libraries and the “ctypes” Module – dbader\.org](https://dbader.org/blog/python-ctypes-tutorial) #ril
  - [Interfacing Python and C: Advanced “ctypes” Features – dbader\.org](https://dbader.org/blog/python-ctypes-tutorial-part-2) #ril
  - [IPython Cookbook \- 5\.4\. Wrapping a C library in Python with ctypes](https://ipython-books.github.io/54-wrapping-a-c-library-in-python-with-ctypes/) #ril

## Loading Library ??

  - [Loading dynamic link libraries - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#loading-dynamic-link-libraries)
      - `ctypes` 在不同平台揭露了不同的 prefabricated (預製的) library loaders -- Unix-like 的 `cdll` 或 Windows 專有的 `windll` 及 `oledll`。透過它的 attribute 就能載入 library。

        這幾個 loader 的差別在於 [calling convention](https://en.wikipedia.org/wiki/X86_calling_conventions)，`cdll` 走 [cdecl](https://en.wikipedia.org/wiki/X86_calling_conventions#cdecl) (C declaration)，而 `windll` 跟 `oledll` 都走 [stdcall](https://en.wikipedia.org/wiki/X86_calling_conventions#stdcall)，只是 `oledll` 假設 function 會回傳 Windows `HRESULT` error code 而已：

            >>> from ctypes import *
            >>> print(windll.kernel32) # kernel32 走 stcall
            <WinDLL 'kernel32', handle ... at ...>
            >>> print(cdll.msvcrt)     # msvcrt 走 cdecl
            <CDLL 'msvcrt', handle ... at ...>
            >>> libc = cdll.msvcrt
            >>>

        看來 Unix-like 都走 cdecl，所以問題不大。不過為什麼 library loader 都叫 `*dll`?? DLL 不是 Windows 專有的說法? 文件雖然出現幾次 dll object 的說法，不過 "loaded shared library" 的說法出現更多次。

      - 不過在 Unix-like 因為載入 library 需要指明 extension 的關係，所以 attribute 的方法行不通，只好透過 `cdll.LoadLibrary()` 或自己建立 `CDLL` instance 來達成：

            >>> cdll.LoadLibrary("libc.so.6") # 都給完整的檔名；跟 search path 有關，例如 Linux 的 LD_LIBRARY_PATH
            <CDLL 'libc.so.6', handle ... at ...>
            >>> libc = CDLL("libc.so.6")
            >>> libc
            <CDLL 'libc.so.6', handle ... at ...>
            >>>

  - 實驗發現 `CDLL('mylib.so')` 在 macOS 下可以載到 `./mylib.so`，但在 Linux 下會丟出 `OSError: mylib.so: cannot open shared object file: No such file or directory` 的錯誤，改用 `CDLL('./mylib.so') 可以；猜想是 macOS 與 Linux 找 shared library 的方式不同??
      - [Python ctypes: loading DLL from from a relative path \- Stack Overflow](https://stackoverflow.com/questions/2980479/) #ril
  - [Finding shared libraries - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#finding-shared-libraries) #ril
      - When programming in a compiled language, shared libraries are accessed when compiling/linking a program, and when the program is run. 雖然 compiler 有自己的表示法 (例如 `gcc -lssl`)，跟 runtime (例如 Python 的 `CDLL('libssl.so')`) 可能不同；但找的地方在同個 OS 下都一樣??
      - The purpose of the `find_library()` function (`ctypes.util`) is to locate a library in a way SIMILAR to what the compiler or runtime loader does (on platforms with several versions of a shared library the most recent should be loaded), while the ctypes library loaders act like when a program is run, and call the runtime loader directly. 聽起來行為跟 library loader 還是有些差異，定位在開發時期的工具：

            $ gcc -o main main.c -lssl -lcrypto
            $ sudo find / -name '*ssl*.so'
            /usr/local/lib/python3.7/lib-dynload/_ssl.cpython-37m-x86_64-linux-gnu.so
            /usr/lib/python2.7/lib-dynload/_ssl.x86_64-linux-gnu.so
            /usr/lib/x86_64-linux-gnu/libssl.so
            /usr/lib/x86_64-linux-gnu/libevent_openssl.so
            /usr/lib/x86_64-linux-gnu/apr-util-1/apr_crypto_openssl.so
            /usr/lib/x86_64-linux-gnu/apr-util-1/apr_crypto_openssl-1.so
            /usr/lib/python3.5/lib-dynload/_ssl.cpython-35m-x86_64-linux-gnu.so
            $ ls /usr/local/lib
            libpython3.7m.so  libpython3.7m.so.1.0  libpython3.so  pkgconfig  python2.7  python3.5  python3.7

            $ python
            >>> from ctypes import *
            >>> CDLL('ssl') # 同 GCC 的寫法竟找到目錄?
            Traceback (most recent call last):
              File "<stdin>", line 1, in <module>
              File "/usr/local/lib/python3.7/ctypes/__init__.py", line 356, in __init__
                self._handle = _dlopen(self._name, mode)
            OSError: /usr/lib/ssl: cannot read file data: Is a directory
            >>> CDLL('ssl.so')
            Traceback (most recent call last):
              File "<stdin>", line 1, in <module>
              File "/usr/local/lib/python3.7/ctypes/__init__.py", line 356, in __init__
                self._handle = _dlopen(self._name, mode)
            OSError: ssl.so: cannot open shared object file: No such file or directory
            >>> CDLL('libssl.so')
            <CDLL 'libssl.so', handle 563444dc3930 at 0x7f0a6efbcda0>

            >>> CDLL('libpython3.so') # 在 /usr/local/lib 下的 library 也會找；但為什麼自己的 .so 就找不到??
            <CDLL 'libpython3.so', handle 563444e51d10 at 0x7f0a6efbcd30>

            >>> from ctypes.util import find_library
            >>> find_library('libssl.so') # 用 library loader 的寫法反而找不到
            >>> find_library('ssl.so')    # 拿掉前面的 lib 就可以?
            'libssl.so.1.1'
            >>> find_library('ssl')
            'libssl.so.1.1'

      - On Linux, `find_library()` tries to run external programs (`/sbin/ldconfig`, `gcc`, `objdump` and `ld`) to find the library file. It returns the filename of the library file. Changed in version 3.6: On Linux, the value of the environment variable `LD_LIBRARY_PATH` is used when searching for libraries, if a library cannot be found by any other means. 原來這項工具是 development time 用的!! 實驗發現，Linux 的 library loader 也會參考 `LD_LIBRARY_PATH`!!
  - [Calling functions - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#calling-functions) 有兩段文字提到 calling convention，但還是看不出來 calling convention 是否整個 library 都一樣??
      - `ValueError` is raised when you call an `stdcall` function with the `cdecl` calling convention, or vice versa.
      - To find out the correct calling convention you have to look into the C header file or the documentation for the function you want to call.
  - [Loading shared libraries - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#loading-shared-libraries) 自己建立 loader instance，可以做更細微的控制 #ril
      - If you have an existing HANDLE to an already loaded shared library, it can be passed as the `handle` named parameter, otherwise the underlying platforms `dlopen` or `LoadLibrary` function is used to load the library into the process, and to get a handle to it. 載入多次會怎樣?? 若本來記憶體就有會用同一份??
  - [python\-magic/magic\.py at 0\.4\.15 · ahupp/python\-magic](https://github.com/ahupp/python-magic/blob/0.4.15/magic.py#L181) `python-magic` 用 `ctypes` 載入 `libmagic`，支援 Linux/Windows/macOS 平台，很值得參考；載入失敗時會丟 `ImportError` #ril

## Unload Library ??

  - [How can I unload a DLL using ctypes in Python? \- Stack Overflow](https://stackoverflow.com/questions/359498/) 用 `del`? #ril
  - [python \- ctypes unload dll \- Stack Overflow](https://stackoverflow.com/questions/13128995/) #ril

## Memory Buffer ??

  - 感覺 Python 跟 shared library 運作在同一個 process 裡，就 `ptr = c_char_p(b'01234567890123456789')` 而言，`ptr` 是 Python variable (ctypes instance)，背後對應的 memory buffer 是 C variable 自己，因為是個 pointer (`char *`)，所以內容只是 `b'01234567890123456789'` 內部資料所在的位置。

        >>> s = b'01234567890123456789'
        >>> ptr = c_char_p(s)
        >>> id(ptr) # address of the object in memory / ctypes instance 的位置
        4438213224
        >>> addressof(ptr) # address of the memory buffer / C pointer variable 的位置
        4438213304
        >>> id(s) # Python object 的位置，內部資料在另一個地方 (4440222864)
        4440222832
        >>> ptr
        c_char_p(4440222864) # C pointer 裡的內容 4440222864，才是 data 真正的位置
        >>> sizeof(ptr) # C pointer 在記憶體的大小 (64-bit)，跟資料內容無關
        8

        >>> ptr.value
        b'01234567890123456789'
        >>> ptr2 = c_char_p(4440222864) # 把 integer address 給另一個 pointer
        >>> ptr2
        c_char_p(4440222864)
        >>> ptr2.value # 結果看到相同的內容，同 C pointer 的操作方式
        b'01234567890123456789'
        >>> c_char_p(4440222864 + 1).value # 不意外地，指標可以運算
        b'1234567890123456789'

  - [class ctypes._CData - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#ctypes._CData) #ril
      - All ctypes type instances contain a MEMORY BLOCK that hold C COMPATIBLE DATA; the address of the memory block is returned by the `addressof()` helper function.
      - Another instance variable is exposed as `_objects`; this contains other Python objects that need to be kept alive in case the memory block contains pointers. ??
  - [Fundamental data types - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#fundamental-data-types) #ril
      - All these types can be created by calling them with an optional INITIALIZER of the correct type and value. Since these types are mutable, their value can also be changed afterwards: 從 initiailzer 這個用字看來，似乎就在抄寫資料，到另一塊記憶體，也之所以不用擔心會動到 Python object 內部的資料：

            >>> i = 42
            >>> ci = c_int(i)
            >>> id(i), addressof(ci) # 資料被抄寫到另一塊記憶體 -- memory buffer
            (140662668280328, 4309678496)
            >>> ci.value = -99 # 直接修改 memory buffer 的內容
            >>> i, ci, addressof(ci)
            (42, c_int(-99), 4309678496) # 位置不變，但內容變了；Python variable 不受影響

      - Assigning a new value to instances of the pointer types `c_char_p`, `c_wchar_p`, and `c_void_p` changes the MEMORY LOCATION they point to, not the CONTENTS of the memory block (of course not, because Python bytes objects are immutable):

            >>> s = b'hello'
            >>> ptr = c_char_p(s)
            >>> id(s), addressof(ptr), ptr
            (4535649544, 4535448928, c_char_p(4535649576)) # memory buffer (pointer) 的內容 4535649576，是 b'hello' 內部資料的位置
            >>> ptr.value # 雖然 .value 是輸出 target 的內容，像是 C 裡面 *ptr 的用法
            b'hello'
            >>> ptr.value = b'world' # 把 memory buffer (pointer) 指向 b'world' 內部資料的位置 (4535649456)，像是 C 裡面 ptr = &"world" 的用法。
            >>> id(s), addressof(ptr), ptr
            (4535649544, 4535448928, c_char_p(4535649456)) # 同一個 memory buffer / pointer variable (4535448928)，但指向的位置變了
            >>> ptr.value
            b'world'

      - You should be CAREFUL, however, not to pass them to FUNCTIONS EXPECTING POINTERS TO MUTABLE MEMORY. 聽起來是有機會把 immutable Python object 的內部資料以指標的型式傳進 shared library，若 shared library 會修改其內容，不是 Python object 所預期的，但若傳進 mutable Python object 的內部資料呢? 可惜 `c_char_p(bytearray(b'hello'))` 會丟出 `TypeError: bytes or integer address expected instead of bytearray instance` 的錯誤。

      - If you need mutable memory blocks, `ctypes` has a `create_string_buffer()` function which creates these in various ways. The current memory block contents can be accessed (or changed) with the `raw` property; if you want to access it AS `NUL` terminated string, use the `value` property: To create a mutable memory block containing unicode characters of the C type `wchar_t` use the `create_unicode_buffer()` function.

        先弄清楚 `.raw` 跟 `.value` 的差別：

            >>> buf = create_string_buffer(5)
            >>> sizeof(buf)
            5
            >>> buf.raw
            b'\x00\x00\x00\x00\x00'
            >>> buf.raw = b'\x01' * 5
            >>> buf.raw
            b'\x01\x01\x01\x01\x01'
            >>> buf.raw = b'ab'
            >>> buf.raw
            b'ab\x01\x01\x01'
            >>> buf.value = b'ab' # 透過 .value 給值，後面會自動上 NUL
            >>> buf.raw
            b'ab\x00\x01\x01'

            >>> buf = create_string_buffer(b'abcde') # 給定初始值，會在後面加上 NUL；因為內部實作走 .value
            >>> sizeof(buf)
            6
            >>> buf.raw
            b'abcde\x00'

        `lib.c`:

            #include <ctype.h>

            void upper(char *chars, int len) {
              for (int i = 0; i <= len; i++)
                *(chars + i) = toupper(*(chars + i));
            }

        測試：

            >>> lib = CDLL('lib.so')
            >>> chars = b'abc123'
            >>> buffer = create_string_buffer(chars)
            >>> type(buffer)
            <class 'ctypes.c_char_Array_7'> # NUL-terminated
            >>> sizeof(buffer)
            7
            >>> buffer.raw, buffer.value
            (b'abc123\x00', b'abc123') # 反而是 .raw 會看到結尾的 NUL?
            >>> lib.upper.restype = None

            >>> lib.upper(buffer, len(chars))
            >>> chars, buffer.value
            (b'abc123', b'ABC123') # 成功修改 buffer，不影響原始資料

            >>> lib.upper(chars, len(chars))
            >>> chars, buffer.value
            (b'ABC123', b'ABC123') # bytes 也可以改!? 但不建議這麼做

            >>> create_string_buffer(bytearray(b'hello')) # ctypes 幾乎不支援 bytearray!?
            ...
            TypeError: bytearray(b'hello')

      - [`create_string_buffer()`](https://github.com/python/cpython/blob/v3.7.1/Lib/ctypes/__init__.py#L47) 的實作如下：

            def create_string_buffer(init, size=None): # 傳回 C char[]，傳入 C library 就是 `char *`
                if isinstance(init, bytes):
                    if size is None:
                        size = len(init)+1  # 刻意加了結尾 NUL 的空間，因為下面用 .value 初始化
                    buftype = c_char * size # char[]
                    buf = buftype()
                    buf.value = init
                    return buf
                elif isinstance(init, int):
                    buftype = c_char * init
                    buf = buftype()
                    return buf
                raise TypeError(init) # 只支援 bytes 跟 int，應該要支援 bytes-like 的

  - [create_string_buffer - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#ctypes.create_string_buffer) #ril

  - [python \- How can I use ctypes to pass a byteArray into a C function that takes a char\* as its argument? \- Stack Overflow](https://stackoverflow.com/questions/37422662/) #ril
      - Mark Tolonen: Note that when passing a python byte string, consider the buffer immutable. In this case you only are reading the buffer, but if you need to allow the C function to mutate the string use: `ctypes.create_string_buffer(5,'hello')` 或 `ctypes.create_string_buffer('hello')` (含 terminating null)。
      - orion elenzil: 若真的要傳 `bytearray`，可以用 build a `ctypes.c_char` backed by the memory of your byte-array, and pass that -- 搭配 `from_buffer()` => 看起來有點 tricky，或許官方說的 `ctypes.create_string_buffer()` 才是正解，反正資料最初拿到都是 `bytes`，差別在於抄進 `bytearray` 或 buffer 而已。
  - [Issue 10803: ctypes: better support of bytearray objects \- Python tracker](https://bugs.python.org/issue10803) 還是不支援 bytearray，不一致的部份還被拿掉了 #ril
  - [python 2\.7 \- Convert ctype byte array to bytes \- Stack Overflow](https://stackoverflow.com/questions/15377338/) eryksun 一樣提到 `from_buffer()` 的用法 #ril
  - [ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html) #ril
      - 一開始就講到 On platforms where `sizeof(long) == sizeof(int)` it is an alias to `c_long`. 看來 `sizeof` 跟 C 裡面的用法一樣。

## Function, Callback ??

  - [Accessing functions from loaded dlls - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#accessing-functions-from-loaded-dlls) 透過 loaded shared library 的 attribute 可以取得 foreign function object (`ctypes._FuncPtr`)；下面一大段都在說明 Windows 的各種狀況，還好 Unix-like 很單純。
  - [Calling functions - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#calling-functions) #ril
      - 拿到 foreign function object 後才能呼叫它，接下來就是如何傳遞參數、如果接收回傳值的問題。
      - `None`, integers, bytes objects (指 bytes-like object?) and (unicode) strings are the only native Python objects that can directly be used as parameters in these function calls. `None` is passed as a C `NULL` pointer, `bytes` objects and strings are passed as pointer to the MEMORY BLOCK that contains their data (`char *` or `wchar_t *`). Python integers are passed as the platforms default C `int` type, their value is masked to fit into the C type.
      - Fundamental data types 整理了一張 ctypes - C - Python 的 type 對照表，例如 `ctypes.c_char_p` -> C `char *` (NUL-terminated) -> Python `bytes` / `None`，或 `ctypes.c_wchar_p` -> C `wchar_t *` (NUL-terminated) -> (unicode) string / `None`，這跟不同的 ctypes type 的 constructor 可以用什麼 Python type 初始化有關。例如： (Python 3)

            >>> c_int()
            c_int(0)
            >>> c_wchar_p("Hello, World!") # unicode
            c_wchar_p(u'Hello, World!')
            >>> c_char_p('Hello, World!')  # bytes
            c_char_p(4558286644)

  - [Calling functions, continued - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#calling-functions-continued) #ril
  - [Specifying the required argument types (function prototypes) - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#specifying-the-required-argument-types-function-prototypes) 包裝 wrapper 給別人使用時會用到 #ril
  - [Return types - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#return-types) #ril
  - [Callback functions - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#callback-functions) #ril
  - [Foreign functions - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#foreign-functions) #ril
      - Foreign functions can be accessed as attributes of loaded shared libraries. The function objects created in this way by default accept any number of arguments, accept any ctypes data instances as arguments, and return the DEFAULT result type specified by the library loader.
      - Foreign function 的型態都是 `ctypes._FuncPtr` -- base class for C callable foreign functions，生成的 foreign function object 可以透過 special attributes 調整：

## Data Type ??

  - [Data types - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#data-types)
      - 所有 ctypes data type 都以 `ctypes._CData` non-public class 做為 base class。
      - All ctypes type instances contain a memory block that hold C compatible data; the address of the memory block is returned by the `addressof()` helper function. 從 constructor 傳進去的資料，會被轉成 C compatible data 存在內部的 memory block，而 C 就是透過該 memory block 的 address 存取資料。
      - Another instance variable is exposed as `_objects`; this contains other Python objects that need to be kept alive IN CASE the memory block contains pointers. 怕被回收應該是被 reference，而不是 reference 別人?? 又為什麼跟 pointer 有關?
      - `_CData.in_dll(library, name)` 似乎可以用來為 struct 產生對應的 type?? This method returns a ctypes type instance exported by a shared library. `name` is the name of the SYMBOL that exports the data, library is the LOADED shared library.
  - [Fundamental data types - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#ctypes-fundamental-data-types-2)
      - 所有 FUNDAMENTAL ctypes data type 都以 `ctypes._SimpleData` non-public class 做為 base class (當然 `_SimpleData` 也繼承 `_CData`)，ctypes data types that are not and do not contain pointers can now be pickled.
      - 會提到 `_SimpleData` 是為了帶出唯一的 common attribute `value` -- This attribute contains the ACTUAL VALUE of the instance.
          - For integer and pointer types, it is an integer, for character types, it is a single character bytes object or string, for character pointer types it is a Python bytes object or string. 聽起來是內部 C compatible data 轉換後的結果??
          - When the `value` attribute is retrieved from a ctypes instance, usually a new object is returned each time. `ctypes` does not implement original object return, always a new object is constructed. The same is true for all other ctypes object instances.
      - Fundamental data types, when returned as foreign function call results, or, for example, by retrieving structure field members or array items, are transparently converted to native Python types. In other words, if a foreign function has a `restype` of `c_char_p`, you will always receive a Python bytes object, not a `c_char_p` instance. 這也僅限於 structure field members 與 arrary items?? 否則什麼時候要用到 `value` attribute?
      - Fundamental ctypes data types 所列的都是 constructor，以 `_p` 結尾的是 pointer；雖然只有內建 `c_char_p`、`c_void_p`、`c_wchar_p` 3 個，其餘的可以透過 `ctypes.POINTER(type)` 自行建立。
      - Class `ctypes.c_byte` 對應 C `signed char`，表示 small integer；可以用 integer 初始化，但內部不會做 overflow checking。
      - Class `ctypes.c_char` 對應 C `char` 表示 a single character；可以用 string 初始化，但長度必須是 1 個字元。
      - Class `ctypes.c_char_p` 對應 C `char *` 表示 a zero-terminated string；可以用 integer address 或 `bytes` object 初始化。若是單純的 character pointer (沒有 zero-terminated 的特性) 想用來指向 binary data 則要改用 `POINTER(c_char)`，但為什麼不是 `POINTER(c_byte)`??
      - Class `ctypes.c_int` 對應 C `signed int`，在 `sizeof(int) == sizeof(long)` 的平台上，就只是 `c_long` 的 alias；可以用 integer 初始化，但內部不會做 overflow checking。
      - Class `ctypes.c_long` 對應 C `signed long`；可以用 integer 初始化，但內部不會做 overflow checking。
      - Class `ctypes.c_wchar` 對應 C `wchart_t` 表示 a single character UNICODE string；可以用 string 初始化，但長度必須是 1 個字元。
      - Class `ctypes.c_wchar_p` 對應 C `wchart_t *` 表示 a pointer to a zero-terminated wide character string，可以用 integer address 或 string 初始化。
  - [Type conversions - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#type-conversions) #ril

## Array ??

  - [Arrays - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#arrays) #ril
  - [Array and pointers - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#arrays-and-pointers)
      - The recommended way to create concrete array types is by MULTIPLYING ANY CTYPES DATA TYPE with a positive integer. Alternatively, you can subclass this type and define `_length_` and `_type_` class variables. 前者的做法顯然比較 pythonic，所以 multiplying 會創造另一個 type，還是有 constructor 可以初始化 array 的內容??
      - Array elements can be read and written using standard subscript and slice accesses; for slice reads, the resulting object is not itself an `Array`. 另外 `_length_` attribute 也可以透過 `len()` 取得，很直覺。
      - Array subclass constructors accept positional arguments, used to initialize the elements in order.

## Pointer ??

  - [Pointers - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#pointers) #ril
  - [Passing pointers (or: passing parameters by reference) - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#passing-pointers-or-passing-parameters-by-reference) #ril
  - [Array and pointers - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#arrays-and-pointers) #ril

## Struct ??

  - [Structures and unions - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#structures-and-unions) #ril
  - [Structured data types - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#structured-data-types) #ril

## Memory Management ??

  - [Mailing List Archive: ctypes free memory which is allocated in C DLL](https://lists.gt.net/python/python/1019748) #ril
      - zlchen.ken: After Python called this function, and done with the returned structure, I would like to free the returned structure. How can I achieve this ? Basically, I tried that I wrote a corresponding free interface in the DLL, it works, but calling the libc.free in Python doesn't work.
      - rosuav: As a general rule, you should always MATCH your allocs and frees. Use the same library to free the memory as was used to allocate it. Nothing else is safe. If your DLL exposes an API that allocates memory, your DLL should expose a CORRESPONDING API to free it. malloc/free 本來就該成對出現；另外提供一個 function 做 free 好像是唯一的解法?
      - zlchen.ken: Yes, I agree writing a corresponding API to free the memory is the best practice and best bet. Sometimes, the third party API may not provide that.
      - rosuav: Then that's a majorly dangerous third party API. The only time it's safe to provide a HALF-ONLY API like that is when the code gets statically linked with the application, so there's a guarantee that `malloc()` in one place corresponds to `free()` in another. ... If a DLL allocates memory and doesn't deallocate it, lean on its author to complete the job. 還是決定 DLL 應該提供另一半 API 來釋放記憶體，要 caller 找特定的 library version 做 free，這太不可靠了。
      - Nobody: On Windows, a process may have multiple versions of the MSVCRT DLL (which provides malloc/free). If an executable or DLL is linked against multiple DLLs, each DLL could be using a different version of MSVCRT. Different versions of MSVCRT may have SEPARATE HEAPS 問題就在這裡，不過這是 Windows 特有的問題?

        If a function in a DLL returns a pointer to memory which it allocated with `malloc()`, that DLL must also provide a function which can be used to free that memory. It can't leave it to the application (or higher-level DLL) to call `free()`, because the application may not be using the same version of MSVCRT as the DLL. 就 Python 端的 caller 而言，用起來會很不方便 ...

  - [c\+\+ \- Python ctypes: how to free memory? Getting invalid pointer error \- Stack Overflow](https://stackoverflow.com/questions/13445568/) eryksun 示範了清楚的解法，另外提供 `void freeme(char *ptr)` 讓 Python 端釋放記憶體 #ril
      - 刻意將 `restype` 設為 `c_void_p` 就不會發生 type conversion，也就能拿到 pointer，稍後才能拿來釋放記憶體。
      - 用到的 [`strdup`](https://en.cppreference.com/w/c/experimental/dynamic/strdup) 明確指出 The returned pointer must be passed to `free` to avoid a memory leak. 有些 API 的設計，確實不會 `malloc`/`free` 成對出現。
  - [Wraping C code with Python CTypes: memory and pointers \| Causeway](https://cvstuff.wordpress.com/2014/11/27/wraping-c-code-with-python-ctypes-memory-and-pointers/) (2014-11-27) 最後刻意提出 `free_mem(double* a)` #ril
  - [c \- How to use malloc and free with python ctypes? \- Stack Overflow](https://stackoverflow.com/questions/18679264/) Once the Python ctypes objects have no references they will be freed automatically #ril
  - [python ctypes and memory leaks](https://ubuntuforums.org/showthread.php?t=1575321&s=d6057461511fb8b7890686e528a52084) #ril
      - nvteighen: But yes ctypes is verbose and unpractical for big APIs. What some people do is to use SWIG, which generates a Python interface from C (and C++) automatically and *really* nicely (well, it isn't just for Python... check it out!)
  - [`ctypes.util.find_msvcrt()` - ctypes — A foreign function library for Python — Python 3\.7\.1 documentation](https://docs.python.org/3/library/ctypes.html#ctypes.util.find_msvcrt) 出現一句 If you need to free memory, for example, allocated by an extension module with a call to the `free(void *)`, it is important that you use the function in the SAME LIBRARY that allocated the memory.

## 參考資料 {: #reference }

  - [ctypes Reference](https://docs.python.org/3/library/ctypes.html#ctypes-reference)
  - [ctype, C, Python Type Mapping](https://docs.python.org/3/library/ctypes.html#fundamental-data-types)

手冊：

  - [cpython/Lib/ctypes at master · python/cpython](https://github.com/python/cpython/tree/master/Lib/ctypes)
