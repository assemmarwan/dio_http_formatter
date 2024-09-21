[![Pub Version](https://img.shields.io/pub/v/dio_http_formatter?include_prereleases)](https://pub.dev/packages/dio_http_formatter)

A simple Dio interceptor for pretty printing the HTTP request/response (using the awesome
package [Logger](https://github.com/leisim/logger)) to be printed in the console for easier debugging and sharing.

Different content types are supported and pretty printed such as:

- `application/json`
- `application/x-www-form-urlencoded`
- `text/html`

## Getting started

1- Install the package in your project:

```
flutter pub get dio_http_formatter
```

or if not for Flutter:

```
pub get dio_http_formatter
```

2- Add the interceptor to your Dio instance like:

```dart

final _dio = Dio();
_dio.interceptors.add(HttpFormatter());
```

### Dio Version Map

For a certain version of Dio, use the following table to find the correct version of this package to use:

| Dio Version | Package Version |
|:------------|:----------------|
| 4.x.x       | 2.x.x           |
| 5.x.x       | 3.x.x           |

## Options

Below are the optional parameters that can be specified for the formatter to customize what and how the HTTP request and response is printed.

| Property                  |       Type      |   Default Value   |
|---------------------------|:---------------:|:-----------------:|
| includeRequest            |      `bool`     |       `true`      |
| includeRequestHeaders     |      `bool`     |       `true`      |
| includeRequestQueryParams |      `bool`     |       `true`      |
| includeRequestBody        |      `bool`     |       `true`      |
| includeResponse           |      `bool`     |       `true`      |
| includeResponseHeaders    |      `bool`     |       `true`      |
| includeResponseBody       |      `bool`     |       `true`      |
| logger                    |     `Logger`    | `PrettyPrinter()` |
| loggingFilter             | `LoggingFilter` |       `null`      |


## Logging Filter

The `HTTPFormatter` has support for filtering whether to log a request/response or not. For example:

```dart

final dio = Dio();
dio.interceptors.add(
  HttpFormatter(
    loggingFilter: (request, response, error) {
      // We don't want to print the request/response when 201 is returned
      if (response?.statusCode == 201) {
        return false;
      }
      // Otherwise, the logs should print
      return true;
    },
  ),
);
```

> [!WARNING]  
> `httpLoggerFilter` is now deprecated and it's highly encouraged to move to the new `loggingFilter`. `httpLoggerFilter` will be removed in the next major version.

## Examples

### POST request [application/json]

```dart
  await _dio.post('https://postman-echo.com/post',
      data: <String, dynamic>{'foo': 'foo'},
      options: Options()
        ..headers = <String, dynamic>{
          'my-custom-header': 'my-custom-header',
          'content-type': 'application/json'
        });
```

```
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│ ⤴ REQUEST ⤴
│ 
│ POST https://postman-echo.com/post
│ content-type: application/json
│ my-custom-header: my-custom-header
│ content-length: 13
│ 
│ 
│ {
│   "foo": "foo"
│ }
│ 
│ ⤵ RESPONSE [200/OK] [Time elapsed: 1080 ms]⤵
│ 
│ connection: [keep-alive]
│ set-cookie: [sails.sid=s%3AlO2moZlJ_-LGJZdq_o0KRpliqamhCecq.lNnUP5X%2Fvr%2BXi2an7q6GJki9DPmDQyPAyBW7p117ijM; Path=/; HttpOnly]
│ date: [Mon, 22 Jun 2020 17:29:07 GMT]
│ vary: [Accept-Encoding]
│ content-length: [417]
│ etag: [W/"1a1-14yzanqIFzi16qAA3YVbkp9Acl8"]
│ content-type: [application/json; charset=utf-8]
│ 
│ 
│ {
│   "args": {},
│   "data": {
│     "foo": "foo"
│   },
│   "files": {},
│   "form": {},
│   "headers": {
│     "x-forwarded-proto": "https",
│     "x-forwarded-port": "443",
│     "host": "postman-echo.com",
│     "x-amzn-trace-id": "Root=1-5ef0ea63-50bc2440e0e07883458a067f",
│     "content-length": "13",
│     "user-agent": "Dart/2.8 (dart:io)",
│     "content-type": "application/json",
│     "my-custom-header": "my-custom-header",
│     "accept-encoding": "gzip"
│   },
│   "json": {
│     "foo": "foo"
│   },
│   "url": "https://postman-echo.com/post"
│ }
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

### POST request [multipart/form-data]
```dart
await dio.post(
    "https://postman-echo.com/post",
    data: FormData.fromMap({
      "foo": "foo",
      "bar": MultipartFile.fromBytes([1, 2, 3, 4, 5, 6])
    }),
  );
```
```text
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│ ⤴ REQUEST ⤴
│ 
│ POST https://postman-echo.com/post
│ content-type: multipart/form-data; boundary=--dio-boundary-0846883596
│ content-length: 234
│ 
│ 
│ {
│   "foo": "foo",
│   "bar": "[application/octet-stream; length=6]"
│ }
│ 
│ ⤵ RESPONSE [200/OK] [Time elapsed: 1431 ms]⤵
│ 
│ etag: [W/"238-Drbr+mbesAC7mnUT1/6HdwqJbOg"]
│ connection: [keep-alive]
│ content-type: [application/json; charset=utf-8]
│ set-cookie: [sails.sid=s%3AYZPFhMKwqVTkLbZkRSbdqY_ZGZYFul8h.UrGXXLdzjfYJEdEVOlpQND2Ms3KnpKomTNQh42u3tS4; Path=/; HttpOnly]
│ date: [Sun, 19 Mar 2023 12:39:21 GMT]
│ content-length: [568]
│ 
│ 
│ {
│   "args": {},
│   "data": {},
│   "files": {
│     "undefined": "data:application/octet-stream;base64,AQIDBAUG"
│   },
│   "form": {
│     "foo": "foo"
│   },
│   "headers": {
│     "x-forwarded-proto": "https",
│     "x-forwarded-port": "443",
│     "host": "postman-echo.com",
│     "x-amzn-trace-id": "Root=1-64170279-48f590a477b666d63975dd13",
│     "content-length": "234",
│     "user-agent": "Dart/2.19 (dart:io)",
│     "content-type": "multipart/form-data; boundary=--dio-boundary-0846883596",
│     "accept-encoding": "gzip"
│   },
│   "json": null,
│   "url": "https://postman-echo.com/post"
│ }
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

### POST request [application/x-www-form-urlencoded]
```dart
await dio.post(
    "https://postman-echo.com/post",
    data: {
      "foo": "foo",
      "bar": "bar",
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );
```
```text
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│ ⤴ REQUEST ⤴
│ 
│ POST https://postman-echo.com/post
│ content-type: application/x-www-form-urlencoded
│ content-length: 15
│ 
│ 
│ {
│   "foo": "foo",
│   "bar": "bar"
│ }
│ 
│ ⤵ RESPONSE [200/OK] [Time elapsed: 1419 ms]⤵
│ 
│ etag: [W/"213-RckysDJgyaHU3rsP8vCoDnqI4Pg"]
│ connection: [keep-alive]
│ content-type: [application/json; charset=utf-8]
│ set-cookie: [sails.sid=s%3AxDq5jvVLfuAkxh5o0pUhZOLzkqPt4xBz.apV3a%2FKrhiKWA%2B7foUqihO0BMGTnCOwVSiiW93CBozo; Path=/; HttpOnly]
│ date: [Sun, 19 Mar 2023 12:42:13 GMT]
│ content-length: [531]
│ 
│ 
│ {
│   "args": {},
│   "data": "",
│   "files": {},
│   "form": {
│     "foo": "foo",
│     "bar": "bar"
│   },
│   "headers": {
│     "x-forwarded-proto": "https",
│     "x-forwarded-port": "443",
│     "host": "postman-echo.com",
│     "x-amzn-trace-id": "Root=1-64170325-433157c952cf5ed84f36f867",
│     "content-length": "15",
│     "user-agent": "Dart/2.19 (dart:io)",
│     "content-type": "application/x-www-form-urlencoded",
│     "accept-encoding": "gzip"
│   },
│   "json": {
│     "foo": "foo",
│     "bar": "bar"
│   },
│   "url": "https://postman-echo.com/post"
│ }
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```



### Successful GET request [text/html]

```dart
await _dio.get('https://example.org');
```

```
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│ ⤴ REQUEST ⤴
│ 
│ GET https://example.org
│ 
│ 
│ ⤵ RESPONSE [200/OK] [Time elapsed: 963 ms]⤵
│ 
│ cache-control: [max-age=604800]
│ last-modified: [Thu, 17 Oct 2019 07:18:26 GMT]
│ date: [Mon, 22 Jun 2020 17:34:41 GMT]
│ content-encoding: [gzip]
│ vary: [Accept-Encoding]
│ age: [336678]
│ content-type: [text/html; charset=UTF-8]
│ server: [ECS (dcb/7FA3)]
│ accept-ranges: [bytes]
│ content-length: [648]
│ etag: ["3147526947"]
│ x-cache: [HIT]
│ expires: [Mon, 29 Jun 2020 17:34:41 GMT]
│ 
│ 
│ <!doctype html>
│ <html>
│ <head>
│     <title>Example Domain</title>
│ 
│     <meta charset="utf-8" />
│     <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
│     <meta name="viewport" content="width=device-width, initial-scale=1" />
│     <style type="text/css">
│     body {
│         background-color: #f0f0f2;
│         margin: 0;
│         padding: 0;
│         font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
│         
│     }
│     div {
│         width: 600px;
│         margin: 5em auto;
│         padding: 2em;
│         background-color: #fdfdff;
│         border-radius: 0.5em;
│         box-shadow: 2px 3px 7px 2px rgba(0,0,0,0.02);
│     }
│     a:link, a:visited {
│         color: #38488f;
│         text-decoration: none;
│     }
│     @media (max-width: 700px) {
│         div {
│             margin: 0 auto;
│             width: auto;
│         }
│     }
│     </style>    
│ </head>
│ 
│ <body>
│ <div>
│     <h1>Example Domain</h1>
│     <p>This domain is for use in illustrative examples in documents. You may use this
│     domain in literature without prior coordination or asking for permission.</p>
│     <p><a href="https://www.iana.org/domains/example">More information...</a></p>
│ </div>
│ </body>
│ </html>
│ 
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

### Successful GET request with Query Params [text/html]

```dart
  await _dio.get('https://example.com',
        queryParameters: {'limit_start': 0, 'search_term': 'dart'});
```

```
┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
│ ⤴ REQUEST ⤴
│ 
│ GET https://example.com
│ 
│ ===== Query Parameters =====
│ limit_start : 0
│ search_term : dart
│ 
│ ⤵ RESPONSE [200/OK] [Time elapsed: 1204 ms]⤵
│ 
│ last-modified: [Thu, 17 Oct 2019 07:18:26 GMT]
│ cache-control: [max-age=604800]
│ date: [Fri, 26 Nov 2021 12:04:26 GMT]
│ vary: [Accept-Encoding]
│ content-encoding: [gzip]
│ content-length: [648]
│ age: [86638]
│ etag: ["3147526947+gzip"]
│ content-type: [text/html; charset=UTF-8]
│ x-cache: [HIT]
│ server: [ECS (oxr/8317)]
│ expires: [Fri, 03 Dec 2021 12:04:26 GMT]
│ 
│ 
│ <!doctype html>
│ <html>
│ <head>
│     <title>Example Domain</title>
│ 
│     <meta charset="utf-8" />
│     <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
│     <meta name="viewport" content="width=device-width, initial-scale=1" />
│     <style type="text/css">
│     body {
│         background-color: #f0f0f2;
│         margin: 0;
│         padding: 0;
│         font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", "Open Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
│         
│     }
│     div {
│         width: 600px;
│         margin: 5em auto;
│         padding: 2em;
│         background-color: #fdfdff;
│         border-radius: 0.5em;
│         box-shadow: 2px 3px 7px 2px rgba(0,0,0,0.02);
│     }
│     a:link, a:visited {
│         color: #38488f;
│         text-decoration: none;
│     }
│     @media (max-width: 700px) {
│         div {
│             margin: 0 auto;
│             width: auto;
│         }
│     }
│     </style>    
│ </head>
│ 
│ <body>
│ <div>
│     <h1>Example Domain</h1>
│     <p>This domain is for use in illustrative examples in documents. You may use this
│     domain in literature without prior coordination or asking for permission.</p>
│     <p><a href="https://www.iana.org/domains/example">More information...</a></p>
│ </div>
│ </body>
│ </html>
│ 
└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

```

