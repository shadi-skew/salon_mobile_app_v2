import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/features/chat/data/data_sources/chat_api_service.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/manager/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required ChatApiService apiService})
      : _apiService = apiService,
        _sessionId = DateTime.now().millisecondsSinceEpoch.toString(),
        super(const ChatState());

  final ChatApiService _apiService;
  final String _sessionId;
  int _messageCounter = 0;

  String _nextId() => 'msg_${_messageCounter++}';

  /// Start conversation — called when chat page opens
  Future<void> startConversation() async {
    if (state.messages.isNotEmpty) return; // Already started

    emit(state.copyWith(isTyping: true));

    try {
      final response = await _apiService.sendMessage(
        ChatApiRequest(sessionId: _sessionId, message: ''),
      );
      _addAiMessages(response.messages);
    } catch (e) {
      if (kDebugMode) debugPrint('Chat error: $e');
      emit(state.copyWith(isTyping: false, error: 'Failed to connect'));
    }
  }

  /// Send a text message
  Future<void> sendTextMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMsg = ChatMessage(
      id: _nextId(),
      isUser: true,
      type: ChatMessageType.text,
      text: text.trim(),
    );

    emit(state.copyWith(
      messages: [...state.messages, userMsg],
      isTyping: true,
      error: null,
    ));

    try {
      final response = await _apiService.sendMessage(
        ChatApiRequest(sessionId: _sessionId, message: text.trim()),
      );
      _addAiMessages(response.messages);
    } catch (e) {
      if (kDebugMode) debugPrint('Chat error: $e');
      emit(state.copyWith(isTyping: false, error: 'Failed to send message'));
    }
  }

  /// Send an image
  Future<void> sendImage(String imagePath) async {
    // Add user image message
    final userMsg = ChatMessage(
      id: _nextId(),
      isUser: true,
      type: ChatMessageType.image,
      imagePath: imagePath,
    );

    emit(state.copyWith(
      messages: [...state.messages, userMsg],
      isTyping: true,
      error: null,
    ));

    try {
      // Convert image to base64 for API
      String? imageBase64;
      try {
        final bytes = await File(imagePath).readAsBytes();
        imageBase64 = base64Encode(bytes);
      } catch (_) {
        imageBase64 = 'mock_image_data';
      }

      final response = await _apiService.sendMessage(
        ChatApiRequest(
          sessionId: _sessionId,
          imageBase64: imageBase64,
        ),
      );
      _addAiMessages(response.messages);
    } catch (e) {
      if (kDebugMode) debugPrint('Chat error: $e');
      emit(state.copyWith(isTyping: false, error: 'Failed to send image'));
    }
  }

  /// Handle option selection (hairstyle or color card tapped)
  Future<void> selectOption({
    required String messageId,
    required String optionId,
    required String optionType,
  }) async {
    // Update the message with the selected option
    final updatedMessages = state.messages.map((msg) {
      if (msg.id == messageId) {
        return msg.copyWith(selectedOptionId: optionId);
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updatedMessages, isTyping: true));

    try {
      final response = await _apiService.sendMessage(
        ChatApiRequest(
          sessionId: _sessionId,
          selectedOptionId: optionId,
          selectedOptionType: optionType,
        ),
      );
      _addAiMessages(response.messages);
    } catch (e) {
      if (kDebugMode) debugPrint('Chat error: $e');
      emit(state.copyWith(isTyping: false, error: 'Failed to process selection'));
    }
  }

  /// Convert API response messages to ChatMessages and add them
  void _addAiMessages(List<ChatResponseMessage> responseMessages) {
    final newMessages = <ChatMessage>[];

    for (final rm in responseMessages) {
      switch (rm.type) {
        case 'text':
          newMessages.add(ChatMessage(
            id: _nextId(),
            isUser: false,
            type: ChatMessageType.text,
            text: rm.text,
          ));
          break;
        case 'hairstyle_options':
          newMessages.add(ChatMessage(
            id: _nextId(),
            isUser: false,
            type: ChatMessageType.hairstyleOptions,
            hairstyleOptions: rm.hairstyleOptions,
          ));
          break;
        case 'color_options':
          newMessages.add(ChatMessage(
            id: _nextId(),
            isUser: false,
            type: ChatMessageType.colorOptions,
            colorOptions: rm.colorOptions,
          ));
          break;
      }
    }

    emit(state.copyWith(
      messages: [...state.messages, ...newMessages],
      isTyping: false,
    ));
  }
}
