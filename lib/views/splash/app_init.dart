import 'package:amommy/services/alarm_service.dart';
import 'package:amommy/services/hive_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_init.g.dart';

@Riverpod(keepAlive: true)
Future<void> appInit(AppInitRef ref) async {
  ref.onDispose(() {
    ref.invalidate(alarmServiceProvider);
    ref.invalidate(hiveServiceProvider);
  });
  await ref.watch(hiveServiceProvider.future);
  await ref.watch(alarmServiceProvider.future);
}
