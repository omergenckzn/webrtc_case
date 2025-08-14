import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

class ApiRoutes {
  static String get baseUrlDev => dotenv.env['API_BASE_URL_DEV'] ?? '';
  static String get baseUrlProduction =>
      dotenv.env['API_BASE_URL_PRODUCTION'] ?? '';
  static String get baseUrlStaging => dotenv.env['API_BASE_URL_STAGING'] ?? '';


}
