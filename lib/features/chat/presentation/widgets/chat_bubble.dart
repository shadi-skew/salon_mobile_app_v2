import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salon_mobile_app_v2/core/resources/color_manager.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.type == ChatMessageType.image) {
      return _ImageBubble(message: message);
    }
    return _TextBubble(message: message);
  }
}

class _TextBubble extends StatelessWidget {
  const _TextBubble({required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? 64 : 12,
        right: isUser ? 16 : 64,
        bottom: 6,
        top: 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // AI avatar
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8, bottom: 2),
              decoration: const BoxDecoration(
                color: Color(0xFF0F6A6A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
          // Bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color(0xFF0F6A6A)
                    : const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 6),
                  bottomRight: Radius.circular(isUser ? 6 : 20),
                ),
              ),
              child: Text(
                message.text ?? '',
                style: TextStyle(
                  color: isUser ? Colors.white : ColorManager.blackTitle,
                  fontSize: 15,
                  height: 1.45,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageBubble extends StatelessWidget {
  const _ImageBubble({required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: EdgeInsets.only(
        left: isUser ? 64 : 12,
        right: isUser ? 16 : 64,
        bottom: 6,
        top: 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // AI avatar for non-user images
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8, bottom: 2),
              decoration: const BoxDecoration(
                color: Color(0xFF0F6A6A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _buildImage(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    // Network image (AI-generated from S3)
    if (message.isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: message.imageUrl!,
        fit: BoxFit.cover,
        height: 280,
        width: double.infinity,
        placeholder: (context, url) => Container(
          height: 280,
          color: Colors.grey.shade100,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Color(0xFF0F6A6A),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: 280,
          color: Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image_outlined,
                  size: 40, color: Colors.grey.shade400),
              const SizedBox(height: 8),
              Text(
                'Failed to load image',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    // Local image (user-uploaded)
    if (message.isLocalImage) {
      return Image.file(
        File(message.imagePath!),
        fit: BoxFit.cover,
        height: 220,
        width: double.infinity,
      );
    }

    // Fallback
    return Container(
      height: 220,
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 40, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            'Photo sent',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
