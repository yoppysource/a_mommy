import 'dart:io';
import 'package:amommy/views/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    super.key,
    required this.focusNode,
    required this.onSend,
  });
  final FocusNode focusNode;
  final void Function(String, List<String>?) onSend;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  late final TextEditingController _controller;
  List<XFile>? _selectedImages;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedImages = await picker.pickMultiImage();

    if (pickedImages.isNotEmpty) {
      setState(() {
        _selectedImages = pickedImages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selectedImages != null && _selectedImages!.isNotEmpty)
          Container(
            color: Palette.gray1,
            height: 68,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Stack(
                    children: [
                      Image.file(
                        File(_selectedImages![index].path),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 2,
                        top: 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImages!.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Palette.primary1,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color:
                widget.focusNode.hasFocus ? Palette.gray1 : Palette.transparent,
            boxShadow: widget.focusNode.hasFocus
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.09),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, -3),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Container(
            constraints: const BoxConstraints(minHeight: 50.0),
            decoration: BoxDecoration(
              color: widget.focusNode.hasFocus ? Palette.white : Palette.gray1,
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
            ),
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () => _pickImages(),
                  child: Container(
                    width: 34,
                    height: 34,
                    margin: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                      color: Palette.primary3,
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(
                        CupertinoIcons.plus,
                        color: Palette.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    focusNode: widget.focusNode,
                    minLines: 1,
                    maxLines: 3,
                    controller: _controller,
                    style: TextPreset.body2.copyWith(color: Palette.gray8),
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle:
                          TextPreset.body2.copyWith(color: Palette.gray4),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.focusNode.hasFocus)
                  IconButton(
                    onPressed: () {
                      if (_controller.text.isEmpty) return;

                      widget.onSend(
                        _controller.text,
                        _selectedImages?.map((e) => e.path).toList(),
                      );
                      _selectedImages = null;
                      widget.focusNode.unfocus();
                      _controller.clear();
                    },
                    iconSize: 24,
                    icon: const Icon(
                      CupertinoIcons.paperplane_fill,
                      color: Palette.primary3,
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
