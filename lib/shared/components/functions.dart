import 'package:adkar/shared/components/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../Screens/Adkar/adkar_details.dart';
import '../../Screens/Adkar/cubit/ahadith_cubit.dart';
import '../../notification.dart';
import '../helper/cash_helper.dart';
import '../helper/constant.dart';
import 'components.dart';

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
  // for (var notif in notifications) {
  //   await Noti.showTimeNotificationDaily(
  //     payload: 'adkar',
  //     id: notif['id'],
  //     title: 'فَذَكِّرْ',
  //     body: notif['description']!,
  //     time: notif['date'],
  //     fln: Noti.flutterLocalNotificationsPlugin,
  //     removeAfter: const Duration(seconds: 120),
  //   );
  // }

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

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

void listenNotification(context) =>
    Noti.onNotification.stream.listen((event) async {
      if (event == 'adkarSabah') {
        await AhadithCubit.get(context)
            .getSectionDetails(context, 1)
            .then((value) {
          navigatAndReturn(
            context: context,
            page: ShowCaseWidget(
              builder: Builder(
                builder: (context) => const AdkarDetails(
                  title: 'اذكار الصباح',
                ),
              ),
            ),
          );
        });
      } else if (event == "adkarMasa1") {
        await AhadithCubit.get(context)
            .getSectionDetails(context, 2)
            .then((value) {
          navigatAndReturn(
              context: context,
              page: ShowCaseWidget(
                builder: Builder(
                    builder: ((context) => const AdkarDetails(
                          title: 'اذكار المساء',
                        ))),
              ));
        });
      }
    });

Future<void> checkUpdate(BuildContext context) async {
  int? currentVersion;
  Map<String, dynamic>? update;
  Map<String, dynamic>? itemupdate;
  int? currentUpdateVersion;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  currentVersion = getExtendedVersionNumber(version);

  await FirebaseFirestore.instance
      .collection('update')
      .doc('details')
      .get()
      .then((value) {
    update = value.data();
    itemupdate = update!['updates'];
    String updateVersion = update!['version'];
    currentUpdateVersion = getExtendedVersionNumber(updateVersion);
  });

  await Future.delayed(Duration.zero, () {
    if (currentUpdateVersion! > currentVersion!) {
      // _showAlert(context);
      showDialog(
          context: context,
          builder: (context) => CustomDialog(
                itemupdate: itemupdate,
                update: update,
              ));
    }
  });
}
