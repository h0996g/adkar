import 'package:adkar/Screens/settings/cubit/settings_state.dart';
import 'package:adkar/notification.dart';
import 'package:adkar/shared/helper/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constant.dart';
import '../../../shared/helper/cash_helper.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);
  bool switchNoti = isNotiOn;
  Future<void> changeSwitchListTile(bool value, String wichOne) async {
    if (wichOne == 'switchNoti') {
      switchNoti = value;
      if (switchNoti == false) {
        Noti.cancelAll();
        await CachHelper.putcache(key: 'isNotiOn', value: false);
      } else {
        activeNotification();
        await CachHelper.putcache(key: 'isNotiOn', value: true);
      }
      emit(ChangeSwitchListTileNoti());
    }
  }
}
