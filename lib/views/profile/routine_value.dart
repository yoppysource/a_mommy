import 'package:amommy/models/routine_model.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'routine_value.g.dart';

@riverpod
class RoutineValue extends _$RoutineValue {
  @override
  List<RoutineModel> build() {
    return ref.watch(userProvider)?.dailyRoutines ?? [];
  }

  List<RoutineModel> get morningRoutineList => state
      .where((element) => element.dayTime == DayTime.morning)
      .toList(growable: false);

  List<RoutineModel> get afternoonRoutineList => state
      .where((element) => element.dayTime == DayTime.afternoon)
      .toList(growable: false);

  List<RoutineModel> get nightRoutineList => state
      .where((element) => element.dayTime == DayTime.night)
      .toList(growable: false);

  RoutineModel getRoutine(int index, DayTime dayTime) {
    if (dayTime == DayTime.morning) {
      return morningRoutineList[index];
    } else if (dayTime == DayTime.afternoon) {
      return afternoonRoutineList[index];
    } else {
      return nightRoutineList[index];
    }
  }

  void onChangeRoutine(DayTime dayTime, int index, String name) {
    getRoutine(index, dayTime).name = name;
    state = [...state];
  }

  void onRemoveRoutine(int index) {
    final routines = state;
    routines.removeAt(index);
    state = [...routines];
  }

  void onAddRoutine(DayTime dayTime) {
    final routines = state;
    routines.add(RoutineModel(name: "", dayTime: DayTime.morning));
    state = [...routines];
  }
}
