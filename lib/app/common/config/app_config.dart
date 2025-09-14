import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get bearerToken => dotenv.env['API_BEARER_TOKEN'] ?? '';
  static String get isFirstKey => dotenv.env['kFirstKey'] ?? '';
}
