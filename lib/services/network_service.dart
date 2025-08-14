import 'dart:async';
import 'package:dating_app/core/network/authorization_interceptor.dart';
import 'package:dating_app/flavors.dart';
import 'package:dating_app/services/logger_service.dart';
import 'package:dio/dio.dart';


class NetworkService {
  NetworkService(
    this._dio,
  ) {

    _dio.options.baseUrl = F.baseUrl;
    _dio.options.contentType = 'application/json';
    _dio.options.headers = {
    };
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);

    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.interceptors.add(AuthorizationInterceptor());
    _dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        responseHeader: false,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) async {
          handler.next(response);
        },
        onError: (DioException error, handler) {
          if (error.response != null) {
            handler.resolve(
              Response(
                requestOptions: error.requestOptions,
                statusCode: error.response!.statusCode,
                data: error.response!.data,
                headers: error.response!.headers,
                statusMessage: error.message,
              ),
            );
          } else {
            handler.next(error);
          }
        },
      ),
    );
  }

  final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      _logError(e);
      rethrow;
    }
  }

  Future<Response<T>> getWithoutToken<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final options = Options(
        extra: {
          'skipAuth': true,
        },
      );
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      _logError(e);
      rethrow;
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(path, data: data, options: options);
    } on DioException catch (e) {
      _logError(e);
      rethrow;
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(path, data: data, options: options);
    } on DioException catch (e) {
      _logError(e);
      rethrow;
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(path, data: data, options: options);
    } on DioException catch (e) {
      _logError(e);
      rethrow;
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      return await _dio.patch<T>(path, data: data, options: options);
    } on DioException catch (e) {
      _logError(e);
      rethrow;
    }
  }

  void _logError(DioException error) {
    LoggerService.logError(
      'DioError: ${error.message}',
    );
    if (error.response != null) {
      LoggerService.logError('DioError Response: ${error.response?.data}');
    }
  }
}
