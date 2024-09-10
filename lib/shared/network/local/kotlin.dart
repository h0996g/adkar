import 'package:adkar/shared/components/functions.dart';
import 'package:flutter/services.dart';

class CustomNotification {
  static const platform =
      MethodChannel('com.example.adkar/custom_notification');

  Future<void> startCustomNotificationService() async {
    try {
      await platform.invokeMethod('startCustomNotificationService');
      activeSaba7Masa();
    } on PlatformException catch (e) {
      print("Failed to start custom notification service: '${e.message}'.");
    }
  }

  Future<void> stopCustomNotificationService() async {
    try {
      await platform.invokeMethod('stopCustomNotificationService');
      print(
          "Custom notification service stoppedddddddddddddddddddddddddddddddd");
    } on PlatformException catch (e) {
      print("Failed to stop custom notification service: '${e.message}'");
    }
  }
}
