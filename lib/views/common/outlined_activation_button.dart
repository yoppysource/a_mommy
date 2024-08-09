import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';

class OutlinedActivationButton extends StatelessWidget {
  const OutlinedActivationButton({
    super.key,
    this.width,
    this.height = 50.0,
    this.onPressed,
    this.textStyle = TextPreset.body1,
    this.alignment = Alignment.center,
    this.changeActiveTextStyle = true,
    required this.text,
    required this.isActive,
  });

  final double? width;
  final double height;

  final String text;
  final VoidCallback? onPressed;
  final bool isActive;
  final bool changeActiveTextStyle;

  final TextStyle? textStyle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Palette.white,
          border: Border.all(
            width: 1,
            color: isActive ? Palette.primary5 : Palette.gray3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: isActive
              ? (changeActiveTextStyle ? textStyle : TextPreset.subTitle2)!
                  .copyWith(color: Palette.primary5)
              : (changeActiveTextStyle ? textStyle : TextPreset.body1)!
                  .copyWith(color: Palette.gray6),
        ),
      ),
    );
  }
}
