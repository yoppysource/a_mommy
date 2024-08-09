import 'package:amommy/views/common/outlined_activation_button.dart';
import 'package:amommy/views/common/delay_label.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmInputView extends ConsumerStatefulWidget {
  const AlarmInputView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlarmInputViewState();
}

class _AlarmInputViewState extends ConsumerState<AlarmInputView> {
  String? selectedOption;
  List<String> options = ["Yes", "No"];
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    final userNotifier = ref.watch(userProvider.notifier);
    return DelayLabel(
      title: "Do you want to set an alarm?",
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...options.map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: OutlinedActivationButton(
                      text: option,
                      isActive: option == selectedOption,
                      onPressed: () async {
                        setState(() {
                          selectedOption = option;
                        });
                        if (selectedOption == 'Yes') {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              selectedTime = time;
                            });
                          }
                          userNotifier.onAlarmTimeChanged(selectedTime);
                          userNotifier.onNeedAlarmChanged(true);
                        } else {
                          setState(() {
                            selectedTime = null;
                          });
                          userNotifier.onAlarmTimeChanged(null);
                          userNotifier.onNeedAlarmChanged(false);
                        }
                      },
                    ),
                  ),
                ),
                if (selectedOption == 'Yes' && selectedTime != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      "Alarm set to ${selectedTime!.format(context)}",
                      style: TextPreset.subTitle2,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
