import 'dart:io';

// ============================================================
// API Request / Response — matches backend POST /chat/send
// Backend expects multipart/form-data (not JSON)
// ============================================================

class SendMessageRequest {
  final String content;
  final String? sessionId;
  final String? image; // base64-encoded image

  const SendMessageRequest({
    required this.content,
    this.sessionId,
    this.image,
  });
}

class HairColor {
  final int level;
  final String hex;
  final String name;

  const HairColor({
    required this.level,
    required this.hex,
    required this.name,
  });

  factory HairColor.fromJson(Map<String, dynamic> json) {
    return HairColor(
      level: json['level'] as int,
      hex: json['hex'] as String,
      name: json['name'] as String,
    );
  }
}

class MessageResponse {
  final String sessionId;
  final String content;
  final String? imageUrl;
  final List<HairColor> hairColors;
  final bool generatingImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MessageResponse({
    required this.sessionId,
    required this.content,
    this.imageUrl,
    this.hairColors = const [],
    this.generatingImage = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      sessionId: json['session_id'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String?,
      hairColors: (json['hair_colors'] as List?)
              ?.map((c) => HairColor.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      generatingImage: json['generating_image'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class SessionResponse {
  final String id;
  final String? title;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SessionResponse({
    required this.id,
    this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      id: json['id'] as String,
      title: json['title'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

// ============================================================
// Local UI chat message model
// ============================================================

enum ChatMessageType { text, image, hairColors }

class ChatMessage {
  final String id;
  final bool isUser;
  final ChatMessageType type;
  final String? text;
  final String? imagePath; // local file path (user-uploaded)
  final String? imageUrl; // network URL (AI-generated from S3)
  final List<HairColor>? hairColors;
  final String? selectedColorName; // set after user taps a color
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.isUser,
    required this.type,
    this.text,
    this.imagePath,
    this.imageUrl,
    this.hairColors,
    this.selectedColorName,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  bool get hasImage =>
      (imagePath != null && File(imagePath!).existsSync()) || imageUrl != null;

  bool get isNetworkImage => imageUrl != null;
  bool get isLocalImage => imagePath != null && File(imagePath!).existsSync();

  ChatMessage copyWith({String? selectedColorName}) {
    return ChatMessage(
      id: id,
      isUser: isUser,
      type: type,
      text: text,
      imagePath: imagePath,
      imageUrl: imageUrl,
      hairColors: hairColors,
      selectedColorName: selectedColorName ?? this.selectedColorName,
      timestamp: timestamp,
    );
  }
}
