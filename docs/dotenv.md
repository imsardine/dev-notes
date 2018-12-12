# .env

  - [Declare default environment variables in file \| Docker Documentation](https://docs.docker.com/compose/env-file/) Docker Compose 可以用 `.env` 宣告預設的 environment variable。
  - [Installation — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/installation/) Flask 有裝 python-dotdev 的話，`flask` 可以由 `.env` 或 `.flaskenv` 提供環境變數的值；提到 `.env` 可以放 private variable，不該進 VCS 版控。
  - [III. Config: Store config in the environment - The Twelve\-Factor App](https://12factor.net/config) python-env 提到的 12-factor principles 之一 #ril
      - 這裡的 config 不包括像是 `config/routes.rb` 的 internal application config，因為這類 config 不會因 deploy 而異，最好用 code 來做。
  - [motdotla/dotenv: Loads environment variables from \.env for nodejs projects\.](https://github.com/motdotla/dotenv) #ril
  - [theskumar/python\-dotenv: Get and set values in your \.env file in local and production servers\.](https://github.com/theskumar/python-dotenv) #ril
  - [Pipenv: Python Dev Workflow for Humans — pipenv 2018\.11\.27\.dev0 documentation](https://pipenv.readthedocs.io/en/latest/) 提到 Streamline development workflow by loading `.env` files.

## `.env` 的管理/版本控制 ??

  - [How do you manage \.env \(dotenv\) files? : devops](https://www.reddit.com/r/devops/comments/52pl5c/how_do_you_manage_env_dotenv_files/) #ril
      - 最佳實務建議 `.env` 不要放進 VCS 版控，但要如何 track changes?
      - mvarrieur: 會把 `.env.example` 放進版控，若 dev/test credentials 不能存取 sensitive data 也會放進去，方便使用。
      - ztherion: 把 example config 放進版控，並留下 password manager 的連結。
      - miend: 把 template 放進版控，但實際上會透過 Kubernetes Secrets 以 volume 的型式掛進 container。
