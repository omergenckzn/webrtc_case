import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/router/app_router.gr.dart';
import 'package:flutter/material.dart';

class AuthRedirector {
  factory AuthRedirector() {
    return _instance;
  }
  AuthRedirector._internal();
  static final AuthRedirector _instance = AuthRedirector._internal();
  late BuildContext _context;

  set context(BuildContext context) {
    _context = context;
  }

  void redirectToLogin() {
    _context.router.replace(const UsernameRoute());
  }
}
