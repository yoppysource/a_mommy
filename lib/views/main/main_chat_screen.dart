import 'dart:async';
import 'package:alarm/model/alarm_settings.dart';
import 'package:amommy/services/alarm_service.dart';
import 'package:amommy/services/schedule_check_service.dart';
import 'package:amommy/views/main/chat_messages.dart';
import 'package:amommy/views/main/chat_messages_view.dart';
import 'package:amommy/views/main/chat_text_field.dart';
import 'package:amommy/views/profile/user_input_screen.dart';
import 'package:amommy/views/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainChatScreen extends ConsumerStatefulWidget {
  const MainChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends ConsumerState<MainChatScreen>
    with ChatMessagesState, WidgetsBindingObserver {
  late final FocusNode _focusNode;
  StreamSubscription<AlarmSettings>? _subscription;
  AlarmSettings? settings;
  bool get isRinging => settings != null;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(scheduleCheckServiceProvider).checkSchedule();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    _subscription = ref
        .read(alarmServiceProvider)
        .requireValue
        .ringStream
        .listen((setting) {
      setState(() {
        settings = setting;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(scheduleCheckServiceProvider).checkSchedule();
      ref.read(chatMessagesProvider.notifier).resetCount();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(chatMessagesProvider.notifier);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'A Mommy',
          style: TextPreset.subTitle2,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserInputScreen(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.settings),
          ),
        ],
        centerTitle: true,
      ),
      body: isRinging
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Wake up!"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(alarmServiceProvider)
                            .requireValue
                            .stopById(settings!.id);
                        await notifier.notifyWakeUp(
                          TimeOfDay.fromDateTime(
                            settings!.dateTime.toLocal(),
                          ),
                          TimeOfDay.now(),
                        );
                        setState(() {
                          settings = null;
                        });
                      },
                      child: const Text("Stop"),
                    ),
                  ],
                )
              ],
            )
          : GestureDetector(
              onTap: _focusNode.unfocus,
              child: Column(
                children: [
                  Expanded(
                    child: ChatMessagesView(
                      isFocused: _focusNode.hasFocus,
                      chats: chatMessages(ref),
                    ),
                  ),
                  ChatTextField(
                    focusNode: _focusNode,
                    onSend: (message, images) async {
                      await notifier.sendMessage(message, images);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
