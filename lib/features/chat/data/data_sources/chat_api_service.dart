import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:salon_mobile_app_v2/core/api/api_consumer.dart';
import 'package:salon_mobile_app_v2/features/chat/data/endpoints/chat_endpoints.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';

abstract class ChatApiService {
  Future<MessageResponse> sendMessage(SendMessageRequest request);
  Future<MessageResponse> generateImage(String sessionId);
  Future<List<SessionResponse>> getSessions();
  Future<List<MessageResponse>> getSessionMessages(String sessionId);
}

class RemoteChatApiService implements ChatApiService {
  final ApiConsumer _apiConsumer;

  RemoteChatApiService(this._apiConsumer);

  @override
  Future<MessageResponse> sendMessage(SendMessageRequest request) async {
    // Backend expects Form data (not JSON)
    final formMap = <String, dynamic>{
      'content': request.content,
    };

    if (request.sessionId != null) {
      formMap['session_id'] = request.sessionId;
    }

    if (request.image != null) {
      final bytes = base64Decode(request.image!);
      formMap['image'] = MultipartFile.fromBytes(
        bytes,
        filename: 'photo.jpg',
      );
    }

    final formData = FormData.fromMap(formMap);

    final response = await _apiConsumer.post(
      ChatEndpoints.sendMessage,
      formData: formData,
    );

    return MessageResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<MessageResponse> generateImage(String sessionId) async {
    final response = await _apiConsumer.post(
      ChatEndpoints.generateImage(sessionId),
    );
    return MessageResponse.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<List<SessionResponse>> getSessions() async {
    final response = await _apiConsumer.get(ChatEndpoints.getSessions);
    return (response as List)
        .map((json) => SessionResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<MessageResponse>> getSessionMessages(String sessionId) async {
    final response = await _apiConsumer.get(
      ChatEndpoints.getSessionMessages(sessionId),
    );
    return (response as List)
        .map((json) => MessageResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
