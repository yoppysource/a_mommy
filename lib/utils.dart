import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get formattedString {
    final String period = hour >= 12 ? 'PM' : 'AM';
    final int hourOfPeriod = hour % 12 == 0 ? 12 : hour % 12;

    final String minuteFormatted = minute.toString().padLeft(2, '0');

    return '$hourOfPeriod:$minuteFormatted $period';
  }
}

extension DayTimeExtension on DateTime {
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
