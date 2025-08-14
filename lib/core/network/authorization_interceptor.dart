import 'package:dating_app/core/network/auth_redirector.dart';
import 'package:dating_app/services/token_service.dart';
import 'package:dio/dio.dart';
import 'package:dating_app/locator.dart' as di;

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor();

  final TokenService _tokenService = di.getIt<TokenService>();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['skipAuth'] == true) {
      return handler.next(options);
    }

    final token = await _tokenService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {

    super.onError(err, handler);
  }
}
