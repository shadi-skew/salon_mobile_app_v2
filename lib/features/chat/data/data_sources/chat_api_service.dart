import 'dart:math';
import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';

// ============================================================
// Abstract API service — swap the implementation for real backend
// ============================================================

abstract class ChatApiService {
  Future<ChatApiResponse> sendMessage(ChatApiRequest request);
}

// ============================================================
// Mock implementation — simulates the full conversation flow
//
// TO SWITCH TO REAL BACKEND:
//   1. Create RemoteChatApiService that implements ChatApiService
//   2. Use Dio/ApiConsumer to POST to your endpoint
//   3. Change the DI registration in injection.dart or chat_cubit.dart
//   4. The rest of the app (cubit, UI) stays the same
// ============================================================

class MockChatApiService implements ChatApiService {
  final Map<String, _ConversationContext> _sessions = {};

  @override
  Future<ChatApiResponse> sendMessage(ChatApiRequest request) async {
    // Simulate network delay
    await Future.delayed(
      Duration(milliseconds: 1000 + Random().nextInt(1500)),
    );

    final ctx = _sessions.putIfAbsent(
      request.sessionId,
      () => _ConversationContext(),
    );

    final List<ChatResponseMessage> responses = [];

    // Handle option selections
    if (request.selectedOptionId != null) {
      return _handleOptionSelection(ctx, request);
    }

    // Handle image upload
    if (request.imageBase64 != null) {
      ctx.hasPhoto = true;
    }

    final msg = (request.message ?? '').toLowerCase();

    switch (ctx.phase) {
      case _Phase.initial:
        ctx.phase = _Phase.intentAsked;
        responses.add(const ChatResponseMessage(
          type: 'text',
          text:
              "Hello! 👋 Welcome to the Salon.\n\nHow can I help you today? Would you like to:\n\n• Change your hairstyle\n• Get a color formula\n• Both",
        ));
        break;

      case _Phase.intentAsked:
        if (_containsBoth(msg)) {
          ctx.intent = 'both';
          ctx.phase = _Phase.hairstylePhotoAsked;
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "Great, let's start with your hairstyle first! 💇‍♀️\n\nCould you share a photo of your current hair? This will help me give better recommendations.",
          ));
        } else if (_containsHairstyle(msg)) {
          ctx.intent = 'hairstyle';
          ctx.phase = _Phase.hairstylePhotoAsked;
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "I'd love to help you find a new hairstyle! 💇‍♀️\n\nCould you share a photo of your current hair? This will help me give better recommendations.",
          ));
        } else if (_containsColor(msg)) {
          ctx.intent = 'color';
          ctx.phase = _Phase.colorPhotoAsked;
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "Let's find the perfect color for you! 🎨\n\nCould you share a photo of your current hair color?",
          ));
        } else {
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "I'd be happy to help! Could you let me know if you'd like to change your hairstyle, get a color formula, or both?",
          ));
        }
        break;

      case _Phase.hairstylePhotoAsked:
        if (ctx.hasPhoto) {
          ctx.phase = _Phase.hairstyleOptionsShown;
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "Thanks for sharing! I can see your current look. ✨\n\nHere are some hairstyle options that would work great for you:",
          ));
          responses.add(ChatResponseMessage(
            type: 'hairstyle_options',
            hairstyleOptions: _hairstyleOptions,
          ));
        } else if (_isRefusal(msg)) {
          ctx.phase = _Phase.hairstyleGenderAsked;
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "No worries at all! 😊 Let me ask a few questions instead.\n\nWhat's your gender?",
          ));
        } else {
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "Could you share a photo of your current hair? Or if you prefer not to, just let me know and I'll ask some questions instead.",
          ));
        }
        break;

      case _Phase.hairstyleGenderAsked:
        ctx.gender = msg;
        ctx.phase = _Phase.hairstyleLengthAsked;
        responses.add(const ChatResponseMessage(
          type: 'text',
          text:
              "Got it! And what's your current hair length?\n\n• Short\n• Medium\n• Long",
        ));
        break;

      case _Phase.hairstyleLengthAsked:
        ctx.hairLength = msg;
        ctx.phase = _Phase.hairstyleOptionsShown;
        responses.add(const ChatResponseMessage(
          type: 'text',
          text:
              "Perfect! Based on what you've told me, here are some hairstyle options I'd recommend for you: ✨",
        ));
        responses.add(ChatResponseMessage(
          type: 'hairstyle_options',
          hairstyleOptions: _hairstyleOptions,
        ));
        break;

      case _Phase.hairstyleOptionsShown:
        responses.add(const ChatResponseMessage(
          type: 'text',
          text: "Please tap on one of the hairstyle options above to select it! 👆",
        ));
        break;

      case _Phase.colorPhotoAsked:
        if (ctx.hasPhoto) {
          ctx.phase = _Phase.colorCurrentShown;
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "Thanks! I can see your current hair color. 🎨\n\nTo confirm, please select your current hair color level:",
          ));
          responses.add(ChatResponseMessage(
            type: 'color_options',
            colorOptions: _colorOptions,
          ));
        } else if (_isRefusal(msg)) {
          ctx.phase = _Phase.colorCurrentShown;
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "No problem! 😊 Please select your current hair color level:",
          ));
          responses.add(ChatResponseMessage(
            type: 'color_options',
            colorOptions: _colorOptions,
          ));
        } else {
          responses.add(const ChatResponseMessage(
            type: 'text',
            text:
                "Could you share a photo of your current hair? Or if you prefer not to, just let me know!",
          ));
        }
        break;

      case _Phase.colorCurrentShown:
        responses.add(const ChatResponseMessage(
          type: 'text',
          text: "Please tap on your current hair color level above! 👆",
        ));
        break;

      case _Phase.colorTargetShown:
        responses.add(const ChatResponseMessage(
          type: 'text',
          text: "Please select your desired target color above! 👆",
        ));
        break;

      case _Phase.complete:
        responses.add(const ChatResponseMessage(
          type: 'text',
          text:
              "Is there anything else I can help you with? You can ask about hairstyles, color formulas, or both! 😊",
        ));
        ctx.phase = _Phase.intentAsked;
        break;

    }

    return ChatApiResponse(sessionId: request.sessionId, messages: responses);
  }

  Future<ChatApiResponse> _handleOptionSelection(
    _ConversationContext ctx,
    ChatApiRequest request,
  ) async {
    final List<ChatResponseMessage> responses = [];

    if (request.selectedOptionType == 'hairstyle') {
      final selected = _hairstyleOptions.firstWhere(
        (o) => o.id == request.selectedOptionId,
        orElse: () => _hairstyleOptions.first,
      );

      responses.add(ChatResponseMessage(
        type: 'text',
        text:
            "Excellent choice! 🌟 The ${selected.name} style will look amazing on you!\n\n${selected.description} — a perfect look!",
      ));

      if (ctx.intent == 'both') {
        ctx.phase = _Phase.colorCurrentShown;
        responses.add(const ChatResponseMessage(
          type: 'text',
          text:
              "Now let's work on your color! 🎨\n\nPlease select your current hair color level:",
        ));
        responses.add(ChatResponseMessage(
          type: 'color_options',
          colorOptions: _colorOptions,
        ));
      } else {
        responses.add(const ChatResponseMessage(
          type: 'text',
          text:
              "Would you also like a color formula recommendation? Just say \"color\" if you do! 😊",
        ));
        ctx.phase = _Phase.complete;
      }
    } else if (request.selectedOptionType == 'color') {
      final selected = _colorOptions.firstWhere(
        (o) => o.id == request.selectedOptionId,
        orElse: () => _colorOptions.first,
      );

      if (ctx.currentColorLevel == null) {
        // Selecting current color
        ctx.currentColorLevel = selected.name;
        ctx.currentColorLevelNum = selected.level;
        ctx.phase = _Phase.colorTargetShown;

        responses.add(ChatResponseMessage(
          type: 'text',
          text:
              "Got it! You're currently at Level ${selected.level} (${selected.name}). 👍\n\nNow, what color would you like to achieve? Select your target:",
        ));
        responses.add(ChatResponseMessage(
          type: 'color_options',
          colorOptions: _colorOptions,
        ));
      } else {
        // Selecting target color
        ctx.phase = _Phase.complete;

        final developer =
            selected.level > ctx.currentColorLevelNum! ? '20 vol' : '30 vol';
        final processingTime =
            (selected.level - ctx.currentColorLevelNum!).abs() * 5 + 25;

        responses.add(ChatResponseMessage(
          type: 'text',
          text:
              "Great choice! 🎨 Here's your recommended color formula:\n\n"
              "━━━━━━━━━━━━━━━━━\n"
              "📋 COLOR FORMULA\n"
              "━━━━━━━━━━━━━━━━━\n\n"
              "From: Level ${ctx.currentColorLevelNum} (${ctx.currentColorLevel})\n"
              "To: Level ${selected.level} (${selected.name})\n\n"
              "• Developer: $developer\n"
              "• Toner: ${selected.name} ${selected.level}.1\n"
              "• Processing time: $processingTime–${processingTime + 5} minutes\n\n"
              "⚠️ Please consult with your professional stylist for the best results!",
        ));

        responses.add(const ChatResponseMessage(
          type: 'text',
          text:
              "Is there anything else I can help you with? 😊",
        ));
      }
    }

    return ChatApiResponse(sessionId: request.sessionId, messages: responses);
  }

  // ---- Keyword helpers ----

  bool _containsHairstyle(String msg) =>
      msg.contains('hairstyle') ||
      msg.contains('hair style') ||
      msg.contains('haircut') ||
      msg.contains('style') ||
      msg.contains('cut');

  bool _containsColor(String msg) =>
      msg.contains('color') ||
      msg.contains('colour') ||
      msg.contains('dye') ||
      msg.contains('formula');

  bool _containsBoth(String msg) => msg.contains('both');

  bool _isRefusal(String msg) =>
      msg.contains('no') ||
      msg.contains("can't") ||
      msg.contains('dont') ||
      msg.contains("don't") ||
      msg.contains('without') ||
      msg.contains('skip') ||
      msg.contains('prefer not') ||
      msg.contains('rather not');

  // ---- Mock data ----

  static final List<HairstyleOptionData> _hairstyleOptions = [
    const HairstyleOptionData(
      id: 'hs_1',
      name: 'Beach Waves',
      tag: 'Casual',
      description: 'Effortless, natural waves',
      backgroundColor: Color(0xFFF5C6D0),
    ),
    const HairstyleOptionData(
      id: 'hs_2',
      name: 'Long Layered',
      tag: 'Modern',
      description: 'Soft layers with movement',
      backgroundColor: Color(0xFFB8A0D0),
    ),
    const HairstyleOptionData(
      id: 'hs_3',
      name: 'Pixie Cut',
      tag: 'Short',
      description: 'Low maintenance, chic',
      backgroundColor: Color(0xFFC4B8D8),
    ),
    const HairstyleOptionData(
      id: 'hs_4',
      name: 'Curly Voluminous',
      tag: 'Bold',
      description: 'Full-bodied curls',
      backgroundColor: Color(0xFFB8A0D0),
    ),
  ];

  static final List<ColorOptionData> _colorOptions = [
    const ColorOptionData(id: 'cl_1', level: 1, name: 'Black', color: Color(0xFF000000)),
    const ColorOptionData(id: 'cl_2', level: 2, name: 'Darkest Brown', color: Color(0xFF1A0F00)),
    const ColorOptionData(id: 'cl_3', level: 3, name: 'Dark Brown', color: Color(0xFF3D2200)),
    const ColorOptionData(id: 'cl_4', level: 4, name: 'Medium Brown', color: Color(0xFF6B4423)),
    const ColorOptionData(id: 'cl_5', level: 5, name: 'Light Brown', color: Color(0xFF8B6914)),
    const ColorOptionData(id: 'cl_6', level: 6, name: 'Dark Blonde', color: Color(0xFFA67C52)),
    const ColorOptionData(id: 'cl_7', level: 7, name: 'Medium Blonde', color: Color(0xFFC4A265)),
    const ColorOptionData(id: 'cl_8', level: 8, name: 'Light Blonde', color: Color(0xFFD4B87A)),
    const ColorOptionData(id: 'cl_9', level: 9, name: 'Very Light Blonde', color: Color(0xFFE8D5A3)),
    const ColorOptionData(id: 'cl_10', level: 10, name: 'Lightest Blonde', color: Color(0xFFF5E6C8)),
  ];
}

// ---- Conversation state machine ----

enum _Phase {
  initial,
  intentAsked,
  hairstylePhotoAsked,
  hairstyleGenderAsked,
  hairstyleLengthAsked,
  hairstyleOptionsShown,
  colorPhotoAsked,
  colorCurrentShown,
  colorTargetShown,
  complete,
}

class _ConversationContext {
  _Phase phase = _Phase.initial;
  String? intent; // hairstyle, color, both
  bool hasPhoto = false;
  String? gender;
  String? hairLength;
  String? currentColorLevel;
  int? currentColorLevelNum;
}
