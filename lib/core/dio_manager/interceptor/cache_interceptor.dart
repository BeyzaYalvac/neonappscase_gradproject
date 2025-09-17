import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:neonappscase_gradproject/app/common/cache/build_cache_key.dart';
import 'package:neonappscase_gradproject/app/common/cache/hive/hive_cache_store.dart';
import 'package:neonappscase_gradproject/app/common/cache/hive_cache_model.dart';

/// Options.extra alanında kullanabileceğin anahtarlar:
/// - 'cache' (bool): GET çağrıyı cachele (default: true)
/// - 'maxAge' (Duration): Bu çağrı için maxAge override
/// - 'staleOnError' (bool): Hata durumunda bayat da olsa cache ver (default: true)
/// - 'preferCache' (bool): İstek atmadan önce (varsa) cache’i direkt çözümle (default: false)
class CacheInterceptor extends Interceptor {
  final HiveCacheStore store;
  CacheInterceptor(this.store);

  bool _isGet(RequestOptions o) => o.method.toUpperCase() == 'GET';

  String _keyFor(RequestOptions o) => buildCacheKey(
    o.method,
    o.uri,
    query: o.queryParameters,
    bodyForKey: null,
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Sadece GET isteklerde çalışalım
    if (!_isGet(options)) return handler.next(options);

    final useCache = (options.extra['cache'] as bool?) ?? true;
    final preferCache = (options.extra['preferCache'] as bool?) ?? false;

    if (!useCache) return handler.next(options);

    if (preferCache) {
      final key = _keyFor(options);
      final entry = await store.read(key);
      if (entry != null) {
        // preferCache: ağ vurmadan cache dön
        return handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: jsonDecode(entry.value),
            extra: {
              ...options.extra, // 🔑 request extra’ları taşı
              'fromCache': true, // 🔑 cache işareti
              'stale': !entry.isFresh,
            },
          ),
        );
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final options = response.requestOptions;
    if (_isGet(options) &&
        response.statusCode == 200 &&
        ((options.extra['cache'] as bool?) ?? true)) {
      final cacheKey = _keyFor(options);

      // Bu çağrı için maxAge override edilebilir
      final override = options.extra['maxAge'];
      final maxAge = (override is Duration)
          ? override
          : const Duration(minutes: 30);

      final entry = CacheModel(
        key: cacheKey,
        value: jsonEncode(response.data),
        createdAt: DateTime.now(),
        maxAge: maxAge,
      );

      await store.write(entry);
      print("✅ Cache stored for key=$cacheKey");
    }
    response.extra['fromCache'] = response.extra['fromCache'] ?? false;

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final o = err.requestOptions;
    if (!_isGet(o) || ((o.extra['cache'] as bool?) == false)) {
      return handler.next(err);
    }

    final staleOnError = (o.extra['staleOnError'] as bool?) ?? true;
    final key = _keyFor(o);
    final entry = await store.read(key);

    if (entry != null) {
      print("Cache entry bulundu, dönüyorum: $key"); // 👈 BURAYA

      final isNetworkish = _isNetworkOrServerSide(err);

      // Politika:
      // - staleOnError=true ise: herhangi bir ağ/timeout/5xx hatasında bayat da olsa cache ver
      // - staleOnError=false ise: sadece fresh ise ver
      final canServe = staleOnError
          ? isNetworkish /* bayatı da ver */
          : entry.isFresh /* sadece taze */;

      if (canServe) {
        return handler.resolve(
          Response(
            requestOptions: o,
            statusCode: 200,
            data: jsonDecode(entry.value),
            extra: {...o.extra, 'fromCache': true, 'stale': !entry.isFresh},
          ),
        );
      }
    }

    // Cache yoksa ya da politika izin vermiyorsa hatayı devam ettir
    handler.next(err);
  }

  bool _isNetworkOrServerSide(DioException e) {
    // Bağlantı/timeout/unknown hataları veya 5xx
    final type = e.type;
    final isConn =
        type == DioExceptionType.connectionError ||
        type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.unknown;

    final status = e.response?.statusCode ?? 0;
    final is5xx = status >= 500 && status <= 599;

    return isConn || is5xx;
  }
}
