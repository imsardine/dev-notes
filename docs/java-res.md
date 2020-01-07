---
title: Java / Resource
---
# [Java](java.md) / Resource

  - [How to load resources and files in Java \- bl\.ocks\.org](https://bl.ocks.org/gkhays/1d90f75d9347cc2d7bc70f7bd56f31e7) (2019-11-10) #ril

  - [Location-Independent Access to Resources](https://docs.oracle.com/javase/8/docs/technotes/guides/lang/resources.html) #ril

    Overview

      - A RESOURCE is data (images, audio, text, and so on) that a program needs to access in a way that is INDEPENDENT OF THE LOCATION OF THE PROGRAM CODE.

        Java programs can use two mechanisms to access resources:

          - Applets use `Applet.getCodeBase()` to get the base URL for the applet code and then extend the base URL with a relative path to load the desired resource, for example with `Applet.getAudioClip(url)`.
          - Applications use "well known locations" such as `System.getProperty("user.home")` or `System.getProperty("java.home")`, then add `"/lib/resource"`, and open that file.

        雖然這些做法適用廣義的 resource，但這裡要講的是 Java 狹意上的 resource -- 透過 `Class`/`ClassLoader` 提供的方法存取。

      - Methods in the classes `Class` and `ClassLoader` provide a LOCATION-INDEPENDENT way to locate resources. For example, they enable locating resources for:

          - An applet loaded from the Internet using multiple HTTP connections.
          - An applet loaded using JAR files.
          - A Java Bean loaded or installed in the `CLASSPATH`.
          - A "library" installed in the `CLASSPATH`.

      - These methods do not provide specific support for locating LOCALIZED resources. Localized resources are supported by the [internationalization facilities](https://docs.oracle.com/javase/8/docs/technotes/guides/intl/index.html). #ril

    Resources, names, and contexts

      - A resource is identified by a string consisting of a sequence of SUBSTRINGS, delimited by slashes (`/`), followed by a RESOURCE NAME. Each substring must be a VALID JAVA IDENTIFIER.

        The resource name is of the form `shortName` or `shortName.extension`. Both `shortName` and `extension` must be Java identifiers.

        這裡 "resource name" 跟下面 "name of a resource" 的說法有點難分辨，感覺 "resource name" 不包含路徑的部份，但 "name of a resource" 又有 ??

      - The name of a resource is independent of the Java implementation; in particular, the path separator is ALWAYS a slash (`/`). However, the Java implementation controls the details of how the contents of the resource are mapped into a file, DATABASE, or other object containing the actual resource.

      - The interpretation of a resource name is relative to a CLASS LOADER INSTANCE. Methods implemented by the `ClassLoader` class do this interpretation.

    System Resources

      - A system resource is a resource that is either built-in to the system, or kept by the HOST IMPLEMENTATION in, for example, a local file system. Programs access system resources through the `ClassLoader` methods `getSystemResource` and `getSystemResourceAsStream`.

        For example, in a particular implementation, locating a system resource may involve searching the entries in the `CLASSPATH`. The `ClassLoader` methods search each directory, ZIP file, or JAR file entry in the `CLASSPATH` for the resource file, and, if found, returns either an `InputStream`, or the resource name. If not found, the methods return `null`.

        這裡說的 "resource name"，根據 [`Class.getResource()` 的 API 文件](https://docs.oracle.com/javase/8/docs/api/java/lang/Class.html#getResource-java.lang.String-)，其實是 `URL`；好奇從 class path 裡拿到的 resource 其 protocol 是什麼?? 尤其 `URL` 只保證支持 `http(s)`、`file` 及 `jar` 這些 protocol。

      - A resource may be found in a different entry in the `CLASSPATH` than the location where the class file was loaded.

    Non-System Resources

      - The implementation of `getResource` on a class loader depends on the details of the `ClassLoader` class. For example, `AppletClassLoader`:

          - First tries to locate the resource as a system resource; then, if not found,
          - Searches through the resources in archives (JAR files) already loaded in this `CODEBASE`; then, if not found,
          - Uses `CODEBASE` and attempts to locate the resource (which may involve contacting a remote site).

      - All class loaders will search for a resource first as a system resource, in a manner analogous to searcing for class files. This search rule permits overwriting locally any resource. Clients should choose a resource name that will be unique (using the company or package name as a prefix, for instance). ??

    Resource Names

      - A common convention for the name of a resource used by a class is to use the fully qualified name of the package of the class, but convert all periods (`.`) to slashes (`/`), and add a resource name of the form `name.extension`. To support this, and to simplify handling the details of system classes (for which `getClassLoader` returns `null`), the class `Class` provides two convenience methods that call the appropriate methods in `ClassLoader`.

      - The resource name given to a `Class` method may have an initial starting "/" that identifies it as an "ABSOLUTE" name. Resource names that do not start with a "/" are "RELATIVE".

        Absolute names are stripped of their starting "/" and are passed, without any further modification, to the appropriate `ClassLoader` method to locate the resource. Relative names are modified according to the convention described previously and then are passed to a `ClassLoader` method. ??
