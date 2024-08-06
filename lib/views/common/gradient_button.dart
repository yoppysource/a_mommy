import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.height = 50.0,
    this.radius = 8.0,
    required this.text,
    required this.onPressed,
    required this.textStyle,
  });

  final String text;
  final TextStyle textStyle;
  final double height;
  final double radius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: onPressed != null
          ? BoxDecoration(
              gradient: Palette.gradient1,
              borderRadius: BorderRadius.circular(radius),
            )
          : BoxDecoration(
              color: Palette.gray3,
              borderRadius: BorderRadius.circular(radius),
            ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: textStyle.copyWith(color: Palette.white),
            ),
          ),
        ),
      ),
    );
  }
}
