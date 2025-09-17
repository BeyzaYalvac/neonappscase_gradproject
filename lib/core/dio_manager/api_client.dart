import 'package:dio/dio.dart';
import 'package:neonappscase_gradproject/app/common/cache/hive/hive_cache_store.dart';
import 'package:neonappscase_gradproject/core/dio_manager/interceptor/cache_interceptor.dart';
import 'package:neonappscase_gradproject/core/dio_manager/interceptor/logger_interceptor.dart';
import 'safe_dio.dart';

class ApiClient {
  late final SafeDio safe;

  ApiClient({
    required String baseUrl,
    Map<String, dynamic>? headers,
    List<Interceptor>? extraInterceptors,
  }) {
    final dio =
        Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 20),
              sendTimeout: const Duration(seconds: 20),
              headers: headers,
              responseType: ResponseType.json,
              receiveDataWhenStatusError: true,
            ),
          )
          ..interceptors.addAll([
            CacheInterceptor(HiveCacheStore()),
            LoggerInterceptor(),
          ]);

    if (extraInterceptors != null) {
      dio.interceptors.addAll(extraInterceptors);
    }

    safe = SafeDio(dio);
  }
}
