import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class Noti {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject();

  // static Future initialize() async {
  //   var androidInit = new AndroidInitializationSettings('mipmap/ic_launcher');
  //   var initializationSetting =
  //       new InitializationSettings(android: androidInit);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSetting);
  // }

//!  hadi 3la jal win tadik kima tetka 3la notification (path)
  static Future init({bool initSchediled = false}) async {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');

    final settings = InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      onNotification.add(notificationResponse);
    });
  }

//! hadi bh tji notification 3adi
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
