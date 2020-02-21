# SnakeYAML

  - [asomov / snakeyaml / wiki / Home — Bitbucket](https://bitbucket.org/asomov/snakeyaml/wiki/Home)

      - YAML 1.1 parser and emitter for Java.

    Requirements

      - SnakeYAML requires Java 7 or higher (The latest version built for Java 6 is 1.23).
      - SnakeYAML does not depend on any external library (but the tests do).

  - [Parsing YAML with SnakeYAML \| Baeldung](https://www.baeldung.com/java-snake-yaml) (2019-10-16) #ril

## 新手上路 {: #getting-started }

  - [Quick start - asomov / snakeyaml / wiki / Home — Bitbucket](https://bitbucket.org/asomov/snakeyaml/wiki/Home#markdown-header-quick-start)

    Loading (de-serialize):

        Yaml yaml = new Yaml();
        Object obj = yaml.load("a: 1\nb: 2\nc:\n  - aaa\n  - bbb");
        System.out.println(obj);

        {b=2, c=[aaa, bbb], a=1}

    Dumping (serialise):

        Map<String, String> map = new HashMap<String, String>();
        map.put("name", "Pushkin");
        Yaml yaml = new Yaml();
        String output = yaml.dump(map);
        System.out.println(output);

        ---
        name: Pushkin

  - [Loading YAML - asomov / snakeyaml / wiki / Documentation — Bitbucket](https://bitbucket.org/asomov/snakeyaml/wiki/Documentation#markdown-header-loading-yaml)

      - Start with instantiating the `org.yaml.snakeyaml.Yaml` instance.

            Yaml yaml = new Yaml();

    Loading YAML

      - The method `Yaml.load()` converts a YAML document to a Java object.

            Yaml yaml = new Yaml();
            String document = "\n- Hesperiidae\n- Papilionidae\n- Apatelodidae\n- Epiplemidae";
            List<String> list = (List<String>) yaml.load(document);
            System.out.println(list);

            ['Hesperiidae', 'Papilionidae', 'Apatelodidae', 'Epiplemidae']

        You can find an example [here](http://bitbucket.org/asomov/snakeyaml/src/tip/src/test/java/examples/LoadExampleTest.java)

      - `Yaml.load()` accepts a `String` or an `InputStream` object. `Yaml.load(InputStream stream)` detects the encoding by checking the BOM (byte order mark) sequence at the beginning of the stream. If no BOM is present, the `utf-8` encoding is assumed.

        `Yaml.load()` returns a Java object.

            public void testLoadFromString() {
                Yaml yaml = new Yaml();
                String document = "hello: 25";
                Map map = (Map) yaml.load(document);
                assertEquals("{hello=25}", map.toString());
                assertEquals(new Long(25), map.get("hello"));
            }

            public void testLoadFromStream() throws FileNotFoundException {
                InputStream input = new FileInputStream(new File("src/test/resources/reader/utf-8.txt"));
                Yaml yaml = new Yaml();
                Object data = yaml.load(input);
                assertEquals("test", data);
                //
                data = yaml.load(new ByteArrayInputStream("test2".getBytes()));
                assertEquals("test2", data);
            }

    Implicit types

      - When a TAG?? for a scalar node is not explicitly defined, SnakeYAML tries to detect the type applying regular expressions to the content of the scalar node.

            1.0 -> Float
            42 -> Integer
            2009-03-30 -> Date

        An example how to change the default implicit types can be found [here](http://bitbucket.org/asomov/snakeyaml/src/tip/src/test/java/examples/resolver/CustomResolverTest.java)

## JavaBeans

  - 官方的例子刻意避開了 `api_key` 這類 snake case 的用法 (YAML 慣用)，對應到 JavaBeans 的 property 會變成 `getApi_key()` 及 setApi_key()`，

    > By default standard JavaBean properties and public fields are included. `BeanAccess.FIELD` makes is possible to use private fields directly.
    >
    > -- [JavaBeans - SnakeYAML Documentation](https://bitbucket.org/asomov/snakeyaml/wiki/Documentation#markdown-header-javabeans)

    看起來是有解的，但測試上要生出假的 config 會比較困難 (猜想是透過 Reflection)，建議用 SnakeYAML 載入 `java.util.Map` 再搭配 `Config` (interface) + `ConfigImpl` 的做法.

  - SnakeYAML + `Config` + `ConfigImpl`: ([imsardine/learning](https://github.com/imsardine/learning/blob/ede4adee254f3f2f3a577f7bc014821ae6d30787/snakeyaml/tests/test_config_framework.py#L1))

    `Main.java`:

        import java.io.FileInputStream;
        import java.util.Map;
        import org.yaml.snakeyaml.Yaml;
        import mypkg.Config;
        import mypkg.ConfigImpl;

        public class Main {
          public static void main(String[] args) throws Exception {
            Map settings = (Map) new Yaml().load(new FileInputStream("hello.yml"));
            Config config = new ConfigImpl(settings);
            System.out.print(config.getGreeting() + ", Y" + config.getYear() + "!");
          }
        }

    `mypkg/Config.java`:

        package mypkg;

        public interface Config {
          String getGreeting();
          int getYear();
        }

    `mypkg/ConfigImpl.java`:

        package mypkg;

        import java.util.Map;

        public class ConfigImpl implements Config {

          private Map settings;

          public ConfigImpl(Map settings) {
            this.settings = settings;
          }

          public String getGreeting() {
            return (String) settings.get("greeting");
          }

          public int getYear() {
            return (Integer) settings.get("year");
          }

        }

---

參考資料：

  - [JavaBeans - asomov / snakeyaml / wiki / Documentation — Bitbucket](https://bitbucket.org/asomov/snakeyaml/wiki/Documentation#markdown-header-javabeans)

      - The spec says - "One of the main goals of the JavaBeans architecture is to provide a platform neutral component architecture."

      - Avoiding global tags significantly improves ability to exchange the YAML documents between different platforms and languages.

        If the custom Java class conforms to the JavaBean specification it can be loaded and dumped without any extra code. For instance this JavaBean

            public class CarWithWheel {
                private String plate;
                private String year;
                private Wheel wheel;
                private Object part;
                private Map<String, Integer> map;

                public String getPlate() {
                    return plate;
                }

                public void setPlate(String plate) {
                    this.plate = plate;
                }

                public Wheel getWheel() {
                    return wheel;
                }

                public void setWheel(Wheel wheel) {
                    this.wheel = wheel;
                }

                public Map<String, Integer> getMap() {
                    return map;
                }

                public void setMap(Map<String, Integer> map) {
                    this.map = map;
                }

                public Object getPart() {
                    return part;
                }

                public void setPart(Object part) {
                    this.part = part;
                }

                public String getYear() {
                    return year;
                }

                public void setYear(String year) {
                    this.year = year;
                }
            }

            CarWithWheel car1 = new CarWithWheel();
            car1.setPlate("12-XP-F4");
            Wheel wheel = new Wheel();
            wheel.setId(2);
            car1.setWheel(wheel);
            Map<String, Integer> map = new HashMap<String, Integer>();
            map.put("id", 3);
            car1.setMap(map);
            car1.setPart(new Wheel(4));
            car1.setYear("2008");
            String output = new Yaml().dump(car1);

        will be dumped as

            !!package.CarWithWheel
            map: {id: 3}
            part: !!org.yaml.snakeyaml.constructor.Wheel {id: 4}
            plate: 12-XP-F4
            wheel: {id: 2}
            year: '2008'

        Note that the `part` property still has a GLOBAL TAG but the `wheel` property does not (because the wheel's runtime class is the same as it is defined in the `CarWithWheel` class).

        差別就在 `Wheel getWheel()` 與 `Object getPart()`。雖然說 "... exchange the YAML documents between different platforms and languages"，但埋那麼多 tag 會讓 YAML 像綁定了某個程式語言 ??

      - The example for the above JavaBean can be found [here](http://bitbucket.org/asomov/snakeyaml/src/tip/src/test/java/org/yaml/snakeyaml/constructor/ImplicitTagsTest.java)

        The preferred way to dump a JavaBean is to use `Yaml.dumpAs(obj, Tag.MAP). This utility is emitting with the block layout and DOES NOT emit the root global tag with the class name (using implicit `!!map` tag).

      - The preferred way to parse a JavaBean is to use `Yaml.loadAs()`. It eliminates the need to cast returned instances to the specified class.

        跟 `load()` 一樣只差沒有 generic，但 `<T> T load(...)` 中的 `T` 又是什麼?? 感覺 `Yaml.load()` 會需要 global tag，但 `Yaml.loadAs()` 不需要 ??

        By default standard JavaBean properties and public fields are included. `BeanAccess.FIELD` makes is possible to use private fields directly.

## Snake Case

  - [asomov / snakeyaml / Pull request \#21: convert snake to camel — Bitbucket](https://bitbucket.org/asomov/snakeyaml/pull-requests/21) #ril
  - [Config using camelCase instead of underscore · Issue \#256 · uber\-go/fx](https://github.com/uber-go/fx/issues/256) 要用 snake case 或 camel case 有些爭論 #ril
  - [Handling "underscore" in set method names \- Google Groups](https://groups.google.com/forum/#!topic/snakeyaml-core/8HjAuRh_yKA) #ril

## 疑難排解 {: #troubleshooting }

### No single argument constructor found for class XXX

```
org.yaml.snakeyaml.error.YAMLException: No single argument constructor found for class com.youdomain.MyClass : null
```

這個錯誤源自 [`org.yaml.snakeyaml.constructor.Constructor`](https://bitbucket.org/asomov/snakeyaml/src/e48f21e8cea63a69f94b35f87df063593efdf542/src/main/java/org/yaml/snakeyaml/constructor/Constructor.java?at=default#Constructor.java-370,374,380,382:383,385,387:388,541:543,548,554:556,558:559,563:566,568,572,575,583:584,589,594,597)。

為什麼只有在某些環境下才會出現??

## 參考資料 {: #reference }

  - [SnakeYAML - Bitbucket](https://bitbucket.org/asomov/snakeyaml)

社群：

  - ['snakeyaml' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/snakeyaml)
  - [SnakeYAML - Google Groups](https://groups.google.com/forum/#!forum/snakeyaml-core)

相關：

  - [YAML](yaml.md)

手冊：

  - [Javadoc API Reference](https://www.javadoc.io/doc/org.yaml/snakeyaml/)
  - [Changelog](https://bitbucket.org/asomov/snakeyaml/wiki/Changes)
