import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interceptor to automatically add Authorization header with Bearer token
/// Expand this as you add authentication to your app
@singleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const String _tokenKey = 'access_token';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Skip adding token for authentication endpoints
      final path = options.uri.path;
      final isAuthEndpoint = path.contains('/auth/login') ||
          path.contains('/auth/register');

      if (isAuthEndpoint) {
        if (kDebugMode) {
          debugPrint('AuthInterceptor: Skipping token for auth endpoint: $path');
        }
        handler.next(options);
        return;
      }

      // Get the access token from storage
      final token = _sharedPreferences.getString(_tokenKey);

      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          debugPrint('AuthInterceptor: No token found for $path');
        }
        handler.next(options);
        return;
      }

      options.headers['Authorization'] = 'Bearer $token';

      if (kDebugMode) {
        debugPrint('AuthInterceptor: Added Bearer token to $path');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AuthInterceptor error: $e');
      }
    }

    handler.next(options);
  }
}
