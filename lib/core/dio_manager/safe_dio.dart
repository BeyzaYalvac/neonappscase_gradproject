import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'api_result.dart';
import 'app_error.dart';
import 'dio_error_mapper.dart';

class SafeDio {
  final Dio _dio;
  SafeDio(this._dio);

  Future<ApiResult<T>> _wrap<T>(Future<Response<T>> Function() call) async {
    try {
      final res = await call();
      return ApiResult.success(res.data as T);
    } on DioException catch (e) {
      return ApiResult.failure(mapDioError(e));
    } catch (_) {
      return ApiResult.failure(
        AppError(type: AppErrorType.unknown, message: 'Bilinmeyen hata.'),
      );
    }
  }

  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) => _wrap<T>(() async {
    final response = await _dio.get<T>(
      path,
      queryParameters: query,
      options: options,
    );
    debugPrint('---${response.statusCode.toString()}---');
    return response;
  });

  Future<ApiResult<T>> post<T>(String path, {dynamic data, Options? options}) =>
      _wrap<T>(() => _dio.post<T>(path, data: data, options: options));

  Future<ApiResult<T>> put<T>(String path, {dynamic data, Options? options}) =>
      _wrap<T>(() => _dio.put<T>(path, data: data, options: options));

  Future<ApiResult<T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
  }) => _wrap<T>(() => _dio.delete<T>(path, data: data, options: options));
}
