// Routine can be two way of it. First daily routine and one time routine.
import 'package:hive/hive.dart';

part 'promise_model.g.dart';

@HiveType(typeId: 2)
enum DayTime {
  @HiveField(0)
  morning,
  @HiveField(1)
  afternoon,
  @HiveField(2)
  night,
}

// This routine must be temporary. If daily routine, it must put in UserProfile.
@HiveType(typeId: 1)
class PromiseModel extends HiveObject {
  static const String boxName = 'promise';
  @HiveField(0)
  String name;
  @HiveField(1)
  DayTime dayTime;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  DateTime? checkedAt;

  PromiseModel({
    required this.name,
    required this.dayTime,
    this.isDone = false,
    this.checkedAt,
  });
}
