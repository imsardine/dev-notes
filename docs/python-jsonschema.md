# jsonschema

  - [Julian/jsonschema: An\(other\) implementation of JSON Schema for Python](https://github.com/Julian/jsonschema)

      - `jsonschema` is an implementation of JSON Schema for Python (supporting 2.7+ including Python 3).

      - It can also be used from console:

            $ jsonschema -i sample.json sample.schema

    Features

      - Full support for Draft 7, Draft 6, Draft 4 and Draft 3

      - LAZY VALIDATION that can iteratively report all validation errors.

        不用走過整份文件才能回報第一個錯誤? 還是預設只會回報第一個錯誤 ??

      - Programmatic querying of which properties or items failed validation.

## 新手上路 {: #getting-started }

  - [Julian/jsonschema: An\(other\) implementation of JSON Schema for Python](https://github.com/Julian/jsonschema)

        >>> from jsonschema import validate

        >>> # A sample schema, like what we'd get from json.load()
        >>> schema = {
        ...     "type" : "object",
        ...     "properties" : {
        ...         "price" : {"type" : "number"},
        ...         "name" : {"type" : "string"},
        ...     },
        ... }

        >>> # If no exception is raised by validate(), the instance is valid.
        >>> validate(instance={"name" : "Eggs", "price" : 34.99}, schema=schema)

        >>> validate(
        ...     instance={"name" : "Eggs", "price" : "Invalid"}, schema=schema,
        ... )                                   # doctest: +IGNORE_EXCEPTION_DETAIL
        Traceback (most recent call last):
            ...
        ValidationError: 'Invalid' is not of type 'number'

    用法很單純，`jsonschema.validate(instance, schema)` 沒有丟出 `ValidationError` 就是通過檢查；其中 `instance` (JSON document) 及 `schema` 都跟 `json.load()` 的結果一樣。

    不過以這個例子而言，`ValidationError` 沒有指出是 `price` 的資料有問題，大一點的 JSON document 會不會很難找出問題 ??

  - [The Basics - Schema Validation — jsonschema 3\.0\.1 documentation](https://python-jsonschema.readthedocs.io/en/stable/validate/#the-basics) #ril

      - The simplest way to validate an instance under a given schema is to use the `validate()` function.

  - [Validate data easily with JSON Schema « Python recipes « ActiveState Code](http://code.activestate.com/recipes/579135-validate-data-easily-with-json-schema/) #ril
  - [How to JSON schema validate 10x \(or 100x\) faster in Python \- Peterbe\.com](https://www.peterbe.com/plog/jsonschema-validate-10x-faster-in-python) (2018-11-04) #ril

## Performance

  - [Benchmarks - Julian/jsonschema: An\(other\) implementation of JSON Schema for Python](https://github.com/Julian/jsonschema#benchmarks) #ril

## 安裝設置 {: #setup }

  - 用 pip 安裝 `jsonschema` 套件，支援 Python 2.7+ 與 Python 3。

---

參考資料：

  - [Julian/jsonschema: An\(other\) implementation of JSON Schema for Python](https://github.com/Julian/jsonschema#installation)

    `jsonschema` is available on PyPI. You can install using pip:

        $ pip install jsonschema

  - [jsonschema/setup\.cfg at v3\.0\.1 · Julian/jsonschema](https://github.com/Julian/jsonschema/blob/v3.0.1/setup.cfg#L26) 相依性不少?

        install_requires =
            attrs>=17.4.0
            pyrsistent>=0.14.0
            setuptools
            six>=1.11.0
            functools32;python_version<'3'

        [options.extras_require]
        format =
            idna
            jsonpointer>1.13
            rfc3987
            strict-rfc3339
            webcolors

    [Schema Validation — jsonschema 3\.0\.1 documentation](https://python-jsonschema.readthedocs.io/en/stable/validate/#jsonschema.FormatError) 提到 `pip install jsonschema[format]`，跟部份 format 的檢查有關。

## 參考資料 {: #reference }

  - [jsonschema - Read the Docs](https://python-jsonschema.readthedocs.io/)
  - [Julian/jsonschema - GitHub](https://github.com/Julian/jsonschema)
  - [jsonschema - PyPI](https://pypi.org/project/jsonschema/)

手冊：

  - [`jsonschema.validate()`](https://python-jsonschema.readthedocs.io/en/stable/validate/#jsonschema.validate)
