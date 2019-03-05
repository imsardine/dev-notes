# WordPress

  - [WordPress \- Wikipedia](https://en.wikipedia.org/wiki/WordPress) #ril

## Theme

  - [Theme Directory - Featured \| WordPress\.org](https://wordpress.org/themes/) #ril
  - [50\+ Best Free Responsive WordPress Themes 2019 \- Colorlib](https://colorlib.com/wp/free-wordpress-themes/) (2019-01-11) 感覺質感還不錯 #ril

## 安裝設定 {: #installation }

  - [Download \| WordPress\.org](https://wordpress.org/download/) #ril
  - [Installing WordPress « WordPress Codex](https://codex.wordpress.org/Installing_WordPress#Famous_5-Minute_Installation) #ril

### Docker ??

  - [wordpress \- Docker Hub](https://hub.docker.com/_/wordpress/) #ril

        $ docker run --name some-wordpress --link some-mysql:mysql -d wordpress

    If you'd like to be able to access the instance from the host without the container's IP, standard port mappings can be used:

        $ docker run --name some-wordpress --link some-mysql:mysql -p 8080:80 -d wordpress

    Then, access it via http://localhost:8080 or http://host-ip:8080 in a browser.

      - The following environment variables are also honored for configuring your WordPress instance:
          - `-e WORDPRESS_DB_HOST=...` (defaults to the IP and port of the linked `mysql` container)
          - `-e WORDPRESS_DB_USER=...` (defaults to "`root`")
          - `-e WORDPRESS_DB_PASSWORD=...` (defaults to the value of the `MYSQL_ROOT_PASSWORD` environment variable from the linked `mysql` container)

            這是 container link 特有的效果 -- recipient container (WordPress) 會收到 source container (MySQL) 的環境變數。

          - `-e WORDPRESS_DB_NAME=...` (defaults to "`wordpress`")
          - `-e WORDPRESS_TABLE_PREFIX=...` (defaults to `""`, only set this when you need to override the default table prefix in `wp-config.php`)
          - `-e WORDPRESS_AUTH_KEY=...`, `-e WORDPRESS_SECURE_AUTH_KEY=...`, `-e WORDPRESS_LOGGED_IN_KEY=...`, `-e WORDPRESS_NONCE_KEY=...`, `-e WORDPRESS_AUTH_SALT=...`, `-e WORDPRESS_SECURE_AUTH_SALT=...`, `-e WORDPRESS_LOGGED_IN_SALT=...`, `-e WORDPRESS_NONCE_SALT=...` (default to unique random SHA1s) 這是做什麼的??
          - `-e WORDPRESS_DEBUG=1` (defaults to disabled, non-empty value will enable `WP_DEBUG` in `wp-config.php`)
          - `-e WORDPRESS_CONFIG_EXTRA=...` (defaults to nothing, non-empty value will be embedded verbatim inside `wp-config.php` -- especially useful for applying extra configuration values this image does not provide by default such as `WP_ALLOW_MULTISITE`; see [docker-library/wordpress#142](https://github.com/docker-library/wordpress/pull/142) for more details)

      - If the `WORDPRESS_DB_NAME` specified does not already exist on the given MySQL server, it will be created automatically upon startup of the wordpress container, provided that the `WORDPRESS_DB_USER` specified has the necessary permissions to create it.

      - If you'd like to use an external database instead of a linked `mysql` container, specify the hostname and port with `WORDPRESS_DB_HOST` along with the password in `WORDPRESS_DB_PASSWORD` and the username in `WORDPRESS_DB_USER` (if it is something other than `root`):

            $ docker run --name some-wordpress -e WORDPRESS_DB_HOST=10.1.2.3:3306 \
                -e WORDPRESS_DB_USER=... -e WORDPRESS_DB_PASSWORD=... -d wordpress

      - When running WordPress with TLS behind a reverse proxy such as NGINX which is responsible for doing [TLS termination](https://en.wikipedia.org/wiki/TLS_termination_proxy), be sure to set `X-Forwarded-Proto` appropriately (see ["Using a Reverse Proxy" in "Administration Over SSL" in upstream's documentation](https://codex.wordpress.org/Administration_Over_SSL#Using_a_Reverse_Proxy)). No additional environment variables or configuration should be necessary (this image automatically adds the noted `HTTP_X_FORWARDED_PROTO` code to `wp-config.php` if any of the above-noted environment variables are specified).

        就 client --> https:// --> reverse proxy --> http:// --> WordPress 的關係及 [X\-Forwarded\-Proto \- HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-Proto) 看來，reverse proxy 要在 `X-Forwarded-Proto` 記錄 client --> revere proxy 這一段真正的 protocol，因為 reverse proxy --> WordPress 這一段固定走 HTTP，若想知道 client 走的 protocol，就必須要取用 `X-Forwarded-Proto` header -- 猜想是用來產生 URL。

  - [Quickstart: Compose and WordPress \| Docker Documentation](https://docs.docker.com/compose/wordpress/) #ril

  - [Docer Secrets - wordpress \- Docker Hub](https://hub.docker.com/_/wordpress/#docker-secrets) 透過不同 `_FILE` 的環境變數傳 #ril

  - [WordPress in Docker\. Part 1: Dockerization \- Buddy](https://buddy.works/guides/wordpress-docker-kubernetes-part-1) #ril

## 參考資料 {: #reference}

  - [WordPress](https://wordpress.org/)
  - [Theme Directory](https://wordpress.org/themes/)
