# Javassist

## 疑難排解 {: #troubleshooting }

## java.io.IOException: invalid constant type: 18

  - [Reflections \- Java 8 \- invalid constant type \- Stack Overflow](https://stackoverflow.com/questions/30313255)

      - Holger: If you look at [this table](https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4), you’ll see that “constant type: 18” refers to the `CONSTANT_InvokeDynamic` attribute whose tag value is 18.

        So you are using a library which has a class parser which is not Java 8 compatible. Actually, this class parser even isn’t Java 7 compatible as this constant value is specified since Java 7. It just got away with that as ordinary Java code doesn’t use this feature in Java 7. But when interacting with code produced by different programming languages for the JVM, it could even fail with Java 7.

        There’s [an item in the bug tracker of Reflections](https://code.google.com/p/reflections/issues/detail?id=178) describing your problem. At the bottom, you will find the notice:

        > With this fix: https://issues.jboss.org/browse/JASSIST-174 javassist got support for this constant. So with 3.18.2-GA this error doesn't occur.

      - mehmetunluu: I solved this problem that;

        First upgrade javassist jar to -> 3.18.2-GA

            <dependency>
              <groupId>org.javassist</groupId>
              <artifactId>javassist</artifactId>
              <version>3.18.2-GA</version>
            </dependency>

        Secondly add `weblogic.xml`

            <wls:package-name>javassist.*</wls:package-name>

## 參考資料 {: #reference }

  - [Javassist](https://www.javassist.org/)
  - [jboss-javassist/javassist - GitHub](https://github.com/jboss-javassist/javassist)
  - [Releases](https://github.com/jboss-javassist/javassist/releases)
