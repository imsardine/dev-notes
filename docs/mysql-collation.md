---
:title: MySQL / Collation
---
# [MySQL](mysql.md) / Collation

  - [MySQL :: MySQL 8\.0 Reference Manual :: 10 Character Sets, Collations, Unicode](https://dev.mysql.com/doc/refman/8.0/en/charset.html) #ril

## utf8 & utf8mb4

  - [The utf8mb4 Upgrade – Make WordPress Core](https://make.wordpress.org/core/2015/04/02/the-utf8mb4-upgrade/) (2015-04-02)

      - In WordPress 4.2, we’re upgrading tables to `utf8mb4`, when we can. Your site will only upgrade when the following conditions are met:

          - You’re currently using the utf8 character set.
          - Your MySQL server is version 5.5.3 or higher (including all 10.x versions of MariaDB).
          - Your MySQL client libraries are version 5.5.3 or higher. If you’re using [mysqlnd](https://www.php.net/manual/en/book.mysqlnd.php), 5.0.9 or higher.

      - The difference between `utf8` and `utf8mb4` is that the former can only store 3 BYTE CHARACTERS, while the latter can store 4 BYTE CHARACTERS. In Unicode terms, `utf8` can only store characters in the Basic Multilingual Plane, while `utf8mb4` can store ANY Unicode character. This greatly expands the language usability of WordPress, especially in countries that use Han character sets.

      - Unicode isn’t without its problems, but it’s the best option available.

        `utf8mb4` is 100% backwards compatible with `utf8`.

      - Due to INDEX SIZE RESTRICTIONS ?? in MySQL, this does mean we need to re-create a handful of indexes to fit within MySQL’s rules. Using a standard configuration, MySQL allows 767 bytes per index, which for `utf8` means 767 bytes / 3 bytes = 255 characters. For `utf8mb4`, that means 767 bytes / 4 bytes = 191 characters. The indexes that will be resized are:

          - `wp_usermeta.meta_key`
          - `wp_terms.slug`
          - `wp_terms.name`
          - `wp_commentmeta.meta_key`
          - `wp.postmeta.meta_key`
          - `wp_posts.post_name`

        And from Multisite:

          - `wp_site.domain`
          - `wp_sitemeta.meta_key`
          - `wp_signups.domain`

        為什麼 Workpress 這麼大的專案，只會影響到少數幾個 index ??

      - Of course, the Multisite (and `wp_usermeta`) keys obey the `DO_NOT_UPGRADE_GLOBAL_TABLES` setting. The upgrade will only be attempted once, though we’ll probably add a check in a future WordPress version to see if we can upgrade now (say, if you’ve upgraded your MySQL server since upgrading to WordPress 4.2).

      - If you’re a plugin developer and your plugin includes custom tables, please test that your indexes fit within MySQL’s limits. MySQL won’t always produce an error when the index is too big, so you’ll need to manually check the size of each index, instead of relying on automated testing.

      - If you’d like to upgrade your custom tables to `utf8mb4` (and your indexes are all in order), you can do it really easily with the shiny new `maybe_convert_table_to_utf8mb4( $tablename )` function. It’s available in `wp-admin/includes/upgrade.php`, and will SANITY CHECK that your tables are ENTIRELY `utf8` before upgrading.

        有些 `utf8`，有些是 `utf8mb4` 會有什麼問題嗎??

  - [MySQL utf8 vs utf8mb4 \- What's the difference between utf8 and utf8mb4?](https://www.eversql.com/mysql-utf8-vs-utf8mb4-whats-the-difference-between-utf8-and-utf8mb4/) (2017-07-11) #ril

    The Story of UTF8 VS UTF8MB4

      - I once got a call from the support team, saying that one of our customers reported that the application fails to save data in one of our business-critical features. The customer is seeing a general error from the application. About 30 of his 500 users are experiencing this issue and can’t save data in the application.

        After a short 15 minutes debugging session, we saw that the data is transmitted from the client side, successful received in the server side, and the insertion query is fired to the database. But still, no data in the database. Hmm.. now it got interesting.

      - Looking at the logs, it turns out that for specific inputs, MySQL REFUSED TO INSERT THE DATA to the database. The error MySQL logged was:

            Incorrect string value: ‘\xF0\x9F\x98\x81…’ for column ‘data’ at row 1

        Looking at those first 4 bytes, I got to no conclusion as to what was the issue. When googling them, I found that they represent an EMOTICON in UTF8. So, it means that for this specific input, each character is probably ENCODED AS 4 BYTES.

        I tried to reproduce this issue with a different string, which has its characters encoded with 1-3 bytes per character. It turned out that it only happens when each character in the data was combined of 4-byte.

      - We scratched our heads and thought – the character set we used in the database is UTF8, which should support 4 bytes (right?), so what’s wrong?

        Well, it turns out we were wrong. We quickly realized that MySQL decided that UTF-8 can only hold 3 bytes per character. Why? no good reason that I can find documented anywhere. Few years later, when MySQL 5.5.3 was released, they introduced a new encoding called `utf8mb4`, which is actually the REAL 4-BYTE utf8 encoding that you know and love.

    Recommendation

      - if you’re using MySQL (or MariaDB or Percona Server), make sure you know your encodings. I would recommend anyone to set the MySQL encoding to `utf8mb4`. Never use `utf8` in MySQL, there is no good reason to do that (unless you like tracing encoding related bugs).


    How to convert utf8 to utf8mb4 in MySQL?

      - So now I had to fix this issue. As I recommend above, I wanted to use utf8mb4 and drop the old utf8. To do that, I used the following ALTER statements. Please DO NOT just copy paste them. You need to make sure you understand each of them and adjust them accordingly.

## 參考資料 {: #reference }

文件：

  - [Character Sets, Collations, Unicode - MySQL Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/charset.html)
