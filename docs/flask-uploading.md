# Flask Uploading & Downloading

## Uploading

[learning/test\_upload\.py at master · imsardine/learning](https://github.com/imsardine/learning/blob/master/flask/tests/test_upload.py):

```python
import base64
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/', methods=['POST'])
def upload():
    files = []
    for name in request.files:
        fs = request.files[name] # werkzeug.datastructures.FileStorage

        # decoding is needed, or TypeError: Object of type 'bytes' is not JSON serializable
        content = base64.standard_b64encode(fs.read()).decode('ascii')
        entry = {
            'name': fs.name,
            'filename': fs.filename,
            'content_length': fs.content_length,
            'content_type': fs.content_type,
            'content': content,
        }
        files.append(entry)

    return jsonify(files)
```

```
$ FLASK_APP=upload.py flask run &
...
 * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)

$ curl -F 'file1=@logo.png' -F 'file2=@document.txt' http://127.0.0.1:5000/ | jq .
[
  {
    "content": "iVBORw0...KGgoAAAAN",
    "content_length": 0,
    "content_type": "application/octet-stream",
    "filename": "logo.png",
    "name": "file1"
  },
  {
    "content": "aW1wb3...J0IGJhc=",
    "content_length": 0,
    "content_type": "application/octet-stream",
    "filename": "document.txt",
    "name": "file2"
  }
]
```

參考資料：

  - [Uploading Files — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/patterns/fileuploads/) #ril
      - 在 client 端，需要一個 `<form enctype="multipart/form-data">` + `<input type=file>`，送出後在 server-side 可以從 request object 的 `files` 拿到檔案，接著就是呼叫 `save()` 存到檔案系統。

            from werkzeug.utils import secure_filename

            @app.route('/', methods=['GET', 'POST'])
            def upload_file():
                if request.method == 'POST':
                    # check if the post request has the file part
                    if 'file' not in request.files: # key-value pairs str:FileStorage
                        flash('No file part')
                        return redirect(request.url)
                    file = request.files['file']
                    # if user does not select file, browser also
                    # submit an empty part without filename
                    if file.filename == '': # 沒有選檔案，還是可以拿到 FileStorage
                        flash('No selected file')
                        return redirect(request.url)
                    if file and allowed_file(file.filename):
                        filename = secure_filename(file.filename) # never trust user input
                        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                        return redirect(url_for('uploaded_file',
                                                filename=filename))
                return '''
                <!doctype html>
                <title>Upload new File</title>
                <h1>Upload new File</h1>
                <form method=post enctype=multipart/form-data>
                  <input type=file name=file> <-- 會形成 request.files 的 key
                  <input type=submit value=Upload>
                </form>
                '''

  - [files - API — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/api/#flask.Request.files)
      - `MultiDict` object containing all uploaded files. Each key in files is the name from the `<input type="file" name="">`. Each value in `files` is a Werkzeug `FileStorage` object. 基本上它跟 Python 的 file object 很像，有 [`save()`](http://werkzeug.pocoo.org/docs/0.14/datastructures/#werkzeug.datastructures.FileStorage.save) 可以把內容寫到檔案系統；還有其他屬性 -- `name`、`filename`、`content_length`、`content_type`、`mimetype` 等。
      - Note that `files` will only contain data if the request method was POST, PUT or PATCH and the `<form>` that posted to the request had `enctype="multipart/form-data"`. It will be empty otherwise. 上面還有一種使用者沒選檔案就送出表單的狀況，會拿到 file object，但內容是空的。
  - [FileStorage - Data Structures — Werkzeug Documentation \(0\.14\)](http://werkzeug.pocoo.org/docs/0.14/datastructures/#werkzeug.datastructures.FileStorage)
      - The `FileStorage` class is a thin wrapper over incoming files. It is used by the request object to represent uploaded files.
      - All the attributes of the wrapper STREAM are proxied by the file storage so it’s possible to do `storage.read()` instead of the long form `storage.stream.read()`. 按 [io — Core tools for working with streams — Python 3\.7\.1 documentation](https://docs.python.org/3/library/io.html) 的說法，stream 就是 file-like object。
      - `stream` - The input stream for the uploaded file. This usually points to an open temporary file. 就當 file-like object 使用，不一定要呼叫 `save()` 存成檔案再讀出來。
      - `filename` - The filename of the file on the client.
      - `name` - The name of the form field.
      - `headers` - The multipart headers as `Headers` object. This usually contains irrelevant information but in combination with CUSTOM MULTIPART requests the raw headers might be interesting. ??
      - `close()` - Close the underlying file if possible. 釋放資源??
      - `content_length` - The content-length sent in the header. Usually not available
      - `content_type` - The content-type sent in the header. Usually not available 所以只能從 `filename` 推測??
      - `mimetype` - Like `content_type`, but without PARAMETERS (eg, without charset, type etc.) and always lowercase. For example if the content type is `text/HTML; charset=utf-8` the `mimetype` would be `'text/html'`. 也就是 `content_type` 前段正規化的結果，後段拆出去 `mimetype_params`。
      - `mimetype_params` - The mimetype parameters as dict. For example if the content type is `text/html; charset=utf-8` the params would be `{'charset': 'utf-8'}`.
      - `save(dst, buffer_size=16384)` - Save the file to a destination path or file object. If the destination is a file object YOU HAVE TO CLOSE IT YOURSELF after the call. The buffer size is the number of bytes held in memory during the copy process. It defaults to 16KB. 那自己的 `close` 要誰來呼叫??
  - [Fix the client intended to send too large body nginx error \- Jesin's Blog](https://websistent.com/fix-client-intended-to-send-too-large-body-nginx-error/) (2013-02-25) 限制來自於前端的 nginx，調整 `nginx.conf` 裡的 `client_max_body_size 20M;` 即可。

## Downloading

參考資料：

  - [Uploading Files — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/patterns/fileuploads/) 檔案上傳後若存在檔案系統裡，可以透過 `send_from_directory` 下載：

            from flask import send_from_directory

            @app.route('/uploads/<filename>')
            def uploaded_file(filename):
                return send_from_directory(app.config['UPLOAD_FOLDER'],
                                           filename)

  - [flask.send_from_directory - API — Flask 1\.0\.2 documentation](http://flask.pocoo.org/docs/1.0/api/#flask.send_from_directory) Send a file from a given directory with `send_file()`. This is a SECURE way to quickly EXPOSE STATIC FILES from an upload folder or something similar.

## 參考資料 {: #reference }

手冊：

  - [`flask.Request.files`](http://flask.pocoo.org/docs/1.0/api/#flask.Request.files)
  - [Class `werkzeug.datastructures.FileStorage`](http://werkzeug.pocoo.org/docs/0.14/datastructures/#werkzeug.datastructures.FileStorage)
  - [`flask.send_from_directory()`](http://flask.pocoo.org/docs/1.0/api/#flask.send_from_directory)
