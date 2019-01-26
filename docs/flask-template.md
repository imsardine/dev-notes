---
title: Flask / Template
---
# [Flask](flask.md) / Template

  - [Templates — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/tutorial/templates/) #ril

## Macro ??

## Variables??

  - [Variables - Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/#variables) #ril

## Undefined Variables

  - 這跟 Fail Fast 有關，Flask 默默地將錯誤吃掉就很有問題。

參考資料：

  - [Template Designer Documentation — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/templates/#variables) If a variable or attribute does not exist, you will get back an undefined value. What you can do with that kind of value depends on the application configuration: the default behavior is ... 但沒有講 configuration 怎麼調整。
  - [django \- In Jinja2, how do you test if a variable is undefined? \- Stack Overflow](https://stackoverflow.com/questions/3842690/) freyley 自問自答: 因為原來在 enviroment setup 用了 `undefined = StrictUndefined`，改用 `JINJA2_ENVIRONMENT_OPTIONS = { 'undefined' : Undefined }` 即可；這是 Django + Jinja2 的用法，不過 `StrictUndefined` 的方向是對的。
  - [flask/app\.py at master · pallets/flask](https://github.com/pallets/flask/blob/master/flask/app.py#L274) `Flask.jinga_options` 似乎是可以下手的地方? 但它的型態是 `ImmutableDict`。
  - [Add a way to make AttributeErrors visible · Issue \#313 · pallets/jinja](https://github.com/pallets/jinja/issues/313) 提到 `app.jinja_env.undefined = jinja2.StrictUndefined` 的用法 #ril
  - [flask/app\.py at master · pallets/flask](https://github.com/pallets/flask/blob/master/flask/app.py#L636) `def jinja_env(self)` 內部呼叫 `create_jinja_environment()` 產生 `jinja2.Environment`，但因為帶有 `@locked_cached_property` 的關係，只會產生一次，所以 `app.jinja_env` 是可以拿到 `Environment` 的 property。
  - [class jinja2.Environment - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#jinja2.Environment) 提到 `extensions`、`undefined` 等用法；其中 `undefined` 是指 undefined values in the template 要用什麼值來表示，預設的 `Undefined` 會以空字串表現。不過並沒有提到 `Environment` 建立之後，可以直接用 attribute 指定 option?? `undefined([hint, obj, name, exc])` 是個 function...
  - [Undefined Types - API — Jinja2 Documentation (2\.11)](http://jinja.pocoo.org/docs/dev/api/#undefined-types) 當 template engine 找不到 `name` 或 `name.attriute` 時，就會傳回一個 undefined value，最接近 Python 行為的是 `StrictUndefined`，除了可以測試是否 undefined 外，其他操作都會噴錯。
  - [class jinja2.StrictUndefined - API — Jinja2 Documentation (2\.10)](http://jinja.pocoo.org/docs/2.10/api/#jinja2.StrictUndefined) An undefined that barks on print and iteration as well as boolean tests and all kinds of comparisons. In other words: you can do nothing with it except checking if it’s defined using the defined test. 聽起來滿棒的，至少還可以檢查。
  - [Registering Filters - Templates — Flask Documentation (0\.12)](http://flask.pocoo.org/docs/0.12/templating/#registering-filters) 提到 `app.jinja_env.filters['reverse']` 的用法。
  - [Set app\.jinja\_env\.undefined to something better when debug = True · Issue \#1006 · pallets/flask](https://github.com/pallets/flask/issues/1006) 針對 "missing attributes of template variables are swallowed by Flask" 的問題 (即便是在 debug mode) 的問題，提出在 debug mode 將 `app.jinja_env.undefined` 改成會在 log 寫出 warning 的型態。
  - [Add a way to make AttributeErrors visible · Issue \#313 · pallets/jinja](https://github.com/pallets/jinja/issues/313) untitaker 提出 `app.jinja_env.undefined = jinja2.StrictUndefined` 的做法，但似乎沒被接受? #ril
  - [python \- Raise error for undefined attributes in Jinja templates in Flask \- Stack Overflow](https://stackoverflow.com/questions/39127940/) estevo 自問自答，也是採用 `app.jinja_env.undefined = jinja2.StrictUndefined` 的做法
  - [python \- SQLAlchemy model data isn't rendered in Jinja loop \- Stack Overflow](https://stackoverflow.com/questions/35559127/) davidism: `app.jinja_env.undefined = StrictUndefined`
  - [Gunicorn Flask App Factory \- pythonexample\.com](http://pythonexample.com/code/gunicorn-flask-app-factory/) 幾個 `app.jinja_env.undefined = StrictUndefined` 的範例。

