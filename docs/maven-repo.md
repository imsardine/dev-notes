---
title: Maven / Repository
---
# [Maven](maven.md) / Repository

  - [Maven – Introduction to Repositories](https://maven.apache.org/guides/introduction/introduction-to-repositories.html) #ril

  - [Maven – Guide to installing 3rd party JARs](https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html) #ril
  - [Maven – Guide to deploying 3rd party JARs to remote repository](https://maven.apache.org/guides/mini/guide-3rd-party-jars-remote.html) #ril
  - [Maven – Guide to Coping with Sun JARs](https://maven.apache.org/guides/mini/guide-coping-with-sun-jars.html) #ril
  - [Maven – Remote repository access through authenticated HTTPS](https://maven.apache.org/guides/mini/guide-repository-ssl.html) #ril
  - [Maven – Guide to relocation](https://maven.apache.org/guides/mini/guide-relocation.html) #ril

## Local Repository {: #local }

  - [Where is the Maven Local Repository? \| Baeldung](https://www.baeldung.com/maven-local-repository) (2020-01-16)

      - This quick writeup will focus on where Maven stores all the local dependencies locally – which is in the Maven local repository.

        Simply put, when we run a Maven build, all the dependencies of our project (jars, plugin jars, other artifacts) are all stored locally for later use.

      - Also keep in mind that, beyond just this type of local repository, Maven does support 3 types of repos:

          - Local – Folder location on the local Dev machine
          - Central – Repository provided by Maven community
          - Remote – Organization owned CUSTOM REPOSITORY

        Let's now focus on the local repository.

      - The local repository of Maven is a folder location on the developer's machine, where all the project artifacts are stored locally.

        When maven build is executed, Maven automatically downloads all the dependency jars into the local repository.

        Usually this folder is named `.m2`.

      - Here's where the default path to this folder is – based on OS:

          - Windows: `C:\Users\<User_Name>\.m2`
          - Linux: `/home/<User_Name>/.m2`
          - Mac: `/Users/<user_name>/.m2`

        And of course, for both on Linux or Mac: `~/.m2`

      - If the repo is not present in this default location, it's likely because some pre-existing configuration.

        That config file is located in the Maven installation directory – in a folder called `conf` – and is named `settings.xml`.

        Here's the relevant configuration that determines the location of our missing local repo:

            <settings>
                <localRepository>C:/maven_repository</localRepository>
                ...

        That's essentially how we can change the location of the local repo – and of course, if that location is changed, we'll no longer find the repo at the default location.

        Note: The files stored in the earlier location will not be moved automatically.

## Central Repository {: #central }

  - [Maven – Maven Central Repository](https://maven.apache.org/repository/index.html) #ril

## 參考資料 {: #reference }

  - [The Central Repository](https://search.maven.org/) ([repo](https://repo.maven.apache.org/maven2/))
