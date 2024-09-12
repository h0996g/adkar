import 'package:flutter/services.dart';
import 'package:adkar/shared/components/functions.dart';

class CustomNotification {
  static const platform =
      MethodChannel('com.example.adkar/custom_notification');

  Future<void> startCustomNotificationService(
      {int repeatIntervalSeconds = 60}) async {
    try {
      await platform.invokeMethod('startCustomNotificationService', {
        'repeatInterval':
            repeatIntervalSeconds * 1000, // Convert seconds to milliseconds
      });
      activeSaba7Masa();
    } on PlatformException catch (e) {
      print("Failed to start custom notification service: '${e.message}'.");
    }
  }

  Future<void> stopCustomNotificationService() async {
    try {
      await platform.invokeMethod('stopCustomNotificationService');
      print("Custom notification service stopped");
    } on PlatformException catch (e) {
      print("Failed to stop custom notification service: '${e.message}'");
    }
  }

  Future<bool> isCustomNotificationServiceRunning() async {
    try {
      final bool isRunning =
          await platform.invokeMethod('isCustomNotificationServiceRunning');
      return isRunning;
    } on PlatformException catch (e) {
      print(
          "Failed to check if custom notification service is running: '${e.message}'");
      return false;
    }
  }
}
