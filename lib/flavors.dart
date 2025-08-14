import 'package:dating_app/core/config/api_routes.dart';
import 'package:dating_app/firebase_options_development.dart' as development;
import 'package:dating_app/firebase_options_production.dart' as production;
import 'package:dating_app/firebase_options_staging.dart' as staging;
import 'package:firebase_core/firebase_core.dart';

enum Flavor {
  development,
  production,
  staging,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'DatingApp Dev';
      case Flavor.production:
        return 'DatingApp';
      case Flavor.staging:
        return 'DatingApp Test';
      default:
        return 'DatingApp Unknown';
    }
  }

  static FirebaseOptions get firebaseOptions {
    switch (appFlavor) {
      case Flavor.development:
        return development.DefaultFirebaseOptions.currentPlatform;
      case Flavor.production:
        return production.DefaultFirebaseOptions.currentPlatform;
      case Flavor.staging:
        return staging.DefaultFirebaseOptions.currentPlatform;
      default:
        return development.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return ApiRoutes.baseUrlDev;
      case Flavor.production:
        return ApiRoutes.baseUrlProduction;
      case Flavor.staging:
        return ApiRoutes.baseUrlStaging;
      default:
        return ApiRoutes.baseUrlDev;
    }
  }
}
