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
    DateTime now = DateTime.now();
    List<PromiseModel> unCheckedPromise = promises
        .where(
          (promise) =>
              promise.checkedAt!.isBefore(now) &&
              promise.checkedAt!.isSameDay(now) &&
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
        promise.isDone = false;
        await promise.save();
      }

      if (todayPromises.isEmpty) {
        for (var promise in user.dailyPromises!) {
          final model = PromiseModel(
            name: promise.name,
            dayTime: promise.dayTime,
          );
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
                DateTime baseTime =
                    DateTime(now.year, now.month, now.day, 15, 0);
                if (now.isBefore(baseTime)) {
                  checkedAt = baseTime.add(Duration(
                    hours: Random().nextInt(3),
                    minutes: Random().nextInt(60),
                  ));
                } else {
                  checkedAt = now.add(Duration(
                    hours: Random().nextInt(18 - now.hour),
                    minutes: Random().nextInt(60),
                  ));
                }
              }
              break;
            case DayTime.night:
              if (now.hour < 24) {
                DateTime baseTime =
                    DateTime(now.year, now.month, now.day, 21, 0);
                if (now.isBefore(baseTime)) {
                  checkedAt = baseTime.add(Duration(
                    hours: Random().nextInt(2),
                    minutes: Random().nextInt(60),
                  ));
                } else {
                  checkedAt = now.add(Duration(
                    hours: Random().nextInt(24 - now.hour),
                    minutes: Random().nextInt(60),
                  ));
                }
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
