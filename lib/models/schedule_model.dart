// This routine must be temporary. If daily routine, it must put in UserProfile.
import 'package:hive/hive.dart';

part 'schedule_model.g.dart';

@HiveType(typeId: 4)
class ScheduleModel extends HiveObject {
  static const String boxName = 'schedule';

  @HiveField(0)
  String name;
  @HiveField(1)
  DateTime plannedTime;
  @HiveField(2)
  bool isNotified;
  @HiveField(3)
  String? feeling;

  ScheduleModel({
    required this.name,
    required this.plannedTime,
    this.isNotified = false,
  });
}
