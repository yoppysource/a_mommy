import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get formattedString => '$hour:$minute';
}

extension DayTimeExtension on DateTime {
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
