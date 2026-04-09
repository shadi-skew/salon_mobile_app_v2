import 'package:flutter/material.dart';

// ============================================================
// API Request / Response models
// When the backend is ready, these map directly to the JSON contract.
// ============================================================

class ChatApiRequest {
  final String sessionId;
  final String? message;
  final String? imageBase64;
  final String? selectedOptionId;
  final String? selectedOptionType; // "hairstyle" or "color"

  const ChatApiRequest({
    required this.sessionId,
    this.message,
    this.imageBase64,
    this.selectedOptionId,
    this.selectedOptionType,
  });

  Map<String, dynamic> toJson() => {
        'session_id': sessionId,
        'message': message,
        'image': imageBase64,
        'selected_option_id': selectedOptionId,
        'selected_option_type': selectedOptionType,
      };
}

class ChatApiResponse {
  final String sessionId;
  final List<ChatResponseMessage> messages;

  const ChatApiResponse({
    required this.sessionId,
    required this.messages,
  });

  factory ChatApiResponse.fromJson(Map<String, dynamic> json) {
    return ChatApiResponse(
      sessionId: json['session_id'] as String,
      messages: (json['messages'] as List)
          .map((m) => ChatResponseMessage.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ChatResponseMessage {
  final String type; // "text", "hairstyle_options", "color_options"
  final String? text;
  final List<HairstyleOptionData>? hairstyleOptions;
  final List<ColorOptionData>? colorOptions;

  const ChatResponseMessage({
    required this.type,
    this.text,
    this.hairstyleOptions,
    this.colorOptions,
  });

  factory ChatResponseMessage.fromJson(Map<String, dynamic> json) {
    return ChatResponseMessage(
      type: json['type'] as String,
      text: json['text'] as String?,
      hairstyleOptions: json['hairstyle_options'] != null
          ? (json['hairstyle_options'] as List)
              .map((o) =>
                  HairstyleOptionData.fromJson(o as Map<String, dynamic>))
              .toList()
          : null,
      colorOptions: json['color_options'] != null
          ? (json['color_options'] as List)
              .map(
                  (o) => ColorOptionData.fromJson(o as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

// ============================================================
// Hairstyle / Color option data
// ============================================================

class HairstyleOptionData {
  final String id;
  final String name;
  final String tag;
  final String description;
  final String? imageUrl;
  final Color backgroundColor;

  const HairstyleOptionData({
    required this.id,
    required this.name,
    required this.tag,
    required this.description,
    this.imageUrl,
    required this.backgroundColor,
  });

  factory HairstyleOptionData.fromJson(Map<String, dynamic> json) {
    return HairstyleOptionData(
      id: json['id'] as String,
      name: json['name'] as String,
      tag: json['tag'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String?,
      backgroundColor: Color(
        int.parse((json['background_color'] as String).replaceFirst('#', '0xFF')),
      ),
    );
  }
}

class ColorOptionData {
  final String id;
  final int level;
  final String name;
  final Color color;

  const ColorOptionData({
    required this.id,
    required this.level,
    required this.name,
    required this.color,
  });

  factory ColorOptionData.fromJson(Map<String, dynamic> json) {
    return ColorOptionData(
      id: json['id'] as String,
      level: json['level'] as int,
      name: json['name'] as String,
      color: Color(
        int.parse((json['color'] as String).replaceFirst('#', '0xFF')),
      ),
    );
  }
}

// ============================================================
// Local UI chat message model
// ============================================================

enum ChatMessageType { text, image, hairstyleOptions, colorOptions }

class ChatMessage {
  final String id;
  final bool isUser;
  final ChatMessageType type;
  final String? text;
  final String? imagePath;
  final List<HairstyleOptionData>? hairstyleOptions;
  final List<ColorOptionData>? colorOptions;
  final DateTime timestamp;
  String? selectedOptionId;

  ChatMessage({
    required this.id,
    required this.isUser,
    required this.type,
    this.text,
    this.imagePath,
    this.hairstyleOptions,
    this.colorOptions,
    this.selectedOptionId,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  ChatMessage copyWith({String? selectedOptionId}) {
    return ChatMessage(
      id: id,
      isUser: isUser,
      type: type,
      text: text,
      imagePath: imagePath,
      hairstyleOptions: hairstyleOptions,
      colorOptions: colorOptions,
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
      timestamp: timestamp,
    );
  }
}
