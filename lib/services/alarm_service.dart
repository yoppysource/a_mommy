import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'alarm_service.g.dart';

class AlarmService {
  Future<AlarmService> init() async {
    await Alarm.init();
    return this;
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    print('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      print('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      print(
          'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
    }
    if (await isAutoStartAvailable == false) {
      getAutoStartPermission();
    }
  }

  Future<void> setAlarm(DateTime dateTime) async {
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: dateTime,
      assetAudioPath: 'assets/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'This is the title',
      notificationBody: 'This is the body',
      enableNotificationOnKill: Platform.isIOS,
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }
}

@Riverpod(keepAlive: true)
Future<AlarmService> alarmService(AlarmServiceRef ref) async {
  AlarmService service = AlarmService();
  await service.init();
  return service;
}
