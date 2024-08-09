import 'dart:async';
import 'package:amommy/models/chat_message_model.dart';
import 'package:amommy/models/promise_model.dart';
import 'package:amommy/services/hive_service.dart';
import 'package:amommy/services/llm_service.dart';
import 'package:amommy/services/promise_check_service.dart';
import 'package:amommy/services/schedule_check_service.dart';
import 'package:amommy/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chat_messages.g.dart';

@Riverpod(keepAlive: true)
class ChatMessages extends _$ChatMessages {
  HiveService get hiveService => ref.watch(hiveServiceProvider).requireValue;
  LLMService get llmService => ref.watch(llmServiceProvider);
  PromiseCheckService get promiseCheckService =>
      ref.watch(promiseCheckServiceProvider).requireValue;
  List<ChatMessageModel> get lastChats =>
      state.length > 20 ? state.sublist(state.length - 20) : state;
  StreamSubscription? _scheduleSubscription;
  int messageCountForThisSession = 0;
  bool isAboutPromise = false;

  void resetCount() {
    messageCountForThisSession = 0;
  }

  @override
  List<ChatMessageModel> build() {
    _scheduleSubscription?.cancel();
    _scheduleSubscription = ref
        .watch(scheduleCheckServiceProvider)
        .scheduleStream
        .listen((schedule) async {
      String? momMessage = await llmService.getMessage(
        lastChats,
        "Your son had scheduled named ${schedule.name} at ${schedule.plannedTime.toString()}, Current time is ${schedule.plannedTime.toString()}. Ask your son how was the schedule.",
      );
      _onMomMessage(momMessage);
    });
    return hiveService.getChatMessages();
  }

  Future<void> _onMomMessage(String? momMessage) async {
    if (momMessage == null) {
      return;
    }
    // Split and remove empty strings
    final momChatModels = momMessage
        .replaceAll('\n', '.')
        .split('.')
        .where((e) => e.trim().isNotEmpty)
        .map(
          (e) => ChatMessageModel(
            isMe: false,
            message: e.trim(),
            created: DateTime.now(),
          ),
        )
        .toList();
    await hiveService.addChatMessages(momChatModels);
    state = [...(momChatModels.reversed), ...state];
  }

  Future<void> sendMessage(String message, List<String>? imagePath) async {
    messageCountForThisSession++;
    DateTime now = DateTime.now();
    final List<ChatMessageModel> userChatMessages = [];

    if (imagePath != null && imagePath.isNotEmpty) {
      userChatMessages.addAll(
        imagePath.map(
          (e) => ChatMessageModel(
            created: now,
            isMe: true,
            imagePath: e,
          ),
        ),
      );
    }

    if (message.isNotEmpty) {
      userChatMessages.add(
        ChatMessageModel(
          created: now,
          isMe: true,
          message: message,
        ),
      );
    }

    await hiveService.addChatMessages(userChatMessages);
    state = [
      ...userChatMessages.reversed,
      ...state,
    ];

    // Check if the message there is unchecked promise
    PromiseModel? model = promiseCheckService.getUnCheckedPromises();

    // Extract last 20 chats from chat messages
    String? momMessage;
    if (isAboutPromise) {
      momMessage = await llmService.getMessage(
        state,
        "You just check from your son whether he keep his promise or not. If he didn't do it, blame him by comparing your neighbor's son.",
      );
      isAboutPromise = false;
    } else if (model != null && messageCountForThisSession > 2) {
      sendPromiseCheckMessage(model);
    } else {
      momMessage = await llmService.getMessage(lastChats, message);
    }

    _onMomMessage(momMessage);
  }

  Future<void> notifyWakeUp(TimeOfDay planedTime, TimeOfDay actualTime) async {
    String? momMessage = await llmService.getMessage(
      lastChats,
      "the user woke up at ${actualTime.formattedString}, the alarm was set to ${planedTime.formattedString}. If the user wake up more than 10 minutes after alarm. Blame the user by comparing your neighbor's son. Or say morning hello to user.",
    );
    _onMomMessage(momMessage);
  }

  Future<void> sendPromiseCheckMessage(PromiseModel model) async {
    model.isDone = true;
    model.save();
    String? momMessage = await llmService.getMessage(
      lastChats,
      "Your son promised to ${model.name} at ${model.dayTime.name}. Check if your son did it. If he didn't do it",
    );
    _onMomMessage(momMessage);
    isAboutPromise = true;
  }

  Future<void> clear() async {
    await hiveService.chatMessageBox.deleteAll(hiveService.chatMessageBox.keys);
    state = [];
  }
}

mixin class ChatMessagesState {
  List<ChatMessageModel> chatMessages(WidgetRef ref) =>
      ref.watch(chatMessagesProvider);
}
