import 'package:amommy/models/routine_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 100)
enum Language {
  @HiveField(0)
  korean,
  @HiveField(1)
  english,
}

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? age;
  @HiveField(2)
  Language? language;
  @HiveField(3)
  String? livingArea;
  @HiveField(4)
  List<String>? hobbies;
  @HiveField(5)
  String? job;
  @HiveField(6)
  List<RoutineModel>? dailyRoutines;
  @HiveField(7)
  TimeOfDay? alarmTime;
  @HiveField(8)
  bool? needAlarm;

  UserModel({
    this.name,
    this.age,
    this.language,
    this.livingArea,
    this.hobbies,
    this.job,
    this.dailyRoutines,
    this.alarmTime,
    this.needAlarm,
  });

  bool get isReady =>
      name != null &&
      age != null &&
      language != null &&
      livingArea != null &&
      hobbies != null &&
      job != null &&
      dailyRoutines != null &&
      hobbies != null &&
      hobbies!.isNotEmpty &&
      (needAlarm == false || (needAlarm == true && alarmTime != null));

  UserModel copyWith({
    String? name,
    int? age,
    Language? language,
    String? livingArea,
    List<String>? hobbies,
    String? job,
    List<RoutineModel>? dailyRoutines,
    TimeOfDay? alarmTime,
    bool? needAlarm,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      language: language ?? this.language,
      livingArea: livingArea ?? this.livingArea,
      hobbies: hobbies ?? this.hobbies,
      job: job ?? this.job,
      dailyRoutines: dailyRoutines ?? this.dailyRoutines,
      alarmTime: alarmTime ?? this.alarmTime,
      needAlarm: needAlarm ?? this.needAlarm,
    );
  }
}
