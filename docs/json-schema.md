# JSON Schema

  - [JSON Schema \| The home of JSON Schema](https://json-schema.org/)

      - JSON Schema is a vocabulary that allows you to ANNOTATE and VALIDATE JSON documents.

    Advantages > JSON Schema

      - DESCRIBES your existing data format(s).
      - Provides clear human- and machine- readable documentation.

      - Validates data which is useful for:

          - Automated testing.

          - Ensuring quality of client submitted data.

            以為會比較常用在驗證 server 吐出來的資料。

    Advantages > JSON Hyper-Schema ??

      - Make any JSON format a hypermedia format with no constraints on document structure
      - Allows use of URI Templates with instance data
      - Describe client data for use with links using JSON Schema.
      - Recognizes collections and collection items.

    The Path to Standardization

      - The JSON Schema project intends to shepherd all FOUR draft series to RFC status. Currently, we are continuing to improve our SELF-PUBLISHED INTERNET-DRAFTS. The next step will be to get the drafts adopted by an IETF Working Group.

        We are actively investigating how to accomplish this. If you have experience with such things and would like to help, please contact us!

      - In the meantime, publication of Internet-Draft documents can be tracked through the IETF:

          - JSON Schema (core)
          - JSON Schema Validation
          - JSON Hyper-Schema
          - Relative JSON Pointers ??

      - Internet-Drafts expire after six months, so our goal is to publish often enough to always have a set of unexpired drafts available. There may be brief gaps as we wrap up each draft and finalize the text.

      - The intention, particularly for vocabularies such as validation which have been widely implemented, is to remain as compatible as possible from draft to draft. However, these are still drafts, and given a clear enough need validated with the user community, major changes can occur.

## 新手上路 {: #getting-started }

  - [Quickstart - JSON Schema \| The home of JSON Schema](https://json-schema.org/#quickstart)

      - The JSON document being validated or described we call the INSTANCE, and the document containing the DESCRIPTION is called the SCHEMA.

      - The most basic schema is a BLANK JSON object, which constrains nothing, ALLOWS ANYTHING, and describes nothing:

            {}

      - You can apply constraints on an instance by adding VALIDATION KEYWORDS to the schema. For example, the “`type`” keyword can be used to restrict an instance to an object, `array`, `string`, `number`, `boolean`, or `null`:

            { "type": "string" }

        為什麼要檢查 "一定是 null"? 應該是檢查 nullable 吧 ??

      - JSON Schema is HYPERMEDIA READY, and ideal for annotating your existing JSON-based HTTP API. JSON Schema documents are IDENTIFIED BY URIs, which can be used in HTTP Link headers, and inside JSON Schema documents to allow RECURSIVE DEFINITIONS. ??

  - [Getting Started Step\-By\-Step \| JSON Schema](https://json-schema.org/learn/getting-started-step-by-step.html) #ril

    Introduction

      - The following example is by no means definitive of all the value JSON Schema can provide. For this you will need to go deep into the specification itself – learn more at http://json-schema.org/specification.html.

      - Let’s pretend we’re interacting with a JSON based product catalog. This catalog has a product which has:

          - An identifier: `productId`
          - A product name: `productName`
          - A selling cost for the consumer: `price`
          - An optional set of tags: `tags`.

        For example:

            {
              "productId": 1,
              "productName": "A green door",
              "price": 12.50,
              "tags": [ "home", "green" ]
            }

      - While generally straightforward, the example leaves some OPEN QUESTIONS. Here are just a few of them:

          - What is `productId`?
          - Is `productName` required?
          - Can the price be zero (0)?
          - Are all of the tags string values?

        When you’re talking about a DATA FORMAT, you want to have METADATA about what keys mean, including the valid inputs for those keys. JSON Schema is a proposed IETF standard how to answer those questions for data.

    Starting the schema

      - To start a schema definition, let’s begin with a basic JSON schema.

        We start with four properties called KEYWORDS which are expressed as JSON keys.

        Yes. the standard uses a JSON data document to describe data documents, most often that are also JSON data documents but could be in any number of other content types like `text/xml`. 也可以用 XML 寫 ??

          - The `$schema` keyword states that this schema is written according to a specific draft of the standard and used for a variety of reasons, primarily version control.

            The `$id` keyword defines a URI for the schema, and the base URI that other URI references within the schema are resolved against.

            其中 `$schema` 應該是必要的，否則 validator 不知道要以哪個版本來解讀 schema，但 `$id` 是必要的嗎 ??

          - The `title` and `description` annotation keywords are DESCRIPTIVE ONLY. They do not add constraints to the data being validated. The INTENT of the schema is stated with these two keywords.

          - The `type` validation keyword defines the FIRST CONSTRAINT on our JSON data and in this case it has to be a JSON Object.

                {
                  "$schema": "http://json-schema.org/draft-07/schema#",
                  "$id": "http://example.com/product.schema.json",
                  "title": "Product",
                  "description": "A product in the catalog",
                  "type": "object"
                }

          - We introduce the following pieces of terminology when we start the schema:

              - Schema Keyword: `$schema` and `$id`.
              - Schema Annotations: `title` and `description`.
              - Validation Keyword: `type`.

            雖然 Keyword 分 schema/validation keyword 兩種，但也只有 validation keyword 跟 validation 有關 (產生實質的 constraints)，而 schema annotation 就如字面所示只有說明性質，不影響 validation。

    Defining the properties

      - `productId` is a numeric value that uniquely identifies a product. Since this is the canonical identifier for a product, it doesn’t make sense to have a product without one, so it is required.

        從 `{}` 代表 allow anything 看來，schema 只要描述 JSON document 有用到的部份即可? 以下面一開始的 schema 為例，只宣告了 `productId` 與 `productName`，拿來檢查上面帶有 `price` 及 `tags` 的 JSON document 並不會出錯。

      - In JSON Schema terms, we update our schema to add:

          - The `properties` validation keyword.

          - The `productId` key.

            `description` schema annotation and `type` validation keyword is noted – we covered both of these in the previous section.

          - The `required` validation keyword listing `productId`.

                {
                  "$schema": "http://json-schema.org/draft-07/schema#",
                  "$id": "http://example.com/product.schema.json",
                  "title": "Product",
                  "description": "A product from Acme's catalog",
                  "type": "object",
                  "properties": {
                    "productId": {
                      "description": "The unique identifier for a product",
                      "type": "integer"
                    }
                  },
                  "required": [ "productId" ]
                }

             注意 `required` 不是寫在各別的 property 底下，而是跟 `type`、`properties` 同一層。

          - `productName` is a string value that describes a product. Since there isn’t much to a product without a name it also is required.

            Since the `required` validation keyword is an array of strings we can note multiple keys as required; We now include `productName`.

                {
                  "$schema": "http://json-schema.org/draft-07/schema#",
                  "$id": "http://example.com/product.schema.json",
                  "title": "Product",
                  "description": "A product from Acme's catalog",
                  "type": "object",
                  "properties": {
                    "productId": {
                      "description": "The unique identifier for a product",
                      "type": "integer"
                    },
                    "productName": {
                      "description": "Name of the product",
                      "type": "string"
                    }
                  },
                  "required": [ "productId", "productName" ]

    Going deeper with properties

      - According to the store owner there are no free products. ;)

        The `price` key is added with the usual description schema annotation and `type` validation keywords covered previously. It is also included in the array of keys defined by the `required` validation keyword.

        We specify the value of `price` must be something other than zero using the `exclusiveMinimum` validation keyword.

        If we wanted to include zero as a valid price we would have specified the `minimum` validation keyword.

              {
                "$schema": "http://json-schema.org/draft-07/schema#",
                "$id": "http://example.com/product.schema.json",
                "title": "Product",
                "description": "A product from Acme's catalog",
                "type": "object",
                "properties": {
                  ...,
                  "price": {
                    "description": "The price of the product",
                    "type": "number",
                    "exclusiveMinimum": 0
                  }
                },
                "required": [ "productId", "productName", "price" ]
              }

        `number` 跟 `integer` 的差別在於，`number` 可以表現小數點。

      - Next, we come to the `tags` key.

        The store owner has said this:

          - If there are tags there must be at least one tag,
          - All tags must be unique; no duplication within a single product.
          - All tags must be text.
          - Tags are nice but they aren’t required to be present.

        Therefore:

          - The `tags` key is added with the usual annotations and keywords.
          - This time the `type` validation keyword is `array`.
          - We introduce the `items` validation keyword so we can define what appears in the array. In this case: `string` values via the `type` validation keyword.
          - The `minItems` validation keyword is used to make sure there is at least one item in the array.
          - The `uniqueItems` validation keyword notes all of the items in the array must be unique relative to one another.

        We did not add this key to the `required` validation keyword array because it is optional.

            {
              "$schema": "http://json-schema.org/draft-07/schema#",
              "$id": "http://example.com/product.schema.json",
              "title": "Product",
              "description": "A product from Acme's catalog",
              "type": "object",
              "properties": {
                ...,
                "tags": {
                  "description": "Tags for the product",
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "minItems": 1,
                  "uniqueItems": true
                }
              },
              "required": [ "productId", "productName", "price" ]
            }

        搭配 `minItems` 來看，`"tags": []` 就無法通過 validation；要允許這種狀況，把 `"minItems": 1` 拿掉即可。

    Nesting data structures

      - Up until this point we’ve been dealing with a very FLAT schema – only one level. This section demonstrates nested data structures.

        We omitted the `description` annotation keyword for brevity in the example. While it’s usually preferable to annotate thoroughly in this case the structure and key names are fairly familiar to most developers.

      - The `dimensions` key is added using the concepts we’ve previously discovered. Since the `type` validation keyword is `object` we can use the `properties` validation keyword to define a nested data structure.

        You will note the SCOPE of the `required` validation keyword is applicable to the `dimensions` key and NOT BEYOND.

            {
              "$schema": "http://json-schema.org/draft-07/schema#",
              "$id": "http://example.com/product.schema.json",
              "title": "Product",
              "description": "A product from Acme's catalog",
              "type": "object",
              "properties": {
                ...,
                "dimensions": {
                  "type": "object",
                  "properties": {
                    "length": {
                      "type": "number"
                    },
                    "width": {
                      "type": "number"
                    },
                    "height": {
                      "type": "number"
                    }
                  },
                  "required": [ "length", "width", "height" ]
                }
              },
              "required": [ "productId", "productName", "price" ]
            }

    References outside the schema

      - So far our JSON schema has been wholly SELF CONTAINED. It is very common to share JSON schema across many data structures for reuse, readability and maintainability among other reasons.

      - For this example we introduce a new JSON Schema RESOURCE and for both properties therein:

          - We use the `minimum` validation keyword noted earlier.
          - We add the `maximum` validation keyword.

        Combined, these give us a range to use in validation.

            {
              "$id": "https://example.com/geographical-location.schema.json",
              "$schema": "http://json-schema.org/draft-07/schema#",
              "title": "Longitude and Latitude",
              "description": "A geographical coordinate on a planet (most commonly Earth).",
              "required": [ "latitude", "longitude" ],
              "type": "object",
              "properties": {
                "latitude": {
                  "type": "number",
                  "minimum": -90,
                  "maximum": 90
                },
                "longitude": {
                  "type": "number",
                  "minimum": -180,
                  "maximum": 180
                }
              }
            }

      - Next we add a reference to this new schema so it can be INCORPORATED.

            {
              "$schema": "http://json-schema.org/draft-07/schema#",
              "$id": "http://example.com/product.schema.json",
              "title": "Product",
              "description": "A product from Acme's catalog",
              "type": "object",
              "properties": {
                ...,
                "warehouseLocation": {
                  "description": "Coordinates of the warehouse where the product is located.",
                  "$ref": "https://example.com/geographical-location.schema.json"
                }
              },
              "required": [ "productId", "productName", "price" ]
            }

    Taking a look at data for our defined JSON Schema

      - We’ve certainly expanded on the concept of a product since our earliest sample data (scroll up to the top). Let’s take a look at data which matches the JSON Schema we have defined.

            {
              "productId": 1,
              "productName": "An ice sculpture",
              "price": 12.50,
              "tags": [ "cold", "ice" ],
              "dimensions": {
                "length": 7.0,
                "width": 12.0,
                "height": 9.5
              },
              "warehouseLocation": {
                "latitude": -78.75,
                "longitude": 20.4
              }
            }

  - [Understanding JSON Schema — Understanding JSON Schema 7\.0 documentation](https://json-schema.org/understanding-json-schema/) #ril
  - [Introduction \- JSON Schema](https://cswr.github.io/JsonSchema/spec/introduction/) #ril

## Type, Nullable ??

  - [6.1.1. type - JSON Schema Validation: A Vocabulary for Structural Validation of JSON](https://json-schema.org/latest/json-schema-validation.html#rfc.section.6.1.1)

      - The value of this keyword MUST be either a string or an ARRAY. If it is an array, elements of the array MUST be strings and MUST be unique.
      - String values MUST be one of the six primitive types (`"null"`, `"boolean"`, `"object"`, `"array"`, `"number"`, or `"string"`), or `"integer"` which matches any number with a zero fractional part.
      - An instance validates if and only if the instance is IN ANY OF THE SETS listed for this keyword.

  - [python \- JSON Schema: validate a number\-or\-null value \- Stack Overflow](https://stackoverflow.com/questions/22565005/) #ril
  - [Handling the null type in JSON schema](https://www.ibm.com/support/knowledgecenter/en/SS4SVW_beta/designing/api_null_type.html) 出現 `type": [ "null", "string" ]` 的用法。

## Validator

  - [Validators - Implementations \| JSON Schema](https://json-schema.org/implementations.html#validators)

    JavaScript

      - [ajv](https://github.com/epoberezkin/ajv) draft-07, -06, -04 for Node.js and browsers - supports custom keywords and $data reference (MIT)

        星星數最多!! 遠超過下面兩個。

      - [djv](https://github.com/korzio/djv) draft-06, -04 for Node.js and browsers (MIT)
      - [vue-vuelidate-jsonschema](https://github.com/mokkabonna/vue-vuelidate-jsonschema) draft-06 (MIT)

    Python

      - [jsonschema](https://github.com/Julian/jsonschema) draft-07, -06, -04, -03 (MIT)

## 參考資料 {: #reference }

  - [JSON Schema](https://json-schema.org/)
  - [json-schema-org/json-schema-spec - GitHub](https://github.com/json-schema-org/json-schema-spec)

社群：

  - [JSON Schema - Google Groups](https://groups.google.com/forum/#!forum/json-schema)

工具：

  - [`jsonschema`](python-jsonschema.md) - Python 唯一的 validator
  - [JSON Schema Validator - Newtonsoft](https://www.jsonschemavalidator.net/)
  - [JSON Schema Lint](https://jsonschemalint.com/#/version/draft-07/markup/json)

手冊：

  - [JSON Schema: A Media Type for Describing JSON Documents](https://json-schema.org/latest/json-schema-core.html)
  - [JSON Schema Validation: A Vocabulary for Structural Validation of JSON](https://json-schema.org/latest/json-schema-validation.html)
