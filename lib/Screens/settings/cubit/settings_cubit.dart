import 'package:adkar/Screens/settings/cubit/settings_state.dart';
import 'package:adkar/notification.dart';
import 'package:adkar/shared/helper/constant.dart';
import 'package:adkar/shared/network/local/kotlin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  double _notificationTextSize =
      _parseTextSize(CachHelper.getData(key: 'notificationTextSize')) ?? 18.0;
  double get notificationTextSize => _notificationTextSize.clamp(12.0, 30.0);

  static double? _parseTextSize(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Future<void> changeNotificationTextSize(double size) async {
    try {
      _notificationTextSize = size.clamp(12.0, 30.0);
      await CachHelper.putcache(
          key: 'notificationTextSize', value: _notificationTextSize.toString());
      print("New text size saved: $_notificationTextSize");

      const platform = MethodChannel('com.example.adkar/custom_notification');
      await platform.invokeMethod('updateNotificationTextSize');

      emit(ChangeNotificationTextSizeState());
    } catch (e, stackTrace) {
      print("Error in changeNotificationTextSize: $e");
      print("Stack trace: $stackTrace");
    }
  }
}
