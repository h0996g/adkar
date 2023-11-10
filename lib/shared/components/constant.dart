import 'package:flutter/material.dart';

import '../../notification.dart';
import '../helper/cash_helper.dart';
import '../helper/constant.dart';

bool isFirstTimeAdkarCH = true;
bool isFirstTimeQuranCH = true;
TimeOfDay adkarTimeSabahCH = const TimeOfDay(hour: 23, minute: 23);
TimeOfDay adkarTimeMasaaCH = const TimeOfDay(hour: 16, minute: 30);

double sizeAdkarTextCH = 26;
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
      time: adkarTimeSabahCH,
      fln: Noti.flutterLocalNotificationsPlugin);

  await Noti.showTimeNotificationDaily(
      id: 26,
      payload: 'adkarMasa1',
      title: 'اذكار المساء',
      body: 'اذكار المساء',
      // scheduleDate: DateTime.now().add(Duration(seconds: 10)),
      time: adkarTimeMasaaCH,
      fln: Noti.flutterLocalNotificationsPlugin);
}

Future<void> cacheHelperRecoveryValue() async {
  isFirstTimeAppCH = await CachHelper.getData(key: "isFirstTime") ?? false;
  isNotiOnCH = await CachHelper.getData(key: "isNotiOn") ?? true;
  isFirstTimeAdkarCH =
      await CachHelper.getData(key: 'isFirstTimeAdkar') ?? true;
  isFirstTimeQuranCH =
      await CachHelper.getData(key: 'isFirstTimeQuran') ?? true;
  sizeAdkarTextCH =
      await CachHelper.getData(key: 'sizeAdkarText') ?? sizeAdkarTextCH;
  adkarTimeSabahCH = TimeOfDay(
      hour: await CachHelper.getData(key: 'adkarTimeSabahCH.hour') ??
          adkarTimeSabahCH.hour,
      minute: await CachHelper.getData(key: 'adkarTimeSabahCH.minute') ??
          adkarTimeSabahCH.minute);
  adkarTimeMasaaCH = TimeOfDay(
      hour: await CachHelper.getData(key: 'adkarTimeMasaaCH.hour') ??
          adkarTimeMasaaCH.hour,
      minute: await CachHelper.getData(key: 'adkarTimeMasaaCH.minute') ??
          adkarTimeMasaaCH.minute);
}
