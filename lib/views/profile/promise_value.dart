import 'package:amommy/models/promise_model.dart';
import 'package:amommy/views/profile/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'promise_value.g.dart';

@riverpod
class PromiseValue extends _$PromiseValue {
  @override
  List<PromiseModel> build() {
    return ref.watch(userProvider)?.dailyPromises ?? [];
  }

  List<PromiseModel> get morningPromiseList => state
      .where((element) => element.dayTime == DayTime.morning)
      .toList(growable: false);

  List<PromiseModel> get afternoonPromiseList => state
      .where((element) => element.dayTime == DayTime.afternoon)
      .toList(growable: false);

  List<PromiseModel> get nightPromiseList => state
      .where((element) => element.dayTime == DayTime.night)
      .toList(growable: false);

  void onChangePromise(
    PromiseModel promiseModel,
    String name,
  ) {
    int index = state.indexWhere((element) => element == promiseModel);
    if (index > -1) {
      state[index].name = name;
      state = [...state];
    }
  }

  void onRemovePromise(PromiseModel promiseModel) {
    final promises = state;
    int index = promises.indexWhere((element) => element == promiseModel);
    if (index > -1) {
      promises.removeAt(index);
      state = [...promises];
    }
  }

  void onAddPromise(DayTime dayTime) {
    final promises = state;
    promises.add(PromiseModel(name: "", dayTime: dayTime));
    state = [...promises];
  }
}
