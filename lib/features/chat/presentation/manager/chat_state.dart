import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final bool isGeneratingImage;
  final String? error;

  const ChatState({
    this.messages = const [],
    this.isTyping = false,
    this.isGeneratingImage = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
    bool? isGeneratingImage,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      isGeneratingImage: isGeneratingImage ?? this.isGeneratingImage,
      error: error,
    );
  }
}
