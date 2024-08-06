import 'package:amommy/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'hive_service.g.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(LanguageAdapter());

    await Hive.openBox<UserModel>('user');
  }

  Box<UserModel> get userBox => Hive.box<UserModel>('user');

  Future<void> saveMe(UserModel user) async => await userBox.put('me', user);

  UserModel? getMe() => userBox.get('me');

  Future<void> deleteMe() async => await userBox.delete('me');
}

@Riverpod(keepAlive: true)
Future<HiveService> hiveService(HiveServiceRef ref) async {
  HiveService hiveService = HiveService();
  await hiveService.init();
  return hiveService;
}
