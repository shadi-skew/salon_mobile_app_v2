import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_mobile_app_v2/features/chat/data/models/chat_models.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/manager/chat_cubit.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/manager/chat_state.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/hair_color_options_widget.dart';
import 'package:salon_mobile_app_v2/features/chat/presentation/widgets/image_generating_shimmer.dart';
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
      backgroundColor: const Color(0xFFF6FCFC),
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF34ACB7), Color(0xFF5CC4CD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF34ACB7).withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Salon Assistant',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: const Color(0xFF34C759),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF34C759).withValues(alpha: 0.4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF34C759),
                      ),
                    ),
                  ],
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
            color: Colors.grey.shade100,
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
                      color: const Color(0xFF34ACB7).withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF34ACB7),
                        fontWeight: FontWeight.w600,
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
                  itemCount: state.messages.length +
                      (state.isTyping || state.isGeneratingImage ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Trailing indicator slot
                    if (index == state.messages.length) {
                      if (state.isGeneratingImage) {
                        return const ImageGeneratingShimmer();
                      }
                      return const TypingIndicator();
                    }
                    final message = state.messages[index];
                    if (message.type == ChatMessageType.hairColors) {
                      return HairColorOptionsWidget(
                        colors: message.hairColors ?? [],
                        selectedColorName: message.selectedColorName,
                        onSelected: (color) {
                          context.read<ChatCubit>().selectHairColor(
                                messageId: message.id,
                                color: color,
                              );
                        },
                      );
                    }
                    return ChatBubble(message: message);
                  },
                ),
              ),

              // Error banner
              if (state.error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: Colors.red.shade50,
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          size: 16, color: Colors.red.shade400),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.error!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context
                            .read<ChatCubit>()
                            .emit(state.copyWith(error: null)),
                        child: Icon(Icons.close,
                            size: 16, color: Colors.red.shade400),
                      ),
                    ],
                  ),
                ),

              // Input
              ChatInputField(
                enabled: !state.isTyping && !state.isGeneratingImage,
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
}
