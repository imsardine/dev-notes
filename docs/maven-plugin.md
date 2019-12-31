---
title: Maven / Plugin
---
# [Maven](maven.md) / Plugin

  - [Maven – Available Plugins](https://maven.apache.org/plugins/index.html) #ril

      - Maven is - at its heart - a PLUGIN EXECUTION FRAMEWORK; all work is done by plugins. Looking for a specific goal to execute? This page lists the CORE plugins and others. There are the BUILD and the REPORTING plugins:

          - Build plugins will be executed during the BUILD and they should be configured in the `<build/>` element from the POM.

          - Reporting plugins will be executed during the SITE GENERATION and they should be configured in the `<reporting/>` element from the POM.

            Because the result of a Reporting plugin is part of the generated site, Reporting plugins should be both internationalized and localized. You can read more about the localization of our plugins and how you can help.

    Supported By The Maven Project

      - To see the most up-to-date list browse the Maven repository, specifically the `org/apache/maven/plugins` subfolder. (Plugins are organized according to a directory structure that resembles the standard Java package naming convention)

      - Core Plugins

        Plugins corresponding to DEFAULT CORE PHASES (ie. `clean`, `compile`). They may have multiple goals as well.

          - `clean` - Clean up after the build.
          - `compiler` - Compiles Java sources.
          - `deploy` - Deploy the built artifact to the REMOTE REPOSITORY.
          - `failsafe` - Run the JUnit INTEGRATION TESTS in an isolated classloader.
          - `install` - Install the built artifact into the LOCAL REPOSITORY.
          - `resources` - Copy the resources to the output directory for including in the JAR.
          - `site` - Generate a site for the current project.
          - `surefire` - Run the JUnit UNIT TESTS in an isolated classloader. 注意跟 `failsafe` 的不同。
          - `verifier` - Useful for INTEGRATION TESTS - verifies the existence of certain conditions. ??

      - Packaging types/tools

        These plugins relate to packaging RESPECTIVE ARTIFACT TYPES.

          - `ear` - Generate an EAR from the current project.
          - `ejb` - Build an EJB (and optional client) from the current project.
          - `jar` - Build a JAR from the current project.
          - `rar` - Build a RAR from the current project. ??
          - `war` - Build a WAR from the current project.
          - `app-client/acr` - Build a JavaEE application client from the current project.
          - `shade` - Build an UBER-JAR from the current project, including dependencies.
          - `source` - Build a source-JAR from the current project.
          - `jlink` - Build Java Run Time Image. ??
          - `jmod` - Build Java JMod files. ??

      - Reporting plugins

        Plugins which generate reports, are configured as reports in the POM and run under the site generation lifecycle.

          - `changelog` - Generate a list of recent changes from your SCM.
          - `changes` - Generate a report from an issue tracker or a change document. ??
          - `checkstyle` - Generate a Checkstyle report.
          - `doap` - Generate a Description of a Project (DOAP) file from a POM. ??
          - `docck` - Documentation checker plugin. ??
          - `javadoc` - Generate Javadoc for the project.
          - `jdeps` - Run JDK's JDeps tool on the project.
          - `jxr` - Generate a source cross reference.
          - `linkcheck` - Generate a Linkcheck report of your project's documentation.
          - `pmd` - Generate a PMD report.
          - `project-info-report` - Generate standard project reports.
          - `surefire-report` - Generate a report based on the results of unit tests.

      - Tools

        These are miscellaneous tools available through Maven by default.

          - `antrun` - Run a set of ant tasks from a phase of the build.
          - `archetype` - Generate a skeleton project structure from an archetype.
          - `assembly` - Build an assembly (distribution) of sources and/or binaries.
          - `dependency` - Dependency manipulation (copy, unpack) and ANALYSIS.
          - `enforcer` - Environmental constraint checking (Maven Version, JDK etc), User Custom Rule Execution.
          - `gpg` - Create signatures for the artifacts and poms.
          - `help` - Get information about the working environment for the project.
          - `invoker` - Run a set of Maven projects and verify the output.
          - `jarsigner` - Signs or verifies project artifacts.
          - `jdeprscan` - Run JDK's JDeprScan tool on the project.
          - `patch` - Use the gnu patch tool to apply patch files to source code.
          - `pdf` - Generate a PDF version of your project's documentation.
          - `plugin` - Create a Maven plugin descriptor for any MOJOS found in the source tree, to include in the JAR.
          - `release` - Release the current project - updating the POM and tagging in the SCM. 有點像是 bump version? #ril
          - `remote-resources` - Copy remote resources to the output directory for inclusion in the artifact.
          - `scm` - Execute SCM commands for the current project.
          - `scm-publish` - Publish your Maven website to a scm location.
          - `stage` - Assists with release staging and promotion. ??
          - `toolchains` - Allows to share configuration across plugins.

  - [Maven – Plugin Developers Centre](https://maven.apache.org/plugin-developers/index.html) #ril

## 參考資料 {: #reference }

  - [Plugin Developers Centre - Maven](https://maven.apache.org/plugin-developers/index.html) #ril

手冊：

  - [Maven Plugins](https://maven.apache.org/plugins/index.html)
