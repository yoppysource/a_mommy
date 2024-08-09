import 'package:amommy/models/promise_model.dart';
import 'package:amommy/models/user_model.dart';
import 'package:amommy/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  HiveService get hiveService => ref.watch(hiveServiceProvider).requireValue;

  @override
  UserModel? build() {
    return hiveService.getMe();
  }

  // When next button pressed in profile input page
  Future<void> onNameChanged(String name) async {
    if (name.isEmpty) {
      return;
    }
    // When first register there will be no user
    UserModel currentUser = state ?? UserModel();
    state = currentUser.copyWith(name: name);
  }

  void onAgeChanged(String ageStr) {
    int? age = int.tryParse(ageStr.trim());
    if (age == null || age <= 0) {
      return;
    }
    state = state!.copyWith(age: age);
  }

  void onLanguageChanged(String languageStr) {
    // Default language is english
    Language language = Language.english;
    for (var element in Language.values) {
      if (element.name == languageStr) {
        language = element;
        break;
      }
    }
    state = state!.copyWith(language: language);
  }

  Future<void> saveCurrentState() async => hiveService.saveMe(state!);

  void onLivingAreaChanged(String livingArea) {
    if (livingArea.isEmpty) {
      return;
    }
    state = state!.copyWith(livingArea: livingArea);
  }

  void onJobChanged(String job) {
    if (job.isEmpty) {
      return;
    }
    state = state!.copyWith(job: job);
  }

  Future<void> saveHobbies(List<String> hobbies) async {
    state = state!.copyWith(hobbies: hobbies);
    return saveCurrentState();
  }

  void onAlarmTimeChanged(TimeOfDay? alarmTime) {
    state = state!.copyWith(alarmTime: alarmTime);
    saveCurrentState();
  }

  void onNeedAlarmChanged(bool needAlarm) {
    state = state!.copyWith(needAlarm: needAlarm);
    saveCurrentState();
  }

  Future<void> savePromises(List<PromiseModel> routines) async {
    List<PromiseModel> filteredRoutines =
        routines.where((element) => element.name.isNotEmpty).toList();
    state = state!.copyWith(dailyPromises: filteredRoutines);
    return saveCurrentState();
  }
}

mixin class UserState {
  UserModel? user(WidgetRef ref) => ref.watch(userProvider);
}
