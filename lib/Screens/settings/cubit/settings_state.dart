abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ChangeSwitchListTileNoti extends SettingsState {}

class ChangeTimePickerState extends SettingsState {}

class ChangeFloatingNotificationIntervalState extends SettingsState {}

class ChangeTypeNotificationState extends SettingsState {
  final String notificationType;

  ChangeTypeNotificationState({required this.notificationType});
}

class ChangeNotificationTextSizeState extends SettingsState {}
