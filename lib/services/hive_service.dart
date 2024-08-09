import 'package:amommy/models/chat_message_model.dart';
import 'package:amommy/models/promise_model.dart';
import 'package:amommy/models/schedule_model.dart';
import 'package:amommy/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'hive_service.g.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(LanguageAdapter());
    Hive.registerAdapter(PromiseModelAdapter());
    Hive.registerAdapter(DayTimeAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
    Hive.registerAdapter(ChatMessageModelAdapter());
    Hive.registerAdapter(ScheduleModelAdapter());

    await Hive.openBox<UserModel>(UserModel.boxName);
    await Hive.openBox<ChatMessageModel>(ChatMessageModel.boxName);
    await Hive.openBox<ScheduleModel>(ScheduleModel.boxName);
    await Hive.openBox<PromiseModel>(PromiseModel.boxName);
    // chatMessageBox.deleteAll(chatMessageBox.keys);
  }

  Box<UserModel> get userBox => Hive.box<UserModel>(UserModel.boxName);
  Box<ChatMessageModel> get chatMessageBox =>
      Hive.box<ChatMessageModel>(ChatMessageModel.boxName);
  Box<ScheduleModel> get scheduleBox =>
      Hive.box<ScheduleModel>(ScheduleModel.boxName);
  Box<PromiseModel> get promiseBox =>
      Hive.box<PromiseModel>(PromiseModel.boxName);

  Future<void> saveMe(UserModel user) async => await userBox.put('me', user);

  UserModel? getMe() => userBox.get('me');

  Future<void> deleteMe() async => await userBox.delete('me');

  List<ChatMessageModel> getChatMessages() =>
      chatMessageBox.values.toList().reversed.toList();

  Future<void> addChatMessages(List<ChatMessageModel> chatMessages) async =>
      await chatMessageBox.addAll(chatMessages);

  Future<void> addSchedule(ScheduleModel schedule) async =>
      await scheduleBox.add(schedule);

  List<ScheduleModel> getSchedule() => scheduleBox.values.toList();

  Future<void> addPromise(PromiseModel promise) async =>
      await promiseBox.add(promise);

  List<PromiseModel> getPromises() => promiseBox.values.toList();
}

@Riverpod(keepAlive: true)
Future<HiveService> hiveService(HiveServiceRef ref) async {
  HiveService hiveService = HiveService();
  await hiveService.init();
  return hiveService;
}
