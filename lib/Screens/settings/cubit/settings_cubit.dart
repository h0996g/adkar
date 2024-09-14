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
  SettingsCubit() : super(SettingsInitial()) {
    loadNotificationSettings();
  }
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

  // double _notificationTextSize =
  //     _parseTextSize(CachHelper.getData(key: 'notificationTextSize')) ?? 18.0;
  // double get notificationTextSize => _notificationTextSize.clamp(12.0, 30.0);

  double _notificationTextSize = 18.0;
  Color _notificationTextColor = const Color(0xFF964B00);
  double _notificationTransparency = 1.0;

  double get notificationTextSize => _notificationTextSize;
  Color get notificationTextColor => _notificationTextColor;
  double get notificationTransparency => _notificationTransparency;

  Future<void> loadNotificationSettings() async {
    try {
      // Text Size
      var textSize = await CachHelper.getData(key: 'notificationTextSize');
      _notificationTextSize =
          textSize != null ? double.parse(textSize.toString()) : 18.0;

      // Text Color
      var textColor = await CachHelper.getData(key: 'notificationTextColor');
      _notificationTextColor = textColor != null
          ? Color(int.parse(textColor.toString()))
          : const Color(0xFF964B00);

      // Transparency
      var transparency =
          await CachHelper.getData(key: 'notificationTransparency');
      _notificationTransparency =
          transparency != null ? double.parse(transparency.toString()) : 0.8;
    } catch (e) {
      print("Error loading notification settings: $e");
      // Use default values if there's an error
      _notificationTextSize = 18.0;
      _notificationTextColor = const Color(0xFF964B00);
      _notificationTransparency = 1.0;
    }
    emit(NotificationSettingsLoaded());
  }

  Future<void> changeNotificationTextSize(double size) async {
    _notificationTextSize = size.clamp(12.0, 30.0);
    await CachHelper.putcache(
        key: 'notificationTextSize', value: _notificationTextSize.toString());
    await _updateNotificationSettings();
    emit(ChangeNotificationSettingsState());
  }

  Future<void> changeNotificationTextColor(Color color) async {
    _notificationTextColor = color;
    await CachHelper.putcache(
        key: 'notificationTextColor',
        value: _notificationTextColor.value.toString());
    await _updateNotificationSettings();
    emit(ChangeNotificationSettingsState());
  }

  Future<void> changeNotificationTransparency(double transparency) async {
    _notificationTransparency = transparency.clamp(0.0, 1.0);
    await CachHelper.putcache(
        key: 'notificationTransparency',
        value: _notificationTransparency.toString());
    await _updateNotificationSettings();
    emit(ChangeNotificationSettingsState());
  }

  Future<void> _updateNotificationSettings() async {
    const platform = MethodChannel('com.example.adkar/custom_notification');
    try {
      await platform.invokeMethod('updateNotificationSettings', {
        'textSize': _notificationTextSize,
        'textColor': _notificationTextColor.value,
        'transparency': _notificationTransparency,
      });
    } catch (e) {
      print("Error updating notification settings: $e");
    }
  }
}
