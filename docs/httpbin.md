# HttpBin

  - [httpbin\.org](https://httpbin.org/)
      - A simple HTTP Request & Response Service.
      - 最早是 RequestBin 可以用來測 POST request，但無法控制 response，所以才有 HttpBin 的出現；但 HttpBin 不支援 POST (現在已支援)
  - [requests/httpbin: HTTP Request & Response Service, written in Python \+ Flask\.](https://github.com/requests/httpbin) 額外提到 written in Python + Flask
  - [Announcing Httpbin\.org — Kenneth Reitz](https://www.kennethreitz.org/essays/httpbin) (2011-06-12)
      - Requests 的測試在實務上有些惱人，現有的 PostBin.org (現在都會導到 http://requestb.in/ ?) 只能用來測 HTTP POST，而且執行在 GAE 上，所以 httpbin.org 就這樣誕生了。
      - 例如 `curl http://httpbin.org/user-agent` 會得到 `{ "user-agent": "curl/7.43.0" }`。
      - HttpBin 會打包在 PyPI 上，用 Flask 開發。

## Hello, World!

```
def test_hello_world():
    query_string = {'greeting': 'Hello, World!'}
    resp = requests.get('http://httpbin/get', params=query_string)
    resp.raise_for_status() # best practice

    assert resp.json()['args']['greeting'] == 'Hello, World!'
```

## 新手上路?? {: #getting-started }

  - [httpbin\.org](https://httpbin.org/) 首頁是用 Flasgger 產生的 API 文件，區分為 HTTP Methods、Auth、Status codes、Response formats、Cookies、Images、Redirects 及 Anything，可以分開學習。

## Request Inspection ??

  - [Request inspection - httpbin\.org](https://httpbin.org/#operations-tag-Request_inspection) 底下有 `/headers`、`/ip` 跟 `/user-agent`，感覺是 `GET /anything` 的簡化版?

## Anything

`/anything` 因為 "returns anything passed in request data" 的特定，又支援不同的 HTTP method，可以用來檢查往 server 端送出的資料是否正確，但無法安排特定的 response，因為型態固定是 `application/json`，結構也是固定的。例如：

```
$ curl https://httpbin.org/anything?key1=value1 --data key2=value2
{
  "args": {        <-- 收到的資料
    "key1": "value1"
  },
  "data": "",
  "files": {},
  "form": {
    "key2": "value2"
  },
  "headers": {     <-- 收到的 header
    "Accept": "*/*",
    "Connection": "close",
    "Content-Length": "11",
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "httpbin.org",
    "User-Agent": "curl/7.54.0"
  },
  "json": null,
  "method": "POST",
  "origin": "12.34.56.78",
  "url": "https://httpbin.org/anything?key1=value1"
}
```

參考資料：

  - [Anything - httpbin\.org](https://httpbin.org/#operations-tag-Anything)
      - Returns anything that is passed to request 看似 Request inspection 是它的簡化版?
      - 支援 DELETE、GET、PATCH、POST、PUT，有 `/anything` 跟 `/anything/{anything}` 兩種 endpoint? 只要以 `/anything` 開頭即可。
  - [Enable request logging · Issue \#421 · requests/httpbin](https://github.com/requests/httpbin/issues/421)
      - drichards-levtech: 想看 server side 收到什麼?
      - sigmavirus24: (member) `/anything` already returns the data as it is seen by HTTPbin => 這一點可以用來確認收到什麼!!

## 安裝設定 {: #installation }

### 用 Docker 執行 HttpBin

```
$ docker run --rm -d --name httpbin kennethreitz/httpbin
$ docker run --rm -it --link httpbin alpine
/ # apk add --no-cache curl
/ # curl -i http://httpbin/get
HTTP/1.1 200 OK
Server: gunicorn/19.9.0
Date: Fri, 28 Sep 2018 13:37:49 GMT
Connection: keep-alive
Content-Type: application/json
Content-Length: 175
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true

{
  "args": {},
  "headers": {
    "Accept": "*/*",
    "Host": "httpbin",
    "User-Agent": "curl/7.61.1"
  },
  "origin": "172.17.0.5",
  "url": "http://httpbin/get"
}
```

參考資料：

  - [httpbin\.org](https://httpbin.org/) 一開始就講 Run locally: `$ docker run -p 80:80 kennethreitz/httpbin`
  - [kennethreitz/httpbin \- Docker Hub](https://hub.docker.com/r/kennethreitz/httpbin/) 這裡什麼都沒講
      - `Dockerfile` 以 `ubuntu:18.04` 為基礎，執行用 `CMD ["gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]`
      - Tags 只有 `latest` XD

## 參考資料 {: #reference }

  - [httpbin.org](https://httpbin.org/)
  - [requests/httpbin - GitHub](https://github.com/requests/httpbin)

社群：

  - [#httpbin hashtag on Twitter](https://twitter.com/hashtag/httpbin)
