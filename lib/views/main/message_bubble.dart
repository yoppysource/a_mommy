import 'dart:io';

import 'package:amommy/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble.first({
    super.key,
    required this.isMe,
    required this.createdAt,
    this.message,
    this.imagePath,
  }) : isFirstInSequence = true;

  const MessageBubble.next({
    super.key,
    required this.isMe,
    required this.createdAt,
    this.imagePath,
    this.message,
  }) : isFirstInSequence = false;

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final isToday = now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;

    if (isToday) {
      // 오늘인 경우 오후 2:30 형식으로 반환
      final formattedTime = DateFormat('a h:mm', 'en').format(dateTime);
      return formattedTime;
    } else {
      // 하루 이상 지난 경우 8월 20일 오후 2:30 형식으로 반환
      final formattedDate = DateFormat('M d', 'en').format(dateTime);
      final formattedTime = DateFormat('a h:mm', 'en').format(dateTime);
      return '$formattedDate $formattedTime';
    }
  }

  final DateTime createdAt;
  final bool isFirstInSequence;
  final bool isMe;
  final String? message;
  final String? imagePath;

  final _textRadius = 300.0;
  final _imageRadius = 14.0;

  double get _radius => imagePath != null ? _imageRadius : _textRadius;

  BorderRadius get rightBorder => BorderRadius.only(
        topLeft: Radius.circular(_radius),
        topRight: Radius.circular(_radius),
        bottomLeft: Radius.circular(_radius),
        bottomRight: Radius.zero,
      );

  BorderRadius get leftBorder => BorderRadius.only(
        topLeft: Radius.circular(_radius),
        topRight: Radius.circular(_radius),
        bottomLeft: Radius.zero,
        bottomRight: Radius.circular(_radius),
      );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          imagePath != null
              ? InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: isMe ? rightBorder : leftBorder,
                    child: Image.file(
                      File(imagePath!),
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: isMe ? Palette.primary3 : Palette.gray2,
                    borderRadius: isMe ? rightBorder : leftBorder,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Linkify(
                    onOpen: (link) => launchUrl(Uri.parse(link.url)),
                    text: message!,
                    style: TextPreset.body2
                        .copyWith(color: isMe ? Palette.white : Palette.gray8),
                    softWrap: true,
                  ),
                ),
          const SizedBox(height: 4.0),
          Text(
            formatDateTime(createdAt),
            style: TextPreset.caption.copyWith(color: Palette.gray6),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
