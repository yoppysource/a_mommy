import 'dart:async';

import 'package:amommy/models/schedule_model.dart';
import 'package:amommy/services/hive_service.dart';
import 'package:amommy/services/local_notification_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'schedule_check_service.g.dart';

class ScheduleCheckService {
  ScheduleCheckService(this._notificationService, this._hiveService);

  final LocalNotificationService _notificationService;
  final HiveService _hiveService;
  final StreamController<ScheduleModel> _scheduleController =
      StreamController();
  Stream<ScheduleModel> get scheduleStream => _scheduleController.stream;

  final setPlanTool = FunctionDeclaration(
    'setPlan',
    'set plan for today',
    Schema(
      SchemaType.object,
      properties: {
        'name': Schema(
          SchemaType.string,
          description: 'The name of the schedule to set',
        ),
        'timeOfDay': Schema(
          SchemaType.string,
          description: 'When is the time to do plan' 'HH:MM format',
        ),
      },
      requiredProperties: ['name', "timeOfDay"],
    ),
  );

  Future<Map<String, Object?>> setPlanFromLLM(
    Map<String, Object?> arguments,
  ) async {
    String name = arguments['name'] as String;
    String timeOfDay = arguments['timeOfDay'] as String;
    List<String> time = timeOfDay.split(':');
    DateTime now = DateTime.now();
    DateTime plannedTime = DateTime(
        now.year, now.month, now.day, int.parse(time[0]), int.parse(time[1]));

    await _notificationService.scheduleNotification(
      plannedTime,
    );
    _hiveService.addSchedule(ScheduleModel(
      name: name,
      plannedTime: plannedTime,
    ));

    return arguments;
  }

  void checkSchedule() {
    List<ScheduleModel> schedules = _hiveService.getSchedule();
    DateTime now = DateTime.now();
    for (var schedule in schedules) {
      if (now.isAfter(schedule.plannedTime) && !schedule.isNotified) {
        schedule.isNotified = true;
        schedule.save();
        _scheduleController.add(schedule);
      }
    }
  }
}

@Riverpod(keepAlive: true)
ScheduleCheckService scheduleCheckService(ScheduleCheckServiceRef ref) {
  return ScheduleCheckService(
    ref.read(localNotificationServiceProvider).requireValue,
    ref.read(hiveServiceProvider).requireValue,
  );
}
