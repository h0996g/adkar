import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future initialize() async {
    var androidInit = new AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSetting =
        new InitializationSettings(android: androidInit);
    await flutterLocalNotificationsPlugin.initialize(initializationSetting);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails('channelId', 'channelName',
            playSound: true,
            // sound: RawResourceAndroidNotificationSound('notification'),
            importance: Importance.max,
            priority: Priority.high);
    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, not);
  }
}
