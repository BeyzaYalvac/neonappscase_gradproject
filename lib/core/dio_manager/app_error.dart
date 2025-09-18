enum AppErrorType {
  network,
  server,
  unauthorized,
  unknown,
  timeout,
  client,
} //Hataları sınıflandırdımm (Daha da çeşitlendirmeyi unutmayayım unknown'a düşerse sıkıntı)

class AppError {
  final AppErrorType type;
  final String? message;

  AppError({required this.type, this.message});

  @override
  String toString() {
    return 'AppError{type: $type, message: $message}';
  }
}
