import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;
part 'local_notification_service.g.dart';

class LocalNotificationService {
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  static notificationTapBackground(NotificationResponse notificationResponse) {
    print("bg:$notificationResponse");
  }

  Future<void> init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      print("noti-------------$notificationResponse");
      // ...
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  Future<void> scheduleNotification(
    DateTime dateTime,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'A Mommy',
      "Message from a mommy",
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'The channel for local notification',
        importance: Importance.max,
        priority: Priority.high,
      )),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

@Riverpod(keepAlive: true)
Future<LocalNotificationService> localNotificationService(
    LocalNotificationServiceRef ref) async {
  final service = LocalNotificationService();
  await service.init();
  return service;
}
