import 'dart:math';
import 'package:amommy/models/promise_model.dart';
import 'package:amommy/models/user_model.dart';
import 'package:amommy/services/hive_service.dart';
import 'package:amommy/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "promise_check_service.g.dart";

class PromiseCheckService {
  PromiseCheckService(this._hiveService);
  final HiveService _hiveService;
  List<PromiseModel> get promises => _hiveService.getPromises();

  PromiseModel? getUnCheckedPromises() {
    List<PromiseModel> unCheckedPromise = promises
        .where(
          (promise) =>
              promise.checkedAt!.isBefore(DateTime.now()) &&
              promise.isDone == false,
        )
        .toList();
    if (unCheckedPromise.isNotEmpty) {
      return unCheckedPromise[0];
    }
    return null;
  }

  Future<void> init() async {
    UserModel? user = _hiveService.getMe();
    if (user != null &&
        user.dailyPromises != null &&
        user.dailyPromises!.isNotEmpty) {
      // Check if promise list doesn't contain today's promises
      DateTime now = DateTime.now();
      List<PromiseModel> todayPromises = promises
          .where((promise) => promise.checkedAt!.isSameDay(now))
          .toList();
      for (var promise in todayPromises) {
        promise.checkedAt = DateTime.now().add(const Duration(seconds: 10));
        promise.isDone = false;
        break;
      }

      if (todayPromises.isEmpty) {
        for (var promise in user.dailyPromises!) {
          final model =
              PromiseModel(name: promise.name, dayTime: promise.dayTime);
          DateTime? checkedAt;
          switch (promise.dayTime) {
            case DayTime.morning:
              if (now.hour < 12) {
                checkedAt = now.add(Duration(
                  hours: Random().nextInt(12 - now.hour),
                  minutes: Random().nextInt(60),
                ));
              }
              break;
            case DayTime.afternoon:
              if (now.hour < 18) {
                int from = now.hour < 15 ? 15 : now.hour;
                checkedAt = now.add(Duration(
                  hours: Random().nextInt(18 - from),
                  minutes: Random().nextInt(60),
                ));
              }
              break;
            case DayTime.night:
              if (now.hour < 24) {
                int from = now.hour < 21 ? 21 : now.hour;
                // 현재 시간부터 24시 이전까지 랜덤으로 시간 생성
                checkedAt = now.add(Duration(
                  hours: Random().nextInt(24 - from),
                  minutes: Random().nextInt(60),
                ));
              }
              break;
          }
          if (checkedAt != null) {
            model.checkedAt = checkedAt;
            await _hiveService.addPromise(model);
          }
        }
      }
    }
  }
}

@Riverpod(keepAlive: true)
Future<PromiseCheckService> promiseCheckService(
  PromiseCheckServiceRef ref,
) async {
  PromiseCheckService promiseCheckService =
      PromiseCheckService(ref.read(hiveServiceProvider).requireValue);
  await promiseCheckService.init();
  return promiseCheckService;
}
