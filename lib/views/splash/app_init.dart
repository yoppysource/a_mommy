import 'package:amommy/services/alarm_service.dart';
import 'package:amommy/services/hive_service.dart';
import 'package:amommy/services/local_notification_service.dart';
import 'package:amommy/services/promise_check_service.dart';
import 'package:amommy/services/schedule_check_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_init.g.dart';

@Riverpod(keepAlive: true)
Future<void> appInit(AppInitRef ref) async {
  ref.onDispose(() {
    ref.invalidate(alarmServiceProvider);
    ref.invalidate(hiveServiceProvider);
    ref.invalidate(localNotificationServiceProvider);
    ref.invalidate(scheduleCheckServiceProvider);
    ref.invalidate(promiseCheckServiceProvider);
  });
  await ref.watch(hiveServiceProvider.future);
  await ref.watch(alarmServiceProvider.future);
  await ref.watch(localNotificationServiceProvider.future);
  await ref.watch(promiseCheckServiceProvider.future);
  ref.watch(scheduleCheckServiceProvider);
}
