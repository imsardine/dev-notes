---
title: Swagger / Codegen
---
# [Swagger](swagger.md) / Codegen

  - [Getting Started With Swagger \| Swagger](https://swagger.io/tools/open-source/getting-started/)

      - Use the Swagger Editor to create your OAS definition and then use Swagger Codegen to generate SERVER IMPLEMENTATION.

      - If on the other hand you're an API CONSUMER who wants to integrate with an API that has an OpenAPI definition you can use Swagger Inspector or the online version of Swagger UI to explore the API (given that you have a URL to the APIs Swagger definition) - and then use Swagger Codegen to generate the CLIENT LIBRARY of your choice.

        Codegen 可以應用在 server implementation/stub 與 client library。

  - [Swagger Codegen \| API Development Tools \| Swagger](https://swagger.io/tools/swagger-codegen/)

      - Swagger Codegen can simplify your build process by generating SERVER STUBS and CLIENT SDKs for any API, defined with the OpenAPI (formerly known as Swagger) specification, so your team can focus better on your API’s implementation and adoption.

## CLI

```
$ swagger-codegen config-help -l python

CONFIG OPTIONS
	packageName
	    python package name (convention: snake_case). (Default: swagger_client)
...

$ swagger-codegen generate -i http://petstore.swagger.io/v2/swagger.json -l python -o /local/out -DpackageName=petstore
[main] INFO io.swagger.parser.Swagger20Parser - reading from http://petstore.swagger.io/v2/swagger.json
[main] WARN io.swagger.codegen.ignore.CodegenIgnoreProcessor - Output directory does not exist, or is inaccessible. No file (.swagger-codegen-ignore) will be evaluated.
[main] INFO io.swagger.codegen.AbstractGenerator - writing file /local/out/petstore/models/api_response.py
...
```

參考資料：

  - [Getting Started - swagger\-api/swagger\-codegen: swagger\-codegen contains a template\-driven engine to generate documentation, API clients and server stubs in different languages by parsing your OpenAPI / Swagger definition\.](https://github.com/swagger-api/swagger-codegen#getting-started)

      - To generate a PHP client for http://petstore.swagger.io/v2/swagger.json, please run the following

            git clone https://github.com/swagger-api/swagger-codegen
            cd swagger-codegen
            mvn clean package
            java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
               -i http://petstore.swagger.io/v2/swagger.json \
               -l php \
               -o /var/tmp/php_api_client

      - To get a list of general options available, please run `java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar help generate`
      - To get a list of PHP specified options (which can be passed to the generator with a config file via the `-c` option), please run `java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar config-help -l php`

  - [Customizing the generator - swagger\-api/swagger\-codegen: swagger\-codegen contains a template\-driven engine to generate documentation, API clients and server stubs in different languages by parsing your OpenAPI / Swagger definition\.](https://github.com/swagger-api/swagger-codegen#customizing-the-generator)

      - There are different aspects of customizing the code generator beyond just creating or modifying templates. EACH LANGUAGE has a supporting CONFIGURATION FILE to handle different TYPE MAPPINGS, etc:

            $ ls -1 modules/swagger-codegen/src/main/java/io/swagger/codegen/languages/
            AbstractJavaJAXRSServerCodegen.java
            AbstractTypeScriptClientCodegen.java
            ... (results omitted)
            TypeScriptAngularClientCodegen.java
            TypeScriptNodeClientCodegen.java

        以 Python 而言就是 [`PythonClientCodegen.java`](https://github.com/swagger-api/swagger-codegen/blob/master/modules/swagger-codegen/src/main/java/io/swagger/codegen/languages/PythonClientCodegen.java)

      - Each of these files creates REASONABLE DEFAULTS so you can get running quickly. But if you want to configure package names, prefixes, model folders, etc. you can use a JSON CONFIG FILE to pass the values.

            java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate \
              -i http://petstore.swagger.io/v2/swagger.json \
              -l java \
              -o samples/client/petstore/java \
              -c path/to/config.json

        Supported config options can be DIFFERENT PER LANGUAGE. Running `config-help -l {lang}` will show available options.

            java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar config-help -l java

      - These options are applied via configuration file (e.g. `config.json`) or by passing them with `java -jar swagger-codegen-cli.jar -D{optionName}={optionValue}`. (If `-D{optionName}` does not work, please open a ticket and we'll look into it)

## Online Generator ??

  - [Online generators - swagger\-api/swagger\-codegen: swagger\-codegen contains a template\-driven engine to generate documentation, API clients and server stubs in different languages by parsing your OpenAPI / Swagger definition\.](https://github.com/swagger-api/swagger-codegen#online-generators) #ril
  - [Swagger Generator - Swagger UI](https://generator.swagger.io/) #ril

## 疑難排解 {: #troubleshooting }

### [Python] Should not import self ??

  - 手動將有問題的 import 移除，目前只能這樣。
  - 產出的 code 品質似乎有待加強，例如 `setup.py` 與 `requirements.txt` 對 3rd-party 套件的要求就不一樣。

參考資料：

  - [\[bug\]\[python\]\[model\] Should not import self · Issue \#7541 · swagger\-api/swagger\-codegen](https://github.com/swagger-api/swagger-codegen/issues/7541) (2018-01-31) #ril

    光一個簡單的 JSON 就可以產出這種無法執行的 code，在 Swagger Codegen 2.3.1 上：

        from xms_client.models.placement_node import PlacementNode  # noqa: F401,E501

        class PlacementNode(object):

      - gorlins: ran into this too... did not occur in v2.2.3
      - jimmyjames: Seeing this as well on 2.3.0. Maybe related to #6839? (looking at the generated # noqa: F401,E501 comments introduced there).
      - jacobweber: Same issue....had to manually remove one of the circular references before building.

      - tomplus: (contributor) In my opinion WE SHOULD REMOVE THESE IMPORTS FROM MODELS. It makes a lot of problems with CIRCULAR DEPENDENCIES between 2 or more models (model A has an attribute with model B and model B has a optional attribute with model A). These imported objects are not used at all and we know about it - we added F401 to disable warning from pylint :/

        奇怪，加了 F401 後 Pylint 不會叫，但 runtime 根本跑不起來，這是哪招?

  - [\[python\]\[client\] Comment out useless imports by wy\-z · Pull Request \#7542 · swagger\-api/swagger\-codegen](https://github.com/swagger-api/swagger-codegen/pull/7542) 但最後沒被 merge #ril

## 安裝設定 {: #reference }

  - [Download Swagger Codegen \| Swagger](https://swagger.io/tools/swagger-codegen/download/)

      - Swagger Codegen is an open source project which allows  generation of API client libraries (SDK generation), server stubs, and documentation automatically from an OpenAPI Specification. Swagger Codegen is available for download in the GitHub repository.

  - [Prerequisites - swagger\-api/swagger\-codegen: swagger\-codegen contains a template\-driven engine to generate documentation, API clients and server stubs in different languages by parsing your OpenAPI / Swagger definition\.](https://github.com/swagger-api/swagger-codegen#prerequisites)

      - If you're looking for the latest stable version, you can grab it directly from Maven.org (Java 7 runtime at a minimum):

            $ wget http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.4/swagger-codegen-cli-2.4.4.jar -O swagger-codegen-cli.jar
            $ java -jar swagger-codegen-cli.jar help

### Docker

```
$ alias swagger-codegen="docker run --rm -v \${PWD}:/local swaggerapi/swagger-codegen-cli"
$ alias swagger-codegen-v3="docker run --rm -v \${PWD}:/local swaggerapi/swagger-codegen-cli-v3"
$ swagger-codegen help

$ swagger-codegen generate -i http://petstore.swagger.io/v2/swagger.json -l python -o /local/out
```

參考資料：

  - [Swagger Codegen CLI Docker Image - swagger\-api/swagger\-codegen: swagger\-codegen contains a template\-driven engine to generate documentation, API clients and server stubs in different languages by parsing your OpenAPI / Swagger definition\.](https://github.com/swagger-api/swagger-codegen#swagger-codegen-cli-docker-image)

      - The Swagger Codegen image acts as a standalone executable. It can be used as an ALTERNATIVE TO INSTALLING VIA HOMEBREW, or for developers who are unable to install Java or upgrade the installed version.

        To generate code with this image, you'll need to mount a local location as a volume. Example:

            docker run --rm -v ${PWD}:/local swaggerapi/swagger-codegen-cli-v3 generate \
                -i http://petstore.swagger.io/v2/swagger.json \
                -l go \
                -o /local/out/go

        The generated code will be located under `./out/go` in the current directory.

  - [swagger\-codegen/Dockerfile at master · swagger\-api/swagger\-codegen](https://github.com/swagger-api/swagger-codegen/blob/master/Dockerfile)

        FROM jimschubert/8-jdk-alpine-mvn:1.0

        ...

        ENV GEN_DIR /opt/swagger-codegen
        WORKDIR ${GEN_DIR}

        ...

        COPY docker-entrypoint.sh /usr/local/bin/

        ENTRYPOINT ["docker-entrypoint.sh"]

        CMD ["help"]

## 參考資料 {: #reference }

  - [Swagger Codegen | Swagger](https://swagger.io/tools/swagger-codegen/)
  - [swagger-api/swagger-codegen - GitHub](https://github.com/swagger-api/swagger-codegen)
  - [swaggerapi/swagger-codegen-cli - Docker Hub](https://hub.docker.com/r/swaggerapi/swagger-codegen-cli/)
  - [swaggerapi/swagger-codegen-cli-v3 - Docker Hub](https://hub.docker.com/r/swaggerapi/swagger-codegen-cli-v3/)
  - [swaggerapi/swagger-generator - Docker Hub](https://hub.docker.com/r/swaggerapi/swagger-generator/)

CLI Usage:

```
$ swagger-codegen
usage: swagger-codegen-cli <command> [<args>]

The most commonly used swagger-codegen-cli commands are:
    config-help   Config help for chosen lang
    generate      Generate code with chosen lang
    help          Display help information
    langs         Shows available langs
    meta          MetaGenerator. Generator for creating a new template set and configuration for Codegen.  The output will be based on the language you specify, and includes default templates to include.
    validate      Validate specification
    version       Show version information

See 'swagger-codegen-cli help <command>' for more information on a specific
command.

$ swagger-codegen langs
Available languages: [ada, ada-server, akka-scala, android, apache2, apex ...]
```

```
$ swagger-codegen help generate
NAME
        swagger-codegen-cli generate - Generate code with chosen lang

SYNOPSIS
        swagger-codegen-cli generate
                [(-a <authorization> | --auth <authorization>)]
                [--additional-properties <additional properties>...]
                [--api-package <api package>] [--artifact-id <artifact id>]
                [--artifact-version <artifact version>]
                [(-c <configuration file> | --config <configuration file>)]
                [-D <system properties>...] [--git-repo-id <git repo id>]
                [--git-user-id <git user id>] [--group-id <group id>]
                [--http-user-agent <http user agent>]
                (-i <spec file> | --input-spec <spec file>)
                [--ignore-file-override <ignore file override location>]
                [--import-mappings <import mappings>...]
                [--instantiation-types <instantiation types>...]
                [--invoker-package <invoker package>]
                (-l <language> | --lang <language>)
                [--language-specific-primitives <language specific primitives>...]
                [--library <library>] [--model-name-prefix <model name prefix>]
                [--model-name-suffix <model name suffix>]
                [--model-package <model package>]
                [(-o <output directory> | --output <output directory>)]
                [--release-note <release note>] [--remove-operation-id-prefix]
                [--reserved-words-mappings <reserved word mappings>...]
                [(-s | --skip-overwrite)]
                [(-t <template directory> | --template-dir <template directory>)]
                [--type-mappings <type mappings>...] [(-v | --verbose)]

OPTIONS
        -a <authorization>, --auth <authorization>
            adds authorization headers when fetching the swagger definitions
            remotely. Pass in a URL-encoded string of name:header with a comma
            separating multiple values

        --additional-properties <additional properties>
            sets additional properties that can be referenced by the mustache
            templates in the format of name=value,name=value. You can also have
            multiple occurrences of this option.

        --api-package <api package>
            package for generated api classes

        --artifact-id <artifact id>
            artifactId in generated pom.xml

        --artifact-version <artifact version>
            artifact version in generated pom.xml

        -c <configuration file>, --config <configuration file>
            Path to json configuration file. File content should be in a json
            format {"optionKey":"optionValue", "optionKey1":"optionValue1"...}
            Supported options can be different for each language. Run
            config-help -l {lang} command for language specific config options.

        -D <system properties>
            sets specified system properties in the format of
            name=value,name=value (or multiple options, each with name=value)

        --git-repo-id <git repo id>
            Git repo ID, e.g. swagger-codegen.

        --git-user-id <git user id>
            Git user ID, e.g. swagger-api.

        --group-id <group id>
            groupId in generated pom.xml

        --http-user-agent <http user agent>
            HTTP user agent, e.g. codegen_csharp_api_client, default to
            'Swagger-Codegen/{packageVersion}}/{language}'

        -i <spec file>, --input-spec <spec file>
            location of the swagger spec, as URL or file (required)

        --ignore-file-override <ignore file override location>
            Specifies an override location for the .swagger-codegen-ignore file.
            Most useful on initial generation.

        --import-mappings <import mappings>
            specifies mappings between a given class and the import that should
            be used for that class in the format of type=import,type=import. You
            can also have multiple occurrences of this option.

        --instantiation-types <instantiation types>
            sets instantiation type mappings in the format of
            type=instantiatedType,type=instantiatedType.For example (in Java):
            array=ArrayList,map=HashMap. In other words array types will get
            instantiated as ArrayList in generated code. You can also have
            multiple occurrences of this option.

        --invoker-package <invoker package>
            root package for generated code

        -l <language>, --lang <language>
            client language to generate (maybe class name in classpath,
            required)

        --language-specific-primitives <language specific primitives>
            specifies additional language specific primitive types in the format
            of type1,type2,type3,type3. For example:
            String,boolean,Boolean,Double. You can also have multiple
            occurrences of this option.

        --library <library>
            library template (sub-template)

        --model-name-prefix <model name prefix>
            Prefix that will be prepended to all model names. Default is the
            empty string.

        --model-name-suffix <model name suffix>
            Suffix that will be appended to all model names. Default is the
            empty string.

        --model-package <model package>
            package for generated models

        -o <output directory>, --output <output directory>
            where to write the generated files (current dir by default)

        --release-note <release note>
            Release note, default to 'Minor update'.

        --remove-operation-id-prefix
            Remove prefix of operationId, e.g. config_getId => getId

        --reserved-words-mappings <reserved word mappings>
            specifies how a reserved name should be escaped to. Otherwise, the
            default _<name> is used. For example id=identifier. You can also
            have multiple occurrences of this option.

        -s, --skip-overwrite
            specifies if the existing files should be overwritten during the
            generation.

        -t <template directory>, --template-dir <template directory>
            folder containing the template files

        --type-mappings <type mappings>
            sets mappings between swagger spec types and generated code types in
            the format of swaggerType=generatedType,swaggerType=generatedType.
            For example: array=List,map=Map,string=String. You can also have
            multiple occurrences of this option.

        -v, --verbose
            verbose mode
```
