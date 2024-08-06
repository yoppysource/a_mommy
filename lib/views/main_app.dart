import 'package:amommy/views/main/main_chat_screen.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:amommy/views/profile/user_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeOrProfilePage extends ConsumerWidget with UserState {
  const HomeOrProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return user(ref) == null || !user(ref)!.isReady
        ? const UserInputScreen()
        : const MainChatScreen();
  }
}
