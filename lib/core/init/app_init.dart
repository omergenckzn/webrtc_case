
import 'dart:io';

import 'package:dating_app/flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:dating_app/locator.dart' as di;

abstract class AppInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    di.setup();
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: F.firebaseOptions,
        name: Platform.isIOS ? null : 'primary',
      );
    }
  }
}
