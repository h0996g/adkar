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
  Future<void> changeSwitchListTile(bool value, String wichOne,
      {String? off, String? on}) async {
    if (wichOne == 'switchNoti') {
      switchNoti = value;
      if (switchNoti == false) {
        if (off == 'custom') {
          await CustomNotification().stopCustomNotificationService();
        } else if (off == 'normal') {
          Noti.cancelAll();
        } else {
          await CustomNotification().stopCustomNotificationService();
          Noti.cancelAll();
        }

        await CachHelper.putcache(key: 'isNotiOn', value: false);
      } else {
        if (on == 'custom') {
          CustomNotification().startCustomNotificationService();
        } else if (on == 'normal') {
          await activeNotification();
        } else {
          CustomNotification().startCustomNotificationService();
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

  String _notificationType = 'custom';

  String get notificationType => _notificationType;

  Future<void> changeNotificationType(String value) async {
    _notificationType = value;
    await CachHelper.putcache(key: 'typeNoti', value: value);

    emit(ChangeTypeNotificationState(notificationType: value));
  }
}
