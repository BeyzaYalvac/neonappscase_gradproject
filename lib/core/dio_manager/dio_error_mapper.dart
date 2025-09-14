import 'package:dio/dio.dart';
import 'package:neonappscase_gradproject/core/dio_manager/app_error.dart';

AppError mapDioError(DioException e) {
  final code = e.response?.statusCode;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return AppError(
        type: AppErrorType.timeout,
        message: 'İstek zaman aşımına uğradı.',
      );
    case DioExceptionType.connectionError:
      return AppError(
        type: AppErrorType.network,
        message: 'İnternet bağlantısı yok.',
      );
    case DioExceptionType.badResponse:
      if (code != null && code >= 500) {
        return AppError(
          type: AppErrorType.server,
          message: 'Sunucu hatası ($code).',
        );
      }
      return AppError(
        type: AppErrorType.client,
        message: 'İstemci hatası (${code ?? '?'}).',
      );
    case DioExceptionType.cancel:
      return AppError(
        type: AppErrorType.client,
        message: 'İstek iptal edildi.',
      );
    case DioExceptionType.badCertificate:
      return AppError(type: AppErrorType.client, message: 'Sertifika hatası.');
    default:
      return AppError(type: AppErrorType.unknown, message: 'Bilinmeyen hata.');
  }
}
