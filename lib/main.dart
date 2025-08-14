import 'package:dating_app/core/init/app_init.dart';
import 'package:dating_app/dating_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await AppInit.init();
  await dotenv.load(fileName: '.env');
  runApp(DatingApp());
}
