# WTForms

## 新手上路 ?? {: #getting-started }

  - [Crash Course - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html) #ril
      - With WTForms, your form field HTML can be generated for you, but we let you customize it in your TEMPLATES. This allows you to maintain SEPARATION OF CODE AND PRESENTATION, and keep those messy parameters out of your python code. 透過 `Field()` 傳入的 keyword params??
      - Form 是 core container，表示一群 field，可以透過 dictionary-style 或 attribute style 存取個別的 field。
      - Field 則擔負了所有吃力的工作 (heavy lifting)，從 "Each field represents a data type and the field handles COERCING FORM INPUT TO THAT DATATYPE." 看來，內部會做資料的強制轉型 (coerce)；也就是 field = input + data (type)，在 input -> data 之間，有 validation (可以有多個 validator)、data conversion??
      - 每個 field 背後預設都會有個 widget，負責畫出代表這個 field 的 HTML representation。
      - 首先，像 ORM 一樣用 class variables 宣告 fields：

            from wtforms import Form, BooleanField, StringField, validators

            class RegistrationForm(Form):
                username     = StringField('Username', [validators.Length(min=4, max=25)])
                email        = StringField('Email Address', [validators.Length(min=6, max=35)])
                accept_rules = BooleanField('I accept the site rules', [validators.InputRequired()])

      - 就像一般的 Python class，也可以繼承 -- 共用一些 field。

            class ProfileForm(Form):
                birthday  = DateTimeField('Your Birthday', format='%m/%d/%y')
                signature = TextAreaField('Forum Signature')

            class AdminProfileForm(ProfileForm):
                username = StringField('Username', [validators.Length(max=40)])
                level    = IntegerField('User Level', [validators.NumberRange(min=0, max=10)])

      - 使用時就是產生一個 instance，例如：

            def register(request):
                form = RegistrationForm(request.POST) # 如果進來的是 GET request 會怎樣??
                if request.method == 'POST' and form.validate():
                    user = User()
                    user.username = form.username.data
                    user.email = form.email.data
                    user.save()
                    redirect('register') # 成功就轉向
                return render_response('register.html', form=form) # 失敗就重畫

      - 如果要編修現有的資料? 透過 `Form(formdata, obj)` 第 2 個參數提供初始資料，再用 `Form.populate_obj()` 將 updated data 抄寫到另一個 object，這對簡單的 CRUD、admin forms 很實用。

            def edit_profile(request):
                user = request.current_user
                form = ProfileForm(request.POST, user) # 會從 obj (user) 取 post data 裡拿不到的資料
                if request.method == 'POST' and form.validate():
                    form.populate_obj(user) # 將 post data (轉換過的) 寫回與 field 同名的 names
                    user.save()
                    redirect('edit_profile')
                return render_response('edit_profile.html', form=form)

## Form ??

  - [Forms - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/forms.html) #ril

## Field ??

  - [Fields - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/fields.html) #ril
  - [How do I mark in a template when a field is required? - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/faq.html#how-do-i-mark-in-a-template-when-a-field-is-required) #ril

## Validation (Field-level) ??

  - [Validators - Crash Course - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html#validators)
      - Validation 是透過 field 下一或多個 validators 來達成；`Field(label, validators, ...)`，通常也會自訂 error message；注意 error message 是從個別 validator 給的，不是從 field 下手。

            class ChangeEmailForm(Form):
                email = StringField('Email', [
                    validators.Length(min=6, message=_(u'Little short for an email address?')),
                    validators.Email(message=_(u'That\'s not a valid email address.'))
                ])

  - [Custom Validators - Crash Course - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html#custom-validators)
      - 把 ad-hoc validator 加進 field 的 validators：

            from wtforms.validators import ValidationError

            def is_42(form, field): # 只要接受 form 跟 field 兩個參數的 callable 即可
                if field.data != 42:
                    raise ValidationError('Must be 42')

            class FourtyTwoForm(Form):
                num = IntegerField('Number', [is_42])

      - 或是在 form class 裡提供 in-form field-specific validator：

            class FourtyTwoForm(Form):
                num = IntegerField('Number')

                def validate_num(form, field): # validate_<fieldname>
                    if field.data != 42:
                        raise ValidationError(u'Must be 42')

  - [wtforms/validators\.py at master · wtforms/wtforms](https://github.com/wtforms/wtforms/blob/master/src/wtforms/validators.py#L72) 雖然 custom validator 文件沒講，但 built-in validators 有自己的 convention `__init__(self, fieldname, message=None)`，做為 callable 被呼叫時 `__call__(self, form, field)`，若判定為 invalid 就會拿 `self.message` 來串 error message #ril
  - [Validators - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/validators.html) #ril
  - [Validation - Fields - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/fields.html#wtforms.fields.Field.validate) 出現 field-level validation 的說法，還有 `pre_validate(form)` 與 `post_vlidate(form)` 可以覆寫 #ril
  - [In-line Validators - WTForms Documentation](https://wtforms.readthedocs.io/en/stable/forms.html#inline-validators) #ril
  - [\[feature request/question\] Form wise errors · Issue \#55 · wtforms/wtforms](https://github.com/wtforms/wtforms/issues/55) #ril

## Validation (Form-level) ??

  - [Complex Validation with Flask\-WTF \| Flask \(A Python Microframework\)](http://flask.pocoo.org/snippets/64/) 示範 form-level validation 的做法 #ril
  - [python \- How do I validate wtforms fields against one another? \- Stack Overflow](https://stackoverflow.com/questions/21815067/) 覆寫 `Form.validate()` 來追加 form-level validation #ril
  - [`validate()` - Forms - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/forms.html#wtforms.form.Form.validate) 按 Validates the form by calling validate on each field, passing any extra `Form.validate_<fieldname>` validators to the field validator. 若 `validate_<fieldname>` 發生在後面，感覺就可以做 post validation 或 form-level validation 了? #ril

## Data Access, Processing ??

  - [How Forms get data - Crash Course - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html#how-forms-get-data)
      - 除了透過 `Form(formdata, obj)` 提供 data 外，也可以透過 keyword arguments 來提供，但要避開現有的參數名稱就是，例如 `formdata`、`obj`、`prefix` 等。
      - `formdata` takes precendence over `obj`, which itself takes precedence over keyword arguments. 然後才是 field 宣告時提供的 default value。
      - If a form was submitted (request.POST is not empty), process the form input. ... If there was no form input, then try the following in order: `obj` argument -> keyword arguments -> default value (field)
  - [wtforms/core\.py at master · wtforms/wtforms](https://github.com/wtforms/wtforms/blob/master/src/wtforms/fields/core.py#L813) `DateTimeField` 內部 `process_formdata()` 會做型態轉換，然後存進 `self.data` 裡，而 `_value()` 則會將 `self.data` 格式化成字串；中間出現的 `self.raw_data` 又有什麼不同??
  - [Custom Fields - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/fields.html#custom-fields) #ril
      - 這裡示範 "comma-separated list of tags"，用 `_value()` 把 `list` (of tags) 轉為 comma-separated tags (string)，反之 `process_formdata()` 則將 comma-separated tags (string) 轉回 `list` (of tags)；又 `process_formdata()` 是發生在 validation 之後嗎??

## Widget, Rendering ??

  - [Rendering Fields - Crash Course - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html#rendering-fields)
      - 要把一個 field 畫出來，其實就是轉型成 string，例如 `str(form.my_field)` 或 `unicode(form.my_field)`。
      - 但它真正的威力來自於 `__call__()`，可以額外提供 keyword arguments，會被輸出成 HTML attributes，例如 `form.my_field(style="width: 200px;", class_="bar")`。
      - 在 Jinja template 裡用起來像這樣 `<div>{{ form.username.label }}: {{ form.username(class="css_class") }}</div>`，或是 Django template 要用 `{% form_field form.username class="css_class" %}`；其中的 `form_field` templatetag (Django 專屬的 extension) 用於要額外傳遞 keyword arguments 時。
  - [Displaying Errors - Crash Course - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html#displaying-errors) #ril
      - 分 field 印 error message：

            <form method="POST" action="/login">
                <div>{{ form.username.label }}: {{ form.username(class="css_class") }}</div>
                {% if form.username.errors %}
                    <ul class="errors">{% for error in form.username.errors %}<li>{{ error }}</li>{% endfor %}</ul>
                {% endif %}

                <div>{{ form.password.label }}: {{ form.password() }}</div>
                {% if form.password.errors %}
                    <ul class="errors">{% for error in form.password.errors %}<li>{{ error }}</li>{% endfor %}</ul>
                {% endif %}
            </form>

    或是集中在一起提示：

      - 這時候 label 的識別度很重要，否則 "This field is required" 看不出來是在講誰。
      - 另外 `|dictsort` 是必要的，否則會遇到 `ValueError: too many values to unpack`，不過因為它是按 field name 排序 (`form.errors` 的結構 `{field_name: [errors]})`)，所以排出來的結果可能跟 UI 的順序不同，或許個別顯示是比較好的。

            {% if form.errors %}
                <ul class="errors">
                    {% for field_name, field_errors in form.errors|dictsort if field_errors %}
                        {% for error in field_errors %}
                            <li>{{ form[field_name].label }}: {{ error }}</li>
                        {% endfor %}
                    {% endfor %}
                </ul>
            {% endif %}

      - 不過 error handling 很煩雜，最後建議用 Jinja 的 macro 來簡化。

  - [Rendering Errors - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/specific_problems.html#rendering-errors)
  - [Widgets - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/widgets.html) #ril

## Testing ??

  - [Exploring in the console - Crash Course - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html#exploring-in-the-console) 再次強調 form 只是個 simple container object，可以在 Python console 裡直接玩 -- 不需要 web framework；呼叫 `Form.validate()`，若 invalid 會傳回 `False`，從 `Form.errors` (dict) 可以得到錯誤的細節。

        >>> from wtforms import Form, StringField, validators
        >>> class UsernameForm(Form):
        ...     username = StringField('Username', [validators.Length(min=5)], default=u'test')
        ...
        >>> form = UsernameForm()
        >>> form['username']
        <wtforms.fields.StringField object at 0x827eccc>
        >>> form.username.data
        u'test'
        >>> form.validate()
        False
        >>> form.errors
        {'username': [u'Field must be at least 5 characters long.']}


        >>> form2 = UsernameForm(username=u'Robert') # 由 **kwargs 提供資料
        >>> form2.data
        {'username': u'Robert'}
        >>> form2.validate()
        True

  - [class wtforms.form.Form - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/forms.html#wtforms.form.Form) `Form(data=<dict>)` 似乎更適合拿來測試??

## File Upload ??

  - [Does WTForms handle file uploads? - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/faq.html#does-wtforms-handle-file-uploads) 不支援，因為會跟 web framework 產生相依? #ril

## CSRF ??

  - [CSRF Protection - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/csrf.html) #ril

## Form object 不適合傳進 domain model?

  - Form 比較像是 presentation mode。
  - 假設前端 UI 輸入日期的設計是用分開的下拉清單分別選最年、月、日，那麼 form 顯然就不適合傳進 domain model，應該要解析成 date 型態後再傳進去。

## 安裝設定 {: #installation }

  - [Download / Installation - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/crash_course.html#download-installation) 安裝 `WTForms` 套件

## 參考資料 {: #reference }

  - [WTForms](http://wtforms.readthedocs.io/en/latest/)
  - [WTForms - PyPI](https://pypi.python.org/pypi/WTForms)
  - [wtforms/wtforms - GitHub](https://github.com/wtforms/wtforms/)

社群：

  - ['wtforms' Questions - Stack Overflow](https://stackoverflow.com/questions/tagged/wtforms)

相關：

  - [Flask-WTF](flask-wtf.md)

手冊：

  - [API - WTForms Documentation](https://wtforms.readthedocs.io/en/latest/index.html)
  - [class `wtforms.form.Form`](https://wtforms.readthedocs.io/en/latest/forms.html#wtforms.form.Form)
  - [class `wtforms.fields.Field`](https://wtforms.readthedocs.io/en/latest/fields.html#wtforms.fields.Field)
  - [Basic & Convenience Fields](https://wtforms.readthedocs.io/en/latest/fields.html#basic-fields)
  - [Built-in Validators](https://wtforms.readthedocs.io/en/latest/validators.html#module-wtforms.validators)

