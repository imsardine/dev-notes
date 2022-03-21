# Poetry

  - [Poetry \- Python dependency management and packaging made easy](https://python-poetry.org/)

    過去好像沒有工具同時含括 packaging 與 dependency management 兩個面向。

    DETERMINISTIC BUILDS - Develop

      - Poetry comes with all the tools you might need to manage your projects in a DETERMINISTIC WAY.

            $ poetry add pendulum

            Using version ^2.0.5 for pendulum

            Updating dependencies
            Resolving dependencies... (1.5s)

            Writing lock file

            Package operations: 4 installs, 0 updates, 0 removals

              - Installing six (1.13.0): Downloading... 25%
              - Updating pytzdata (2019.3 -> 2020.4): Installing...
              - Installing pendulum (2.0.5)

        所謂 deterministic build，其實就是 [reproduciable build](https://en.wikipedia.org/wiki/Reproducible_builds)，pipenv 也是類似的定位。

        > It also generates the ever-important Pipfile.lock, which is used to produce deterministic builds.
        >
        > -- [Pipenv: Python Dev Workflow for Humans](https://pipenv.pypa.io/en/latest/)

    PACKAGE WITH EASE - Build

      - Easily build and package your projects with a SINGLE COMMAND.

            $ poetry build

            Building poetry (1.0.0)
            - Building sdist
            - Built poetry-1.0.0.tar.gz

            - Building wheel
            - Built poetry-1.0.0-py2.py3-none-any.whl

        Supports source distribution and wheels.

    SHARE YOUR WORK - Publish

      - Make your work known by publishing it to PyPI.

            $ poetry publish

            Publishing poetry (1.0.0) to PyPI

            - Uploading poetry-1.0.0.tar.gz 100%
            - Uploading poetry-1.0.0-py2.py3-none-any.whl 58%

        You can also publish on private repositories.

    CHECK THE STATE OF YOUR DEPENDENCIES - Track

      - Having an insight of your project's dependencies is just one command away.

            $ poetry show --tree
            requests-toolbelt 0.8.0 A utility belt for advanced users...
            └── requests <3.0.0,>=2.0.1
                ├── certifi >=2017.4.17
                ├── chardet >=3.0.2,<3.1.0
                ├── idna >=2.5,<2.7
                └── urllib3 <1.23,>=1.21.1

            $ poetry show --latest
            pendulum 2.0.4   1.4.5 Python datetimes made easy.
            django   1.11.11 2.0.3 A high-level Python Web framework ...
            requests 2.18.4  2.18.4 Python HTTP for Humans.

    DEPENDENCY RESOLVER

      - Poetry comes with an exhaustive dependency resolver, which will always find a solution if it exists.

        And get a detailed explanation if no solution exists.

    ISOLATION

      - Poetry either uses your configured virtualenvs or creates its own to always be isolated from your system.

        The behavior is configurable.

    INTUITIVE CLI

      - Poetry's commands are intuitive and easy to use, with SENSIBLE DEFAULTS while still being configurable.

        It's also extensible with PLUGIN system.

## 參考資料 {: #reference }

  - [Poetry](https://python-poetry.org/)
  - [python-poetry/poetry - GitHub](https://python-poetry.org/)
