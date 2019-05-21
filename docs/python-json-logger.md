# python-json-logger

  - [madzak/python\-json\-logger: Json Formatter for the standard python logger](https://github.com/madzak/python-json-logger)
      - This library is provided to allow standard python logging to output log data as json objects. With JSON we can make our logs more READABLE BY MACHINES and we can stop writing CUSTOM PARSERS for syslog type records.

## 新手上路 ?? {: #getting-started }

  - [python\-json\-logger/jsonlogger\.py at v0\.1\.10 · madzak/python\-json\-logger](https://github.com/madzak/python-json-logger/blob/v0.1.10/src/pythonjsonlogger/jsonlogger.py#L178) 文件有點難懂，先爬過 `JsonFormatter.format()` 的原始碼會有幫助：

        def __init__(self, *args, **kwargs):
            ...
            self._required_fields = self.parse()

        def format(self, record):
            message_dict = {}
            if isinstance(record.msg, dict): # (1)
                message_dict = record.msg
                record.message = None
            else:
                record.message = record.getMessage()
            # only format time if needed
            if "asctime" in self._required_fields: # (2)
                record.asctime = self.formatTime(record, self.datefmt)

            # Display formatted exception, but allow overriding it in the
            # user-supplied dict.
            if record.exc_info and not message_dict.get('exc_info'):
                message_dict['exc_info'] = self.formatException(record.exc_info) # (3)
            if not message_dict.get('exc_info') and record.exc_text:
                message_dict['exc_info'] = record.exc_text

            try:
                log_record = OrderedDict()
            except NameError:
                log_record = {}

            self.add_fields(log_record, record, message_dict)
            log_record = self.process_log_record(log_record)

            return "%s%s" % (self.prefix, self.jsonify_log_record(log_record))

        def add_fields(self, log_record, record, message_dict):
            for field in self._required_fields:
                log_record[field] = record.__dict__.get(field)
            log_record.update(message_dict)
            merge_record_extra(record, log_record, reserved=self._skip_fields)

            if self.timestamp:
                key = self.timestamp if type(self.timestamp) == str else 'timestamp'
                log_record[key] = datetime.utcnow()

     1. 這代表 `debug(msg, *args)` 中的 `msg` 就用 `dict`，這用法很怪!? 如果同時間有其他 handler 就炸了。
     2. `_required_fields` 從使用者提供的 format string 拆出來，例如 `'(asctime) (message)'` 會拆出 `['asctime', 'message']`
     3. 只呼叫 `formatException()`，沒有 Python 3 才有的 `formatStack()`，在 Python 3 下使用會有問題? 不過 `stack_info` 好像一直都沒東西??

  - [Usage - madzak/python\-json\-logger: Json Formatter for the standard python logger](https://github.com/madzak/python-json-logger#usage) #ril

    Integrating with Python's logging framework

      - Json outputs are provided by the `JsonFormatter` logging formatter. You can add the custom formatter like below:

        Please note: version 0.1.0 has changed the import structure, please update to the following example for proper importing

            import logging
            from pythonjsonlogger import jsonlogger

            logger = logging.getLogger() # 取得 root logger 自己安排 handler + formatter

            logHandler = logging.StreamHandler()
            formatter = jsonlogger.JsonFormatter()
            logHandler.setFormatter(formatter)
            logger.addHandler(logHandler)

    Customizing fields

      - The FMT PARSER can also be overidden if you want to have required fields that differ from the default of just message. These two invocations are equivalent:

            class CustomJsonFormatter(jsonlogger.JsonFormatter):
                def parse(self):
                    return self._fmt.split(';')

            formatter = CustomJsonFormatter('one;two')

            # is equivalent to:

            formatter = jsonlogger.JsonFormatter('(one) (two)')

        [`JsonFormatter` 也是繼承自 `logging.Formatter`](https://github.com/madzak/python-json-logger/blob/v0.1.10/src/pythonjsonlogger/jsonlogger.py#L77)，把 format string 參數拿來表示 "要輸出哪些欄位" (自訂語法)，所以才會有 "fmt parser" 這概念出現。

        話說回來，如果 `JsonFormatter('(one) (two)')` 就可以指定欄位，為何還有自訂 `JsonFormatter.parse()` 的需求?

      - You can also add extra fields to your json output by specifying a dict IN PLACE OF MESSAGE??, as well as by specifying an `extra={}` argument.

        Contents of these dictionaries will be added at the ROOT LEVEL OF THE ENTRY?? and may override basic fields.

        看不懂，要先爬過 `JsonFormatter` 的原始碼??

## 安裝設定 {: #installation }

  - [Installing - madzak/python\-json\-logger: Json Formatter for the standard python logger](https://github.com/madzak/python-json-logger#installing) #ril
      - `pip install python-json-logger`

## 參考資料 {: #reference }

  - [madzak/python-json-logger](https://github.com/madzak/python-json-logger)

相關：

  - [Python Logging](python-logging.md)
  - [JSON Lines](jsonlines.md)
