import 'package:amommy/views/common/delayed_reveal.dart';
import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';

class DelayLabel extends StatelessWidget {
  const DelayLabel({
    super.key,
    required this.title,
    required this.child,
    this.subTitle,
  });
  final String title;
  final String? subTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          DelayedReveal(
            delay: const Duration(milliseconds: 300),
            child: Text(
              title,
              style: TextPreset.heading2,
            ),
          ),
          if (subTitle != null) ...{
            const SizedBox(height: 16.0),
            DelayedReveal(
              delay: const Duration(milliseconds: 600),
              child: Text(
                subTitle!,
                style: TextPreset.body1.copyWith(color: Palette.gray8),
                textAlign: TextAlign.center,
              ),
            ),
          },
          const SizedBox(height: 24.0),
          DelayedReveal(
            delay: Duration(milliseconds: subTitle != null ? 900 : 600),
            child: child,
          ),
        ],
      ),
    );
  }
}
