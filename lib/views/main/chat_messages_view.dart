import 'package:amommy/models/chat_message_model.dart';
import 'package:amommy/views/main/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessagesView extends ConsumerWidget {
  const ChatMessagesView({
    super.key,
    this.isFocused = false,
    required this.chats,
  });
  final bool isFocused;
  final List<ChatMessageModel> chats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(
          top: 120.0,
          bottom: 12.0,
          left: 24.0,
          right: 24.0,
        ),
        itemCount: chats.length,
        itemBuilder: (ctx, index) {
          final chatMessage = chats[index];
          final nextChatMessage =
              index + 1 < chats.length ? chats[index + 1] : null;
          final currentMessageIsMe = chatMessage.isMe;
          final nextMessageUserIsMe = nextChatMessage?.isMe;
          final nextUserIsSame = currentMessageIsMe == nextMessageUserIsMe;

          if (nextUserIsSame) {
            return MessageBubble.next(
              isMe: chatMessage.isMe,
              message: chatMessage.message,
              createdAt: chatMessage.created,
              imagePath: chatMessage.imagePath,
            );
          } else {
            return MessageBubble.first(
              isMe: chatMessage.isMe,
              message: chatMessage.message,
              createdAt: chatMessage.created,
              imagePath: chatMessage.imagePath,
            );
          }
        });
  }
}
