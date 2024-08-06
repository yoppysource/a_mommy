import 'package:amommy/views/common/bottom_button.dart';
import 'package:amommy/views/common/delay_label.dart';
import 'package:amommy/views/profile/hobby_value.dart';
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
                return _TextInputItem(
                  text: hobbyValue[index],
                  hintText: widget.hintText,
                  onXIconPressed: () => hobbyValue.removeAt(index),
                  index: index,
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

class _TextInputItem extends ConsumerWidget {
  const _TextInputItem({
    required this.text,
    required this.onXIconPressed,
    required this.hintText,
    required this.index,
  });
  final String text;
  final int index;
  final VoidCallback onXIconPressed;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hobbyValueController = ref.watch(hobbyValueProvider.notifier);
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Palette.white,
        border: Border.all(
          width: 1,
          color: Palette.gray3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextPreset.body1.copyWith(color: Palette.gray6),
                border: InputBorder.none,
              ),
              initialValue: text,
              onChanged: (value) =>
                  hobbyValueController.onHobbyChanged(index, value),
            ),
          ),
          InkWell(
            onTap: onXIconPressed,
            child: const Icon(
              CupertinoIcons.xmark,
              color: Palette.gray6,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
