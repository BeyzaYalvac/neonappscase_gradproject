import 'app_error.dart';

//Dio'dan gelen yanıtı tek birsınıfla temsil etmek istedim.
/// Success olduğunda [data] gelir.
/// Failure olduğunda [error] gelir.
class ApiResult<T> {
  final T? data;
  final AppError? error;

  const ApiResult._({
    this.data,
    this.error,
  }); 
  
  /// Başarılı sonuç
  factory ApiResult.success(T data) => ApiResult._(data: data, error: null);

  /// Hatalı sonuç
  factory ApiResult.failure(AppError error) =>
      ApiResult._(error: error, data: null);

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}
