import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService._();

  static LocalNotificationService localNotificationService =
      LocalNotificationService._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  // global
  AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    "chat-app",
    "local Notification",
    importance: Importance.max,
    priority: Priority.max,
  );

  // init
  Future<void> initNotificationService() async {
    plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    AndroidInitializationSettings android =
        AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings ios = DarwinInitializationSettings();
    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );
    await plugin.initialize(settings);
  }

  // show

  Future<void> showNotification(String title, String body) async {
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);
    await plugin.show(0, title, body, notificationDetails);
  }

  // scheduled notification
  Future<void> scheduledNotification() async {
    tz.Location location = tz.getLocation('Asia/Kolkata');
    await plugin.zonedSchedule(
        1,
        "Bid Billions Day 2024",
        "nothing for sale ",
        tz.TZDateTime.now(location).add(const Duration(seconds: 5)),
        NotificationDetails(android: androidDetails),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
