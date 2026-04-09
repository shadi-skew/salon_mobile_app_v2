import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:salon_mobile_app_v2/core/errors/network_exceptions.dart';

/// Interceptor to handle and transform API errors
@singleton
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final networkException = NetworkExceptions.getException(err);

    final transformedError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: networkException,
      stackTrace: err.stackTrace,
    );

    super.onError(transformedError, handler);
  }
}
