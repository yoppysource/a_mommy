// Routine can be two way of it. First daily routine and one time routine.
import 'package:hive/hive.dart';
part 'morning_alarm_model.g.dart';

@HiveType(typeId: 3)
class MorningAlarmModel extends HiveObject {
  @HiveField(0)
  DateTime plannedTime;
  @HiveField(1)
  DateTime? actualTime;
  @HiveField(2)
  DateTime? snoozedTime;

  MorningAlarmModel({
    required this.plannedTime,
    this.actualTime,
    this.snoozedTime,
  });
}
