# IK Analysis for Elasticsearch

  - [medcl/elasticsearch\-analysis\-ik: The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary\.](https://github.com/medcl/elasticsearch-analysis-ik) #ril
      - The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary.
      - Analyzer: `ik_smart`, `ik_max_word`, Tokenizer: `ik_smart`, `ik_max_word` 所以 analyzer 完全沒用到 filter??
      - `ik_max_word` 和 `ik_smart` 什么区别? `ik_max_word`: 会将文本做最细粒度的拆分，比如会将“中华人民共和国国歌 ”拆分为“ 中华人民共和国,中华人民,中华,华人,人民共和国,人民,人,民,共和国,共和,和,国国,国歌”，会穷尽各种可能的组合；`ik_smart`: 会做最粗粒度的拆分，比如会将“中华人民共和国国歌”拆分为“中华人民共和国,国歌”。 => 但為麼以 `ik_smart` 拆解的結果，用 `國` 找得到??
  - [ik-analyzer - Google Code Archive \- Long\-term storage for Google Code Project Hosting\.](https://code.google.com/archive/p/ik-analyzer/) #ril
  - [Lucene中文分词IK Analyzer \- 任何技能都是从模仿开始，逐步升华。 \- CSDN博客](https://blog.csdn.net/zhu_tianwei/article/details/46607421) (2015-06-23) #ril

## Custom Dictionary ??

  - [Dictionary Configuration - medcl/elasticsearch\-analysis\-ik: The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary\.](https://github.com/medcl/elasticsearch-analysis-ik#dictionary-configuration) #ril
      - `IKAnalyzer.cfg.xml` can be located at `{conf}/analysis-ik/config/IKAnalyzer.cfg.xml` or `{plugins}/elasticsearch-analysis-ik-*/config/IKAnalyzer.cfg.xml`

            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">
            <properties>
                <comment>IK Analyzer 扩展配置</comment>
                <!--用户可以在这里配置自己的扩展字典 -->
                <entry key="ext_dict">custom/mydict.dic;custom/single_word_low_freq.dic</entry>
                 <!--用户可以在这里配置自己的扩展停止词字典-->
                <entry key="ext_stopwords">custom/ext_stopword.dic</entry>
                <!--用户可以在这里配置远程扩展字典 -->
                <entry key="remote_ext_dict">location</entry>
                <!--用户可以在这里配置远程扩展停止词字典-->
                <entry key="remote_ext_stopwords">http://xxx.com/xxx.dic</entry>
            </properties>

## 繁體中文 ?? {: #traditional-chinese }

  - [sunghau/elasticsearch\-analysis\-ik\-config\-traditional\-chinese: ik config files for traditional chinese](https://github.com/sunghau/elasticsearch-analysis-ik-config-traditional-chinese) #ril
      - 主要的差別似乎在於 [elasticsearch\-analysis\-ik\-config\-traditional\-chinese/IKAnalyzer\.cfg\.xml at master · sunghau/elasticsearch\-analysis\-ik\-config\-traditional\-chinese](https://github.com/sunghau/elasticsearch-analysis-ik-config-traditional-chinese/blob/master/config/ik/IKAnalyzer.cfg.xml)，把 `custom/**/*.dic` 引進來：


            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd">  
            <properties>  
                <comment>IK Analyzer 扩展配置</comment>
                <!--用户可以在这里配置自己的扩展字典 -->	
                <entry key="ext_dict">custom/mydict.dic;custom/single_word_low_freq.dic;custom/zhTW/main.dic;custom/zhTW/preposition.dic;custom/zhTW/quantifier.dic;custom/zhTW/suffix.dic;custom/zhTW/surname.dic</entry> 	
                 <!--用户可以在这里配置自己的扩展停止词字典-->
                <entry key="ext_stopwords">custom/ext_stopword.dic;custom/zhTW/stopword.dic</entry>
                <!--用户可以在这里配置远程扩展字典 -->	
                <!-- <entry key="remote_ext_dict">words_location</entry> -->
                <!--用户可以在这里配置远程扩展停止词字典-->
                <!-- <entry key="remote_ext_stopwords">words_location</entry> -->
            </properties>

## 安裝設定 ?? {: #installation }

  - [medcl/elasticsearch\-analysis\-ik: The IK Analysis plugin integrates Lucene IK analyzer into elasticsearch, support customized dictionary\.](https://github.com/medcl/elasticsearch-analysis-ik)
      - 安裝方法都是將 plugin ZIP (只有 4.3 MB) 解開放進 `$ES_ROOT/plugins/xxx`，下面兩種做法只是手動/自動的差別而已，最後都要 restart ES。
      - optional 1 - 1) download pre-build package from here: https://github.com/medcl/elasticsearch-analysis-ik/releases 2) create plugin folder `cd your-es-root/plugins/ && mkdir ik` 3) unzip plugin to folder `your-es-root/plugins/ik` 直接把 zip 解開到放到 `$ES_ROOT/plugins/xxx` 即可。
      - optional 2 - use `elasticsearch-plugin` to install (supported from version v5.5.1):

            $ ES_VERSION=6.3.0
            $ ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v$ES_VERSION/elasticsearch-analysis-ik-$ES_VERSION.zip

      - 為什麼不同 ES 的版本，就要採用不同的 IK，近期更是呈現 1-to-1 的關係，為什麼兩者綁得這麼緊??

## 參考資料

  - [medcl/elasticsearch-analysis-ik - GitHub](https://github.com/medcl/elasticsearch-analysis-ik)
  - [IK Analyzer (Lucene)](https://code.google.com/archive/p/ik-analyzer/)
