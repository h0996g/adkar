import 'package:flutter/material.dart';

import '../../notification.dart';
import '../helper/cash_helper.dart';
import '../helper/constant.dart';

bool isFirstTimeAdkar = true;
bool isFirstTimeQuran = true;
double sizeAdkarText = 26;
// ! hadi bh ndir compare bin version t3 App (1.0.1 m3a 1.0.3 mital )
int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}

Future<void> firstTimeNoti({required bool isFirstTime}) async {
  if (isFirstTime == false) {
    print('awel mra ');
    await activeNotification();
    await CachHelper.putcache(key: 'isFirstTime', value: true); //kant  isNotiOn
  }
}

Future<void> activeNotification() async {
  print('ra7 ndir active l notificaiotn');
  for (var notif in notifications) {
    await Noti.showTimeNotificationDaily(
        payload: 'adkar',
        id: notif['id'],
        title: 'فَذَكِّرْ',
        body: notif['description']!,
        time: notif['date'],
        fln: Noti.flutterLocalNotificationsPlugin);
  }

  await Noti.showTimeNotificationDaily(
      id: 25,
      payload: 'adkarSabah',
      title: 'اذكار الصباح',
      body: 'اذكار الصباح',
      // scheduleDate: DateTime.now().add(Duration(seconds: 10)),
      time: const TimeOfDay(hour: 7, minute: 30),
      fln: Noti.flutterLocalNotificationsPlugin);
  await Noti.showTimeNotificationDaily(
      id: 26,
      payload: 'adkarMasa1',
      title: 'اذكار المساء',
      body: 'اذكار المساء',
      // scheduleDate: DateTime.now().add(Duration(seconds: 10)),
      time: const TimeOfDay(hour: 16, minute: 30),
      fln: Noti.flutterLocalNotificationsPlugin);
}

Future<void> cacheHelperRecoveryValue() async {
  isFirstTime = await CachHelper.getData(key: "isFirstTime") ?? false;
  isNotiOn = await CachHelper.getData(key: "isNotiOn") ?? true;
  isFirstTimeAdkar = await CachHelper.getData(key: 'isFirstTimeAdkar') ?? true;
  isFirstTimeQuran = await CachHelper.getData(key: 'isFirstTimeQuran') ?? true;
  sizeAdkarText =
      await CachHelper.getData(key: 'sizeAdkarText') ?? sizeAdkarText;
}
