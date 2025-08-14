// lib/features/splash/presentation/splash_view.dart
import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/core/router/app_router.gr.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.router.replaceAll([const UsernameRoute()]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(

        ),
      ),
    );
  }
}
