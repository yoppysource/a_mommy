import 'package:amommy/views/common/gradient_button.dart';
import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  static double get height => 110.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.white,
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 52.0),
      child: GradientButton(
        text: text,
        onPressed: onPressed,
        textStyle: const TextStyle(),
      ),
    );
  }
}
