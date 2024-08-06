import 'package:amommy/views/common/delay_label.dart';
import 'package:amommy/views/common/underlined_text_form_field.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInputView extends ConsumerStatefulWidget with UserState {
  TextInputView(
    this.initialValue,
    this.title,
    this.hintText,
    this.onChange, {
    this.isNumber = false,
    super.key,
  }) {
    input = ValueNotifier<String>(initialValue);
  }
  final String initialValue;
  final String title;
  final String hintText;
  final bool isNumber;
  final void Function(String) onChange;
  late final ValueNotifier<String> input;

  @override
  ConsumerState<TextInputView> createState() => _TextInputViewState();
}

class _TextInputViewState extends ConsumerState<TextInputView> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.initialValue)
      ..addListener(() {
        widget.onChange(textEditingController.text);
      });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DelayLabel(
      title: widget.title,
      child: UnderlinedTextFormField(
        hintText: widget.hintText,
        textEditingController: textEditingController,
        autofocus: widget.initialValue.isEmpty,
        keyboardType: widget.isNumber ? TextInputType.number : null,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
