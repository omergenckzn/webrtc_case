import 'package:dating_app/core/enums/status.dart';

class ApiResponse<T> {
  ApiResponse({
    required this.status,
    this.message,
    this.data,
  });

  factory ApiResponse.error(String message) {
    return ApiResponse<T>(
      status: Status.error,
      message: message,
    );
  }
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? fromJsonT,
  ) {
    final resp = json['response'] as Map<String, dynamic>;
    final code = resp['code'] as int;
    final msg = resp['message'] as String?;

    final status = code == 200 ? Status.success : Status.failure;

    return ApiResponse<T>(
      status: status,
      message: msg,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
  final Status status;
  final String? message;
  final T? data;
}
