
flutter packages pub run build_runner build --delete-conflicting-outputs

dart run build_runner build

flutter packages pub run build_runner watch --delete-conflicting-outputs

#generate flavors
flutter pub run flutter_flavorizr

flutter run  --release --flavor development -t lib/main_development.dart
flutter run  --release --flavor production -t lib/main_production.dart
flutter run  --release --flavor staging -t lib/main_staging.dart


flutter build apk  --release --flavor development -t lib/main_development.dart
flutter build apk  --release --flavor staging -t lib/main_staging.dart
flutter build apk  --release --flavor production -t lib/main_production.dart

flutter build appbundle  --release --flavor production -t lib/main_production.dart


#firebase analytics


#generate api route
python api_routes_gen.py

#App Link
xcrun simctl openurl booted https://<web domain>/details

# shellcheck disable=SC2164
cd android  ;  ./gradlew signingReport

flutter clean ; flutter pub get ; cd ios ; pod install --repo-update