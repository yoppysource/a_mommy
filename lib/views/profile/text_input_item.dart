import 'package:amommy/views/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputItem extends StatelessWidget {
  const TextInputItem({
    super.key,
    required this.text,
    required this.onXIconPressed,
    required this.hintText,
    required this.onChanged,
  });
  final String text;
  final VoidCallback onXIconPressed;
  final String hintText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
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
              onChanged: (value) => onChanged(value),
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
