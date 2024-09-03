import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Noti {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  // static Future initialize() async {
  //   var androidInit = new AndroidInitializationSettings('mipmap/ic_launcher');
  //   var initializationSetting =
  //       new InitializationSettings(android: androidInit);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSetting);
  // }

//!  hadi 3la jal win tadik kima tetka 3la notification (path)
  static Future init({bool initSchediled = false}) async {
    // hadi 3la jal kima tkon App m9folaa
    final deatails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (deatails != null && deatails.didNotificationLaunchApp) {
      onNotification.add(deatails.notificationResponse!.payload);
    }

    var android = const AndroidInitializationSettings('mipmap/ic_launcher');

    final settings = InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      onNotification.add(notificationResponse.payload);
    });
  }

//! hadi bh tji notification 3adi mra w7da
  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('channelId', 'channelName',
            playSound: true,
            // sound: RawResourceAndroidNotificationSound('notification'),
            importance: Importance.min,
            channelShowBadge: false,
            maxProgress: 1,
            number: 1,
            onlyAlertOnce: true,
            showWhen: false,
            autoCancel: true,
            priority: Priority.high);
    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(id, title, body, not, payload: payload);
  }

  static Future showTimeNotificationDaily({
    var id = 0,
    required String title,
    required String body,
    required TimeOfDay time,
    var payload,
    required FlutterLocalNotificationsPlugin fln,
    Duration removeAfter = const Duration(seconds: 30), // New parameter
  }) async {
    const styleInformation = BigTextStyleInformation('');
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Algiers'));

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      styleInformation: styleInformation,
      importance: Importance.max,
      priority: Priority.high,
      timeoutAfter: removeAfter.inMilliseconds, // Add this line
    );
    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.zonedSchedule(
      id,
      title,
      body,
      _scheduleDailt(time),
      not,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _scheduleDailt(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    print(tz.TZDateTime.now(tz.local));
    final scheduleDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  static void cancel(int id) => flutterLocalNotificationsPlugin.cancel(id);
  static void cancelAll() => flutterLocalNotificationsPlugin.cancelAll();
}
