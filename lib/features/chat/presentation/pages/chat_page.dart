import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/manager/chat_cubit.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/manager/chat_state.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/color_options_widget.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/hairstyle_options_widget.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/typing_indicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatCubit>().startConversation();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F6A6A), Color(0xFF1A8A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salon Assistant',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            height: 0.5,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) => _scrollToBottom(),
        builder: (context, state) {
          return Column(
            children: [
              // Date header
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // Messages list
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  itemCount:
                      state.messages.length + (state.isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.messages.length && state.isTyping) {
                      return const TypingIndicator();
                    }
                    return _buildMessageWidget(context, state.messages[index]);
                  },
                ),
              ),

              // Input
              ChatInputField(
                enabled: !state.isTyping,
                onSendText: (text) =>
                    context.read<ChatCubit>().sendTextMessage(text),
                onSendImage: (path) =>
                    context.read<ChatCubit>().sendImage(path),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageWidget(BuildContext context, ChatMessage message) {
    switch (message.type) {
      case ChatMessageType.text:
      case ChatMessageType.image:
        return ChatBubble(message: message);

      case ChatMessageType.hairstyleOptions:
        return HairstyleOptionsWidget(
          options: message.hairstyleOptions ?? [],
          selectedOptionId: message.selectedOptionId,
          onSelected: (optionId) {
            context.read<ChatCubit>().selectOption(
                  messageId: message.id,
                  optionId: optionId,
                  optionType: 'hairstyle',
                );
          },
        );

      case ChatMessageType.colorOptions:
        return ColorOptionsWidget(
          options: message.colorOptions ?? [],
          selectedOptionId: message.selectedOptionId,
          onSelected: (optionId) {
            context.read<ChatCubit>().selectOption(
                  messageId: message.id,
                  optionId: optionId,
                  optionType: 'color',
                );
          },
        );
    }
  }
}
