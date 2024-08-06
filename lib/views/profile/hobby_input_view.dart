import 'package:amommy/views/common/bottom_button.dart';
import 'package:amommy/views/common/delay_label.dart';
import 'package:amommy/views/profile/hobby_value.dart';
import 'package:amommy/views/profile/text_input_item.dart';
import 'package:amommy/views/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HobbyInputScreen extends ConsumerStatefulWidget {
  const HobbyInputScreen(this.initialValue, this.title, this.hintText,
      {super.key});

  final String title;
  final String hintText;
  final List<String> initialValue;

  @override
  ConsumerState<HobbyInputScreen> createState() => _HobbyInputScreenState();
}

class _HobbyInputScreenState extends ConsumerState<HobbyInputScreen> {
  @override
  Widget build(BuildContext context) {
    final hobbyValue = ref.watch(hobbyValueProvider);
    final hobbyValueController = ref.watch(hobbyValueProvider.notifier);
    return DelayLabel(
      title: widget.title,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: hobbyValue.length,
              itemBuilder: (context, index) {
                return TextInputItem(
                  text: hobbyValue[index],
                  hintText: widget.hintText,
                  onXIconPressed: () => hobbyValue.removeAt(index),
                  onChanged: (value) =>
                      hobbyValueController.onHobbyChanged(index, value),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () => hobbyValueController.addHobby(),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: const CircleAvatar(
                radius: 20.0,
                backgroundColor: Palette.primary1,
                child: Icon(
                  CupertinoIcons.add,
                  size: 28.0,
                  color: Palette.white,
                ),
              ),
            ),
            SizedBox(height: BottomButton.height),
          ],
        ),
      ),
    );
  }
}
