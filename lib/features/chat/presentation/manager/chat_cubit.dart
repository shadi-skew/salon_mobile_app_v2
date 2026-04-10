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
        super(const ChatState());

  final ChatApiService _apiService;
  String? _sessionId;
  int _messageCounter = 0;

  String _nextId() => 'msg_${_messageCounter++}';

  /// Start conversation — sends first empty message to get AI greeting
  Future<void> startConversation() async {
    if (state.messages.isNotEmpty) return;

    emit(state.copyWith(isTyping: true));

    try {
      final response = await _apiService.sendMessage(
        SendMessageRequest(
          content: '',
          sessionId: _sessionId,
        ),
      );

      _sessionId = response.sessionId;

      final aiMsg = ChatMessage(
        id: _nextId(),
        isUser: false,
        type: ChatMessageType.text,
        text: response.content,
        imageUrl: response.imageUrl,
      );

      emit(state.copyWith(
        messages: [...state.messages, aiMsg],
        isTyping: false,
      ));
    } catch (e) {
      if (kDebugMode) debugPrint('Chat error: $e');
      emit(state.copyWith(isTyping: false, error: 'Failed to connect'));
    }
  }

  /// Send a text message
  Future<void> sendTextMessage(String text) async {
    if (text.trim().isEmpty) return;

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
        SendMessageRequest(
          content: text.trim(),
          sessionId: _sessionId,
        ),
      );

      _sessionId ??= response.sessionId;
      _addAiMessage(response);
    } catch (e) {
      if (kDebugMode) debugPrint('Chat error: $e');
      emit(state.copyWith(isTyping: false, error: 'Failed to send message'));
    }
  }

  /// Send an image (with optional text)
  Future<void> sendImage(String imagePath, {String? text}) async {
    final userMsg = ChatMessage(
      id: _nextId(),
      isUser: true,
      type: ChatMessageType.image,
      imagePath: imagePath,
      text: text,
    );

    emit(state.copyWith(
      messages: [...state.messages, userMsg],
      isTyping: true,
      error: null,
    ));

    try {
      final bytes = await File(imagePath).readAsBytes();
      final imageBase64 = base64Encode(bytes);

      final response = await _apiService.sendMessage(
        SendMessageRequest(
          content: text ?? '',
          sessionId: _sessionId,
          image: imageBase64,
        ),
      );

      _sessionId ??= response.sessionId;
      _addAiMessage(response);
    } catch (e) {
      if (kDebugMode) debugPrint('Chat error: $e');
      emit(state.copyWith(isTyping: false, error: 'Failed to send image'));
    }
  }

  /// Start a new conversation (reset session)
  void resetConversation() {
    _sessionId = null;
    _messageCounter = 0;
    emit(const ChatState());
  }

  /// Handle color selection — sends the chosen color name as a text message
  Future<void> selectHairColor({
    required String messageId,
    required HairColor color,
  }) async {
    // Mark the color message as selected (locks it)
    final updatedMessages = state.messages.map((msg) {
      if (msg.id == messageId) {
        return msg.copyWith(selectedColorName: color.name);
      }
      return msg;
    }).toList();

    emit(state.copyWith(messages: updatedMessages));

    // Send the selection as a text message to the backend
    await sendTextMessage(color.name);
  }

  void _addAiMessage(MessageResponse response) {
    final messages = <ChatMessage>[...state.messages];

    // Add text message
    if (response.content.isNotEmpty) {
      messages.add(ChatMessage(
        id: _nextId(),
        isUser: false,
        type: ChatMessageType.text,
        text: response.content,
      ));
    }

    // Add hair color options if present
    if (response.hairColors.isNotEmpty) {
      messages.add(ChatMessage(
        id: _nextId(),
        isUser: false,
        type: ChatMessageType.hairColors,
        hairColors: response.hairColors,
      ));
    }

    // Add generated image as separate message if present
    if (response.imageUrl != null) {
      messages.add(ChatMessage(
        id: _nextId(),
        isUser: false,
        type: ChatMessageType.image,
        imageUrl: response.imageUrl,
      ));
    }

    // If backend says image is being generated, show shimmer placeholder
    if (response.generatingImage) {
      emit(state.copyWith(
        messages: messages,
        isTyping: false,
        isGeneratingImage: true,
      ));
      _waitForGeneratedImage();
      return;
    }

    emit(state.copyWith(
      messages: messages,
      isTyping: false,
      isGeneratingImage: false,
    ));
  }

  /// Call the dedicated generate endpoint to produce the image
  Future<void> _waitForGeneratedImage() async {
    try {
      final response = await _apiService.generateImage(_sessionId!);

      final messages = <ChatMessage>[...state.messages];

      if (response.imageUrl != null) {
        messages.add(ChatMessage(
          id: _nextId(),
          isUser: false,
          type: ChatMessageType.image,
          imageUrl: response.imageUrl,
        ));
      }

      emit(state.copyWith(
        messages: messages,
        isGeneratingImage: false,
      ));
    } catch (e) {
      if (kDebugMode) debugPrint('Image generation error: $e');
      emit(state.copyWith(
        isGeneratingImage: false,
        error: 'Failed to generate image',
      ));
    }
  }
}
