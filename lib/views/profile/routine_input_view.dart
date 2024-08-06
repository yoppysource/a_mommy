import 'package:amommy/models/routine_model.dart';
import 'package:amommy/views/common/bottom_button.dart';
import 'package:amommy/views/common/delay_label.dart';
import 'package:amommy/views/profile/routine_value.dart';
import 'package:amommy/views/profile/text_input_item.dart';
import 'package:amommy/views/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineInputView extends ConsumerStatefulWidget {
  const RoutineInputView(this.initialValue, this.title, this.hintText,
      {super.key});

  final String title;
  final String hintText;
  final List<RoutineModel> initialValue;

  @override
  ConsumerState<RoutineInputView> createState() => _RoutineInputViewState();
}

class _RoutineInputViewState extends ConsumerState<RoutineInputView> {
  @override
  Widget build(BuildContext context) {
    final routine = ref.watch(routineValueProvider);
    final routineNotifier = ref.watch(routineValueProvider.notifier);
    return DelayLabel(
      title: widget.title,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Morning Routine", style: TextPreset.subTitle3),
            const SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              itemCount: routineNotifier.morningRoutineList.length,
              itemBuilder: (context, index) {
                final routine = routineNotifier.morningRoutineList[index];
                return TextInputItem(
                  text: routine.name,
                  hintText: widget.hintText,
                  onXIconPressed: () =>
                      routineNotifier.onRemoveRoutine(routine),
                  onChanged: (value) =>
                      routineNotifier.onChangeRoutine(routine, value),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () => routineNotifier.onAddRoutine(DayTime.morning),
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
            const Text("Afternoon Routine", style: TextPreset.subTitle3),
            const SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              itemCount: routineNotifier.afternoonRoutineList.length,
              itemBuilder: (context, index) {
                final routine = routineNotifier.afternoonRoutineList[index];
                return TextInputItem(
                  text: routine.name,
                  hintText: widget.hintText,
                  onXIconPressed: () =>
                      routineNotifier.onRemoveRoutine(routine),
                  onChanged: (value) =>
                      routineNotifier.onChangeRoutine(routine, value),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () => routineNotifier.onAddRoutine(DayTime.afternoon),
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
            const Text("Night Routine", style: TextPreset.subTitle3),
            const SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              itemCount: routineNotifier.nightRoutineList.length,
              itemBuilder: (context, index) {
                final routine = routineNotifier.nightRoutineList[index];
                return TextInputItem(
                  text: routine.name,
                  hintText: widget.hintText,
                  onXIconPressed: () =>
                      routineNotifier.onRemoveRoutine(routine),
                  onChanged: (value) =>
                      routineNotifier.onChangeRoutine(routine, value),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () => routineNotifier.onAddRoutine(DayTime.night),
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
