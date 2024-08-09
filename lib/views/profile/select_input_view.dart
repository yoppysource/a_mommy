import 'package:amommy/views/common/outlined_activation_button.dart';
import 'package:amommy/views/common/delay_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectInputView extends ConsumerStatefulWidget {
  final List<String> options;
  final String title;
  final Function(String) onChanged;
  final String? initialOption;
  const SelectInputView(
      this.options, this.title, this.initialOption, this.onChanged,
      {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectInputViewState();
}

class _SelectInputViewState extends ConsumerState<SelectInputView> {
  late String? selectedOption;

  @override
  void initState() {
    selectedOption = widget.initialOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DelayLabel(
      title: widget.title,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.options
                  .map(
                    (option) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: OutlinedActivationButton(
                        text: option,
                        isActive: option == selectedOption,
                        onPressed: () {
                          setState(() {
                            selectedOption = option;
                          });
                          widget.onChanged(option);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
