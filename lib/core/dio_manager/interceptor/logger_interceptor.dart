/*
Neden Logger Interceptor yazıyoruz?

Dio tek başına log yazmıyor (ya da sadece print ile çok basit bilgi veriyor).

.get() veya .post() çağırırken try/catch ile uğraşmadan

hangi URL’e istek atıldığını,

hangi status code döndüğünü,

hata varsa mesajını,
loglarda net şekilde görebilmek.

Yani debugging için kara kutu yerine şeffaf bir log defteri oluyor.
*/

import 'dart:developer' as dev;

import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    dev.log('[REQUEST] ${options.method} ${options.uri}', name: 'HTTP');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final fromCache = response.extra['fromCache'] == true;
    dev.log(
      '[RESPONSE] ${response.statusCode} '
      '${response.requestOptions.method} ${response.requestOptions.uri} '
      '${fromCache ? "(CACHE)" : "(NETWORK)"}',
      name: 'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    dev.log(
      '[ERROR] ${err.requestOptions.method} ${err.requestOptions.uri} '
      '-> ${err.response?.statusCode} : ${err.message}',
      name: 'HTTP',
    );
    handler.next(err);
  }
}
