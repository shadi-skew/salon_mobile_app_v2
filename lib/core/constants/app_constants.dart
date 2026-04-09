/// Application-wide constants
class AppConstants {
  AppConstants._();

  // Pagination
  static const int defaultPageSize = 20;
  static const int initialPage = 0;

  // API Timeouts
  static const Duration connectTimeout = Duration(seconds: 60);
  static const Duration receiveTimeout = Duration(seconds: 180);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);
}
