import 'package:amommy/models/promise_model.dart';
import 'package:amommy/views/common/bottom_button.dart';
import 'package:amommy/views/common/delay_label.dart';
import 'package:amommy/views/profile/promise_value.dart';
import 'package:amommy/views/profile/text_input_item.dart';
import 'package:amommy/views/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromiseInputView extends ConsumerStatefulWidget {
  const PromiseInputView(this.initialValue, this.title, this.hintText,
      {super.key});

  final String title;
  final String hintText;
  final List<PromiseModel> initialValue;

  @override
  ConsumerState<PromiseInputView> createState() => _PromiseInputViewState();
}

class _PromiseInputViewState extends ConsumerState<PromiseInputView> {
  @override
  Widget build(BuildContext context) {
    final promises = ref.watch(promiseValueProvider);
    final promiseNotifier = ref.watch(promiseValueProvider.notifier);
    return DelayLabel(
      title: widget.title,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Morning Promise", style: TextPreset.subTitle3),
            const SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              itemCount: promiseNotifier.morningPromiseList.length,
              itemBuilder: (context, index) {
                final promise = promiseNotifier.morningPromiseList[index];
                return TextInputItem(
                  text: promise.name,
                  hintText: widget.hintText,
                  onXIconPressed: () =>
                      promiseNotifier.onRemovePromise(promise),
                  onChanged: (value) =>
                      promiseNotifier.onChangePromise(promise, value),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () => promiseNotifier.onAddPromise(DayTime.morning),
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
            const SizedBox(height: 24.0),
            const Text("Afternoon Promise", style: TextPreset.subTitle3),
            const SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              itemCount: promiseNotifier.afternoonPromiseList.length,
              itemBuilder: (context, index) {
                final promise = promiseNotifier.afternoonPromiseList[index];
                return TextInputItem(
                  text: promise.name,
                  hintText: widget.hintText,
                  onXIconPressed: () =>
                      promiseNotifier.onRemovePromise(promise),
                  onChanged: (value) =>
                      promiseNotifier.onChangePromise(promise, value),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () => promiseNotifier.onAddPromise(DayTime.afternoon),
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
            const SizedBox(height: 24.0),
            const Text("Night Promise", style: TextPreset.subTitle3),
            const SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              itemCount: promiseNotifier.nightPromiseList.length,
              itemBuilder: (context, index) {
                final promise = promiseNotifier.nightPromiseList[index];
                return TextInputItem(
                  text: promise.name,
                  hintText: widget.hintText,
                  onXIconPressed: () =>
                      promiseNotifier.onRemovePromise(promise),
                  onChanged: (value) =>
                      promiseNotifier.onChangePromise(promise, value),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () => promiseNotifier.onAddPromise(DayTime.night),
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
