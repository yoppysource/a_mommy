import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';

class UnderlinedTextFormField extends TextFormField {
  UnderlinedTextFormField({
    super.key,
    super.focusNode,
    bool? autofocus,
    TextEditingController? textEditingController,
    super.enabled,
    super.keyboardType,
    super.inputFormatters,
    String? hintText,
    bool? obscureText,
    super.validator,
    super.onSaved,
    super.onChanged,
    super.onFieldSubmitted,
    super.onTapOutside,
    super.scrollPadding,
  }) : super(
          controller: textEditingController,
          autofocus: autofocus ?? false,
          obscureText: obscureText ?? false,
          style: TextPreset.subTitle2.copyWith(color: Palette.gray8),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            hintText: hintText,
            hintStyle:
                TextPreset.body1.copyWith(color: Palette.gray4, height: 0),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Palette.gray2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Palette.primary3),
            ),
            filled: true,
            fillColor: Palette.white,
            alignLabelWithHint: false,
          ),
          cursorColor: Palette.primary3,
        );
}
