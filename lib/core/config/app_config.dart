/// Application configuration class.
/// Values are injected at build time via --dart-define-from-file=dart_defines.json
class AppConfig {
  AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://3.234.189.178:5001',
  );

  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static const String apiTimeout = String.fromEnvironment(
    'API_TIMEOUT',
    defaultValue: '30',
  );

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';

  static Duration get timeoutDuration =>
      Duration(seconds: int.tryParse(apiTimeout) ?? 30);

  /// Whether to use mock API data.
  /// Set "USE_MOCK_API": "true" in dart_defines.json to enable.
  static bool get useMockApi {
    const envValue = String.fromEnvironment('USE_MOCK_API');
    if (envValue.isNotEmpty) return envValue.toLowerCase() == 'true';
    return isDevelopment;
  }
}
