import 'package:adkar/Screens/settings/cubit/settings_state.dart';
import 'package:adkar/notification.dart';
import 'package:adkar/shared/helper/constant.dart';
import 'package:adkar/shared/network/local/kotlin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/functions.dart';
import '../../../shared/helper/cash_helper.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

  TimeOfDay selectedTimeSabah = adkarTimeSabahCH;
  TimeOfDay selectedTimeMasaa = adkarTimeMasaaCH;
  bool switchNoti = isNotiOnCH;
  String _notificationType = CachHelper.getData(key: 'typeNoti') ?? 'custom';
  String get notificationType => _notificationType;

  // final List<String> intervalOptions = [
  //   '15 دقيقة',
  //   '30 دقيقة',
  //   '1 ساعة',
  //   '2 ساعة',
  //   '4 ساعات'
  // ];
  // String _floatingNotificationInterval =
  //     CachHelper.getData(key: 'floatingNotificationInterval') ?? '30 دقيقة';
  // String get floatingNotificationInterval => floatingNotificationInterval;
  Future<void> changeSwitchListTile(bool value, String wichOne,
      {String? on}) async {
    if (wichOne == 'switchNoti') {
      switchNoti = value;
      if (switchNoti == false) {
        await CustomNotification().stopCustomNotificationService();
        Noti.cancelAll();
        CachHelper.putcache(key: 'isNotiOn', value: false);
      } else {
        if (on == 'custom') {
          await CustomNotification().startCustomNotificationService(
              repeatIntervalSeconds: getIntervalInSeconds());
          Noti.cancelAll();
        } else if (on == 'normal') {
          await CustomNotification().stopCustomNotificationService();
          await activeNotification();
        }
        await CachHelper.putcache(key: 'isNotiOn', value: true);
      }
      emit(ChangeSwitchListTileNoti());
    }
  }

  void changeTimePicker(
      {required String sabahOrMasaa, required TimeOfDay timeOfDay}) {
    if (sabahOrMasaa == 'sabah') {
      selectedTimeSabah = timeOfDay;
    } else {
      selectedTimeMasaa = timeOfDay;
    }
    emit(ChangeTimePickerState());
  }

  Future<void> changeTimeAdkar(
      {required String sabahOrMasaa, required TimeOfDay timeOfDay}) async {
    if (sabahOrMasaa == 'sabah') {
      await CachHelper.putcache(
          key: 'adkarTimeSabahCH.hour', value: timeOfDay.hour);
      await CachHelper.putcache(
          key: 'adkarTimeSabahCH.minute', value: timeOfDay.minute);
      await Noti.showTimeNotificationDaily(
          id: 25,
          payload: 'adkarSabah',
          title: 'اذكار الصباح',
          body: 'اذكار الصباح',
          time: timeOfDay,
          fln: Noti.flutterLocalNotificationsPlugin);
    } else if (sabahOrMasaa == 'masaa') {
      await CachHelper.putcache(
          key: 'adkarTimeMasaaCH.hour', value: timeOfDay.hour);
      await CachHelper.putcache(
          key: 'adkarTimeMasaaCH.minute', value: timeOfDay.minute);
      await Noti.showTimeNotificationDaily(
          id: 26,
          payload: 'adkarMasa1',
          title: 'اذكار المساء',
          body: 'اذكار المساء',
          time: timeOfDay,
          fln: Noti.flutterLocalNotificationsPlugin);
    }
  }

  Future<void> changeNotificationType(String value) async {
    _notificationType = value;
    await CachHelper.putcache(key: 'typeNoti', value: value);
    emit(ChangeTypeNotificationState(notificationType: value));
  }

  // New method to change floating notification interval
  Future<void> changeFloatingNotificationInterval(String interval) async {
    floatingNotificationIntervalCH = interval;
    print(getIntervalInSeconds());
    await CachHelper.putcache(
        key: 'floatingNotificationInterval', value: interval);
    if (switchNoti && _notificationType == 'custom') {
      await CustomNotification().stopCustomNotificationService();
      await CustomNotification().startCustomNotificationService(
          repeatIntervalSeconds: getIntervalInSeconds());
    }
    emit(ChangeFloatingNotificationIntervalState());
  }
}
