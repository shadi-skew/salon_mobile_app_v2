import 'package:salon_mobile_app_v2/core/config/app_config.dart';

/// Base endpoints class
/// For better organization, create feature-specific endpoint classes
/// in each feature's data/endpoints folder
class Endpoints {
  Endpoints._();

  static String get baseUrl => AppConfig.baseUrl;
}
