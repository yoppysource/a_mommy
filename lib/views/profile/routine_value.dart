import 'package:amommy/models/routine_model.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void onChangeRoutine(
    RoutineModel routineModel,
    String name,
  ) {
    int index = state.indexWhere((element) => element == routineModel);
    if (index > -1) {
      state[index].name = name;
      state = [...state];
    }
  }

  void onRemoveRoutine(RoutineModel routineModel) {
    final routines = state;
    int index = routines.indexWhere((element) => element == routineModel);
    if (index > -1) {
      routines.removeAt(index);
      state = [...routines];
    }
  }

  void onAddRoutine(DayTime dayTime) {
    final routines = state;
    routines.add(RoutineModel(name: "", dayTime: dayTime));
    state = [...routines];
  }
}
