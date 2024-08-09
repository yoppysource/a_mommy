import 'dart:async';
import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:amommy/models/user_model.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'alarm_service.g.dart';

class AlarmService {
  StreamSubscription<AlarmSettings>? subscription;

  Stream<AlarmSettings> get ringStream => Alarm.ringStream.stream;
  Future<void> init() async {
    await Alarm.init();
    checkAndroidScheduleExactAlarmPermission();
  }

  final setMorningAlarmTool = FunctionDeclaration(
    'setMorningAlarm',
    'At night, set Morning alarm to awake the user',
    Schema(
      SchemaType.object,
      properties: {
        'timeOfDay': Schema(
          SchemaType.string,
          description: 'When is the time to set the alarm.' 'HH:MM format',
        ),
      },
      requiredProperties: ['timeOfDay'],
    ),
  );

  Future<Map<String, Object?>> setAlarmFromLLM(
      Map<String, Object?> arguments) async {
    String timeOfDay = arguments['timeOfDay'] as String;
    List<String> time = timeOfDay.split(':');
    DateTime now = DateTime.now();
    DateTime alarmTime = DateTime(
        now.year, now.month, now.day, int.parse(time[0]), int.parse(time[1]));

    await setAlarm(alarmTime);

    return arguments;
  }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    if (status.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
    if (await isAutoStartAvailable == false) {
      getAutoStartPermission();
    }
  }

  bool get isAlarmSetOnTomorrow {
    // If there is an alarm set for tomorrow, return true.
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    bool isSetOnTomorrow = false;
    for (var element in Alarm.getAlarms()) {
      if (element.dateTime.year == tomorrow.year &&
          element.dateTime.month == tomorrow.month &&
          element.dateTime.day == tomorrow.day) {
        isSetOnTomorrow = true;
        break;
      }
    }
    return isSetOnTomorrow;
  }

  Future<void> setAlarm(DateTime dateTime) async {
    // If you set an alarm for the same dateTime as an existing one, the new alarm will replace the existing one.
    await stop();
    final alarmSettings = AlarmSettings(
      id: 1,
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

  Future<void> stop() async => await Alarm.stopAll();

  Future<void> stopById(int id) async => await Alarm.stop(id);
}

@Riverpod(keepAlive: true)
Future<AlarmService> alarmService(AlarmServiceRef ref) async {
  AlarmService service = AlarmService();
  await service.init();
  UserModel? user = ref.read(userProvider);
  if (user != null && user.needAlarm == true && user.alarmTime != null) {
    DateTime now = DateTime.now();
    DateTime alarmTime = DateTime(now.year, now.month, now.day + 1,
        user.alarmTime!.hour, user.alarmTime!.minute);
    // When there is no alarm for tomorrow
    if (service.isAlarmSetOnTomorrow == false) {
      service.setAlarm(alarmTime);
    }
  }
  return service;
}
