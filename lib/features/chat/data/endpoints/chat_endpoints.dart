import 'package:salon_mobile_app_v2/core/config/app_config.dart';

class ChatEndpoints {
  ChatEndpoints._();

  static String get baseUrl => AppConfig.baseUrl;

  /// POST — send a message (creates session if session_id is null)
  static String get sendMessage => '$baseUrl/chat/send';

  /// GET — list all sessions
  static String get getSessions => '$baseUrl/chat/sessions';

  /// GET — get all messages for a session
  static String getSessionMessages(String sessionId) =>
      '$baseUrl/chat/sessions/$sessionId/messages';

  /// POST — trigger image generation for a session
  static String generateImage(String sessionId) =>
      '$baseUrl/chat/sessions/$sessionId/generate';
}
