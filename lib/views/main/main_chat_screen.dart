import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainChatScreen extends ConsumerStatefulWidget {
  const MainChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends ConsumerState<MainChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Main Chat Screen"),
      ),
    );
  }
}
