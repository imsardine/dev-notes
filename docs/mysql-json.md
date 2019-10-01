---
title: MySQL / JSON
---
# [MySQL](mysql.md) / JSON

  - [Using JSON with MySQL 5\.7–compatible Amazon Aurora \| AWS Database Blog](https://aws.amazon.com/blogs/database/using-json-with-mysql-5-7-compatible-amazon-aurora/) (2018-02-15)

    What’s the big deal about JSON support in MySQL 5.7?

      - MySQL 5.6 supports numeric, date and time, string (character and byte) types, and spatial data types. Although this is a broad set of supported types, these primitive data types can LIMIT YOUR FLEXIBILITY TO EVOLVE AN APPLICATION.

      - If you use MySQL 5.6, you have two options when PLANNING AHEAD for evolution of the application.

          - The first option is to specify the full schema containing all the fields that you currently need in the application. If the application subsequently needs a new field, you must update the schema to add that column.

            There are some benefits to this approach. You can index the new field. Also, features such as fast data definition language (DDL) in Amazon Aurora can minimize the operational burden of adding a column. However, the fact remains that you must execute a DATABASE SCHEMA CHANGE and also update the SQL statements to accommodate the change.

          - The second option is to use a string to ENCODE A FLEXIBLE SET OF FIELDS and PARSE THE STRING IN THE APPLICATION LAYER. Although flexible, this approach places an unreasonable burden on you to parse the data.

      - This is where JSON comes in—it offers an excellent middle way by providing you the flexibility you need. JSON also provides the benefit of your not having to write any code to parse the data; the ORM or the language runtime should be able to care of it. JSON support was introduced in MySQL 5.7.8.

        ORM 面對的是 JSON-format string ??

      - In addition to the benefits just listed, having JSON as a native type in MySQL means that the database can automatically validate JSON documents stored in JSON columns. Invalid documents produce an error.

        JSON as a native type also allows the database to optimize the JSON format. JSON documents stored in JSON columns are converted to an internal format that permits quick read access to document elements. When the server later must read a JSON value stored in this binary format, the value need not be parsed from a text representation. The binary format is structured to enable the server to look up subobjects or nested values directly by key or array index. It does so without reading all the values before or after them in the document.

        這一段幾乎跟 [MySQL :: MySQL 5\.7 Reference Manual :: 11\.6 The JSON Data Type](https://dev.mysql.com/doc/refman/5.7/en/json.html) 完全一樣。

      - Amazon Aurora now supports MySQL 5.7 compatibility, meaning you can now develop applications using JSON data types on top of MySQL 5.7–compatible Aurora.

        The rest of this post walks through an example e-commerce application for an electronics store that uses JSON data types and MySQL-compatible Aurora.

  - [mysql \- Storing JSON in database vs\. having a new column for each key \- Stack Overflow](https://stackoverflow.com/questions/15367696/) #ril
  - [What you need to know about JSON in MySQL \| Opensource\.com](https://opensource.com/article/17/5/mysql-json) (2017-05-15) #ril
  - [MySQL for your JSON \- Compose Articles](https://www.compose.com/articles/mysql-for-your-json/) (2017-02-08) #ril

  - [MySQL :: MySQL 5\.7 Reference Manual :: 11\.6 The JSON Data Type](https://dev.mysql.com/doc/refman/5.7/en/json.html)

      - As of MySQL 5.7.8, MySQL supports a native `JSON` data type defined by RFC 7159 that enables efficient access to data in JSON (JavaScript Object Notation) documents. The `JSON` data type provides these advantages over STORING JSON-FORMAT STRINGS IN A STRING COLUMN:

          - Automatic validation of JSON documents stored in `JSON` columns. Invalid documents produce an error.

          - Optimized storage format. JSON documents stored in `JSON` columns are converted to an internal format that permits QUICK READ ACCESS TO DOCUMENT ELEMENTS.

            When the server later must read a JSON value stored in this BINARY format, the value need not be parsed from a text representation. The binary format is structured to enable the server to LOOK UP SUBOBJECTS OR NESTED VALUES DIRECTLY BY KEY OR ARRAY INDEX without reading all values before or after them in the document.

      - The space required to store a JSON document is ROUGHLY THE SAME as for `LONGBLOB` or `LONGTEXT`; see Section 11.8, “Data Type Storage Requirements”, for more information.

        It is important to keep in mind that the size of any JSON document stored in a `JSON` column is limited to the value of the `max_allowed_packet` system variable. (When the server is manipulating a JSON value internally in memory, it can be larger than this; the limit applies when the server stores it.)

      - A `JSON` column cannot have a non-`NULL` default value.

        預設值只能是 `NULL`，所以 `JSON` 欄位必然是 nullable ??

      - Along with the `JSON` data type, a set of SQL functions is available to enable operations on JSON values, such as creation, manipulation, and searching. The following discussion shows examples of these operations. For details about individual functions, see [Section 12.17, “JSON Functions”](https://dev.mysql.com/doc/refman/5.7/en/json-functions.html). #ril

      - A set of spatial functions for operating on [GeoJSON](https://geojson.org/) values is also available. See [Section 12.16.11, “Spatial GeoJSON Functions”](https://dev.mysql.com/doc/refman/5.7/en/spatial-geojson-functions.html). #ril

      - `JSON` columns, like columns of other binary types, are not indexed directly; instead, you can create an index on a GENERATED COLUMN that extracts a scalar value from the `JSON` column. See [Indexing a Generated Column to Provide a JSON Column Index](https://dev.mysql.com/doc/refman/5.7/en/create-table-secondary-indexes.html#json-column-indirect-index), for a detailed example. #ril

        什麼是 generated column ?? 感覺會自動同步 JSON 裡特定的資料，方便直接 query。

      - The MySQL optimizer also looks for compatible indexes on virtual columns that match JSON expressions. #ril

      - MySQL NDB Cluster 7.5 (7.5.2 and later) supports JSON columns and MySQL JSON functions, including creation of an index on a column generated from a JSON column as a workaround for being unable to index a JSON column. A maximum of 3 JSON columns per NDB table is supported.

        原來一個 table 的 `JSON` 欄位還有限制數量。

  - [MySQL :: MySQL 8\.0 Reference Manual :: 11\.6 The JSON Data Type](https://dev.mysql.com/doc/refman/8.0/en/json.html) #ril

  - [Working with MySQL JSON data type with prepared statements, using it in Go and resolving the problems I had](https://medium.com/aubergine-solutions/working-with-mysql-json-data-type-with-prepared-statements-using-it-in-go-and-resolving-the-15ef14974c48) (2018-07-31) #ril
  - [Native JSON support in MYSQL 5\.7 : what are the pros and cons of JSON data type in MYSQL? \- Stack Overflow](https://stackoverflow.com/questions/33660866/) #ril

## 新手上路 {: #getting-started }

  - [Using JSON with MySQL 5\.7–compatible Amazon Aurora \| AWS Database Blog](https://aws.amazon.com/blogs/database/using-json-with-mysql-5-7-compatible-amazon-aurora/) (2018-02-15) #ril

    Creating a schema

      - Electronics products can be DIVERSE—laptops, cell phones, printers, TVs, DVDs, and so on. The PRODUCT ATTRIBUTES CAN CORRESPONDINGLY VARY WIDELY. This makes it tricky to store product attributes in a normalized form so that you can search on different features and attributes. For example, we might want to do this for a product comparison.

        We start by creating a database for our store.

            CREATE DATABASE online_store;
            USE online_store

      - For simplicity, our database only has three tables—`brands`, `categories`, and `products`. The `brands` and `categories` tables don’t have JSON fields, so let’s get them out of the way so we can get to the fun part.

            CREATE TABLE brands (
                id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL
            );

            CREATE TABLE categories (
                id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL
            );

            INSERT INTO brands (name) VALUES ('Apple');
            INSERT INTO brands (name) VALUES ('Samsung');
            INSERT INTO brands (name) VALUES ('Lenovo');
            INSERT INTO brands (name) VALUES ('LG');
            INSERT INTO brands (name) VALUES ('ASUS');

            INSERT INTO categories (name) VALUES ('Phones');
            INSERT INTO categories (name) VALUES ('Desktop');
            INSERT INTO categories (name) VALUES ('Laptop');
            INSERT INTO categories (name) VALUES ('Tablets');

        The following is what the tables look like.

            mysql> SELECT * FROM categories;
            +----+---------+
            | id | name    |
            +----+---------+
            |  1 | Phones  |
            |  2 | Desktop |
            |  3 | Laptop  |
            |  4 | Tablets |
            +----+---------+
            4 rows in set (0.00 sec)

            mysql> SELECT * FROM brands;
            +----+---------+
            | id | name    |
            +----+---------+
            |  1 | Apple   |
            |  2 | Samsung |
            |  3 | Lenovo  |
            |  4 | LG      |
            |  5 | ASUS    |
            +----+---------+
            5 rows in set (0.00 sec)

      - Now for the part that starts using JSON. The `products` table holds different product attributes in a JSON column.

            CREATE TABLE products (
            id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            brand_id INT UNSIGNED NOT NULL,
            category_id INT UNSIGNED NOT NULL,
            attributes JSON NOT NULL);

    Inserting JSON data

      - Let’s store information about our first product. We can do this by directly inserting the attributes as a JSON object.

            INSERT INTO products
            (`name`,`brand_id`,`category_id`,`attributes`)
            VALUES
            ('Samsung 3 Chromebook',2,3,
            '{
            "dimensions":{"w":11.4,"d":8,"h":0.7},
            "weight":2.54,
            "color":"black",
            "CPU":"Intel Celeron N3060 / 1.6 GHz",
            "processor_count":2,
            "operating_system":"chrome",
            "memory":4,
            "Storage":"16 GB SSD"
            }'
            );

            mysql> select * from products \G
            *************************** 1. row ***************************
                     id: 1
                   name: Samsung 3 Chromebook
               brand_id: 2
            category_id: 3
             attributes: {"CPU": "Intel Celeron N3060 / 1.6 GHz", "color": "black", "memory": 4, "weight": 2.54, "Storage": "16 GB SSD", "dimensions": {"d": 8, "h": 0.7, "w": 11.4}, "processor_count": 2, "operating_system": "chrome"}
            1 row in set (0.00 sec)

        Insert 時用 JSON string 表示，輸出時也是個字串。

      - If you are using a GUI tool like MySQL Workbench, replace `\G` at the end of the query with `;` ??

      - Formatting a JSON OBJECT in an insert query can turn out to be quite a cumbersome exercise. We can use the function `JSON_OBJECT` to make this easier.

        The `JSON_OBJECT` function accepts a list of key-value pairs in the format

            JSON_OBJECT(key1,value1,key2,value2,key3,value3,……,key(n),value(n).

        這裡的 formatting 指的不是 JSON 欄位的內容要如何輸出，而是 insert 時的字面表示法。

        It returns a JSON object. Let’s insert information about our next product using the `JSON_OBJECT` function.

        注意 `JSON_OBJECT()` 巢狀的用法，還用到了 `JSON_ARRAY()`。

            INSERT INTO products
            (`name`,`brand_id`,`category_id`,`attributes`)
            VALUES
            ('Lenovo Notebook',3,3,JSON_OBJECT(
            "dimensions",JSON_OBJECT("w",12.6,"d",8.8,"h",0.6),"weight",3.53,"color","platinum silver","CPU","Intel Core i7 (7th Gen) 7500U / 2.7 GHz","processor_count",2,"operating_system","Windows 10","memory",16,"storage","512 GB SSD","interfaces",JSON_ARRAY("USB","Thunderbolt","HDMI","Audio Jack"))
            );

            mysql> select * from products where id=2 \G
            *************************** 1. row ***************************
                     id: 2
                   name: Lenovo Notebook
               brand_id: 3
            category_id: 3
             attributes: {"CPU": "Intel Core i7 (7th Gen) 7500U / 2.7 GHz", "color": "platinum silver", "memory": 16, "weight": 3.53, "storage": "512 GB SSD", "dimensions": {"d": 8.8, "h": 0.6, "w": 12.6}, "interfaces": ["USB", "Thunderbolt", "HDMI", "Audio Jack"], "processor_count": 2, "operating_system": "Windows 10"}
            1 row in set (0.00 sec)

        Here we can also see another helpful function at work—`JSON_ARRAY`. This function returns a JSON array when passed a set of values.

      - Another function that helps us store a JSON object is `JSON_MERGE`. The `JSON_MERGE` function takes multiple JSON objects and produces a single JSON object. This is useful when you get data as key-value pair objects. Let’s insert data about our next product using `JSON_MERGE`.

            INSERT INTO products
            (`name`,`brand_id`,`category_id`,`attributes`)
            VALUES
            ('Galaxy Tab',2,4,
            JSON_MERGE(
            '{"display_size":10.1}',
            '{"operating_system":"Android Marshmallow"}',
            '{"storage":"16 GB"}',
            '{"color":"White"}',
            '{"memory":2}',
            '{"camera":"8 MegaPixel"}'
            ));

            mysql> select * from products where id=3 \G
            *************************** 1. row ***************************
                     id: 3
                   name: Galaxy Tab
               brand_id: 2
            category_id: 4
             attributes: {"color": "White", "camera": "8 MegaPixel", "memory": 2, "storage": "16 GB", "display_size": 10.1, "operating_system": "Android Marshmallow"}
            1 row in set (0.00 sec)

        `JSON_MERGE` 可以將多個 JSON object 合併；若參數是字串，也會先被轉成 JSON object。

      - We can use `JSON_OBJECT` and `JSON_MERGE` in combination to make things easier.

            INSERT INTO products 
            (`name`,`brand_id`,`category_id`,`attributes`)
            VALUES
            ('Lenovo Tab',3,4,
            JSON_MERGE(
            JSON_OBJECT("display_size",10.1),
            JSON_OBJECT("operating_system","Android"),
            JSON_OBJECT("storage","16 GB"),
            JSON_OBJECT("color","Black"),
            JSON_OBJECT("memory",16),
            JSON_OBJECT("camera","5 MegaPixel")
            ));

            mysql> select * from products where id=4 \G
            *************************** 1. row ***************************
                     id: 4
                   name: Lenovo Tab
               brand_id: 3
            category_id: 4
             attributes: {"color": "Black", "camera": "5 MegaPixel", "memory": 16 , "storage": "16 GB", "display_size": 10.1, "operating_system": "Android"}
            1 row in set (0.00 sec)

      - Let’s add a few more rows.

            INSERT INTO products
            (`name`,`brand_id`,`category_id`,`attributes`)
            VALUES
            ('Asus Vivobook',5,3,'{"CPU": "Intel Pentium mobile processor N4200", "color": "black", "memory": 4, "weight": 4.10, "storage": "500 GB SSD", "graphics": "Intel HD Graphics 500", "dimensions": {"d": 11.5, "h": 2.6, "w": 19.8}, "interfaces": ["USB", "Thunderbolt", "HDMI", "Audio Jack"], "processor_count": 4, "operating_system": "Windows 10"}'),
            ('Macbook Pro',1,3,'{"CPU": "Intel Core i7", "color": "Silver", "memory": 16, "weight": 4.49, "storage": "256 GB SSD", "graphics": "Intel Iris Pro Graphics", "dimensions": {"d": 14.1, "h": 0.7, "w": 9.7}, "interfaces": ["USB", "Thunderbolt", "Audio Jack"], "processor_count": 4, "operating_system": "Mac OS X"}'),
            ('Apple iPad',1,4,'{"color": "Space Gray", "camera": "1.2 MegaPixel", "memory": 16, "storage": "16 GB", "display_size": 9.7, "operating_system": "iOS 10"}'),
            ('Apple iPad',1,4,'{"color": "Space Gray", "camera": "1.2 MegaPixel", "memory": 32, "storage": "16 GB", "display_size": 9.7, "operating_system": "iOS 10"}'),
            ('S8',2,1,'{"color": "Rose Pink", "camera": "8 MegaPixel", "memory": 64, "weight": "152 g", "dimensions": {"d": 14.1, "h": 0.7, "w": 9.7}, "Screen Size": 5.8, "operating_system": "Android Nougat"}'),
            ('Note',2,1,'{"color": "Black ", "camera": "8 MegaPixel", "memory": 64, "weight": "152 g", "dimensions": {"d": 0.3, "h": 3, "w": 6.3}, "Screen Size": 5.8, "operating_system": "Android Nougat"}'),
            ('iPhone 7 plus',1,1,'{"color": "Silver ", "camera": "12 MegaPixel", "memory": 32, "weight": "120 g", "dimensions": {"d": 3.1, "h": 0.29, "w": 6.2}, "Screen Size": 5.5, "operating_system": "iOS 10"}'),
            (' iPhone 6',1,1,'{"color": "Silver ", "camera": "12 MegaPixel", "memory": 16, "weight": "150 g", "dimensions": {"d": 3.1, "h": 0.29, "w": 6.2}, "Screen Size": 4.7, "operating_system": "iOS 10"}');

        Now that we’ve added a few rows, let’s move on to run queries on JSON objects.

    Selecting and filtering JSON data

      - It’s simple to write a select query like the following one.

            SELECT * FROM products WHERE attributes like '{"color": "Black", "camera": "5 MegaPixel", "memory": 16, "storage": "16 GB", "display_size": 10.1, "operating_system": "Android"}'\G
            *************************** 1. row ***************************
                     id: 4
                   name: Lenovo Tab
               brand_id: 3
            category_id: 4
             attributes: {"color": "Black", "camera": "5 MegaPixel", "memory": 16 , "storage": "16 GB", "display_size": 10.1, "operating_system": "Android"}
            1 row in set (0.00 sec)

        直接用 JSON string 比對!?

      - However, this isn’t the most efficient or useful way to query a database. The function we want to use is `JSON_EXTRACT`. For example, let’s say that we want to find all the Android devices we have.

            SELECT name,attributes->'$.operating_system' as operating_system FROM products WHERE JSON_EXTRACT(attributes,'$.operating_system') like '"Android%';
            +------------+-----------------------+
            | name       | operating_system      |
            +------------+-----------------------+
            | Galaxy Tab | "Android Marshmallow" |
            | Lenovo Tab | "Android"             |
            | S8         | "Android Nougat"      |
            | Note       | "Android Nougat"      |
            +------------+-----------------------+
            4 rows in set (0.00 sec)

        `JSON_EXTRACT()` 只需用在 `WHERE` 條件式裡 ?? 另外 `attributes->'$.operating_system'` 的語法也滿特別的。

      - There are three things to notice here. First, `JSON_EXTRACT` can extract attributes from JSON that we can use for comparison and filtering.

        Second, you can see another SHORTHAND for reading attributes in the select clause: `attributes->'$.operating_system'`.

        Third, the results of the `JSON_EXTRACT` still INCLUDE QUOTES. That leads us to our next function, `JSON_UNQUOTE`. Let’s rewrite the query with `JSON_UNQUOTE` and see the difference.

            SELECT name,JSON_UNQUOTE(attributes->'$.operating_system') as operating_system FROM products WHERE JSON_UNQUOTE(JSON_EXTRACT(attributes,'$.operating_system')) like 'Android%';

            +------------+---------------------+
            | name       | operating_system    |
            +------------+---------------------+
            | Galaxy Tab | Android Marshmallow |
            | Lenovo Tab | Android             |
            | S8         | Android Nougat      |
            | Note       | Android Nougat      |
            +------------+---------------------+
            4 rows in set (0.00 sec)

        注意上面 `like '"Android%'` 的語法，`Android` 前還有個雙引號，另外 `operating_system` 的結果兩側也都有雙引號。都用 `JSON_EXTRACT()` 了，為什麼不自動把引號拿掉?

      - MySQL doesn’t support indexes on JSON columns, but that restriction is easy to get around using VIRTUAL COLUMNS.

            mysql> alter table products add key idx_attributes (attributes);
            ERROR 3152 (42000): JSON column 'attributes' cannot be used in key specification.

        Let’s add a GENERATED COLUMN that stores the memory of each device.

            mysql> alter table products add column memory int as (attributes->'$.memory');
            Query OK, 0 rows affected (0.03 sec)
            Records: 0  Duplicates: 0  Warnings: 0

        Now let’s create an index on the column.

            mysql> alter table products add key idx_memory (memory);
            Query OK, 0 rows affected (0.03 sec)
            Records: 0  Duplicates: 0  Warnings: 0

        Let’s look at the EXPLAIN PLAN for the query to fetch all devices that have 16 GB memory. As you can see from the explain plan, this uses the index we created on the virtual column derived from the JSON column.

            mysql> EXPLAIN SELECT name,memory FROM products where memory=16;
            +----+-------------+----------+------------+------+---------------+------------+---------+-------+------+----------+-------+
            | id | select_type | table    | partitions | type | possible_keys | key        | key_len | ref   | rows | filtered | Extra |
            +----+-------------+----------+------------+------+---------------+------------+---------+-------+------+----------+-------+
            |  1 | SIMPLE      | products | NULL       | ref  | idx_memory    | idx_memory | 5       | const |    5 |   100.00 | NULL  |
            +----+-------------+----------+------------+------+---------------+------------+---------+-------+------+----------+-------+
            1 row in set, 1 warning (0.00 sec)

      - Another useful function is `JSON_KEYS`, which returns the keys from the JSON object. Suppose that we want to see what attributes we store for an iPad.

            mysql> select id,name,JSON_KEYS(attributes) from products where name like 'Apple iPad';
            +----+------------+------------------------------------------------------------------------------+
            | id | name       | JSON_KEYS(attributes)                                                        |
            +----+------------+------------------------------------------------------------------------------+
            |  7 | Apple iPad | ["color", "camera", "memory", "storage", "display_size", "operating_system"] |
            |  8 | Apple iPad | ["color", "camera", "memory", "storage", "display_size", "operating_system"] |
            +----+------------+------------------------------------------------------------------------------+
            2 rows in set (0.00 sec)

        不過 `[...]` 這種結果，在 MySQL 裡是什麼資料型態 ??

  - [MySQL :: MySQL 5\.7 Reference Manual :: 11\.6 The JSON Data Type](https://dev.mysql.com/doc/refman/5.7/en/json.html) #ril

  - [How to Use JSON Data Fields in MySQL Databases — SitePoint](https://www.sitepoint.com/use-json-data-fields-mysql-databases/) (2016-04-29) #ril
  - [A Practical Guide to MySQL JSON Data Type By Example](http://www.mysqltutorial.org/mysql-json/) #ril
  - [Working with JSON in MySQL ― Scotch\.io](https://scotch.io/tutorials/working-with-json-in-mysql) (2017-01-26) #ril
  - [30 mins with MySQL JSON functions \| dasini\.net \- Journal d'un expert MySQL](http://dasini.net/blog/2018/07/23/30-mins-with-mysql-json-functions/) (2018-07-23) #ril

## 參考資料 {: #reference }

